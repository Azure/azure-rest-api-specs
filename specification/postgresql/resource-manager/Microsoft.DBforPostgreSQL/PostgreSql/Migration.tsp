import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./shared.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

using TypeSpec.Versioning;

using Azure.Core;

namespace Microsoft.DBforPostgreSQL;

/**
 * State of migration.
 */
union MigrationState {
  string,

  /** Migration is in progress. */
  InProgress: "InProgress",

  /** Migration is waiting for user action. */
  WaitingForUserAction: "WaitingForUserAction",

  /** Migration has been canceled. */
  Canceled: "Canceled",

  /** Migration has failed. */
  Failed: "Failed",

  /** Migration has succeeded. */
  Succeeded: "Succeeded",

  /** Validation for migration has failed. */
  ValidationFailed: "ValidationFailed",

  /** Migration is cleaning up resources. */
  CleaningUp: "CleaningUp",
}

/**
 * Substate of migration.
 */
union MigrationSubstate {
  string,

  /** Performing pre-requisite steps for migration. */
  PerformingPreRequisiteSteps: "PerformingPreRequisiteSteps",

  /** Waiting for logical replication setup request on source database. */
  WaitingForLogicalReplicationSetupRequestOnSourceDB: "WaitingForLogicalReplicationSetupRequestOnSourceDB",

  /** Waiting for databases to migrate specification. */
  WaitingForDBsToMigrateSpecification: "WaitingForDBsToMigrateSpecification",

  /** Waiting for target database overwrite confirmation. */
  WaitingForTargetDBOverwriteConfirmation: "WaitingForTargetDBOverwriteConfirmation",

  /** Waiting for data migration scheduling. */
  WaitingForDataMigrationScheduling: "WaitingForDataMigrationScheduling",

  /** Waiting for data migration window. */
  WaitingForDataMigrationWindow: "WaitingForDataMigrationWindow",

  /** Migrating data. */
  MigratingData: "MigratingData",

  /** Waiting for cutover trigger. */
  WaitingForCutoverTrigger: "WaitingForCutoverTrigger",

  /** Completing migration. */
  CompletingMigration: "CompletingMigration",

  /** Migration completed. */
  Completed: "Completed",

  /** Canceling requested database migrations. */
  CancelingRequestedDBMigrations: "CancelingRequestedDBMigrations",

  /** Validation in progress. */
  ValidationInProgress: "ValidationInProgress",
}

/**
 * Migration state of a database.
 */
union MigrationDatabaseState {
  string,

  /** Migration is in progress for the database. */
  InProgress: "InProgress",

  /** Migration is waiting for cutover trigger for the database. */
  WaitingForCutoverTrigger: "WaitingForCutoverTrigger",

  /** Migration has failed for the database. */
  Failed: "Failed",

  /** Migration has been canceled for the database. */
  Canceled: "Canceled",

  /** Migration has succeeded for the database. */
  Succeeded: "Succeeded",

  /** Migration is being canceled for the database. */
  Canceling: "Canceling",
}

/**
 * Validation state for migration.
 */
union ValidationState {
  string,

  /** Validation has failed. */
  Failed: "Failed",

  /** Validation has succeeded. */
  Succeeded: "Succeeded",

  /** Validation has succeeded with warnings. */
  Warning: "Warning",
}

/**
 * Mode used to perform the migration.
 */
union MigrationMode {
  string,

  /** Offline migration mode. */
  Offline: "Offline",

  /** Online migration mode. */
  Online: "Online",
}

/**
 * Supported option for a migration.
 */
union MigrationOption {
  string,

  /** Validate the migration without performing it. */
  Validate: "Validate",

  /** Perform the migration. */
  Migrate: "Migrate",

  /** Validate and perform the migration. */
  ValidateAndMigrate: "ValidateAndMigrate",
}

/**
 * Source server type used for the migration.
 */
union SourceType {
  string,

  /** On-premises PostgreSQL server. */
  OnPremises: "OnPremises",

  /** Amazon Web Services PostgreSQL server. */
  AWS: "AWS",

  /** Google Cloud Platform PostgreSQL server. */
  GCP: "GCP",

