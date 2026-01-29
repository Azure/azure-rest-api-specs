import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.SqlVirtualMachine;

@@clientName(SqlVirtualMachine, "SqlVm", "csharp");
@@clientName(SqlVirtualMachineProperties.wsfcDomainCredentials,
  "WindowsServerFailoverClusterDomainCredentials",
  "csharp"
);
@@clientName(SqlVirtualMachineProperties.wsfcStaticIp,
  "WindowsServerFailoverClusterStaticIP",
  "csharp"
);
@@clientName(SqlVirtualMachineProperties.sqlVirtualMachineGroupResourceId,
  "SqlVmGroupResourceId",
  "csharp"
);
@@clientName(SqlVirtualMachineGroup, "SqlVmGroup", "csharp");
@@clientName(SqlVirtualMachineGroupProperties.wsfcDomainProfile,
  "WindowsServerFailoverClusterDomainProfile",
  "csharp"
);
@@clientName(SqlVirtualMachineUpdate, "SqlVmPatch", "csharp");
@@clientName(AvailabilityGroupListenerProperties.multiSubnetIpConfigurations,
  "MultiSubnetIPConfigurations",
  "csharp"
);
@@clientName(LoadBalancerConfiguration,
  "AvailabilityGroupListenerLoadBalancerConfiguration",
  "csharp"
);
@@clientName(LoadBalancerConfiguration.privateIpAddress,
  "PrivateIPAddress",
  "csharp"
);
@@clientName(LoadBalancerConfiguration.publicIpAddressResourceId,
  "PublicIPAddressResourceId",
  "csharp"
);
@@clientName(LoadBalancerConfiguration.sqlVirtualMachineInstances,
  "SqlVmInstances",
  "csharp"
);
@@clientName(PrivateIPAddress,
  "AvailabilityGroupListenerPrivateIPAddress",
  "csharp"
);
@@clientName(PrivateIPAddress.ipAddress, "IPAddress", "csharp");
@@clientName(AgConfiguration, "AvailabilityGroupConfiguration", "csharp");
@@clientName(AgReplica, "AvailabilityGroupReplica", "csharp");
@@clientName(AgReplica.sqlVirtualMachineInstanceId,
  "SqlVmInstanceId",
  "csharp"
);
@@clientName(Commit, "AvailabilityGroupReplicaCommitMode", "csharp");
@@clientName(Failover, "AvailabilityGroupReplicaFailoverMode", "csharp");
@@clientName(Role, "AvailabilityGroupReplicaRole", "csharp");
@@clientName(AutoBackupSettings.backupSystemDbs,
  "AreSystemDbsIncludedInBackup",
  "csharp"
);
@@clientName(AutoBackupSettings.enableEncryption,
  "IsEncryptionEnabled",
  "csharp"
);
@@clientName(AutoBackupSettings.enable, "IsEnabled", "csharp");
@@clientName(DayOfWeek, "SqlVmAutoPatchingDayOfWeek", "csharp");
@@clientName(ConnectivityType, "SqlServerConnectivityType", "csharp");
@@clientName(ConnectivityType.LOCAL, "Local", "csharp");
@@clientName(ConnectivityType.PRIVATE, "Private", "csharp");
@@clientName(ConnectivityType.PUBLIC, "Public", "csharp");
@@clientName(SqlServerLicenseType.AHUB, "Ahub", "csharp");
@@clientName(SqlServerLicenseType.PAYG, "Payg", "csharp");
@@clientName(SqlWorkloadType.GENERAL, "General", "csharp");
@@clientName(SqlWorkloadType.OLTP, "Oltp", "csharp");
@@clientName(FullBackupFrequencyType, "SqlVmFullBackupFrequency", "csharp");
@@clientName(ScaleType, "SqlVmGroupScaleType", "csharp");
@@clientName(Schedule, "SqlVmAssessmentSchedule", "csharp");
@@clientName(Schedule.enable, "IsEnabled", "csharp");
@@clientName(SQLInstanceSettings, "SqlInstanceSettings", "csharp");
@@clientName(SQLInstanceSettings.maxServerMemoryMB,
  "MaxServerMemoryInMB",
  "csharp"
);
@@clientName(SQLInstanceSettings.minServerMemoryMB,
  "MinServerMemoryInMB",
  "csharp"
);
@@clientName(ReadableSecondary, "ReadableSecondaryMode", "csharp");
@@clientName(AutoBackupSettings, "SqlVmAutoBackupSettings", "csharp");
@@clientName(AutoBackupSettings.fullBackupStartTime,
  "FullBackupStartHour",
  "csharp"
);
@@clientName(AutoBackupSettings.retentionPeriod,
  "RetentionPeriodInDays",
  "csharp"
);
@@clientName(AutoPatchingSettings, "SqlVmAutoPatchingSettings", "csharp");
@@clientName(AutoPatchingSettings.maintenanceWindowDuration,
  "MaintenanceWindowDurationInMinutes",
  "csharp"
);
@@clientName(AutoPatchingSettings.enable, "IsEnabled", "csharp");
@@clientName(BackupScheduleType, "SqVmBackupScheduleType", "csharp");
@@clientName(ClusterConfiguration, "SqlVmClusterConfiguration", "csharp");
@@clientName(AssessmentSettings, "SqlVmAssessmentSettings", "csharp");
@@clientName(AssessmentSettings.enable, "IsEnabled", "csharp");
@@clientName(AssessmentDayOfWeek, "SqlVmAssessmentDayOfWeek", "csharp");
@@clientName(ClusterManagerType, "SqlVmClusterManagerType", "csharp");
@@clientName(ClusterManagerType.WSFC, "WindowsServerFailoverCluster", "csharp");
@@clientName(ClusterSubnetType, "SqlVmClusterSubnetType", "csharp");
@@clientName(StorageConfigurationSettings,
  "SqlVmStorageConfigurationSettings",
  "csharp"
);
@@clientName(StorageConfigurationSettings.sqlSystemDbOnDataDisk,
  "IsSqlSystemDBOnDataDisk",
  "csharp"
);
@@clientName(StorageConfigurationSettings.sqlTempDbSettings,
  "SqlTempDBSettings",
  "csharp"
);
@@clientName(KeyVaultCredentialSettings,
  "SqlVmKeyVaultCredentialSettings",
  "csharp"
);
@@clientName(KeyVaultCredentialSettings.enable, "IsEnabled", "csharp");
@@clientName(ServerConfigurationsManagementSettings,
  "SqlServerConfigurationsManagementSettings",
  "csharp"
);
// @@clientName(Operation, "SqlVmInfo", "csharp");
@@clientName(OperationDisplay, "SqlVmOperationDisplay", "csharp");
@@clientName(OperationOrigin, "SqlVmOperationOrigin", "csharp");
@@clientName(OsType, "SqlVmOsType", "csharp");
@@clientName(TroubleshootingScenario, "SqlVmTroubleshootingScenario", "csharp");
@@clientName(TroubleshootingStatus, "SqlVmTroubleshootingStatus", "csharp");
@@clientName(VirtualMachineIdentity, "SqlVmIdentity", "csharp");
@@clientName(VmIdentityType, "SqlVmVmIdentityType", "csharp");
@@clientName(AdditionalOsPatch, "SqlVmAdditionalOsPatch", "csharp");
@@clientName(AdditionalVmPatch, "SqlVmAdditionalVmPatch", "csharp");
@@clientName(MultiSubnetIpConfiguration,
  "MultiSubnetIPConfiguration",
  "csharp"
);
@@clientName(MultiSubnetIpConfiguration.privateIpAddress,
  "PrivateIPAddress",
  "csharp"
);
@@clientName(MultiSubnetIpConfiguration.sqlVirtualMachineInstance,
  "SqlVmInstance",
  "csharp"
);
@@clientName(DiskConfigAssessmentRequest,
  "SqlVmDiskConfigAssessmentContent",
  "csharp"
);
@@clientName(DiskConfigurationType, "SqlVmDiskConfigurationType", "csharp");
@@clientName(DiskConfigurationType.ADD, "Add", "csharp");
@@clientName(DiskConfigurationType.EXTEND, "Extend", "csharp");
@@clientName(DiskConfigurationType.NEW, "New", "csharp");
@@clientName(StorageWorkloadType, "SqlVmStorageWorkloadType", "csharp");
@@clientName(StorageWorkloadType.GENERAL, "General", "csharp");
@@clientName(StorageWorkloadType.OLTP, "Oltp", "csharp");
@@clientName(AutoBackupDaysOfWeek, "SqlVmAutoBackupDayOfWeek", "csharp");
@@clientName(SQLStorageSettings, "SqlStorageSettings", "csharp");
@@clientName(SQLStorageSettings.luns, "Luns", "csharp");
@@clientName(SQLTempDbSettings, "SqlTempDBSettings", "csharp");
@@clientName(SQLTempDbSettings.luns, "LogicalUnitNumbers", "csharp");
@@clientName(WsfcDomainCredentials,
  "WindowsServerFailoverClusterDomainCredentials",
  "csharp"
);
@@clientName(WsfcDomainProfile,
  "WindowsServerFailoverClusterDomainProfile",
  "csharp"
);
@@clientName(WsfcDomainProfile.ouPath, "OrganizationalUnitPath", "csharp");
@@clientName(SqlVirtualMachineGroups.listBySqlVmGroup,
  "GetSqlVmsBySqlVmGroup",
  "csharp"
);
@@clientName(SqlVirtualMachine.name, "sqlVmName", "csharp");
@@clientName(SqlVirtualMachines.update::parameters.properties,
  "patch",
  "csharp"
);
@@clientName(SqlVirtualMachineGroup.name, "sqlVmGroupName", "csharp");
@@clientName(SqlVirtualMachineGroups.update::parameters.properties,
  "patch",
  "csharp"
);
@@alternateType(LoadBalancerConfiguration.sqlVirtualMachineInstances,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@alternateType(LoadBalancerConfiguration.loadBalancerResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(LoadBalancerConfiguration.publicIpAddressResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(SqlVirtualMachine.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(SqlVirtualMachineProperties.virtualMachineResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(SqlVirtualMachineProperties.wsfcStaticIp,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(PrivateIPAddress.ipAddress, Azure.Core.ipV4Address, "csharp");
@@alternateType(PrivateIPAddress.subnetResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(AgReplica.sqlVirtualMachineInstanceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(SqlVirtualMachineProperties.sqlVirtualMachineGroupResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(AutoBackupSettings.storageAccountUrl, url, "csharp");
@@alternateType(KeyVaultCredentialSettings.azureKeyVaultUrl, url, "csharp");
@@alternateType(WsfcDomainProfile.storageAccountUrl, url, "csharp");
