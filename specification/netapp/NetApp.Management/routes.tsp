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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Check resource name availability")
  @operationId("NetAppResource_CheckNameAvailability")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Check file path availability")
  @operationId("NetAppResource_CheckFilePathAvailability")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Check quota availability")
  @operationId("NetAppResource_CheckQuotaAvailability")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Describes region specific information.")
  @operationId("NetAppResource_QueryRegionInfo")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Describe a network sibling set")
  @operationId("NetAppResource_QueryNetworkSiblingSet")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Update the network features of a network sibling set")
  @operationId("NetAppResource_UpdateNetworkSiblingSet")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get usages")
  @operationId("NetAppResourceUsages_List")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get specific type of usage")
  @operationId("NetAppResourceUsages_Get")
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