  /** Azure Virtual Machine PostgreSQL server. */
  AzureVM: "AzureVM",

  /** Azure Database for PostgreSQL single server. */
  PostgreSQLSingleServer: "PostgreSQLSingleServer",

  /** Amazon RDS for PostgreSQL. */
  AWS_RDS: "AWS_RDS",

  /** Amazon Aurora for PostgreSQL. */
  AWS_AURORA: "AWS_AURORA",

  /** Amazon EC2 for PostgreSQL. */
  AWS_EC2: "AWS_EC2",

  /** Google Cloud SQL for PostgreSQL. */
  GCP_CloudSQL: "GCP_CloudSQL",

  /** Google Cloud AlloyDB for PostgreSQL. */
  GCP_AlloyDB: "GCP_AlloyDB",

  /** Google Compute Engine for PostgreSQL. */
  GCP_Compute: "GCP_Compute",

  /** EnterpriseDB PostgreSQL server. */
  EDB: "EDB",

  /** EnterpriseDB Oracle Server. */
  EDB_Oracle_Server: "EDB_Oracle_Server",

  /** EnterpriseDB PostgreSQL server. */
  EDB_PostgreSQL: "EDB_PostgreSQL",

  /** Azure Database for PostgreSQL flexible server. */
  PostgreSQLFlexibleServer: "PostgreSQLFlexibleServer",

  /** .NET Cosmos DB for PostgreSQL */
  PostgreSQLCosmosDB: "PostgreSQLCosmosDB",

  /** Huawei RDS for PostgreSQL */
  Huawei_RDS: "Huawei_RDS",

  /** Huawei Compute for PostgreSQL */
  Huawei_Compute: "Huawei_Compute",

  /** Heroku PostgreSQL */
  Heroku_PostgreSQL: "Heroku_PostgreSQL",

  /** Crunchy PostgreSQL */
  Crunchy_PostgreSQL: "Crunchy_PostgreSQL",

  /** ApsaraDB RDS for PostgreSQL */
  ApsaraDB_RDS: "ApsaraDB_RDS",

  /** Digital Ocean Droplets for PostgreSQL */
  Digital_Ocean_Droplets: "Digital_Ocean_Droplets",

  /** Digital Ocean PostgreSQL */
  Digital_Ocean_PostgreSQL: "Digital_Ocean_PostgreSQL",

  /** Supabase PostgreSQL */
  Supabase_PostgreSQL: "Supabase_PostgreSQL",
}

/**
 * SSL mode used by a migration. Default SSL mode for 'PostgreSQLSingleServer' is 'VerifyFull'. Default SSL mode for other source types is 'Prefer'.
 */
union SslMode {
  string,

  /** Prefer SSL connection. If the server does not support SSL, the connection will be established without SSL. */
  Prefer: "Prefer",

  /** Require SSL connection. If the server does not support SSL, the connection will fail. */
  Require: "Require",

  /** Require SSL connection and verify the server certificate against the CA certificate. */
  VerifyCA: "VerifyCA",

  /** Require SSL connection, verify the server certificate against the CA certificate, and verify that the server hostname matches the certificate. */
  VerifyFull: "VerifyFull",
}

/**
 * Indicates whether to setup logical replication on source server, if needed.
 */
union LogicalReplicationOnSourceServer {
  string,

  /** Logical replication will be set up on the source server. */
  True: "True",

  /** Logical replication will not be set up on the source server. */
  False: "False",
}

/**
 * Indicates if databases on the target server can be overwritten when already present.
 */
union OverwriteDatabasesOnTargetServer {
  string,

  /** Databases on the target server can be overwritten when already present. */
  True: "True",

  /** Databases on the target server cannot be overwritten when already present. When the migration workflow detects that the database already exists on the target server, it will wait for a confirmation. */
  False: "False",
}

/**
 * Indicates if roles and permissions must be migrated.
 */
union MigrateRolesAndPermissions {
  string,

  /** Roles and permissions will be migrated. */
  True: "True",

  /** Roles and permissions will not be migrated. */
  False: "False",
}

/**
 * Indicates if data migration must start right away.
 */
union StartDataMigration {
  string,

  /** Data migration must start right away. */
  True: "True",

