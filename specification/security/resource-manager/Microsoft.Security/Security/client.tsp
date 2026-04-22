import "./Alerts/main.tsp";
import "./AlertsSuppressionRules/main.tsp";
import "./ApiCollections/main.tsp";
import "./Applications/main.tsp";
import "./Assessment/main.tsp";
import "./ATPSettings/main.tsp";
import "./Automations/main.tsp";
import "./ComplianceResults/main.tsp";
import "./DefenderForStorage/main.tsp";
import "./Governance/main.tsp";
import "./HealthReports/main.tsp";
import "./IoTSecurity/main.tsp";
import "./LegacySettings/main.tsp";
import "./Locations/main.tsp";
import "./MdeOnboarding/main.tsp";
import "./Operations/main.tsp";
import "./Pricings/main.tsp";
import "./PrivateLinks/main.tsp";
import "./RegulatoryCompliance/main.tsp";
import "./SecureScore/main.tsp";
import "./SecurityConnectors/main.tsp";
import "./SecurityConnectorsDevOps/main.tsp";
import "./SecurityOperators/main.tsp";
import "./SecuritySolutions/main.tsp";
import "./SecurityStandards/main.tsp";
import "./SensitivitySettings/main.tsp";
import "./ServerVulnerabilityAssessmentsSettings/main.tsp";
import "./Settings/main.tsp";
import "./SqlVulnerabilityAssessments/main.tsp";
import "./Standards/main.tsp";
import "./SubAssessments/main.tsp";
import "./Tasks/main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.Core;
using PrivateLinksAPI;

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
  params?: `private-link-parameters`,
): ArmResponse<PrivateLinksAPI.PrivateLinkResource> | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateLinkResources.get,
  privateLinksGetCustomization,
  "!javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op privateLinksCreateCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params?: `private-link-parameters`,
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
  "!javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op privateLinksUpdateCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params?: `private-link-parameters`,
  properties: PrivateLinksAPI.PrivateLinkUpdate,
): ArmResponse<PrivateLinksAPI.PrivateLinkResource> | ErrorResponse;

@@clientName(privateLinksUpdateCustomization::parameters.properties,
  "privateLink"
);
@@Azure.ClientGenerator.Core.override(PrivateLinkResources.update,
  privateLinksUpdateCustomization,
  "!javascript"
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
  params?: `private-link-parameters`,
): ArmDeleteAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
  Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateLinkResources.delete,
  privateLinksDeleteCustomization,
  "!javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op privateLinksHeadCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params?: `private-link-parameters`,
): OkResponse | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateLinkResources.head,
  privateLinksHeadCustomization,
  "!javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op privateEndpointConnectionsListCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params?: `private-link-parameters`,
): ArmResponse<ResourceListResult<PrivateLinksAPI.PrivateEndpointConnection>> | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateEndpointConnections.list,
  privateEndpointConnectionsListCustomization,
  "!javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op privateEndpointConnectionsGetCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params?: `private-link-parameters`,
  privateEndpointConnectionName: string,
): ArmResponse<Azure.ResourceManager.PrivateEndpointConnection> | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateEndpointConnections.get,
  privateEndpointConnectionsGetCustomization,
  "!javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op privateEndpointConnectionsCreateOrUpdateCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params?: `private-link-parameters`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateEndpointConnectionName: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource: Azure.ResourceManager.PrivateEndpointConnection,
): ArmResourceUpdatedResponse<PrivateLinksAPI.PrivateLinkResource> | ArmResourceCreatedResponse<
  PrivateLinksAPI.PrivateLinkResource,
  ArmAsyncOperationHeader<FinalResult = PrivateLinksAPI.PrivateLinkResource> &
    Azure.Core.Foundations.RetryAfterHeader
> | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateEndpointConnections.createOrUpdate,
  privateEndpointConnectionsCreateOrUpdateCustomization,
  "!javascript"
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
  params?: `private-link-parameters`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateEndpointConnectionName: string,
): ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
  Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateEndpointConnections.delete,
  privateEndpointConnectionsDeleteCustomization,
  "!javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op privateLinkResourcesListCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params?: `private-link-parameters`,
): ArmResponse<ResourceListResult<PrivateLinkGroupResource>> | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateLinkGroupResources.list,
  privateLinkResourcesListCustomization,
  "!javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op privateLinkResourcesGetCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params?: `private-link-parameters`,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  groupId: string,
): ArmResponse<PrivateLinkGroupResource> | ErrorResponse;

@@Azure.ClientGenerator.Core.override(PrivateLinkGroupResources.get,
  privateLinkResourcesGetCustomization,
  "!javascript"
);

@@clientName(SecurityOperatorsAPI.SecurityOperator, "OperatorResource", "go");
@@clientName(SecurityStandardsAPI.SecurityStandard,
  "ArmSecurityStandard",
  "go"
);
@@clientName(SecurityStandardsAPI.SecurityStandardProperties,
  "ArmSecurityStandardProperties",
  "go"
);
@@usage(IoTSecurityAPI.CustomAlertRule, Usage.input | Usage.output, "go");

@@clientName(SecuritySolutionsAPI.Status, "StatusEnum", "go");

@@clientName(Azure.ResourceManager.CommonTypes.ErrorAdditionalInfo,
  "ArmErrorAdditionalInfo",
  "python"
);
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnection,
  "ArmPrivateEndpointConnection",
  "python"
);
@@clientName(Azure.ResourceManager.CommonTypes.ActionType,
  "ArmActionType",
  "python,javascript"
);
@@clientName(SecuritySolutionsAPI.AadConnectivityState,
  "AadConnectivityStateEnum",
  "python"
);
@@clientName(SecuritySolutionsAPI.ExternalSecuritySolutionKind,
  "ExternalSecuritySolutionKindEnum",
  "python"
);
@@clientName(SecuritySolutionsAPI.Protocol, "ProtocolEnum", "python");
@@clientName(AlertsAPI.Kind, "KindEnum", "python");
@@clientName(SecuritySolutionsAPI.Status, "StatusEnum", "python");
@@clientName(Governance.OperationResult,
  "OperationResultAutoGenerated",
  "python"
);

@@clientName(Azure.ResourceManager.CommonTypes.ErrorAdditionalInfo,
  "ArmErrorAdditionalInfo",
  "java"
);
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnection,
  "ArmPrivateEndpointConnection",
  "java"
);
@@clientName(Azure.ResourceManager.CommonTypes.ActionType,
  "ArmActionType",
  "java"
);

@@clientName(Azure.ResourceManager.CommonTypes.ErrorAdditionalInfo,
  "ArmErrorAdditionalInfo",
  "java"
);
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnection,
  "ArmPrivateEndpointConnection",
  "java"
);
@@clientName(Azure.ResourceManager.CommonTypes.ActionType,
  "ArmActionType",
  "java"
);
