import "./AlertsAPI/main.tsp";
import "./AlertsSuppressionRulesAPI/main.tsp";
import "./ApiCollectionsAPI/main.tsp";
import "./ApplicationsAPI/main.tsp";
import "./AssessmentAPI/main.tsp";
import "./ATPSettingsAPI/main.tsp";
import "./AutomationsAPI/main.tsp";
import "./ComplianceResultsAPI/main.tsp";
import "./DefenderForStorageAPI/main.tsp";
import "./GovernanceAPI/main.tsp";
import "./HealthReportsAPI/main.tsp";
import "./IoTSecurityAPI/main.tsp";
import "./LegacySettingsAPI/main.tsp";
import "./LocationsAPI/main.tsp";
import "./MdeOnboardingAPI/main.tsp";
import "./OperationsAPI/main.tsp";
import "./PricingsAPI/main.tsp";
import "./PrivateLinksAPI/main.tsp";
import "./RegulatoryComplianceAPI/main.tsp";
import "./SecureScoreAPI/main.tsp";
import "./SecurityConnectorsAPI/main.tsp";
import "./SecurityConnectorsDevOpsAPI/main.tsp";
import "./SecurityOperatorsAPI/main.tsp";
import "./SecuritySolutionsAPI/main.tsp";
import "./SecurityStandardsAPI/main.tsp";
import "./SensitivitySettingsAPI/main.tsp";
import "./ServerVulnerabilityAssessmentsSettingsAPI/main.tsp";
import "./SettingsAPI/main.tsp";
import "./SqlVulnerabilityAssessmentsAPI/main.tsp";
import "./StandardsAPI/main.tsp";
import "./SubAssessmentsAPI/main.tsp";
import "./TasksAPI/main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.Core;
using PrivateLinksAPI;
using GovernanceAPI;
using ATPSettingsAPI;
using AssessmentAPI;
using SecuritySolutionsAPI;
using SecurityStandardsAPI;
using ComplianceResultsAPI;
using HealthReportsAPI;
using LegacySettingsAPI;
using SqlVulnerabilityAssessmentsAPI;
using AlertsAPI;
using ApiCollectionsAPI;

@client({
  name: "SecurityManagementClient",
  service: [
    AlertsAPI,
    AlertsSuppressionRulesAPI,
    ApiCollectionsAPI,
    ApplicationsAPI,
    AssessmentAPI,
    ATPSettingsAPI,
    AutomationsAPI,
    ComplianceResultsAPI,
    DefenderForStorageAPI,
    GovernanceAPI,
    HealthReportsAPI,
    IoTSecurityAPI,
    LegacySettingsAPI,
    LocationsAPI,
    MdeOnboardingAPI,
    OperationsAPI,
    PricingsAPI,
    PrivateLinksAPI,
    RegulatoryComplianceAPI,
    SecureScoreAPI,
    SecurityConnectorsAPI,
    SecurityConnectorsDevOpsAPI,
    SecurityOperatorsAPI,
    SecuritySolutionsAPI,
    SecurityStandardsAPI,
    SensitivitySettingsAPI,
    ServerVulnerabilityAssessmentsSettingsAPI,
    SettingsAPI,
    SqlVulnerabilityAssessmentsAPI,
    StandardsAPI,
    SubAssessmentsAPI,
    TasksAPI
  ],
  autoMergeService: true,
})
namespace SecurityManagementClient;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model `private-link-parameters` {
  /**
   * The name of the private link resource.
   */
  @path
  @minLength(3)
  @maxLength(63)
  @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
  privateLinkName: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op privateLinksGetCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query
  privateLinkName: `private-link-parameters`,
): ArmResponse<PrivateLinksAPI.PrivateLinkResource> | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateLinkResources.get,
  privateLinksGetCustomization,
  "!python,!java,!javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op privateLinksCreateCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query
  privateLinkName: `private-link-parameters`,

  resource: PrivateLinksAPI.PrivateLinkResource,
): ArmResourceUpdatedResponse<PrivateLinksAPI.PrivateLinkResource> | ArmResourceCreatedResponse<
  PrivateLinksAPI.PrivateLinkResource,
  ArmAsyncOperationHeader<FinalResult = PrivateLinksAPI.PrivateLinkResource> &
    Azure.Core.Foundations.RetryAfterHeader
> | ErrorResponse;

@@clientName(privateLinksCreateCustomization::parameters.resource,
  "privateLink"
);
@@Azure.ClientGenerator.Core.override(PrivateLinkResources.create,
  privateLinksCreateCustomization,
  "!python,!java,!javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op privateLinksUpdateCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query
  privateLinkName: `private-link-parameters`,

  properties: PrivateLinksAPI.PrivateLinkUpdate,
): ArmResponse<PrivateLinksAPI.PrivateLinkResource> | ErrorResponse;

