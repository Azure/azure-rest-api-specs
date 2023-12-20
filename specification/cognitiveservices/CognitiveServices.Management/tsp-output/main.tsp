import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./CognitiveServicesAccount.tsp";
import "./CognitiveServicesDeletedAccount.tsp";
import "./CognitiveServicesPrivateEndpointConnection.tsp";
import "./CognitiveServicesAccountDeployment.tsp";
import "./CommitmentPlan.tsp";
import "./CognitiveServicesCommitmentPlan.tsp";
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
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
@doc("Cognitive Services Management Client")
namespace Azure.ResourceManager.CognitiveServices;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_05_01: "2023-05-01",
}
