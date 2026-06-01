// Stub declarations for well-known ARM framework types referenced by
// `@@alternateType` directives in `client.tsp`. The C# emitter recognizes
// these symbols by their cross-language definition ID
// (`Azure.ResourceManager.Models.*`) and maps them to framework types in the
// generated .NET SDK; the model bodies are intentionally empty.

namespace Azure.ResourceManager.Models {
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Stub only — body unused; emitter resolves by cross-language definition id."
  model WritableSubResource {}
}
