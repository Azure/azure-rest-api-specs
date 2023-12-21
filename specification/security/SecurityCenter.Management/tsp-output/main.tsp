import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./CustomAssessmentAutomation.tsp";
import "./CustomEntityStoreAssignment.tsp";
import "./ComplianceResult.tsp";
import "./Pricing.tsp";
import "./AdvancedThreatProtectionSetting.tsp";
import "./DeviceSecurityGroup.tsp";
import "./IoTSecuritySolutionModel.tsp";
import "./IoTSecuritySolutionAnalyticsModel.tsp";
import "./IoTSecurityAggregatedAlert.tsp";
import "./IoTSecurityAggregatedRecommendation.tsp";
import "./AscLocation.tsp";
import "./SecurityTask.tsp";
import "./SecurityTask.tsp";
import "./AutoProvisioningSetting.tsp";
import "./Compliance.tsp";
import "./SecurityContact.tsp";
import "./WorkspaceSetting.tsp";
import "./RegulatoryComplianceStandard.tsp";
import "./RegulatoryComplianceControl.tsp";
import "./RegulatoryComplianceAssessment.tsp";
import "./SecuritySubAssessment.tsp";
import "./Automation.tsp";
import "./AlertsSuppressionRule.tsp";
import "./ServerVulnerabilityAssessment.tsp";
import "./SecurityAssessmentMetadataResponse.tsp";
import "./SecurityAssessmentMetadataResponse.tsp";
import "./SecurityAssessmentResponse.tsp";
import "./AdaptiveApplicationControlGroup.tsp";
import "./AdaptiveNetworkHardening.tsp";
import "./JitNetworkAccessPolicy.tsp";
import "./SecureScoreItem.tsp";
import "./ConnectorSetting.tsp";
import "./Alert.tsp";
import "./Alert.tsp";
import "./Setting.tsp";
import "./IngestionSetting.tsp";
import "./Software.tsp";
import "./SecurityConnector.tsp";
import "./GovernanceRule.tsp";
import "./GovernanceAssignment.tsp";
import "./Application.tsp";
import "./Application.tsp";
import "./Scan.tsp";
import "./RuleResults.tsp";
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
