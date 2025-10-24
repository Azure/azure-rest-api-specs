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

namespace Microsoft.DBforMySQL;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface LocationBasedCapabilities {
  /**
   * Get capabilities at specified location in a given subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @list
  @get
  @action("capabilities")
  list is ArmProviderActionSync<
    Response = ArmResponse<CapabilitiesListResult>,
    Scope = SubscriptionActionScope,
    Parameters = LocationNameParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface CheckVirtualNetworkSubnetUsage {
  /**
   * Get virtual network subnet usage for a given vNet resource id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @action("checkVirtualNetworkSubnetUsage")
  execute is ArmProviderActionSync<
    Request = VirtualNetworkSubnetUsageParameter,
    Response = VirtualNetworkSubnetUsageResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationNameParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface CheckNameAvailability {
  /**
   * Check the availability of name for server
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @action("checkNameAvailability")
  execute is ArmProviderActionSync<
    Request = NameAvailabilityRequest,
    Response = NameAvailability,
    Scope = SubscriptionActionScope,
    Parameters = LocationNameParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface CheckNameAvailabilityWithoutLocation {
  /**
   * Check the availability of name for server
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @action("checkNameAvailability")
  execute is ArmProviderActionSync<
    Request = NameAvailabilityRequest,
    Response = NameAvailability,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface OperationResults {
  /**
   * Get the operation result for a long running operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Get the operation result for a long running operation.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DBforMySQL/locations/{locationName}/operationResults/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationNameParameter,
    ...Foundations.OperationIdParameter,
  ): ArmResponse<OperationStatusExtendedResult> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface OperationProgress {
  /**
   * Get the operation result for a long running operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Get the operation result for a long running operation.")
  @operationId("OperationProgress_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DBforMySQL/locations/{locationName}/operationProgress/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationNameParameter,
    ...Foundations.OperationIdParameter,
  ): ArmResponse<OperationProgressResult> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GetPrivateDnsZoneSuffix {
  /**
   * Get private DNS zone suffix in the cloud.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @action("getPrivateDnsZoneSuffix")
  execute is ArmProviderActionSync<Response = GetPrivateDnsZoneSuffixResponse>;
}

@armResourceOperations
interface Replicas {
  /**
   * List all the replicas for a given server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @list
  @get
  @action("replicas")
  listByServer is ArmResourceActionSync<
    Server,
    void,
    Response = ArmResponse<ServerListResult>
  >;
}
