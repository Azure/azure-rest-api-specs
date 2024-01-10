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
@armProviderNamespace
@service({
  title: "FrontDoorManagementClient",
})
// @versioned(Versions)
@doc("FrontDoor Client")
namespace Microsoft.Network;

// @doc("The available API versions.")
// enum Versions {
//   @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
//   @useDependency(Azure.Core.Versions.v1_0_Preview_1)
//   v2016_11_01: "2016-11-01",
// }

