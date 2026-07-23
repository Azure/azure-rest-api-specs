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
import "./csharp-arm-models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "@typespec/versioning";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using TypeSpec.Versioning;
using Http;
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
using IoTSecurityAPI;
using SecurityConnectorsAPI;
using StandardsAPI;

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

/**
 * A private link resource name parameter.
 */
model PrivateLinkNameParameter {
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
  ...PrivateLinkNameParameter,
): ArmResponse<PrivateLinksAPI.PrivateLinkResource> | ErrorResponse;

@@Azure.ClientGenerator.Core.override(
  PrivateLinkResources.get,
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
  ...PrivateLinkNameParameter,
  resource: PrivateLinksAPI.PrivateLinkResource,
):
  | ArmResourceUpdatedResponse<PrivateLinksAPI.PrivateLinkResource>
  | ArmResourceCreatedResponse<
      PrivateLinksAPI.PrivateLinkResource,
      ArmAsyncOperationHeader<FinalResult = PrivateLinksAPI.PrivateLinkResource> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  | ErrorResponse;

@@clientName(
  privateLinksCreateCustomization::parameters.resource,
  "privateLink"
);
@@Azure.ClientGenerator.Core.override(
  PrivateLinkResources.create,
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
  ...PrivateLinkNameParameter,
  properties: PrivateLinksAPI.PrivateLinkUpdate,
): ArmResponse<PrivateLinksAPI.PrivateLinkResource> | ErrorResponse;

@@clientName(
  privateLinksUpdateCustomization::parameters.properties,
  "privateLink"
);
@@Azure.ClientGenerator.Core.override(
  PrivateLinkResources.update,
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
  ...PrivateLinkNameParameter,
):
  | ArmDeleteAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>
  | ArmDeletedNoContentResponse
  | ErrorResponse;

@@Azure.ClientGenerator.Core.override(
  PrivateLinkResources.delete,
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
  ...PrivateLinkNameParameter,
): OkResponse | ErrorResponse;

@@Azure.ClientGenerator.Core.override(
  PrivateLinkResources.head,
  privateLinksHeadCustomization,
  "!python,!java,!javascript"
);

@@clientName(
  defenderFoDatabasesAwsOffering,
  "DefenderForDatabasesAwsOffering",
  "csharp"
);
@@clientName(
  DefenderFoDatabasesAwsOfferingArcAutoProvisioning,
  "DefenderForDatabasesAwsOfferingArcAutoProvisioning",
  "csharp"
);
@@clientName(
  DefenderFoDatabasesAwsOfferingRds,
  "DefenderForDatabasesAwsOfferingRds",
  "csharp"
);
@@clientName(
  DefenderFoDatabasesAwsOfferingDatabasesDspm,
  "DefenderForDatabasesAwsOfferingDatabasesDspm",
  "csharp"
);
@@access(DefenderFoDatabasesAwsOfferingDatabasesDspm, Access.public, "csharp");

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op privateEndpointConnectionsListCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ...PrivateLinkNameParameter,
):
  | ArmResponse<ResourceListResult<PrivateLinksAPI.PrivateEndpointConnection>>
  | ErrorResponse;

@@Azure.ClientGenerator.Core.override(
  PrivateEndpointConnections.list,
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
  ...PrivateLinkNameParameter,

  @path
  privateEndpointConnectionName: string,
): ArmResponse<Azure.ResourceManager.PrivateEndpointConnection> | ErrorResponse;

@@Azure.ClientGenerator.Core.override(
  PrivateEndpointConnections.get,
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
  ...PrivateLinkNameParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  privateEndpointConnectionName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource: PrivateLinksAPI.PrivateEndpointConnection,
):
  | ArmResourceUpdatedResponse<PrivateLinksAPI.PrivateLinkResource>
  | ArmResourceCreatedResponse<
      PrivateLinksAPI.PrivateLinkResource,
      ArmAsyncOperationHeader<FinalResult = PrivateLinksAPI.PrivateLinkResource> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  | ErrorResponse;

@@Azure.ClientGenerator.Core.override(
  PrivateEndpointConnections.createOrUpdate,
  privateEndpointConnectionsCreateOrUpdateCustomization,
  "!python,!java,!javascript"
);
@@clientName(
  privateEndpointConnectionsCreateOrUpdateCustomization::parameters.resource,
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
  ...PrivateLinkNameParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  privateEndpointConnectionName: string,
):
  | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>
  | ArmDeletedNoContentResponse
  | ErrorResponse;

@@Azure.ClientGenerator.Core.override(
  PrivateEndpointConnections.delete,
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
  ...PrivateLinkNameParameter,
): ArmResponse<ResourceListResult<PrivateLinkGroupResource>> | ErrorResponse;

@@Azure.ClientGenerator.Core.override(
  PrivateLinkGroupResources.list,
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
  ...PrivateLinkNameParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  groupId: string,
): ArmResponse<PrivateLinkGroupResource> | ErrorResponse;

@@Azure.ClientGenerator.Core.override(
  PrivateLinkGroupResources.get,
  privateLinkResourcesGetCustomization,
  "!python,!java,!javascript"
);
@@clientName(
  SecurityStandardsAPI.SecurityStandard,
  "ArmSecurityStandard",
  "go"
);
@@clientName(SecurityOperatorsAPI.SecurityOperator, "OperatorResource", "go");
@@clientLocation(
  SecurityStandards.createOrUpdate,
  "ArmSecurityStandards",
  "go"
);
@@clientLocation(SecurityStandards.get, "ArmSecurityStandards", "go");
@@clientLocation(SecurityStandards.delete, "ArmSecurityStandards", "go");
@@clientLocation(SecurityStandards.list, "ArmSecurityStandards", "go");
@@clientName(
  SecurityStandardsAPI.SecurityStandardProperties,
  "ArmSecurityStandardProperties",
  "go"
);
@@usage(
  IoTSecurityAPI.CustomAlertRule,
  Usage.input | Usage.output,
  "go,javascript,csharp"
);

@@clientName(
  Azure.ResourceManager.CommonTypes.ErrorAdditionalInfo,
  "ArmErrorAdditionalInfo",
  "java"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.PrivateEndpointConnection,
  "ArmPrivateEndpointConnection",
  "java,javascript,go"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.ActionType,
  "ArmActionType",
  "java,go"
);
@@clientName(StandardsAPI.StandardList, "ArmSecurityStandardList", "go");

@@clientName(
  IoTSecurityAPI.RecommendationType.IoT_ACRAuthentication,
  "IoTAcrauthentication",
  "javascript,go"
);
@@clientName(
  IoTSecurityAPI.RecommendationType.IoT_IPFilter_DenyAll,
  "IoTIpfilterDenyAll",
  "javascript,go"
);
@@clientName(
  IoTSecurityAPI.RecommendationType.IoT_IPFilter_PermissiveRule,
  "IoTIpfilterPermissiveRule",
  "javascript,go"
);
@@clientName(SubAssessmentsAPI.CVE, "Cve", "javascript,java");

@@clientName(
  SecurityConnectorsAPI.DefenderCspmAwsOfferingCiemCiemDiscovery,
  "DefenderCspmAwsOfferingCiemDiscovery",
  "go,javascript,python,java"
);

@@clientName(
  SecurityConnectorsAPI.DefenderCspmAwsOfferingCiemCiemOidc,
  "DefenderCspmAwsOfferingCiemOidc",
  "go,javascript,python,java"
);

@@clientName(Common.ResourceDetails, "CommonResourceDetails", "python");
@@clientName(HealthReportsAPI.status, "StatusAutoGenerated", "python");

// C# compatibility customizations are grouped by purpose.

