import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("API Versions for Azure Container Apps Assessment Resource.")
enum ContainerAppsApiVersions {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @doc("2025-09-09-preview API Version.")
  v2025_09_09_preview: "2025-09-09-preview",
}
