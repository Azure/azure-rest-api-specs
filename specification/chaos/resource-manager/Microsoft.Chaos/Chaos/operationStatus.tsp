import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./common.models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;

/**
 * Chaos Studio async operation status resource operations.
 */
@armResourceOperations
interface OperationStatuses {
  /**
   * Returns the current status of an async operation.
   */
  @autoRoute
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * The provider namespace (this parameter will not show up in operations).
     */
    @path
    @segment("providers")
    provider: "Microsoft.Chaos",

    ...LocationParameter,
    ...Foundations.OperationIdParameter,
  ): ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult> | ErrorResponse;
}

@@segment(OperationStatuses.get::parameters.operationId, "operationStatuses");
