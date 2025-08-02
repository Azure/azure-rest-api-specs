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
  @doc("Azure Kubernetes Node Customization api version 2025-06-02.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_06_02_preview: "2025-06-02-preview",
}
