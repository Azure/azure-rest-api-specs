import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.DBforMySQL;

@@clientName(Microsoft.DBforMySQL,
  "MySQLManagementFlexibleServerClient",
  "javascript"
);
@@clientName(Microsoft.DBforMySQL, "MySQLManagementClient", "python");

@@clientName(ServerVersion.`5.7`, "Five7", "javascript,go,csharp");
@@clientName(ServerVersion.`8.0.21`, "Eight021", "javascript,go,csharp");
@@clientName(ServerVersion.`5.7`, "FIVE7", "python");
@@clientName(ServerVersion.`8.0.21`, "EIGHT0_21", "python");

// Java SDK compatibility fixes for TypeSpec migration
@@clientName(Microsoft.DBforMySQL.MySQLServerIdentity, "Identity", "java");
@@clientName(Microsoft.DBforMySQL.MySQLServerSku, "Sku", "java");
@@clientName(Microsoft.DBforMySQL.ServerSkuTier, "SkuTier", "java");
@@clientName(DataEncryption.primaryKeyURI, "primaryKeyUri", "java");
@@clientName(DataEncryption.geoBackupKeyURI, "geoBackupKeyUri", "java");

@@clientName(Capability, "MySqlFlexibleServersCapability", "csharp");
@@clientName(Storage.storageSizeGB, "StorageSizeInGB", "csharp");
@@clientName(SkuCapability.supportedMemoryPerVCoreMB,
  "SupportedMemoryPerVCoreInMB",
  "csharp"
);
@@clientName(ConfigurationListForBatchUpdate.value, "Values", "csharp");
@@clientName(Configuration, "MySqlFlexibleServerConfiguration", "csharp");
@@clientName(Database, "MySqlFlexibleServerDatabase", "csharp");
@@clientName(FirewallRule, "MySqlFlexibleServerFirewallRule", "csharp");
@@clientName(ServerBackup, "MySqlFlexibleServerBackup", "csharp");
@@clientName(ServerBackupV2, "MySqlFlexibleServerBackupV2", "csharp");
@@clientName(Server, "MySqlFlexibleServer", "csharp");
@@clientName(ServerVersion, "MySqlFlexibleServerVersion", "csharp");
@@clientName(EnableStatusEnum, "MySqlFlexibleServerEnableStatusEnum", "csharp");
@@clientName(ReplicationRole, "MySqlFlexibleServerReplicationRole", "csharp");
@@clientName(DataEncryption, "MySqlFlexibleServerDataEncryption", "csharp");
@@clientName(MaintenanceWindow,
  "MySqlFlexibleServerMaintenanceWindow",
  "csharp"
);
@@clientName(Backup, "MySqlFlexibleServerBackupProperties", "csharp");
@@clientName(Storage, "MySqlFlexibleServerStorage", "csharp");
@@clientName(MySQLServerSku, "MySqlFlexibleServerSku", "csharp");
@@clientName(Network, "MySqlFlexibleServerNetwork", "csharp");
@@clientName(HighAvailability, "MySqlFlexibleServerHighAvailability", "csharp");
@@clientName(HighAvailabilityMode,
  "MySqlFlexibleServerHighAvailabilityMode",
  "csharp"
);
@@clientName(HighAvailabilityState,
  "MySqlFlexibleServerHighAvailabilityState",
  "csharp"
);
@@clientName(ServerForUpdate, "MySqlFlexibleServerForUpdate", "csharp");
@@clientName(ServerListResult, "MySqlFlexibleServerListResult", "csharp");
@@clientName(ServerRestartParameter,
  "MySqlFlexibleServerRestartParameter",
  "csharp"
);
@@clientName(ServerState, "MySqlFlexibleServerState", "csharp");
@@clientName(ServerBackupListResult,
  "MySqlFlexibleServerBackupListResult",
  "csharp"
);
@@clientName(FirewallRuleListResult,
  "MySqlFlexibleServerFirewallRuleListResult",
  "csharp"
);
@@clientName(DatabaseListResult,
  "MySqlFlexibleServerDatabaseListResult",
  "csharp"
);
@@clientName(ConfigurationSource,
  "MySqlFlexibleServerConfigurationSource",
  "csharp"
);
@@clientName(ConfigurationListResult,
  "MySqlFlexibleServerConfigurations",
  "csharp"
);
@@clientName(ConfigurationForBatchUpdate,
  "MySqlFlexibleServerConfigurationForBatchUpdate",
  "csharp"
);
@@clientName(ConfigurationListForBatchUpdate,
  "MySqlFlexibleServerConfigurationListForBatchUpdate",
  "csharp"
);
@@clientName(VirtualNetworkSubnetUsageParameter,
  "MySqlFlexibleServerVirtualNetworkSubnetUsageParameter",
  "csharp"
);
@@clientName(DelegatedSubnetUsage,
  "MySqlFlexibleServerDelegatedSubnetUsage",
  "csharp"
);
@@clientName(VirtualNetworkSubnetUsageResult,
  "MySqlFlexibleServerVirtualNetworkSubnetUsageResult",
  "csharp"
);
@@clientName(SkuCapability, "MySqlFlexibleServerSkuCapability", "csharp");
@@clientName(ServerVersionCapability,
  "MySqlFlexibleServerServerVersionCapability",
  "csharp"
);
@@clientName(StorageEditionCapability,
  "MySqlFlexibleServerStorageEditionCapability",
  "csharp"
);
@@clientName(ServerEditionCapability,
  "MySqlFlexibleServerEditionCapability",
  "csharp"
);
@@clientName(CapabilityProperties,
  "MySqlFlexibleServerCapabilityProperties",
  "csharp"
);
@@clientName(CapabilitiesListResult,
  "MySqlFlexibleServerCapabilitiesListResult",
  "csharp"
);
@@clientName(GetPrivateDnsZoneSuffixResponse,
  "MySqlFlexibleServerPrivateDnsZoneSuffixResponse",
  "csharp"
);
@@clientName(NameAvailabilityRequest,
  "MySqlFlexibleServerNameAvailabilityContent",
  "csharp"
);
@@clientName(NameAvailabilityRequest.type, "ResourceType", "csharp");
@@clientName(NameAvailability,
  "MySqlFlexibleServerNameAvailabilityResult",
  "csharp"
);
@@clientName(CreateMode, "MySqlFlexibleServerCreateMode", "csharp");
@@clientName(DataEncryptionType,
  "MySqlFlexibleServerDataEncryptionType",
  "csharp"
);
@@clientName(ServerSkuTier, "MySqlFlexibleServerSkuTier", "csharp");
@@clientName(IsReadOnly, "MySqlFlexibleServerConfigReadOnlyState", "csharp");
@@clientName(IsDynamicConfig,
  "MySqlFlexibleServerConfigDynamicState",
  "csharp"
);
@@clientName(IsConfigPendingRestart,
  "MySqlFlexibleServerConfigPendingRestartState",
  "csharp"
);
@@clientName(NameAvailability.nameAvailable, "IsNameAvailable", "csharp");
@@clientName(AzureADAdministrator,
  "MySqlFlexibleServerAadAdministrator",
  "csharp"
);
@@clientName(AdministratorListResult,
  "MySqlFlexibleServerAadAdministratorListResult",
  "csharp"
);
@@clientName(AdministratorName,
  "MySqlFlexibleServerAdministratorName",
  "csharp"
);
@@clientName(BackupAndExportRequest,
  "MySqlFlexibleServerBackupAndExportRequest",
  "csharp"
);
@@clientName(BackupAndExportResponse,
  "MySqlFlexibleServerBackupAndExportResult",
  "csharp"
);
@@clientName(BackupFormat, "MySqlFlexibleServerBackupFormat", "csharp");
@@clientName(BackupRequestBase,
  "MySqlFlexibleServerBackupContentBase",
  "csharp"
);
@@clientName(BackupSettings, "MySqlFlexibleServerBackupSettings", "csharp");

