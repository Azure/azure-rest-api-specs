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

namespace Microsoft.DevCenter;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface SkusOperationGroup {
  /**
   * Lists the Microsoft.DevCenter SKUs available in a subscription
   */
  @autoRoute
  @get
  @action("skus")
  listBySubscription is ArmProviderActionSync<
    Response = SkuListResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface OperationStatusesOperationGroup {
  /**
   * Gets the current status of an async operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Get Operation Status")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DevCenter/locations/{location}/operationStatuses/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The ID of an ongoing async operation
     */
    @path
    operationId: string,
  ): ArmResponse<OperationStatus> | (AcceptedResponse & {
    @body
    _: OperationStatus;

    /**
     * The Location header contains the URL where the status of the long running operation can be checked.
     */
    @header
    location?: string;
  }) | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface UsagesOperationGroup {
  /**
   * Lists the current usages and limits in this location for the provided subscription.
   */
  @autoRoute
  @get
  @action("usages")
  listByLocation is ArmProviderActionSync<
    Response = ListUsagesResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface CheckNameAvailabilityOperationGroup {
  /**
   * Check the availability of name for resource
   */
  @autoRoute
  @action("checkNameAvailability")
  execute is ArmProviderActionSync<
    Request = Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
    Response = Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface CheckScopedNameAvailabilityOperationGroup {
  /**
   * Check the availability of name for resource
   */
  @autoRoute
  @action("checkScopedNameAvailability")
  execute is ArmProviderActionSync<
    Request = CheckScopedNameAvailabilityRequest,
    Response = Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}
