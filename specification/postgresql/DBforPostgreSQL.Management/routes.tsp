// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforPostgreSQL;

alias LocationParameter = {
  /**
   * The name of the location.
   */
  @minLength(1)
  @pattern("^[-\\w\\._]+$")
  @path
  @segment("locations")
  locationName: string;
};

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
    Parameters = LocationParameter
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
    Parameters = LocationParameter
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
    Parameters = LocationParameter
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
    Parameters = LocationParameter
  >;
}

@doc("Maintenance event operations for PostgreSQL flexible servers.")
@armResourceOperations
@added(Versions.v2026_04_01)
interface MaintenanceEvents {
  @doc("Gets information about a maintenance event for a flexible server.")
  get is ArmResourceRead<MaintenanceEventResource>;

  @doc("Lists all maintenance events for a flexible server.")
  list is ArmResourceListByParent<
    MaintenanceEventResource,
    Parameters = {
      @doc("Filter maintenance events by status.")
      @query("maintenanceStatus")
      maintenanceStatus?: MaintenanceEventStatusFilter;
    }
  >;

  @doc("Reschedules a maintenance event to a new date and time.")
  reschedule is ArmResourceActionAsyncBase<
    MaintenanceEventResource,
    MaintenanceEventRescheduleRequest,
    | ArmResponse<MaintenanceEventActionResponse>
    | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = MaintenanceEventActionResponse> &
        Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<MaintenanceEventResource>
  >;

  @doc("Applies the maintenance event immediately.")
  applyNow is ArmResourceActionAsyncBase<
    MaintenanceEventResource,
    void,
    | ArmResponse<MaintenanceEventActionResponse>
    | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = MaintenanceEventActionResponse> &
        Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<MaintenanceEventResource>
  >;
}

@doc("Major version upgrade precheck operations for PostgreSQL flexible servers.")
@armResourceOperations
@added(Versions.v2026_04_01)
interface MajorVersionUpgradePrecheck {
  @doc("Gets information about a major version upgrade precheck for a flexible server.")
  get is ArmResourceRead<MajorVersionUpgradePrecheckResource>;

  @doc("Lists major version upgrade prechecks for a flexible server.")
  list is ArmResourceListByParent<MajorVersionUpgradePrecheckResource>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The database agent is enabled or disabled through PUT and the service does not support DELETE."
@armResourceOperations
@added(Versions.v2026_07_01)
interface DbAgents {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "The service contract requires the DBAgent_List operation ID."
  @doc("Lists the database agent configuration for a flexible server.")
  @operationId("DBAgent_List")
  list is ArmResourceListByParent<DbAgent>;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "The service contract requires the DBAgent_Get operation ID."
  @doc("Gets the database agent configuration for a flexible server.")
  @operationId("DBAgent_Get")
  get is ArmResourceRead<DbAgent>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The implemented service contract returns HTTP 202 for every database agent write."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The implemented service contract returns the in-progress database agent resource in the HTTP 202 response body."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "The service contract requires the DBAgent_CreateOrUpdate operation ID."
  @doc("Enables or disables the database agent for a flexible server.")
  @operationId("DBAgent_CreateOrUpdate")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @put
  createOrUpdate is Legacy.CreateOrReplaceAsync<
    DbAgent,
    Request = DbAgentForUpdate,
    Response = DbAgentAcceptedResponse
  >;
}
