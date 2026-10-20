#include "Cfg.h"

#include <capstone/capstone.h>

#include <deque>
#include <set>

namespace specscout {

const BasicBlock* Function::block_at(va_t va) const {
    auto it = blocks.find(va);
    return it == blocks.end() ? nullptr : &it->second;
}

Cfg::Cfg() {
    csh h = 0;
    if (cs_open(CS_ARCH_X86, CS_MODE_64, &h) == CS_ERR_OK) {
        cs_option(h, CS_OPT_DETAIL, CS_OPT_ON);
        handle_ = static_cast<size_t>(h);
    }
}

Cfg::~Cfg() {
    if (handle_) {
        csh h = static_cast<csh>(handle_);
        cs_close(&h);
    }
}

namespace {

constexpr size_t kMaxInsnsPerFunc = 200000;  // runaway guard

// Classify one decoded instruction into our Insn record.
Insn classify(csh h, const cs_insn* ci) {
    Insn in;
    in.va = ci->address;
    in.size = static_cast<uint8_t>(ci->size);
    in.id = ci->id;
    in.mnemonic = ci->mnemonic;
    in.text = std::string(ci->mnemonic) + "  " + ci->op_str;
    in.fallthrough = ci->address + ci->size;

    switch (ci->id) {
        case X86_INS_LFENCE:
        case X86_INS_MFENCE:
        case X86_INS_CPUID:
            in.is_serializing = true;
            break;
        default:
            break;
    }

    const bool is_jump = cs_insn_group(h, ci, X86_GRP_JUMP);
    const bool is_call = cs_insn_group(h, ci, X86_GRP_CALL);
    const bool is_ret  = cs_insn_group(h, ci, X86_GRP_RET);

    if (is_ret) {
        in.is_ret = true;
        return in;
    }
    if (!is_jump && !is_call) return in;

    const cs_x86& x = ci->detail->x86;
    const bool rel = cs_insn_group(h, ci, X86_GRP_BRANCH_RELATIVE);

    // operand 0 carries the target
    if (x.op_count >= 1) {
        const cs_x86_op& op = x.operands[0];
        if (op.type == X86_OP_IMM) {
            in.direct_target = static_cast<va_t>(op.imm);
        } else if (op.type == X86_OP_MEM) {
            in.is_indirect = true;
            if (op.mem.base == X86_REG_RIP && op.mem.index == X86_REG_INVALID) {
                // RIP-relative: absolute slot = next insn VA + disp
                in.mem_target_slot = in.fallthrough + static_cast<int64_t>(op.mem.disp);
            }
        } else {  // register or other
            in.is_indirect = true;
        }
    } else {
        in.is_indirect = !rel;
    }

    if (is_call) {
        in.is_call = true;
    } else {  // jump
        if (ci->id == X86_INS_JMP)
            in.is_uncond_jmp = true;
        else
            in.is_cond_branch = true;  // Jcc family
    }
    return in;
}

}  // namespace

bool Cfg::decode_at(const LoadedImage& img, va_t addr, Insn& out) const {
    if (!handle_) return false;
    size_t avail = 0;
    const uint8_t* code = img.bytes_at(addr, avail);
    if (!code || avail == 0) return false;
    const csh h = static_cast<csh>(handle_);
    cs_insn* ci = cs_malloc(h);
    uint64_t cur = addr;
    bool ok = cs_disasm_iter(h, &code, &avail, &cur, ci);
    if (ok) out = classify(h, ci);
    cs_free(ci, 1);
    return ok;
}

std::string Cfg::resolve_thunk(const LoadedImage& img, va_t addr) const {
    Insn in;
    if (!decode_at(img, addr, in)) return "";
    if (in.is_uncond_jmp && in.is_indirect && in.mem_target_slot) {
        if (const std::string* nm = img.import_name_at(in.mem_target_slot))
            return *nm;
    }
    return "";
}

Function Cfg::build(const LoadedImage& img, va_t func_start, va_t range_end) {
    Function fn;
    fn.start = func_start;
    fn.end = range_end;
    if (!handle_) return fn;

    const csh h = static_cast<csh>(handle_);
    cs_insn* ci = cs_malloc(h);

    std::deque<va_t> worklist{func_start};
    std::set<va_t> block_starts{func_start};
    std::set<va_t> decoded_blocks;
    size_t budget = kMaxInsnsPerFunc;

    auto in_range = [&](va_t va) {
        if (range_end > func_start) return va >= func_start && va < range_end;
        return img.is_executable(va);
    };

    while (!worklist.empty() && budget > 0) {
        va_t addr = worklist.front();
        worklist.pop_front();
        if (decoded_blocks.count(addr)) continue;
        decoded_blocks.insert(addr);

        BasicBlock bb;
        bb.start = addr;

        size_t avail = 0;
        const uint8_t* code = img.bytes_at(addr, avail);
        if (!code) { fn.blocks[addr] = std::move(bb); continue; }

        uint64_t cur = addr;
        bool terminated = false;

        while (avail > 0 && budget > 0) {
            --budget;
            if (!cs_disasm_iter(h, &code, &avail, &cur, ci)) break;  // avail/cur/code advance
            Insn in = classify(h, ci);
            bb.insns.push_back(in);

            // A subsequent block may start right after this instruction if some
            // branch targets it; break the block there to keep starts unique.
            if (in.is_ret) {
                bb.term = TermKind::Ret;
                terminated = true;
                break;
            }
            if (in.is_cond_branch) {
                bb.term = TermKind::CondBranch;
                if (in.direct_target && in_range(in.direct_target)) {
                    bb.succs.push_back(in.direct_target);
                    if (!block_starts.count(in.direct_target)) {
                        block_starts.insert(in.direct_target);
                        worklist.push_back(in.direct_target);
                    }
                }
                if (in_range(in.fallthrough)) {
                    bb.succs.push_back(in.fallthrough);
                    if (!block_starts.count(in.fallthrough)) {
                        block_starts.insert(in.fallthrough);
                        worklist.push_back(in.fallthrough);
                    }
                }
                terminated = true;
                break;
            }
            if (in.is_uncond_jmp) {
                if (in.is_indirect) {
                    bb.term = TermKind::IndirectJmp;
                } else {
                    bb.term = TermKind::DirectJmp;
                    if (in.direct_target && in_range(in.direct_target)) {
                        bb.succs.push_back(in.direct_target);
                        if (!block_starts.count(in.direct_target)) {
                            block_starts.insert(in.direct_target);
                            worklist.push_back(in.direct_target);
                        }
                    }
                }
                terminated = true;
                break;
            }
            // calls and plain instructions do not end the block; but if the
            // next address is already a known block start, stop (fallthrough).
            if (block_starts.count(cur) && cur != bb.start) {
                bb.term = TermKind::Fallthrough;
                bb.succs.push_back(cur);
                terminated = true;
                break;
            }
            if (range_end > func_start && cur >= range_end) break;
        }

        if (!terminated && !bb.insns.empty() && bb.term == TermKind::Unknown) {
            // ran off the end of available bytes / range
            if (in_range(cur)) {
                bb.term = TermKind::Fallthrough;
                bb.succs.push_back(cur);
                if (!block_starts.count(cur)) {
                    block_starts.insert(cur);
                    worklist.push_back(cur);
                }
            }
        }
        fn.blocks[addr] = std::move(bb);
    }

    cs_free(ci, 1);
    return fn;
}

} // namespace specscout
