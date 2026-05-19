import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.DBforPostgreSQL;
using Azure.ClientGenerator.Core;

@@clientName(Microsoft.DBforPostgreSQL, "PostgreSQLManagementClient", "python");
@@clientName(
  Microsoft.DBforPostgreSQL,
  "PostgreSQLManagementFlexibleServerClient",
  "javascript"
);
@@clientName(PostgresMajorVersion.`11`, "ELEVEN", "python,javascript");
@@clientName(PostgresMajorVersion.`12`, "TWELVE", "python,javascript");
@@clientName(PostgresMajorVersion.`13`, "THIRTEEN", "python,javascript");
@@clientName(PostgresMajorVersion.`14`, "FOURTEEN", "python,javascript");
@@clientName(PostgresMajorVersion.`15`, "FIFTEEN", "python,javascript");
@@clientName(PostgresMajorVersion.`16`, "SIXTEEN", "python,javascript");
@@clientName(PostgresMajorVersion.`17`, "SEVENTEEN", "python,javascript");
@@clientName(PostgresMajorVersion.`18`, "EIGHTEEN", "python,javascript");

@@clientName(
  Microsoft.DBforPostgreSQL.ServerProperties.pointInTimeUTC,
  "pointInTimeUtc",
  "java"
);
@@clientName(
  Microsoft.DBforPostgreSQL.DataEncryption.primaryKeyURI,
  "primaryKeyUri",
  "java"
);
@@clientName(
  Microsoft.DBforPostgreSQL.DataEncryption.geoBackupKeyURI,
  "geoBackupKeyUri",
  "java"
);
@@clientName(RequestIdResponseHeader.requestId, "xMsRequestId", "java,go");

@@clientName(
  Microsoft.DBforPostgreSQL.PostgreSqlFlexibleServerHighAvailabilityMode,
  "HighAvailabilityMode",
  "java,go"
);
@@clientName(
  Microsoft.DBforPostgreSQL.HighAvailabilityMode,
  "SupportedHighAvailabilityMode",
  "java,go"
);
@@alternateType(
  Microsoft.DBforPostgreSQL.ServerSkuCapability.supportedHaMode,
  PostgreSqlFlexibleServerHighAvailabilityMode[],
  "java,go"
);

@@clientName(PostgresMajorVersion.`11`, "Eleven", "go");
@@clientName(PostgresMajorVersion.`12`, "Twelve", "go");
@@clientName(PostgresMajorVersion.`13`, "Thirteen", "go");
@@clientName(PostgresMajorVersion.`14`, "Fourteen", "go");
@@clientName(PostgresMajorVersion.`15`, "Fifteen", "go");
@@clientName(PostgresMajorVersion.`16`, "Sixteen", "go");
@@clientName(PostgresMajorVersion.`17`, "Seventeen", "go");
@@clientName(PostgresMajorVersion.`18`, "Eighteen", "go");

