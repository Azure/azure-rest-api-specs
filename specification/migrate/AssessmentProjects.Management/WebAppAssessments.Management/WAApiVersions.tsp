import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("API Versions for Webapp Assessment Resource.")
enum WAApiVersions {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @doc("2024-03-03-preview API Version.")
  v2024_03_03_preview: "2024-03-03-preview",
}
