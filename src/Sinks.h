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

} // namespace specscout::sinks
