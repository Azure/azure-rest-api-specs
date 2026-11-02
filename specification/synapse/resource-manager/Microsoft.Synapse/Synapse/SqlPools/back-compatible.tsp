import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace SqlPools;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlPoolPatchInfo.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlPoolOperation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SensitivityLabelUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RecommendedSensitivityLabelUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlPoolVulnerabilityAssessmentScansExport.properties);

@@clientName(SqlPools.create::parameters.resource, "sqlPoolInfo");
@@clientName(SqlPools.update::parameters.properties, "sqlPoolInfo");
@@clientLocation(SqlPools.sqlPoolRestorePointsCreate, "SqlPoolRestorePoints");
@@clientName(SqlPools.sqlPoolRestorePointsCreate, "Create");
@@clientName(
  SqlPools.sqlPoolRestorePointsCreate::parameters.body,
  "parameters"
);
@@clientLocation(SqlPools.list, "SqlPoolOperations");
@@clientLocation(SqlPools.sqlPoolUsagesList, "SqlPoolUsages");
@@clientName(SqlPools.sqlPoolUsagesList, "List");
@@clientLocation(SqlPools.listCurrent, "SqlPoolSensitivityLabels");
@@clientLocation(
  SqlPools.sqlPoolSensitivityLabelsUpdate,
  "SqlPoolSensitivityLabels"
);
@@clientName(SqlPools.sqlPoolSensitivityLabelsUpdate, "Update");
@@clientName(
  SqlPools.sqlPoolSensitivityLabelsUpdate::parameters.body,
  "parameters"
);
@@clientLocation(SqlPools.listRecommended, "SqlPoolSensitivityLabels");
@@clientLocation(
  SqlPools.sqlPoolRecommendedSensitivityLabelsUpdate,
  "SqlPoolRecommendedSensitivityLabels"
);
@@clientName(SqlPools.sqlPoolRecommendedSensitivityLabelsUpdate, "Update");
@@clientName(
  SqlPools.sqlPoolRecommendedSensitivityLabelsUpdate::parameters.body,
  "parameters"
);
@@clientLocation(SqlPoolOperationResults.listByWorkspace, SqlPools);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlPool.properties);

@@clientLocation(GeoBackupPolicies.get, "SqlPoolGeoBackupPolicies");
@@clientLocation(GeoBackupPolicies.createOrUpdate, "SqlPoolGeoBackupPolicies");
@@clientName(
  GeoBackupPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(GeoBackupPolicies.list, "SqlPoolGeoBackupPolicies");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(GeoBackupPolicy.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DataWarehouseUserActivities.properties);

@@clientLocation(RestorePoints.get, "SqlPoolRestorePoints");
@@clientLocation(RestorePoints.delete, "SqlPoolRestorePoints");
@@clientLocation(RestorePoints.list, "SqlPoolRestorePoints");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RestorePoint.properties);

@@clientLocation(ReplicationLinks.getByName, "SqlPoolReplicationLinks");
@@clientLocation(ReplicationLinks.list, "SqlPoolReplicationLinks");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ReplicationLink.properties);

@@clientName(
  SqlPoolMaintenanceWindows.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MaintenanceWindows.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MaintenanceWindowOptions.properties);

