import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Oracle.Database;

@@clientName(Oracle.Database, "OracleDatabaseMgmt", "python");
@@clientName(Oracle.Database, "OracleDatabaseManagementClient", "javascript");

// CSharp
@@clientName(DataCollectionOptions, "DiagnosticCollectionConfig", "csharp");
@@clientName(DbActionResponse, "ExascaleDBNodeActionResult", "csharp");
@@clientName(DbNode, "CloudVmClusterDBNode", "csharp");
@@clientName(DbNodeProperties, "CloudVmClusterDBNodeProperties", "csharp");
@@clientName(DbNodeProperties.lifecycleState, "DBNodeLifecycleState", "csharp");
@@clientName(DbNodeProperties.timeCreated, "CreatedOn", "csharp");
@@clientName(DbNodeProperties.dbNodeStorageSizeInGbs,
  "DBNodeStorageSizeInGbs",
  "csharp"
);
@@clientName(DbServer, "OracleDBServer", "csharp");
@@clientName(DbServerProperties, "OracleDBServerProperties", "csharp");
@@clientName(DbServerProperties.dbServerPatchingDetails,
  "DBServerPatchingDetails",
  "csharp"
);
@@clientName(DbServerProperties.dbNodeStorageSizeInGbs,
  "DBNodeStorageSizeInGbs",
  "csharp"
);
@@clientName(DbServerProperties.maxDbNodeStorageInGbs,
  "MaxDBNodeStorageInGbs",
  "csharp"
);
@@clientName(DbSystemShape, "OracleDBSystemShape", "csharp");
@@clientName(DbSystemShapeProperties,
  "OracleDBSystemShapeProperties",
  "csharp"
);
@@clientName(DbSystemShapeProperties.availableDbNodePerNodeInGbs,
  "AvailableDBNodePerNodeInGbs",
  "csharp"
);
@@clientName(DbSystemShapeProperties.availableDbNodeStorageInGbs,
  "AvailableDBNodeStorageInGbs",
  "csharp"
);
@@clientName(DbSystemShapeProperties.minDbNodeStoragePerNodeInGbs,
  "MinDBNodeStoragePerNodeInGbs",
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
@@clientName(AddRemoveDbNode.dbServers, "DBServerOcids", "csharp");
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
@@clientName(CloudExadataInfrastructureProperties.dbNodeStorageSizeInGbs,
  "DBNodeStorageSizeInGbs",
  "csharp"
);
@@clientName(CloudExadataInfrastructureProperties.maxDbNodeStorageSizeInGbs,
  "MaxDBNodeStorageSizeInGbs",
  "csharp"
);
@@clientName(CloudExadataInfrastructureProperties.monthlyDbServerVersion,
  "MonthlyDBServerVersion",
  "csharp"
);
@@clientName(CloudExadataInfrastructureProperties.dbServerVersion,
  "DBServerVersion",
  "csharp"
);
@@clientName(CloudVmClusterProperties.timeCreated, "CreatedOn", "csharp");
@@alternateType(CloudVmClusterProperties.timeCreated, utcDateTime, "csharp");
@@clientName(CloudVmClusterProperties.timeCreated, "CreatedOn", "csharp");
@@clientName(CloudVmClusterProperties.dbNodeStorageSizeInGbs,
  "DBNodeStorageSizeInGbs",
  "csharp"
);
@@clientName(ExadbVmClusterProperties.exascaleDbStorageVaultId,
  "ExascaleDBStorageVaultId",
  "csharp"
);
@@clientName(VirtualNetworkAddressProperties.timeAssigned,
  "AssignedOn",
  "csharp"
);
@@alternateType(VirtualNetworkAddressProperties.timeAssigned,
  utcDateTime,
  "csharp"
);
@@clientName(ComputeModel, "OracleDatabaseComputeModel", "csharp");
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
@@clientName(DbServerPatchingStatus, "DBServerPatchingStatus", "csharp");
@@clientName(DbServerPatchingDetails, "DBServerPatchingDetails", "csharp");
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
@@clientName(ProtocolType, "ConnectionProtocolType", "csharp");
@@clientName(ProtocolType.TCP, "Tcp", "csharp");
@@clientName(ProtocolType.TCPS, "Tcps", "csharp");
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
@@alternateType(ScheduledOperationsType.scheduledStartTime,
  utcDateTime,
  "csharp"
);
@@clientName(ScheduledOperationsType.scheduledStopTime, "AutoStopOn", "csharp");
@@alternateType(ScheduledOperationsType.scheduledStopTime,
  utcDateTime,
  "csharp"
);
@@clientName(ScheduledOperationsTypeUpdate.scheduledStartTime,
  "AutoStartOn",
  "csharp"
);
@@alternateType(ScheduledOperationsTypeUpdate.scheduledStartTime,
  utcDateTime,
  "csharp"
);
@@clientName(ScheduledOperationsTypeUpdate.scheduledStopTime,
  "AutoStopOn",
  "csharp"
);
@@alternateType(ScheduledOperationsTypeUpdate.scheduledStopTime,
  utcDateTime,
  "csharp"
);
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
@@clientName(ExascaleDbNodeProperties.dbNodeStorageSizeInGbs,
  "DBNodeStorageSizeInGbs",
  "csharp"
);
@@clientName(ExascaleDbNodeProperties.timeMaintenanceWindowEnd,
  "MaintenanceWindowEndOn",
  "csharp"
);
@@clientName(ExascaleDbNodeProperties.timeMaintenanceWindowStart,
  "MaintenanceWindowStartOn",
  "csharp"
);
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
@@clientName(FlexComponentProperties.availableDbStorageInGbs,
  "AvailableDBStorageInGbs",
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
@@clientName(AzureSubscriptions, "OracleAzureSubscriptionsContent", "csharp");
@@clientName(MaintenanceWindow, "OracleDatabaseMaintenanceWindow", "csharp");
@@clientName(DayOfWeek, "OracleDatabaseDayOfWeek", "csharp");
@@clientName(DayOfWeekName, "OracleDatabaseDayOfWeekName", "csharp");
@@clientName(DayOfWeekUpdate, "OracleDatabaseDayOfWeekUpdate", "csharp");
@@clientName(DbIormConfig, "DBIormConfig", "csharp");
@@clientName(DbIormConfig.dbName, "DBName", "csharp");
@@clientName(DbNodeAction, "DBNodeAction", "csharp");
@@clientName(DbNodeDetails, "DBNodeDetails", "csharp");
@@clientName(DbNodeDetails.dbNodeId, "DBNodeId", "csharp");
@@clientName(DbServerProvisioningState, "DBServerProvisioningState", "csharp");
@@clientName(EstimatedPatchingTime.estimatedDbServerPatchingTime,
  "EstimatedDBServerPatchingTime",
  "csharp"
);
@@clientName(ExadataIormConfig.dbPlans, "DBPlans", "csharp");
@@clientName(HardwareType, "FlexComponentHardwareType", "csharp");
@@clientName(HardwareType.COMPUTE, "Compute", "csharp");
@@clientName(HardwareType.CELL, "Cell", "csharp");
@@clientName(RemoveVirtualMachineFromExadbVmClusterDetails.dbNodes,
  "DBNodes",
  "csharp"
);
@@clientName(ShapeFamily, "GIMinorVersionShapeFamily", "csharp");
@@clientName(ShapeFamily.ExadbXs, "ExadbXS", "csharp");
@@clientName(SystemShapes, "OracleDatabaseSystemShape", "csharp");
@@clientName(SystemShapes.ExaDbXs, "ExadbXS", "csharp");
@@clientName(ExascaleDbStorageDetails, "ExascaleDBStorageDetails", "csharp");
@@clientName(ExascaleDbStorageVaultLifecycleState,
  "ExascaleDBStorageVaultLifecycleState",
  "csharp"
);
@@clientName(ExascaleDbStorageInputDetails,
  "ExascaleDBStorageInputDetails",
  "csharp"
);
@@clientName(AutonomousDatabaseUpdateProperties.peerDbId, "peerDBId", "csharp");

@@usage(AutonomousDatabaseCharacterSetProperties,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(AutonomousDatabaseUpdateProperties,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(AutonomousDatabaseNationalCharacterSetProperties,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(GiVersionProperties, Usage.input | Usage.output, "csharp");
@@usage(SystemVersionProperties, Usage.input | Usage.output, "csharp");
// Addressing Ocid type issue
@@clientName(AutonomousDatabaseBackupProperties.autonomousDatabaseOcid,
  "DatabaseOcid",
  "csharp"
);
@@clientName(AutonomousDatabaseBackupProperties.ocid,
  "DatabaseBackupOcid",
  "csharp"
);
@@clientName(CloudExadataInfrastructureProperties.lastMaintenanceRunId,
  "LastMaintenanceRunOcid",
  "csharp"
);
@@clientName(CloudExadataInfrastructureProperties.nextMaintenanceRunId,
  "NextMaintenanceRunOcid",
  "csharp"
);
@@clientName(CloudExadataInfrastructureProperties.ocid,
  "ExadataInfraOcid",
  "csharp"
);
@@clientName(DbNodeProperties.ocid, "DBNodeOcid", "csharp");
@@clientName(DbNodeProperties.backupIpId, "BackupIPOcid", "csharp");
@@clientName(DbNodeProperties.backupVnic2Id, "BackupVnic2Ocid", "csharp");
@@clientName(DbNodeProperties.backupVnicId, "BackupVnicOcid", "csharp");
@@clientName(DbNodeProperties.dbServerId, "DBServerOcid", "csharp");
@@clientName(DbNodeProperties.dbSystemId, "DBSystemOcid", "csharp");
@@clientName(DbNodeProperties.hostIpId, "HostIPOcid", "csharp");
@@clientName(DbNodeProperties.vnic2Id, "Vnic2Ocid", "csharp");
@@clientName(DbNodeProperties.vnicId, "VnicOcid", "csharp");
@@clientName(CloudVmClusterProperties.ocid, "CloudVmClusterOcid", "csharp");
@@clientName(CloudVmClusterProperties.zoneId, "ZoneOcid", "csharp");
@@clientName(CloudVmClusterProperties.scanDnsRecordId,
  "ScanDnsRecordOcid",
  "csharp"
);
@@clientName(CloudVmClusterProperties.computeNodes,
  "ComputeNodeOcids",
  "csharp"
);
@@clientName(CloudVmClusterProperties.lastUpdateHistoryEntryId,
  "LastUpdateHistoryEntryOcid",
  "csharp"
);
@@clientName(CloudVmClusterProperties.dbServers, "DBServerOcids", "csharp");
@@clientName(CloudVmClusterProperties.compartmentId,
  "CompartmentOcid",
  "csharp"
);
@@clientName(CloudVmClusterProperties.subnetOcid,
  "ClusterSubnetOcid",
  "csharp"
);
@@clientName(VirtualNetworkAddressProperties.vmOcid, "VipVmOcid", "csharp");
@@clientName(VirtualNetworkAddressProperties.ocid, "VipOcid", "csharp");
@@clientName(DbServerProperties.ocid, "DBServerOcid", "csharp");
@@clientName(DbServerProperties.compartmentId, "CompartmentOcid", "csharp");
@@clientName(DbServerProperties.exadataInfrastructureId,
  "ExadataInfrastructureOcid",
  "csharp"
);
@@clientName(DbServerProperties.vmClusterIds, "VmClusterOcids", "csharp");
@@clientName(DbServerProperties.dbNodeIds, "DBNodeOcids", "csharp");
@@clientName(DbServerProperties.autonomousVmClusterIds,
  "AutonomousVmClusterOcids",
  "csharp"
);
@@clientName(DbServerProperties.autonomousVirtualMachineIds,
  "AutonomousVirtualMachineOcids",
  "csharp"
);
@@clientName(DnsPrivateViewProperties.ocid, "DnsPrivateViewOcid", "csharp");
@@clientName(DnsPrivateZoneProperties.ocid, "ZoneOcid", "csharp");
@@clientName(DnsPrivateZoneProperties.viewId, "ViewOcid", "csharp");
@@clientName(OracleSubscriptionProperties.cloudAccountId,
  "CloudAccountOcid",
  "csharp"
);
@@clientName(PrivateIpAddressesFilter.vnicId, "VnicOcid", "csharp");
@@clientName(PrivateIpAddressesFilter.subnetId, "SubnetOcid", "csharp");
@@clientName(PrivateIpAddressProperties.ocid,
  "PrivateIPAddressesOcid",
  "csharp"
);
@@clientName(PrivateIpAddressProperties.subnetId, "SubnetOcid", "csharp");
// Address ComputeModel type change
@@clientName(AutonomousDatabaseBaseProperties.computeModel,
  "DatabaseComputeModel",
  "csharp"
);
@@clientName(AutonomousDatabaseBaseProperties.ocid, "DatabaseOcid", "csharp");

// Java
@@clientName(AutonomousDatabaseBackups.listByParent,
  "listByAutonomousDatabase",
  "java"
);
@@clientName(DbNodes.listByParent, "listByCloudVmCluster", "java");
@@clientName(DbServers.listByParent,
  "listByCloudExadataInfrastructure",
  "java"
);
@@clientName(VirtualNetworkAddresses.listByParent,
  "listByCloudVmCluster",
  "java"
);

@@clientName(AutonomousDatabaseBaseProperties.nextLongTermBackupTimeStamp,
  "nextLongTermBackupTimestamp",
  "java"
);

// Go
@@clientName(AutonomousDatabaseBackups.listByParent,
  "listByAutonomousDatabase",
  "go"
);
@@clientName(DbNodes.listByParent, "listByCloudVMCluster", "go");
@@clientName(DbServers.listByParent, "listByCloudExadataInfrastructure", "go");
@@clientName(VirtualNetworkAddresses.listByParent,
  "listByCloudVMCluster",
  "go"
);
