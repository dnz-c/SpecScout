#include "Sinks.h"

#include <triton/symbolicExpression.hpp>
#include <triton/symbolicVariable.hpp>

#include <unordered_set>

namespace specscout::sinks {

namespace {

bool walk(const triton::ast::SharedAbstractNode& node,
          const std::unordered_set<triton::usize>& ids,
          std::unordered_set<triton::usize>& seen_exprs, int depth) {
    if (!node || depth > 256) return false;

    if (node->getType() == triton::ast::VARIABLE_NODE) {
        auto vn = std::dynamic_pointer_cast<triton::ast::VariableNode>(node);
        if (vn) {
            const auto& sv = vn->getSymbolicVariable();
            if (sv && ids.count(sv->getId())) return true;
        }
    } else if (node->getType() == triton::ast::REFERENCE_NODE) {
        // A reference points at a register/memory symbolic expression; the
        // variable we are hunting for lives inside that expression's AST.
        auto ref = std::dynamic_pointer_cast<triton::ast::ReferenceNode>(node);
        if (ref) {
            const auto& expr = ref->getSymbolicExpression();
            if (expr && seen_exprs.insert(expr->getId()).second) {
                if (walk(expr->getAst(), ids, seen_exprs, depth + 1)) return true;
            }
        }
    }
    for (auto& child : node->getChildren())
        if (walk(child, ids, seen_exprs, depth + 1)) return true;
    return false;
}

}  // namespace

bool ast_references_var(const triton::ast::SharedAbstractNode& node,
                        const std::unordered_set<triton::usize>& ids) {
    std::unordered_set<triton::usize> seen_exprs;
    return walk(node, ids, seen_exprs, 0);
}

namespace {

bool scaled_walk(const triton::ast::SharedAbstractNode& node,
                 const std::unordered_set<triton::usize>& ids,
                 std::unordered_set<triton::usize>& seen_exprs, int depth,
                 bool under_scale) {
    if (!node || depth > 256) return false;
    const auto t = node->getType();

    if (t == triton::ast::VARIABLE_NODE && under_scale) {
        auto vn = std::dynamic_pointer_cast<triton::ast::VariableNode>(node);
        if (vn) {
            const auto& sv = vn->getSymbolicVariable();
            if (sv && ids.count(sv->getId())) return true;
        }
    }

    const bool child_scale =
        under_scale || t == triton::ast::BVMUL_NODE || t == triton::ast::BVSHL_NODE;

    if (t == triton::ast::REFERENCE_NODE) {
        auto ref = std::dynamic_pointer_cast<triton::ast::ReferenceNode>(node);
        if (ref) {
            const auto& expr = ref->getSymbolicExpression();
            if (expr && seen_exprs.insert(expr->getId()).second) {
                if (scaled_walk(expr->getAst(), ids, seen_exprs, depth + 1, child_scale))
                    return true;
            }
        }
    }
    for (auto& child : node->getChildren())
        if (scaled_walk(child, ids, seen_exprs, depth + 1, child_scale)) return true;
    return false;
}

}  // namespace

bool ast_references_var_scaled(const triton::ast::SharedAbstractNode& node,
                               const std::unordered_set<triton::usize>& ids) {
    std::unordered_set<triton::usize> seen_exprs;
    return scaled_walk(node, ids, seen_exprs, 0, false);
}

} // namespace specscout::sinks
