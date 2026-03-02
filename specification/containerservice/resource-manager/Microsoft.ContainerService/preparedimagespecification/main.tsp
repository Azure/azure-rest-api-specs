import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./operations.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service(#{ title: "ContainerServicePreparedImageSpecificationClient" })
@doc("Azure Kubernetes Prepared Image Specification api client.")
@versioned(Versions)
namespace Microsoft.ContainerService;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Azure Kubernetes Prepared Image Specification api versions.")
enum Versions {
  @doc("Azure Kubernetes Prepared Image Specification api version 2026-02-02-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2026_02_02_preview: "2026-02-02-preview",
}
