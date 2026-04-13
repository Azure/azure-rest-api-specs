import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@versioned(Microsoft.Mission.Versions)
@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Supported API versions for the Microsoft.Mission resource provider.")
enum Versions {
  @doc("The 2024-06-01-preview version.")
  @armCommonTypesVersion("v5")
  v2024_06_01_preview: "2024-06-01-preview",

  @doc("The 2024-12-01-preview version.")
  @armCommonTypesVersion("v5")
  v2024_12_01_preview: "2024-12-01-preview",

  @doc("The 2025-05-01-preview version.")
  @armCommonTypesVersion("v5")
  v2025_05_01_preview: "2025-05-01-preview",

  @doc("The 2025-11-01-preview version.")
  @armCommonTypesVersion("v5")
  v2025_11_01_preview: "2025-11-01-preview",

  @doc("The 2026-01-01-preview version.")
  @armCommonTypesVersion("v5")
  v2026_01_01_preview: "2026-01-01-preview",

  @doc("The 2026-03-01-preview version.")
  @armCommonTypesVersion("v5")
  v2026_03_01_preview: "2026-03-01-preview",
}
