import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Versioning;

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

  @doc("SQL authentication with username and password")
  SqlAuthentication: "sql_authentication",

  @doc("Password authentication")
  Password: "password",

  @doc("Windows authentication for SQL Server")
  WindowsAuthentication: "windows_authentication",

  @doc("Azure Active Directory integrated authentication")
  ActiveDirectoryIntegrated: "active_directory_integrated",

  @doc("Azure Active Directory authentication with username and password")
  ActiveDirectoryPassword: "active_directory_password",
}

@doc("The SSL mode for database connection.")
union SslMode {
  string,

  @doc("SslMode: None")
  None: "none",

  @doc("SSL is disabled. If the server requires SSL, the connection will fail.")
  Disable: "disable",

  @doc("Prefer non-SSL connections if the server allows them, but allow SSL connections.")
  Allow: "allow",

  @doc("Prefer SSL connections if the server allows them, but allow connections without SSL.")
  Prefer: "prefer",

  @doc("Fail the connection if the server doesn't support SSL.")
  Require: "require",

  @doc("Fail the connection if the server doesn't support SSL. Also verifies server certificate.")
  VerifyCA: "verify_ca",

  @doc("Fail the connection if the server doesn't support SSL. Also verifies server certificate with host's name.")
  VerifyFull: "verify_full",
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

  @doc("Resource provisioning was canceled")
  Canceled: "Canceled",

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

  @doc("Error level severity")
  Error: "Error",

  @doc("Warning level severity")
  Warning: "Warning",

  @doc("Information")
  Info: "Info",
}

@doc("The readiness state of validation.")
union ReadinessState {
  string,

  @doc("The validation is currently in progress.")
  InProgress: "InProgress",

  @doc("The validation has completed successfully.")
  Succeeded: "Succeeded",

  @doc("The validation has failed.")
  Failed: "Failed",
}

@doc("The readiness status of a check.")
union ReadinessStatus {
  string,

  @doc("The check completed successfully without issues.")
  Succeeded: "Succeeded",

  @doc("The check failed with errors.")
  Failed: "Failed",

  @doc("The check completed with warnings.")
  Warning: "Warning",
}

@doc("Diagnostic severity level.")
union DiagnosticSeverity {
  string,

  @doc("Warning level diagnostic")
  Warning: "Warning",

  @doc("Error level diagnostic")
  Error: "Error",
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

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "connectionName is the identifier"
  @doc("List of connection endpoints")
  connectionEndPoints: ConnectionEndpoint[];
}

@doc("Target database configuration.")
model TargetConfiguration {
  @doc("Database engine type")
  engine: TargetDatabaseEngine;

  @doc("Server resource ID")
  serverResourceId?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "connectionName is the identifier"
  @doc("List of connection endpoints")
  connectionEndPoints: ConnectionEndpoint[];
}

@doc("Mapping definition for schema or database migration.")
model DatabaseMapping {
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

  @doc("Migration progress")
  migrationProgress: MigrationProgress;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "No identifier properties for this array"
  @doc("List of errors")
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

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "No identifier properties for this array"
  @doc("List of errors")
  errors: MigrationError[];

  @doc("Last updated timestamp")
  lastUpdatedAt: utcDateTime;
}

@doc("Diagnostic information for validation result.")
model ValidationDiagnostics {
  @doc("Diagnostic code")
  code: string;

  @doc("Diagnostic message")
  message: string;

  @doc("Severity of the diagnostic")
  severity: DiagnosticSeverity;

  @doc("Diagnostic hint to help resolve issues")
  diagnosticHint: string;
}

@doc("Validation result for a pre-migration check.")
model ValidationResult {
  @doc("Status of the validation check")
  status: ReadinessStatus;

  @doc("Diagnostics information")
  diagnostics?: ValidationDiagnostics;
}

@doc("Summary of a pre-migration validation.")
model PreMigrationValidationSummary {
  @doc("Name of the validation")
  validationName: string;

  @doc("State of this specific validation")
  state: ReadinessState;

  @doc("Detailed validation result for this check")
  validationResult?: ValidationResult;
}

