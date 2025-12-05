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

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ManagedRuleSetsOperationGroup {
  /**
   * Lists all available managed rule sets.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedRuleSets_List")
  @route("/subscriptions/{subscriptionId}/providers/microsoft.Network/frontDoorWebApplicationFirewallManagedRuleSets")
  @armResourceList(ManagedRuleSetDefinitionList)
  @list
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
  ): ArmResponse<ManagedRuleSetDefinitionList> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface FrontDoorNameAvailabilityOperationGroup {
  /**
   * Check the availability of a Front Door resource name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FrontDoorNameAvailability_Check")
  @autoRoute
  @action("checkFrontDoorNameAvailability")
  check is ArmProviderActionSync<
    Request = CheckNameAvailabilityInput,
    Response = CheckNameAvailabilityOutput,
    Error = ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface FrontDoorNameAvailabilityWithSubscriptionOperationGroup {
  /**
   * Check the availability of a Front Door subdomain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FrontDoorNameAvailabilityWithSubscription_Check")
  @autoRoute
  @action("checkFrontDoorNameAvailability")
  check is ArmProviderActionSync<
    Request = CheckNameAvailabilityInput,
    Response = CheckNameAvailabilityOutput,
    Scope = SubscriptionActionScope,
    Error = ErrorResponse
  >;
}
