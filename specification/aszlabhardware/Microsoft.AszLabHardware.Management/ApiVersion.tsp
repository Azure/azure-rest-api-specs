using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AszLabHardware;

@doc("AszLabHardware current api versions")
enum AszLabHardwareCurrentVersion {
  @doc("2025-01-01-preview api version")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2025-01-01-preview`,
}
