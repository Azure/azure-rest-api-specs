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
  @doc("API version 2023-08-22-preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_08_22_preview: "2023-08-22-preview",
}
