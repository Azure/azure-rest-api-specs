import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./DataMaskingPolicy.tsp";
import "./GeoBackupPolicy.tsp";
import "./ServerCommunicationLink.tsp";
import "./ServiceObjective.tsp";
import "./Advisor.tsp";
import "./Advisor.tsp";
import "./DatabaseAutomaticTuning.tsp";
import "./DatabaseColumn.tsp";
import "./DatabaseColumn.tsp";
import "./RecommendedAction.tsp";
import "./DatabaseSchema.tsp";
import "./DatabaseSchema.tsp";
import "./DatabaseSecurityAlertPolicy.tsp";
import "./DatabaseTable.tsp";
import "./DatabaseTable.tsp";
import "./DatabaseVulnerabilityAssessmentRuleBaseline.tsp";
import "./DatabaseVulnerabilityAssessmentRuleBaseline.tsp";
import "./DatabaseVulnerabilityAssessment.tsp";
import "./DatabaseVulnerabilityAssessment.tsp";
import "./VulnerabilityAssessmentScanRecord.tsp";
import "./VulnerabilityAssessmentScanRecord.tsp";
import "./DataWarehouseUserActivities.tsp";
import "./DeletedServer.tsp";
import "./EncryptionProtector.tsp";
import "./FirewallRule.tsp";
import "./InstancePool.tsp";
import "./JobAgent.tsp";
import "./JobCredential.tsp";
import "./JobExecution.tsp";
import "./JobExecution.tsp";
import "./JobExecution.tsp";
import "./Job.tsp";
import "./JobStep.tsp";
import "./JobStep.tsp";
import "./JobTargetGroup.tsp";
import "./JobVersion.tsp";
import "./LongTermRetentionPolicy.tsp";
import "./MaintenanceWindowOptions.tsp";
import "./MaintenanceWindows.tsp";
import "./ManagedBackupShortTermRetentionPolicy.tsp";
import "./ManagedBackupShortTermRetentionPolicy.tsp";
import "./ManagedDatabaseSecurityAlertPolicy.tsp";
import "./ManagedTransparentDataEncryption.tsp";
import "./ManagedInstanceAdministrator.tsp";
import "./ManagedInstanceAzureADOnlyAuthentication.tsp";
import "./ManagedInstanceEncryptionProtector.tsp";
import "./ManagedInstanceKey.tsp";
import "./ManagedInstanceLongTermRetentionPolicy.tsp";
import "./ManagedInstanceOperation.tsp";
import "./ManagedInstancePrivateEndpointConnection.tsp";
import "./ManagedInstancePrivateLink.tsp";
import "./ManagedInstanceVulnerabilityAssessment.tsp";
import "./ManagedServerSecurityAlertPolicy.tsp";
import "./PrivateEndpointConnection.tsp";
import "./PrivateLinkResource.tsp";
import "./RecoverableManagedDatabase.tsp";
import "./RestorePoint.tsp";
import "./ServerAutomaticTuning.tsp";
import "./ServerAzureADAdministrator.tsp";
import "./ServerAzureADOnlyAuthentication.tsp";
import "./ServerDevOpsAuditingSettings.tsp";
import "./ServerDnsAlias.tsp";
import "./ServerKey.tsp";
import "./ServerSecurityAlertPolicy.tsp";
import "./ServerTrustGroup.tsp";
import "./ServerVulnerabilityAssessment.tsp";
import "./SqlAgentConfiguration.tsp";
import "./SubscriptionUsage.tsp";
import "./SyncAgent.tsp";
import "./SyncGroup.tsp";
import "./SyncMember.tsp";
import "./TimeZone.tsp";
import "./VirtualNetworkRule.tsp";
import "./WorkloadClassifier.tsp";
import "./WorkloadGroup.tsp";
import "./BackupShortTermRetentionPolicy.tsp";
import "./LedgerDigestUploads.tsp";
import "./OutboundFirewallRule.tsp";
import "./LongTermRetentionBackup.tsp";
import "./LongTermRetentionBackup.tsp";
import "./ManagedInstanceLongTermRetentionBackup.tsp";
import "./ManagedInstanceLongTermRetentionBackup.tsp";
import "./RestorableDroppedManagedDatabase.tsp";
import "./ServerConnectionPolicy.tsp";
import "./DistributedAvailabilityGroup.tsp";
import "./ServerTrustCertificate.tsp";
import "./EndpointCertificate.tsp";
import "./SensitivityLabel.tsp";
import "./SensitivityLabel.tsp";
import "./ServerBlobAuditingPolicy.tsp";
import "./DatabaseBlobAuditingPolicy.tsp";
import "./ExtendedDatabaseBlobAuditingPolicy.tsp";
import "./ExtendedServerBlobAuditingPolicy.tsp";
import "./DatabaseAdvancedThreatProtection.tsp";
import "./ServerAdvancedThreatProtection.tsp";
import "./ManagedServerDnsAlias.tsp";
import "./ManagedDatabaseAdvancedThreatProtection.tsp";
import "./ManagedInstanceAdvancedThreatProtection.tsp";
import "./ReplicationLink.tsp";
import "./ManagedInstanceDtc.tsp";
import "./VirtualCluster.tsp";
import "./InstanceFailoverGroup.tsp";
import "./ManagedDatabaseRestoreDetailsResult.tsp";
import "./Database.tsp";
import "./ElasticPool.tsp";
import "./ManagedDatabase.tsp";
import "./ManagedInstance.tsp";
import "./ManagedLedgerDigestUploads.tsp";
import "./RecoverableDatabase.tsp";
import "./RestorableDroppedDatabase.tsp";
import "./ServerConfigurationOption.tsp";
import "./StartStopManagedInstanceSchedule.tsp";
import "./LogicalDatabaseTransparentDataEncryption.tsp";
import "./IPv6FirewallRule.tsp";
import "./DatabaseSqlVulnerabilityAssessmentBaselineSet.tsp";
import "./DatabaseSqlVulnerabilityAssessmentBaselineSet.tsp";
import "./DatabaseSqlVulnerabilityAssessmentRuleBaseline.tsp";
import "./DatabaseSqlVulnerabilityAssessmentRuleBaseline.tsp";
import "./SqlVulnerabilityAssessmentScanResults.tsp";
import "./SqlVulnerabilityAssessmentScanResults.tsp";
import "./SqlVulnerabilityAssessmentScanRecord.tsp";
import "./SqlVulnerabilityAssessmentScanRecord.tsp";
import "./SqlVulnerabilityAssessment.tsp";
import "./SqlVulnerabilityAssessment.tsp";
import "./Server.tsp";
import "./FailoverGroup.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * The Azure SQL Database management API provides a RESTful set of web services that interact with Azure SQL Database services to manage your databases. The API enables you to create, retrieve, update, and delete databases.
 */
@armProviderNamespace
@service({
  title: "SqlManagementClient",
})
@versioned(Versions)
namespace Microsoft.Sql;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2014-04-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2014_04_01: "2014-04-01",

  /**
   * The 2020-11-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2020_11_01_preview: "2020-11-01-preview",

  /**
   * The 2022-08-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_08_01_preview: "2022-08-01-preview",

  /**
   * The 2022-02-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_02_01_preview: "2022-02-01-preview",

  /**
   * The 2021-02-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_02_01_preview: "2021-02-01-preview",

  /**
   * The 2021-05-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_05_01_preview: "2021-05-01-preview",

  /**
   * The 2021-11-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_11_01_preview: "2021-11-01-preview",

  /**
   * The 2022-05-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_05_01_preview: "2022-05-01-preview",

  /**
   * The 2023-02-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_02_01_preview: "2023-02-01-preview",

  /**
   * The 2022-11-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_11_01_preview: "2022-11-01-preview",
}
