import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./aimanager.tsp";
import "./aimanagernamespace.tsp";
import "./aimodel.tsp";
import "./modelsource.tsp";
import "./modeldeployment.tsp";
import "./client.tsp";

using Azure.ResourceManager;
using Azure.Core;
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
  @doc("Azure Kubernetes AI Manager api version 2026-04-02-preview.")
  v2026_04_02_preview: "2026-04-02-preview",

  @doc("Azure Kubernetes AI Manager api version 2026-05-02-preview.")
  @previewVersion
  v2026_05_02_preview: "2026-05-02-preview",
}