@@clientName(FullBackupStoreDetails,
  "MySqlFlexibleServerFullBackupStoreDetails",
  "csharp"
);
@@clientName(AdministratorType,
  "MySqlFlexibleServerAdministratorType",
  "csharp"
);
@@clientName(LogFile, "MySqlFlexibleServerLogFile", "csharp");
@@clientName(LogFileListResult,
  "MySqlFlexibleServerLogFileListResult",
  "csharp"
);
@@clientName(OperationStatus,
  "MySqlFlexibleServerBackupAndExportOperationStatus",
  "csharp"
);
@@clientName(ResetAllToDefault,
  "MySqlFlexibleServerConfigurationResetAllToDefault",
  "csharp"
);
@@clientName(ServerGtidSetParameter,
  "MySqlFlexibleServerGtidSetContent",
  "csharp"
);
@@clientName(ValidateBackupResponse,
  "MySqlFlexibleServerValidateBackupResult",
  "csharp"
);
@@clientName(Maintenance, "MySqlFlexibleServerMaintenance", "csharp");
@@clientName(MaintenanceType, "MySqlFlexibleServerMaintenanceType", "csharp");
@@clientName(MaintenanceState, "MySqlFlexibleServerMaintenanceState", "csharp");
@@clientName(MaintenanceProvisioningState,
  "MySqlFlexibleServerMaintenanceProvisioningState",
  "csharp"
);
@@clientName(BackupType, "MySqlFlexibleServerBackupType", "csharp");
@@clientName(ProvisioningState,
  "MySqlFlexibleServerBackupProvisioningState",
  "csharp"
);
@@clientName(ServerProperties.privateEndpointConnections,
  "ServerPrivateEndpointConnections",
  "csharp"
);
@@clientName(BatchOfMaintenance,
  "MySqlFlexibleServerBatchOfMaintenance",
  "csharp"
);
@@clientName(FeatureProperty, "MySqlFlexibleServerFeatureProperty", "csharp");
@@clientName(PatchStrategy, "MySqlFlexibleServerPatchStrategy", "csharp");
@@clientName(StorageRedundancyEnum,
  "MySqlFlexibleServerStorageRedundancyType",
  "csharp"
);
@@clientName(ServerDetachVNetParameter,
  "MySqlFlexibleServerDetachVnetContent",
  "csharp"
);
@@clientName(CheckNameAvailability.execute,
  "CheckMySqlFlexibleServerNameAvailability",
  "csharp"
);
@@clientName(CheckNameAvailabilityWithoutLocation.execute,
  "CheckMySqlFlexibleServerNameAvailabilityWithoutLocation",
  "csharp"
);
@@clientName(Configurations.batchUpdate, "UpdateConfigurations", "csharp");
@@clientName(BackupAndExport.validateBackup, "ValidateBackup", "csharp");
@@clientName(Servers.detachVNet, "DetachVnet", "csharp");
@@clientName(BackupType.FULL, "Full", "csharp");
@@clientName(DataEncryption.type, "EncryptionType", "csharp");
@@clientName(LogFileProperties.type, "TypePropertiesType", "csharp");

