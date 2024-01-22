import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./WebApplicationFirewallPolicy.tsp";
import "./FrontDoor.tsp";
import "./FrontendEndpoint.tsp";
import "./RulesEngine.tsp";
import "./Profile.tsp";
import "./Experiment.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * FrontDoor Client
 */
@armProviderNamespace
@service({
  title: "FrontDoorManagementClient",
})
@versioned(Versions)
namespace Microsoft.Network;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2022-05-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_05_01: "2022-05-01",

  /**
   * The 2021-06-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_06_01: "2021-06-01",

  /**
   * The 2019-11-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2019_11_01: "2019-11-01",
}
