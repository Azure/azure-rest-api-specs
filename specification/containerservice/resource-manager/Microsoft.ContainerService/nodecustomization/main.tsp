import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./operations.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service(#{ title: "ContainerServiceNodeCustomizationClient" })
@doc("Azure Kubernetes Node Customization api client.")
@versioned(Versions)
namespace Microsoft.ContainerService;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Azure Kubernetes Node Customization api versions.")
enum Versions {
  @doc("Azure Kubernetes Node Customization api version 2025-08-02-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_08_02_preview: "2025-08-02-preview",

  @doc("Azure Kubernetes Node Customization api version 2025-09-02-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_09_02_preview: "2025-09-02-preview",
}