@@clientName(privateLinksUpdateCustomization::parameters.properties,
  "privateLink"
);
@@Azure.ClientGenerator.Core.override(PrivateLinkResources.update,
  privateLinksUpdateCustomization,
  "!python,!java,!javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op privateLinksDeleteCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query
  privateLinkName: `private-link-parameters`,
): ArmDeleteAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
  Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateLinkResources.delete,
  privateLinksDeleteCustomization,
  "!python,!java,!javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op privateLinksHeadCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query
  privateLinkName: `private-link-parameters`,
): OkResponse | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateLinkResources.head,
  privateLinksHeadCustomization,
  "!python,!java,!javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op privateEndpointConnectionsListCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query
  privateLinkName: `private-link-parameters`,
): ArmResponse<ResourceListResult<PrivateLinksAPI.PrivateEndpointConnection>> | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateEndpointConnections.list,
  privateEndpointConnectionsListCustomization,
  "!python,!java,!javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op privateEndpointConnectionsGetCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query
  privateLinkName: `private-link-parameters`,

  privateEndpointConnectionName: string,
): ArmResponse<Azure.ResourceManager.PrivateEndpointConnection> | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateEndpointConnections.get,
  privateEndpointConnectionsGetCustomization,
  "!python,!java,!javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op privateEndpointConnectionsCreateOrUpdateCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query
  privateLinkName: `private-link-parameters`,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateEndpointConnectionName: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource: PrivateLinksAPI.PrivateEndpointConnection,
): ArmResourceUpdatedResponse<PrivateLinksAPI.PrivateLinkResource> | ArmResourceCreatedResponse<
  PrivateLinksAPI.PrivateLinkResource,
  ArmAsyncOperationHeader<FinalResult = PrivateLinksAPI.PrivateLinkResource> &
    Azure.Core.Foundations.RetryAfterHeader
> | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateEndpointConnections.createOrUpdate,
  privateEndpointConnectionsCreateOrUpdateCustomization,
  "!python,!java,!javascript"
);
@@clientName(privateEndpointConnectionsCreateOrUpdateCustomization::parameters.resource,
  "privateEndpointConnection"
);

#suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op privateEndpointConnectionsDeleteCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query
  privateLinkName: `private-link-parameters`,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateEndpointConnectionName: string,
): ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
  Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateEndpointConnections.delete,
  privateEndpointConnectionsDeleteCustomization,
  "!python,!java,!javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op privateLinkResourcesListCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query
  privateLinkName: `private-link-parameters`,
): ArmResponse<ResourceListResult<PrivateLinkGroupResource>> | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateLinkGroupResources.list,
  privateLinkResourcesListCustomization,
  "!python,!java,!javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op privateLinkResourcesGetCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query
  privateLinkName: `private-link-parameters`,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  groupId: string,
): ArmResponse<PrivateLinkGroupResource> | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateLinkGroupResources.get,
  privateLinkResourcesGetCustomization,
  "!python,!java,!javascript"
);
@@clientName(SecurityStandardsAPI.SecurityStandard,
  "ArmSecurityStandard",
  "go"
);
@@clientName(SecurityOperatorsAPI.SecurityOperator, "OperatorResource", "go");
@@clientLocation(SecurityStandards.createOrUpdate,
  "ArmSecurityStandards",
  "go"
);
@@clientLocation(SecurityStandards.get, "ArmSecurityStandards", "go");
@@clientLocation(SecurityStandards.delete, "ArmSecurityStandards", "go");
@@clientLocation(SecurityStandards.list, "ArmSecurityStandards", "go");
@@clientName(SecurityStandardsAPI.SecurityStandardProperties,
  "ArmSecurityStandardProperties",
  "go"
);
@@usage(IoTSecurityAPI.CustomAlertRule,
  Usage.input | Usage.output,
  "go,javascript"
);

@@clientName(Azure.ResourceManager.CommonTypes.ErrorAdditionalInfo,
  "ArmErrorAdditionalInfo",
  "java"
);
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnection,
  "ArmPrivateEndpointConnection",
  "java,javascript,go"
);
@@clientName(Azure.ResourceManager.CommonTypes.ActionType,
  "ArmActionType",
  "java,go"
);
@@clientName(StandardsAPI.StandardList, "ArmSecurityStandardList", "go");

@@clientName(IoTSecurityAPI.RecommendationType.IoT_ACRAuthentication,
  "IoTAcrauthentication",
  "javascript,go"
);
@@clientName(IoTSecurityAPI.RecommendationType.IoT_IPFilter_DenyAll,
  "IoTIpfilterDenyAll",
  "javascript,go"
);
@@clientName(IoTSecurityAPI.RecommendationType.IoT_IPFilter_PermissiveRule,
  "IoTIpfilterPermissiveRule",
  "javascript,go"
);
@@clientName(SubAssessmentsAPI.CVE, "Cve", "javascript,java");

@@clientName(SecurityConnectorsAPI.DefenderCspmAwsOfferingCiemCiemDiscovery,
  "DefenderCspmAwsOfferingCiemDiscovery",
  "go,javascript,python,java"
);

@@clientName(SecurityConnectorsAPI.DefenderCspmAwsOfferingCiemCiemOidc,
  "DefenderCspmAwsOfferingCiemOidc",
  "go,javascript,python,java"
);

@@clientName(Common.ResourceDetails, "CommonResourceDetails", "python");
@@clientName(HealthReportsAPI.status, "StatusAutoGenerated", "python");

// C# MPG migration compatibility customizations are grouped by purpose to make
// migration review easier.

// C# common/shared model names.
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnection,
  "ArmPrivateEndpointConnection",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.ActionType,
  "ArmActionType",
  "csharp"
);
@@clientName(HealthReportsAPI.status, "HealthReportStatus", "csharp");
@@clientName(AutomationsAPI.Operator.Equals, "EqualsValue", "csharp");
@@clientName(SubAssessmentsAPI.SecuritySubAssessmentProperties.id,
  "VulnerabilityId",
  "csharp"
);