  /** Data migration must not start right away. */
  False: "False",
}

/**
 * Indicates if cutover must be triggered for the entire migration.
 */
union TriggerCutover {
  string,

  /** Cutover must be triggered for the entire migration. */
  True: "True",

  /** Cutover must not be triggered for the entire migration. */
  False: "False",
}

/**
 * Indicates if cancel must be triggered for the entire migration.
 */
union Cancel {
  string,

  /** Cancel must be triggered for the entire migration. */
  True: "True",

  /** Cancel must not be triggered for the entire migration. */
  False: "False",
}

/**
 * Indicates the filter to apply when listing migrations.
 */
union MigrationListFilter {
  string,

  /** Only active (in-progress) migrations. */
  Active: "Active",

  /** All migrations. */
  All: "All",
}

/**
 * Migration name availability reason.
 */
union MigrationNameAvailabilityReason {
  string,

  /** Migration name is invalid. */
  Invalid: "Invalid",

  /** Migration name already exists. */
  AlreadyExists: "AlreadyExists",
}

/**
 * Level of details of a migration.
 */
union MigrationDetailsLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Summary: "Summary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Full: "Full",
}

/**
 * Migration.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MigrationProperties {
  /**
   * Identifier of a migration.
   */
  @visibility(Lifecycle.Read)
  migrationId?: string;

  /**
   * Current status of a migration.
   */
  @visibility(Lifecycle.Read)
  currentStatus?: MigrationStatus;

  /**
   * Identifier of the private endpoint migration instance.
   */
  migrationInstanceResourceId?: armResourceIdentifier;

  /**
   * Mode used to perform the migration: Online or Offline.
   */
  migrationMode?: MigrationMode;

  /**
   * Supported option for a migration.
   */
  migrationOption?: MigrationOption;

  /**
   * Source server type used for the migration: ApsaraDB_RDS, AWS, AWS_AURORA, AWS_EC2, AWS_RDS, AzureVM, Crunchy_PostgreSQL, Digital_Ocean_Droplets, Digital_Ocean_PostgreSQL, EDB, EDB_Oracle_Server, EDB_PostgreSQL, GCP, GCP_AlloyDB, GCP_CloudSQL, GCP_Compute, Heroku_PostgreSQL, Huawei_Compute, Huawei_RDS, OnPremises, PostgreSQLCosmosDB, PostgreSQLFlexibleServer, PostgreSQLSingleServer, or Supabase_PostgreSQL
   */
  sourceType?: SourceType;

  /**
   * SSL mode used by a migration. Default SSL mode for 'PostgreSQLSingleServer' is 'VerifyFull'. Default SSL mode for other source types is 'Prefer'.
   */
  sslMode?: SslMode;

  /**
   * Metadata of source database server.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  @visibility(Lifecycle.Read)
  sourceDbServerMetadata?: DbServerMetadata;

  /**
   * Metadata of target database server.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  @visibility(Lifecycle.Read)
  targetDbServerMetadata?: DbServerMetadata;

  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  @doc("Identifier of the source database server resource, when 'sourceType' is 'PostgreSQLSingleServer'. For other source types this must be set to ipaddress:port@username or hostname:port@username.")
  sourceDbServerResourceId?: string;

  /**
   * Fully qualified domain name (FQDN) or IP address of the source server. This property is optional. When provided, the migration service will always use it to connect to the source server.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  sourceDbServerFullyQualifiedDomainName?: string;

  /**
   * Identifier of the target database server resource.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  @visibility(Lifecycle.Read)
  targetDbServerResourceId?: string;

  /**
   * Fully qualified domain name (FQDN) or IP address of the target server. This property is optional. When provided, the migration service will always use it to connect to the target server.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  targetDbServerFullyQualifiedDomainName?: string;

  /**
   * Migration secret parameters.
   */
  secretParameters?: MigrationSecretParameters;

  /**
   * Names of databases to migrate.
   */
  @maxItems(50)
  dbsToMigrate?: string[];

  /**
   * Indicates whether to setup logical replication on source server, if needed.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  setupLogicalReplicationOnSourceDbIfNeeded?: LogicalReplicationOnSourceServer;

  /**
   * Indicates if databases on the target server can be overwritten when already present. If set to 'False', when the migration workflow detects that the database already exists on the target server, it will wait for a confirmation.
   */
  overwriteDbsInTarget?: OverwriteDatabasesOnTargetServer;

  /**
   * Start time (UTC) for migration window.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  migrationWindowStartTimeInUtc?: utcDateTime;

  /**
   * End time (UTC) for migration window.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  migrationWindowEndTimeInUtc?: utcDateTime;

  /**
   * Indicates if roles and permissions must be migrated.
   */
  migrateRoles?: MigrateRolesAndPermissions;

  /**
   * Indicates if data migration must start right away.
   */
  startDataMigration?: StartDataMigration;

  /**
   * Indicates if cutover must be triggered for the entire migration.
   */
  triggerCutover?: TriggerCutover;

  /**
   * When you want to trigger cutover for specific databases set 'triggerCutover' to 'True' and the names of the specific databases in this array.
   */
  dbsToTriggerCutoverOn?: string[];

  /**
   * Indicates if cancel must be triggered for the entire migration.
   */
  cancel?: Cancel;

  /**
   * When you want to trigger cancel for specific databases set 'triggerCutover' to 'True' and the names of the specific databases in this array.
   */
  dbsToCancelMigrationOn?: string[];
}

