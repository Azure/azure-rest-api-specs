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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Cannot use @armResourceOperations, the implied @autoRoute produces the wrong route for GET /operationStatuses/{operationId}"
@route("/subscriptions/{subscriptionId}/providers/Microsoft.AzureTerraform")
interface ExportTerraform {
  // Cannot use Azure.ResourceManager.ArmProviderActionAsync due to error during .NET SDK code generation:
  // Unknown identifier SubscriptionActionScope
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Need to override @operationId to fix LintDiff"
  @armResourceAction(ExportResult)
  @doc("Exports the Terraform configuration of the specified resource(s).")
  @route("/exportTerraform")
  @post
  @tag("ExportTerraform")
  export(
    ...CommonExportTerraformParameters,

    @doc("The export parameter")
    @body
    exportParameter: BaseExportModel,
  ): ArmAcceptedLroResponse<
    "Resource operation accepted.",
    ArmCombinedLroHeaders<TerraformOperationStatus, TerraformOperationStatus> &
      Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "202 response of this API has body"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Need to override @operationId to fix LintDiff"
  @doc("Get the status of a long running azure asynchronous operation.")
  @route("/operationStatuses/{operationId}")
  @get
  @tag("OperationStatuses")
  getOperationStatus is ArmReadOperation<
    {
      ...CommonExportTerraformParameters;
      ...OperationIdParameter;
    },
    TerraformOperationStatus | (TerraformOperationStatus &
      ArmAcceptedLroResponse),
    ErrorResponse
  >;
}
