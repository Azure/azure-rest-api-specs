// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Cache;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface RedisOperationGroup {
  /**
   * Checks that the redis cache name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailabilityParameters,
    Response = OkResponse,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface AsyncOperationStatusOperationGroup {
  /**
   * For checking the ongoing status of an operation
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Cache/locations/{location}/asyncOperations/{operationId}")
  @get
  get(
    ...ApiVersionParameter,

    /**
     * The location at which operation was triggered
     */
    @path
    location: string,

    /**
     * The ID of asynchronous operation
     */
    @path
    operationId: string,

    ...SubscriptionIdParameter,
  ): OperationStatus | ErrorResponse;
}
