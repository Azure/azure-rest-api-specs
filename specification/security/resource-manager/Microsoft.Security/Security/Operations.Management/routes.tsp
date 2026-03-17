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

namespace SecurityCenter;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OperationResultsOperationGroup {
  /**
   * Returns operation results for long running operations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OperationResults_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/locations/{location}/operationResults/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The ID of an ongoing async operation.
     */
    @minLength(1)
    @path
    operationId: string,
  ): OkResponse | ArmAcceptedResponse | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OperationStatusesOperationGroup {
  /**
   * Get the status of a long running azure asynchronous operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OperationStatuses_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/locations/{location}/operationStatuses/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The ID of an ongoing async operation.
     */
    @minLength(1)
    @path
    operationId: string,
  ): ArmResponse<Azure.ResourceManager.Foundations.OperationStatusResult> | ErrorResponse;
}
