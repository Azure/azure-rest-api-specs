// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;

interface OperationStatusesOperations {
  /**
   * Get the status of a long running azure asynchronous operation.
   */
  @operationId("OperationStatuses_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Chaos/locations/{location}/operationStatuses/{asyncOperationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...LocationResourceParameter,

    /**
     * The operation Id.
     */
    @path
    asyncOperationId: string,

    ...SubscriptionIdParameter,
  ): ArmResponse<OperationStatus> | ErrorResponse;
}
