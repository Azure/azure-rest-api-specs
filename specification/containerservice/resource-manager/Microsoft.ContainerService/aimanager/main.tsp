import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./aimanager.tsp";
import "./aimanagernamespace.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

@armProviderNamespace
@service(#{ title: "ContainerServiceAIManagerClient" })
@doc("Azure Kubernetes AI Manager api client.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.ContainerService;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Azure Kubernetes AI Manager api versions.")
enum Versions {
  @doc("Azure Kubernetes AI Manager api version 2026-03-02-preview.")
  v2026_03_02_preview: "2026-03-02-preview",
}
