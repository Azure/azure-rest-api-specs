import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("Common API Versions for Migrate Project Tracked Resource.")
enum ApiVersions {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @doc("2025-03-30-preview API Version.")
  v2025_03_30_preview: "2025-03-30-preview",

  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @doc("2025-12-01-preview API Version.")
  v2025_12_01_preview: "2025-12-01-preview",
}
