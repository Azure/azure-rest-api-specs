import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Oracle.Database;

@@clientName(Oracle.Database, "OracleDatabaseMgmt", "python");

// CSharp
@@clientName(DataCollectionOptions, "DiagnosticCollectionConfig", "csharp");
@@clientName(DbActionResponse, "DBActionResult", "csharp");
@@clientName(DbNode, "CloudVmClusterDBNode", "csharp");
@@clientName(DbNodeProperties, "CloudVmClusterDBNodeProperties", "csharp");
@@clientName(DbServer, "OracleDBServer", "csharp");
@@clientName(DbServerProperties, "OracleDBServerProperties", "csharp");
@@clientName(DbSystemShape, "OracleDBSystemShape", "csharp");
@@clientName(DbSystemShapeProperties,
  "OracleDBSystemShapeProperties",
  "csharp"
);
@@clientName(DnsPrivateView, "OracleDnsPrivateView", "csharp");
@@clientName(DnsPrivateViewProperties,
  "OracleDnsPrivateViewProperties",
  "csharp"
);
@@clientName(DnsPrivateZone, "OracleDnsPrivateZone", "csharp");
@@clientName(DnsPrivateZoneProperties,
  "OracleDnsPrivateZoneProperties",
  "csharp"
);
@@clientName(GiVersion, "OracleGIVersion", "csharp");
@@clientName(GiVersionProperties, "OracleGIVersionProperties", "csharp");
@@clientName(SystemVersion, "OracleSystemVersion", "csharp");
@@clientName(VirtualNetworkAddress,
  "CloudVmClusterVirtualNetworkAddress",
  "csharp"
);
@@clientName(VirtualNetworkAddressProperties,
  "CloudVmClusterVirtualNetworkAddressProperties",
  "csharp"
);
@@clientName(ActivationLinks, "CloudAccountActivationLinks", "csharp");
@@clientName(AllConnectionStringType,
  "AutonomousDatabaseConnectionStringType",
  "csharp"
);
@@clientName(AddRemoveDbNode, "CloudVmClusterDBNodeContent", "csharp");
@@clientName(ApexDetailsType, "OracleApexDetailsType", "csharp");
@@clientName(AutonomousDatabaseBaseProperties.dbVersion, "DBVersion", "csharp");
@@clientName(AutonomousDatabaseBaseProperties.dbWorkload,
  "DBWorkload",
  "csharp"
);
@@clientName(AutonomousDatabaseBaseProperties.timeCreated,
  "CreatedOn",
  "csharp"
);
@@clientName(AutonomousDatabaseBaseProperties.timeMaintenanceBegin,
  "MaintenanceBeginOn",
  "csharp"
);
@@clientName(AutonomousDatabaseBaseProperties.timeMaintenanceEnd,
  "MaintenanceEndOn",
  "csharp"
);
@@clientName(AutonomousDatabaseBaseProperties.nextLongTermBackupTimeStamp,
  "NextLongTermBackupCreatedOn",
  "csharp"
);
@@clientName(AutonomousDatabaseBaseProperties.timeDataGuardRoleChanged,
  "DataGuardRoleChangedOn",
  "csharp"
);
@@alternateType(AutonomousDatabaseBaseProperties.timeDataGuardRoleChanged,
  utcDateTime,
  "csharp"
);
@@clientName(AutonomousDatabaseBaseProperties.timeDeletionOfFreeAutonomousDatabase,
  "FreeAutonomousDatabaseDeletedOn",
  "csharp"
);
@@alternateType(AutonomousDatabaseBaseProperties.timeDeletionOfFreeAutonomousDatabase,
  utcDateTime,
  "csharp"
);
@@clientName(AutonomousDatabaseBaseProperties.timeLocalDataGuardEnabled,
  "LocalDataGuardEnabledOn",
  "csharp"
);
@@alternateType(AutonomousDatabaseBaseProperties.timeLocalDataGuardEnabled,
  utcDateTime,
  "csharp"
);
@@clientName(AutonomousDatabaseBaseProperties.timeOfLastFailover,
  "LastFailoverHappenedOn",
  "csharp"
);
@@alternateType(AutonomousDatabaseBaseProperties.timeOfLastFailover,
  utcDateTime,
  "csharp"
);
@@clientName(AutonomousDatabaseBaseProperties.timeOfLastRefresh,
  "LastRefreshHappenedOn",
  "csharp"
);
@@alternateType(AutonomousDatabaseBaseProperties.timeOfLastRefresh,
  utcDateTime,
  "csharp"
);
@@clientName(AutonomousDatabaseBaseProperties.timeOfLastRefreshPoint,
  "LastRefreshPointTimestamp",
  "csharp"
);
@@alternateType(AutonomousDatabaseBaseProperties.timeOfLastRefreshPoint,
  utcDateTime,
  "csharp"
);
@@clientName(AutonomousDatabaseBaseProperties.timeOfLastSwitchover,
  "LastSwitchoverHappenedOn",
  "csharp"
);
@@alternateType(AutonomousDatabaseBaseProperties.timeOfLastSwitchover,
  utcDateTime,
  "csharp"
);
@@clientName(AutonomousDatabaseBaseProperties.timeReclamationOfFreeAutonomousDatabase,
  "FreeAutonomousDatabaseStoppedOn",
  "csharp"
);
@@alternateType(AutonomousDatabaseBaseProperties.timeReclamationOfFreeAutonomousDatabase,
  utcDateTime,
  "csharp"
);
@@clientName(AutonomousDatabaseBaseProperties.timeDisasterRecoveryRoleChanged,
  "DisasterRecoveryRoleChangedOn",
  "csharp"
);
@@clientName(AutonomousDatabaseBaseProperties.dbVersion, "DBVersion", "csharp");
@@alternateType(AutonomousDatabaseBaseProperties.ociUrl, url, "csharp");
@@alternateType(AutonomousDatabaseBaseProperties.serviceConsoleUrl,
  url,
  "csharp"
);
@@alternateType(AutonomousDatabaseBaseProperties.sqlWebDeveloperUrl,
  url,
  "csharp"
);
@@clientName(AutonomousDatabaseBaseProperties.localStandbyDb,
  "LocalStandbyDB",
  "csharp"
);
@@clientName(AutonomousDatabaseBaseProperties.peerDbIds, "PeerDBIds", "csharp");
@@clientName(AutonomousDatabaseBaseProperties.peerDbId, "peerDBId", "csharp");
@@clientName(AutonomousDatabaseCloneProperties.timeUntilReconnectCloneEnabled,
  "ReconnectCloneEnabledOn",
  "csharp"
);
@@alternateType(AutonomousDatabaseCloneProperties.timeUntilReconnectCloneEnabled,
  utcDateTime,
  "csharp"
);
@@clientName(AutonomousDatabaseStandbySummary.timeDataGuardRoleChanged,
  "DataGuardRoleChangedOn",
  "csharp"
);
@@alternateType(AutonomousDatabaseStandbySummary.timeDataGuardRoleChanged,
  utcDateTime,
  "csharp"
);
@@clientName(AutonomousDatabaseStandbySummary.timeDisasterRecoveryRoleChanged,
  "DisasterRecoveryRoleChangedOn",
  "csharp"
);
@@alternateType(AutonomousDatabaseStandbySummary.timeDisasterRecoveryRoleChanged,
  utcDateTime,
  "csharp"
);
@@clientName(AzureResourceProvisioningState,
  "OracleDatabaseProvisioningState",
  "csharp"
);
@@clientName(CloneType, "AutonomousDatabaseCloneType", "csharp");

