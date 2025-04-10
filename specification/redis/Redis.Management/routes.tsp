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

namespace Microsoft.Cache;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface RedisOperationGroup {
  /**
   * Checks that the redis cache name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Redis_CheckNameAvailability")
  @autoRoute
  @action("CheckNameAvailability")
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailabilityParameters,
    Response = void,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AsyncOperationStatusOperationGroup {
  /**
   * For checking the ongoing status of an operation
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AsyncOperationStatus_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Cache/locations/{location}/asyncOperations/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...LocationResourceParameter,

    /**
     * The ID of asynchronous operation
     */
    @path
    operationId: string,

    ...SubscriptionIdParameter,
  ): ArmResponse<OperationStatus> | ErrorResponse;
}
