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

namespace Microsoft.Cdn;

/**
 * Check the availability of a resource name. This is needed for resources where name is globally unique, such as a afdx endpoint.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/checkEndpointNameAvailability")
@post
op checkEndpointNameAvailability(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,

  /**
   * Input to check.
   */
  @bodyRoot
  checkEndpointNameAvailabilityInput: CheckEndpointNameAvailabilityInput,
): ArmResponse<CheckEndpointNameAvailabilityOutput> | ErrorResponse;

/**
 * Check the availability of a resource name. This is needed for resources where name is globally unique, such as a CDN endpoint.
 */
@autoRoute
op checkNameAvailability is ArmProviderActionSync<
  Request = CheckNameAvailabilityInput,
  Response = CheckNameAvailabilityOutput
>;

/**
 * Check the availability of a resource name. This is needed for resources where name is globally unique, such as a CDN endpoint.
 */
@autoRoute
@action("checkNameAvailability")
op checkNameAvailabilityWithSubscription is ArmProviderActionSync<
  Request = CheckNameAvailabilityInput,
  Response = CheckNameAvailabilityOutput,
  Scope = SubscriptionActionScope,
  Parameters = {}
>;

/**
 * Check if the probe path is a valid path and the file can be accessed. Probe path is the path to a file hosted on the origin server to help accelerate the delivery of dynamic content via the CDN endpoint. This path is relative to the origin path specified in the endpoint configuration.
 */
@autoRoute
op validateProbe is ArmProviderActionSync<
  Request = ValidateProbeInput,
  Response = ValidateProbeOutput,
  Scope = SubscriptionActionScope,
  Parameters = {}
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ProfilesOperationGroup {
  /**
   * Checks if CDN profile can be migrated to Azure Frontdoor(Standard/Premium) profile.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/canMigrate")
  @post
  canMigrate(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * Properties needed to check if cdn profile or classic frontdoor can be migrated.
     */
    @bodyRoot
    canMigrateParameters: CanMigrateParameters,
  ): ArmResponse<CanMigrateResult> | (ArmAcceptedResponse<ExtraHeaders = ArmLroLocationHeader<FinalResult = CanMigrateResult>> &
    Azure.Core.Foundations.RetryAfterHeader) | ErrorResponse;

  /**
   * Migrate the CDN profile to Azure Frontdoor(Standard/Premium) profile. The change need to be committed after this.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/migrate")
  @post
  migrate(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * Properties needed to migrate the profile.
     */
    @bodyRoot
    migrationParameters: MigrationParameters,
  ): ArmResponse<MigrateResult> | (ArmAcceptedResponse<ExtraHeaders = ArmLroLocationHeader<FinalResult = MigrateResult>> & {
    @bodyRoot _: MigrateResult;
  }) | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ResourceUsageOperationGroup {
  /**
   * Check the quota and actual usage of the CDN profiles under the given subscription.
   */
  @autoRoute
  @action("checkResourceUsage")
  @list
  list is ArmProviderActionSync<
    Response = ResourceUsageListResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface EdgeNodesOperationGroup {
  /**
   * Edgenodes are the global Point of Presence (POP) locations used to deliver CDN content to end users.
   */
  @autoRoute
  @get
  @action("edgenodes")
  @list
  list is ArmProviderActionSync<Response = EdgenodeResult>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ManagedRuleSetsOperationGroup {
  /**
   * Lists all available managed rule sets.
   */
  @autoRoute
  @get
  @action("cdnWebApplicationFirewallManagedRuleSets")
  @list
  list is ArmProviderActionSync<
    Response = ManagedRuleSetDefinitionList,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}
