import "@typespec/versioning";

using TypeSpec.Versioning;

@versioned(Versions)
namespace Microsoft.Discovery.Workspace;

@doc("The Microsoft.Discovery service versions.")
enum Versions {
  @doc("The 2026-02-01-preview version of the Microsoft.Discovery service data plane.")
  `2026-02-01-preview`,
}
