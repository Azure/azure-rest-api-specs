import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Fleet.tsp";
import "./FleetMember.tsp";
import "./UpdateRun.tsp";
import "./FleetUpdateStrategy.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Azure Kubernetes Fleet Manager api client.
 */
@armProviderNamespace
@service({
  title: "ContainerServiceFleetClient",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
namespace Microsoft.ContainerService;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-10-15 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_10_15: "2023-10-15",
}