@@clientLocation(
  TransparentDataEncryptions.get,
  "SqlPoolTransparentDataEncryptions"
);
@@clientLocation(
  TransparentDataEncryptions.createOrUpdate,
  "SqlPoolTransparentDataEncryptions"
);
@@clientName(
  TransparentDataEncryptions.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(
  TransparentDataEncryptions.list,
  "SqlPoolTransparentDataEncryptions"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(TransparentDataEncryption.properties);

@@clientName(
  SqlPoolBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlPoolBlobAuditingPolicy.properties);

@@clientLocation(SensitivityLabels.get, "SqlPoolSensitivityLabels");
@@clientLocation(SensitivityLabels.createOrUpdate, "SqlPoolSensitivityLabels");
@@clientName(
  SensitivityLabels.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(SensitivityLabels.delete, "SqlPoolSensitivityLabels");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SensitivityLabel.properties);

@@clientLocation(SqlPoolColumns.listByTableName, "SqlPoolTableColumns");
@@clientLocation(
  SqlPoolColumns.enableRecommendation,
  "SqlPoolSensitivityLabels"
);
@@clientLocation(
  SqlPoolColumns.disableRecommendation,
  "SqlPoolSensitivityLabels"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlPoolColumn.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlPoolConnectionPolicy.properties);

@@clientName(
  SqlPoolVulnerabilityAssessments.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlPoolVulnerabilityAssessment.properties);

@@clientLocation(
  VulnerabilityAssessmentScanRecords.get,
  "SqlPoolVulnerabilityAssessmentScans"
);
@@clientLocation(
  VulnerabilityAssessmentScanRecords.list,
  "SqlPoolVulnerabilityAssessmentScans"
);
@@clientLocation(
  VulnerabilityAssessmentScanRecords.initiateScan,
  "SqlPoolVulnerabilityAssessmentScans"
);
@@clientLocation(
  VulnerabilityAssessmentScanRecords.export,
  "SqlPoolVulnerabilityAssessmentScans"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(VulnerabilityAssessmentScanRecord.properties);

@@clientName(
  SqlPoolSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlPoolSecurityAlertPolicy.properties);

@@clientName(
  SqlPoolVulnerabilityAssessmentRuleBaselines.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlPoolVulnerabilityAssessmentRuleBaseline.properties);

@@clientName(
  ExtendedSqlPoolBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ExtendedSqlPoolBlobAuditingPolicy.properties);

@@clientName(
  DataMaskingPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DataMaskingPolicy.properties);

@@clientName(
  DataMaskingRules.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DataMaskingRule.properties);

@@clientLocation(WorkloadGroups.get, "SqlPoolWorkloadGroup");
@@clientLocation(WorkloadGroups.createOrUpdate, "SqlPoolWorkloadGroup");
@@clientName(WorkloadGroups.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(WorkloadGroups.delete, "SqlPoolWorkloadGroup");
@@clientLocation(WorkloadGroups.list, "SqlPoolWorkloadGroup");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WorkloadGroup.properties);

@@clientLocation(WorkloadClassifiers.get, "SqlPoolWorkloadClassifier");
@@clientLocation(
  WorkloadClassifiers.createOrUpdate,
  "SqlPoolWorkloadClassifier"
);
@@clientName(
  WorkloadClassifiers.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(WorkloadClassifiers.delete, "SqlPoolWorkloadClassifier");
@@clientLocation(WorkloadClassifiers.list, "SqlPoolWorkloadClassifier");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WorkloadClassifier.properties);

@@clientLocation(
  ServerBlobAuditingPolicies.get,
  "WorkspaceManagedSqlServerBlobAuditingPolicies"
);
@@clientLocation(
  ServerBlobAuditingPolicies.createOrUpdate,
  "WorkspaceManagedSqlServerBlobAuditingPolicies"
);
@@clientName(
  ServerBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(
  ServerBlobAuditingPolicies.listByWorkspace,
  "WorkspaceManagedSqlServerBlobAuditingPolicies"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ServerBlobAuditingPolicy.properties);

@@clientLocation(
  ExtendedServerBlobAuditingPolicies.get,
  "WorkspaceManagedSqlServerExtendedBlobAuditingPolicies"
);
@@clientLocation(
  ExtendedServerBlobAuditingPolicies.createOrUpdate,
  "WorkspaceManagedSqlServerExtendedBlobAuditingPolicies"
);
@@clientName(
  ExtendedServerBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(
  ExtendedServerBlobAuditingPolicies.listByWorkspace,
  "WorkspaceManagedSqlServerExtendedBlobAuditingPolicies"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ExtendedServerBlobAuditingPolicy.properties);

@@clientLocation(
  ServerSecurityAlertPolicies.get,
  "WorkspaceManagedSqlServerSecurityAlertPolicy"
);
@@clientLocation(
  ServerSecurityAlertPolicies.createOrUpdate,
  "WorkspaceManagedSqlServerSecurityAlertPolicy"
);
@@clientName(
  ServerSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(
  ServerSecurityAlertPolicies.list,
  "WorkspaceManagedSqlServerSecurityAlertPolicy"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ServerSecurityAlertPolicy.properties);

@@clientLocation(
  ServerVulnerabilityAssessments.get,
  "WorkspaceManagedSqlServerVulnerabilityAssessments"
);
@@clientLocation(
  ServerVulnerabilityAssessments.createOrUpdate,
  "WorkspaceManagedSqlServerVulnerabilityAssessments"
);
@@clientName(
  ServerVulnerabilityAssessments.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(
  ServerVulnerabilityAssessments.delete,
  "WorkspaceManagedSqlServerVulnerabilityAssessments"
);
@@clientLocation(
  ServerVulnerabilityAssessments.list,
  "WorkspaceManagedSqlServerVulnerabilityAssessments"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ServerVulnerabilityAssessment.properties);

@@clientLocation(
  EncryptionProtectors.get,
  "WorkspaceManagedSqlServerEncryptionProtector"
);
@@clientLocation(
  EncryptionProtectors.createOrUpdate,
  "WorkspaceManagedSqlServerEncryptionProtector"
);
@@clientName(
  EncryptionProtectors.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(
  EncryptionProtectors.list,
  "WorkspaceManagedSqlServerEncryptionProtector"
);
@@clientLocation(
  EncryptionProtectors.revalidate,
  "WorkspaceManagedSqlServerEncryptionProtector"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(EncryptionProtector.properties);

@@clientLocation(
  RecoverableSqlPools.get,
  "WorkspaceManagedSqlServerRecoverableSqlPools"
);
@@clientLocation(
  RecoverableSqlPools.list,
  "WorkspaceManagedSqlServerRecoverableSqlPools"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RecoverableSqlPool.properties);

@@clientName(
  WorkspaceManagedSqlServerDedicatedSQLMinimalTlsSettings.update::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DedicatedSQLminimalTlsSettings.properties);

@@clientLocation(
  WorkspaceManagedSqlServerUsagesOperationGroup.list,
  "WorkspaceManagedSqlServerUsages"
);