// C# client names.
@@clientName(
  Azure.ResourceManager.CommonTypes.PrivateEndpointConnection,
  "ArmPrivateEndpointConnection",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.ActionType,
  "ArmActionType",
  "csharp"
);
@@clientName(HealthReportsAPI.status, "HealthReportStatus", "csharp");
@@clientName(AutomationsAPI.Operator.Equals, "EqualsValue", "csharp");
@@clientName(LegacySettingsAPI.AutoProvision, "AutoProvisionState", "csharp");
@@clientName(
  AssessmentAPI.ExpandEnum,
  "SecurityAssessmentODataExpand",
  "csharp"
);
@@clientName(
  AutomationsAPI.MinimalSeverity,
  "SecurityAlertMinimalSeverity",
  "csharp"
);
@@clientName(
  SecureScoreAPI.ExpandControlsEnum,
  "SecurityScoreODataExpand",
  "csharp"
);
@@clientName(
  SecurityConnectorsAPI.Type,
  "VulnerabilityAssessmentAutoProvisioningType",
  "csharp"
);
@@clientName(
  SecurityConnectorsAPI.ArcAutoProvisioningConfiguration,
  "DefenderForDatabasesAwsOfferingArcAutoProvisioningConfiguration",
  "csharp"
);
@@clientName(
  SecurityConnectorsAPI.GcpOrganizationalDataMember,
  "GcpMemberOrganizationalInfo",
  "csharp"
);
@@clientName(
  SecurityConnectorsAPI.GcpOrganizationalDataOrganization,
  "GcpParentOrganizationalInfo",
  "csharp"
);
@@clientName(
  SqlVulnerabilityAssessmentsAPI.RuleType,
  "VulnerabilityAssessmentRuleType",
  "csharp"
);
@@clientName(
  SqlVulnerabilityAssessmentsAPI.Remediation,
  "SqlVulnerabilityAssessmentRemediation",
  "csharp"
);
@@clientName(
  SqlVulnerabilityAssessmentsAPI.VaRule,
  "VulnerabilityAssessmentRule",
  "csharp"
);
@@clientName(
  SqlVulnerabilityAssessmentsAPI.QueryCheck,
  "VulnerabilityAssessmentRuleQueryCheck",
  "csharp"
);
@@usage(
  SqlVulnerabilityAssessmentsAPI.ScanResultProperties,
  Usage.input,
  "csharp"
);
@@usage(SqlVulnerabilityAssessmentsAPI.Remediation, Usage.input, "csharp");
@@usage(SqlVulnerabilityAssessmentsAPI.VaRule, Usage.input, "csharp");
@@usage(SqlVulnerabilityAssessmentsAPI.QueryCheck, Usage.input, "csharp");
@@clientName(
  SqlVulnerabilityAssessmentsAPI.RulesResultsInput,
  "RulesResultsContent",
  "csharp"
);
@@clientName(SecurityConnectorsAPI.SubPlan, "AvailableSubPlanType", "csharp");
@@clientName(StandardsAPI.Assignment, "SecurityCenterAssignment", "csharp");
@@clientName(StandardsAPI.Standard, "SecurityCenterStandard", "csharp");
@@clientName(
  PrivateLinksAPI.PrivateLinkGroupResource,
  "PrivateLinkGroup",
  "csharp"
);
@@clientName(
  SubAssessmentsAPI.SecuritySubAssessmentProperties.id,
  "VulnerabilityId",
  "csharp"
);

