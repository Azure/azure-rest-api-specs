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

namespace Microsoft.Resources;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface Subscriptions {
  /**
   * This operation provides all the locations that are available for resource providers; however, each resource provider may support a subset of this list.
   */
  @summary("Gets all available geo-locations.")
  @route("/subscriptions/{subscriptionId}/locations")
  @list
  @tag("Subscriptions")
  listLocations(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * Whether to include extended locations.
     */
    @query("includeExtendedLocations")
    includeExtendedLocations?: boolean,
  ): ArmResponse<LocationListResult> | CloudError;

  /**
   * Gets details about a specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Subscriptions")
  @route("/subscriptions/{subscriptionId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
  ): ArmResponse<Subscription> | CloudError;

  /**
   * Gets all subscriptions for a tenant.
   */
  @route("/subscriptions")
  @list
  @tag("Subscriptions")
  list(
    ...ApiVersionParameter,
  ): ArmResponse<SubscriptionListResult> | CloudError;

  /**
   * Compares a subscriptions logical zone mapping
   */
  @autoRoute
  @tag("Subscriptions")
  @action("checkZonePeers/")
  checkZonePeers is ArmProviderActionSync<
    Request = CheckZonePeersRequest,
    Response = CheckZonePeersResult,
    Scope = SubscriptionActionScope
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface Tenants {
  /**
   * Gets the tenants for your account.
   */
  @tag("Tenants")
  @route("/tenants")
  @list
  list(...ApiVersionParameter): ArmResponse<TenantListResult> | CloudError;
}

/**
 * A resource name is valid if it is not a reserved word, does not contains a reserved word and does not start with a reserved word
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@summary("Checks resource name validity")
@operationId("checkResourceName")
@autoRoute
@tag("Tenants")
op checkResourceName is ArmProviderActionSync<
  Request = ResourceName,
  Response = CheckResourceNameResult,
  Error = CloudError,
  OptionalRequestBody = true
>;
