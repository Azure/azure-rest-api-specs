import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.DBforPostgreSQL;
using Azure.ClientGenerator.Core;

@@clientName(Microsoft.DBforPostgreSQL, "PostgreSQLManagementClient", "python");
@@clientName(Microsoft.DBforPostgreSQL,
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

@@clientName(Microsoft.DBforPostgreSQL.ServerProperties.pointInTimeUTC,
  "pointInTimeUtc",
  "java"
);
@@clientName(Microsoft.DBforPostgreSQL.DataEncryption.primaryKeyURI,
  "primaryKeyUri",
  "java"
);
@@clientName(Microsoft.DBforPostgreSQL.DataEncryption.geoBackupKeyURI,
  "geoBackupKeyUri",
  "java"
);
@@clientName(RequestIdResponseHeader.requestId, "xMsRequestId", "java,go");

@@clientName(Microsoft.DBforPostgreSQL.PostgreSqlFlexibleServerHighAvailabilityMode,
  "HighAvailabilityMode",
  "java,go"
);
@@clientName(Microsoft.DBforPostgreSQL.HighAvailabilityMode,
  "SupportedHighAvailabilityMode",
  "java,go"
);
@@alternateType(Microsoft.DBforPostgreSQL.ServerSkuCapability.supportedHaMode,
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
@@clientName(ConfigurationDataType,
  "PostgreSqlFlexibleServerConfigurationDataType",
  "csharp"
);
@@clientName(CreateModeForPatch,
  "PostgreSqlFlexibleServerCreateModeForUpdate",
  "csharp"
);
@@clientName(FailoverMode, "PostgreSqlFlexibleServerFailoverMode", "csharp");
@@clientName(GeographicallyRedundantBackup,
  "PostgreSqlFlexibleServerGeoRedundantBackupEnum",
  "csharp"
);
@@clientName(Database, "PostgreSqlFlexibleServerDatabase", "csharp");
@@clientName(FirewallRule, "PostgreSqlFlexibleServerFirewallRule", "csharp");
@@clientName(Server, "PostgreSqlFlexibleServer", "csharp");
@@clientName(PostgresMajorVersion, "PostgreSqlFlexibleServerVersion", "csharp");
@@clientName(MaintenanceWindow,
  "PostgreSqlFlexibleServerMaintenanceWindow",
  "csharp"
);
@@clientName(Backup, "PostgreSqlFlexibleServerBackupProperties", "csharp");
@@clientName(Storage, "PostgreSqlFlexibleServerStorage", "csharp");
@@clientName(Sku, "PostgreSqlFlexibleServerSku", "csharp");
@@clientName(Network, "PostgreSqlFlexibleServerNetwork", "csharp");
@@clientName(HighAvailability,
  "PostgreSqlFlexibleServerHighAvailability",
  "csharp"
);
@@clientName(ServerState, "PostgreSqlFlexibleServerState", "csharp");
@@clientName(VirtualNetworkSubnetUsageParameter,
  "PostgreSqlFlexibleServerVirtualNetworkSubnetUsageParameter",
  "csharp"
);
@@clientName(DelegatedSubnetUsage,
  "PostgreSqlFlexibleServerDelegatedSubnetUsage",
  "csharp"
);
@@clientName(VirtualNetworkSubnetUsageModel,
  "PostgreSqlFlexibleServerVirtualNetworkSubnetUsageResult",
  "csharp"
);
@@clientName(ServerVersionCapability,
  "PostgreSqlFlexibleServerServerVersionCapability",
  "csharp"
);
@@clientName(StorageEditionCapability,
  "PostgreSqlFlexibleServerStorageEditionCapability",
  "csharp"
);
@@clientName(ServerEditionCapability,
  "PostgreSqlFlexibleServerEditionCapability",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
  "PostgreSqlFlexibleServerNameAvailabilityContent",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse,
  "PostgreSqlFlexibleServerNameAvailabilityResponse",
  "csharp"
);
@@clientName(CheckNameAvailabilityReason,
  "PostgreSqlFlexibleServerNameUnavailableReason",
  "csharp"
);
@@clientName(NameAvailabilityModel,
  "PostgreSqlFlexibleServerNameAvailabilityResult",
  "csharp"
);
@@clientName(CreateMode, "PostgreSqlFlexibleServerCreateMode", "csharp");
@@clientName(SkuTier, "PostgreSqlFlexibleServerSkuTier", "csharp");
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(Storage.storageSizeGB, "StorageSizeInGB", "csharp");
@@clientName(StorageMbCapability.storageSizeMb, "StorageSizeInMB", "csharp");
@@clientName(StorageMbCapability,
  "PostgreSqlFlexibleServerStorageCapability",
  "csharp"
);
@@clientName(RestartParameter,
  "PostgreSqlFlexibleServerRestartParameter",
  "csharp"
);
@@clientName(HighAvailabilityState,
  "PostgreSqlFlexibleServerHAState",
  "csharp"
);
@@clientName(ServerPublicNetworkAccessState,
  "PostgreSqlFlexibleServerPublicNetworkAccessState",
  "csharp"
);
@@clientName(StorageEditionCapability.supportedStorageMb,
  "SupportedStorageCapabilities",
  "csharp"
);
@@clientName(ServerProperties.pointInTimeUTC, "PointInTimeUtc", "csharp");
@@clientName(MicrosoftEntraAuth,
  "PostgreSqlFlexibleServerActiveDirectoryAuthEnum",
  "csharp"
);
@@clientName(DataEncryptionType, "PostgreSqlFlexibleServerKeyType", "csharp");
@@clientName(AuthConfig, "PostgreSqlFlexibleServerAuthConfig", "csharp");
@@clientName(DataEncryption,
  "PostgreSqlFlexibleServerDataEncryption",
  "csharp"
);
@@clientName(FastProvisioningEditionCapability,
  "PostgreSqlFlexibleServerFastProvisioningEditionCapability",
  "csharp"
);
@@clientName(IdentityType, "PostgreSqlFlexibleServerIdentityType", "csharp");
@@clientName(BackupType, "PostgreSqlFlexibleServerBackupOrigin", "csharp");
@@clientName(PasswordBasedAuth,
  "PostgreSqlFlexibleServerPasswordAuthEnum",
  "csharp"
);
@@clientName(PrincipalType, "PostgreSqlFlexibleServerPrincipalType", "csharp");
@@clientName(ReplicationRole,
  "PostgreSqlFlexibleServerReplicationRole",
  "csharp"
);
@@clientName(BackupAutomaticAndOnDemand,
  "PostgreSqlFlexibleServerBackup",
  "csharp"
);
@@clientName(StorageTierCapability,
  "PostgreSqlFlexibleServerStorageTierCapability",
  "csharp"
);
@@clientName(AdminCredentials, "PostgreSqlMigrationAdminCredentials", "csharp");
@@clientName(BackupSettings,
  "PostgreSqlFlexibleServerBackupSettings",
  "csharp"
);
@@clientName(BackupStoreDetails,
  "PostgreSqlFlexibleServerBackupStoreDetails",
  "csharp"
);
@@clientName(Cancel, "PostgreSqlMigrationCancel", "csharp");
@@clientName(LogicalReplicationOnSourceServer,
  "PostgreSqlMigrationLogicalReplicationOnSourceDb",
  "csharp"
);
@@clientName(OverwriteDatabasesOnTargetServer,
  "PostgreSqlMigrationOverwriteDbsInTarget",
  "csharp"
);
@@clientName(StartDataMigration,
  "PostgreSqlMigrationStartDataMigration",
  "csharp"
);
@@clientName(TriggerCutover, "PostgreSqlMigrationTriggerCutover", "csharp");
@@clientName(CapabilityStatus,
  "PostgreSqlFlexbileServerCapabilityStatus",
  "csharp"
);
@@clientName(DbServerMetadata, "PostgreSqlServerMetadata", "csharp");
@@clientName(FastProvisioningSupport,
  "PostgreSqlFlexibleServerFastProvisioningSupported",
  "csharp"
);
@@clientName(Capability.fastProvisioningSupported,
  "SupportFastProvisioning",
  "csharp"
);
@@clientName(Capability,
  "PostgreSqlFlexibleServerCapabilityProperties",
  "csharp"
);
@@clientName(CapturedLog, "PostgreSqlFlexibleServerLogFile", "csharp");
@@clientName(GeographicallyRedundantBackupSupport,
  "PostgreSqlFlexibleServerGeoBackupSupported",
  "csharp"
);
@@clientName(ZoneRedundantHighAvailabilitySupport,
  "PostgreSqlFlexibleServerZoneRedundantHaSupported",
  "csharp"
);
@@clientName(ZoneRedundantHighAvailabilityAndGeographicallyRedundantBackupSupport,
  "PostgreSqlFlexibleServerZoneRedundantHaAndGeoBackupSupported",
  "csharp"
);
@@clientName(StorageAutoGrowthSupport,
  "PostgreSqlFlexibleServerStorageAutoGrowthSupported",
  "csharp"
);
@@clientName(OnlineStorageResizeSupport,
  "PostgreSqlFlexibleServerOnlineResizeSupported",
  "csharp"
);
@@clientName(LocationRestricted,
  "PostgreSqlFlexibleServerZoneRedundantRestricted",
  "csharp"
);
@@clientName(ServerSkuCapability,
  "PostgreSqlFlexibleServerSkuCapability",
  "csharp"
);
@@clientName(CapabilityBase.status, "CapabilityStatus", "csharp");
@@clientName(CapabilityBase, "PostgreSqlBaseCapability", "csharp");
@@clientName(ExecutionStatus, "PostgreSqlExecutionStatus", "csharp");
@@clientName(EncryptionKeyStatus, "PostgreSqlKeyStatus", "csharp");
@@clientName(BackupsLongTermRetentionResponse,
  "PostgreSqlFlexibleServerLtrBackupResult",
  "csharp"
);
@@clientName(LtrPreBackupResponse,
  "PostgreSqlFlexibleServerLtrPreBackupResult",
  "csharp"
);
@@clientName(MigrationListFilter, "PostgreSqlMigrationListFilter", "csharp");
@@clientName(MigrationMode, "PostgreSqlMigrationMode", "csharp");
@@clientName(MigrationNameAvailabilityReason,
  "PostgreSqlMigrationNameUnavailableReason",
  "csharp"
);
@@clientName(MigrationNameAvailability,
  "PostgreSqlCheckMigrationNameAvailabilityContent",
  "csharp"
);
@@clientName(MigrationNameAvailability.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(MigrationSecretParameters,
  "PostgreSqlMigrationSecretParameters",
  "csharp"
);
@@clientName(MigrationState, "PostgreSqlMigrationState", "csharp");
@@clientName(MigrationStatus, "PostgreSqlMigrationStatus", "csharp");
@@clientName(MigrationSubstate, "PostgreSqlMigrationSubState", "csharp");
@@clientName(MigrationSubstateDetails,
  "PostgreSqlMigrationSubStateDetails",
  "csharp"
);
@@clientName(BackupRequestBase, "PostgreSqlBackupContent", "csharp");
@@clientName(AzureManagedDiskPerformanceTier,
  "PostgreSqlManagedDiskPerformanceTier",
  "csharp"
);
@@clientName(BackupsLongTermRetentionRequest,
  "PostgreSqlFlexibleServerLtrBackupContent",
  "csharp"
);
@@clientName(LtrPreBackupRequest,
  "PostgreSqlFlexibleServerLtrPreBackupContent",
  "csharp"
);
@@clientName(Migration, "PostgreSqlMigration", "csharp");
@@alternateType(AdministratorMicrosoftEntraProperties.objectId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(DataEncryption.primaryUserAssignedIdentityId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(AdvancedThreatProtectionSettingsModel,
  "ServerThreatProtectionSettingsModel",
  "csharp"
);
@@clientName(AdministratorMicrosoftEntra,
  "PostgreSqlFlexibleServerMicrosoftEntraAdministrator",
  "csharp"
);
@@clientName(LtrServerBackupOperationList,
  "PostgreSqlLtrServerBackupOperationList",
  "csharp"
);
@@clientName(BackupsLongTermRetentionOperation,
  "PostgreSqlLtrServerBackupOperation",
  "csharp"
);
@@clientName(VirtualEndpoint, "VirtualEndpointResource", "csharp");
@@clientName(ReadReplicaPromoteOption, "ReplicationPromoteOption", "csharp");
@@clientName(MigrationDatabaseState, "MigrationDbState", "csharp");
@@clientName(MigrateRolesAndPermissions, "MigrateRolesEnum", "csharp");
@@clientName(DatabaseMigrationState, "DbMigrationStatus", "csharp");
@@clientName(UserAssignedIdentity,
  "PostgreSqlFlexibleServerUserAssignedIdentity",
  "csharp"
);
@@clientName(HighAvailabilityMode, "PostgreSqlFlexibleServerHAMode", "csharp");
@@clientName(TuningOptions, "PostgreSqlFlexibleServerTuningOption", "csharp");
@@clientName(FeatureStatus, "PostgreSqlFlexibleServerFeatureStatus", "csharp");
@@clientName(ImpactRecord, "RecommendationImpactRecord", "csharp");
@@clientName(NameProperty, "QuotaUsageNameProperty", "csharp");
@@clientName(ObjectRecommendationPropertiesAnalyzedWorkload,
  "ObjectRecommendationAnalyzedWorkload",
  "csharp"
);
@@clientName(ObjectRecommendationPropertiesImplementationDetails,
  "ObjectRecommendationImplementationDetails",
  "csharp"
);
@@clientName(QuotaUsage, "PostgreSqlFlexibleServerQuotaUsage", "csharp");
@@clientName(RecommendationTypeEnum,
  "PostgreSqlFlexibleServerRecommendationType",
  "csharp"
);
@@clientName(RecommendationTypeParameterEnum,
  "PostgreSqlFlexibleServerRecommendationFilterType",
  "csharp"
);
@@clientName(SupportedFeature,
  "PostgreSqlFlexibleServerSupportedFeature",
  "csharp"
);
@@clientName(TuningOptionParameterEnum,
  "PostgreSqlFlexibleServerTuningOptionType",
  "csharp"
);
