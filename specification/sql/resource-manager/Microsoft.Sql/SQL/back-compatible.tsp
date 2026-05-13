import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Sql;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabaseExtensions.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabaseOperation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabaseUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ImportExportOperationResult.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabaseSqlVulnerabilityAssessmentRuleBaselineListInput.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabaseSqlVulnerabilityAssessmentRuleBaselineInput.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabaseUsage.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabaseVulnerabilityAssessmentScansExport.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DataMaskingRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ElasticPoolOperation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ElasticPoolUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FailoverGroupUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(InstancePoolUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CopyLongTermRetentionBackupParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LongTermRetentionBackupOperationResult.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(UpdateLongTermRetentionBackupParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(QueryStatistics.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedDatabaseUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecurityEvent.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SensitivityLabelUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RecommendedSensitivityLabelUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedInstanceUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RefreshExternalGovernanceStatusOperationResultMI.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(TdeCertificate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ReplicationLinkUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServerOperation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServerUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RefreshExternalGovernanceStatusOperationResult.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServerUsage.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SynapseLinkWorkspace.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SyncAgentLinkedDatabase.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VirtualClusterUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(UpdateVirtualClusterDnsServersOperation.properties);

@@clientName(BackupShortTermRetentionPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(BackupShortTermRetentionPolicies.update::parameters.properties,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(BackupShortTermRetentionPolicy.properties);

@@clientName(ServerBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServerBlobAuditingPolicy.properties);

@@clientName(DatabaseBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabaseBlobAuditingPolicy.properties);

@@clientName(ExtendedDatabaseBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExtendedDatabaseBlobAuditingPolicy.properties);

@@clientName(ExtendedServerBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExtendedServerBlobAuditingPolicy.properties);

@@clientLocation(DatabaseAdvancedThreatProtections.get,
  "DatabaseAdvancedThreatProtectionSettings"
);
@@clientLocation(DatabaseAdvancedThreatProtections.createOrUpdate,
  "DatabaseAdvancedThreatProtectionSettings"
);
@@clientName(DatabaseAdvancedThreatProtections.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(DatabaseAdvancedThreatProtections.listByDatabase,
  "DatabaseAdvancedThreatProtectionSettings"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabaseAdvancedThreatProtection.properties);

@@clientLocation(Advisors.get, "DatabaseAdvisors");
@@clientLocation(Advisors.update, "DatabaseAdvisors");
@@clientName(Advisors.update::parameters.properties, "parameters");
@@clientLocation(Advisors.listByDatabase, "DatabaseAdvisors");
@@clientName(ServerAdvisors.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Advisor.properties);

@@clientLocation(RecommendedActions.get, "DatabaseRecommendedActions");
@@clientLocation(RecommendedActions.update, "DatabaseRecommendedActions");
@@clientName(RecommendedActions.update::parameters.properties, "parameters");
@@clientLocation(RecommendedActions.listByDatabaseAdvisor,
  "DatabaseRecommendedActions"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RecommendedAction.properties);

@@clientLocation(DatabaseAutomaticTunings.get, "DatabaseAutomaticTuning");
@@clientLocation(DatabaseAutomaticTunings.update, "DatabaseAutomaticTuning");
@@clientName(DatabaseAutomaticTunings.update::parameters.properties,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabaseAutomaticTuning.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabaseColumn.properties);

@@clientLocation(ImportExportExtensionsOperationResults.get,
  "DatabaseExtensions"
);
@@clientLocation(ImportExportExtensionsOperationResults.createOrUpdate,
  "DatabaseExtensions"
);
@@clientName(ImportExportExtensionsOperationResults.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ImportExportExtensionsOperationResults.listByDatabase,
  "DatabaseExtensions"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ImportExportExtensionsOperationResult.properties);

@@clientName(Databases.createOrUpdate::parameters.resource, "parameters");
@@clientName(Databases.update::parameters.properties, "parameters");
@@clientLocation(Databases.listByDatabase, DatabaseColumns);
@@clientLocation(Databases.revalidate, "DatabaseEncryptionProtectors");
@@clientLocation(Databases.revert, "DatabaseEncryptionProtectors");
@@clientLocation(Databases.databaseOperationsListByDatabase,
  "DatabaseOperations"
);
@@clientName(Databases.databaseOperationsListByDatabase, "ListByDatabase");
@@clientLocation(Databases.cancel, "DatabaseOperations");
@@clientName(Databases.importDatabase, "Import");
@@clientName(Databases.export::parameters.body, "parameters");
@@clientName(Databases.importDatabase::parameters.body, "parameters");
@@clientName(Databases.rename::parameters.body, "parameters");
@@clientLocation(Databases.databaseUsagesListByDatabase, "DatabaseUsages");
@@clientName(Databases.databaseUsagesListByDatabase, "ListByDatabase");
@@clientLocation(Databases.create, RestorePoints);
@@clientName(Databases.create::parameters.body, "parameters");
@@clientLocation(Databases.listCurrentByDatabase, SensitivityLabels);
@@clientLocation(Databases.sensitivityLabelsUpdate, SensitivityLabels);
@@clientName(Databases.sensitivityLabelsUpdate, "Update");
@@clientName(Databases.sensitivityLabelsUpdate::parameters.body, "parameters");
@@clientLocation(Databases.listRecommendedByDatabase, SensitivityLabels);
@@clientLocation(Databases.recommendedSensitivityLabelsUpdate,
  "RecommendedSensitivityLabels"
);
@@clientName(Databases.recommendedSensitivityLabelsUpdate, "Update");
@@clientName(Databases.recommendedSensitivityLabelsUpdate::parameters.body,
  "parameters"
);
@@clientLocation(Databases.sensitivityLabelsListByDatabase, SensitivityLabels);
@@clientName(Databases.sensitivityLabelsListByDatabase, "ListByDatabase");
@@clientLocation(Databases.synapseLinkWorkspacesListByDatabase,
  "SynapseLinkWorkspaces"
);
@@clientName(Databases.synapseLinkWorkspacesListByDatabase, "ListByDatabase");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Database.properties);

@@clientName(DatabaseSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabaseSecurityAlertPolicy.properties);

@@clientLocation(DatabaseSqlVulnerabilityAssessmentBaselineSets.get,
  "DatabaseSqlVulnerabilityAssessmentBaselines"
);
@@clientLocation(DatabaseSqlVulnerabilityAssessmentBaselineSets.createOrUpdate,
  "DatabaseSqlVulnerabilityAssessmentBaselines"
);
@@clientName(DatabaseSqlVulnerabilityAssessmentBaselineSets.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(DatabaseSqlVulnerabilityAssessmentBaselineSets.listBySqlVulnerabilityAssessment,
  "DatabaseSqlVulnerabilityAssessmentBaselines"
);
@@clientLocation(SqlVulnerabilityAssessmentBaseline.createOrUpdate,
  "SqlVulnerabilityAssessmentBaselines"
);
@@clientName(SqlVulnerabilityAssessmentBaseline.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabaseSqlVulnerabilityAssessmentBaselineSet.properties
);

@@clientName(DatabaseSqlVulnerabilityAssessmentRuleBaselines.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(SqlVulnerabilityAssessmentRuleBaseline.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(SqlVulnerabilityAssessmentRuleBaseline.delete,
  "SqlVulnerabilityAssessmentRuleBaselines"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabaseSqlVulnerabilityAssessmentRuleBaseline.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SqlVulnerabilityAssessmentScanResults.properties);

@@clientLocation(SqlVulnerabilityAssessmentScanRecords.get,
  "DatabaseSqlVulnerabilityAssessmentScans"
);
@@clientLocation(SqlVulnerabilityAssessmentScanRecords.listBySqlVulnerabilityAssessments,
  "DatabaseSqlVulnerabilityAssessmentScans"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SqlVulnerabilityAssessmentScanRecord.properties);

@@clientLocation(SqlVulnerabilityAssessments.get,
  "DatabaseSqlVulnerabilityAssessmentsSettings"
);
@@clientLocation(SqlVulnerabilityAssessments.listByDatabase,
  "DatabaseSqlVulnerabilityAssessmentsSettings"
);
@@clientLocation(SqlVulnerabilityAssessments.execute,
  "DatabaseSqlVulnerabilityAssessmentExecuteScan"
);
@@clientName(SqlVulnerabilityAssessmentsSettings.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(SqlVulnerabilityAssessmentsSettings.delete,
  SqlVulnerabilityAssessments
);
@@clientLocation(SqlVulnerabilityAssessmentsSettings.execute,
  "SqlVulnerabilityAssessmentExecuteScan"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SqlVulnerabilityAssessment.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabaseTable.properties);

@@clientName(DatabaseVulnerabilityAssessmentRuleBaselines.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ManagedDatabaseVulnerabilityAssessmentRuleBaselines.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabaseVulnerabilityAssessmentRuleBaseline.properties
);

@@clientName(DatabaseVulnerabilityAssessments.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ManagedDatabaseVulnerabilityAssessments.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabaseVulnerabilityAssessment.properties);

@@clientLocation(VulnerabilityAssessmentScanRecords.get,
  "DatabaseVulnerabilityAssessmentScans"
);
@@clientLocation(VulnerabilityAssessmentScanRecords.listByDatabase,
  "DatabaseVulnerabilityAssessmentScans"
);
@@clientLocation(VulnerabilityAssessmentScanRecords.export,
  "DatabaseVulnerabilityAssessmentScans"
);
@@clientLocation(VulnerabilityAssessmentScanRecords.initiateScan,
  "DatabaseVulnerabilityAssessmentScans"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VulnerabilityAssessmentScanRecord.properties);

@@clientName(DataMaskingPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(DataMaskingPolicies.listByDatabase, "DataMaskingRules");
@@clientLocation(DataMaskingPolicies.dataMaskingRulesCreateOrUpdate,
  "DataMaskingRules"
);
@@clientName(DataMaskingPolicies.dataMaskingRulesCreateOrUpdate,
  "CreateOrUpdate"
);
@@clientName(DataMaskingPolicies.dataMaskingRulesCreateOrUpdate::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DataMaskingPolicy.properties);

@@clientLocation(DataWarehouseUserActivitiesOperationGroup.get,
  "DataWarehouseUserActivities"
);
@@clientLocation(DataWarehouseUserActivitiesOperationGroup.listByDatabase,
  "DataWarehouseUserActivities"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DataWarehouseUserActivities.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DeletedServer.properties);

@@clientName(DistributedAvailabilityGroups.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(DistributedAvailabilityGroups.update::parameters.properties,
  "parameters"
);
@@clientName(DistributedAvailabilityGroups.failover::parameters.body,
  "parameters"
);
@@clientName(DistributedAvailabilityGroups.setRole::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DistributedAvailabilityGroup.properties);

@@clientName(ElasticPools.createOrUpdate::parameters.resource, "parameters");
@@clientName(ElasticPools.update::parameters.properties, "parameters");
@@clientLocation(ElasticPools.listByElasticPool, Databases);
@@clientLocation(ElasticPools.elasticPoolOperationsListByElasticPool,
  "ElasticPoolOperations"
);
@@clientName(ElasticPools.elasticPoolOperationsListByElasticPool,
  "ListByElasticPool"
);
@@clientLocation(ElasticPools.cancel, "ElasticPoolOperations");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ElasticPool.properties);

@@clientName(EncryptionProtectors.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(EncryptionProtector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(EndpointCertificate.properties);

@@clientName(FailoverGroups.createOrUpdate::parameters.resource, "parameters");
@@clientName(FailoverGroups.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FailoverGroup.properties);

@@clientName(FirewallRules.createOrUpdate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FirewallRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServerImportExportOperationResult.properties);

@@clientName(GeoBackupPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(GeoBackupPolicy.properties);

@@clientName(InstanceFailoverGroups.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(InstanceFailoverGroup.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(InstancePoolOperation.properties);

@@clientName(InstancePools.createOrUpdate::parameters.resource, "parameters");
@@clientName(InstancePools.update::parameters.properties, "parameters");
@@clientLocation(InstancePools.listByInstancePool, ManagedInstances);
@@clientLocation(InstancePools.usagesListByInstancePool, "Usages");
@@clientName(InstancePools.usagesListByInstancePool, "ListByInstancePool");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(InstancePool.properties);

@@clientName(IPv6FirewallRules.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IPv6FirewallRule.properties);

@@clientName(JobAgents.createOrUpdate::parameters.resource, "parameters");
@@clientName(JobAgents.update::parameters.properties, "parameters");
@@clientLocation(JobAgents.listByAgent, JobExecutions);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(JobAgent.properties);

@@clientName(JobCredentials.createOrUpdate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(JobCredential.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(JobExecution.properties);

@@clientName(JobPrivateEndpoints.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(JobPrivateEndpoint.properties);

@@clientName(Jobs.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Jobs.create, JobExecutions);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Job.properties);

@@clientName(JobSteps.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(JobStepOperationGroup.getByVersion, JobSteps);
@@clientLocation(JobStepOperationGroup.listByVersion, JobSteps);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(JobStep.properties);

@@clientName(JobTargetGroups.createOrUpdate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(JobTargetGroup.properties);

@@clientLocation(LedgerDigestUploadsOperationGroup.get, "LedgerDigestUploads");
@@clientLocation(LedgerDigestUploadsOperationGroup.createOrUpdate,
  "LedgerDigestUploads"
);
@@clientName(LedgerDigestUploadsOperationGroup.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(LedgerDigestUploadsOperationGroup.listByDatabase,
  "LedgerDigestUploads"
);
@@clientLocation(LedgerDigestUploadsOperationGroup.disable,
  "LedgerDigestUploads"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LedgerDigestUploads.properties);

@@clientName(LongTermRetentionBackups.changeAccessTier::parameters.body,
  "parameters"
);
@@clientName(LongTermRetentionBackups.copy::parameters.body, "parameters");
@@clientName(LongTermRetentionBackups.update::parameters.body, "parameters");
@@clientLocation(LongTermRetentionBackupOperationGroup.getByResourceGroup,
  LongTermRetentionBackups
);
@@clientLocation(LongTermRetentionBackupOperationGroup.deleteByResourceGroup,
  LongTermRetentionBackups
);
@@clientLocation(LongTermRetentionBackupOperationGroup.listByResourceGroupDatabase,
  LongTermRetentionBackups
);
@@clientLocation(LongTermRetentionBackupOperationGroup.changeAccessTierByResourceGroup,
  LongTermRetentionBackups
);
@@clientName(LongTermRetentionBackupOperationGroup.changeAccessTierByResourceGroup::parameters.body,
  "parameters"
);
@@clientLocation(LongTermRetentionBackupOperationGroup.copyByResourceGroup,
  LongTermRetentionBackups
);
@@clientName(LongTermRetentionBackupOperationGroup.copyByResourceGroup::parameters.body,
  "parameters"
);
@@clientLocation(LongTermRetentionBackupOperationGroup.lockTimeBasedImmutabilityByResourceGroup,
  LongTermRetentionBackups
);
@@clientLocation(LongTermRetentionBackupOperationGroup.removeLegalHoldImmutabilityByResourceGroup,
  LongTermRetentionBackups
);
@@clientLocation(LongTermRetentionBackupOperationGroup.removeTimeBasedImmutabilityByResourceGroup,
  LongTermRetentionBackups
);
@@clientLocation(LongTermRetentionBackupOperationGroup.setLegalHoldImmutabilityByResourceGroup,
  LongTermRetentionBackups
);
@@clientLocation(LongTermRetentionBackupOperationGroup.updateByResourceGroup,
  LongTermRetentionBackups
);
@@clientName(LongTermRetentionBackupOperationGroup.updateByResourceGroup::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LongTermRetentionBackup.properties);

@@clientLocation(ManagedInstanceLongTermRetentionBackups.get,
  LongTermRetentionManagedInstanceBackups
);
@@clientLocation(ManagedInstanceLongTermRetentionBackups.delete,
  LongTermRetentionManagedInstanceBackups
);
@@clientLocation(ManagedInstanceLongTermRetentionBackups.listByDatabase,
  LongTermRetentionManagedInstanceBackups
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedInstanceLongTermRetentionBackup.properties);

@@clientName(LongTermRetentionPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LongTermRetentionPolicy.properties);

@@clientLocation(MaintenanceWindowOptionsOperationGroup.get,
  "MaintenanceWindowOptions"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MaintenanceWindowOptions.properties);

@@clientLocation(MaintenanceWindowsOperationGroup.get, "MaintenanceWindows");
@@clientLocation(MaintenanceWindowsOperationGroup.createOrUpdate,
  "MaintenanceWindows"
);
@@clientName(MaintenanceWindowsOperationGroup.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MaintenanceWindows.properties);

@@clientName(ManagedBackupShortTermRetentionPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ManagedBackupShortTermRetentionPolicies.update::parameters.properties,
  "parameters"
);
@@clientName(ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ManagedRestorableDroppedDatabaseBackupShortTermRetentionPolicies.update::parameters.properties,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedBackupShortTermRetentionPolicy.properties);

@@clientLocation(ManagedDatabaseAdvancedThreatProtections.get,
  "ManagedDatabaseAdvancedThreatProtectionSettings"
);
@@clientLocation(ManagedDatabaseAdvancedThreatProtections.createOrUpdate,
  "ManagedDatabaseAdvancedThreatProtectionSettings"
);
@@clientName(ManagedDatabaseAdvancedThreatProtections.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ManagedDatabaseAdvancedThreatProtections.listByDatabase,
  "ManagedDatabaseAdvancedThreatProtectionSettings"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedDatabaseAdvancedThreatProtection.properties);

@@clientLocation(ManagedDatabaseMoveOperationResults.get,
  "ManagedDatabaseMoveOperations"
);
@@clientLocation(ManagedDatabaseMoveOperationResults.listByLocation,
  "ManagedDatabaseMoveOperations"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedDatabaseMoveOperationResult.properties);

@@clientLocation(ManagedInstanceQueries.get, "ManagedDatabaseQueries");
@@clientLocation(ManagedInstanceQueries.listByQuery, "ManagedDatabaseQueries");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedInstanceQuery.properties);

@@clientLocation(ManagedDatabaseRestoreDetailsResults.get,
  "ManagedDatabaseRestoreDetails"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedDatabaseRestoreDetailsResult.properties);

@@clientName(ManagedDatabases.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ManagedDatabases.update::parameters.properties, "parameters");
@@clientLocation(ManagedDatabases.listByDatabase, ManagedDatabaseColumns);
@@clientName(ManagedDatabases.cancelMove::parameters.body, "parameters");
@@clientName(ManagedDatabases.completeMove::parameters.body, "parameters");
@@clientName(ManagedDatabases.completeRestore::parameters.body, "parameters");
@@clientName(ManagedDatabases.startMove::parameters.body, "parameters");
@@clientLocation(ManagedDatabases.managedDatabaseSecurityEventsListByDatabase,
  "ManagedDatabaseSecurityEvents"
);
@@clientName(ManagedDatabases.managedDatabaseSecurityEventsListByDatabase,
  "ListByDatabase"
);
@@clientLocation(ManagedDatabases.listCurrentByDatabase,
  "ManagedDatabaseSensitivityLabels"
);
@@clientLocation(ManagedDatabases.managedDatabaseSensitivityLabelsUpdate,
  "ManagedDatabaseSensitivityLabels"
);
@@clientName(ManagedDatabases.managedDatabaseSensitivityLabelsUpdate, "Update");
@@clientName(ManagedDatabases.managedDatabaseSensitivityLabelsUpdate::parameters.body,
  "parameters"
);
@@clientLocation(ManagedDatabases.listRecommendedByDatabase,
  "ManagedDatabaseSensitivityLabels"
);
@@clientLocation(ManagedDatabases.managedDatabaseRecommendedSensitivityLabelsUpdate,
  "ManagedDatabaseRecommendedSensitivityLabels"
);
@@clientName(ManagedDatabases.managedDatabaseRecommendedSensitivityLabelsUpdate,
  "Update"
);
@@clientName(ManagedDatabases.managedDatabaseRecommendedSensitivityLabelsUpdate::parameters.body,
  "parameters"
);
@@clientLocation(ManagedDatabases.managedDatabaseSensitivityLabelsListByDatabase,
  "ManagedDatabaseSensitivityLabels"
);
@@clientName(ManagedDatabases.managedDatabaseSensitivityLabelsListByDatabase,
  "ListByDatabase"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedDatabase.properties);

@@clientName(ManagedDatabaseSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedDatabaseSecurityAlertPolicy.properties);

@@clientLocation(SensitivityLabels.get, "ManagedDatabaseSensitivityLabels");
@@clientLocation(SensitivityLabels.createOrUpdate,
  "ManagedDatabaseSensitivityLabels"
);
@@clientName(SensitivityLabels.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(SensitivityLabels.delete, "ManagedDatabaseSensitivityLabels");
@@clientLocation(SensitivityLabels.disableRecommendation,
  "ManagedDatabaseSensitivityLabels"
);
@@clientLocation(SensitivityLabels.enableRecommendation,
  "ManagedDatabaseSensitivityLabels"
);
@@clientLocation(SensitivityLabelOperationGroup.get, SensitivityLabels);
@@clientLocation(SensitivityLabelOperationGroup.createOrUpdate,
  SensitivityLabels
);
@@clientName(SensitivityLabelOperationGroup.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(SensitivityLabelOperationGroup.delete, SensitivityLabels);
@@clientLocation(SensitivityLabelOperationGroup.disableRecommendation,
  SensitivityLabels
);
@@clientLocation(SensitivityLabelOperationGroup.enableRecommendation,
  SensitivityLabels
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SensitivityLabel.properties);

@@clientLocation(ManagedTransparentDataEncryptions.get,
  "ManagedDatabaseTransparentDataEncryption"
);
@@clientLocation(ManagedTransparentDataEncryptions.createOrUpdate,
  "ManagedDatabaseTransparentDataEncryption"
);
@@clientName(ManagedTransparentDataEncryptions.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ManagedTransparentDataEncryptions.listByDatabase,
  "ManagedDatabaseTransparentDataEncryption"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedTransparentDataEncryption.properties);

@@clientName(ManagedInstanceAdministrators.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedInstanceAdministrator.properties);

@@clientLocation(ManagedInstanceAdvancedThreatProtections.get,
  "ManagedInstanceAdvancedThreatProtectionSettings"
);
@@clientLocation(ManagedInstanceAdvancedThreatProtections.createOrUpdate,
  "ManagedInstanceAdvancedThreatProtectionSettings"
);
@@clientName(ManagedInstanceAdvancedThreatProtections.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ManagedInstanceAdvancedThreatProtections.listByInstance,
  "ManagedInstanceAdvancedThreatProtectionSettings"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedInstanceAdvancedThreatProtection.properties);

@@clientName(ManagedInstanceAzureADOnlyAuthentications.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedInstanceAzureADOnlyAuthentication.properties);

@@clientName(ManagedInstanceDtcs.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedInstanceDtc.properties);

@@clientName(ManagedInstanceEncryptionProtectors.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedInstanceEncryptionProtector.properties);

@@clientName(ManagedInstanceKeys.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedInstanceKey.properties);

@@clientName(ManagedInstanceLongTermRetentionPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedInstanceLongTermRetentionPolicy.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedInstanceOperation.properties);

@@clientName(ManagedInstancePrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedInstancePrivateEndpointConnection.properties);

@@clientLocation(ManagedInstancePrivateLinks.get,
  "ManagedInstancePrivateLinkResources"
);
@@clientLocation(ManagedInstancePrivateLinks.listByManagedInstance,
  "ManagedInstancePrivateLinkResources"
);

@@clientName(ManagedInstances.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ManagedInstances.update::parameters.properties, "parameters");
@@clientLocation(ManagedInstances.listInaccessibleByInstance, ManagedDatabases);
@@clientName(ManagedInstances.validateAzureKeyVaultEncryptionKey::parameters.body,
  "parameters"
);
@@clientLocation(ManagedInstances.create, "ManagedInstanceTdeCertificates");
@@clientName(ManagedInstances.create::parameters.body, "parameters");
@@clientLocation(ManagedInstances.listByInstance, ServerTrustGroups);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedInstance.properties);

@@clientName(ManagedInstanceVulnerabilityAssessments.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedInstanceVulnerabilityAssessment.properties);

@@clientLocation(ManagedLedgerDigestUploadsOperationGroup.get,
  "ManagedLedgerDigestUploads"
);
@@clientLocation(ManagedLedgerDigestUploadsOperationGroup.createOrUpdate,
  "ManagedLedgerDigestUploads"
);
@@clientName(ManagedLedgerDigestUploadsOperationGroup.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ManagedLedgerDigestUploadsOperationGroup.listByDatabase,
  "ManagedLedgerDigestUploads"
);
@@clientLocation(ManagedLedgerDigestUploadsOperationGroup.disable,
  "ManagedLedgerDigestUploads"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedLedgerDigestUploads.properties);

@@clientName(ManagedServerDnsAliases.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ManagedServerDnsAliases.acquire::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedServerDnsAlias.properties);

@@clientName(ManagedServerSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedServerSecurityAlertPolicy.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NetworkSecurityPerimeterConfiguration.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(OutboundFirewallRule.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RecoverableDatabase.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RecoverableManagedDatabase.properties);

@@clientName(ReplicationLinks.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ReplicationLinks.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ReplicationLink.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RestorableDroppedDatabase.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RestorableDroppedManagedDatabase.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RestorePoint.properties);

@@clientLocation(ServerAdvancedThreatProtections.get,
  "ServerAdvancedThreatProtectionSettings"
);
@@clientLocation(ServerAdvancedThreatProtections.createOrUpdate,
  "ServerAdvancedThreatProtectionSettings"
);
@@clientName(ServerAdvancedThreatProtections.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ServerAdvancedThreatProtections.listByServer,
  "ServerAdvancedThreatProtectionSettings"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServerAdvancedThreatProtection.properties);

@@clientLocation(ServerAutomaticTunings.get, "ServerAutomaticTuning");
@@clientLocation(ServerAutomaticTunings.update, "ServerAutomaticTuning");
@@clientName(ServerAutomaticTunings.update::parameters.properties,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServerAutomaticTuning.properties);

@@clientName(ServerAzureADAdministrators.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServerAzureADAdministrator.properties);

@@clientName(ServerAzureADOnlyAuthentications.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServerAzureADOnlyAuthentication.properties);

@@clientName(ServerConfigurationOptions.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServerConfigurationOption.properties);

@@clientName(ServerConnectionPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServerConnectionPolicy.properties);

@@clientName(ServerDevOpsAuditSettings.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServerDevOpsAuditingSettings.properties);

@@clientName(ServerDnsAliases.acquire::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServerDnsAlias.properties);

@@clientName(ServerKeys.createOrUpdate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServerKey.properties);

@@clientName(Servers.createOrUpdate::parameters.resource, "parameters");
@@clientName(Servers.update::parameters.properties, "parameters");
@@clientLocation(Servers.listInaccessibleByServer, Databases);
@@clientLocation(Servers.replace, FirewallRules);
@@clientName(Servers.replace::parameters.body, "parameters");
@@clientLocation(Servers.listByServer, ReplicationLinks);
@@clientLocation(Servers.serverOperationsListByServer, "ServerOperations");
@@clientName(Servers.serverOperationsListByServer, "ListByServer");
@@clientName(Servers.importDatabase::parameters.body, "parameters");
@@clientLocation(Servers.serverUsagesListByServer, "ServerUsages");
@@clientName(Servers.serverUsagesListByServer, "ListByServer");
@@clientLocation(Servers.create, "TdeCertificates");
@@clientName(Servers.create::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Server.properties);

@@clientName(ServerSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServerSecurityAlertPolicy.properties);

@@clientName(ServerTrustCertificates.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServerTrustCertificate.properties);

@@clientName(ServerTrustGroups.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServerTrustGroup.properties);

@@clientName(ServerVulnerabilityAssessments.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServerVulnerabilityAssessment.properties);

@@clientLocation(SqlAgentConfigurations.get, "SqlAgent");
@@clientLocation(SqlAgentConfigurations.createOrUpdate, "SqlAgent");
@@clientName(SqlAgentConfigurations.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SqlAgentConfiguration.properties);

@@clientName(StartStopManagedInstanceSchedules.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(StartStopManagedInstanceSchedule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SubscriptionUsage.properties);

@@clientName(SyncAgents.createOrUpdate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SyncAgent.properties);

@@clientName(SyncGroups.createOrUpdate::parameters.resource, "parameters");
@@clientName(SyncGroups.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SyncGroup.properties);

@@clientName(SyncMembers.createOrUpdate::parameters.resource, "parameters");
@@clientName(SyncMembers.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SyncMember.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(TimeZone.properties);

@@clientLocation(LogicalDatabaseTransparentDataEncryptions.get,
  "TransparentDataEncryptions"
);
@@clientLocation(LogicalDatabaseTransparentDataEncryptions.createOrUpdate,
  "TransparentDataEncryptions"
);
@@clientName(LogicalDatabaseTransparentDataEncryptions.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(LogicalDatabaseTransparentDataEncryptions.listByDatabase,
  "TransparentDataEncryptions"
);
@@clientLocation(LogicalDatabaseTransparentDataEncryptions.resume,
  "TransparentDataEncryptions"
);
@@clientLocation(LogicalDatabaseTransparentDataEncryptions.suspend,
  "TransparentDataEncryptions"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LogicalDatabaseTransparentDataEncryption.properties);

@@clientName(VirtualClusters.createOrUpdate::parameters.resource, "parameters");
@@clientName(VirtualClusters.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VirtualCluster.properties);

@@clientName(VirtualNetworkRules.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VirtualNetworkRule.properties);

@@clientName(WorkloadClassifiers.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(WorkloadClassifier.properties);

@@clientName(WorkloadGroups.createOrUpdate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(WorkloadGroup.properties);

@@clientLocation(DeletedServersOperationGroup.list, DeletedServers);

@@clientLocation(CapabilitiesOperationGroup.listByLocation, "Capabilities");

@@clientLocation(LongTermRetentionBackupsOperationGroup.listByLocation,
  LongTermRetentionBackups
);
@@clientLocation(LongTermRetentionBackupsOperationGroup.listByServer,
  LongTermRetentionBackups
);
@@clientLocation(LongTermRetentionBackupsOperationGroup.listByResourceGroupLocation,
  LongTermRetentionBackups
);
@@clientLocation(LongTermRetentionBackupsOperationGroup.listByResourceGroupServer,
  LongTermRetentionBackups
);

@@clientLocation(LongTermRetentionManagedInstanceBackupsOperationGroup.listByLocation,
  LongTermRetentionManagedInstanceBackups
);
@@clientLocation(LongTermRetentionManagedInstanceBackupsOperationGroup.listByInstance,
  LongTermRetentionManagedInstanceBackups
);
@@clientLocation(LongTermRetentionManagedInstanceBackupsOperationGroup.listByResourceGroupLocation,
  LongTermRetentionManagedInstanceBackups
);
@@clientLocation(LongTermRetentionManagedInstanceBackupsOperationGroup.listByResourceGroupInstance,
  LongTermRetentionManagedInstanceBackups
);

@@clientLocation(ServersOperationGroup.checkNameAvailability, Servers);

@@clientLocation(SyncGroupsOperationGroup.listSyncDatabaseIds, SyncGroups);

@@clientName(ServersOperationGroup.checkNameAvailability::parameters.body,
  "parameters"
);
@@visibility(ManagedInstancePrivateLink.properties, Lifecycle.Read);
@@visibility(PrivateLinkResource.properties, Lifecycle.Read);
@@doc(RestorableDroppedDatabase.location, "Resource location.");
@@clientName(Azure.ResourceManager.CommonTypes.SystemData,
  "systemdata",
  "!javascript,!python,!java,!go"
);