// C# resource type names: preserve previous GA resource, collection, extension,
// and mocking surfaces.
@@clientName(IoTSecurityAPI.IoTSecuritySolutionModel,
  "IotSecuritySolution",
  "csharp"
);
@@clientName(IoTSecurityAPI.IoTSecurityAggregatedAlert,
  "IotSecurityAggregatedAlert",
  "csharp"
);
@@clientName(IoTSecurityAPI.IoTSecurityAggregatedRecommendation,
  "IotSecurityAggregatedRecommendation",
  "csharp"
);
@@clientName(AlertsAPI.Alert, "SecurityAlert", "csharp");
@@clientName(AlertsAPI.AlertSimulatorRequestBody,
  "SecurityAlertSimulatorContent",
  "csharp"
);
@@clientName(SecureScoreAPI.SecureScoreItem, "SecureScore", "csharp");
@@clientName(AlertsSuppressionRulesAPI.AlertsSuppressionRule,
  "SecurityAlertsSuppressionRule",
  "csharp"
);
@@clientName(AssessmentAPI.SecurityAssessment,
  "SecurityAssessmentGenerated",
  "csharp"
);
@@clientName(AssessmentAPI.SecurityAssessmentResponse,
  "SecurityAssessment",
  "csharp"
);
@@clientName(AutomationsAPI.Automation, "SecurityAutomation", "csharp");
@@clientName(LocationsAPI.AscLocation, "SecurityCenterLocation", "csharp");
@@clientName(PricingsAPI.Pricing, "SecurityCenterPricing", "csharp");
@@clientName(LegacySettingsAPI.Compliance, "SecurityCompliance", "csharp");
@@clientName(ApplicationsAPI.Application,
  "SecurityConnectorApplication",
  "csharp"
);
@@clientName(GovernanceAPI.GovernanceRule,
  "SecurityConnectorGovernanceRule",
  "csharp"
);
@@clientName(SettingsAPI.Setting, "SecuritySetting", "csharp");
@@clientName(LegacySettingsAPI.WorkspaceSetting,
  "SecurityWorkspaceSetting",
  "csharp"
);
@@clientName(AssessmentAPI.SecurityAssessmentMetadata,
  "SecurityAssessmentMetadataGenerated",
  "csharp"
);
@@clientName(AssessmentAPI.SecurityAssessmentMetadataResponse,
  "SecurityAssessmentMetadata",
  "csharp"
);
@@clientName(SqlVulnerabilityAssessmentsAPI.RuleResults,
  "SqlVulnerabilityAssessmentBaselineRule",
  "csharp"
);
@@clientName(SqlVulnerabilityAssessmentsAPI.ScanV2,
  "SqlVulnerabilityAssessmentScan",
  "csharp"
);
@@clientName(AssessmentAPI.Categories,
  "SecurityAssessmentResourceCategory",
  "csharp"
);
@@clientName(Common.Severity, "SecurityAssessmentSeverity", "csharp");
@@clientName(AssessmentAPI.UserImpact,
  "SecurityAssessmentUserImpact",
  "csharp"
);
@@clientName(AssessmentAPI.Threats, "SecurityThreat", "csharp");
@@clientName(AssessmentAPI.AssessmentType, "SecurityAssessmentType", "csharp");
@@clientName(AssessmentAPI.SecurityAssessmentMetadataPartnerData,
  "SecurityAssessmentMetadataPartner",
  "csharp"
);
@@clientName(IoTSecurityAPI.ValueType, "SecurityValueType", "csharp");
@@clientName(SecuritySolutionsAPI.Protocol,
  "JitNetworkAccessPortProtocol",
  "csharp"
);

@@clientName(SecuritySolutionsAPI.Status,
  "JitNetworkAccessPortStatus",
  "csharp"
);
@@clientName(SecuritySolutionsAPI.StatusReason,
  "JitNetworkAccessPortStatusReason",
  "csharp"
);

// C# scalar type mappings.
@@alternateType(SecuritySolutionsAPI.JitNetworkAccessPortRule.maxRequestAccessDuration,
  duration,
  "csharp"
);

// C# model and enum names.
@@clientName(SubAssessmentsAPI.CVSS, "SecurityCvss", "csharp");
@@clientName(SubAssessmentsAPI.CVE, "SecurityCve", "csharp");
@@clientName(SqlVulnerabilityAssessmentsAPI.Baseline,
  "SqlVulnerabilityAssessmentBaseline",
  "csharp"
);
@@clientName(SqlVulnerabilityAssessmentsAPI.RuleStatus,
  "SqlVulnerabilityAssessmentScanResultRuleStatus",
  "csharp"
);
@@clientName(SqlVulnerabilityAssessmentsAPI.ScanPropertiesV2,
  "SqlVulnerabilityAssessmentScanProperties",
  "csharp"
);
@@clientName(Common.State, "SecurityAlertNotificationByRoleState", "csharp");
@@clientName(AutomationsAPI.SecurityContactRole,
  "SecurityAlertReceivingRole",
  "csharp"
);
@@clientName(SecurityConnectorsAPI.DefenderForServersAwsOfferingVaAutoProvisioning,
  "DefenderForServersAwsOfferingVulnerabilityAssessmentAutoProvisioning",
  "csharp"
);
@@clientName(SecurityConnectorsAPI.DefenderForServersGcpOfferingDefenderForServers,
  "GcpDefenderForServersInfo",
  "csharp"
);
@@clientName(SecurityConnectorsAPI.DefenderForDatabasesGcpOfferingDefenderForDatabasesArcAutoProvisioning,
  "GcpDefenderForDatabasesArcAutoProvisioning",
  "csharp"
);
@@clientName(IoTSecurityAPI.RecommendationType,
  "IotSecurityRecommendationType",
  "csharp"
);
@@clientName(SqlVulnerabilityAssessmentsAPI.ScanTriggerType,
  "SqlVulnerabilityAssessmentScanTriggerType",
  "csharp"
);
@@clientName(SqlVulnerabilityAssessmentsAPI.ScanState,
  "SqlVulnerabilityAssessmentScanState",
  "csharp"
);
@@clientName(AlertsSuppressionRulesAPI.ScopeElement,
  "SuppressionAlertsScopeElement",
  "csharp"
);

