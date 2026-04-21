import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Network;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Rest;

@@clientName(Microsoft.Network,
  "FrontDoorManagementClient",
  "python, javascript"
);
@@clientName(Experiment, "FrontDoorExperiment", "csharp");
@@clientName(Profile, "FrontDoorNetworkExperimentProfile", "csharp");
@@clientName(RulesEngine, "FrontDoorRulesEngine", "csharp");
@@clientName(WebApplicationFirewallPolicy,
  "FrontDoorWebApplicationFirewallPolicy",
  "csharp"
);

@@clientName(MinimumTLSVersion.`1.0`, "ONE0", "python");
@@clientName(MinimumTLSVersion.`1.2`, "ONE2", "python");
@@clientName(MatchProcessingBehavior.Continue, "CONTINUE_ENUM", "python");
@@clientName(MinimumTLSVersion.`1.0`, "One0", "javascript");
@@clientName(MinimumTLSVersion.`1.2`, "One2", "javascript");

@@clientName(MinimumTLSVersion, "MinimumTlsVersion", "java");
@@clientName(ValidateCustomDomainInput.hostName, "hostname", "java");
@@clientName(FrontendEndpointUpdateParameters.hostName, "hostname", "java");
@@clientName(FrontendEndpointProperties.hostName, "hostname", "java");
@@clientName(LatencyMetric.endDateTimeUTC, "endDateTimeUtc", "java");
@@clientName(LatencyScorecardProperties.startDateTimeUTC,
  "startDateTimeUtc",
  "java"
);
@@clientName(LatencyScorecardProperties.endDateTimeUTC,
  "endDateTimeUtc",
  "java"
);
@@clientName(TimeseriesProperties.startDateTimeUTC, "startDateTimeUtc", "java");
@@clientName(TimeseriesProperties.endDateTimeUTC, "endDateTimeUtc", "java");
@@clientName(TimeseriesDataPoint.dateTimeUTC, "dateTimeUtc", "java");

@@clientName(GetLatencyScorecardsParameters.endDateTimeUTC,
  "endDateTimeUtc",
  "java"
);
@@clientName(GetLatencyScorecardsParameters.endDateTimeUTC, "endOn", "csharp");
@@clientName(GetTimeseriesParameters.startDateTimeUTC,
  "startDateTimeUtc",
  "java"
);
@@clientName(GetTimeseriesParameters.endDateTimeUTC, "endDateTimeUtc", "java");
@@clientName(GetTimeseriesParameters.startDateTimeUTC, "startOn", "csharp");
@@clientName(GetTimeseriesParameters.endDateTimeUTC, "endOn", "csharp");
@@clientName(GetTimeseriesParameters.timeseriesType,
  "timeSeriesType",
  "csharp"
);

@@clientName(MinimumTLSVersion.`1.0`, "One0", "go");
@@clientName(MinimumTLSVersion.`1.2`, "One2", "go");

/**
 * added for override of Profiles.createOrUpdate
 */
