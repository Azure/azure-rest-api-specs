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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface CapabilitiesByLocationOperationGroup {
  /**
   * Lists the capabilities available in a given location for a specific subscription.
   */
  @list
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface NameAvailabilityOperationGroup {
  /**
   * Checks the validity and availability of the given name, to assign it to a new server or to use it as the base name of a new pair of virtual endpoints.
   */
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface PrivateDnsZoneSuffixOperationGroup {
  /**
   * Gets the private DNS zone suffix.
   */
  @autoRoute
  @action("getPrivateDnsZoneSuffix")
  get is ArmProviderActionSync<Response = {
    @body
    privateDnsZoneSuffix: PrivateDnsZoneSuffix;
  }>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface QuotaUsagesOperationGroup {
  /**
   * Get quota usages at specified location in a given subscription.
   */
  @autoRoute
  @get
  @list
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface VirtualNetworkSubnetUsageOperationGroup {
  /**
   * Lists the virtual network subnet usage for a given virtual network.
   */
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
