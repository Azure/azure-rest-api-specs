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

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "This is defined in other swagger file - hybridconnectivity.json"
@useDependency(Azure.Core.Versions.v1_0_Preview_2)
@armCommonTypesVersion(CommonTypes.Versions.v5)
@armProviderNamespace
@service({
  title: "Hybrid Connectivity Management API",
  version: "2023-12-01-preview",
})
@doc("REST API for public clouds.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.HybridConnectivity;

//---------------------------------------------- Models ----------------------------------------------

@doc("The properties of Solution Type")
model SolutionTypeProperties {
  @doc("The type of the solution")
  solutionType: string;

  @doc("Solution settings")
  solutionSettings?: SolutionSettings;
}

@doc("Solution settings")
model SolutionSettings is Record<string>;

@doc("ConnectorId and SolutionTypes and their properties to Generate AWS CFT Template.")
model GenerateAwsTemplateRequest {
  @doc("The name of public cloud connector")
  connectorId: string;

  @doc("The list of solution types and their settings")
  solutionTypes?: Array<SolutionTypeProperties>;
}

//---------------------------------------------- Operations ----------------------------------------------

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Need to remove autoroute"
@route("/subscriptions/{subscriptionId}/providers/Microsoft.HybridConnectivity/")
interface GenerateAwsTemplate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Need to remove autoroute"
  @route("generateAwsTemplate")
  @post
  @action
  @tag("GenerateAwsTemplate")
  @doc("Retrieve AWS Cloud Formation template")
  post(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    @doc("ConnectorId and SolutionTypes and their properties to Generate AWS CFT Template.")
    @body
    generateAwsTemplateRequest: GenerateAwsTemplateRequest,
  ): Azure.ResourceManager.ArmResponse<{}> | ErrorResponse;
}
