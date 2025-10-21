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

namespace Microsoft.NetApp;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface NetAppResourceOperationGroup {
  /**
   * Check if a resource name is available.
   */
  @summary("Check resource name availability")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = ResourceNameAvailabilityRequest,
    Response = CheckAvailabilityResponse,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
  /**
   * Check if a file path is available.
   */
  @summary("Check file path availability")
  @autoRoute
  checkFilePathAvailability is ArmProviderActionSync<
    Request = FilePathAvailabilityRequest,
    Response = CheckAvailabilityResponse,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
  /**
   * Check if a quota is available.
   */
  @summary("Check quota availability")
  @autoRoute
  checkQuotaAvailability is ArmProviderActionSync<
    Request = QuotaAvailabilityRequest,
    Response = CheckAvailabilityResponse,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
  /**
   * Provides storage to network proximity and logical zone mapping information.
   */
  @summary("Describes region specific information.")
  @autoRoute
  @get
  @action("regionInfo")
  queryRegionInfo is ArmProviderActionSync<
    Response = RegionInfo,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
  /**
   * Get details of the specified network sibling set.
   */
  @summary("Describe a network sibling set")
  @autoRoute
  queryNetworkSiblingSet is ArmProviderActionSync<
    Request = QueryNetworkSiblingSetRequest,
    Response = NetworkSiblingSet,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
  /**
   * Update the network features of the specified network sibling set.
   */
  @summary("Update the network features of a network sibling set")
  @autoRoute
  updateNetworkSiblingSet is ArmProviderActionAsync<
    Request = UpdateNetworkSiblingSetRequest,
    Response = NetworkSiblingSet,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface NetAppResourceUsagesOperationGroup {
  /**
   * Get current subscription usages
   */
  @summary("Get usages")
  @autoRoute
  @get
  @action("usages")
  @list
  list is ArmProviderActionSync<
    Response = UsagesListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
  /**
   * Get current subscription usage of the specific type
   */
  @summary("Get specific type of usage")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.NetApp/locations/{location}/usages/{usageType}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The type of usage
     */
    @path
    usageType: string,
  ): ArmResponse<UsageResult> | ErrorResponse;
}