@armResourceOperations
interface ProfilesOverrides {
  /**
   * override for Profiles.createOrUpdate
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  replaceCreateOrUpdate(
    ...Azure.ResourceManager.ProviderNamespace<Profile>,
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    profileName: string,
    ...ResourceGroupParameter,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    parameters: Microsoft.Network.Profile,
  ): ArmResourceUpdatedResponse<Profile> | ArmResourceCreatedResponse<
    Profile,
    ArmLroLocationHeader<FinalResult = Profile> &
      Azure.Core.Foundations.RetryAfterHeader
  > | (ArmAcceptedLroResponse & {
    @bodyRoot
    _: Profile;
  });
}
@@override(Profiles.createOrUpdate,
  ProfilesOverrides.replaceCreateOrUpdate,
  "go,javascript,python"
);

@@clientName(State, "FrontDoorExperimentState", "csharp");
@@clientName(Endpoint, "FrontDoorExperimentEndpointProperties", "csharp");
@@clientName(ExperimentProperties.endpointA, "ExperimentEndpointA", "csharp");
@@clientName(ExperimentProperties.endpointB, "ExperimentEndpointB", "csharp");
@@clientName(Timeseries, "FrontDoorTimeSeriesInfo", "csharp");
@@clientName(TimeseriesProperties.startDateTimeUTC, "StartOn", "csharp");
@@clientName(TimeseriesProperties.endDateTimeUTC, "EndOn", "csharp");
@@clientName(WebApplicationFirewallPolicyProperties.customRules,
  "RulesList",
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility — flatten managedRules into parent; baseline 1.4.1 exposed ManagedRuleSets directly on Data."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WebApplicationFirewallPolicyProperties.managedRules,
  "csharp"
);
@@clientName(HealthProbeSettingsModel,
  "FrontDoorHealthProbeSettingsData",
  "csharp"
);
@@clientName(LoadBalancingSettingsModel,
  "FrontDoorLoadBalancingSettingsData",
  "csharp"
);
@@clientName(RoutingRule, "RoutingRuleData", "csharp");
@@clientName(PurgeParameters, "FrontDoorEndpointPurgeContent", "csharp");
@@clientName(ValidateCustomDomainInput,
  "FrontDoorValidateCustomDomainContent",
  "csharp"
);
@@clientName(ValidateCustomDomainOutput,
  "FrontDoorValidateCustomDomainResult",
  "csharp"
);
@@clientName(ValidateCustomDomainOutput.customDomainValidated,
  "IsCustomDomainValidated",
  "csharp"
);
@@clientName(CustomHttpsProvisioningState,
  "FrontendEndpointCustomHttpsProvisioningState",
  "csharp"
);
@@clientName(CustomHttpsProvisioningSubstate,
  "FrontendEndpointCustomHttpsProvisioningSubstate",
  "csharp"
);
@@clientName(ProfileUpdateModel,
  "FrontDoorNetworkExperimentProfilePatch",
  "csharp"
);
@@clientName(PolicySettings,
  "FrontDoorWebApplicationFirewallPolicySettings",
  "csharp"
);
@@clientName(PolicyResourceState,
  "FrontDoorWebApplicationFirewallPolicyResourceState",
  "csharp"
);
@@clientName(CustomRule, "WebApplicationCustomRule", "csharp");
@@clientName(CheckNameAvailabilityInput,
  "FrontDoorNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckNameAvailabilityInput.type, "ResourceType", "csharp");
@@clientName(CheckNameAvailabilityOutput,
  "FrontDoorNameAvailabilityResult",
  "csharp"
);
@@clientName(ActionType, "RuleMatchActionType", "csharp");
@@clientName(Availability, "FrontDoorNameAvailabilityState", "csharp");
@@clientName(Backend, "FrontDoorBackend", "csharp");
@@alternateType(Backend.privateLinkResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Backend.privateLinkLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@clientName(PrivateEndpointStatus, "BackendPrivateEndpointStatus", "csharp");
@@clientName(BackendPool, "FrontDoorBackendPool", "csharp");
@@clientName(BackendPoolsSettings.sendRecvTimeoutSeconds,
  "SendRecvTimeoutInSeconds",
  "csharp"
);
@@clientName(FrontDoorCertificateType,
  "FrontDoorEndpointConnectionCertificateType",
  "csharp"
);
@@clientName(CustomHttpsProvisioningSubstate.PendingDomainControlValidationREquestApproval,
  "PendingDomainControlValidationRequestApproval",
  "csharp"
);
@@clientName(MatchCondition, "WebApplicationRuleMatchCondition", "csharp");
@@clientName(MatchCondition.negateCondition, "IsNegateCondition", "csharp");
@@clientName(MatchVariable, "WebApplicationRuleMatchVariable", "csharp");
@@clientName(Operator, "WebApplicationRuleMatchOperator", "csharp");
@@clientName(Operator.RegEx, "RegEX", "csharp");
@@clientName(TransformType, "WebApplicationRuleMatchTransformType", "csharp");
@@clientName(TransformType.UrlDecode, "UriDecode", "csharp");
@@clientName(TransformType.UrlEncode, "UriEncode", "csharp");
@@clientName(RuleType, "WebApplicationRuleType", "csharp");
@@clientName(FrontDoorHealthProbeMethod.GET, "Get", "csharp");
@@clientName(HeaderAction, "RulesEngineHeaderAction", "csharp");
@@clientName(HeaderActionType, "RulesEngineHeaderActionType", "csharp");
@@clientName(LatencyScorecardProperties.id, "LatencyScorecardId", "csharp");
@@clientName(LatencyScorecardProperties.name, "LatencyScorecardName", "csharp");
@@clientName(LatencyScorecardProperties.endpointA,
  "ScorecardEndpointA",
  "csharp"
);
@@clientName(LatencyScorecardProperties.endpointB,
  "ScorecardEndpointB",
  "csharp"
);
@@clientName(LatencyScorecardProperties.startDateTimeUTC, "StartOn", "csharp");
@@clientName(LatencyScorecardProperties.endDateTimeUTC, "EndOn", "csharp");
@@clientName(PolicyMode, "FrontDoorWebApplicationFirewallPolicyMode", "csharp");
@@clientName(RulesEngineMatchCondition.negateCondition,
  "IsNegateCondition",
  "csharp"
);
@@clientName(Transform, "RulesEngineMatchTransform", "csharp");
@@clientName(Transform.UrlDecode, "UriDecode", "csharp");
@@clientName(Transform.UrlEncode, "UriEncode", "csharp");
@@clientName(ResourceType, "FrontDoorResourceType", "csharp");
@@clientName(MinimumTLSVersion, "FrontDoorRequiredMinimumTlsVersion", "csharp");
@@clientName(LatencyMetric.endDateTimeUTC, "EndOn", "csharp");
@@clientName(AggregationInterval,
  "FrontDoorTimeSeriesInfoAggregationInterval",
  "csharp"
);
@@clientName(TimeseriesAggregationInterval,
  "FrontDoorTimeSeriesAggregationInterval",
  "csharp"
);
@@clientName(CacheConfiguration, "FrontDoorCacheConfiguration", "csharp");
@@clientName(EndpointType, "FrontDoorEndpointType", "csharp");
@@clientName(EndpointType.AFD, "AzureFrontDoor", "csharp");
@@clientName(EndpointType.ATM, "AzureTrafficManager", "csharp");
@@clientName(TimeseriesDataPoint, "FrontDoorTimeSeriesDataPoint", "csharp");
@@clientName(TimeseriesType, "FrontDoorTimeSeriesType", "csharp");
@@clientName(VariableName,
  "FrontDoorWebApplicationFirewallPolicyGroupByVariableName",
  "csharp"
);
@@clientName(GroupByVariable,
  "FrontDoorWebApplicationFirewallPolicyGroupByVariable",
  "csharp"
);
@@alternateType(ExperimentProperties.scriptFileUri, url, "csharp");

@@alternateType(TimeseriesProperties.endpoint, url, "csharp");
@@alternateType(LatencyScorecardProperties.endpointA, url, "csharp");
@@alternateType(LatencyScorecardProperties.endpointB, url, "csharp");
@@clientName(ManagedRuleExclusionSelectorMatchOperator.Equals,
  "EqualsValue",
  "csharp"
);
@@clientName(ScrubbingRuleEntryMatchOperator.Equals, "EqualsValue", "csharp");
@@clientName(ExceptionSelectorMatchOperator.Equals, "EqualsValue", "csharp");
@@clientName(ExceptionValueMatchOperator.Equals, "EqualsValue", "csharp");

@@clientName(FrontDoorNameAvailabilityOperationGroup.check,
  "CheckFrontDoorNameAvailability",
  "csharp"
);
@@clientName(FrontDoorNameAvailabilityWithSubscriptionOperationGroup.check,
  "CheckFrontDoorNameAvailability",
  "csharp"
);
@@clientName(EndpointType.CDN, "Cdn", "csharp");
@@clientName(FrontDoorHealthProbeMethod.HEAD, "Head", "csharp");
@@clientName(TimeseriesDataPoint.dateTimeUTC, "DateTimeUtc", "csharp");
@@clientName(ActionType.CAPTCHA, "Captcha", "csharp");
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.Network.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ResourcewithSettableName.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(BasicResource.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(BasicResourceWithSettableIDName.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@usage(TimeseriesDataPoint, Usage.input | Usage.output, "csharp");
@@usage(LatencyMetric, Usage.input | Usage.output, "csharp");
@@usage(RouteConfiguration, Usage.input | Usage.output, "csharp");

@@usage(Timeseries, Usage.input | Usage.output, "csharp");
@@usage(LatencyScorecard, Usage.input | Usage.output, "csharp");
@@usage(ManagedRuleSetDefinition, Usage.input | Usage.output, "csharp");
@@usage(PreconfiguredEndpoint, Usage.input | Usage.output, "csharp");

@@clientName(SubResource, "FrontDoorSubResource", "csharp");
@@alternateType(SubResource.id, Azure.Core.armResourceIdentifier, "csharp");
@@clientName(BasicResourceWithSettableIDName,
  "FrontDoorResourceData",
  "csharp"
);
@@clientName(BasicResourceWithSettableIDName.type, "ResourceType", "csharp");
@@alternateType(BasicResourceWithSettableIDName.type,
  Azure.Core.armResourceType,
  "csharp"
);
@@alternateType(RoutingRuleUpdateParametersWebApplicationFirewallPolicyLink.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(FrontendEndpointUpdateParametersWebApplicationFirewallPolicyLink.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(KeyVaultCertificateSourceParametersVault.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// FrontDoorResourceData (BasicResourceWithSettableIDName) instead of FrontDoorSubResource (SubResource).
// hierarchyBuilding cannot be used here: the validator requires the base's properties (id) to be
// directly on the target, but our models inherit `id` from SubResource.
// Keeps models.tsp untouched (no swagger change) — replacements are C#-only constructs.
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "C#-only replacement model to swap base class; no impact on spec/swagger."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Brownfield migration: inherits @customAzureResource from BasicResourceWithSettableIDName; replacement is C#-only."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "C#-only replacement model; not emitted to swagger and not a top-level ARM resource."
@doc("A routing rule represents a specification for traffic to treat and where to send it, along with health probe information.")
model RoutingRuleReplacement extends BasicResourceWithSettableIDName {
  @doc("Properties of the Front Door Routing Rule")
  properties?: RoutingRuleProperties;
}
@@alternateType(RoutingRule, RoutingRuleReplacement, "csharp");
@@clientName(RoutingRuleReplacement, "RoutingRuleData", "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility — flatten properties into parent in C# SDK."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(RoutingRuleReplacement.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "C#-only replacement model to swap base class; no impact on spec/swagger."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Brownfield migration: inherits @customAzureResource from BasicResourceWithSettableIDName; replacement is C#-only."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "C#-only replacement model; not emitted to swagger and not a top-level ARM resource."
@doc("Load balancing settings for a backend pool")
model LoadBalancingSettingsModelReplacement
  extends BasicResourceWithSettableIDName {
  @doc("Properties of the load balancing settings")
  properties?: LoadBalancingSettingsProperties;
}
@@alternateType(LoadBalancingSettingsModel,
  LoadBalancingSettingsModelReplacement,
  "csharp"
);
@@clientName(LoadBalancingSettingsModelReplacement,
  "FrontDoorLoadBalancingSettingsData",
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility — flatten properties into parent in C# SDK."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(LoadBalancingSettingsModelReplacement.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "C#-only replacement model to swap base class; no impact on spec/swagger."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Brownfield migration: inherits @customAzureResource from BasicResourceWithSettableIDName; replacement is C#-only."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "C#-only replacement model; not emitted to swagger and not a top-level ARM resource."
@doc("Load balancing settings for a backend pool")
model HealthProbeSettingsModelReplacement
  extends BasicResourceWithSettableIDName {
  @doc("Properties of the health probe settings")
  properties?: HealthProbeSettingsProperties;
}
@@alternateType(HealthProbeSettingsModel,
  HealthProbeSettingsModelReplacement,
  "csharp"
);
@@clientName(HealthProbeSettingsModelReplacement,
  "FrontDoorHealthProbeSettingsData",
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility — flatten properties into parent in C# SDK."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(HealthProbeSettingsModelReplacement.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "C#-only replacement model to swap base class; no impact on spec/swagger."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Brownfield migration: inherits @customAzureResource from BasicResourceWithSettableIDName; replacement is C#-only."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "C#-only replacement model; not emitted to swagger and not a top-level ARM resource."
@doc("A backend pool is a collection of backends that can be routed to.")
model BackendPoolReplacement extends BasicResourceWithSettableIDName {
  @doc("Properties of the Front Door Backend Pool")
  properties?: BackendPoolProperties;
}
@@alternateType(BackendPool, BackendPoolReplacement, "csharp");
@@clientName(BackendPoolReplacement, "FrontDoorBackendPool", "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility — flatten properties into parent in C# SDK."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(BackendPoolReplacement.properties,
  "csharp"
);

@@alternateType(Profile.etag, Azure.Core.eTag, "csharp");
@@alternateType(WebApplicationFirewallPolicy.etag, Azure.Core.eTag, "csharp");
@@alternateType(PolicySettings.redirectUrl, url, "csharp");

@@alternateType(Microsoft.Network.Resource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
@@alternateType(ResourcewithSettableName,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
@@alternateType(BasicResource,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility: preserve autorest-generated resource treatment."
@@Azure.ResourceManager.Legacy.customAzureResource(FrontDoor,
  #{ isAzureResource: true }
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility: preserve autorest-generated resource treatment."
@@Azure.ResourceManager.Legacy.customAzureResource(Experiment,
  #{ isAzureResource: true }
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility: preserve autorest-generated resource treatment."
@@Azure.ResourceManager.Legacy.customAzureResource(Profile,
  #{ isAzureResource: true }
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility: preserve autorest-generated resource treatment."
@@Azure.ResourceManager.Legacy.customAzureResource(RulesEngine,
  #{ isAzureResource: true }
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility: preserve autorest-generated resource treatment."
@@Azure.ResourceManager.Legacy.customAzureResource(WebApplicationFirewallPolicy,
  #{ isAzureResource: true }
);

@@alternateType(GetLatencyScorecardsParameters.endDateTimeUTC,
  utcDateTime,
  "csharp"
);

@@alternateType(TimeseriesProperties.startDateTimeUTC, utcDateTime, "csharp");
@@alternateType(TimeseriesProperties.endDateTimeUTC, utcDateTime, "csharp");
@@alternateType(TimeseriesDataPoint.dateTimeUTC, utcDateTime, "csharp");
@@alternateType(LatencyMetric.endDateTimeUTC, utcDateTime, "csharp");

@@clientName(TimeseriesProperties.timeseriesType, "TimeSeriesType", "csharp");
@@clientName(TimeseriesProperties.timeseriesData, "TimeSeriesData", "csharp");

@@clientName(FrontendEndpointUpdateParameters.sessionAffinityTtlSeconds,
  "SessionAffinityTtlInSeconds",
  "csharp"
);

@@usage(RulesEngineRule, Usage.input | Usage.output, "csharp");

// WritableSubResource and SubResource don't exist in TypeSpec; define them in the ARM Models namespace so the
// C# generator maps them to Azure.ResourceManager.Resources.Models.{Writable}SubResource.
namespace Azure.ResourceManager.Models {
  model WritableSubResource {
    id?: Azure.Core.armResourceIdentifier;
  }
  model SubResource {
    id?: Azure.Core.armResourceIdentifier;
  }
}
@@alternateType(RoutingRuleUpdateParameters.frontendEndpoints,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(WebApplicationFirewallPolicyProperties.frontendEndpointLinks,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);
@@alternateType(WebApplicationFirewallPolicyProperties.routingRuleLinks,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);
@@alternateType(WebApplicationFirewallPolicyProperties.securityPolicyLinks,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);

@@clientName(Experiments.getLatencyScorecards,
  "GetLatencyScorecardsReport",
  "csharp"
);
@@clientName(Experiments.getTimeseries, "GetTimeSeriesReport", "csharp");
@@clientName(WebApplicationFirewallPolicies.listBySubscription,
  "GetFrontDoorWebApplicationFirewallPoliciesByFrontDoorWebApplicationFirewallPolicy",
  "csharp"
);
@@clientName(Profiles.preconfiguredEndpointsList,
  "GetPreconfiguredEndpoints",
  "csharp"
);
@@clientName(ManagedRuleSetsOperationGroup.list,
  "GetManagedRuleSets",
  "csharp"
);
