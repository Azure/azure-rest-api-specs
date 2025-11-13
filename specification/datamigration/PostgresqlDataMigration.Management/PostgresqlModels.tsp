import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using OpenAPI;

namespace Microsoft.DataMigration;

@doc("The mode of the database migration.")
union MigrationMode {
  string,

  @doc("Offline migration mode")
  Offline: "offline",

  @doc("Online migration mode")
  Online: "online",
}

@doc("The source database engine type.")
union SourceDatabaseEngine {
  string,

  @doc("Oracle database engine")
  Oracle: "oracle",

  @doc("PostgreSQL database engine")
  Postgres: "postgres",

  @doc("Azure PostgreSQL Flexible Server")
  AzurePostgresFlexible: "azure_postgres_flexible",
}

@doc("The source database engine type.")
union TargetDatabaseEngine {
  string,

  @doc("Azure PostgreSQL Flexible Server")
  AzurePostgresFlexible: "azure_postgres_flexible",

  @doc("Azure PostgreSQL Orion")
  AzurePostgresOrion: "azure_postgres_orion",
}

@doc("The authentication method for database connection.")
union AuthenticationMethod {
  string,

  @doc("Password authentication")
  Password: "password",
}

@doc("The SSL mode for database connection.")
union SslMode {
  string,

  @doc("Require SSL connection")
  Require: "require",

  @doc("Prefer SSL connection")
  Prefer: "prefer",

  @doc("Disable SSL connection")
  Disable: "disable",
}

@doc("The scope of the mapping.")
union MappingScope {
  string,

  @doc("Schema level mapping")
  Schema: "schema",

  @doc("Database level mapping")
  Database: "database",
}

@doc("The provisioning state of the resource.")
union ProvisioningState {
  string,

  @doc("Resource is being provisioned")
  Provisioning: "Provisioning",

  @doc("Resource provisioning succeeded")
  Succeeded: "Succeeded",

  @doc("Resource provisioning failed")
  Failed: "Failed",

  @doc("Resource is being updated")
  Updating: "Updating",

  @doc("Resource is being deleted")
  Deleting: "Deleting",
}

@doc("The migration status state.")
union MigrationState {
  string,

  @doc("Migration is in progress")
  InProgress: "InProgress",

  @doc("Migration succeeded")
  Succeeded: "Succeeded",

  @doc("Migration failed")
  Failed: "Failed",

  @doc("Migration is pending")
  Pending: "Pending",

  @doc("Migration is cancelled")
  Cancelled: "Cancelled",

  @doc("Migration is being cancelled")
  Cancelling: "Cancelling",

  @doc("Cutover is in progress")
  CutoverInProgress: "CutoverInProgress",
}

@doc("The type of migration operation.")
union MigrationOperationType {
  string,

  @doc("Cancel the migration")
  Cancel: "cancel",

  @doc("Perform cutover")
  Cutover: "cutover",
}

@doc("The connection status.")
union ConnectionStatus {
  string,

  @doc("Connection test in progress")
  InProgress: "InProgress",

  @doc("Connection test succeeded")
  Succeeded: "Succeeded",

  @doc("Connection test failed")
  Failed: "Failed",
}

@doc("The validation status.")
union ValidationStatus {
  string,

  @doc("Validation succeeded")
  Succeeded: "Succeeded",

  @doc("Validation failed")
  Failed: "Failed",

  @doc("Validation in progress")
  InProgress: "InProgress",

  @doc("Validation pending")
  Pending: "Pending",
}

@doc("The migration phase.")
union MigrationPhase {
  string,

  @doc("Data migration phase")
  DataMigration: "DataMigration",

  @doc("Schema migration phase")
  SchemaMigration: "SchemaMigration",

  @doc("Validation phase")
  Validation: "Validation",

  @doc("Cutover phase")
  Cutover: "Cutover",
}

@doc("Error severity level.")
union ErrorSeverity {
  string,

  @doc("Critical error")
  Critical: "Critical",

  @doc("Error")
  Error: "Error",

  @doc("Warning")
  Warning: "Warning",

  @doc("Information")
  Info: "Info",
}

@doc("SSL configuration for database connection.")
model SslConfiguration {
  @doc("SSL mode")
  mode: SslMode;
}