/**
 * State of migration.
 */
model MigrationStatus {
  /**
   * State of migration.
   */
  @visibility(Lifecycle.Read)
  state?: MigrationState;

  /**
   * Error message, if any, for the migration state.
   */
  @visibility(Lifecycle.Read)
  error?: string;

  /**
   * Current migration sub state details.
   */
  @visibility(Lifecycle.Read)
  currentSubStateDetails?: MigrationSubstateDetails;
}

/**
 * Details of migration substate.
 */
model MigrationSubstateDetails {
  /**
   * Substate of migration.
   */
  @visibility(Lifecycle.Read)
  currentSubState?: MigrationSubstate;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  dbDetails?: Record<DatabaseMigrationState>;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  validationDetails?: ValidationDetails;
}

/**
 * Migration state of a database.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
model DatabaseMigrationState {
  /**
   * Name of database.
   */
  databaseName?: string;

  /**
   * Migration state of a database.
   */
  migrationState?: MigrationDatabaseState;

  /**
   * Migration operation of a database.
   */
  migrationOperation?: string;

  /**
   * Start time of a migration state.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * End time of a migration state.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Number of tables queued for the migration of a database.
   */
  fullLoadQueuedTables?: int32;

  /**
   * Number of tables encountering errors during the migration of a database.
   */
  fullLoadErroredTables?: int32;

  /**
   * Number of tables loading during the migration of a database.
   */
  fullLoadLoadingTables?: int32;

  /**
   * Number of tables loaded during the migration of a database.
   */
  fullLoadCompletedTables?: int32;

  /**
   * Change Data Capture update counter.
   */
  cdcUpdateCounter?: int32;

  /**
   * Change Data Capture delete counter.
   */
  cdcDeleteCounter?: int32;

  /**
   * Change Data Capture insert counter.
   */
  cdcInsertCounter?: int32;

  /**
   * Change Data Capture applied changes counter.
   */
  appliedChanges?: int32;

  /**
   * Change Data Capture incoming changes counter.
   */
  incomingChanges?: int32;

  /**
   * Lag in seconds between source and target during online phase.
   */
  latency?: int32;

  /**
   * Error message, if any, for the migration state.
   */
  message?: string;
}

/**
 * Details for the validation for migration.
 */
