// Sinks.h — gadget sink predicates evaluated on Triton state.
#pragma once

#include <triton/ast.hpp>
#include <triton/tritonTypes.hpp>

#include <unordered_set>

namespace specscout::sinks {

// Does this AST transitively reference any symbolic variable whose id is in
// `ids`? Used to ask "is this effective address derived from the attacker
// input (input vars) or from a prior attacker-addressed load (load vars)?".
//
// The S1 `a[b[i]]` shape is a load whose address references a *load* variable;
// the inner load `b[i]` references an *input* variable. This survives Triton's
// constant folding of concrete memory, which an isMemory()-node walk does not.
bool ast_references_var(const triton::ast::SharedAbstractNode& node,
                        const std::unordered_set<triton::usize>& ids);

// Like the above, but true only if a referenced variable appears *under a
// multiply/shift* (a scaled index). This is the cache-transmitter hallmark —
// the loaded value is spread across cache lines (e.g. array2[v * 512]) — and it
// separates real `a[b[i]]` gadgets from ordinary pointer chasing (`p->a->b`),
// which dereferences the loaded value directly with no scaling.
bool ast_references_var_scaled(const triton::ast::SharedAbstractNode& node,
                               const std::unordered_set<triton::usize>& ids);

} // namespace specscout::sinks
