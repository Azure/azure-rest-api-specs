import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@versioned(Microsoft.AzureCis.Versions)
namespace Microsoft.AzureCis;

@doc("Supported versions.")
enum Versions {
  @doc("API version 2024-11-04-preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_11_04_preview: "2024-11-04-preview",
}