// C# operation names and operations intentionally excluded from generation.
@@clientName(SecuritySolutionsAPI.DiscoveredSecuritySolutionsOperationGroup.list,
  "GetDiscoveredSecuritySolutions",
  "csharp"
);
@@scope(SecuritySolutionsAPI.DiscoveredSecuritySolutionsOperationGroup.list,
  "!csharp"
);
@@clientName(SecuritySolutionsAPI.ExternalSecuritySolutionsOperationGroup.list,
  "GetExternalSecuritySolutions",
  "csharp"
);
@@scope(SecuritySolutionsAPI.ExternalSecuritySolutionsOperationGroup.list,
  "!csharp"
);
@@clientName(SecuritySolutionsAPI.JitNetworkAccessPoliciesOperationGroup.list,
  "GetJitNetworkAccessPolicies",
  "csharp"
);
@@scope(SecuritySolutionsAPI.JitNetworkAccessPoliciesOperationGroup.list,
  "!csharp"
);
@@clientName(SecuritySolutionsAPI.JitNetworkAccessPoliciesOperationGroup.listByResourceGroup,
  "GetJitNetworkAccessPolicies",
  "csharp"
);
@@scope(SecuritySolutionsAPI.JitNetworkAccessPoliciesOperationGroup.listByResourceGroup,
  "!csharp"
);
@@clientName(SecuritySolutionsAPI.SecuritySolutionsOperationGroup.list,
  "GetSecuritySolutions",
  "csharp"
);
@@scope(SecuritySolutionsAPI.SecuritySolutionsOperationGroup.list, "!csharp");
@@clientName(SecuritySolutionsAPI.SecuritySolutionsReferenceDataOperationGroup.list,
  "GetSecuritySolutionsReferenceData",
  "csharp"
);
@@clientName(SecuritySolutionsAPI.AllowedConnectionsOperationGroup.list,
  "GetAllowedConnections",
  "csharp"
);
@@scope(SecuritySolutionsAPI.AllowedConnectionsOperationGroup.list, "!csharp");
@@clientName(MdeOnboardingAPI.MdeOnboardings.list,
  "GetMdeOnboardings",
  "csharp"
);
@@scope(MdeOnboardingAPI.MdeOnboardings.list, "!csharp");
@@clientName(SecureScoreAPI.SecureScoreControlDefinitionsOperationGroup.list,
  "GetSecureScoreControlDefinitions",
  "csharp"
);
@@clientName(SecureScoreAPI.SecureScoreControlDefinitionsOperationGroup.listBySubscription,
  "GetSecureScoreControlDefinitionsBySubscription",
  "csharp"
);
@@clientName(SensitivitySettingsAPI.GetSensitivitySettingsResponses.list,
  "GetSensitivitySettings",
  "csharp"
);
@@clientName(SensitivitySettingsAPI.GetSensitivitySettingsListResponse,
  "SensitivitySettingsListResult",
  "csharp"
);
@@clientName(SecuritySolutionsAPI.TopologyOperationGroup.list,
  "GetTopologies",
  "csharp"
);
@@scope(SecuritySolutionsAPI.TopologyOperationGroup.list, "!csharp");
@@clientName(ApiCollectionsAPI.ApiCollectionsOperationGroup.listByResourceGroup,
  "GetApiCollections",
  "csharp"
);
@@clientName(OperationsAPI.OperationResultsOperationGroup.get,
  "GetOperationResult",
  "csharp"
);
@@clientName(OperationsAPI.OperationStatusesOperationGroup.get,
  "GetOperationStatus",
  "csharp"
);
@@scope(OperationsAPI.OperationStatusesOperationGroup.get, "!csharp");
@@clientName(AlertsAPI.Alerts.updateSubscriptionLevelStateToActivate,
  "Activate",
  "csharp"
);
@@clientName(AlertsAPI.AlertOperationGroup.updateResourceGroupLevelStateToActivate,
  "Activate",
  "csharp"
);
@@clientName(AlertsAPI.Alerts.updateSubscriptionLevelStateToDismiss,
  "Dismiss",
  "csharp"
);
@@clientName(AlertsAPI.AlertOperationGroup.updateResourceGroupLevelStateToDismiss,
  "Dismiss",
  "csharp"
);
@@clientName(AlertsAPI.Alerts.updateSubscriptionLevelStateToResolve,
  "Resolve",
  "csharp"
);
@@clientName(AlertsAPI.AlertOperationGroup.updateResourceGroupLevelStateToResolve,
  "Resolve",
  "csharp"
);
@@clientName(AlertsAPI.Alerts.updateSubscriptionLevelStateToInProgress,
  "UpdateSatateToInProgress",
  "csharp"
);
@@clientName(AlertsAPI.AlertOperationGroup.updateResourceGroupLevelStateToInProgress,
  "UpdateSatateToInProgress",
  "csharp"
);
@@clientName(SecurityConnectorsDevOpsAPI.DevOpsConfigurations.listAvailable,
  "GetAvailableAzureDevOpsOrganizations",
  "csharp"
);
@@clientName(SecurityConnectorsDevOpsAPI.DevOpsConfigurations.gitHubOwnersListAvailable,
  "GetAvailableGitHubOwners",
  "csharp"
);
@@clientName(SecurityConnectorsDevOpsAPI.DevOpsConfigurations.gitLabGroupsListAvailable,
  "GetAvailableGitLabGroups",
  "csharp"
);

