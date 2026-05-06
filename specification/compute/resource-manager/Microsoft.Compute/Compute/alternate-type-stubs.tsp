// Stub declarations for `Azure.ResourceManager.Models` types referenced by
// `@@alternateType` decorators in client.tsp (e.g. mapping
// Common.SubResource → Azure.ResourceManager.Models.SubResource for csharp).
//
// These are TypeSpec-only placeholders — the .NET emitter resolves them to the
// real ARM common types from `Azure.ResourceManager` at generation time and the
// stubs themselves never appear in the emitted SDK or wire payload.
//
// This file is kept separate from client.tsp because TypeSpec's
// blockless-namespace-first rule disallows placing a blocked
// `namespace { ... }` declaration before the blockless `namespace ComputeCombine;`
// in client.tsp.

namespace Azure.ResourceManager.Models {
  model SubResource {}
  model WritableSubResource {}
}