@@clientName(
  IoTSecurityAPI.IoTSecuritySolutionModel,
  "IotSecuritySolution",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.IoTSecurityAggregatedAlert,
  "IotSecurityAggregatedAlert",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.IoTSecurityAggregatedRecommendation,
  "IotSecurityAggregatedRecommendation",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.IoTSecuritySolutionAnalyticsModel,
  "IotSecuritySolutionAnalyticsModel",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.IoTSecurityAggregatedAlertPropertiesTopDevicesListItem,
  "IotSecurityAggregatedAlertTopDevice",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.ExportData,
  "IotSecuritySolutionExportOption",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.DataSource,
  "IotSecuritySolutionDataSource",
  "csharp"
);
@@clientName(IoTSecurityAPI.IoTSeverityMetrics, "IotSeverityMetrics", "csharp");
@@clientName(
  IoTSecurityAPI.IoTSecuritySolutionAnalyticsModelPropertiesDevicesMetricsItem,
  "IotSecuritySolutionAnalyticsModelDevicesMetrics",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.IoTSecurityAlertedDevice,
  "IotSecurityAlertedDevice",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.IoTSecurityDeviceAlert,
  "IotSecurityDeviceAlert",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.IoTSecurityDeviceRecommendation,
  "IotSecurityDeviceRecommendation",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.ConnectionToIpNotAllowed,
  "ConnectionToIPNotAllowed",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.ConnectionFromIpNotAllowed,
  "ConnectionFromIPNotAllowed",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.UnmaskedIpLoggingStatus,
  "UnmaskedIPLoggingStatus",
  "csharp"
);
@@usage(
  SecuritySolutionsAPI.ServerVulnerabilityAssessment,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(
  ComplianceResultsAPI.ComplianceResult,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(
  IoTSecurityAPI.IoTSecurityAggregatedAlert,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(
  IoTSecurityAPI.IoTSecurityAggregatedRecommendation,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(
  IoTSecurityAPI.IoTSecuritySolutionAnalyticsModel,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(
  RegulatoryComplianceAPI.RegulatoryComplianceAssessment,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(
  RegulatoryComplianceAPI.RegulatoryComplianceControl,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(
  RegulatoryComplianceAPI.RegulatoryComplianceStandard,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(SecureScoreAPI.SecureScoreItem, Usage.input | Usage.output, "csharp");
@@usage(AlertsAPI.Alert, Usage.input | Usage.output, "csharp");
@@usage(LocationsAPI.AscLocation, Usage.input | Usage.output, "csharp");
@@usage(LegacySettingsAPI.Compliance, Usage.input | Usage.output, "csharp");
@@usage(
  SubAssessmentsAPI.SecuritySubAssessment,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(TasksAPI.SecurityTask, Usage.input | Usage.output, "csharp");
@@clientName(AlertsAPI.Alert, "SecurityAlert", "csharp");
@@clientName(
  AlertsAPI.AlertSimulatorRequestBody,
  "SecurityAlertSimulatorContent",
  "csharp"
);
@@clientName(SecureScoreAPI.SecureScoreItem, "SecureScore", "csharp");
@@clientName(
  AlertsSuppressionRulesAPI.AlertsSuppressionRule,
  "SecurityAlertsSuppressionRule",
  "csharp"
);
@@clientName(
  AlertsSuppressionRulesAPI.AlertsSuppressionRuleProperties.lastModifiedUtc,
  "LastModifiedOn",
  "csharp"
);
@@clientName(
  AlertsSuppressionRulesAPI.AlertsSuppressionRuleProperties.expirationDateUtc,
  "ExpireOn",
  "csharp"
);
@@clientName(
  AlertsSuppressionRulesAPI.RuleState,
  "SecurityAlertsSuppressionRuleState",
  "csharp"
);
@@clientName(
  AlertsSuppressionRulesAPI.SuppressionAlertsScope.allOf,
  "SuppressionAlertsScopeAllOf",
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required to preserve the existing C# flattened SecurityAlertsSuppressionRule shape."
@@flattenProperty(
  AlertsSuppressionRulesAPI.AlertsSuppressionRuleProperties.suppressionAlertsScope,
  "csharp"
);
@@clientName(
  AssessmentAPI.SecurityAssessment,
  "SecurityAssessmentCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  AssessmentAPI.SecurityAssessmentResponse,
  "SecurityAssessment",
  "csharp"
);
@@clientName(AutomationsAPI.Automation, "SecurityAutomation", "csharp");
@@clientName(
  AutomationsAPI.AutomationScope,
  "SecurityAutomationScope",
  "csharp"
);
@@clientName(
  AutomationsAPI.AutomationSource,
  "SecurityAutomationSource",
  "csharp"
);
@@clientName(
  AutomationsAPI.AutomationRuleSet,
  "SecurityAutomationRuleSet",
  "csharp"
);
@@clientName(
  AutomationsAPI.AutomationTriggeringRule,
  "SecurityAutomationTriggeringRule",
  "csharp"
);
@@clientName(
  AutomationsAPI.AutomationAction,
  "SecurityAutomationAction",
  "csharp"
);
@@clientName(
  AutomationsAPI.AutomationActionLogicApp,
  "SecurityAutomationActionLogicApp",
  "csharp"
);
@@clientName(
  AutomationsAPI.AutomationActionEventHub,
  "SecurityAutomationActionEventHub",
  "csharp"
);
@@clientName(
  AutomationsAPI.AutomationActionWorkspace,
  "SecurityAutomationActionWorkspace",
  "csharp"
);
@@clientName(
  AutomationsAPI.PropertyType,
  "AutomationTriggeringRulePropertyType",
  "csharp"
);
@@clientName(
  AutomationsAPI.Operator,
  "AutomationTriggeringRuleOperator",
  "csharp"
);
@@clientName(AutomationsAPI.EventSource, "SecurityEventSource", "csharp");
@@clientName(LocationsAPI.AscLocation, "SecurityCenterLocation", "csharp");
@@clientName(PricingsAPI.Pricing, "SecurityCenterPricing", "csharp");
@@clientName(LegacySettingsAPI.Compliance, "SecurityCompliance", "csharp");
@@clientName(LegacySettingsAPI.Rank, "SensitivityLabelRank", "csharp");
@@clientName(ApplicationsAPI.Application, "SecurityApplication", "csharp");
@@clientName(SettingsAPI.Setting, "SecuritySetting", "csharp");
@@clientName(
  LegacySettingsAPI.WorkspaceSetting,
  "SecurityWorkspaceSetting",
  "csharp"
);
@@clientName(
  AssessmentAPI.SecurityAssessmentMetadata,
  "SecurityAssessmentMetadataGenerated",
  "csharp"
);
@@clientName(
  AssessmentAPI.SecurityAssessmentMetadataResponse,
  "SecurityAssessmentMetadata",
  "csharp"
);
@@clientName(
  SqlVulnerabilityAssessmentsAPI.RuleResults,
  "SqlVulnerabilityAssessmentBaselineRule",
  "csharp"
);
@@clientName(
  SqlVulnerabilityAssessmentsAPI.ScanV2,
  "SqlVulnerabilityAssessmentScan",
  "csharp"
);
@@clientName(
  AssessmentAPI.Categories,
  "SecurityAssessmentResourceCategory",
  "csharp"
);
@@clientName(Common.Severity, "SecurityAssessmentSeverity", "csharp");
@@clientName(
  AssessmentAPI.UserImpact,
  "SecurityAssessmentUserImpact",
  "csharp"
);
@@clientName(AssessmentAPI.Threats, "SecurityThreat", "csharp");
@@clientName(AssessmentAPI.AssessmentType, "SecurityAssessmentType", "csharp");
@@clientName(
  AssessmentAPI.SecurityAssessmentMetadataPartnerData,
  "SecurityAssessmentMetadataPartner",
  "csharp"
);
@@clientName(IoTSecurityAPI.ValueType, "SecurityValueType", "csharp");
@@clientName(IoTSecurityAPI.ValueType.IpCidr, "IPCidr", "csharp");
@@clientName(
  SecuritySolutionsAPI.Protocol,
  "JitNetworkAccessPortProtocol",
  "csharp"
);
@@clientName(SecuritySolutionsAPI.Protocol.TCP, "Tcp", "csharp");
@@clientName(SecuritySolutionsAPI.Protocol.UDP, "Udp", "csharp");
@@clientName(
  SecuritySolutionsAPI.ExternalSecuritySolutionKind.AAD,
  "Aad",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.ExternalSecuritySolutionKind.ATA,
  "Ata",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.ExternalSecuritySolutionKind.CEF,
  "Cef",
  "csharp"
);

@@clientName(
  SecuritySolutionsAPI.Status,
  "JitNetworkAccessPortStatus",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.StatusReason,
  "JitNetworkAccessPortStatusReason",
  "csharp"
);

@@clientName(SubAssessmentsAPI.CVSS, "SecurityCvss", "csharp");
@@clientName(SubAssessmentsAPI.CVE, "SecurityCve", "csharp");
@@clientName(
  SqlVulnerabilityAssessmentsAPI.Baseline,
  "SqlVulnerabilityAssessmentBaseline",
  "csharp"
);
@@clientName(
  SqlVulnerabilityAssessmentsAPI.RuleStatus,
  "SqlVulnerabilityAssessmentScanResultRuleStatus",
  "csharp"
);
@@clientName(
  SqlVulnerabilityAssessmentsAPI.ScanPropertiesV2,
  "SqlVulnerabilityAssessmentScanProperties",
  "csharp"
);
@@clientName(
  SqlVulnerabilityAssessmentsAPI.ScanResult,
  "SqlVulnerabilityAssessmentScanResult",
  "csharp"
);
@@clientName(
  SqlVulnerabilityAssessmentsAPI.ScanResultProperties,
  "SqlVulnerabilityAssessmentScanResultProperties",
  "csharp"
);
@@access(
  SqlVulnerabilityAssessmentsAPI.SqlVulnerabilityAssessmentScanResults.get,
  Access.internal,
  "csharp"
);
@@access(
  SqlVulnerabilityAssessmentsAPI.SqlVulnerabilityAssessmentScanResults.list,
  Access.internal,
  "csharp"
);
@@clientName(Common.State, "SecurityAlertNotificationByRoleState", "csharp");
@@clientName(
  AutomationsAPI.SecurityContactRole,
  "SecurityAlertReceivingRole",
  "csharp"
);
@@clientName(
  SecurityConnectorsAPI.DefenderForServersAwsOfferingVaAutoProvisioning,
  "DefenderForServersAwsOfferingVulnerabilityAssessmentAutoProvisioning",
  "csharp"
);
@@clientName(
  SecurityConnectorsAPI.DefenderForServersGcpOfferingDefenderForServers,
  "GcpDefenderForServersInfo",
  "csharp"
);
@@clientName(
  SecurityConnectorsAPI.ScanningMode,
  "DefenderForServersScanningMode",
  "csharp"
);
@@clientName(
  SecurityConnectorsAPI.DefenderForDatabasesGcpOfferingDefenderForDatabasesArcAutoProvisioning,
  "GcpDefenderForDatabasesArcAutoProvisioning",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.RecommendationType,
  "IotSecurityRecommendationType",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.RecommendationType.IoT_ACRAuthentication,
  "IotAcrAuthentication",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.RecommendationType.IoT_AgentSendsUnutilizedMessages,
  "IotAgentSendsUnutilizedMessages",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.RecommendationType.IoT_Baseline,
  "IotBaseline",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.RecommendationType.IoT_EdgeHubMemOptimize,
  "IotEdgeHubMemOptimize",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.RecommendationType.IoT_EdgeLoggingOptions,
  "IotEdgeLoggingOptions",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.RecommendationType.IoT_InconsistentModuleSettings,
  "IotInconsistentModuleSettings",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.RecommendationType.IoT_InstallAgent,
  "IotInstallAgent",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.RecommendationType.IoT_IPFilter_DenyAll,
  "IotIPFilterDenyAll",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.RecommendationType.IoT_IPFilter_PermissiveRule,
  "IotIPFilterPermissiveRule",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.RecommendationType.IoT_OpenPorts,
  "IotOpenPorts",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.RecommendationType.IoT_PermissiveFirewallPolicy,
  "IotPermissiveFirewallPolicy",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.RecommendationType.IoT_PermissiveInputFirewallRules,
  "IotPermissiveInputFirewallRules",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.RecommendationType.IoT_PermissiveOutputFirewallRules,
  "IotPermissiveOutputFirewallRules",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.RecommendationType.IoT_PrivilegedDockerOptions,
  "IotPrivilegedDockerOptions",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.RecommendationType.IoT_SharedCredentials,
  "IotSharedCredentials",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.RecommendationType.IoT_VulnerableTLSCipherSuite,
  "IotVulnerableTlsCipherSuite",
  "csharp"
);
@@clientName(
  SqlVulnerabilityAssessmentsAPI.ScanTriggerType,
  "SqlVulnerabilityAssessmentScanTriggerType",
  "csharp"
);
@@clientName(
  SqlVulnerabilityAssessmentsAPI.ScanState,
  "SqlVulnerabilityAssessmentScanState",
  "csharp"
);
@@clientName(
  AlertsSuppressionRulesAPI.ScopeElement,
  "SuppressionAlertsScopeElement",
  "csharp"
);

@@clientName(
  SecuritySolutionsAPI.DiscoveredSecuritySolutionsOperationGroup.list,
  "GetDiscoveredSecuritySolutions",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.ExternalSecuritySolutionsOperationGroup.list,
  "GetExternalSecuritySolutions",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.JitNetworkAccessPoliciesOperationGroup.list,
  "GetJitNetworkAccessPolicies",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.JitNetworkAccessPoliciesOperationGroup.listByResourceGroup,
  "GetJitNetworkAccessPoliciesByResourceGroup",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.SecuritySolutionsOperationGroup.list,
  "GetSecuritySolutions",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.SecuritySolutionsReferenceDataOperationGroup.list,
  "GetAllSecuritySolutionsReferenceData",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.AllowedConnectionsOperationGroup.list,
  "GetAllowedConnections",
  "csharp"
);
@@clientName(
  MdeOnboardingAPI.MdeOnboardings.list,
  "GetMdeOnboardings",
  "csharp"
);
@@clientName(
  ApiCollectionsAPI.ApiCollections.listBySubscription,
  "GetSecurityCenterApiCollections",
  "csharp"
);
@@clientName(AlertsAPI.AlertsOperationGroup.list, "GetAlerts", "csharp");
@@clientName(TasksAPI.TasksOperationGroup.list, "GetTasks", "csharp");
@@clientName(
  SecureScoreAPI.SecureScoreControlsOperationGroup.list,
  "GetSecureScoreControls",
  "csharp"
);
@@clientName(
  SecureScoreAPI.SecureScoreControlDefinitionsOperationGroup.list,
  "GetSecureScoreControlDefinitions",
  "csharp"
);
@@clientName(
  SecureScoreAPI.SecureScoreControlDefinitionsOperationGroup.listBySubscription,
  "GetSecureScoreControlDefinitionsBySubscription",
  "csharp"
);
@@clientName(
  SensitivitySettingsAPI.GetSensitivitySettingsResponse,
  "SensitivitySetting",
  "csharp"
);
@@clientName(
  SensitivitySettingsAPI.GetSensitivitySettingsResponseProperties,
  "SensitivitySettingsProperties",
  "csharp"
);
@@clientName(
  SensitivitySettingsAPI.GetSensitivitySettingsResponses.list,
  "GetSensitivitySettings",
  "csharp"
);
@@clientName(
  SensitivitySettingsAPI.GetSensitivitySettingsListResponse,
  "SensitivitySettingsListResult",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.TopologyOperationGroup.list,
  "GetTopologies",
  "csharp"
);
@@clientName(
  ApiCollectionsAPI.ApiCollectionsOperationGroup.listByResourceGroup,
  "GetApiCollections",
  "csharp"
);
@@clientName(
  OperationsAPI.OperationResultsOperationGroup.get,
  "GetOperationResult",
  "csharp"
);
@@clientName(
  OperationsAPI.OperationStatusesOperationGroup.get,
  "GetOperationStatus",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Subscription and resource-group alert operations intentionally share the legacy C# action name."
@@clientName(
  AlertsAPI.Alerts.updateSubscriptionLevelStateToActivate,
  "Activate",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Subscription and resource-group alert operations intentionally share the legacy C# action name."
@@clientName(
  AlertsAPI.AlertOperationGroup.updateResourceGroupLevelStateToActivate,
  "Activate",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Subscription and resource-group alert operations intentionally share the legacy C# action name."
@@clientName(
  AlertsAPI.Alerts.updateSubscriptionLevelStateToDismiss,
  "Dismiss",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Subscription and resource-group alert operations intentionally share the legacy C# action name."
@@clientName(
  AlertsAPI.AlertOperationGroup.updateResourceGroupLevelStateToDismiss,
  "Dismiss",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Subscription and resource-group alert operations intentionally share the legacy C# action name."
@@clientName(
  AlertsAPI.Alerts.updateSubscriptionLevelStateToResolve,
  "Resolve",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Subscription and resource-group alert operations intentionally share the legacy C# action name."
@@clientName(
  AlertsAPI.AlertOperationGroup.updateResourceGroupLevelStateToResolve,
  "Resolve",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Subscription and resource-group alert operations intentionally share the legacy C# action name."
@@clientName(
  AlertsAPI.Alerts.updateSubscriptionLevelStateToInProgress,
  "UpdateSatateToInProgress",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Subscription and resource-group alert operations intentionally share the legacy C# action name."
@@clientName(
  AlertsAPI.AlertOperationGroup.updateResourceGroupLevelStateToInProgress,
  "UpdateSatateToInProgress",
  "csharp"
);
@@clientName(
  SecurityConnectorsDevOpsAPI.DevOpsConfigurations.listAvailable,
  "GetAvailableAzureDevOpsOrganizations",
  "csharp"
);
@@clientName(
  SecurityConnectorsDevOpsAPI.DevOpsConfigurations.gitHubOwnersListAvailable,
  "GetAvailableGitHubOwners",
  "csharp"
);
@@clientName(
  SecurityConnectorsDevOpsAPI.DevOpsConfigurations.gitLabGroupsListAvailable,
  "GetAvailableGitLabGroups",
  "csharp"
);
@@clientName(
  CSharpExternalSecuritySolutionReplacement,
  "ExternalSecuritySolution",
  "csharp"
);
@@clientName(
  CSharpCefExternalSecuritySolutionReplacement,
  "CefExternalSecuritySolution",
  "csharp"
);
@@clientName(
  CSharpAtaExternalSecuritySolutionReplacement,
  "AtaExternalSecuritySolution",
  "csharp"
);
@@clientName(
  CSharpAadExternalSecuritySolutionReplacement,
  "AadExternalSecuritySolution",
  "csharp"
);
@@clientName(
  CSharpSecurityAssessmentStatusResult,
  "SecurityAssessmentStatusResult",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.ConnectableResource,
  "ConnectableResourceInfo",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.ConnectedResource,
  "ConnectedResourceInfo",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.AllowedConnectionsResource,
  "SecurityCenterAllowedConnection",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.TopologyResource,
  "SecurityTopology",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.ExternalSecuritySolutions.listByHomeRegion,
  "GetExternalSecuritySolutionsByHomeRegion",
  "csharp"
);
@@clientName(
  AutomationsAPI.AutomationValidationStatus,
  "SecurityAutomationValidationStatus",
  "csharp"
);
@@clientName(
  AutomationsAPI.AutomationUpdateModel,
  "SecurityAutomationPatch",
  "csharp"
);
@@clientName(Common.Tags, "SecurityCenterPatchTags", "csharp");
@@clientName(
  AssessmentAPI.AssessmentStatus,
  "SecurityAssessmentStatus",
  "csharp"
);
@@clientName(
  AssessmentAPI.AssessmentStatusCode,
  "SecurityAssessmentStatusCode",
  "csharp"
);
@@clientName(
  ComplianceResultsAPI.ResourceStatus,
  "SecurityAssessmentResourceStatus",
  "csharp"
);
@@clientName(
  SecurityStandardsAPI.SeverityEnum,
  "CustomRecommendationSeverity",
  "csharp"
);
@@clientName(
  SecurityStandardsAPI.SecurityIssue,
  "CustomRecommendationSecurityIssue",
  "csharp"
);
@@clientName(
  AssessmentAPI.SecurityAssessmentMetadataPropertiesResponse,
  "SecurityAssessmentMetadataPropertiesResult",
  "csharp"
);
@@clientName(
  AssessmentAPI.SecurityAssessmentMetadataPropertiesResponsePublishDates,
  "SecurityAssessmentPublishDates",
  "csharp"
);
@@clientName(
  AssessmentAPI.SecurityAssessmentPartnerData,
  "SecurityAssessmentPartner",
  "csharp"
);
@@clientName(
  SecurityConnectorsDevOpsAPI.AzureDevOpsOrgListResponse,
  "AzureDevOpsOrgListResult",
  "csharp"
);
@@clientName(
  SecurityConnectorsDevOpsAPI.GitHubOwnerListResponse,
  "GitHubOwnerListResult",
  "csharp"
);
@@clientName(
  SecurityConnectorsDevOpsAPI.GitLabGroupListResponse,
  "GitLabGroupListResult",
  "csharp"
);
@@clientName(
  SecurityConnectorsDevOpsAPI.IssueCreationRequest,
  "IssueCreationContent",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.JitNetworkAccessPolicyInitiateRequest,
  "JitNetworkAccessPolicyInitiateContent",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.JitNetworkAccessRequest,
  "JitNetworkAccessRequestInfo",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.IoTSecuritySolutionProperties.unmaskedIpLoggingStatus,
  "UnmaskedIPLoggingStatus",
  "csharp"
);
@@clientName(
  TasksAPI.SecurityTaskProperties,
  "SecurityTaskPropertiesInfo",
  "csharp"
);
@@clientName(
  TasksAPI.SecurityTaskParameters,
  "SecurityTaskProperties",
  "csharp"
);
@@usage(TasksAPI.SecurityTask, Usage.input | Usage.output, "csharp");
@@usage(TasksAPI.SecurityTaskProperties, Usage.input, "csharp");
@@clientName(
  SensitivitySettingsAPI.UpdateSensitivitySettingsRequest,
  "SensitivitySettingCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  SensitivitySettingsAPI.Label,
  "InformationProtectionSensitivityLabel",
  "csharp"
);
@@clientName(HealthReportsAPI.issue, "SecurityHealthIssue", "csharp");
@@clientName(
  SecurityConnectorsAPI.EnvironmentData,
  "SecurityConnectorEnvironment",
  "csharp"
);
@@clientName(SecurityConnectorsAPI.CloudName.AWS, "Aws", "csharp");
@@clientName(SecurityConnectorsAPI.CloudName.GCP, "Gcp", "csharp");
@@clientName(
  SecurityConnectorsAPI.AwsEnvironmentData,
  "AwsEnvironment",
  "csharp"
);
@@clientName(
  SecurityConnectorsAPI.GcpOrganizationalData,
  "GcpOrganizationalInfo",
  "csharp"
);
@@clientName(
  SecurityConnectorsAPI.GcpProjectEnvironmentData,
  "GcpProjectEnvironment",
  "csharp"
);
@@clientName(
  SecurityConnectorsAPI.GithubScopeEnvironmentData,
  "GithubScopeEnvironment",
  "csharp"
);
@@clientName(
  SecurityConnectorsAPI.AzureDevOpsScopeEnvironmentData,
  "AzureDevOpsScopeEnvironment",
  "csharp"
);
@@clientName(
  SecurityConnectorsAPI.GitlabScopeEnvironmentData,
  "GitLabScopeEnvironmentInfo",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.AadConnectivityState,
  "AadConnectivityStateType",
  "csharp"
);
@@clientName(
  SecurityConnectorsAPI.DockerHubEnvironmentData,
  "DockerHubEnvironmentInfo",
  "csharp"
);
@@clientName(
  SecurityConnectorsAPI.JFrogEnvironmentData,
  "JFrogEnvironmentInfo",
  "csharp"
);
@@clientName(
  GovernanceAPI.GovernanceAssignmentAdditionalData,
  "GovernanceAssignmentAdditionalInfo",
  "csharp"
);
@@clientName(
  SecurityStandardsAPI.StandardAssignmentPropertiesExemptionData,
  "StandardAssignmentExemptionInfo",
  "csharp"
);
@@clientName(
  SecurityStandardsAPI.StandardAssignmentPropertiesAttestationData,
  "StandardAssignmentAttestationInfo",
  "csharp"
);
@@clientName(TasksAPI.SecurityTaskParameters.name, "TaskName", "csharp");
@@clientName(
  TasksAPI.SecurityTaskProperties.creationTimeUtc,
  "CreatedOn",
  "csharp"
);
@@clientName(
  TasksAPI.SecurityTaskProperties.lastStateChangeTimeUtc,
  "LastStateChangedOn",
  "csharp"
);
@@clientName(
  SecurityConnectorsAPI.cloudOffering,
  "SecurityCenterCloudOffering",
  "csharp"
);
@@clientName(
  SecurityConnectorsAPI.AwsOrganizationalData,
  "AwsOrganizationalInfo",
  "csharp"
);
@@clientName(
  AlertsAPI.ResourceIdentifier,
  "SecurityAlertResourceIdentifier",
  "csharp"
);
@@clientName(AlertsAPI.AlertSeverity, "SecurityAlertSeverity", "csharp");
@@clientName(AlertsAPI.Intent, "KillChainIntent", "csharp");
@@clientName(AlertsAPI.AlertStatus, "SecurityAlertStatus", "csharp");
@@clientName(AlertsAPI.AlertEntity, "SecurityAlertEntity", "csharp");
@@clientName(
  AlertsAPI.AlertPropertiesSupportingEvidence,
  "SecurityAlertSupportingEvidence",
  "csharp"
);
@@clientName(AlertsAPI.AlertEntity.type, "AlertEntityType", "csharp");
@@clientName(
  AlertsAPI.AlertPropertiesSupportingEvidence.type,
  "SecurityAlertSupportingEvidenceType",
  "csharp"
);
@@clientName(
  AlertsAPI.AlertSimulatorRequestProperties,
  "SecurityAlertSimulatorRequestProperties",
  "csharp"
);
@@clientName(AlertsAPI.AlertProperties.startTimeUtc, "StartOn", "csharp");
@@clientName(AlertsAPI.AlertProperties.endTimeUtc, "EndOn", "csharp");
@@clientName(
  AlertsAPI.AlertProperties.timeGeneratedUtc,
  "GeneratedOn",
  "csharp"
);
@@clientName(
  AlertsAPI.AlertProperties.processingEndTimeUtc,
  "ProcessingEndOn",
  "csharp"
);
@@clientName(
  SecurityConnectorsDevOpsAPI.AzureDevOpsOrgProperties.provisioningStatusUpdateTimeUtc,
  "ProvisioningStatusUpdatedOn",
  "csharp"
);
@@clientName(
  SecurityConnectorsDevOpsAPI.AzureDevOpsProjectProperties.provisioningStatusUpdateTimeUtc,
  "ProvisioningStatusUpdatedOn",
  "csharp"
);
@@clientName(
  SecurityConnectorsDevOpsAPI.AzureDevOpsRepositoryProperties.provisioningStatusUpdateTimeUtc,
  "ProvisioningStatusUpdatedOn",
  "csharp"
);
@@clientName(
  SecurityConnectorsDevOpsAPI.DevOpsConfigurationProperties.provisioningStatusUpdateTimeUtc,
  "ProvisioningStatusUpdatedOn",
  "csharp"
);
@@clientName(
  SecurityConnectorsDevOpsAPI.GitHubOwnerProperties.provisioningStatusUpdateTimeUtc,
  "ProvisioningStatusUpdatedOn",
  "csharp"
);
@@clientName(
  SecurityConnectorsDevOpsAPI.GitHubRepositoryProperties.provisioningStatusUpdateTimeUtc,
  "ProvisioningStatusUpdatedOn",
  "csharp"
);
@@clientName(
  SecurityConnectorsDevOpsAPI.GitLabGroupProperties.provisioningStatusUpdateTimeUtc,
  "ProvisioningStatusUpdatedOn",
  "csharp"
);
@@clientName(
  SecurityConnectorsDevOpsAPI.GitLabProjectProperties.provisioningStatusUpdateTimeUtc,
  "ProvisioningStatusUpdatedOn",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.JitNetworkAccessRequest.startTimeUtc,
  "StartOn",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.JitNetworkAccessRequestPort.endTimeUtc,
  "EndOn",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.JitNetworkAccessPolicyInitiatePort.endTimeUtc,
  "EndOn",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.IoTSecurityAggregatedAlertProperties.aggregatedDateUtc,
  "AggregatedOn",
  "csharp"
);
@@clientName(
  SubAssessmentsAPI.SecuritySubAssessmentProperties.timeGenerated,
  "GeneratedOn",
  "csharp"
);
@@clientName(
  AssessmentAPI.SecurityAssessmentMetadataProperties.preview,
  "IsPreview",
  "csharp"
);
@@clientName(AssessmentAPI.Tactics, "SecurityAssessmentTactic", "csharp");
@@clientName(AssessmentAPI.Techniques, "SecurityAssessmentTechnique", "csharp");
@@clientName(
  SubAssessmentsAPI.AdditionalData,
  "SecuritySubAssessmentAdditionalInfo",
  "csharp"
);
@@clientName(
  IoTSecurityAPI.TagsResource,
  "SecurityCenterTagsResourceInfo",
  "csharp"
);

// C# resource metadata customizations.
#suppress "@azure-tools/typespec-client-generator-core/client-option" "Preserve the existing C# subscription-level alert resource name"
@@clientOption(
  AlertsAPI.Alerts.getSubscriptionLevel,
  "resource-name",
  "SubscriptionSecurityAlert",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option" "Preserve the existing C# resource-group-level alert resource name"
@@clientOption(
  AlertsAPI.AlertOperationGroup.getResourceGroupLevel,
  "resource-name",
  "ResourceGroupSecurityAlert",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option" "Preserve the existing C# subscription-level task resource name"
@@clientOption(
  TasksAPI.SecurityTasks.getSubscriptionLevelTask,
  "resource-name",
  "SubscriptionSecurityTask",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option" "Preserve the existing C# resource-group-level task resource name"
@@clientOption(
  TasksAPI.Tasks.getResourceGroupLevelTask,
  "resource-name",
  "ResourceGroupSecurityTask",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option" "Place simulate on the security alert collection for backward compatibility"
@@clientOption(
  AlertsAPI.AlertsOperationGroup.simulate,
  "resource-operation-kind",
  "CollectionAction",
  "csharp"
);

// Operation status was not exposed by the previous C# generator and is excluded for compatibility.
@@scope(OperationsAPI.OperationStatusesOperationGroup.get, "!csharp");

// C# compatibility replacement: the external security solution discriminator hierarchy
// is a legacy model surface, not an ARM resource surface. Keep replacement models
// until the generator can preserve that API shape with SDK custom base code.
// C# compatibility replacement for the external security solution resource shape.
#suppress "@azure-tools/typespec-azure-core/casing-style" "C# compatibility replacement type uses the CSharp prefix to avoid changing service model names."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Replacement model for C# compatibility because the generated resource hierarchy is not API-compatible with the legacy model hierarchy."
#suppress "@azure-tools/typespec-azure-core/documentation-required" "C# compatibility replacement helper should not generate public XML docs."
model CSharpExternalSecuritySolutionReplacement
  extends Azure.ResourceManager.Foundations.Resource {
  /** The external security solution kind. */
  kind?: SecuritySolutionsAPI.ExternalSecuritySolutionKind;

  /** The resource location. */
  @visibility(Lifecycle.Read)
  location?: azureLocation;
}

// C# compatibility replacement for the CEF external security solution resource shape.
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Replacement model for C# compatibility because the generated resource hierarchy is not API-compatible with the legacy model hierarchy."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Matches the original legacy custom resource shape."
#suppress "@azure-tools/typespec-azure-core/casing-style" "C# compatibility replacement type uses the CSharp prefix to avoid changing service model names."
#suppress "@azure-tools/typespec-azure-core/documentation-required" "C# compatibility replacement helper should not generate public XML docs."
model CSharpCefExternalSecuritySolutionReplacement
  extends CSharpExternalSecuritySolutionReplacement {
  /** The CEF solution properties. */
  properties?: SecuritySolutionsAPI.CefSolutionProperties;

  /** The external security solution kind. */
  kind: "CEF";
}

// C# compatibility replacement for the ATA external security solution resource shape.
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Replacement model for C# compatibility because the generated resource hierarchy is not API-compatible with the legacy model hierarchy."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Matches the original legacy custom resource shape."
#suppress "@azure-tools/typespec-azure-core/casing-style" "C# compatibility replacement type uses the CSharp prefix to avoid changing service model names."
#suppress "@azure-tools/typespec-azure-core/documentation-required" "C# compatibility replacement helper should not generate public XML docs."
model CSharpAtaExternalSecuritySolutionReplacement
  extends CSharpExternalSecuritySolutionReplacement {
  /** The ATA solution properties. */
  properties?: SecuritySolutionsAPI.AtaSolutionProperties;

  /** The external security solution kind. */
  kind: "ATA";
}

// C# compatibility replacement for the AAD external security solution resource shape.
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Replacement model for C# compatibility because the generated resource hierarchy is not API-compatible with the legacy model hierarchy."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Matches the original legacy custom resource shape."
#suppress "@azure-tools/typespec-azure-core/casing-style" "C# compatibility replacement type uses the CSharp prefix to avoid changing service model names."
#suppress "@azure-tools/typespec-azure-core/documentation-required" "C# compatibility replacement helper should not generate public XML docs."
model CSharpAadExternalSecuritySolutionReplacement
  extends CSharpExternalSecuritySolutionReplacement {
  /** The AAD solution properties. */
  properties?: SecuritySolutionsAPI.AadSolutionProperties;

  /** The external security solution kind. */
  kind: "AAD";
}

// C# compatibility replacement: keep the GA property name FirstEvaluatedOn while
// preserving the service wire name firstEvaluationDate.
// C# compatibility replacement for the security assessment status result shape.
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Replacement model preserves the legacy .NET model hierarchy and property names."
#suppress "@azure-tools/typespec-azure-core/casing-style" "C# compatibility replacement type uses the CSharp prefix to avoid changing service model names."
#suppress "@azure-tools/typespec-azure-core/documentation-required" "C# compatibility replacement helper should not generate public XML docs."
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

@@clientName(
  SecuritySolutionsAPI.securitySolutionsReferenceData,
  "SecuritySolutionsReferenceInfo",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.securitySolutionsReferenceDataList,
  "SecuritySolutionsReferenceInfoList",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.securitySolutionsReferenceDataProperties,
  "SecuritySolutionsReferenceInfoProperties",
  "csharp"
);

@@alternateType(
  SecuritySolutionsAPI.JitNetworkAccessPortRule.maxRequestAccessDuration,
  duration,
  "csharp"
);
@@usage(
  CSharpSecurityAssessmentStatusResult,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(
  CSharpExternalSecuritySolutionReplacement,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(
  CSharpCefExternalSecuritySolutionReplacement,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(
  CSharpAtaExternalSecuritySolutionReplacement,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(
  CSharpAadExternalSecuritySolutionReplacement,
  Usage.input | Usage.output,
  "csharp"
);
@@alternateType(
  SecuritySolutionsAPI.ConnectableResource.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SecuritySolutionsAPI.ConnectedResource.connectedResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SecuritySolutionsAPI.Location.location,
  azureLocation,
  "csharp"
);
@@alternateType(
  SecuritySolutionsAPI.JitNetworkAccessPolicy.location,
  Azure.Core.azureLocation | null,
  "csharp"
);
@@alternateType(
  SecuritySolutionsAPI.DiscoveredSecuritySolution.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  SecuritySolutionsAPI.AllowedConnectionsResource.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  SecuritySolutionsAPI.SecuritySolution.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  SecuritySolutionsAPI.TopologyResource.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  IoTSecurityAPI.IoTSecuritySolutionModel.location,
  Azure.Core.azureLocation | null,
  "csharp"
);
@@alternateType(AutomationsAPI.Automation.etag, Azure.Core.eTag, "csharp");
@@alternateType(
  SecurityConnectorsAPI.SecurityConnector.etag,
  Azure.Core.eTag,
  "csharp"
);
@@alternateType(
  SecuritySolutionsAPI.ConnectedWorkspace.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  LegacySettingsAPI.WorkspaceSettingProperties.workspaceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  StandardsAPI.Assignment.location,
  Azure.Core.azureLocation | null,
  "csharp"
);
@@alternateType(
  StandardsAPI.Standard.location,
  Azure.Core.azureLocation | null,
  "csharp"
);
@@clientName(
  SecurityConnectorsAPI.CloudName,
  "SecurityCenterCloudName",
  "csharp"
);
@@clientName(PricingsAPI.PricingTier, "SecurityCenterPricingTier", "csharp");
@@clientName(PricingsAPI.Enforce, "SecurityPolicyEnforce", "csharp");
@@clientName(PricingsAPI.Extension, "SecurityConnectorExtension", "csharp");
@@clientName(
  PricingsAPI.Inherited,
  "SecurityCenterPricingInheritance",
  "csharp"
);
@@clientName(
  PricingsAPI.ResourcesCoverageStatus,
  "SecurityCenterResourcesCoverageStatus",
  "csharp"
);
@@clientName(
  PricingsAPI.IsEnabled,
  "SecurityCenterExtensionIsEnabled",
  "csharp"
);
@@clientName(SecureScoreAPI.ControlType, "SecurityControlType", "csharp");
@@clientName(SensitivitySettingsAPI.BuiltInInfoType.type, "Dns", "csharp");
@@clientName(Common.SettingName.MCAS, "Mcas", "csharp");
@@clientName(Common.SettingName.WDATP, "Wdatp", "csharp");
@@clientName(
  Common.SettingName.WDATP_EXCLUDE_LINUX_PUBLIC_PREVIEW,
  "WdatpExcludeLinuxPublicPreview",
  "csharp"
);
@@clientName(
  Common.SettingName.WDATP_UNIFIED_SOLUTION,
  "WdatpUnifiedSolution",
  "csharp"
);
@@clientName(
  AlertsAPI.AlertSimulatorBundlesRequestProperties,
  "SecurityAlertSimulatorBundlesRequestProperties",
  "csharp"
);
@@clientName(
  AlertsAPI.BundleType,
  "SecurityAlertSimulatorBundleType",
  "csharp"
);
@@clientName(AlertsAPI.BundleType.DNS, "Dns", "csharp");
@@clientName(
  DefenderForStorageAPI.AutomatedResponseType,
  "MalwareScanningAutomatedResponseType",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.ConnectionType,
  "SecurityCenterConnectionType",
  "csharp"
);
@@clientName(
  HealthReportsAPI.StatusName,
  "SecurityCenterHealthStatus",
  "csharp"
);
@@clientName(
  GovernanceAPI.OperationResultStatus,
  "SecurityCenterOperationResultStatus",
  "csharp"
);
@@clientName(
  SqlVulnerabilityAssessmentsAPI.ScanOperationStatus,
  "SqlVulnerabilityAssessmentScanOperationStatus",
  "csharp"
);
@@clientName(
  SecurityStandardsAPI.attestationComplianceState,
  "StandardAssignmentAttestationComplianceState",
  "csharp"
);
@@clientName(
  SecurityStandardsAPI.StandardType,
  "SecurityStandardType",
  "csharp"
);
@@clientName(SecurityStandardsAPI.Effect, "SecurityCenterEffect", "csharp");
@@clientName(SecurityStandardsAPI.StandardSupportedCloud.AWS, "Aws", "csharp");
@@clientName(SecurityStandardsAPI.StandardSupportedCloud.GCP, "Gcp", "csharp");
@@clientName(
  SecurityStandardsAPI.ExemptionCategory,
  "SecurityExemptionCategory",
  "csharp"
);
@@clientName(StandardsAPI.StandardSupportedClouds.AWS, "Aws", "csharp");
@@clientName(StandardsAPI.StandardSupportedClouds.GCP, "Gcp", "csharp");
@@clientName(
  SecurityConnectorsDevOpsAPI.InventoryKind,
  "IotSecurityInventoryKind",
  "csharp"
);
@@clientName(
  SecurityConnectorsDevOpsAPI.InventoryListKind,
  "IotSecurityInventoryListKind",
  "csharp"
);
@@clientName(
  HealthReportsAPI.environmentDetails,
  "SecurityConnectorEnvironmentDetails",
  "csharp"
);
@@clientName(
  GovernanceAPI.GovernanceRuleProperties.includeMemberScopes,
  "IsIncludeMemberScopes",
  "csharp"
);
@@clientName(
  PricingsAPI.PricingProperties.deprecated,
  "IsDeprecated",
  "csharp"
);
@@clientName(
  SubAssessmentsAPI.ContainerRegistryVulnerabilityProperties.patchable,
  "IsPatchable",
  "csharp"
);
@@clientName(
  SecurityConnectorsAPI.DefenderCspmJFrogOfferingMdcContainersImageAssessment.enabled,
  "IsMdcContainersImageAssessmentEnabled",
  "csharp"
);
@@clientName(
  DefenderForStorageAPI.DefenderForStorageSettingProperties.overrideSubscriptionLevelSettings,
  "IsOverrideSubscriptionLevelSettings",
  "csharp"
);
@@clientName(
  LegacySettingsAPI.InformationProtectionKeyword.custom,
  "IsCustom",
  "csharp"
);
@@clientName(
  LegacySettingsAPI.InformationProtectionKeyword.excluded,
  "IsExcluded",
  "csharp"
);
@@clientName(
  LegacySettingsAPI.InformationType,
  "SecurityInformationTypeInfo",
  "csharp"
);
@@clientName(LegacySettingsAPI.InformationType.enabled, "IsEnabled", "csharp");
@@clientName(LegacySettingsAPI.InformationType.custom, "IsCustom", "csharp");
@@alternateType(
  LegacySettingsAPI.InformationType.recommendedLabelId,
  uuid,
  "csharp"
);
@@clientName(
  SqlVulnerabilityAssessmentsAPI.Remediation.automated,
  "IsAutomated",
  "csharp"
);
@@clientName(
  SqlVulnerabilityAssessmentsAPI.RuleResultsProperties.latestScan,
  "IsLatestScan",
  "csharp"
);
@@clientName(
  SqlVulnerabilityAssessmentsAPI.RuleResultsInput.latestScan,
  "IsLatestScan",
  "csharp"
);
@@clientName(
  SubAssessmentsAPI.ServerVulnerabilityProperties.patchable,
  "IsPatchable",
  "csharp"
);
@@clientName(
  SecurityConnectorsAPI.Authentication,
  "SecurityConnectorAuthentication",
  "csharp"
);
@@clientName(
  PrivateLinksAPI.PublicNetworkAccess,
  "SecurityCenterPublicNetworkAccess",
  "csharp"
);
@@clientName(
  GovernanceAPI.OperationResult,
  "SecurityCenterOperationResult",
  "csharp"
);
@@clientName(Common.OperationStatus, "SecurityCenterOperationStatus", "csharp");
@@clientName(
  Azure.ResourceManager.CommonTypes.Identity,
  "SecurityConnectorIdentity",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.ResourceIdentityType,
  "SecurityConnectorIdentityType",
  "csharp"
);
@@clientName(Common.ResourceDetails, "SecurityCenterResourceDetails", "csharp");
@@clientName(
  HealthReportsAPI.resourceDetails,
  "SecurityCloudResourceDetails",
  "csharp"
);
@@clientName(Common.Source, "SecurityCenterResourceSource", "csharp");
@@clientName(
  Common.ProvisioningState,
  "SecurityCenterProvisioningState",
  "csharp"
);
@@clientName(
  DefenderForStorageAPI.BlobScanResultsOptions,
  "BlobScanResultsConfig",
  "csharp"
);
@@clientName(
  SensitivitySettingsAPI.GetSensitivitySettingsResponsePropertiesMipInformation,
  "SensitivitySettingsMipInformation",
  "csharp"
);
@@alternateType(
  StandardsAPI.Assignment.etag,
  Azure.Core.EtagProperty.etag,
  "csharp"
);
@@alternateType(
  StandardsAPI.Standard.etag,
  Azure.Core.EtagProperty.etag,
  "csharp"
);
@@alternateType(
  HealthReportsAPI.environmentDetails.nativeResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SecurityConnectorsDevOpsAPI.IssueCreationRequest.securityAssessmentResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SecureScoreAPI.SecureScoreControlDefinitionItemProperties.assessmentDefinitions,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);
@@clientName(
  GovernanceAPI.GovernanceRuleOwnerSource.type,
  "SourceType",
  "csharp"
);
@@alternateType(
  AssessmentAPI.OnPremiseResourceDetailsProperties.vmuuid,
  uuid,
  "csharp"
);
@@clientName(
  AssessmentAPI.OnPremiseResourceDetailsProperties.vmuuid,
  "VmUuid",
  "csharp"
);
@@clientName(
  SecuritySolutionsAPI.JitNetworkAccessPolicyVirtualMachine.publicIpAddress,
  "PublicIPAddress",
  "csharp"
);
@@alternateType(
  AssessmentAPI.AssessmentStatusResponse,
  CSharpSecurityAssessmentStatusResult,
  "csharp"
);
@@alternateType(
  SecuritySolutionsAPI.ExternalSecuritySolution,
  CSharpExternalSecuritySolutionReplacement,
  "csharp"
);
@@alternateType(
  SecuritySolutionsAPI.CefExternalSecuritySolution,
  CSharpCefExternalSecuritySolutionReplacement,
  "csharp"
);
@@alternateType(
  SecuritySolutionsAPI.AtaExternalSecuritySolution,
  CSharpAtaExternalSecuritySolutionReplacement,
  "csharp"
);
@@alternateType(
  SecuritySolutionsAPI.AadExternalSecuritySolution,
  CSharpAadExternalSecuritySolutionReplacement,
  "csharp"
);
@@usage(AlertsAPI.AlertPropertiesSupportingEvidence, Usage.input, "csharp");
@@alternateType(AlertsAPI.AlertProperties.alertUri, url, "csharp");

// C# pageable operation customizations.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required to preserve the legacy C# pageable operation shape."
@@markAsPageable(PricingsAPI.Pricings.list, "csharp");

// Other language customizations.
@@clientName(
  Azure.ResourceManager.CommonTypes.PrivateEndpointConnection,
  "ArmPrivateEndpointConnection",
  "python"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.ActionType,
  "ArmActionType",
  "python,javascript"
);
@@clientName(AadConnectivityState, "AadConnectivityStateEnum", "python");
@@clientName(
  ExternalSecuritySolutionKind,
  "ExternalSecuritySolutionKindEnum",
  "python"
);
@@clientName(Protocol, "ProtocolEnum", "python");
@@clientName(AlertsAPI.Kind, "KindEnum", "python");
@@clientName(OperationResultStatus, "OperationResult", "python");
@@clientName(OperationResult, "OperationResultAutoGenerated", "python");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "To mitigate breaking change for legacy Python SDK"
@@clientDefaultValue(
  AdvancedThreatProtectionSettingNameAlias.settingName,
  "current",
  "python"
);
@@alternateType(
  AdvancedThreatProtectionSettingNameAlias.settingName,
  "current"
);
// The C# management generator recognizes these resources as singleton resources only
// when the final name parameter is modeled as a closed literal union. Keep the
// service TypeSpec enum unchanged for other languages and apply the fixed name
// only to C# to preserve the singleton-shaped SDK API.
// C# fixed name for the advanced threat protection singleton resource.
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The enum is made closed for .NET SDK in order to recognize the corresponding resource a singleton"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "C# compatibility replacement helper should not generate public XML docs."
@clientName("AdvancedThreatProtectionSettingName")
union CSharpAdvancedThreatProtectionSettingName {
  /** Current. */
  Current: "current",
}

@@alternateType(
  AdvancedThreatProtectionSettingName,
  CSharpAdvancedThreatProtectionSettingName,
  "csharp"
);
@@alternateType(
  AdvancedThreatProtectionSettingNameAlias.settingName,
  CSharpAdvancedThreatProtectionSettingName,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "To mitigate breaking change for legacy Python SDK"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  JitNetworkAccessPolicyInitiateTypeAlias.jitNetworkAccessPolicyInitiateType,
  "initiate",
  "python"
);
@@Azure.ClientGenerator.Core.alternateType(
  JitNetworkAccessPolicyInitiateTypeAlias.jitNetworkAccessPolicyInitiateType,
  "initiate"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "To mitigate breaking change for legacy Python SDK"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  ServerVulnerabilityAssessmentNameAlias.serverVulnerabilityAssessment,
  "default",
  "python"
);
@@Azure.ClientGenerator.Core.alternateType(
  ServerVulnerabilityAssessmentNameAlias.serverVulnerabilityAssessment,
  "default"
);
// The C# management generator recognizes these resources as singleton resources only
// when the final name parameter is modeled as a closed literal union. Keep the
// service TypeSpec enum unchanged for other languages and apply the fixed name
// only to C# to preserve the singleton-shaped SDK API.
// C# fixed name for the server vulnerability assessment singleton resource.
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The enum is made closed for .NET SDK in order to recognize the corresponding resource a singleton"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "C# compatibility replacement helper should not generate public XML docs."
@clientName("ServerVulnerabilityAssessmentName", "csharp")
union CSharpServerVulnerabilityAssessmentName {
  /** Default. */
  Default: "default",
}

@@Azure.ClientGenerator.Core.alternateType(
  ServerVulnerabilityAssessmentName,
  CSharpServerVulnerabilityAssessmentName,
  "csharp"
);
@@Azure.ClientGenerator.Core.alternateType(
  ServerVulnerabilityAssessmentNameAlias.serverVulnerabilityAssessment,
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

@@override(
  SqlVulnerabilityAssessmentScanResults.list,
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

@@override(
  SqlVulnerabilityAssessmentScanResults.get,
  sqlVulnerabilityAssessmentScanResultsGet
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op alertsListResourceGroupLevelByRegionCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /** The location where ASC stores the data of the subscription. can be retrieved from Get locations */
  @path
  @segment("locations")
  @key
  ascLocation: Azure.Core.azureLocation,
): ArmResponse<AlertList> | ErrorResponse;

@@override(
  AlertOperationGroup.listResourceGroupLevelByRegion,
  alertsListResourceGroupLevelByRegionCustomized,
  "python,go,java"
);

@@alternateType(
  Azure.ResourceManager.CommonTypes.Identity.type,
  "SystemAssigned",
  "go"
);

@@clientName(
  HealthReportsAPI.resourceDetails,
  "HealthReportResourceDetails",
  "java,go"
);
@@clientLocation(
  ApiCollections.getByAzureApiManagementService,
  "ApiCollections",
  "java"
);
@@clientLocation(
  ApiCollections.onboardAzureApiManagementApi,
  "ApiCollections",
  "java"
);
@@clientLocation(
  ApiCollections.offboardAzureApiManagementApi,
  "ApiCollections",
  "java"
);
@@clientLocation(
  ApiCollections.listByAzureApiManagementService,
  "ApiCollections",
  "java"
);
@@clientLocation(ApiCollections.listBySubscription, "ApiCollections", "java");
@@clientLocation(
  ApiCollectionsOperationGroup.listByResourceGroup,
  "ApiCollections",
  "java"
);

@@clientName(SecurityManagementClient, "SecurityCenter", "java");
@@clientName(SubAssessmentsAPI.CVSS, "Cvss", "java");
@@clientName(
  SecurityAssessmentPropertiesBaseRiskPathsItemEdgeItem,
  "SecurityAssessmentPropertiesBaseRiskPathsItemEdge",
  "java"
);
@@clientName(
  SecurityAssessmentPropertiesBaseRiskPathsItemNodesItem,
  "SecurityAssessmentPropertiesBaseRiskPathsPropertiesItemsItem",
  "java"
);
@@clientLocation(
  ApplicationsAPI.SecurityConnectorApplication.get,
  "SecurityConnectorApplications",
  "java"
);
@@clientLocation(
  ApplicationsAPI.SecurityConnectorApplication.createOrUpdate,
  "SecurityConnectorApplications",
  "java"
);
@@clientLocation(
  ApplicationsAPI.SecurityConnectorApplication.delete,
  "SecurityConnectorApplications",
  "java"
);
@@clientLocation(
  ApplicationsAPI.SecurityConnectorApplication.list,
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

@@alternateType(
  JitNetworkAccessPolicies.createOrUpdate::parameters.resource,
  JitNetworkAccessPolicyCreate,
  "javascript"
);