// C# legacy resource hierarchy customizations.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change the base type back to TrackedResourceData for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(IoTSecurityAPI.IoTSecuritySolutionModel,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change the base type back to TrackedResourceData for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(AutomationsAPI.Automation,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change the base type back to TrackedResourceData for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(SecurityConnectorsAPI.SecurityConnector,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);

// C# compatibility replacement: @@hierarchyBuilding currently crashes the
// management generator for these legacy custom-resource shapes, so use
// @@alternateType against replacement models that carry the desired hierarchy.
model CSharpExternalSecuritySolutionReplacement
  extends Azure.ResourceManager.Foundations.Resource {
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Matches the original legacy custom resource shape."
  properties?: unknown;
  kind?: SecuritySolutionsAPI.ExternalSecuritySolutionKind;

  @visibility(Lifecycle.Read)
  location?: azureLocation;
}

// C# compatibility replacement: @@hierarchyBuilding currently crashes the
// management generator for these derived models, so use @@alternateType to keep
// the GA inheritance chain through ExternalSecuritySolution.
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Replacement model for C# compatibility because @@hierarchyBuilding currently crashes the management generator for this shape."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Matches the original legacy custom resource shape."
model CSharpCefExternalSecuritySolutionReplacement
  extends CSharpExternalSecuritySolutionReplacement {
  properties?: SecuritySolutionsAPI.CefSolutionProperties;
  kind: "CEF";
}

// C# compatibility replacement: @@hierarchyBuilding currently crashes the
// management generator for these derived models, so use @@alternateType to keep
// the GA inheritance chain through ExternalSecuritySolution.
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Replacement model for C# compatibility because @@hierarchyBuilding currently crashes the management generator for this shape."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Matches the original legacy custom resource shape."
model CSharpAtaExternalSecuritySolutionReplacement
  extends CSharpExternalSecuritySolutionReplacement {
  properties?: SecuritySolutionsAPI.AtaSolutionProperties;
  kind: "ATA";
}

// C# compatibility replacement: @@hierarchyBuilding currently crashes the
// management generator for these derived models, so use @@alternateType to keep
// the GA inheritance chain through ExternalSecuritySolution.
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Replacement model for C# compatibility because @@hierarchyBuilding currently crashes the management generator for this shape."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Matches the original legacy custom resource shape."
model CSharpAadExternalSecuritySolutionReplacement
  extends CSharpExternalSecuritySolutionReplacement {
  properties?: SecuritySolutionsAPI.AadSolutionProperties;
  kind: "AAD";
}

// C# compatibility replacement: @@hierarchyBuilding currently crashes the
// management generator for this flattened resource-like model, so use
// @@alternateType against a replacement model with a TrackedResource base.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Replacement model for C# compatibility because @@hierarchyBuilding currently crashes the management generator for this shape."
#suppress "@azure-tools/typespec-azure-core/casing-style" "Matches the original service-defined shape."
model CSharpSecuritySolutionsReferenceDataReplacement
  extends Azure.ResourceManager.Foundations.Resource {
  ...SecuritySolutionsAPI.Location;
  properties: SecuritySolutionsAPI.securitySolutionsReferenceDataProperties;
}

// C# compatibility replacement: keep the GA property name FirstEvaluatedOn while
// preserving the service wire name firstEvaluationDate.
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Replacement model preserves the legacy .NET model hierarchy and property names."
model CSharpSecurityAssessmentStatusResult
  extends AssessmentAPI.AssessmentStatus {
  /**
   * The time that the assessment was created and first evaluated. Returned as UTC time in ISO 8601 format
   */
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "firstEvaluationDate")
  firstEvaluatedOn?: utcDateTime;

  /**
   * The time that the status of the assessment last changed. Returned as UTC time in ISO 8601 format
   */
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "statusChangeDate")
  statusChangeOn?: utcDateTime;
}

