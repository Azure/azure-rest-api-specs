import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Sql;

// TODO: remove this when breaking change is allowed
@@alternateType(SecurityAlertsPolicyProperties.state,
  SecurityAlertPolicyState,
  "java"
);
@@alternateType(ServerProperties.publicNetworkAccess,
  ServerNetworkAccessFlag,
  "java"
);

@@clientName(Microsoft.Sql, "SqlManagementClient", "java,javascript,python");

@@clientName(SyncAgentLinkedDatabaseProperties.userName, "username", "java");
@@clientName(SyncMemberProperties.userName, "username", "java");
@@clientName(SyncGroupProperties.hubDatabaseUserName,
  "hubDatabaseUsername",
  "java"
);

@@usage(ServerDnsAlias, Azure.ClientGenerator.Core.Usage.input, "java");

@@alternateType(CheckNameAvailabilityResourceType,
  "Microsoft.Sql/servers",
  "java"
);

@@alternateType(ServerProperties.minimalTlsVersion, string, "java");

@@clientName(DNSRefreshOperationStatus,
  "DnsRefreshConfigurationPropertiesStatus",
  "java"
);
@@clientName(ReplicationModeType, "ReplicationMode", "java");
@@clientName(UpsertManagedServerOperationStepWithEstimatesAndDurationStatus,
  "Status",
  "java"
);

@@clientName(SqlVulnerabilityAssessmentScanRecord,
  "VulnerabilityAssessmentScanRecordForSql",
  "go"
);
@@clientName(SqlVulnerabilityAssessmentScanRecordProperties,
  "VulnerabilityAssessmentScanRecordForSqlProperties",
  "go"
);
@@clientName(SqlVulnerabilityAssessmentScanError,
  "VulnerabilityAssessmentScanForSqlError",
  "go"
);

@@clientName(MinimalTlsVersion.`1.0`, "ONE0", "python");
@@clientName(MinimalTlsVersion.`1.1`, "ONE1", "python");
@@clientName(MinimalTlsVersion.`1.2`, "ONE2", "python");
@@clientName(MinimalTlsVersion.`1.3`, "ONE3", "python");

@@clientName(QueryTimeGrainType.PT1H, "PT1_H", "python");
@@clientName(QueryTimeGrainType.P1D, "P1_D", "python");

@@clientName(MinimalTlsVersion.`1.0`, "One0", "go");
@@clientName(MinimalTlsVersion.`1.1`, "One1", "go");
@@clientName(MinimalTlsVersion.`1.2`, "One2", "go");
@@clientName(MinimalTlsVersion.`1.3`, "One3", "go");

@@clientName(DiffBackupIntervalInHours.`12`, "Twelve", "go,javascript,python");
@@clientName(DiffBackupIntervalInHours.`24`, "TwentyFour", "go,javascript");
@@clientName(DiffBackupIntervalInHours.`24`, "Twenty_Four", "python");

@@clientName(AvailabilityZoneType.`1`, "One", "go,javascript");
@@clientName(AvailabilityZoneType.`2`, "Two", "go,javascript");
@@clientName(AvailabilityZoneType.`3`, "Three", "go,javascript");

@@clientName(AvailabilityZoneType.`1`, "ONE", "python");
@@clientName(AvailabilityZoneType.`2`, "TWO", "python");
@@clientName(AvailabilityZoneType.`3`, "THREE", "python");

@@alternateType(BlobAuditingPolicyName, "default", "go,javascript");
@@alternateType(CurrentSensitivityLabelSource, "current", "go,javascript");
@@alternateType(RecommendedSensitivityLabelSource,
  "recommended",
  "go,javascript"
);
@@alternateType(VulnerabilityAssessmentSystemDatabaseName,
  "master",
  "go,javascript"
);
@@alternateType(CheckNameAvailabilityResourceType,
  "Microsoft.Sql/servers",
  "go"
);
@@clientName(SqlVulnerabilityAssessmentScanRecordListResult,
  "VulnerabilityAssessmentScanRecordForSQLListResult ",
  "go"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "To mitigate breaking change for legacy Python SDK"
@@Legacy.clientDefaultValue(SensitivityLabelSourceAlias.sensitivityLabelSource,
  "current",
  "python"
);
@@alternateType(SensitivityLabelSourceAlias.sensitivityLabelSource,
  "current",
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "To mitigate breaking change for legacy Python SDK"
@@Legacy.clientDefaultValue(RecommendedSensitivityLabelSourceAlias.sensitivityLabelSource,
  "recommended",
  "python"
);
@@alternateType(RecommendedSensitivityLabelSourceAlias.sensitivityLabelSource,
  "recommended",
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "To mitigate breaking change for legacy Python SDK"
@@Legacy.clientDefaultValue(ServerBlobAuditingPolicyNameAlias.blobAuditingPolicyName,
  "default",
  "python"
);
@@alternateType(ServerBlobAuditingPolicyNameAlias.blobAuditingPolicyName,
  "default",
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "To mitigate breaking change for legacy Python SDK"
@@Legacy.clientDefaultValue(DatabaseBlobAuditingPolicyNameAlias.blobAuditingPolicyName,
  "default",
  "python"
);
@@alternateType(DatabaseBlobAuditingPolicyNameAlias.blobAuditingPolicyName,
  "default",
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "To mitigate breaking change for legacy Python SDK"
@@Legacy.clientDefaultValue(ExtendedDatabaseBlobAuditingPolicyNameAlias.blobAuditingPolicyName,
  "default",
  "python"
);
@@alternateType(ExtendedDatabaseBlobAuditingPolicyNameAlias.blobAuditingPolicyName,
  "default",
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "To mitigate breaking change for legacy Python SDK"
@@Legacy.clientDefaultValue(ExtendedServerBlobAuditingPolicyNameAlias.blobAuditingPolicyName,
  "default",
  "python"
);
@@alternateType(ExtendedServerBlobAuditingPolicyNameAlias.blobAuditingPolicyName,
  "default",
  "python"
);
