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

namespace Microsoft.DBforPostgreSQL;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface LocationBasedCapabilitiesOperationGroup {
  /**
   * Get capabilities at specified location in a given subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LocationBasedCapabilities_Execute")
  @autoRoute
  @get
  @action("capabilities")
  execute is ArmProviderActionSync<
    Response = CapabilitiesListResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The name of the location.
       */
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      @segment("locations")
      locationName: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface CheckNameAvailabilityOperationGroup {
  /**
   * Check the availability of name for resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CheckNameAvailability_Execute")
  @autoRoute
  @action("checkNameAvailability")
  execute is ArmProviderActionSync<
    Request = CheckNameAvailabilityRequest,
    Response = NameAvailability,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface CheckNameAvailabilityWithLocationOperationGroup {
  /**
   * Check the availability of name for resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CheckNameAvailabilityWithLocation_Execute")
  @autoRoute
  @action("checkNameAvailability")
  execute is ArmProviderActionSync<
    Request = CheckNameAvailabilityRequest,
    Response = NameAvailability,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The name of the location.
       */
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      @segment("locations")
      locationName: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface GetPrivateDnsZoneSuffixOperationGroup {
  /**
   * Get private DNS zone suffix in the cloud
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GetPrivateDnsZoneSuffix_Execute")
  @autoRoute
  @action("getPrivateDnsZoneSuffix")
  execute is ArmProviderActionSync<Response = PrivateDnsZoneSuffix>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface QuotaUsagesOperationGroup {
  /**
   * Get quota usages at specified location in a given subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("QuotaUsages_List")
  @autoRoute
  @get
  @action("resourceType/flexibleServers/usages")
  list is ArmProviderActionSync<
    Response = QuotaUsagesListResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The name of the location.
       */
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      @segment("locations")
      locationName: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface VirtualNetworkSubnetUsageOperationGroup {
  /**
   * Get virtual network subnet usage for a given vNet resource id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualNetworkSubnetUsage_Execute")
  @autoRoute
  @action("checkVirtualNetworkSubnetUsage")
  execute is ArmProviderActionSync<
    Request = VirtualNetworkSubnetUsageParameter,
    Response = VirtualNetworkSubnetUsageResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The name of the location.
       */
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      @segment("locations")
      locationName: string;
    }
  >;
}
