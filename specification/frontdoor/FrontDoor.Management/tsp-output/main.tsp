import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./FrontDoorWebApplicationFirewallPolicy.tsp";
import "./FrontDoor.tsp";
import "./FrontendEndpoint.tsp";
import "./FrontDoorRulesEngine.tsp";
import "./FrontDoorNetworkExperimentProfile.tsp";
import "./FrontDoorExperiment.tsp";
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
@doc("FrontDoor Client")
namespace Azure.ResourceManager.FrontDoor;