@@scope(OperationProgress.get, "!csharp");
@@scope(Operations.list, "!csharp");
@@scope(OperationResults.get, "!csharp");

// Skip generating scopes for PrivateLinkResources in C# as they are some naming issues
@@scope(PrivateLinkResources.get, "!csharp");
@@scope(PrivateLinkResources.listByServer, "!csharp");

@@alternateType(LocationNameParameter.locationName, azureLocation, "csharp");
@@alternateType(AdministratorProperties.identityResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(AdministratorProperties.tenantId, uuid, "csharp");
@@alternateType(ServerProperties.sourceServerResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(FirewallRuleProperties.startIpAddress, ipV4Address, "csharp");
@@alternateType(FirewallRuleProperties.endIpAddress, ipV4Address, "csharp");
@@alternateType(ImportSourceProperties.storageUrl, url, "csharp");
@@alternateType(DataEncryption.primaryKeyURI, url, "csharp");
@@alternateType(DataEncryption.geoBackupKeyURI, url, "csharp");
@@alternateType(DataEncryption.primaryUserAssignedIdentityId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(DataEncryption.geoBackupUserAssignedIdentityId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(LogFileProperties.url, url, "csharp");
@@alternateType(NameAvailabilityRequest.type, armResourceType, "csharp");
@@alternateType(Network.delegatedSubnetResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Network.privateDnsZoneResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(VirtualNetworkSubnetUsageParameter.virtualNetworkResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(VirtualNetworkSubnetUsageResult.location,
  azureLocation,
  "csharp"
);
