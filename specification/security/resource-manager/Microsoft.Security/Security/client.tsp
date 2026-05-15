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

@@Azure.ClientGenerator.Core.override(
  PrivateLinkResources.get,
  privateLinksGetCustomization,
  "!python,!java"
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
  "!python,!java"
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

@@clientName(
  privateLinksUpdateCustomization::parameters.properties,
  "privateLink"
);
@@Azure.ClientGenerator.Core.override(
  PrivateLinkResources.update,
  privateLinksUpdateCustomization,
  "!python,!java"
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
):
  | ArmDeleteAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>
  | ArmDeletedNoContentResponse
  | ErrorResponse;

@@Azure.ClientGenerator.Core.override(
  PrivateLinkResources.delete,
  privateLinksDeleteCustomization,
  "!python,!java"
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

@@Azure.ClientGenerator.Core.override(
  PrivateLinkResources.head,
  privateLinksHeadCustomization,
  "!python,!java"
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
):
  | ArmResponse<ResourceListResult<PrivateLinksAPI.PrivateEndpointConnection>>
  | ErrorResponse;

@@Azure.ClientGenerator.Core.override(
  PrivateEndpointConnections.list,
  privateEndpointConnectionsListCustomization,
  "!python,!java"
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

@@Azure.ClientGenerator.Core.override(
  PrivateEndpointConnections.get,
  privateEndpointConnectionsGetCustomization,
  "!python,!java"
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
  "!python,!java"
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
  @query
  privateLinkName: `private-link-parameters`,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateEndpointConnectionName: string,
):
  | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>
  | ArmDeletedNoContentResponse
  | ErrorResponse;

@@Azure.ClientGenerator.Core.override(
  PrivateEndpointConnections.delete,
  privateEndpointConnectionsDeleteCustomization,
  "!python,!java"
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

@@Azure.ClientGenerator.Core.override(
  PrivateLinkGroupResources.list,
  privateLinkResourcesListCustomization,
  "!python,!java"
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

@@Azure.ClientGenerator.Core.override(
  PrivateLinkGroupResources.get,
  privateLinkResourcesGetCustomization,
  "!python,!java"
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
@@usage(IoTSecurityAPI.CustomAlertRule, Usage.input | Usage.output, "go");

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

@@clientName(Common.ResourceDetails, "CommonResourceDetails", "python,go");
@@clientName(HealthReportsAPI.status, "StatusAutoGenerated", "python");
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
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  AdvancedThreatProtectionSettingNameAlias.settingName,
  "current",
  "python"
);
@@Azure.ClientGenerator.Core.alternateType(
  AdvancedThreatProtectionSettingNameAlias.settingName,
  "current"
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

  /** The location where ASC stores the data of the subscription. can be retrieved from Get locations */
  @path
  @segment("locations")
  ascLocation: string,

  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
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
  "java"
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
