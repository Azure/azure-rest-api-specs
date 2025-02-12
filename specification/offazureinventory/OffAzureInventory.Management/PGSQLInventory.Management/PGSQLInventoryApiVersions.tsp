import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("API Versions for Business case Resource.")
enum PGSQLInventoryApiVersions {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @doc("2025-02-01-preview API Version.")
  v2025_02_01_preview: "2025-02-01-preview",
}