// C# configuration
@@clientName(Cluster, "PostgreSqlFlexibleServerClusterProperties", "csharp");
@@clientName(Configuration, "PostgreSqlFlexibleServerConfiguration", "csharp");
@@clientName(
  ConfigurationDataType,
  "PostgreSqlFlexibleServerConfigurationDataType",
  "csharp"
);
@@clientName(
  CreateModeForPatch,
  "PostgreSqlFlexibleServerCreateModeForUpdate",
  "csharp"
);
@@clientName(FailoverMode, "PostgreSqlFlexibleServerFailoverMode", "csharp");
@@clientName(
  GeographicallyRedundantBackup,
  "PostgreSqlFlexibleServerGeoRedundantBackupEnum",
  "csharp"
);
@@clientName(Database, "PostgreSqlFlexibleServerDatabase", "csharp");
@@clientName(FirewallRule, "PostgreSqlFlexibleServerFirewallRule", "csharp");
@@clientName(Server, "PostgreSqlFlexibleServer", "csharp");
@@clientName(PostgresMajorVersion, "PostgreSqlFlexibleServerVersion", "csharp");
@@clientName(
  MaintenanceWindow,
  "PostgreSqlFlexibleServerMaintenanceWindow",
  "csharp"
);
@@clientName(Backup, "PostgreSqlFlexibleServerBackupProperties", "csharp");
@@clientName(Storage, "PostgreSqlFlexibleServerStorage", "csharp");
@@clientName(Sku, "PostgreSqlFlexibleServerSku", "csharp");
@@clientName(Network, "PostgreSqlFlexibleServerNetwork", "csharp");
@@clientName(
  HighAvailability,
  "PostgreSqlFlexibleServerHighAvailability",
  "csharp"
);
@@clientName(ServerState, "PostgreSqlFlexibleServerState", "csharp");
@@clientName(
  VirtualNetworkSubnetUsageParameter,
  "PostgreSqlFlexibleServerVirtualNetworkSubnetUsageParameter",
  "csharp"
);
@@clientName(
  DelegatedSubnetUsage,
  "PostgreSqlFlexibleServerDelegatedSubnetUsage",
  "csharp"
);
@@clientName(
  VirtualNetworkSubnetUsageModel,
  "PostgreSqlFlexibleServerVirtualNetworkSubnetUsageResult",
  "csharp"
);
@@clientName(
  ServerVersionCapability,
  "PostgreSqlFlexibleServerServerVersionCapability",
  "csharp"
);
@@clientName(
  StorageEditionCapability,
  "PostgreSqlFlexibleServerStorageEditionCapability",
  "csharp"
);
@@clientName(
  ServerEditionCapability,
  "PostgreSqlFlexibleServerEditionCapability",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
  "PostgreSqlFlexibleServerNameAvailabilityContent",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse,
  "PostgreSqlFlexibleServerNameAvailabilityResponse",
  "csharp"
);
@@clientName(
  CheckNameAvailabilityReason,
  "PostgreSqlFlexibleServerNameUnavailableReason",
  "csharp"
);
@@alternateType(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse.reason,
  CheckNameAvailabilityReason,
  "csharp"
);
@@clientName(
  NameAvailabilityModel,
  "PostgreSqlFlexibleServerNameAvailabilityResult",
  "csharp"
);
@@clientName(CreateMode, "PostgreSqlFlexibleServerCreateMode", "csharp");
@@clientName(SkuTier, "PostgreSqlFlexibleServerSkuTier", "csharp");
@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(Storage.storageSizeGB, "StorageSizeInGB", "csharp");
@@clientName(StorageMbCapability.storageSizeMb, "StorageSizeInMB", "csharp");
@@clientName(
  StorageMbCapability,
  "PostgreSqlFlexibleServerStorageCapability",
  "csharp"
);
@@clientName(
  RestartParameter,
  "PostgreSqlFlexibleServerRestartParameter",
  "csharp"
);
@@clientName(
  HighAvailabilityState,
  "PostgreSqlFlexibleServerHAState",
  "csharp"
);
@@clientName(
  ServerPublicNetworkAccessState,
  "PostgreSqlFlexibleServerPublicNetworkAccessState",
  "csharp"
);
@@clientName(
  StorageEditionCapability.supportedStorageMb,
  "SupportedStorageCapabilities",
  "csharp"
);
@@alternateType(StorageMbCapability.supportedIops, int64, "csharp");
@@alternateType(StorageTierCapability.iops, int64, "csharp");
@@clientName(ServerProperties.pointInTimeUTC, "PointInTimeUtc", "csharp");
@@clientName(
  MicrosoftEntraAuth,
  "PostgreSqlFlexibleServerActiveDirectoryAuthEnum",
  "csharp"
);
@@clientName(DataEncryptionType, "PostgreSqlFlexibleServerKeyType", "csharp");
@@clientName(AuthConfig, "PostgreSqlFlexibleServerAuthConfig", "csharp");
@@clientName(
  DataEncryption,
  "PostgreSqlFlexibleServerDataEncryption",
  "csharp"
);
@@clientName(
  FastProvisioningEditionCapability,
  "PostgreSqlFlexibleServerFastProvisioningEditionCapability",
  "csharp"
);
@@clientName(IdentityType, "PostgreSqlFlexibleServerIdentityType", "csharp");
@@clientName(BackupType, "PostgreSqlFlexibleServerBackupOrigin", "csharp");
@@clientName(
  PasswordBasedAuth,
  "PostgreSqlFlexibleServerPasswordAuthEnum",
  "csharp"
);
@@clientName(PrincipalType, "PostgreSqlFlexibleServerPrincipalType", "csharp");
@@clientName(
  ReplicationRole,
  "PostgreSqlFlexibleServerReplicationRole",
  "csharp"
);
@@clientName(
  BackupAutomaticAndOnDemand,
  "PostgreSqlFlexibleServerBackup",
  "csharp"
);
@@clientName(
  StorageTierCapability,
  "PostgreSqlFlexibleServerStorageTierCapability",
  "csharp"
);
@@clientName(AdminCredentials, "PostgreSqlMigrationAdminCredentials", "csharp");
@@clientName(
  BackupSettings,
  "PostgreSqlFlexibleServerBackupSettings",
  "csharp"
);
@@clientName(
  BackupStoreDetails,
  "PostgreSqlFlexibleServerBackupStoreDetails",
  "csharp"
);
@@clientName(Cancel, "PostgreSqlMigrationCancel", "csharp");
@@clientName(
  LogicalReplicationOnSourceServer,
  "PostgreSqlMigrationLogicalReplicationOnSourceDb",
  "csharp"
);
@@clientName(
  OverwriteDatabasesOnTargetServer,
  "PostgreSqlMigrationOverwriteDbsInTarget",
  "csharp"
);
@@clientName(
  StartDataMigration,
  "PostgreSqlMigrationStartDataMigration",
  "csharp"
);
@@clientName(TriggerCutover, "PostgreSqlMigrationTriggerCutover", "csharp");
@@clientName(
  CapabilityStatus,
  "PostgreSqlFlexbileServerCapabilityStatus",
  "csharp"
);
@@clientName(DbServerMetadata, "PostgreSqlServerMetadata", "csharp");
@@clientName(
  FastProvisioningSupport,
  "PostgreSqlFlexibleServerFastProvisioningSupported",
  "csharp"
);
@@clientName(
  Capability.fastProvisioningSupported,
  "SupportFastProvisioning",
  "csharp"
);
@@clientName(
  Capability,
  "PostgreSqlFlexibleServerCapabilityProperties",
  "csharp"
);
@@clientName(CapturedLog, "PostgreSqlFlexibleServerLogFile", "csharp");
@@clientName(
  GeographicallyRedundantBackupSupport,
  "PostgreSqlFlexibleServerGeoBackupSupported",
  "csharp"
);
@@clientName(
  ZoneRedundantHighAvailabilitySupport,
  "PostgreSqlFlexibleServerZoneRedundantHaSupported",
  "csharp"
);
@@clientName(
  ZoneRedundantHighAvailabilityAndGeographicallyRedundantBackupSupport,
  "PostgreSqlFlexibleServerZoneRedundantHaAndGeoBackupSupported",
  "csharp"
);
@@clientName(
  StorageAutoGrowthSupport,
  "PostgreSqlFlexibleServerStorageAutoGrowthSupported",
  "csharp"
);
@@clientName(
  OnlineStorageResizeSupport,
  "PostgreSqlFlexibleServerOnlineResizeSupported",
  "csharp"
);
@@clientName(
  LocationRestricted,
  "PostgreSqlFlexibleServerZoneRedundantRestricted",
  "csharp"
);
@@clientName(
  ServerSkuCapability,
  "PostgreSqlFlexibleServerSkuCapability",
  "csharp"
);
@@clientName(CapabilityBase.status, "CapabilityStatus", "csharp");
@@clientName(CapabilityBase, "PostgreSqlBaseCapability", "csharp");
@@clientName(ExecutionStatus, "PostgreSqlExecutionStatus", "csharp");
@@clientName(EncryptionKeyStatus, "PostgreSqlKeyStatus", "csharp");
@@clientName(
  BackupsLongTermRetentionResponse,
  "PostgreSqlFlexibleServerLtrBackupResult",
  "csharp"
);
@@clientName(
  LtrPreBackupResponse,
  "PostgreSqlFlexibleServerLtrPreBackupResult",
  "csharp"
);
@@clientName(MigrationListFilter, "PostgreSqlMigrationListFilter", "csharp");
@@clientName(MigrationMode, "PostgreSqlMigrationMode", "csharp");
@@clientName(
  MigrationNameAvailabilityReason,
  "PostgreSqlMigrationNameUnavailableReason",
  "csharp"
);
@@clientName(
  MigrationNameAvailability,
  "PostgreSqlCheckMigrationNameAvailabilityContent",
  "csharp"
);
@@clientName(
  MigrationNameAvailability.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(
  MigrationSecretParameters,
  "PostgreSqlMigrationSecretParameters",
  "csharp"
);
@@clientName(MigrationState, "PostgreSqlMigrationState", "csharp");
@@clientName(MigrationStatus, "PostgreSqlMigrationStatus", "csharp");
@@clientName(MigrationSubstate, "PostgreSqlMigrationSubState", "csharp");
@@clientName(
  MigrationSubstateDetails,
  "PostgreSqlMigrationSubStateDetails",
  "csharp"
);
@@clientName(BackupRequestBase, "PostgreSqlBackupContent", "csharp");
@@clientName(
  AzureManagedDiskPerformanceTier,
  "PostgreSqlManagedDiskPerformanceTier",
  "csharp"
);
@@clientName(
  BackupsLongTermRetentionRequest,
  "PostgreSqlFlexibleServerLtrBackupContent",
  "csharp"
);
@@clientName(
  LtrPreBackupRequest,
  "PostgreSqlFlexibleServerLtrPreBackupContent",
  "csharp"
);
@@clientName(Migration, "PostgreSqlMigration", "csharp");
@@alternateType(
  AdministratorMicrosoftEntraProperties.objectId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  DataEncryption.primaryUserAssignedIdentityId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// IPAddress type mappings
@@alternateType(
  FirewallRuleProperties.startIpAddress,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(
  FirewallRuleProperties.endIpAddress,
  Azure.Core.ipV4Address,
  "csharp"
);

// Guid type mappings
@@alternateType(AuthConfig.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(
  AdministratorMicrosoftEntraProperties.tenantId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(UserAssignedIdentity.principalId, Azure.Core.uuid, "csharp");
@@alternateType(UserAssignedIdentity.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(
  UserAssignedIdentity.userAssignedIdentities,
  Record<Azure.ResourceManager.CommonTypes.UserAssignedIdentity>,
  "csharp"
);

// Uri type mappings
@@alternateType(DataEncryption.primaryKeyURI, TypeSpec.url, "csharp");
@@alternateType(DataEncryption.geoBackupKeyURI, TypeSpec.url, "csharp");

// ResourceIdentifier type mappings
@@alternateType(
  VirtualNetworkSubnetUsageParameter.virtualNetworkArmResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  MigrationProperties.sourceDbServerResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  MigrationProperties.targetDbServerResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  MigrationPropertiesForPatch.sourceDbServerResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// AzureLocation type mappings
@@alternateType(
  VirtualNetworkSubnetUsageModel.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(DbServerMetadata.location, Azure.Core.azureLocation, "csharp");

// ResourceType type mappings
@@alternateType(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest.type,
  Azure.Core.armResourceType,
  "csharp"
);
@@alternateType(
  MigrationNameAvailability.type,
  Azure.Core.armResourceType,
  "csharp"
);
@@alternateType(
  NameAvailabilityModel.type,
  Azure.Core.armResourceType,
  "csharp"
);

@@clientName(
  AdvancedThreatProtectionSettingsModel,
  "ServerThreatProtectionSettingsModel",
  "csharp"
);
@@clientName(
  AdministratorMicrosoftEntra,
  "PostgreSqlFlexibleServerMicrosoftEntraAdministrator",
  "csharp"
);
@@clientName(
  LtrServerBackupOperationList,
  "PostgreSqlLtrServerBackupOperationList",
  "csharp"
);
@@clientName(
  BackupsLongTermRetentionOperation,
  "PostgreSqlLtrServerBackupOperation",
  "csharp"
);
@@clientName(VirtualEndpoint, "VirtualEndpointResource", "csharp");
@@clientName(ReadReplicaPromoteOption, "ReplicationPromoteOption", "csharp");
@@clientName(MigrationDatabaseState, "MigrationDbState", "csharp");
@@clientName(MigrateRolesAndPermissions, "MigrateRolesEnum", "csharp");
@@clientName(DatabaseMigrationState, "DbMigrationStatus", "csharp");
@@clientName(
  UserAssignedIdentity,
  "PostgreSqlFlexibleServerUserAssignedIdentity",
  "csharp"
);
@@clientName(HighAvailabilityMode, "PostgreSqlFlexibleServerHAMode", "csharp");
@@clientName(TuningOptions, "PostgreSqlFlexibleServerTuningOption", "csharp");
@@clientName(FeatureStatus, "PostgreSqlFlexibleServerFeatureStatus", "csharp");
@@clientName(ImpactRecord, "RecommendationImpactRecord", "csharp");
@@clientName(NameProperty, "QuotaUsageNameProperty", "csharp");
@@clientName(
  ObjectRecommendationPropertiesAnalyzedWorkload,
  "ObjectRecommendationAnalyzedWorkload",
  "csharp"
);
@@clientName(
  ObjectRecommendationPropertiesImplementationDetails,
  "ObjectRecommendationImplementationDetails",
  "csharp"
);
@@clientName(QuotaUsage, "PostgreSqlFlexibleServerQuotaUsage", "csharp");
@@clientName(
  RecommendationTypeEnum,
  "PostgreSqlFlexibleServerRecommendationType",
  "csharp"
);
@@clientName(
  RecommendationTypeParameterEnum,
  "PostgreSqlFlexibleServerRecommendationFilterType",
  "csharp"
);
@@clientName(
  SupportedFeature,
  "PostgreSqlFlexibleServerSupportedFeature",
  "csharp"
);
@@clientName(
  TuningOptionParameterEnum,
  "PostgreSqlFlexibleServerTuningOptionType",
  "csharp"
);

// Preserve backward-compatible operation names for subscription-level operations
@@clientName(
  CapabilitiesByLocationOperationGroup.list,
  "ExecuteLocationBasedCapabilities",
  "csharp"
);
@@clientName(QuotaUsagesOperationGroup.list, "GetQuotaUsages", "csharp");
@@clientName(
  NameAvailabilityOperationGroup.checkGlobally,
  "CheckPostgreSqlFlexibleServerNameAvailability",
  "csharp"
);
@@clientName(
  NameAvailabilityOperationGroup.checkWithLocation,
  "CheckPostgreSqlFlexibleServerNameAvailabilityWithLocation",
  "csharp"
);
@@clientName(
  VirtualNetworkSubnetUsageOperationGroup.list,
  "ExecuteVirtualNetworkSubnetUsage",
  "csharp"
);
@@clientName(
  PrivateDnsZoneSuffixOperationGroup.get,
  "ExecuteGetPrivateDnsZoneSuffix",
  "csharp"
);

// Preserve backward-compatible operation names for server-level operations
@@clientName(
  Servers.listByServer,
  "GetPostgreSqlFlexibleServerLogFiles",
  "csharp"
);
@@clientName(Servers.replicasListByServer, "GetReplicas", "csharp");
@@clientName(Servers.list, "GetServerCapabilities", "csharp");
@@clientName(
  Servers.checkNameAvailability,
  "CheckPostgreSqlMigrationNameAvailability",
  "csharp"
);
@@clientName(Servers.start, "StartLtrBackupFlexibleServer", "csharp");
@@clientName(
  Servers.checkPrerequisites,
  "TriggerLtrPreBackupFlexibleServer",
  "csharp"
);
@@clientName(Replica, "PostgreSqlFlexibleServersReplica", "csharp");
@@clientName(
  ReplicationState,
  "PostgreSqlFlexibleServersReplicationState",
  "csharp"
);
@@clientName(ServerSku, "PostgreSqlFlexibleServersServerSku", "csharp");
@@clientName(SourceType, "PostgreSqlFlexibleServersSourceType", "csharp");
@@clientName(SslMode, "PostgreSqlFlexibleServersSslMode", "csharp");
@@clientName(StorageType, "PostgreSqlFlexibleServersStorageType", "csharp");
@@clientName(
  ValidationDetails,
  "PostgreSqlFlexibleServersValidationDetails",
  "csharp"
);
@@clientName(
  ValidationMessage,
  "PostgreSqlFlexibleServersValidationMessage",
  "csharp"
);
@@clientName(
  ValidationState,
  "PostgreSqlFlexibleServersValidationState",
  "csharp"
);
@@clientName(MigrateNetworkStatus, "DbMigrateNetworkStatus", "csharp");
@@clientName(NetworkMigrationState, "DbNetworkMigrationState", "csharp");

// Restore public constructors and property setters for models treated as output-only
@@usage(ObjectRecommendation, Usage.input, "csharp");
@@usage(ObjectRecommendationPropertiesAnalyzedWorkload, Usage.input, "csharp");
@@usage(
  ObjectRecommendationPropertiesImplementationDetails,
  Usage.input,
  "csharp"
);
@@usage(CapturedLog, Usage.input, "csharp");
@@usage(BackupAutomaticAndOnDemand, Usage.input, "csharp");
@@usage(Configuration, Usage.input, "csharp");
@@usage(AdministratorMicrosoftEntra, Usage.input, "csharp");
@@usage(BackupsLongTermRetentionOperation, Usage.input, "csharp");
@@usage(TuningOptions, Usage.input, "csharp");
@@usage(PrivateLinkResource, Usage.input, "csharp");

// Preserve backward-compatible property names
@@clientName(DataEncryption.type, "KeyType", "csharp");
@@clientName(DataEncryption.primaryKeyURI, "PrimaryKeyUri", "csharp");
@@clientName(DataEncryption.geoBackupKeyURI, "GeoBackupKeyUri", "csharp");
@@clientName(FirewallRuleProperties.startIpAddress, "StartIPAddress", "csharp");
@@clientName(FirewallRuleProperties.endIpAddress, "EndIPAddress", "csharp");
@@clientName(Storage.type, "StorageType", "csharp");
@@clientName(UserAssignedIdentity.type, "IdentityType", "csharp");
@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest.type,
  "ResourceType",
  "csharp"
);
@@clientName(MigrationNameAvailability.type, "ResourceType", "csharp");
@@clientName(NameAvailabilityModel.type, "ResourceType", "csharp");
@@clientName(CapturedLogProperties.type, "LogFileType", "csharp");
@@clientName(ValidationSummaryItem.type, "ValidationSummaryItemType", "csharp");

// Rename resource types to have proper service prefix
@@clientName(
  PrivateEndpointConnection,
  "PostgreSqlFlexibleServersPrivateEndpointConnection",
  "csharp"
);
@@clientName(
  PrivateLinkResource,
  "PostgreSqlFlexibleServersPrivateLinkResource",
  "csharp"
);

// Restore BackupStoreDetails input usage.
@@usage(BackupStoreDetails, Usage.input, "csharp");

// Preserve backward-compatible enum member names
@@clientName(SourceType.AWS_AURORA, "AWSAurora", "csharp");
@@clientName(SourceType.AzureVM, "AzureVm", "csharp");

// Restore public constructors and property setters for additional models
@@usage(AdvancedThreatProtectionSettingsModel, Usage.input, "csharp");
@@usage(PrivateEndpointConnection, Usage.input, "csharp");
@@usage(ServerForPatch, Usage.input, "csharp");
@@usage(DataEncryption, Usage.input, "csharp");
@@usage(MigrationResourceForPatch, Usage.input, "csharp");
@@usage(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
  Usage.input,
  "csharp"
);

// Restore ForPatch sub-model input usage.
@@usage(SkuForPatch, Usage.input, "csharp");
@@usage(BackupForPatch, Usage.input, "csharp");
@@usage(HighAvailabilityForPatch, Usage.input, "csharp");
@@usage(MaintenanceWindowForPatch, Usage.input, "csharp");
@@usage(AuthConfigForPatch, Usage.input, "csharp");
@@usage(MigrationSecretParametersForPatch, Usage.input, "csharp");
@@usage(AdminCredentialsForPatch, Usage.input, "csharp");

// Preserve backward-compatible version enum member names
@@clientName(PostgresMajorVersion.`16`, "Sixteen", "csharp");
@@clientName(PostgresMajorVersion.`17`, "Seventeen", "csharp");
@@clientName(PostgresMajorVersion.`18`, "Eighteen", "csharp");
@@clientName(
  Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);

// Rename AdministratorMicrosoftEntraAdd to preserve backward-compatible C# name
@@clientName(
  AdministratorMicrosoftEntraAdd,
  "PostgreSqlFlexibleServerMicrosoftEntraAdministratorCreateOrUpdateContent",
  "csharp"
);
@@usage(AdministratorMicrosoftEntraAdd, Usage.input, "csharp");

// Note: Removed @@usage for MigrationSubstateDetails, ValidationDetails, ValidationSummaryItem,
// DbLevelValidationStatus, ObjectRecommendationDetails to preserve IReadOnlyList property types
// for backward compatibility with the 1.4.1 API contract.

// Fix TenantId type on AdministratorMicrosoftEntraPropertiesForAdd (string → Guid?)
@@alternateType(
  AdministratorMicrosoftEntraPropertiesForAdd.tenantId,
  Azure.Core.uuid,
  "csharp"
);

// Fix LogFile.Uri type (string → System.Uri)
@@alternateType(CapturedLogProperties.url, TypeSpec.url, "csharp");

// Restore old property name TypePropertiesType on LogFile
@@clientName(CapturedLogProperties.type, "TypePropertiesType", "csharp");

// Make ForPatch types public via @@usage (@@access alone doesn't work for these types)
@@usage(AuthConfigForPatch, Usage.input, "csharp");
@@usage(BackupForPatch, Usage.input, "csharp");
@@usage(HighAvailabilityForPatch, Usage.input, "csharp");
@@usage(MaintenanceWindowForPatch, Usage.input, "csharp");
@@usage(SkuForPatch, Usage.input, "csharp");
@@usage(MigrationSecretParametersForPatch, Usage.input, "csharp");
@@usage(AdminCredentialsForPatch, Usage.input, "csharp");

@@alternateType(
  LocationParameter.locationName,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(MigrateNetworkStatus.subscriptionId, Azure.Core.uuid, "csharp");
@@alternateType(ServerForPatch.sku, Sku, "csharp");
@@alternateType(ServerPropertiesForPatch.backup, Backup, "csharp");
@@alternateType(
  ServerPropertiesForPatch.highAvailability,
  HighAvailability,
  "csharp"
);
@@alternateType(
  ServerPropertiesForPatch.maintenanceWindow,
  MaintenanceWindow,
  "csharp"
);
@@alternateType(ServerPropertiesForPatch.authConfig, AuthConfig, "csharp");
