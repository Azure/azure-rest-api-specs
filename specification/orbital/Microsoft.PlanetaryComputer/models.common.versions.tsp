import "@azure-tools/typespec-azure-core";

using TypeSpec.Versioning;

namespace Microsoft.PlanetaryComputer;

#suppress "@azure-tools/typespec-azure-core/no-enum" "Version information"
@doc("Represents version information.")
enum Versions {
  @doc("Represents the 2025-04-30-preview version.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2025_04_30_Preview: "2025-04-30-preview",
}