model ValidationDetails {
  /**
   * Validation status for migration.
   */
  status?: ValidationState;

  /**
   * Start time (UTC) for validation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  validationStartTimeInUtc?: utcDateTime;

  /**
   * End time (UTC) for validation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  validationEndTimeInUtc?: utcDateTime;

  /**
   * Details of server level validations.
   */
  @identifiers(#[])
  serverLevelValidationDetails?: ValidationSummaryItem[];

  /**
   * Details of server level validations.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  @identifiers(#["databaseName"])
  dbLevelValidationDetails?: DbLevelValidationStatus[];
}

/**
 * Validation summary object.
 */
model ValidationSummaryItem {
  /**
   * Validation type.
   */
  type?: string;

  /**
   * Validation status for migration.
   */
  state?: ValidationState;

  /**
   * Validation messages.
   */
  @identifiers(#[])
  messages?: ValidationMessage[];
}

/**
 * Validation message object.
 */
model ValidationMessage {
  /**
   * Severity of validation message.
   */
  state?: ValidationState;

  /**
   * Validation message string.
   */
  message?: string;
}

/**
 * Validation status summary for a database.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
model DbLevelValidationStatus {
  /**
   * Name of database.
   */
  databaseName?: string;

  /**
   * Start time of a database level validation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedOn?: utcDateTime;

  /**
   * End time of a database level validation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endedOn?: utcDateTime;

  /**
   * Summary of database level validations.
   */
  @identifiers(#[])
  summary?: ValidationSummaryItem[];
}

/**
 * Database server metadata.
 */
model DbServerMetadata {
  /**
   * Location of database server.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Major version of PostgreSQL database engine.
   */
  version?: string;

  /**
   * Storage size (in MB) for database server.
   */
  storageMb?: int32;

  /**
   * Compute tier and size of the database server. This object is empty for an Azure Database for PostgreSQL single server.
   */
  sku?: ServerSku;
}

/**
 * Compute information of a server.
 */
model ServerSku {
  /**
   * Compute tier and size of the database server. This object is empty for an Azure Database for PostgreSQL single server.
   */
  name?: string;

  /**
   * Tier of the compute assigned to a server.
   */
  tier?: SkuTier;
}

/**
 * Migration secret parameters.
 */
model MigrationSecretParameters {
  /**
   * Credentials of administrator users for source and target servers.
   */
  @secret
  adminCredentials: AdminCredentials;

  /**
   * Gets or sets the name of the user for the source server. This user doesn't need to be an administrator.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  sourceServerUsername?: string;

  /**
   * Gets or sets the name of the user for the target server. This user doesn't need to be an administrator.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  targetServerUsername?: string;
}

/**
 * Credentials of administrator users for source and target servers.
 */
model AdminCredentials {
  /**
   * Password for the user of the source server.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  sourceServerPassword: string;

  /**
   * Password for the user of the target server.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  targetServerPassword: string;
}

/**
 * Migration.
 */
model MigrationResourceForPatch {
  /**
   * Migration properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: MigrationPropertiesForPatch;

  /**
   * Application-specific metadata in the form of key-value pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Migration properties.
 */
model MigrationPropertiesForPatch {
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  @doc("Identifier of the source database server resource, when 'sourceType' is 'PostgreSQLSingleServer'. For other source types this must be set to ipaddress:port@username or hostname:port@username.")
  sourceDbServerResourceId?: string;

  /**
   * Fully qualified domain name (FQDN) or IP address of the source server. This property is optional. When provided, the migration service will always use it to connect to the source server.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  sourceDbServerFullyQualifiedDomainName?: string;

  /**
   * Fully qualified domain name (FQDN) or IP address of the target server. This property is optional. When provided, the migration service will always use it to connect to the target server.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  targetDbServerFullyQualifiedDomainName?: string;

  /**
   * Migration secret parameters.
   */
  secretParameters?: MigrationSecretParametersForPatch;

  /**
   * Names of databases to migrate.
   */
  @maxItems(50)
  dbsToMigrate?: string[];

  /**
   * Indicates whether to setup logical replication on source server, if needed.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  setupLogicalReplicationOnSourceDbIfNeeded?: LogicalReplicationOnSourceServer;

  /**
   * Indicates if databases on the target server can be overwritten when already present. If set to 'False', when the migration workflow detects that the database already exists on the target server, it will wait for a confirmation.
   */
  overwriteDbsInTarget?: OverwriteDatabasesOnTargetServer;

  /**
   * Start time (UTC) for migration window.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  migrationWindowStartTimeInUtc?: utcDateTime;

  /**
   * Indicates if roles and permissions must be migrated.
   */
  migrateRoles?: MigrateRolesAndPermissions;

  /**
   * Indicates if data migration must start right away.
   */
  startDataMigration?: StartDataMigration;

  /**
   * Indicates if cutover must be triggered for the entire migration.
   */
  triggerCutover?: TriggerCutover;

  /**
   * When you want to trigger cutover for specific databases set 'triggerCutover' to 'True' and the names of the specific databases in this array.
   */
  dbsToTriggerCutoverOn?: string[];

  /**
   * Indicates if cancel must be triggered for the entire migration.
   */
  cancel?: Cancel;

  /**
   * When you want to trigger cancel for specific databases set 'triggerCutover' to 'True' and the names of the specific databases in this array.
   */
  dbsToCancelMigrationOn?: string[];

  /**
   * Mode used to perform the migration: Online or Offline.
   */
  migrationMode?: MigrationMode;
}

/**
 * Migration secret parameters.
 */
model MigrationSecretParametersForPatch {
  /**
   * Credentials of administrator users for source and target servers.
   */
  @secret
  adminCredentials?: AdminCredentialsForPatch;

  /**
   * Gets or sets the name of the user for the source server. This user doesn't need to be an administrator.
   */
  @visibility(Lifecycle.Update)
  sourceServerUsername?: string;

  /**
   * Gets or sets the name of the user for the target server. This user doesn't need to be an administrator.
   */
  @visibility(Lifecycle.Update)
  targetServerUsername?: string;
}

/**
 * Credentials of administrator users for source and target servers.
 */
model AdminCredentialsForPatch {
  /**
   * Password for the user of the source server.
   */
  @visibility(Lifecycle.Update)
  @secret
  sourceServerPassword?: string;

  /**
   * Password for the user of the target server.
   */
  @visibility(Lifecycle.Update)
  @secret
  targetServerPassword?: string;
}

/**
 * List of migrations.
 */
model MigrationList is Azure.Core.Page<Migration>;

/**
 * Availability of a migration name.
 */
model MigrationNameAvailability {
  /**
   * Name of the migration to check for validity and availability.
   */
  name: string;

  /**
   * Type of resource.
   */
  type: string;

  /**
   * Indicates if the migration name is available.
   */
  @visibility(Lifecycle.Read)
  nameAvailable?: boolean;

  /**
   * Migration name availability reason.
   */
  @visibility(Lifecycle.Read)
  reason?: MigrationNameAvailabilityReason;

  /**
   * Migration name availability message.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

@@visibility(MigrationList.value, Lifecycle.Read);

/**
 * Properties of a migration.
 */
@parentResource(Server)
model Migration is Azure.ResourceManager.TrackedResource<MigrationProperties> {
  ...ResourceNameParameter<
    Resource = Migration,
    KeyName = "migrationName",
    SegmentName = "migrations",
    NamePattern = "^[a-z][a-z0-9]*$"
  >;
}

@armResourceOperations
interface Migrations {
  /**
   * Gets information about a migration.
   */
  get is ArmResourceRead<Migration>;

  /**
   * Creates a new migration.
   */
  create is ArmResourceCreateOrReplaceSync<Migration>;

  /**
   * Updates an existing migration. The request body can contain one to many of the mutable properties present in the migration definition. Certain property updates initiate migration state transitions.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Migration,
    PatchModel = MigrationResourceForPatch
  >;

  /**
   * Cancels an active migration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "Existing DELETE 200 response body is retained for backward compatibility."
  cancel is ArmResourceDeleteSync<
    Migration,
    Response = ArmResponse<Migration> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all migrations of a target flexible server.
   */
  listByTargetServer is ArmResourceListByParent<
    Migration,
    Parameters = {
      /**
       * Migration list filter. Indicates if the request should retrieve only active migrations or all migrations. Defaults to Active.
       */
      @query("migrationListFilter")
      migrationListFilter?: MigrationListFilter;
    },
    Response = ArmResponse<MigrationList>
  >;
}

@@doc(Migration.name, "Name of migration.");
@@doc(Migration.properties, "Migration properties.");
@@doc(
  Migrations.create::parameters.resource,
  "Parameters required for creating a migration."
);
@@doc(
  Migrations.update::parameters.properties,
  "Parameters required to update an existing migration."
);
