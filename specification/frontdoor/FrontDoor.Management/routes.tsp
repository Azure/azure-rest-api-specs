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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ManagedRuleSetsOperationGroup {
  /**
   * Lists all available managed rule sets.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ManagedRuleSets_List")
  @autoRoute
  @list
  @get
  @action("FrontDoorWebApplicationFirewallManagedRuleSets")
  list is ArmProviderActionSync<
    Response = ManagedRuleSetDefinitionList,
    Scope = SubscriptionActionScope,
    Error = ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface FrontDoorNameAvailabilityOperationGroup {
  /**
   * Check the availability of a Front Door resource name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("FrontDoorNameAvailability_Check")
  @autoRoute
  @action("checkFrontDoorNameAvailability")
  check is ArmProviderActionSync<
    Request = CheckNameAvailabilityInput,
    Response = CheckNameAvailabilityOutput,
    Error = ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface FrontDoorNameAvailabilityWithSubscriptionOperationGroup {
  /**
   * Check the availability of a Front Door subdomain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

@@Azure.ClientGenerator.Core.clientName(FrontDoorNameAvailabilityOperationGroup.check::parameters.body,
  "checkFrontDoorNameAvailabilityInput"
);
@@Azure.ClientGenerator.Core.clientName(FrontDoorNameAvailabilityWithSubscriptionOperationGroup.check::parameters.body,
  "checkFrontDoorNameAvailabilityInput"
);
