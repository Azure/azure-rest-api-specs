import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./CustomAssessmentAutomation.tsp";
import "./CustomEntityStoreAssignment.tsp";
import "./ComplianceResult.tsp";
import "./SecurityCenterPricing.tsp";
import "./AdvancedThreatProtectionSetting.tsp";
import "./DeviceSecurityGroup.tsp";
import "./IotSecuritySolution.tsp";
import "./IotSecuritySolutionAnalyticsModel.tsp";
import "./IotSecurityAggregatedAlert.tsp";
import "./IotSecurityAggregatedRecommendation.tsp";
import "./SecurityCenterLocation.tsp";
import "./SubscriptionSecurityTask.tsp";
import "./ResourceGroupSecurityTask.tsp";
import "./AutoProvisioningSetting.tsp";
import "./SecurityCompliance.tsp";
import "./SecurityContact.tsp";
import "./SecurityWorkspaceSetting.tsp";
import "./RegulatoryComplianceStandard.tsp";
import "./RegulatoryComplianceControl.tsp";
import "./RegulatoryComplianceAssessment.tsp";
import "./SecuritySubAssessment.tsp";
import "./SecurityAutomation.tsp";
import "./SecurityAlertsSuppressionRule.tsp";
import "./ServerVulnerabilityAssessment.tsp";
import "./TenantAssessmentMetadata.tsp";
import "./SubscriptionAssessmentMetadata.tsp";
import "./SecurityAssessment.tsp";
import "./AdaptiveApplicationControlGroup.tsp";
import "./AdaptiveNetworkHardening.tsp";
import "./JitNetworkAccessPolicy.tsp";
import "./SecureScore.tsp";
import "./SecurityCloudConnector.tsp";
import "./SubscriptionSecurityAlert.tsp";
import "./ResourceGroupSecurityAlert.tsp";
import "./SecuritySetting.tsp";
import "./IngestionSetting.tsp";
import "./SoftwareInventory.tsp";
import "./SecurityConnector.tsp";
import "./GovernanceRule.tsp";
import "./GovernanceAssignment.tsp";
import "./SubscriptionSecurityApplication.tsp";
import "./SecurityConnectorApplication.tsp";
import "./SqlVulnerabilityAssessmentScan.tsp";
import "./SqlVulnerabilityAssessmentBaselineRule.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "SecurityCenter",
})
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
@doc("API spec for Microsoft.Security (Azure Security Center) resource provider")
namespace Azure.ResourceManager.SecurityCenter;
