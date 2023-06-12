import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./fleet.tsp";
import "./fleetmember.tsp";
import "./updaterun.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;
using OpenAPI;

@armProviderNamespace
@service({
  title: "ContainerServiceFleetClient",
})
@doc("Azure Kubernetes Fleet Manager api client.")
@versioned(Versions)
namespace Microsoft.ContainerService;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2022_09_02_preview: "2022-09-02-preview",

  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_03_15_preview: "2023-03-15-preview"
}
