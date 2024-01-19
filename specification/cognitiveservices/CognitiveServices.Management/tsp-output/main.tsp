import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Account.tsp";
import "./Account.tsp";
import "./PrivateEndpointConnection.tsp";
import "./Deployment.tsp";
import "./CommitmentPlan.tsp";
import "./CommitmentPlan.tsp";
import "./CommitmentPlanAccountAssociation.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "CognitiveServicesManagementClient",
})
@versioned(Versions)
// FIXME: Common type version v2 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
@doc("Cognitive Services Management Client")
namespace Microsoft.CognitiveServices;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2023-05-01 API version.")
  v2023_05_01: "2023-05-01",
}
