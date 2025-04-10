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

namespace Microsoft.Subscription;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SubscriptionsOperationGroup {
  /**
   * This operation provides all the locations that are available for resource providers; however, each resource provider may support a subset of this list.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets all available geo-locations.")
  @operationId("Subscriptions_ListLocations")
  @route("/subscriptions/{subscriptionId}/locations")
  @get
  listLocations(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
  ): ArmResponse<LocationListResult> | ErrorResponse;

  /**
   * Gets details about a specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Subscriptions_Get")
  @route("/subscriptions/{subscriptionId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
  ): ArmResponse<Subscription> | ErrorResponse;

  /**
   * Gets all subscriptions for a tenant.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Subscriptions_List")
  @route("/subscriptions")
  @get
  list(
    ...ApiVersionParameter,
  ): ArmResponse<SubscriptionListResult> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface TenantsOperationGroup {
  /**
   * Gets the tenants for your account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Tenants_List")
  @route("/tenants")
  @get
  list(...ApiVersionParameter): ArmResponse<TenantListResult> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SubscriptionOperationGroup {
  /**
   * The operation to cancel a subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Subscription_Cancel")
  @autoRoute
  cancel is ArmProviderActionSync<
    Response = CanceledSubscriptionId,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  /**
   * The operation to rename a subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Subscription_Rename")
  @autoRoute
  rename is ArmProviderActionSync<
    Request = SubscriptionName,
    Response = RenamedSubscriptionId,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  /**
   * The operation to enable a subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Subscription_Enable")
  @autoRoute
  enable is ArmProviderActionSync<
    Response = EnabledSubscriptionId,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  /**
   * Accept subscription ownership.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Subscription_AcceptOwnership")
  @autoRoute
  acceptOwnership is ArmProviderActionAsync<
    Request = AcceptOwnershipRequest,
    Parameters = {}
  >;
  /**
   * Accept subscription ownership status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Subscription_AcceptOwnershipStatus")
  @autoRoute
  @get
  acceptOwnershipStatus is ArmProviderActionSync<
    Response = AcceptOwnershipStatusResponse,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SubscriptionOperationOperationGroup {
  /**
   * Get the status of the pending Microsoft.Subscription API operations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SubscriptionOperation_Get")
  @route("/providers/Microsoft.Subscription/subscriptionOperations/{operationId}")
  @get
  get(
    ...ApiVersionParameter,

    /**
     * The operation ID, which can be found from the Location field in the generate recommendation response header.
     */
    @path
    operationId: string,
  ): ArmResponse<SubscriptionCreationResult> | ArmAcceptedResponse | ErrorResponse;
}
