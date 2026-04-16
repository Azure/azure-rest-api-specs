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
@@clientName(WebApplicationFirewallPolicy, "FrontDoorWebApplicationFirewallPolicy", "csharp");

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
@@clientName(GetTimeseriesParameters.startDateTimeUTC,
  "startDateTimeUtc",
  "java"
);
@@clientName(GetTimeseriesParameters.endDateTimeUTC, "endDateTimeUtc", "java");

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
@@clientName(WebApplicationFirewallPolicyProperties.customRules, "CustomRuleList", "csharp");
@@clientName(HealthProbeSettingsModel, "FrontDoorHealthProbeSettingsData", "csharp");
@@clientName(LoadBalancingSettingsModel, "FrontDoorLoadBalancingSettingsData", "csharp");
@@clientName(RoutingRule, "RoutingRuleData", "csharp");
@@clientName(PurgeParameters, "FrontDoorEndpointPurgeContent", "csharp");
@@clientName(ValidateCustomDomainInput, "FrontDoorValidateCustomDomainContent", "csharp");
@@clientName(ValidateCustomDomainOutput, "FrontDoorValidateCustomDomainResult", "csharp");
@@clientName(ValidateCustomDomainOutput.customDomainValidated, "IsCustomDomainValidated", "csharp");
@@clientName(CustomHttpsProvisioningState, "FrontendEndpointCustomHttpsProvisioningState", "csharp");
@@clientName(CustomHttpsProvisioningSubstate, "FrontendEndpointCustomHttpsProvisioningSubstate", "csharp");
@@clientName(ProfileUpdateModel, "FrontDoorNetworkExperimentProfilePatch", "csharp");
@@clientName(PolicySettings, "FrontDoorWebApplicationFirewallPolicySettings", "csharp");
@@clientName(PolicyResourceState, "FrontDoorWebApplicationFirewallPolicyResourceState", "csharp");
@@clientName(CustomRule, "WebApplicationCustomRule", "csharp");
@@clientName(CheckNameAvailabilityInput, "FrontDoorNameAvailabilityContent", "csharp");
@@clientName(CheckNameAvailabilityOutput, "FrontDoorNameAvailabilityResult", "csharp");
@@clientName(ActionType, "RuleMatchActionType", "csharp");
@@clientName(Availability, "FrontDoorNameAvailabilityState", "csharp");
@@clientName(Backend, "FrontDoorBackend", "csharp");
@@alternateType(Backend.privateLinkResourceId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(Backend.privateLinkLocation, Azure.Core.azureLocation, "csharp");
@@clientName(PrivateEndpointStatus, "BackendPrivateEndpointStatus", "csharp");
@@clientName(BackendPool, "FrontDoorBackendPool", "csharp");
@@clientName(BackendPoolsSettings.sendRecvTimeoutSeconds, "SendRecvTimeoutInSeconds", "csharp");
@@clientName(FrontDoorCertificateType, "FrontDoorEndpointConnectionCertificateType", "csharp");
@@clientName(CustomHttpsProvisioningSubstate.PendingDomainControlValidationREquestApproval, "PendingDomainControlValidationRequestApproval", "csharp");
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
@@clientName(LatencyScorecardProperties.endpointA, "ScorecardEndpointA", "csharp");
@@clientName(LatencyScorecardProperties.endpointB, "ScorecardEndpointB", "csharp");
@@clientName(LatencyScorecardProperties.startDateTimeUTC, "StartOn", "csharp");
@@clientName(LatencyScorecardProperties.endDateTimeUTC, "EndOn", "csharp");
@@clientName(PolicyMode, "FrontDoorWebApplicationFirewallPolicyMode", "csharp");
@@clientName(RulesEngineMatchCondition.negateCondition, "IsNegateCondition", "csharp");
@@clientName(Transform, "RulesEngineMatchTransform", "csharp");
@@clientName(Transform.UrlDecode, "UriDecode", "csharp");
@@clientName(Transform.UrlEncode, "UriEncode", "csharp");
@@clientName(ResourceType, "FrontDoorResourceType", "csharp");
@@clientName(MinimumTLSVersion, "FrontDoorRequiredMinimumTlsVersion", "csharp");
@@clientName(LatencyMetric.endDateTimeUTC, "EndOn", "csharp");
@@clientName(AggregationInterval, "FrontDoorTimeSeriesInfoAggregationInterval", "csharp");
@@clientName(TimeseriesAggregationInterval, "FrontDoorTimeSeriesAggregationInterval", "csharp");
@@clientName(CacheConfiguration, "FrontDoorCacheConfiguration", "csharp");
@@clientName(EndpointType, "FrontDoorEndpointType", "csharp");
@@clientName(EndpointType.AFD, "AzureFrontDoor", "csharp");
@@clientName(EndpointType.ATM, "AzureTrafficManager", "csharp");
@@clientName(TimeseriesDataPoint, "FrontDoorTimeSeriesDataPoint", "csharp");
@@clientName(TimeseriesType, "FrontDoorTimeSeriesType", "csharp");
@@clientName(VariableName, "FrontDoorWebApplicationFirewallPolicyGroupByVariableName", "csharp");
@@clientName(GroupByVariable, "FrontDoorWebApplicationFirewallPolicyGroupByVariable", "csharp");
@@alternateType(ExperimentProperties.scriptFileUri, url, "csharp");

@@alternateType(TimeseriesProperties.endpoint, url, "csharp");
@@alternateType(LatencyScorecardProperties.endpointA, url, "csharp");
@@alternateType(LatencyScorecardProperties.endpointB, url, "csharp");
@@clientName(ManagedRuleExclusionSelectorMatchOperator.Equals, "EqualsValue", "csharp");
@@clientName(ScrubbingRuleEntryMatchOperator.Equals, "EqualsValue", "csharp");
@@clientName(ExceptionSelectorMatchOperator.Equals, "EqualsValue", "csharp");
@@clientName(ExceptionValueMatchOperator.Equals, "EqualsValue", "csharp");

@@clientName(FrontDoorNameAvailabilityOperationGroup.check, "CheckFrontDoorNameAvailability", "csharp");
@@clientName(FrontDoorNameAvailabilityWithSubscriptionOperationGroup.check, "CheckFrontDoorNameAvailability", "csharp");
@@clientName(EndpointType.CDN, "Cdn", "csharp");
@@clientName(FrontDoorHealthProbeMethod.HEAD, "Head", "csharp");
@@clientName(TimeseriesDataPoint.dateTimeUTC, "DateTimeUtc", "csharp");
@@clientName(ActionType.CAPTCHA, "Captcha", "csharp");
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(Microsoft.Network.Resource.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(ResourcewithSettableName.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(BasicResource.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(BasicResourceWithSettableIDName.id, Azure.Core.armResourceIdentifier, "csharp");

// Category D — output-only models need public constructors
@@usage(TimeseriesDataPoint, Usage.input | Usage.output, "csharp");
@@usage(LatencyMetric, Usage.input | Usage.output, "csharp");
@@usage(RouteConfiguration, Usage.input | Usage.output, "csharp");

// Category E — ResourceIdentifier type on nested id fields
@@alternateType(SubResource.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(RoutingRuleUpdateParametersWebApplicationFirewallPolicyLink.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(FrontendEndpointUpdateParametersWebApplicationFirewallPolicyLink.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(KeyVaultCertificateSourceParametersVault.id, Azure.Core.armResourceIdentifier, "csharp");

// Category F — ETag and Uri type fixes
@@alternateType(Profile.etag, Azure.Core.eTag, "csharp");
@@alternateType(WebApplicationFirewallPolicy.etag, Azure.Core.eTag, "csharp");
@@alternateType(PolicySettings.redirectUrl, url, "csharp");

// Category H — TLS enum member name fixes handled in Customized/ (Tls10->Tls1_0 aliases)
// Note: @@clientName strips underscores (Tls1_0 → Tls10), so Customized/ adds the aliases.