@@clientName(CloudExadataInfrastructureProperties.timeCreated,
  "CreatedOn",
  "csharp"
);
@@alternateType(CloudExadataInfrastructureProperties.timeCreated,
  utcDateTime,
  "csharp"
);
@@clientName(CloudVmClusterProperties.timeCreated, "CreatedOn", "csharp");
@@alternateType(CloudVmClusterProperties.timeCreated, utcDateTime, "csharp");
@@clientName(VirtualNetworkAddressProperties.timeAssigned,
  "AssignedOn",
  "csharp"
);
@@alternateType(VirtualNetworkAddressProperties.timeAssigned,
  utcDateTime,
  "csharp"
);
@@clientName(ComputeModel, "AutonomousDatabaseComputeModel", "csharp");
@@clientName(ComputeModel.ECPU, "Ecpu", "csharp");
@@clientName(ComputeModel.OCPU, "Ocpu", "csharp");
@@clientName(ConnectionStringType,
  "AutonomousDatabaseConnectionStrings",
  "csharp"
);
@@clientName(ProfileType,
  "AutonomousDatabaseConnectionStringProfile",
  "csharp"
);
@@clientName(ConnectionUrlType, "AutonomousDatabaseConnectionUrls", "csharp");
@@alternateType(ConnectionUrlType.apexUrl, url, "csharp");
@@alternateType(ConnectionUrlType.databaseTransformsUrl, url, "csharp");
@@alternateType(ConnectionUrlType.graphStudioUrl, url, "csharp");
@@alternateType(ConnectionUrlType.machineLearningNotebookUrl, url, "csharp");
@@clientName(ConnectionUrlType.mongoDbUrl, "mongoDBUrl", "csharp");
@@alternateType(ConnectionUrlType.mongoDbUrl, url, "csharp");
@@alternateType(ConnectionUrlType.ordsUrl, url, "csharp");
@@alternateType(ConnectionUrlType.sqlDevWebUrl, url, "csharp");
@@clientName(ConsumerGroup, "ConnectionConsumerGroup", "csharp");
@@clientName(CustomerContact, "OracleCustomerContact", "csharp");
@@clientName(DatabaseEditionType, "OracleDatabaseEditionType", "csharp");
@@clientName(DataBaseType, "OracleDataBaseType", "csharp");
@@clientName(DbNodeActionEnum, "DBNodeActionType", "csharp");
@@clientName(DbServerPatchingDetails.timePatchingEnded,
  "PatchingEndedOn",
  "csharp"
);
@@clientName(DbServerPatchingDetails.timePatchingStarted,
  "PatchingStartedOn",
  "csharp"
);
@@clientName(DbServerProperties.timeCreated, "CreatedOn", "csharp");
@@alternateType(DbServerProperties.exadataInfrastructureId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(DiskRedundancy, "CloudVmClusterDiskRedundancy", "csharp");
@@clientName(DnsPrivateViewProperties.timeCreated, "CreatedOn", "csharp");
@@clientName(DnsPrivateViewProperties.timeUpdated, "UpdatedOn", "csharp");
@@clientName(DnsPrivateZoneProperties.timeCreated, "CreatedOn", "csharp");
@@clientName(GenerateType, "WalletGenerateType", "csharp");
@@clientName(HostFormatType, "ConnectionHostFormatType", "csharp");
@@clientName(Intent, "OracleSubscriptionUpdateIntent", "csharp");
@@clientName(LicenseModel, "OracleLicenseModel", "csharp");
@@clientName(LongTermBackUpScheduleDetails.timeOfBackup, "BackupOn", "csharp");
@@clientName(Month, "MaintenanceMonth", "csharp");
@@clientName(MonthName, "MaintenanceMonthName", "csharp");
@@clientName(NsgCidr, "CloudVmClusterNsgCidr", "csharp");
@@clientName(Objective, "IormObjective", "csharp");
@@clientName(OpenModeType, "AutonomousDatabaseModeType", "csharp");
@@clientName(PatchingMode, "MaintenancePatchingMode", "csharp");
@@clientName(PeerDbDetails, "AutonomousDatabaseActionContent", "csharp");
@@clientName(PeerDbDetails.peerDbId, "peerDBId", "csharp");
@@clientName(PeerDbDetails.peerDbOcid, "peerDBOcid", "csharp");
@@clientName(PeerDbDetails.peerDbLocation, "peerDBLocation", "csharp");
@@clientName(PermissionLevelType,
  "AutonomousDatabasePermissionLevelType",
  "csharp"
);
@@clientName(PortRange, "CloudVmClusterPortRange", "csharp");
@@clientName(Preference, "MaintenancePreference", "csharp");
@@clientName(PrivateIpAddressesFilter, "PrivateIPAddressesContent", "csharp");
@@clientName(PrivateIpAddressProperties, "PrivateIPAddressResult", "csharp");
@@alternateType(PrivateIpAddressProperties.subnetId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(ProtocolType, "ConnectionProtocolType", "csharp");
@@clientName(ProtocolType.TCP, "Tcp", "csharp");
@@clientName(Azure.ResourceManager.ResourceProvisioningState,
  "OracleDatabaseResourceProvisioningState",
  "csharp"
);
@@clientName(RoleType, "DataGuardRoleType", "csharp");
@@clientName(SaasSubscriptionDetails.timeCreated, "CreatedOn", "csharp");

@@clientName(ScheduledOperationsType.scheduledStartTime,
  "AutoStartOn",
  "csharp"
);
@@alternateType(ScheduledOperationsType.scheduledStartTime, "csharp");
@@clientName(ScheduledOperationsType.scheduledStopTime, "AutoStopOn", "csharp");
@@alternateType(ScheduledOperationsType.scheduledStopTime, "csharp");
@@clientName(SessionModeType, "ConnectionSessionModeType", "csharp");
@@clientName(SourceType, "AutonomousDatabaseSourceType", "csharp");
@@clientName(SyntaxFormatType.Ezconnectplus, "EzconnectPlus", "csharp");
@@clientName(SystemVersionProperties,
  "OracleSystemVersionProperties",
  "csharp"
);
@@clientName(TlsAuthenticationType,
  "ConnectionTlsAuthenticationType",
  "csharp"
);
@@clientName(WorkloadType, "AutonomousDatabaseWorkloadType", "csharp");
@@clientName(WorkloadType.AJD, "Ajd", "csharp");
@@clientName(WorkloadType.APEX, "Apex", "csharp");
@@clientName(WorkloadType.OLTP, "Oltp", "csharp");
@@clientName(ZoneType, "OracleDnsPrivateZoneType", "csharp");
@@clientName(DnsPrivateZoneProperties.lifecycleState,
  "DnsPrivateZoneLifecycleState",
  "csharp"
);
@@clientName(DnsPrivateViewProperties.lifecycleState,
  "DnsPrivateViewLifecycleState",
  "csharp"
);
@@clientName(DbNodeProperties.lifecycleState, "DBNodeLifecycleState", "csharp");
@@clientName(DbNodeProperties.timeCreated, "DBNodeTimeCreated", "csharp");
@@clientName(AutonomousDbVersionProperties,
  "AutonomousDBVersionProperties",
  "csharp"
);
@@clientName(AutonomousDbVersionProperties.dbWorkload, "DBWorkload", "csharp");
@@clientName(DbNodeProvisioningState, "DBNodeProvisioningState", "csharp");
@@clientName(DbNodeMaintenanceType, "DBNodeMaintenanceType", "csharp");
@@clientName(AutonomousDbVersion, "AutonomousDBVersion", "csharp");
@@clientName(ExascaleDbNode, "ExascaleDBNode", "csharp");
@@clientName(ExascaleDbNodeProperties, "ExascaleDBNodeProperties", "csharp");
@@clientName(ExascaleDbStorageVault, "ExascaleDBStorageVault", "csharp");
@@clientName(ExascaleDbStorageVaultProperties,
  "ExascaleDBStorageVaultProperties",
  "csharp"
);
@@clientName(FlexComponent, "OracleFlexComponent", "csharp");
@@clientName(FlexComponentProperties,
  "OracleFlexComponentProperties",
  "csharp"
);
@@clientName(GiVersion, "OracleGIVersion", "csharp");
@@clientName(GiVersionProperties, "OracleGIVersionProperties", "csharp");
@@clientName(GiMinorVersion, "OracleGIMinorVersion", "csharp");
@@clientName(GiMinorVersionProperties,
  "OracleGIMinorVersionProperties",
  "csharp"
);
@@clientName(AutonomousDatabaseBackupProperties.dbVersion,
  "DBVersion",
  "csharp"
);
@@clientName(AzureSubscriptions,
  "OracleAzureSubscriptionsContent",
  "csharp"
);