@@clientName(CSharpExternalSecuritySolutionReplacement,
  "ExternalSecuritySolution",
  "csharp"
);
@@clientName(CSharpCefExternalSecuritySolutionReplacement,
  "CefExternalSecuritySolution",
  "csharp"
);
@@clientName(CSharpAtaExternalSecuritySolutionReplacement,
  "AtaExternalSecuritySolution",
  "csharp"
);
@@clientName(CSharpAadExternalSecuritySolutionReplacement,
  "AadExternalSecuritySolution",
  "csharp"
);
@@clientName(CSharpSecuritySolutionsReferenceDataReplacement,
  "SecuritySolutionsReferenceData",
  "csharp"
);
@@clientName(CSharpSecurityAssessmentStatusResult,
  "SecurityAssessmentStatusResult",
  "csharp"
);
@@clientName(SecuritySolutionsAPI.ConnectableResource,
  "ConnectableResourceInfo",
  "csharp"
);
@@clientName(SecuritySolutionsAPI.ConnectedResource,
  "ConnectedResourceInfo",
  "csharp"
);
@@usage(CSharpSecurityAssessmentStatusResult,
  Azure.ClientGenerator.Core.Usage.input | Azure.ClientGenerator.Core.Usage.output,
  "csharp"
);
@@alternateType(SecuritySolutionsAPI.ConnectableResource.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(SecuritySolutionsAPI.ConnectedResource.connectedResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(AssessmentAPI.OnPremiseResourceDetailsProperties.vmuuid,
  uuid,
  "csharp"
);
@@alternateType(AssessmentAPI.AssessmentStatusResponse,
  CSharpSecurityAssessmentStatusResult,
  "csharp"
);
@@alternateType(SecuritySolutionsAPI.ExternalSecuritySolution,
  CSharpExternalSecuritySolutionReplacement,
  "csharp"
);
@@alternateType(SecuritySolutionsAPI.CefExternalSecuritySolution,
  CSharpCefExternalSecuritySolutionReplacement,
  "csharp"
);
@@alternateType(SecuritySolutionsAPI.AtaExternalSecuritySolution,
  CSharpAtaExternalSecuritySolutionReplacement,
  "csharp"
);
@@alternateType(SecuritySolutionsAPI.AadExternalSecuritySolution,
  CSharpAadExternalSecuritySolutionReplacement,
  "csharp"
);
@@alternateType(SecuritySolutionsAPI.securitySolutionsReferenceData,
  CSharpSecuritySolutionsReferenceDataReplacement,
  "csharp"
);
@@clientName(SecuritySolutionsAPI.ExternalSecuritySolutions.listByHomeRegion,
  "GetExternalSecuritySolutionsByHomeRegion",
  "csharp"
);

// C# model and enum names.
@@clientName(AutomationsAPI.AutomationValidationStatus,
  "SecurityAutomationValidationStatus",
  "csharp"
);
@@clientName(AutomationsAPI.AutomationUpdateModel,
  "SecurityAutomationPatch",
  "csharp"
);
@@clientName(Common.Tags, "SecurityCenterPatchTags", "csharp");
@@clientName(AssessmentAPI.AssessmentStatus,
  "SecurityAssessmentStatus",
  "csharp"
);
@@clientName(AssessmentAPI.AssessmentStatusCode,
  "SecurityAssessmentStatusCode",
  "csharp"
);
@@clientName(ComplianceResultsAPI.ResourceStatus,
  "SecurityAssessmentResourceStatus",
  "csharp"
);
@@clientName(SecurityStandardsAPI.SeverityEnum,
  "CustomRecommendationSeverity",
  "csharp"
);
@@clientName(SecurityStandardsAPI.SecurityIssue,
  "CustomRecommendationSecurityIssue",
  "csharp"
);
@@clientName(AssessmentAPI.SecurityAssessmentMetadataPropertiesResponse,
  "SecurityAssessmentMetadataPropertiesResult",
  "csharp"
);
@@clientName(AssessmentAPI.SecurityAssessmentMetadataPropertiesResponsePublishDates,
  "SecurityAssessmentPublishDates",
  "csharp"
);
@@clientName(AssessmentAPI.SecurityAssessmentPartnerData,
  "SecurityAssessmentPartnerInfo",
  "csharp"
);
@@clientName(SecurityConnectorsDevOpsAPI.AzureDevOpsOrgListResponse,
  "AzureDevOpsOrgListResult",
  "csharp"
);
@@clientName(SecurityConnectorsDevOpsAPI.GitHubOwnerListResponse,
  "GitHubOwnerListResult",
  "csharp"
);
@@clientName(SecurityConnectorsDevOpsAPI.GitLabGroupListResponse,
  "GitLabGroupListResult",
  "csharp"
);
@@clientName(SecurityConnectorsDevOpsAPI.IssueCreationRequest,
  "IssueCreationContent",
  "csharp"
);
@@clientName(SecuritySolutionsAPI.JitNetworkAccessPolicyInitiateRequest,
  "JitNetworkAccessPolicyInitiateContent",
  "csharp"
);
@@clientName(SecuritySolutionsAPI.JitNetworkAccessRequest,
  "JitNetworkAccessContent",
  "csharp"
);
@@clientName(TasksAPI.SecurityTaskProperties,
  "SecurityTaskPropertiesGenerated",
  "csharp"
);
@@clientName(TasksAPI.SecurityTaskParameters,
  "SecurityTaskProperties",
  "csharp"
);
@@clientName(SensitivitySettingsAPI.UpdateSensitivitySettingsRequest,
  "UpdateSensitivitySettingsContent",
  "csharp"
);
@@clientName(SecurityConnectorsAPI.EnvironmentData,
  "SecurityConnectorEnvironmentInfo",
  "csharp"
);
@@clientName(SecurityConnectorsAPI.AwsEnvironmentData,
  "AwsEnvironmentInfo",
  "csharp"
);
@@clientName(SecurityConnectorsAPI.GcpOrganizationalData,
  "GcpOrganizationalInfo",
  "csharp"
);
@@clientName(SecurityConnectorsAPI.GcpProjectEnvironmentData,
  "GcpProjectEnvironmentInfo",
  "csharp"
);
@@clientName(SecurityConnectorsAPI.GithubScopeEnvironmentData,
  "GithubScopeEnvironmentInfo",
  "csharp"
);
@@clientName(SecurityConnectorsAPI.AzureDevOpsScopeEnvironmentData,
  "AzureDevOpsScopeEnvironmentInfo",
  "csharp"
);
@@clientName(SecurityConnectorsAPI.GitlabScopeEnvironmentData,
  "GitlabScopeEnvironmentInfo",
  "csharp"
);
@@clientName(SecurityConnectorsAPI.DockerHubEnvironmentData,
  "DockerHubEnvironmentInfo",
  "csharp"
);
@@clientName(SecurityConnectorsAPI.JFrogEnvironmentData,
  "JFrogEnvironmentInfo",
  "csharp"
);
@@clientName(GovernanceAPI.GovernanceAssignmentAdditionalData,
  "GovernanceAssignmentAdditionalInfo",
  "csharp"
);
@@clientName(SecurityStandardsAPI.StandardAssignmentPropertiesExemptionData,
  "StandardAssignmentExemptionInfo",
  "csharp"
);
@@clientName(SecurityStandardsAPI.StandardAssignmentPropertiesAttestationData,
  "StandardAssignmentAttestationInfo",
  "csharp"
);

// C# property and parameter names.
@@clientName(TasksAPI.SecurityTaskParameters.name, "TaskName", "csharp");
@@clientName(TasksAPI.SecurityTaskProperties.creationTimeUtc,
  "CreatedOn",
  "csharp"
);
@@clientName(TasksAPI.SecurityTaskProperties.lastStateChangeTimeUtc,
  "LastStateChangedOn",
  "csharp"
);
@@clientName(SecuritySolutionsAPI.ExternalSecuritySolution,
  "ExternalSecuritySolution",
  "csharp"
);
@@clientName(SecurityConnectorsAPI.cloudOffering,
  "SecurityCenterCloudOffering",
  "csharp"
);
@@clientName(SecurityConnectorsAPI.AwsOrganizationalData,
  "AwsOrganizationalInfo",
  "csharp"
);
@@clientName(Common.ResourceDetails, "SecurityCenterResourceDetails", "csharp");
@@clientName(AlertsAPI.ResourceIdentifier,
  "SecurityAlertResourceIdentifier",
  "csharp"
);
@@clientName(AlertsAPI.AlertSeverity, "SecurityAlertSeverity", "csharp");
@@clientName(AlertsAPI.Intent, "KillChainIntent", "csharp");
@@clientName(AlertsAPI.AlertStatus, "SecurityAlertStatus", "csharp");
@@clientName(AlertsAPI.AlertEntity, "SecurityAlertEntity", "csharp");
@@clientName(AlertsAPI.AlertPropertiesSupportingEvidence,
  "SecurityAlertSupportingEvidence",
  "csharp"
);
@@clientName(AlertsAPI.AlertEntity.type, "AlertEntityType", "csharp");
@@clientName(AlertsAPI.AlertPropertiesSupportingEvidence.type,
  "SecurityAlertSupportingEvidenceType",
  "csharp"
);
@@clientName(AlertsAPI.AlertSimulatorRequestProperties,
  "SecurityAlertSimulatorRequestProperties",
  "csharp"
);
@@usage(AlertsAPI.AlertPropertiesSupportingEvidence, Usage.input, "csharp");
@@clientName(AlertsAPI.AlertProperties.startTimeUtc, "StartOn", "csharp");
@@clientName(AlertsAPI.AlertProperties.endTimeUtc, "EndOn", "csharp");
@@clientName(AlertsAPI.AlertProperties.timeGeneratedUtc,
  "GeneratedOn",
  "csharp"
);
@@clientName(AlertsAPI.AlertProperties.processingEndTimeUtc,
  "ProcessingEndOn",
  "csharp"
);
@@alternateType(AlertsAPI.AlertProperties.alertUri, url, "csharp");
@@clientName(AssessmentAPI.SecurityAssessmentMetadataProperties.preview,
  "IsPreview",
  "csharp"
);
@@clientName(AssessmentAPI.Tactics, "SecurityAssessmentTactic", "csharp");
@@clientName(AssessmentAPI.Techniques, "SecurityAssessmentTechnique", "csharp");
@@clientName(SubAssessmentsAPI.AdditionalData,
  "SecuritySubAssessmentAdditionalInfo",
  "csharp"
);
@@clientName(IoTSecurityAPI.TagsResource,
  "SecurityCenterTagsResourceInfo",
  "csharp"
);

// C# pageable operation customizations.
@@markAsPageable(PricingsAPI.Pricings.list, "csharp");

// Other language customizations.
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnection,
  "ArmPrivateEndpointConnection",
  "python"
);
@@clientName(Azure.ResourceManager.CommonTypes.ActionType,
  "ArmActionType",
  "python,javascript"
);
@@clientName(AadConnectivityState, "AadConnectivityStateEnum", "python");
@@clientName(ExternalSecuritySolutionKind,
  "ExternalSecuritySolutionKindEnum",
  "python"
);
@@clientName(Protocol, "ProtocolEnum", "python");
@@clientName(AlertsAPI.Kind, "KindEnum", "python");
@@clientName(OperationResultStatus, "OperationResult", "python");
@@clientName(OperationResult, "OperationResultAutoGenerated", "python");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "To mitigate breaking change for legacy Python SDK"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(AdvancedThreatProtectionSettingNameAlias.settingName,
  "current",
  "python"
);
@@Azure.ClientGenerator.Core.alternateType(AdvancedThreatProtectionSettingNameAlias.settingName,
  "current"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "To mitigate breaking change for legacy Python SDK"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(JitNetworkAccessPolicyInitiateTypeAlias.jitNetworkAccessPolicyInitiateType,
  "initiate",
  "python"
);
@@Azure.ClientGenerator.Core.alternateType(JitNetworkAccessPolicyInitiateTypeAlias.jitNetworkAccessPolicyInitiateType,
  "initiate"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "To mitigate breaking change for legacy Python SDK"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(ServerVulnerabilityAssessmentNameAlias.serverVulnerabilityAssessment,
  "default",
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The enum is made closed for .NET SDK in order to recognize the corresponding resource a singleton"
@clientName("ServerVulnerabilityAssessmentName", "csharp")
union CSharpServerVulnerabilityAssessmentName {
  /** Default. */
  Default: "default",
}

@@Azure.ClientGenerator.Core.alternateType(ServerVulnerabilityAssessmentName,
  CSharpServerVulnerabilityAssessmentName,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op sqlVulnerabilityAssessmentScansGet(
  ...ApiVersionParameter,

  @path
  providerNamespace: "Microsoft.Security",

  @path
  sqlVulnerabilityAssessment: "default",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  scanId: string,

  @query
  databaseName?: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  resourceId: string,
): ArmResponse<ScanV2> | Common.CloudError;

@@override(ScanV2s.get, sqlVulnerabilityAssessmentScansGet);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op sqlVulnerabilityAssessmentScanResultsList(
  ...ApiVersionParameter,

  @path
  providerNamespace: "Microsoft.Security",

  @path
  sqlVulnerabilityAssessment: "default",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  scanId: string,

  @query
  databaseName?: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  resourceId: string,
): ArmResponse<ScanResults> | Common.CloudError;

@@override(SqlVulnerabilityAssessmentScanResults.list,
  sqlVulnerabilityAssessmentScanResultsList
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op sqlVulnerabilityAssessmentScanResultsGet(
  ...ApiVersionParameter,

  @path
  providerNamespace: "Microsoft.Security",

  @path
  sqlVulnerabilityAssessment: "default",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  scanId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  scanResultId: string,

  @query
  databaseName?: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  resourceId: string,
): ArmResponse<ScanResult> | Common.CloudError;

@@override(SqlVulnerabilityAssessmentScanResults.get,
  sqlVulnerabilityAssessmentScanResultsGet
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op alertsListResourceGroupLevelByRegionCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  /** The location where ASC stores the data of the subscription. can be retrieved from Get locations */
  @path
  @segment("locations")
  ascLocation: string,

  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
): ArmResponse<AlertList> | ErrorResponse;

@@override(AlertOperationGroup.listResourceGroupLevelByRegion,
  alertsListResourceGroupLevelByRegionCustomized,
  "python,go,java"
);

@@alternateType(Azure.ResourceManager.CommonTypes.Identity.type,
  "SystemAssigned",
  "go"
);

@@clientName(HealthReportsAPI.resourceDetails,
  "HealthReportResourceDetails",
  "java,go"
);
@@clientLocation(ApiCollections.getByAzureApiManagementService,
  "ApiCollections",
  "java"
);
@@clientLocation(ApiCollections.onboardAzureApiManagementApi,
  "ApiCollections",
  "java"
);
@@clientLocation(ApiCollections.offboardAzureApiManagementApi,
  "ApiCollections",
  "java"
);
@@clientLocation(ApiCollections.listByAzureApiManagementService,
  "ApiCollections",
  "java"
);
@@clientLocation(ApiCollections.listBySubscription, "ApiCollections", "java");
@@clientLocation(ApiCollectionsOperationGroup.listByResourceGroup,
  "ApiCollections",
  "java"
);

@@clientName(SecurityManagementClient, "SecurityCenter", "java");
@@clientName(SubAssessmentsAPI.CVSS, "Cvss", "java");
@@clientName(SecurityAssessmentPropertiesBaseRiskPathsItemEdgeItem,
  "SecurityAssessmentPropertiesBaseRiskPathsItemEdge",
  "java"
);
@@clientName(SecurityAssessmentPropertiesBaseRiskPathsItemNodesItem,
  "SecurityAssessmentPropertiesBaseRiskPathsPropertiesItemsItem",
  "java"
);
@@clientLocation(ApplicationsAPI.SecurityConnectorApplication.get,
  "SecurityConnectorApplications",
  "java"
);
@@clientLocation(ApplicationsAPI.SecurityConnectorApplication.createOrUpdate,
  "SecurityConnectorApplications",
  "java"
);
@@clientLocation(ApplicationsAPI.SecurityConnectorApplication.delete,
  "SecurityConnectorApplications",
  "java"
);
@@clientLocation(ApplicationsAPI.SecurityConnectorApplication.list,
  "SecurityConnectorApplications",
  "java"
);
@@clientName(HealthReportsAPI.status, "HealthReportStatus", "java,go");
@@clientName(SecuritySolutionsAPI.Status, "Status", "java");

// JavaScript SDK visibility workaround for jitNetworkAccessPoliciesCreateOrUpdate:
// JitNetworkAccessPolicy contains server-side read-only properties (location, provisioningState)
// that conflict with visibility/required. These write-specific models omit those fields.
// Pattern: https://github.com/Azure/azure-rest-api-specs/pull/40791

/**
 * JIT network access policy properties for create/update operations.
 * Omits server-side read-only field: provisioningState.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Write-specific model"
model JitNetworkAccessPolicyPropertiesCreate {
  /**
   * Configurations for Microsoft.Compute/virtualMachines resource type.
   */
  virtualMachines: JitNetworkAccessPolicyVirtualMachine[];

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Write-specific model"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Write-specific model"
  requests?: JitNetworkAccessRequest[];
}

/**
 * JIT network access policy resource for create/update operations.
 * Omits server-side read-only fields: location, provisioningState.
 */
model JitNetworkAccessPolicyCreate {
  /**
   * Kind of the resource
   */
  kind?: string;

  /**
   * Properties of the JIT network access policy
   */
  properties: JitNetworkAccessPolicyPropertiesCreate;
}

@@alternateType(JitNetworkAccessPolicies.createOrUpdate::parameters.resource,
  JitNetworkAccessPolicyCreate,
  "javascript"
);
