import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.ApplicationMigration;

@doc("API Versions for CodeScanSites Resource.")
enum CodeScanSitesApiVersions {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("2025-09-09-preview API Version.")
  v2025_09_09_preview: "2025-09-09-preview",
}
