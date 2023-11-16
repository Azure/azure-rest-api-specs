import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

@useDependency(Azure.Core.Versions.v1_0_Preview_2)
@armProviderNamespace
@service({
  title: "Hybrid Connectivity Management API",
  version: "2023-12-01-preview",
})
@doc("REST API for public clouds.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.HybridConnectivity;


//---------------------------------------------- Models ----------------------------------------------


@doc("The properties of Solution Configuration")
model SolutionTypeProperties {
  @doc("The resource provisioning state")
  @visibility("read")
  provisioningState?: provisioningState;

  @doc("The type of the solution")
  solutionType: string;

  @doc("Solution settings")
  solutionSettings?: string;

  @doc("The status of solution configurations")
  @visibility("read")
  status?: solutionConfigurationStatus;

  @doc("The detailed message of status details")
  @visibility("read")
  statusDetails?: string;

  @doc("The last execution time of solution configuration.")
  @visibility("read")
  lastExecutionTime?: utcDateTime;
}

enum solutionConfigurationStatus {
  New,
  InProgress,
  Completed,
  Failed,
}

enum provisioningState {
  Succeeded,
  Failed, 
  Canceled
}

@doc("ConnectorId and SolutionTypes and their properties to Generate AWS CFT Template.")
model GenerateAwsTemplateRequest {
  @doc("The name of public cloud connector")
  connectorId: string;

  @doc("The list of solution types and their settings")
  solutionTypes?: Array<SolutionTypeProperties>;
}

@doc("Cloud formation template response.")
model generateAwsTemplateResponse {
  @doc("Cloud formation template for specified solution types")
  body: unknown;
}

//---------------------------------------------- Operations ----------------------------------------------

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Need to remove autoroute"
@route("/subscriptionId/{subscriptionId}/providers/Microsoft.HybridConnectivity/")
interface GenerateAwsTemplate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Need to remove autoroute"
  @route("generateAwsTemplate")
  @post
  @action
  @tag("GenerateAwsTemplate")
  @operationId("GenerateAwsTemplate")
  @doc("Retrieve AWS Cloud Formation template")
  generateAwsTemplate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    @doc("ConnectorId and SolutionTypes and their properties to Generate AWS CFT Template.")
    @body GenerateAwsTemplateRequest: GenerateAwsTemplateRequest,
  ): Azure.ResourceManager.ArmResponse<generateAwsTemplateResponse> | ErrorResponse;
}
