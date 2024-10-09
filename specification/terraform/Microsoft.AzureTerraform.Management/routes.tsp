import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using OpenAPI;

namespace Microsoft.AzureTerraform;

@doc("Parameters common to all ExportTerraform operations")
model CommonExportTerraformParameters {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Cannot use @armResourceOperations decorator, the implied @autoRoute forces {subscriptionId} path param to be at the end"
interface ExportTerraform {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Cannot use @armResourceOperation, API is not bound to a single resource type"
  @doc("Exports the Terraform configuration of the specified resource(s).")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.AzureTerraform/exportTerraform")
  @post
  @tag("ExportTerraform")
  @pollingOperation(ExportTerraform.operationStatuses)
  exportTerraform(
    ...CommonExportTerraformParameters,

    @doc("The export parameter")
    @body
    exportParameter: BaseExportModel,
  ): AcceptedLroResponse<"Export request accepted."> | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Cannot use @armResourceRead, API is not bound to a single resource type"
  @doc("Get the status of a long running azure asynchronous operation.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.AzureTerraform/operationStatuses/{operationId}")
  @get
  @tag("OperationStatuses")
  operationStatuses(
    ...OperationIdParameter,
    ...CommonExportTerraformParameters,
  ): OperationStatus | AcceptedLroResponse<"InProgress operation status"> | ErrorResponse;
}
