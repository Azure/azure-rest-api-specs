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
interface CapabilitiesByLocationOperationGroup {
  /**
   * Lists the capabilities available in a given location for a specific subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CapabilitiesByLocation_List")
  @autoRoute
  @get
  @action("capabilities")
  list is ArmProviderActionSync<
    Response = CapabilityList,
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
interface NameAvailabilityOperationGroup {
  /**
   * Checks the validity and availability of the given name, to assign it to a new server or to use it as the base name of a new pair of virtual endpoints.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NameAvailability_CheckGlobally")
  @autoRoute
  @action("checkNameAvailability")
  checkGlobally is ArmProviderActionSync<
    Request = Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
    Response = NameAvailabilityModel,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  /**
   * Check the availability of name for resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NameAvailability_CheckWithLocation")
  @autoRoute
  @action("checkNameAvailability")
  checkWithLocation is ArmProviderActionSync<
    Request = Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
    Response = NameAvailabilityModel,
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
interface PrivateDnsZoneSuffixOperationGroup {
  /**
   * Gets the private DNS zone suffix.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateDnsZoneSuffix_Get")
  @autoRoute
  @action("getPrivateDnsZoneSuffix")
  get is ArmProviderActionSync<Response = PrivateDnsZoneSuffix>;
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
    Response = QuotaUsageList,
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
   * Lists the virtual network subnet usage for a given virtual network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualNetworkSubnetUsage_List")
  @autoRoute
  @action("checkVirtualNetworkSubnetUsage")
  list is ArmProviderActionSync<
    Request = VirtualNetworkSubnetUsageParameter,
    Response = VirtualNetworkSubnetUsageModel,
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
