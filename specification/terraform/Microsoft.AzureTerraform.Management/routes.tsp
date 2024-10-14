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
@route("/subscription/{subscriptionId}/providers/{provider}")
interface ExportTerraform {
  @armResourceAction(ExportResult)
  @doc("Exports the Terraform configuration of the specified resource(s).")
  @route("/exportTerraform")
  @post
  @tag("ExportTerraform")
  // Cannot use Azure.ResourceManager.ArmProviderActionAsync due to a bug
  exportTerraform(
    ...DefaultBaseParameters<SubscriptionActionScope>,
    ...ProviderNamespace<SubscriptionActionScope>,

    @doc("The resource(s) to be exported to Terraform")
    @bodyRoot
    body: BaseExportModel,
  ): ArmAcceptedLroResponse<
    "Resource operation accepted.",
    ArmLroLocationHeader<
      Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
      OperationStatus,
      string
    > &
      Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;

  @doc("Get the status of a long running azure asynchronous operation.")
  @route("/operationStatuses/{operationId}")
  @get
  @tag("OperationStatuses")
  operationStatuses is ArmReadOperation<
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
      ...ProviderNamespace<SubscriptionActionScope>;
      ...OperationIdParameter;
    },
    OperationStatus | ArmAcceptedLroResponse,
    ErrorResponse
  >;
}