@doc("Pre-migration validation status.")
model PreMigrationValidationStatus {
  @doc("Overall state of the pre-migration validation")
  state: ReadinessState;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "validationName is the identifier"
  @doc("List of pre-migration validation summaries")
  preMigrationValidationSummaries?: PreMigrationValidationSummary[];
}

@doc("Properties of the DatabaseMigration resource.")
model DatabaseMigrationProperties {
  @doc("Migration name")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  migrationName: string;

  @doc("Migration description")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  description: string;

  @doc("Migration mode")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  migrationMode: MigrationMode;

  @doc("Source database configuration")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  source: SourceConfiguration;

  @doc("Target database configuration")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  target: TargetConfiguration;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "No identifier properties for this array"
  @doc("List of mapping definitions")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  mappingDefinitions: DatabaseMapping[];

  @doc("Compute profile")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  computeProfile: ComputeProfile;

  @doc("Migration job settings")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  migrationJobsettings: MigrationJobSettings;

  @doc("The type of operation to perform on the migration")
  operationType?: MigrationOperationType;

  @doc("List of database names to apply the operation to. If not specified, applies to all databases.")
  databaseNames?: string[];

  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Migration status")
  @visibility(Lifecycle.Read)
  migrationStatus?: MigrationStatus;

  @doc("Pre-migration validation status")
  @visibility(Lifecycle.Read)
  preMigrationValidations?: PreMigrationValidationStatus;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "databaseName is the identifier"
  @doc("List of database migration statuses")
  @visibility(Lifecycle.Read)
  databases?: DatabaseMigrationStatus[];

  @doc("Migration start time")
  @visibility(Lifecycle.Read)
  startedAt?: utcDateTime;

  @doc("Migration end time")
  @visibility(Lifecycle.Read)
  endedAt?: utcDateTime;
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

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "No identifier properties for this array"
  @doc("List of errors encountered during connection test")
  errors: MigrationError[];
}

@doc("Properties of the connectivity test response.")
model ConnectivityTestProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "connectionName is the identifier"
  @doc("Source connection test results")
  source: ConnectionTestResult[];

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "connectionName is the identifier"
  @doc("Target connection test results")
  target: ConnectionTestResult[];
}

@doc("Response for testing connectivity.")
model ConnectivityTestResult {
  @doc("Request identifier for tracking the operation")
  requestId: string;

  @doc("Connectivity test properties")
  properties?: ConnectivityTestProperties;
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

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "schemaName is the identifier"
  @doc("List of schemas in the database")
  schemas: SchemaInfo[];
}

@doc("Discovered database objects for a connection.")
model DiscoveredDatabaseObjects {
  @doc("Connection name")
  connectionName: string;

  @doc("Database engine type")
  engine: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "databaseName and serviceName are identifiers"
  @doc("List of databases discovered")
  databases: DatabaseInfo[];
}

@doc("Response for discovering database objects.")
model DatabaseDiscoveryResult {
  @doc("Request identifier for tracking the operation")
  requestId?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "connectionName is the identifier"
  @doc("Source database objects discovered")
  source: DiscoveredDatabaseObjects[];

  @doc("Target database objects discovered")
  target: DiscoveredDatabaseObjects;
}

@doc("Status response for connectivity test operation.")
model CheckConnectivityResult {
  @doc("Request identifier for tracking the operation")
  requestId?: string;

  @doc("Status properties")
  properties?: ConnectivityTestStatusProperties;
}

@doc("Properties of connectivity test status response.")
model ConnectivityTestStatusProperties {
  @doc("Operation status")
  status: OperationStatus;

  @doc("Connectivity test properties")
  testResults?: ConnectivityTestProperties;

  @doc("Error details if operation failed")
  error?: MigrationError;
}

@doc("Operation status enum.")
union OperationStatus {
  string,

  @doc("Operation is in progress")
  InProgress: "InProgress",

  @doc("Operation completed successfully")
  Succeeded: "Succeeded",

  @doc("Operation failed")
  Failed: "Failed",

  @doc("Operation was cancelled")
  Cancelled: "Cancelled",
}