@doc("Credentials for database authentication.")
model DatabaseCredentials {
  @doc("Authentication method")
  authenticationMethod: AuthenticationMethod;

  @doc("User name for authentication")
  userName: string;

  @doc("Password for authentication")
  @secret
  password: string;
}

@doc("Connection endpoint for database.")
model ConnectionEndpoint {
  @doc("Connection name")
  connectionName: string;

  @doc("Host name of the database server")
  hostName: string;

  @doc("Port number")
  port: int32;

  @doc("Service name (for Oracle)")
  serviceName?: string;

  @doc("Database name")
  databaseName?: string;

  @doc("Database credentials")
  credentials: DatabaseCredentials;

  @doc("SSL configuration")
  ssl: SslConfiguration;
}

@doc("Source database configuration.")
model SourceConfiguration {
  @doc("Database engine type")
  engine: SourceDatabaseEngine;

  @doc("Server resource ID")
  serverResourceId?: string;

  @doc("List of connection endpoints")
  @OpenAPI.extension("x-ms-identifiers", #["connectionName"])
  connectionEndPoints: ConnectionEndpoint[];
}

@doc("Target database configuration.")
model TargetConfiguration {
  @doc("Database engine type")
  engine: TargetDatabaseEngine;

  @doc("Server resource ID")
  serverResourceId?: string;

  @doc("List of connection endpoints")
  @OpenAPI.extension("x-ms-identifiers", #["connectionName"])
  connectionEndPoints: ConnectionEndpoint[];
}

@doc("Mapping definition for schema or database migration.")
model MappingDefinition {
  @doc("Scope of the mapping")
  mappingScope: MappingScope;

  @doc("Source schema name")
  sourceSchemaName?: string;

  @doc("Source database name")
  sourceDatabaseName?: string;

  @doc("Target database name")
  targetDatabaseName?: string;

  @doc("Target schema name")
  targetSchemaName?: string;

  @doc("Source connection name")
  sourceConnectionName: string;

  @doc("Target connection name")
  targetConnectionName: string;
}

@doc("Compute profile configuration.")
model ComputeProfile {
  @doc("Compute subnet resource ID")
  computeSubnetResourceId: string;
}

@doc("Migration job settings.")
model MigrationJobSettings {
  @doc("Validate only flag")
  validateOnly: boolean;
}

@doc("Tag key-value pair.")
model Tag {
  @doc("Tag key")
  key: string;

  @doc("Tag value")
  value: string;
}

@doc("Migration statistics.")
model MigrationStatistics {
  @doc("Total number of tables")
  tablesTotal: int32;

  @doc("Number of completed tables")
  tablesCompleted: int32;

  @doc("Number of failed tables")
  tablesFailed: int32;

  @doc("Number of tables in progress")
  tablesInProgress: int32;

  @doc("Number of pending tables")
  tablesPending: int32;

  @doc("Percentage complete")
  percentComplete: int32;
}

@doc("Migration progress information.")
model MigrationProgress {
  @doc("Current migration phase")
  migrationPhase: MigrationPhase;

  @doc("Migration statistics")
  migrationStatistics: MigrationStatistics;
}

@doc("Error information.")
model MigrationError {
  @doc("Error code")
  errorCode: string;

  @doc("Error category")
  category: string;

  @doc("Error severity")
  severity: ErrorSeverity;

  @doc("Error message")
  message: string;

  @doc("Error details")
  details: string;
}

@doc("Database migration status.")
model DatabaseMigrationStatus {
  @doc("Database name")
  databaseName: string;

  @doc("Migration status")
  migrationStatus: MigrationState;

  @doc("Validation status")
  validationStatus: ValidationStatus;

  @doc("Migration progress")
  migrationProgress: MigrationProgress;

  @doc("List of errors")
  @OpenAPI.extension("x-ms-identifiers", #[])
  errors: MigrationError[];

  @doc("Creation timestamp")
  @visibility(Lifecycle.Read)
  createdAt: utcDateTime;

  @doc("Last updated timestamp")
  @visibility(Lifecycle.Read)
  lastUpdatedAt: utcDateTime;
}

@doc("Overall migration status.")
model MigrationStatus {
  @doc("Current state of the migration")
  state: MigrationState;

  @doc("List of errors")
  @OpenAPI.extension("x-ms-identifiers", #[])
  errors: MigrationError[];

  @doc("Last updated timestamp")
  lastUpdatedAt: utcDateTime;
}

@doc("Properties of the DatabaseMigration resource.")
model DatabaseMigrationProperties {
  @doc("Migration name")
  migrationName: string;

  @doc("Migration description")
  description: string;

  @doc("Migration mode")
  migrationMode: MigrationMode;

  @doc("Source database configuration")
  source: SourceConfiguration;

  @doc("Target database configuration")
  target: TargetConfiguration;

  @doc("List of mapping definitions")
  @OpenAPI.extension("x-ms-identifiers", #[])
  mappingDefinitions: MappingDefinition[];

  @doc("Compute profile")
  computeProfile: ComputeProfile;

  @doc("Migration job settings")
  migrationJobsettings: MigrationJobSettings;

  @doc("List of tags")
  @OpenAPI.extension("x-ms-identifiers", #["key"])
  tags: Tag[];

  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Migration status")
  @visibility(Lifecycle.Read)
  migrationStatus?: MigrationStatus;

  @doc("List of database migration statuses")
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["databaseName"])
  databases?: DatabaseMigrationStatus[];

  @doc("Migration start time")
  @visibility(Lifecycle.Read)
  startedAt?: utcDateTime;

  @doc("Migration end time")
  @visibility(Lifecycle.Read)
  endedAt?: utcDateTime;
}

@doc("Properties for updating a DatabaseMigration resource with operation type.")
model DatabaseMigrationUpdateProperties {
  @doc("The type of operation to perform on the migration")
  operationType: MigrationOperationType;

  @doc("List of database names to apply the operation to. If not specified, applies to all databases.")
  databaseNames?: string[];
}

@doc("Request body for testing connectivity.")
model TestConnectivityRequest {
  @doc("Source database configuration")
  source: SourceConfiguration;

  @doc("Target database configuration")
  target: TargetConfiguration;

  @doc("Compute profile configuration")
  computeProfile: ComputeProfile;
}

@doc("Connection test result for a single endpoint.")
model ConnectionTestResult {
  @doc("Connection name")
  connectionName: string;

  @doc("Connection status")
  connectionStatus: ConnectionStatus;

  @doc("List of errors encountered during connection test")
  @OpenAPI.extension("x-ms-identifiers", #[])
  errors: MigrationError[];
}

@doc("Properties of the connectivity test response.")
model ConnectivityTestProperties {
  @doc("Source connection test results")
  @OpenAPI.extension("x-ms-identifiers", #["connectionName"])
  source: ConnectionTestResult[];

  @doc("Target connection test results")
  @OpenAPI.extension("x-ms-identifiers", #["connectionName"])
  target: ConnectionTestResult[];
}

@doc("Response for testing connectivity.")
model TestConnectivityResponse {
  @doc("Request identifier for tracking the operation")
  requestId: string;

  @doc("Connectivity test properties")
  properties: ConnectivityTestProperties;
}

@doc("Request body for discovering database objects.")
model DiscoverDatabaseObjectsRequest {
  @doc("Source database configuration")
  source: SourceConfiguration;

  @doc("Target database configuration")
  target: TargetConfiguration;

  @doc("Compute profile configuration")
  computeProfile: ComputeProfile;
}

@doc("Schema information.")
model SchemaInfo {
  @doc("Schema name")
  schemaName: string;
}

@doc("Database information with schemas.")
model DatabaseInfo {
  @doc("Database name")
  databaseName?: string;

  @doc("Service name (for Oracle)")
  serviceName?: string;

  @doc("List of schemas in the database")
  @OpenAPI.extension("x-ms-identifiers", #["schemaName"])
  schemas: SchemaInfo[];
}

@doc("Discovered database objects for a connection.")
model DiscoveredDatabaseObjects {
  @doc("Connection name")
  connectionName: string;

  @doc("Database engine type")
  engine: string;

  @doc("List of databases discovered")
  @OpenAPI.extension("x-ms-identifiers", #["databaseName", "serviceName"])
  databases: DatabaseInfo[];
}

@doc("Response for discovering database objects.")
model DiscoverDatabaseObjectsResponse {
  @doc("Request identifier for tracking the operation")
  requestId?: string;

  @doc("Source database objects discovered")
  @OpenAPI.extension("x-ms-identifiers", #["connectionName"])
  source: DiscoveredDatabaseObjects[];

  @doc("Target database objects discovered")
  target: DiscoveredDatabaseObjects;
}
