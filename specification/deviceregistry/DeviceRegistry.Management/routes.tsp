import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.OpenAPI;

namespace Microsoft.DeviceRegistry;

interface OperationStatusOperations{
    /**
     * Returns the current status of an async operation.
     */
    @route("/subscriptions/{subscriptionId}/providers/Microsoft.DeviceRegistry/locations/{location}/operationStatuses/{operationId}")
    @get
    list(
      ...LocationBaseParameters,
      ...OperationIdParameter
    ):ArmResponse<OperationListResult>
    | ErrorResponse;
  }