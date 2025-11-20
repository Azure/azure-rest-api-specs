import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace PurviewDataQuality;

/**
 * Defines the type of asset metadata observer used for data quality monitoring.
 * Observers monitor data assets and execute quality checks based on their configuration.
 */
@doc("Type of asset metadata observer for data quality monitoring")
union AssetMetadataObserverType {
  string,

  /** Basic observer type for standard data quality monitoring operations */
  Basic: "Basic",
}

/**
 * Parameters for data quality rule operations within a specific data asset.
 * Rules define validation logic and quality checks that can be applied to datasets.
 */
@doc("Parameters for rule operations including rule identifier and optional response data")
@parentResource(DataAsset)
@resource("rules")
model RuleParameters {
  /**
   * Unique identifier for the data quality rule within the data asset context
   */
  @doc("Unique identifier for the data quality rule")
  @key("ruleId")
  @visibility(Lifecycle.Create)
  ruleId: string;

  /**
   * Optional rule entity response containing rule configuration and metadata
   */
  @doc("Rule entity response data")
  response?: RuleEntity;
}

/**
 * Container for data quality rule entities associated with a specific data asset.
 * Encapsulates both the rule identifier and the complete rule configuration.
 */
@doc("Rule entities containing rule identifier and complete rule configuration")
@parentResource(DataAsset)
@resource("rules")
model RuleEntities {
  /**
   * Unique identifier for the data quality rule within the data asset context
   */
  @doc("Unique identifier for the data quality rule")
  @key("ruleId")
  @visibility(Lifecycle.Create)
  ruleId: string;

  /**
   * Complete rule entity containing configuration, validation logic, and metadata
   */
  @doc("Complete rule entity with configuration and metadata")
  ruleEntity: RuleEntity;
}

/**
 * Represents a business domain which serves as the top-level organizational unit for data governance.
 * Business domains group related data products and provide governance context and policies.
 */
@doc("Business domain representing a top-level organizational unit for data governance")
@resource("business-domains")
model BusinessDomain {
  /**
   * Unique identifier for the business domain used in API path parameters
   */
  @doc("Unique identifier for the business domain")
  @key
  @visibility(Lifecycle.Create)
  businessDomainId: string;
}

/**
 * Represents a data product within a business domain, containing related data assets.
 * Data products serve specific business purposes and analytical use cases.
 */
@doc("Data product containing related data assets for specific business purposes")
@parentResource(BusinessDomain)
@resource("data-products")
model DataProduct {
  /**
   * Unique identifier for the data product within its parent business domain
   */
  @doc("Unique identifier for the data product")
  @key
  @visibility(Lifecycle.Create)
  dataProductId: string;
}

/**
 * Represents an individual data asset such as a dataset, table, or data source.
 * Data assets can be monitored for quality, profiled, and have rules applied to them.
 */
@doc("Individual data asset such as dataset, table, or data source for quality monitoring")
@parentResource(DataProduct)
@resource("data-assets")
model DataAsset {
  /**
   * Unique identifier for the data asset within its parent data product
   */
  @doc("Unique identifier for the data asset")
  @key
  @visibility(Lifecycle.Create)
  dataAssetId: string;
}

/**
 * Represents a specific execution instance of a scheduled data quality operation.
 * Schedule runs track the execution status and results of automated quality checks.
 */
@doc("Execution instance of a scheduled data quality operation with status tracking")
@parentResource(BusinessDomain)
@resource("runs")
model ScheduleRun {
  /**
   * Unique identifier for the schedule run execution within the business domain
   */
  @doc("Unique identifier for the schedule run execution")
  @key
  @visibility(Lifecycle.Create)
  runId: string;
}

/**
 * Represents a data source connection within a business domain.
 * Data sources provide connectivity to external systems, databases, or storage locations.
 */
@doc("Data source connection to external systems or databases within a business domain")
@parentResource(BusinessDomain)
@resource("data-sources")
model DataSource {
  /**
   * Unique identifier for the data source within the business domain context
   */
  @doc("Unique identifier for the data source")
  @key
  @visibility(Lifecycle.Create)
  dataSourceId: string;
}

/**
 * Represents a schedule configuration within a business domain.
 * Schedules define automated execution patterns for data quality operations and scans.
 */
@doc("Schedule configuration for automated data quality operations and scans")
@parentResource(BusinessDomain)
@resource("schedule")
model Schedule {
  /**
   * Unique identifier for the schedule within the business domain context
   */
  @doc("Unique identifier for the schedule")
  @key
  @visibility(Lifecycle.Create)
  scheduleId: string;
}

/**
 * Represents a data quality scan operation within a schedule context.
 * Scans execute quality checks and validations on specified data assets.
 */
@doc("Data quality scan operation for executing quality checks on data assets")
@parentResource(Schedule)
@resource("scans")
model ScanEntity {
  /**
   * Unique identifier for the scan within the schedule context
   */
  @doc("Unique identifier for the scan")
  @key
  @visibility(Lifecycle.Create)
  scanId: string;
}

/**
 * Represents an execution instance of a data profiling operation on a data asset.
 * Profile runs collect statistical information and data characteristics for quality assessment.
 */
@doc("Execution instance of data profiling operation collecting statistical information")
@parentResource(DataAsset)
@resource("profiles")
model ProfileRun {
  /**
   * Unique identifier for the profile run execution within the data asset context
   */
  @doc("Unique identifier for the profile run execution")
  @key("profileRunId")
  @visibility(Lifecycle.Create)
  profileRunId: string;
}

/**
 * Represents a run execution at the business domain level.
 * Business domain runs coordinate multiple operations across all data products and assets.
 */
@doc("Run execution coordinating operations across business domain data products and assets")
@parentResource(BusinessDomain)
@resource("runs")
model BusinessDomainRun {
  /**
   * Unique identifier for the business domain run execution
   */
  @doc("Unique identifier for the business domain run execution")
  @key("runId")
  @visibility(Lifecycle.Create)
  runId: string;
}

/**
 * Represents a profiling rule applied to a data asset for statistical analysis.
 * Profile rules define what statistical measures and patterns to collect during profiling.
 */
@doc("Profiling rule for collecting statistical measures and data patterns")
@parentResource(DataAsset)
@resource("asset-metadata")
model ProfileRule {
  /**
   * Unique identifier for the profile rule within the data asset context
   */
  @doc("Unique identifier for the profile rule")
  @key("ruleId")
  @visibility(Lifecycle.Create)
  ruleId: string;
}

/**
 * Represents observational metadata captured during data quality monitoring.
 * Contains monitoring results, anomaly detection, and observability data for assets.
 */
@doc("Observational metadata from data quality monitoring with results and anomaly detection")
@parentResource(DataAsset)
@resource("observations")
model ObservationAssetMetadata {
  /**
   * Unique identifier for the observation metadata within the data asset context
   */
  @doc("Unique identifier for the observation metadata")
  @key("observationId")
  @visibility(Lifecycle.Create)
  observationId: string;
}

/**
 * Represents descriptive and operational metadata associated with a data asset.
 * Contains business context, ownership information, and tracking details for governance.
 */
@doc("Descriptive and operational metadata for data asset governance and discovery")
@parentResource(DataAsset)
@resource("asset-metadata")
model AssetMetadataRoute {
  /**
   * Unique identifier for the asset metadata within the data asset context
   */
  @doc("Unique identifier for the asset metadata")
  @key("metadataId")
  @visibility(Lifecycle.Create)
  metadataId: string;

  /**
   * Detailed business description providing context about the data asset's purpose and usage
   */
  @doc("Business description and context of the data asset")
  description?: string;

  /**
   * Identifier of the user or service principal who originally created this metadata entry
   */
  @doc("Creator of the metadata entry")
  createdBy?: string;

  /**
   * Timestamp of the most recent update to this metadata entry
   */
  @doc("Last update timestamp")
  lastUpdated?: utcDateTime;
}

/**
 * Defines the execution status of data quality rules and operations.
 */
@doc("Execution status for data quality rules and operations")
union Status {
  /** The rule or operation is active and currently executing */
  Active: "Active",

  /** The rule or operation is temporarily suspended */
  Suspended: "Suspended",

  /** The rule or operation has finished successfully */
  Completed: "Completed",

  /** The rule or operation encountered an error and failed */
  Failed: "Failed",

  /** The rule or operation is currently executing */
  InProgress: "InProgress",

  /** Custom status not predefined above */
  string,
}

/**
 * Type of operation being monitored.
 */
@doc("Type of operation being monitored")
union OperationKind {
  /** Operation type is unknown */
  Unknown: "Unknown",

  /** Create operation */
  Create: "Create",

  /** Update operation */
  Update: "Update",

  /** Delete operation */
  Delete: "Delete",

  /** Retrieve operation */
  Retrieve: "Retrieve",

  /** Custom operation kind not predefined above */
  string,
}

/**
 * Structured error information with codes, messages, and contextual details.
 */
@doc("Structured error information with codes, messages, and contextual details")
model ErrorDetails {
  @doc("Standardized error code")
  code?: string;

  @doc("Human-readable error message")
  message?: string;

  @doc("Additional error context as key-value pairs")
  details?: Record<string>;
}

/**
 * Status monitoring with execution state, progress tracking, and error reporting.
 */
@doc("Status monitoring with execution state, progress tracking, and error reporting")
model StatusMonitor {
  @key
  @visibility(Lifecycle.Read)
  @doc("Unique identifier of the monitored operation")
  id: string;

  @lroStatus
  @doc("Current status of the operation")
  status: LroStatus;

  @doc("Kind of operation being monitored")
  kind?: OperationKind;

  @doc("Last status update timestamp (UTC)")
  lastUpdated: utcDateTime;

  @doc("Status description message")
  statusMessage?: string;

  @doc("Completion percentage (0–100)")
  progressPercentage?: int32;

  @doc("Error details for failed operations")
  errorDetails?: ErrorDetails;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Legacy API design uses unknown type for flexible result payloads"
  @doc("Result payload for successful operations")
  result?: unknown;
}

/**
 * HTTP response wrapper for operations that return a StatusMonitor.
 * This ensures operations returning a StatusMonitor produce a 202 Accepted response.
 */
// @doc("HTTP 202 response containing a StatusMonitor body")
// model StatusMonitorResponse {
//   @doc("HTTP status code indicating the request has been accepted for processing")
//   @statusCode
//   statusCode: 202;

//   @body
//   @doc("Status monitor payload")
//   value: StatusMonitor;
// }
/**
 * Contains the hierarchical resource identifiers for data asset rule operations.
 * Provides the complete path context from business domain down to the data asset level.
 */
@doc("Hierarchical resource identifiers for data asset rule operations")
model DataAssetRuleResourceId {
  /**
   * Unique identifier of the business domain containing the data product
   */
  @doc("Business domain identifier")
  @path
  businessDomainId: string;

  /**
   * Unique identifier of the data product containing the data asset
   */
  @doc("Data product identifier")
  @path
  dataProductId: string;

  /**
   * Unique identifier of the data asset where rules are applied
   */
  @doc("Data asset identifier")
  @path
  dataAssetId: string;
}

/**
 * Represents a comprehensive data quality rule entity with validation logic and scoring.
 * Rules define validation criteria, execution parameters, and track quality scores for data assets.
 */
/**
 * Represents a comprehensive data quality rule entity with validation logic and scoring.
 * Rules define validation criteria, execution parameters, and track quality scores for data assets.
 */
@doc("Data quality rule entity with validation logic, execution parameters, and scoring")
model RuleEntity {
  /**
   * Descriptive name of the rule that identifies its purpose or validation type
   */
  @doc("Descriptive name of the rule")
  name: string;

  /**
   * Detailed explanation of what the rule validates and its business purpose
   */
  @doc("Detailed description of rule validation and business purpose")
  description?: string;

  /**
   * Classification of the rule type (e.g., CustomTruth, Completeness, Accuracy)
   */
  @doc("Rule type classification")
  type: string;

  /**
   * Current execution status of the rule (Active, Suspended, etc.)
   */
  @doc("Current execution status")
  status: string;

  /**
   * Type-specific configuration properties for rule execution and validation logic
   */
  @doc("Type-specific configuration properties")
  typeProperties?: TypeProperties;

  /**
   * Unique identifier for the rule within the system
   */
  @doc("Unique rule identifier")
  id: string;

  /**
   * Reference to the business domain where this rule is applied
   */
  @doc("Business domain reference")
  businessDomain?: Reference;

  /**
   * Reference to the data product where this rule is applied
   */
  @doc("Data product reference")
  dataProduct?: Reference;

  /**
   * Reference to the data asset where this rule is applied
   */
  @doc("Data asset reference")
  dataAsset?: Reference;

  /**
   * Quality score (0.0 to 1.0) representing how well the data passes this rule
   */
  @doc("Quality score (0.0 to 1.0)")
  score?: float64;

  /**
   * Optional business dimension or classification (e.g., Completeness, Accuracy)
   */
  @doc("Optional business dimension or classification")
  dimension?: string;

  /**
   * Timestamp when this rule was created
   */
  @doc("Timestamp when this rule was created")
  createdAt?: utcDateTime;

  /**
   * Timestamp when this rule was last modified
   */
  @doc("Timestamp when this rule was last modified")
  lastModifiedAt?: utcDateTime;

  /**
   * User identifier for the creator of the rule
   */
  @doc("User identifier for the creator of the rule")
  createdBy?: string;

  /**
   * User identifier for the last modifier of the rule
   */
  @doc("User identifier for the last modifier of the rule")
  lastModifiedBy?: string;
}

/**
 * Parameter alias for rule operations requiring hierarchical resource context.
 * Provides the complete path identifiers needed for rule management within the resource hierarchy.
 */
alias rulesParameter = {
  /**
   * Unique identifier of the business domain containing the rule context
   */
  @doc("Business domain identifier")
  businessDomainId: string;

  /**
   * Unique identifier of the data product containing the rule context
   */
  @doc("Data product identifier")
  dataProductId: string;

  /**
   * Unique identifier of the data asset where the rule is applied
   */
  @doc("Data asset identifier")
  dataAssetId: string;
};

/**
 * Contains type-specific configuration properties for data quality rules.
 * Provides flexible configuration options that vary based on the rule type being implemented.
 */
/**
 * Contains type-specific configuration properties for data quality rules.
 * Provides flexible configuration options that vary based on the rule type being implemented.
 */
/**
 * Contains type-specific configuration properties for data quality rules.
 * Supports both column-based and expression-based configurations.
 */
@doc("Type-specific configuration properties for data quality rules.")
model TypeProperties {
  /**
   * Column specification when the rule applies to a single column.
   */
  @doc("Column specification for column-specific rules.")
  column?: Column;

  /**
   * List of columns for multi-column or relational rules (e.g., Duplicate, CustomTruth).
   */
  @doc("List of columns for multi-column or relational rules (e.g., Duplicate, CustomTruth).")
  columns?: Column[];

  /**
   * Regex or pattern-based validation logic for format rules.
   */
  @doc("Regex or pattern-based validation logic for format rules.")
  pattern?: string;

  /**
   * Main logical condition or expression defining validation criteria.
   * Example: {City} != 'Berlin'
   */
  @doc("Main logical condition or expression defining validation criteria.")
  condition?: string;

  /**
   * Optional filter condition to limit rows that are validated by this rule.
   * Example: ID > 1
   */
  @doc("Optional filter condition to limit rows that are validated by this rule.")
  filterCriteria?: string;

  /**
   * Optional condition defining when a field or column is considered empty.
   * Example: REVENUE == 0.0
   */
  @doc("Optional condition defining when a field or column is considered empty.")
  emptyCriteria?: string;
}
/**
 * Represents a column definition within a dataset for rule applications.
 * Used to specify which columns are subject to validation or quality checks.
 */
@doc("Column definition for dataset validation and quality checks")
model Column {
  /**
   * Data type or classification of the column (e.g., string, integer, date)
   */
  @doc("Column data type or classification")
  type?: string;

  /**
   * Column name or identifier within the dataset schema
   */
  @doc("Column name or identifier")
  value?: string;
}

/**
 * Reference to another entity within the data governance hierarchy.
 * Used to establish relationships between business domains, data products, and data assets.
 */
@doc("Reference to entities in the data governance hierarchy for relationship establishment")
model Reference {
  /**
   * Type classification of the referenced entity (BusinessDomainReference, DataProductReference, DataAssetReference)
   */
  @doc("Type classification of the referenced entity")
  type?: string;

  /**
   * Unique identifier of the entity being referenced
   */
  @doc("Unique identifier of the referenced entity")
  referenceId?: string;
}

/**
 * HTTP response model for data quality rule entity operations.
 * Contains the complete rule definition with execution status and quality scoring.
 */
@doc("HTTP response containing complete data quality rule information")
model RuleEntityResponse {
  /**
   * HTTP status code indicating successful rule creation (201 Created)
   */
  @doc("HTTP status code for rule creation")
  @statusCode
  statusCode: 201;

  /**
   * Complete rule entity containing configuration, validation logic, and metadata
   */
  @doc("Complete rule entity with configuration and metadata")
  ruleEntity: RuleEntity;
}

/**
 * Individual rule entity within bulk operation responses.
 * Contains complete rule information without HTTP status codes for collection responses.
 */
@doc("Individual rule entity for bulk operations")
model RuleEntityBulkResponse {
  /**
   * Human-readable name identifying the data quality rule
   */
  @doc("Descriptive name of the data quality rule")
  name: string;

  /**
   * Detailed explanation of the rule's validation logic and business purpose
   */
  @doc("Detailed description of rule validation and purpose")
  description?: string;

  /**
   * Classification of the rule type (e.g., completeness, accuracy, consistency)
   */
  @doc("Classification of the data quality rule type")
  type: string;

  /**
   * Current execution status of the rule (active, inactive, error)
   */
  @doc("Current execution status of the rule")
  status: string;

  /**
   * Type-specific configuration parameters and validation settings
   */
  @doc("Type-specific configuration for rule validation")
  typeProperties?: TypeProperties;

  /**
   * Unique system identifier for the rule entity
   */
  @doc("Unique system identifier for the rule")
  id: string;

  /**
   * Reference to the business domain where this rule applies
   */
  @doc("Reference to the associated business domain")
  businessDomain?: Reference;

  /**
   * Reference to the data product where this rule applies
   */
  @doc("Reference to the associated data product")
  dataProduct?: Reference;

  /**
   * Reference to the specific data asset where this rule is executed
   */
  @doc("Reference to the target data asset")
  dataAsset?: Reference;

  /**
   * Current quality score calculated by this rule (0.0 to 100.0)
   */
  @doc("Current quality score from rule execution")
  score?: float64;
}

/**
 * Paginated HTTP response containing a collection of data quality rule entities.
 * Used for list operations returning multiple rules with their complete configurations.
 */
@doc("Paginated response for rule entity list operations")
model RuleEntityListResponse {
  /**
   * HTTP status code indicating successful rule retrieval (201 Created)
   */
  @doc("HTTP status code for successful operation")
  @statusCode
  statusCode: 201;

  /**
   * Collection of rule entities with their complete configurations and current status
   */
  @doc("Collection of rule entities in the response")
  value: RuleEntityBulkResponse[];
}

/**
 * Request model for creating multiple data quality rules in bulk for a specific data asset.
 * Contains an array of rule entities to be created with their complete configurations.
 */
@doc("Request model for bulk rule creation operations")
model BulkRulesRequest {
  /**
   * Array of rule entities to be created in the bulk operation
   */
  @doc("Array of rule entities for bulk creation")
  rules: RuleEntity[];
}

/**
 * Response model for bulk rule creation operations.
 * Returns the created rules with their assigned identifiers and current status.
 */
@doc("Response model for bulk rule creation operations")
model BulkRulesResponse {
  /**
   * Array of successfully created rule entities with their assigned identifiers
   */
  @doc("Array of created rule entities")
  rules: RuleEntity[];
}

/**
 * Response containing array of created rule entities
 */
@doc("Bulk rules creation response")
model CreateBulkRulesResponse {
  /**
   * Array of created rule entities with complete configuration and metadata
   */
  @doc("Array of created rule entities")
  value: RuleEntity[];
}

/**
 * Represents a storage or file location where data assets are physically stored.
 * Supports various storage types including Azure Data Lake, blob storage, and file systems.
 */
@doc("Physical storage location for data assets across different storage types")
model Location {
  /**
   * Storage type identifier (e.g., 'AdlsGen2FileLocation', 'BlobStorageLocation', 'FileSystemLocation')
   */
  @doc("Storage type classification")
  type: string;

  /**
   * Storage-specific configuration properties including paths, containers, and access details
   */
  @doc("Storage-specific configuration properties")
  typeProperties: LocationTypeProperties;
}

/**
 * Storage-specific configuration properties that vary by location type.
 * Contains connection details, paths, and access parameters for different storage systems.
 */
@doc("Storage-specific configuration properties for different location types")
model LocationTypeProperties {
  /**
   * Name of the file system, container, or database where data is stored
   */
  @doc("File system or container name")
  fileSystem?: string;

  /**
   * Hierarchical path to the specific folder, table, or data object within the storage
   */
  @doc("Hierarchical path within the storage location")
  folderPath?: string;

  /**
   * Storage account name or endpoint identifier for accessing the location
   */
  @doc("Storage account name or endpoint identifier")
  accountName?: string;

  /**
   * Geographic region or environment where the storage is located
   */
  @doc("Geographic region or environment location")
  region?: string;
}

/**
 * Unified metadata observer that monitors and tracks data assets across different storage platforms.
 * Supports multiple data source types including Lakehouse, Snowflake, SQL Server, and Oracle systems.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property name"
@doc("Unified metadata observer for monitoring data assets across platforms")
model AssetMetadata {
  /**
   * Unique system identifier for the metadata observer instance
   */
  @doc("Unique identifier of the asset metadata observer")
  id: string;

  /**
   * Human-readable display name for the metadata observer
   */
  @doc("Display name of the asset metadata observer")
  name?: string;

  /**
   * Reference to the business domain that governs this data asset
   */
  @doc("Reference to the associated business domain")
  businessDomain?: Reference;

  /**
   * Reference to the data product that contains this data asset
   */
  @doc("Reference to the associated data product")
  dataProduct?: Reference;

  /**
   * Reference to the specific data asset being observed
   */
  @doc("Reference to the associated data asset")
  dataAsset?: Reference;

  /**
   * UTC timestamp when the metadata observer was initially created
   */
  @doc("Creation timestamp (UTC)")
  createdAt?: utcDateTime;

  /**
   * Identity of the user who created this metadata observer
   */
  @doc("Identity of the creating user")
  createdBy?: string;

  /**
   * UTC timestamp when the metadata observer was last updated
   */
  @doc("Last modification timestamp (UTC)")
  lastModifiedAt?: utcDateTime;

  /**
   * Identity of the user who last modified this metadata observer
   */
  @doc("Identity of the last modifying user")
  lastModifiedBy?: string;

  /**
   * Soft deletion flag indicating if the observer has been logically deleted
   */
  @doc("Soft deletion flag")
  isDeleted?: boolean;

  /**
   * Entity tag for optimistic concurrency control and change detection
   */
  @doc("Entity tag for concurrency control")
  ETag?: string;

  /**
   * Data source type classification (Lakehouse, Snowflake, SQLServer, Oracle)
   */
  @doc("Data source type classification")
  type: string;

  /**
   * Common metadata properties applicable to all data asset types
   */
  @doc("Common metadata properties across all asset types")
  typeProperties?: AssetMetadataCommonProperties;

  /**
   * Physical storage locations for Lakehouse and file-based data assets
   */
  @doc("Physical storage locations for file-based assets")
  location?: Location[];

  /**
   * Data format specification for structured assets (CSV, Parquet, JSON, etc.)
   */
  @doc("Data format specification for structured assets")
  format?: string;

  /**
   * Database schema name for SQL-based data assets (Snowflake, SQL Server, Oracle)
   */
  @doc("Database schema name for SQL-based assets")
  schemaName?: string;

  /**
   * Table name within the database schema for SQL-based data assets
   */
  @doc("Table name for SQL-based data assets")
  tableName?: string;

  /**
   * Host server name or endpoint for on-premises database connections (Oracle, SQL Server)
   */
  @doc("Host server name for on-premises database connections")
  hostName?: string;

  @doc("Connection Dataset name for Google Big Quey type of data asset")
  testConnectionDatasetName?: string;

  @doc("Connection Schema name for Google Big Query type of data asset")
  testConnectionSchemaName?: string;

  @doc("Project ID for Google Big Query type of data asset")
  projectId?: string;

  @doc("Flag indicating if the asset is a Data Quality asset")
  isDQAsset?: boolean;
}

/**
 * Request model for updating asset metadata observer properties.
 * Contains optional fields that can be updated for an existing metadata observer.
 */
@doc("Request model for asset metadata observer updates")
model AssetMetadataObserverUpdateRequest {
  /**
   * Updated human-readable display name for the metadata observer
   */
  @doc("Updated display name of the asset metadata observer")
  name?: string;

  /**
   * Updated data source type classification (Lakehouse, Snowflake, SQLServer, Oracle)
   */
  @doc("Updated data source type classification")
  type?: string;

  /**
   * Updated common metadata properties applicable to all data asset types
   */
  @doc("Updated common metadata properties across all asset types")
  typeProperties?: AssetMetadataCommonProperties;

  /**
   * Updated physical storage locations for Lakehouse and file-based data assets
   */
  @doc("Updated physical storage locations for file-based assets")
  location?: Location[];

  /**
   * Updated data format specification for structured assets (CSV, Parquet, JSON, etc.)
   */
  @doc("Updated data format specification for structured assets")
  format?: string;

  /**
   * Updated database schema name for SQL-based data assets (Snowflake, SQL Server, Oracle)
   */
  @doc("Updated database schema name for SQL-based assets")
  schemaName?: string;

  /**
   * Updated table name within the database schema for SQL-based data assets
   */
  @doc("Updated table name for SQL-based data assets")
  tableName?: string;

  /**
   * Updated host server name or endpoint for on-premises database connections (Oracle, SQL Server)
   */
  @doc("Updated host server name for on-premises database connections")
  hostName?: string;
}

/**
 * Shared metadata properties that apply to all data asset types regardless of their source platform.
 * Contains common configuration and structural information for data governance and quality monitoring.
 */
@doc("Shared metadata properties across all data asset types")
model AssetMetadataCommonProperties {
  /**
   * Collection of input dataset definitions and schemas associated with this asset
   */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Legacy API design uses unknown array type"
  @doc("Input dataset definitions and schemas")
  inputDatasets?: unknown[];

  /**
   * Projection configuration for data transformation and mapping operations
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Legacy API design uses unknown type for flexible projection values"
  @encodedName("application/json", "projection")
  @doc("Data projection and mapping configuration")
  projectionValue?: unknown;
}

/**
 * HTTP response model for schedule creation and update operations.
 * Contains complete schedule configuration including timing, scope, and execution parameters.
 */
@doc("HTTP response for schedule operations with complete configuration")
model ScheduleEntityResponse {
  /**
   * HTTP status code indicating successful schedule creation or update (201 Created)
   */
  @doc("HTTP status code for successful operation")
  @statusCode
  statusCode: 200;

  /**
   * Human-readable name identifying the schedule
   */
  @doc("Human-readable schedule name")
  name?: string;

  /**
   * Unique system identifier for the schedule entity
   */
  @doc("Unique schedule identifier")
  id?: string;

  /**
   * Detailed description of the schedule's purpose and execution logic
   */
  @doc("Detailed schedule description and purpose")
  description?: string;

  /**
   * Key-value metadata annotations for schedule categorization and tagging
   */
  @doc("Metadata annotations for categorization")
  annotations?: Record<string>;

  /**
   * Reference to the business domain that governs this schedule
   */
  @doc("Reference to the governing business domain")
  businessDomain?: Reference;

  /**
   * Execution scope defining which data products and assets are included in scheduled runs
   */
  @doc("Execution scope for data products and assets")
  scope?: {
    items: Array<{
      dataProduct: {
        referenceId: string;
        type: string;
      };
      dataAsset: {
        referenceId: string;
        type: string;
      };
    }>;
  };

  /**
   * Trigger configuration defining when and how often the schedule executes
   */
  @doc("Trigger configuration for schedule timing")
  trigger?: {
    type: string;
    typeProperties: {
      timezone?: string;
      isScheduled?: boolean;
      triggerTime?: utcDateTime;
    };
  };

  /**
   * UTC timestamp when the schedule was last modified
   */
  @doc("Last modification timestamp (UTC)")
  lastModifiedAt?: utcDateTime;

  /**
   * Identity of the user who last modified the schedule
   */
  @doc("Identity of the last modifying user")
  lastModifiedBy?: string;

  /**
   * UTC timestamp when the schedule was initially created
   */
  @doc("Creation timestamp (UTC)")
  createdAt?: utcDateTime;

  /**
   * Identity of the user who created the schedule
   */
  @doc("Identity of the creating user")
  createdBy?: string;

  /**
   * Runtime execution parameters and configuration data for schedule runs
   */
  @doc("Runtime execution parameters and configuration")
  executionData?: Record<string>;
}

/**
 * Schedule entity that defines automated data quality scanning and validation jobs.
 * Manages execution timing, scope definition, and tracks changes within a business domain context.
 */
@doc("Schedule entity for automated data quality scanning and validation")
@parentResource(BusinessDomain)
@resource("schedules")
model ScheduleEntity {
  /**
   * Unique system identifier for the schedule entity
   */
  @key("scheduleId")
  @visibility(Lifecycle.Read)
  @doc("Unique identifier of the schedule")
  id: string;

  /**
   * Human-readable display name for the schedule
   */
  @doc("Human-readable schedule display name")
  name?: string;

  /**
   * Detailed description explaining the schedule's purpose and execution strategy
   */
  @doc("Detailed description of schedule purpose and strategy")
  description?: string;

  /**
   * Trigger configuration defining execution timing and scheduling behavior
   */
  @doc("Trigger configuration for execution timing and scheduling")
  trigger?: {
    /**
     * Trigger type classification (Manual, TimeBased, EventDriven)
     */
    @doc("Trigger type classification")
    type: string;

    /**
     * Type-specific configuration properties for trigger behavior
     */
    @doc("Type-specific trigger configuration properties")
    typeProperties: {
      /**
       * Time zone identifier for schedule evaluation (e.g., 'UTC', 'America/New_York')
       */
      @doc("Time zone identifier for schedule evaluation")
      timezone?: string;

      /**
       * Flag indicating if the schedule is active for automatic execution
       */
      @doc("Flag for automatic execution activation")
      isScheduled?: boolean;

      /**
       * Next scheduled execution time in UTC format
       */
      @doc("Next scheduled execution time (UTC)")
      triggerTime?: utcDateTime;
    };
  };

  /**
   * Execution scope defining the data products and assets targeted for quality scanning
   */
  @doc("Execution scope for data quality scanning")
  scope?: {
    /**
     * Collection of data product and asset pairs that define the scanning boundary
     */
    @doc("Collection of target data products and assets")
    items: Array<{
      /**
       * Reference to the data product containing the target assets
       */
      @doc("Data product reference within scope")
      dataProduct: {
        /**
         * Unique identifier of the referenced data product
         */
        @doc("Data product unique identifier")
        referenceId: string;

        /**
         * Reference type classification for data product
         */
        @doc("Data product reference type")
        type: string;
      };

      /**
       * Reference to the specific data asset to be scanned
       */
      @doc("Data asset reference within scope")
      dataAsset: {
        /**
         * Unique identifier of the referenced data asset
         */
        @doc("Data asset unique identifier")
        referenceId: string;

        /**
         * Reference type classification for data asset
         */
        @doc("Data asset reference type")
        type: string;
      };
    }>;
  };

  /**
   * Reference to the parent business domain that governs this schedule
   */
  @doc("Reference to the governing business domain")
  businessDomain?: {
    /**
     * Reference type classification for business domain
     */
    @doc("Business domain reference type")
    type: string;

    /**
     * Unique identifier of the associated business domain
     */
    @doc("Business domain unique identifier")
    referenceId: string;
  };

  /**
   * UTC timestamp when the schedule was initially created
   */
  @doc("Creation timestamp (UTC)")
  createdAt?: utcDateTime;

  /**
   * UTC timestamp when the schedule was last modified
   */
  @doc("Last modification timestamp (UTC)")
  lastModifiedAt?: utcDateTime;

  /**
   * Identity of the user who created this schedule
   */
  @doc("Identity of the creating user")
  createdBy?: string;

  /**
   * Identity of the user who last modified this schedule
   */
  @doc("Identity of the last modifying user")
  lastModifiedBy?: string;

  /**
   * Entity tag for optimistic concurrency control and change detection
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property name"
  @doc("Entity tag for concurrency control")
  ETag?: string;
}

@doc("Request body model for creating or updating schedule entities")
model ScheduleEntityRequestResponse {
  @doc("Unique identifier of the schedule")
  id?: string;

  /**
   * Human-readable display name for the schedule
   */
  @doc("Human-readable schedule display name")
  name?: string;

  /**
   * Detailed description explaining the schedule's purpose and execution strategy
   */
  @doc("Detailed description of schedule purpose and strategy")
  description?: string;

  /**
   * Trigger configuration defining execution timing and scheduling behavior
   */
  @doc("Trigger configuration for execution timing and scheduling")
  trigger?: {
    /**
     * Trigger type classification (Manual, TimeBased, EventDriven)
     */
    @doc("Trigger type classification")
    type: string;

    /**
     * Type-specific configuration properties for trigger behavior
     */
    @doc("Type-specific trigger configuration properties")
    typeProperties: {
      /**
       * Time zone identifier for schedule evaluation (e.g., 'UTC', 'America/New_York')
       */
      @doc("Time zone identifier for schedule evaluation")
      timezone?: string;

      /**
       * Flag indicating if the schedule is active for automatic execution
       */
      @doc("Flag for automatic execution activation")
      isScheduled?: boolean;

      /**
       * Next scheduled execution time in UTC format
       */
      @doc("Next scheduled execution time (UTC)")
      triggerTime?: utcDateTime;
    };
  };

  /**
   * Execution scope defining the data products and assets targeted for quality scanning
   */
  @doc("Execution scope for data quality scanning")
  scope?: {
    /**
     * Collection of data product and asset pairs that define the scanning boundary
     */
    @doc("Collection of target data products and assets")
    items: Array<{
      /**
       * Reference to the data product containing the target assets
       */
      @doc("Data product reference within scope")
      dataProduct: {
        /**
         * Unique identifier of the referenced data product
         */
        @doc("Data product unique identifier")
        referenceId: string;

        /**
         * Reference type classification for data product
         */
        @doc("Data product reference type")
        type: string;
      };

      /**
       * Reference to the specific data asset to be scanned
       */
      @doc("Data asset reference within scope")
      dataAsset: {
        /**
         * Unique identifier of the referenced data asset
         */
        @doc("Data asset unique identifier")
        referenceId: string;

        /**
         * Reference type classification for data asset
         */
        @doc("Data asset reference type")
        type: string;
      };
    }>;
  };

  /**
   * Reference to the parent business domain that governs this schedule
   */
  @doc("Reference to the governing business domain")
  businessDomain?: {
    /**
     * Reference type classification for business domain
     */
    @doc("Business domain reference type")
    type: string;

    /**
     * Unique identifier of the associated business domain
     */
    @doc("Business domain unique identifier")
    referenceId: string;
  };

  /**
   * UTC timestamp when the schedule was initially created
   */
  @doc("Creation timestamp (UTC)")
  createdAt?: utcDateTime;

  /**
   * UTC timestamp when the schedule was last modified
   */
  @doc("Last modification timestamp (UTC)")
  lastModifiedAt?: utcDateTime;

  /**
   * Identity of the user who created this schedule
   */
  @doc("Identity of the creating user")
  createdBy?: string;

  /**
   * Identity of the user who last modified this schedule
   */
  @doc("Identity of the last modifying user")
  lastModifiedBy?: string;

  /**
   * Entity tag for optimistic concurrency control and change detection
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property name"
  @doc("Entity tag for concurrency control")
  ETag?: string;
}

/**
 * Path parameters for accessing schedules within business domain hierarchical resources.
 * Used in REST API operations to identify specific schedule entities.
 */
@doc("Path parameters for business domain schedule resource identification")
model BusinessDomainScheduleParameters {
  /**
   * Unique identifier of the parent business domain containing the schedule
   */
  @doc("Parent business domain identifier")
  @path
  businessDomainId: string;

  /**
   * Unique identifier of the schedule within the business domain scope
   */
  @doc("Schedule identifier within domain")
  @path
  scheduleId: string;
}

/**
 * Defines the execution scope for data quality scans and validation operations.
 * Specifies which data entities or hierarchical levels are included in scan execution.
 */
@doc("Execution scope definition for data quality scans")
model ScanScope {
  /**
   * Scope type classification (BusinessDomainScope, DataProductScope, DataAssetScope)
   */
  @doc("Scope type classification")
  type?: string;

  /**
   * Unique identifier of the entity that defines the scan boundary
   */
  @doc("Scope boundary entity identifier")
  referenceId?: string;
}

/**
 * Trigger configuration for automated scan execution.
 * Defines timing mechanisms including manual triggers and scheduled cron-based execution.
 */
@doc("Trigger configuration for automated scan execution")
model Trigger {
  /**
   * Trigger mechanism type (Manual, Scheduled, EventDriven)
   */
  @doc("Trigger mechanism type")
  type?: string;

  /**
   * Cron expression defining scheduled execution pattern (e.g., '0 9 * * MON-FRI')
   */
  @doc("Cron expression for scheduled execution")
  cron?: string;
}

/**
 * Data transfer object containing basic scan configuration information.
 * Used for lightweight scan operations and API transfers.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@doc("Data transfer object for scan configuration")
model ScanDTO {
  /**
   * Classification of scan type (FullScan, IncrementalScan, TargetedScan)
   */
  @doc("Scan type classification")
  scanType?: string;
}

/**
 * Comprehensive monitoring and execution metrics for scheduled data quality scans.
 * Tracks success rates, execution timing, and provides audit trail for scheduled operations.
 */
@doc("Monitoring metrics and execution information for scheduled scans")
model ScheduleScanMonitoringEntity {
  /**
   * Count of successfully completed scan executions
   */
  @doc("Number of successful scan executions")
  succeeded?: int64;

  /**
   * Count of failed scan executions with error conditions
   */
  @doc("Number of failed scan executions")
  failed?: int64;

  /**
   * Count of skipped scan executions due to conditions or policies
   */
  @doc("Number of skipped scan executions")
  skipped?: int64;

  /**
   * Current operational status of the schedule (Active, Paused, Error)
   */
  @doc("Current schedule operational status")
  scheduleStatus?: string;

  /**
   * Human-readable name of the associated schedule
   */
  @doc("Associated schedule name")
  scheduleName?: string;

  /**
   * Unique identifier of the associated schedule entity
   */
  @doc("Associated schedule identifier")
  scheduleId?: string;

  /**
   * Unique identifier of the specific scan execution
   */
  @doc("Specific scan execution identifier")
  scanId?: string;

  /**
   * UTC timestamp when the scan execution began
   */
  @doc("Scan execution start time (UTC)")
  startTime?: utcDateTime;

  /**
   * UTC timestamp when the scan execution completed
   */
  @doc("Scan execution end time (UTC)")
  endTime?: utcDateTime;

  /**
   * Account identifier under which the scan was executed
   */
  @doc("Executing account identifier")
  accountId?: string;

  /**
   * Business domain identifier where the scan was performed
   */
  @doc("Business domain identifier")
  businessDomainId?: string;

  /**
   * Total count of individual jobs or tasks within the scan execution
   */
  @doc("Total job count within scan execution")
  totalJobCount?: int64;

  /**
   * Current execution status of the scan (Running, Completed, Failed, Cancelled)
   */
  @doc("Current scan execution status")
  status?: string;

  /**
   * Schedule run type classification (Automatic, Manual, OnDemand)
   */
  @doc("Schedule run type classification")
  scheduleRunType?: string;

  /**
   * Scan type classification indicating the scanning strategy used
   */
  @doc("Scan type classification")
  scanType?: string;

  /**
   * Identity of the user who initiated the scan execution
   */
  @doc("Identity of the scan initiating user")
  startedBy?: string;

  /**
   * Identity of the user who cancelled the scan execution
   */
  @doc("Identity of the scan cancelling user")
  cancelledBy?: string;

  /**
   * UTC timestamp when a cancellation request was submitted
   */
  @doc("Cancellation request timestamp (UTC)")
  cancelRequestTime?: utcDateTime;

  /**
   * Storage partition key for data organization and query optimization
   */
  @doc("Storage partition key for data organization")
  partitionKey?: string;

  /**
   * Storage row key for unique record identification within partition
   */
  @doc("Storage row key for unique record identification")
  rowKey?: string;

  /**
   * Record timestamp for temporal tracking and versioning
   */
  @doc("Record timestamp for temporal tracking")
  timestamp?: utcDateTime;

  /**
   * Entity tag for optimistic concurrency control and change detection
   */
  @doc("Entity tag for concurrency control")
  eTag?: string;
}

/**
 * Comprehensive metadata tracking entity for data quality and processing jobs.
 * Manages execution lifecycle, performance metrics, and audit information for job operations.
 */
@doc("Comprehensive metadata for data quality job tracking and lifecycle management")
model JobMetadataEntity {
  /**
   * Unique execution run identifier linking this job to its parent operation
   */
  @doc("Unique execution run identifier")
  runId?: string;

  /**
   * Identifier of the data product containing the data assets being processed
   */
  @doc("Data product identifier containing target assets")
  dataProductId?: string;

  /**
   * Flag indicating whether redundancy validation checks are enabled for this job
   */
  @doc("Flag for redundancy validation checks")
  redundancyCheck?: boolean;

  /**
   * Account identifier under which this job is executing
   */
  @doc("Executing account identifier")
  accountId?: string;

  /**
   * Business domain identifier governing this job execution
   */
  @doc("Governing business domain identifier")
  businessDomainId?: string;

  /**
   * UTC timestamp when the job was submitted to the execution queue
   */
  @doc("Job submission timestamp (UTC)")
  submissionTime?: utcDateTime;

  /**
   * UTC timestamp when job execution actually began
   */
  @doc("Job execution start timestamp (UTC)")
  startTime?: utcDateTime;

  /**
   * UTC timestamp when job execution completed or failed
   */
  @doc("Job execution end timestamp (UTC)")
  endTime?: utcDateTime;

  /**
   * UTC timestamp when a cancellation request was submitted for this job
   */
  @doc("Job cancellation request timestamp (UTC)")
  cancelRequestTime?: utcDateTime;

  /**
   * Current execution status of the job (Queued, Running, Completed, Failed, Cancelled)
   */
  @doc("Current job execution status")
  status?: string;

  /**
   * Platform-specific job identifier for tracking in external execution systems
   */
  @doc("Platform-specific external job identifier")
  pfsJobId?: string;

  /**
   * Descriptive message providing job execution details, status updates, or error information
   */
  @doc("Job execution message with status or error details")
  message?: string;

  /**
   * Total execution duration in milliseconds for performance tracking and optimization
   */
  @doc("Job execution duration in milliseconds")
  duration?: int64;

  /**
   * Identity of the user who initiated the job execution
   */
  @doc("Identity of the job initiating user")
  startedBy?: string;

  /**
   * Identity of the user who cancelled the job execution
   */
  @doc("Identity of the job cancelling user")
  cancelledBy?: string;

  /**
   * Job type classification (DataQualityScan, ProfileAnalysis, MetadataExtraction)
   */
  @doc("Job type classification")
  jobType?: string;

  /**
   * Geographic region where the job was executed for locality tracking
   */
  @doc("Job execution geographic region")
  jobExecutionRegion?: string;

  /**
   * Unique identifier of the primary data asset being processed by this job
   */
  @doc("Primary data asset identifier")
  dataAssetId?: string;

  /**
   * Human-readable name of the primary data asset being processed
   */
  @doc("Primary data asset name")
  dataAssetName?: string;

  /**
   * Identifier of the schedule that triggered this job (if scheduled execution)
   */
  @doc("Triggering schedule identifier")
  scheduleId?: string;

  /**
   * Human-readable name of the schedule that triggered this job
   */
  @doc("Triggering schedule name")
  scheduleName?: string;

  /**
   * Fully qualified path to the data resource or location being processed
   */
  @doc("Fully qualified data resource path")
  qualifiedPath?: string;

  /**
   * Identifier of the scan operation associated with this job execution
   */
  @doc("Associated scan operation identifier")
  scanId?: string;

  /**
   * Schedule scan type classification for scheduled job executions
   */
  @doc("Schedule scan type classification")
  scheduleScanType?: string;

  /**
   * Spark compute SKU used for job execution billing and resource allocation
   */
  @doc("Spark compute SKU for billing and resource allocation")
  jobBillingSparkSku?: string;

  /**
   * Data source type classification (ADLSGen2, Blob, SQL, Snowflake, etc.)
   */
  @doc("Data source type classification")
  dataSourceType?: string;

  /**
   * Primary data source identifier for the main data connection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
  @doc("Primary data source identifier")
  primaryDataSourceID?: string;

  /**
   * Additional Purview-specific details and metadata for governance tracking
   */
  @doc("Additional Purview-specific governance details")
  puDetail?: string;
}

/**
 * Historical record entity tracking completed job executions and their outcomes.
 * Maintains execution history for audit, compliance, and performance analysis purposes.
 */
@doc("Historical execution record for completed data quality jobs")
model JobHistoryEntity {
  /**
   * Unique identifier of the data asset that was processed by the job
   */
  @doc("Processed data asset identifier")
  @minLength(1)
  dataAssetId: string;

  /**
   * Unique execution run identifier linking this history record to the job
   */
  @doc("Job execution run identifier")
  @minLength(1)
  runId: string;

  /**
   * Identifier of the data product containing the processed data asset
   */
  @doc("Parent data product identifier")
  @minLength(1)
  dataProductId: string;

  /**
   * Identifier of the business domain governing the job execution
   */
  @doc("Governing business domain identifier")
  @minLength(1)
  businessDomainId: string;

  /**
   * UTC timestamp when job execution actually began
   */
  @doc("Job execution start timestamp (UTC)")
  startTime?: utcDateTime;

  /**
   * UTC timestamp when job execution completed or terminated
   */
  @doc("Job execution end timestamp (UTC)")
  endTime?: utcDateTime;

  /**
   * UTC timestamp when the job was initially submitted for execution
   */
  @doc("Job submission timestamp (UTC)")
  submissionTime?: utcDateTime;

  /**
   * Final execution status of the completed job (Completed, Failed, Cancelled)
   */
  @doc("Final job execution status")
  status?: string;

  /**
   * Job type classification for categorizing different execution patterns
   */
  @doc("Job type classification")
  jobType?: string;

  /**
   * Account identifier under which the job was executed
   */
  @doc("Job execution account identifier")
  accountId?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property"
  @doc("Flag indicating if the asset is a Data Quality asset")
  isDQAsset?: boolean;

  @doc("Fully qualified data resource path")
  qualifiedPath?: string;

  @doc("Associated scan operation identifier")
  scanId?: string;

  @doc("Which data product the scan belongs to")
  dataProductName?: string;

  @doc("Which dataasset the scan belongs to")
  dataAssetName?: string;

  @doc("Trigger type classification")
  triggerType?: string;

  @doc("Triggering schedule identifier")
  scheduleId?: string;

  @doc("Scheduled triggered name")
  scheduleName?: string;
}

/**
 * Job execution configuration data transfer object containing runtime parameters and mappings.
 * Defines how jobs should execute including validation settings and data source relationships.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@doc("Job execution configuration with runtime parameters and data mappings")
model JobConfigDTO {
  /**
   * Flag enabling redundancy validation checks to prevent duplicate processing
   */
  @doc("Flag for redundancy validation checks")
  redundancyCheck?: boolean;

  /**
   * Collection of mappings linking logical datasets to their physical data sources
   */
  @doc("Dataset to data source mapping configurations")
  datasetToDatasourceMappings?: DatasetToDatasourceMapping[];
}

/**
 * Status tracking model for long-running rule creation operations.
 * Provides real-time status updates during asynchronous rule deployment and configuration.
 */
@doc("Long-running operation status for rule creation processes")
model RuleCreationStatus {
  /**
   * Current execution state of the long-running rule creation operation
   */
  @doc("Current state of the rule creation operation")
  @lroStatus
  status: LroStatus;
}

/**
 * Standardized status values for long-running operations with extensibility.
 * Covers the complete lifecycle of asynchronous operations from initiation to completion.
 */
@doc("Long-running operation status enumeration with extensibility")
union LroStatus {
  /**
   * Operation is currently executing and has not yet completed
   */
  @doc("Operation in progress")
  InProgress: "InProgress",

  /**
   * Operation completed successfully with expected results
   */
  @doc("Operation completed successfully")
  Succeeded: "Succeeded",

  /**
   * Operation terminated with errors or unexpected conditions
   */
  @doc("Operation failed with errors")
  Failed: "Failed",

  string,
}

/**
 * Mapping configuration that links logical dataset names to their physical data source connections.
 * Enables abstraction layer for job execution across different storage systems and environments.
 */
@doc("Dataset to data source mapping for job execution abstraction")
model DatasetToDatasourceMapping {
  /**
   * Logical alias name used to reference the dataset within job configurations
   */
  @doc("Logical dataset alias name")
  datasetAliasName?: string;

  /**
   * Unique identifier of the physical data source where the dataset resides
   */
  @doc("Physical data source identifier")
  datasourceId?: string;
}

/**
 * HTTP response model for scan operations with comprehensive status tracking and monitoring.
 * Provides scan execution details and real-time status updates for long-running scan processes.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@doc("HTTP response for scan operations with status tracking and monitoring")
model ScanDTOResponse {
  /**
   * Unique identifier of the initiated scan operation for tracking and reference
   */
  @doc("Unique scan operation identifier")
  scanId?: string;

  /**
   * Long-running operation status indicating current execution state
   */
  @doc("Long-running operation execution status")
  @lroStatus
  status: LroStatus;

  /**
   * Detailed monitoring information providing real-time scan execution metrics
   */
  @doc("Real-time scan execution monitoring information")
  statusMonitor?: StatusMonitor;
}

/**
 * Empty parameter model for operations that require no input parameters.
 * Used for API operations that need explicit parameter structure without content.
 */
@doc("Empty parameter model for operations without input parameters")
model EmptyParams {}

/**
 * HTTP response model for asset metadata observer operations.
 * Contains complete observer configuration with hierarchical references and audit information.
 */
@doc("HTTP response for asset metadata observer operations")
model AssetMetadataObserverResponse {
  /**
   * HTTP status code indicating successful observer creation or update (201 Created)
   */
  @doc("HTTP status code for successful operation")
  @statusCode
  statusCode: 201;

  /**
   * Unique system identifier for the metadata observer instance
   */
  @doc("Unique metadata observer identifier")
  id?: string;

  /**
   * Human-readable display name for the metadata observer
   */
  @doc("Human-readable observer display name")
  name?: string;

  /**
   * Reference to the specific data asset being observed for metadata changes
   */
  @doc("Reference to the observed data asset")
  dataAsset?: Reference;

  /**
   * UTC timestamp when the metadata observer was initially created
   */
  @doc("Observer creation timestamp (UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Identity of the user who created this metadata observer
   */
  @doc("Identity of the creating user")
  createdBy?: string;

  /**
   * UTC timestamp when the metadata observer was last modified
   */
  @doc("Observer last modification timestamp (UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;

  /**
   * Identity of the user who last modified this metadata observer
   */
  @doc("Identity of the last modifying user")
  lastModifiedBy?: string;

  /**
   * Runtime execution parameters and configuration data for observer operations
   */
  @doc("Runtime execution parameters and configuration")
  executionData?: Record<string>;

  /**
   * Soft deletion flag indicating if the observer has been logically deleted
   */
  @doc("Soft deletion flag")
  isDeleted?: boolean;

  /**
   * Reference to the business domain that governs this metadata observer
   */
  @doc("Reference to the governing business domain")
  businessDomain?: Reference;

  /**
   * Reference to the data product containing the observed data asset
   */
  @doc("Reference to the containing data product")
  dataProduct?: Reference;

  /**
   * Entity tag for optimistic concurrency control and change detection
   */
  @doc("Entity tag for concurrency control")
  eTag?: string;

  /**
   * Observer type classification determining monitoring capabilities and scope
   */
  @doc("Observer type classification")
  type?: AssetMetadataObserverType;
}

/**
 * Represents the scoped asset metadata configuration for a given data asset.
 * Encapsulates domain, product, and asset references, runtime parameters, and audit metadata.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property name"
@doc("Scoped asset metadata configuration linked to a specific data asset.")
model ScopedAssetMetadata {
  /**
   * Unique identifier for the scoped asset metadata entity.
   */
  @doc("Unique identifier for the scoped asset metadata entity.")
  id?: string;

  /**
   * Description of the scoped asset metadata.
   */
  @doc("Descriptive text providing details about the scoped asset metadata.")
  description: string;

  /**
   * Reference to the associated Business Domain.
   */
  @doc("Reference to the associated Business Domain.")
  businessDomain?: Reference;

  /**
   * Reference to the associated Data Product.
   */
  @doc("Reference to the associated Data Product.")
  dataProduct?: Reference;

  /**
   * Reference to the associated Data Asset.
   */
  @doc("Reference to the associated Data Asset.")
  dataAsset?: Reference;

  /**
   * Runtime configuration parameters defining error row behavior and output format.
   */
  @doc("Runtime configuration parameters defining error row behavior and output format.")
  runtime?: ScopedAssetMetadataRuntime;

  /**
   * List of favorite column paths selected for quick access or monitoring.
   */
  @doc("List of favorite column paths selected for quick access or monitoring.")
  favouriteColumnPaths: string[];

  /**
   * Timestamp when this metadata was created.
   */
  @doc("Timestamp when this metadata was created.")
  createdAt?: utcDateTime;

  /**
   * Timestamp when this metadata was last modified.
   */
  @doc("Timestamp when this metadata was last modified.")
  lastModifiedAt?: utcDateTime;

  /**
   * Identifier of the user who created this metadata.
   */
  @doc("Identifier of the user who created this metadata.")
  createdBy?: string;

  /**
   * Identifier of the user who last modified this metadata.
   */
  @doc("Identifier of the user who last modified this metadata.")
  lastModifiedBy?: string;

  /**
   * Entity tag used for concurrency control and version validation.
   */
  @doc("Entity tag used for concurrency control and version validation.")
  ETag?: string;
}

/**
 * Defines runtime configuration options for a scoped asset metadata entity.
 * Controls whether error rows are captured and specifies the output format.
 */
@doc("Runtime configuration options for a scoped asset metadata entity.")
model ScopedAssetMetadataRuntime {
  @doc("Indicates whether error row details should be captured.")
  isErrorRowRequired: boolean;

  @doc("Specifies the format in which error rows are written (e.g., CSV, Parquet).")
  errorRowWriteFormat?: string;
}

/**
 * Comprehensive data source entity representing external data connections and their configurations.
 * Manages access credentials, network settings, and scope definitions for various data platforms.
 */
@doc("Unified data source entity model combining all supported data source types and their configuration properties.")
model DataSourceEntity {
  /**
   * Unique identifier for the data source entity.
   */
  @doc("Unique system identifier for the data source entity.")
  id?: string;

  /**
   * Display name of the data source connection.
   */
  @doc("Human-readable display name identifying the data source connection.")
  name?: string;

  /**
   * Indicates whether the data source is configured for Virtual Network connectivity.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Already existing body parameter"
  @doc("Virtual Network connectivity flag.")
  isVNetEnabled?: boolean;

  /**
   * Azure resource identifier of the target data platform, if applicable.
   */
  @doc("Azure resource identifier for target platform (if applicable).")
  targetResourceId?: string;

  /**
   * Reference to the business domain that governs this data source.
   */
  @doc("Business domain governance reference for this data source.")
  businessDomain?: {
    /**
     * Type classification for the business domain reference.
     */
    @doc("Business domain reference type classification.")
    type?: string;

    /**
     * Unique identifier of the governing business domain.
     */
    @doc("Unique business domain identifier associated with this data source.")
    referenceId: string;
  };

  /**
   * Timestamp when the data source was last modified.
   */
  @doc("ISO 8601 timestamp representing the last modification time.")
  lastModifiedAt?: string;

  /**
   * Identity of the user who created the data source configuration.
   */
  @doc("Identifier or name of the user who created the data source configuration.")
  createdBy?: string;

  /**
   * Timestamp when the data source was created.
   */
  @doc("ISO 8601 timestamp representing the creation time.")
  createdAt?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Already existing body parameter"
  @doc("Entity tag for concurrency control and change detection.")
  ETag?: string;

  /**
   * Identity of the user who last modified the data source configuration.
   */
  @doc("Identifier or name of the last modifying user.")
  lastModifiedBy?: string;

  /**
   * Type of data source platform, such as AzureSqlDatabase, Snowflake, or OneLake.
   */
  @doc("Platform type of the data source (e.g., AzureSqlDatabase, Snowflake, OneLake, etc.).")
  type?: string;

  /**
   * Authentication credential information for accessing the data source.
   */
  @doc("Authentication credential configuration for data source access.")
  credential?: {
    /**
     * Type of credential (e.g., ServicePrincipal, ManagedIdentity, UsernamePassword).
     */
    @doc("Credential type for authentication.")
    type: string;

    /**
     * Reference identifier for the credential resource.
     */
    @doc("Reference identifier for the credential resource.")
    referenceName?: string;

    /**
     * Additional credential parameters specific to the credential type.
     */
    @doc("Type-specific credential parameters.")
    typeProperties?: {};
  };

  /**
   * Consolidated configuration properties covering all supported data source types.
   */
  @doc("Combined configuration properties for all supported data source platforms.")
  typeProperties?: {
    // ---------- Azure SQL ----------
    @doc("Azure SQL server name (for AzureSqlDatabase).")
    server?: string;

    @doc("Database name (for AzureSqlDatabase, Snowflake, Synapse).")
    database?: string;

    // ---------- Oracle ----------
    @doc("Oracle host IP or DNS (for OnPremiseOracleDatabase).")
    host?: string;

    @doc("Oracle database port (for OnPremiseOracleDatabase).")
    port?: string;

    @doc("Oracle username (for OnPremiseOracleDatabase).")
    username?: string;

    @doc("Schema name (for Oracle, Snowflake, or Databricks).")
    schema?: string;

    @doc("Oracle service name (for OnPremiseOracleDatabase).")
    service?: string;

    @doc("Integration runtime ID (for OnPremiseOracleDatabase).")
    dataIntegrationRuntimeId?: string;

    // ---------- Snowflake ----------
    @doc("Snowflake account URL.")
    url?: string;

    @doc("Snowflake warehouse name.")
    warehouse?: string;

    @doc("Schema name used for test connection (for Snowflake).")
    testConnectionSchemaName?: string;

    @doc("Table name used for test connection (for Snowflake).")
    testConnectionTableName?: string;

    // ---------- ADLS Gen2 ----------
    @doc("Primary DFS endpoint for ADLS Gen2.")
    endpoint?: string;

    // ---------- Azure Databricks Unity Catalog ----------
    @doc("Databricks workspace URL.")
    workspaceUrl?: string;

    @doc("HTTP path for Databricks SQL warehouse.")
    httpPath?: string;

    @doc("Unity Catalog name.")
    catalog?: string;

    @doc("Metastore identifier for Unity Catalog.")
    metastoreId?: string;

    // ---------- Azure Synapse Analytics ----------
    @doc("Synapse workspace name.")
    workspaceName?: string;

    @doc("Dedicated SQL endpoint for Synapse.")
    dedicatedEndpoint?: string;

    @doc("Serverless SQL endpoint for Synapse.")
    serverlessEndpoint?: string;

    @doc("Endpoint type classification (e.g., sql).")
    endpointType?: string;

    // ---------- OneLake ----------
    @doc("Microsoft Entra tenant ID (for OneLake).")
    tenantId?: string;

    @doc("Fabric workspace ID (for OneLake).")
    workspaceId?: string;

    @doc("Lakehouse ID (for OneLake).")
    lakehouseId?: string;

    @doc("Identity of the user who created this data source.")
    createdBy?: string;

    @doc("ISO 8601 timestamp representing the creation time.")
    createdAt?: string;

    #suppress "@azure-tools/typespec-azure-core/casing-style" "Already existing parameter from body"
    @doc("Entity tag for concurrency control and change detection.")
    ETag?: string;

    @doc("Resource name associated with the data source.")
    resourceName?: string;

    @doc("Subscription identifier associated with the data source.")
    subscriptionId?: string;
  };

  @doc("Compute resource identifier associated with the credential.")
  computeId?: string;

  @doc("Region associated with the credential.")
  region?: string;

  @doc("Type of data source platform (e.g., AzureSqlDatabase, OnPremiseOracleDatabase, Snowflake, etc.).")
  dataSourceType?: string;

  @doc("Managed Private Endpoint identifier for secure connectivity.")
  managePrivateEndPointId?: string;

  @doc("Manage Private Endpoint status information.")
  managePrivateEndpointStatus?: string;

  /**
   * Access scope definitions controlling data object inclusion or exclusion for operations.
   */
  @doc("Access scope definitions controlling which data objects are included or excluded from operations.")
  scopes?: Array<{
    /**
     * Scope configuration defining access boundaries and included objects.
     */
    @doc("Scope configuration defining inclusion and exclusion boundaries.")
    scope: {
      /**
       * Type classification for the scope (e.g., SQL, NoSQL, File, etc.).
       */
      @doc("Scope type classification (SQL, NoSQL, File, etc.).")
      type: string;

      /**
       * Collection of included data object names or patterns.
       */
      @doc("List of included data object names or patterns within this scope.")
      includes: string[];
    };

    /**
     * Unique identifier for this scope definition.
     */
    @doc("Unique identifier for this scope definition.")
    id: string;
  }>;
}

/**
 * Query parameters for filtering and paginating data source listing operations.
 * Supports name-based filtering and continuation token pagination for large result sets.
 */
@doc("Query parameters for data source listing with filtering and pagination")
model DataSourceListQueryParams {
  /**
   * Pagination continuation token for retrieving subsequent result pages
   */
  @doc("Pagination continuation token")
  @query("skipToken")
  skipToken?: string;

  /**
   * Name filter for matching data sources by exact or partial name
   */
  @doc("Name filter for data source matching")
  @query("name")
  name?: string;
}

/**
 * HTTP response model for data source operations containing complete connection configuration.
 * Includes platform-specific settings, network configuration, and governance relationships.
 */
@doc("HTTP response model for data source operations with complete configuration and metadata.")
model DataSourceEntityResponse {
  /**
   * HTTP status code indicating successful data source creation or update (201 Created)
   */
  @doc("HTTP status code for successful operation.")
  @statusCode
  statusCode: 201;

  /**
   * Human-readable display name identifying the data source connection.
   */
  @doc("Display name of the data source connection.")
  name: string;

  /**
   * Unique system identifier for the data source entity.
   */
  @doc("Unique data source identifier.")
  id: string;

  /**
   * Flag indicating if the data source is configured for Virtual Network connectivity.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property name"
  @doc("Virtual Network connectivity flag.")
  isVNetEnabled?: boolean;

  /**
   * Azure resource identifier of the target data platform, if Azure-based.
   */
  @doc("Azure resource identifier for target platform (if applicable).")
  targetResourceId?: string;

  /**
   * Reference to the business domain that governs this data source.
   */
  @doc("Business domain governance reference for this data source.")
  businessDomain?: {
    /**
     * Reference type classification for the business domain relationship.
     */
    @doc("Business domain reference type classification.")
    type: string;

    /**
     * Unique identifier of the governing business domain.
     */
    @doc("Unique identifier of the governing business domain.")
    referenceId: string;
  };

  /**
   * ISO 8601 timestamp when the data source configuration was last modified.
   */
  @doc("Timestamp when the data source configuration was last modified (ISO 8601).")
  lastModifiedAt: string;

  /**
   * Identity of the user who last modified the data source configuration.
   */
  @doc("Identity of the last modifying user.")
  lastModifiedBy: string;

  /**
   * Data source platform type (AzureSqlDatabase, Snowflake, AzureSynapseAnalytics, Oracle, etc.)
   */
  @doc("Platform type of the data source (e.g., AzureSqlDatabase, Snowflake, OneLake, etc.).")
  type?: string;

  /**
   * Platform-specific configuration properties including connection strings, authentication, and settings.
   */
  @doc("Platform-specific configuration properties and credentials (key-value pairs).")
  typeProperties?: Record<string>;

  /**
   * Access scope definitions that control which data objects are included or excluded from operations.
   */
  @doc("Access scope definitions controlling inclusion and exclusion of data objects.")
  scopes?: Array<{
    /**
     * Scope configuration defining access boundaries and included objects.
     */
    @doc("Scope configuration defining inclusion and exclusion boundaries.")
    scope: {
      /**
       * Scope type classification (SQL, NoSQL, File, etc.)
       */
      @doc("Scope type classification (e.g., SQL, NoSQL, File, etc.).")
      type: string;

      /**
       * Collection of data object names or patterns included in this scope.
       */
      @doc("Collection of included data object names or patterns.")
      includes: string[];
    };

    /**
     * Unique identifier for the scope definition.
     */
    @doc("Unique identifier for the scope definition.")
    id?: string;

    /**
     * Authentication credential information for accessing the data source.
     */
    @doc("Authentication credential configuration for data source access.")
    credential?: {
      /**
       * Type of credential (e.g., ServicePrincipal, ManagedIdentity, UsernamePassword).
       */
      @doc("Credential type for authentication.")
      type: string;

      /**
       * Reference identifier for the credential resource.
       */
      @doc("Reference identifier for the credential resource.")
      referenceName?: string;

      /**
       * Additional credential parameters specific to the credential type.
       */
      @doc("Type-specific credential parameters.")
      typeProperties?: {};
    };

    @doc("Compute resource identifier associated with the credential.")
    computeId?: string;

    @doc("Region associated with the credential.")
    region?: string;

    @doc("Type of data source platform (e.g., AzureSqlDatabase, OnPremiseOracleDatabase, Snowflake, etc.).")
    dataSourceType?: string;
  }>;
}

/**
 * Paginated response model for data source listing operations within a business domain.
 * Contains collection of data sources with their complete configuration and metadata.
 */
@doc("Paginated response for data source listing operations")
model DataSourceEntityListResponse {
  /**
   * Collection of data source entities with their complete configuration details
   */
  @doc("Collection of data source entities")
  value: DataSourceEntity[];
}

/**
 * HTTP response model for schedule scan monitoring operations.
 * Contains collection of monitoring entities with execution metrics and status information.
 */
@doc("HTTP response for schedule scan monitoring with execution metrics")
model ScheduleScanMonitoringResponse {
  /**
   * HTTP status code indicating successful monitoring data retrieval (200 OK)
   */
  @doc("HTTP status code for successful retrieval")
  @statusCode
  statusCode: 200;

  /**
   * Collection of monitoring entities with execution metrics, timing, and status details
   */
  @doc("Collection of schedule scan monitoring entities")
  value: ScheduleScanMonitoringEntity[];
}

/**
 * Profile entity configuration for data profiling and analysis operations.
 * Defines data source locations, key columns, and profiling parameters for quality assessment.
 */
@doc("Profile entity for data profiling and quality analysis configuration")
model ProfileEntity {
  /**
   * Profile type classification determining the profiling strategy and analysis scope
   */
  @doc("Profile type classification")
  type: string;

  /**
   * Type-specific configuration properties including location definitions and access parameters
   */
  @doc("Type-specific profiling configuration properties")
  typeProperties: {
    /**
     * Collection of data location definitions specifying where profiling should be performed
     */
    location: {
      /**
       * Location type classification (AdlsGen2FileLocation, BlobStorageLocation, etc.)
       */
      type: string;

      /**
       * Location-specific properties defining file system and path details
       */
      typeProperties: {
        /**
         * File system or container name where data resides
         */
        fileSystem: string;

        /**
         * Folder path within the file system containing target data
         */
        folderPath: string;
      };
    }[];
  };

  /**
   * Unique identifier of the data source containing the data to be profiled
   */
  @doc("Data source identifier for profiling target")
  dataSourceId: string;

  /**
   * Profiling configuration including key column definitions and analysis parameters
   */
  @doc("Profiling configuration with key columns and parameters")
  configuration: {
    /**
     * Collection of key columns that serve as primary identifiers for profiling analysis
     */
    keyColumns: {
      /**
       * Name of the key column used for data identification and grouping
       */
      name: string;
    }[];
  };
}

/**
 * HTTP response model for profile entity operations with long-running operation support.
 * Provides immediate acknowledgment with profile run tracking for asynchronous profiling execution.
 */
@doc("HTTP response for profile operations with LRO support and run tracking")
model ProfileEntityResponse {
  /**
   * HTTP status code indicating accepted request for profiling processing (202 Accepted)
   */
  @doc("HTTP status code for accepted profiling operation")
  @statusCode
  statusCode: 202;

  /**
   * Unique identifier for the profile run execution to track profiling progress
   */
  @doc("Profile run execution identifier")
  profileRunId: string;

  /**
   * Long-running operation status for tracking asynchronous profiling completion
   */
  @doc("Long-running operation status for profiling")
  @lroStatus
  status: LroStatus;

  @doc("Real-time profiling execution monitoring information")
  statusMonitor?: StatusMonitor;
}

/**
 * Response model for the latest data quality snapshot report containing comprehensive quality metrics and observer information.
 */
@doc("Latest data quality snapshot report with comprehensive metrics and observer details.")
model DataQualitySnapshotResponse {
  /**
   * Identifier of the business domain associated with this snapshot.
   */
  @doc("Identifier of the business domain associated with this snapshot.")
  businessDomainId: string;

  /**
   * Identifier of the data product under the business domain.
   */
  @doc("Identifier of the data product under the business domain.")
  dataProductId: string;

  /**
   * Identifier of the data asset whose quality is captured in this snapshot.
   */
  @doc("Identifier of the data asset whose quality is captured in this snapshot.")
  assetId: string;

  /**
   * Overall data quality score for the asset.
   */
  @doc("Overall data quality score for the asset.")
  assetScore: float64;

  /**
   * Detailed snapshot data containing observer and rule information.
   */
  @doc("Detailed snapshot data containing observer and rule information.")
  snapshot: {
    /**
     * Array of observers monitoring this data asset.
     */
    @doc("Array of observers monitoring this data asset.")
    observers: Array<{
      /**
       * Name of the observer.
       */
      @doc("Name of the observer.")
      name: string;

      /**
       * Type of the observer.
       */
      @doc("Type of the observer.")
      type: string;

      /**
       * Reference to the data asset being observed.
       */
      @doc("Reference to the data asset being observed.")
      dataAsset: {
        /**
         * Reference identifier for the data asset.
         */
        @doc("Reference identifier for the data asset.")
        referenceId: string;
      };

      /**
       * Observer-specific configuration properties.
       */
      @doc("Observer-specific configuration properties.")
      typeProperties: {
        /**
         * Array of input datasets for this observer.
         */
        @doc("Array of input datasets for this observer.")
        inputDatasets: Array<{
          /**
           * Alias name for the dataset.
           */
          @doc("Alias name for the dataset.")
          @encodedName("application/json", "alias")
          aliasName: string;

          /**
           * Whether this is the primary dataset.
           */
          @doc("Whether this is the primary dataset.")
          primary: boolean;

          /**
           * Dataset configuration and metadata.
           */
          @doc("Dataset configuration and metadata.")
          dataset: {
            /**
             * Fully qualified name of the data source.
             */
            #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property name"
            @doc("Fully qualified name of the data source.")
            datasourceFQN?: string;

            /**
             * Schema summary information for the dataset.
             */
            @doc("Schema summary information for the dataset.")
            schemaSummary: {
              /**
               * Total number of columns in the dataset.
               */
              @doc("Total number of columns in the dataset.")
              columnCount: int32;

              /**
               * Sample of columns with their names and types.
               */
              @doc("Sample of columns with their names and types.")
              sampleColumns: Array<{
                /**
                 * Name of the column.
                 */
                @doc("Name of the column.")
                name: string;

                /**
                 * Data type of the column.
                 */
                @doc("Data type of the column.")
                type: string;
              }>;
            };

            /**
             * Type of the dataset (e.g., Delta, Parquet).
             */
            @doc("Type of the dataset (e.g., Delta, Parquet).")
            type: string;

            /**
             * Location path of the dataset.
             */
            @doc("Location path of the dataset.")
            location: string;
          };
        }>;
      };
    }>;

    /**
     * Summary of data quality rules associated with this snapshot.
     */
    @doc("Summary of data quality rules associated with this snapshot.")
    rulesSummary: {
      /**
       * Total number of rules configured.
       */
      @doc("Total number of rules configured.")
      totalRules: int32;

      /**
       * Number of active rules.
       */
      @doc("Number of active rules.")
      activeRules: int32;

      /**
       * Number of disabled rules.
       */
      @doc("Number of disabled rules.")
      disabledRules: int32;

      /**
       * Sample of active rule names.
       */
      @doc("Sample of active rule names.")
      sampleActiveRules: string[];

      /**
       * Sample of disabled rule names.
       */
      @doc("Sample of disabled rule names.")
      sampleDisabledRules: string[];
    };
  };
}

/**
 * Represents a list of trend records showing data quality score evolution
 * across different business domains, data products, and assets.
 */
@doc("List of data quality trend records grouped by domain, product, and asset.")
model DataQualityTrendResponse {
  /**
   * Array of trend entries representing data quality metrics for each job.
   */
  @doc("Array of trend entries representing data quality metrics for each job.")
  value: DataQualityTrendRecord[];
}

/**
 * Represents an individual trend record for a single data asset and job run.
 */
@doc("Trend record capturing data quality score and job execution information for a specific asset.")
model DataQualityTrendRecord {
  /**
   * Identifier of the business domain associated with the trend record.
   */
  @doc("Identifier of the business domain associated with the trend record.")
  businessDomainId: string;

  /**
   * Identifier of the data product under the business domain.
   */
  @doc("Identifier of the data product under the business domain.")
  dataProductId: string;

  /**
   * Identifier of the data asset whose quality score is represented.
   */
  @doc("Identifier of the data asset whose quality score is represented.")
  assetId: string;

  /**
   * Data quality score for this job execution, if computed.
   */
  @doc("Data quality score for this job execution, if computed.")
  assetScore?: float64;

  /**
   * Identifier of the job execution or monitoring run.
   */
  @doc("Identifier of the job execution or monitoring run.")
  jobId: string;

  /**
   * Migration status information, if available.
   */
  @doc("Migration status information, if available.")
  migrationStatus?: string;
}

/**
 * Opinion entity representing stakeholder feedback and assessment results for data quality controls.
 * Captures evaluation outcomes, timing, and contextual information for governance decision-making.
 */
@doc("Opinion entity for stakeholder feedback and data quality control assessments")
model OpinionEntity {
  /**
   * Unique identifier of the business domain where the opinion was recorded
   */
  @doc("Business domain identifier for opinion context")
  businessDomainId: string;

  /**
   * Unique identifier of the data product associated with this opinion
   */
  @doc("Data product identifier for opinion scope")
  dataProductId: string;

  /**
   * Unique identifier of the specific data asset being evaluated in the opinion
   */
  @doc("Data asset identifier for opinion target")
  dataAssetId: string;

  /**
   * Unique identifier of the data quality control being assessed
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Allow null for backward compatibility"
  @doc("Data quality control identifier")
  controlId?: string | null;

  /**
   * Unique identifier for this specific opinion record
   */
  @doc("Opinion record unique identifier")
  opinionId: string;

  /**
   * Opinion value or assessment result (e.g., "Approved", "Rejected", "Needs Review")
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Existing parameter"
  @doc("Opinion assessment value or result")
  value?: unknown;

  /**
   * UTC timestamp when the opinion assessment was completed
   */
  @doc("Opinion completion timestamp (UTC)")
  resultedAt: utcDateTime;

  /**
   * Unique identifier of the assessment outcome or decision result
   */
  @doc("Assessment outcome identifier")
  outcomeId: string;

  /**
   * Optional identifier of the query execution that generated supporting data for this opinion
   */
  @doc("Supporting query execution identifier")
  queryExecuted?: string;

  @doc("Total number of rows evaluated during the opinion assessment")
  totalRows: int64;

  @doc("Number of empty rows identified during the opinion assessment")
  emptyRows: int64;

  @doc("Number of failed rows identified during the opinion assessment")
  failedRows: int64;

  @doc("Number of passed rows identified during the opinion assessment")
  passedRows: int64;

  @doc("Number of miscast rows identified during the opinion assessment")
  miscastRows: int64;

  @doc("Indicates if the opinion is a cloned instance")
  isClonedOpinion: boolean;
}

/**
 * Response model for job history listing operations with historical execution records.
 * Contains collection of completed job executions with their outcomes and performance metrics.
 */
@doc("Response for job history listing with execution records and metrics")
model JobHistoryResponse {
  /**
   * Collection of historical job execution records with completion details and performance data
   */
  @doc("Collection of job history execution records")
  value: JobHistoryEntity[];
}

/**
 * Empty response
 */
model EmptyResponse {}

/**
 * Asset scoped metadata containing configuration specific to a data asset
 */
@doc("Asset scoped metadata with runtime configuration and references to business domain, data product, and data asset")
model AssetScopedMetadata {
  @doc("Description of the asset scoped metadata")
  description?: string;

  @doc("List of favorite column paths for the asset")
  favouriteColumnPaths?: string[];

  @doc("Unique identifier for the asset scoped metadata")
  id: string;

  @doc("Reference to the business domain")
  businessDomain: Reference;

  @doc("Reference to the data product")
  dataProduct: Reference;

  @doc("Reference to the data asset")
  dataAsset: Reference;

  @doc("Runtime configuration for the asset")
  runtime?: AssetRuntimeConfiguration;

  @doc("Timestamp when the metadata was created")
  createdAt: utcDateTime;

  @doc("Timestamp when the metadata was last modified")
  lastModifiedAt: utcDateTime;

  @doc("User ID who created the metadata")
  createdBy: string;

  @doc("User ID who last modified the metadata")
  lastModifiedBy: string;

  @doc("Entity tag for optimistic concurrency control")
  eTag: string;
}

/**
 * Runtime configuration for asset processing
 */
@doc("Runtime configuration settings for asset processing")
model AssetRuntimeConfiguration {
  @doc("Whether error row is required during processing")
  isErrorRowRequired?: boolean;

  @doc("Format for writing error rows")
  errorRowWriteFormat?: string;
}

/**
 * Global rules applied to assets
 */
@doc("Global rule definition with scoring and metadata")
model GlobalRule {
  @doc("Name of the rule")
  name: string;

  @doc("Unique identifier for the rule")
  id: string;

  @doc("Description of the rule")
  description?: string;

  @doc("Type of the rule")
  type: string;

  @doc("Type-specific properties of the rule")
  typeProperties?: RuleTypeProperties;

  @doc("Status of the rule (Active, Inactive)")
  status: string;

  @doc("Score associated with the rule")
  score?: float64;

  @doc("Dimension of the rule (e.g., Conformity, Completeness)")
  dimension?: string;

  @doc("Reference to the business domain")
  businessDomain?: Reference;

  @doc("Reference to the data product")
  dataProduct?: Reference;

  @doc("Reference to the data asset")
  dataAsset?: Reference;

  @doc("Timestamp when the rule was last modified")
  lastModifiedAt?: utcDateTime;

  @doc("User ID who last modified the rule")
  lastModifiedBy?: string;

  @doc("Timestamp when the rule was created")
  createdAt?: utcDateTime;

  @doc("User ID who created the rule")
  createdBy?: string;
}

/**
 * Type-specific properties for rules
 */
@doc("Type-specific properties configuration for rules")
model RuleTypeProperties {
  @doc("Condition expression for the rule")
  condition?: string;

  @doc("Filter criteria for the rule")
  filterCriteria?: string;

  @doc("Columns associated with the rule")
  columns?: RuleColumn[];
}

/**
 * Column definition for rules
 */
@doc("Column definition used in rule configurations")
model RuleColumn {
  @doc("Value or name of the column")
  value: string;

  @doc("Type of the column reference")
  type: string;
}

/**
 * Score snapshot containing comprehensive scoring and validation results
 */
@doc("Comprehensive score snapshot with business domain, data product, asset scoring, and validation results")
model ScoreSnapshot {
  @doc("Business domain identifier")
  businessDomainId: string;

  @doc("Data product identifier")
  dataProductId: string;

  @doc("Asset identifier")
  assetId: string;

  @doc("Overall score for the asset")
  assetScore: float64;

  @doc("Origin asset identifier")
  originAssetId: string;

  @doc("Is the asset standalone")
  isStandaloneAsset: boolean;

  @doc("Rules with their scores and validation results")
  rules: ScoredRule[];

  @doc("Job information for the snapshot")
  job: SnapshotJob;
}

/**
 * Detailed snapshot information
 */
@doc("Detailed snapshot containing observers, data sources, and validation results")
model SnapshotDetails {
  @doc("List of observers in the snapshot")
  observers?: SnapshotObserver[];

  @doc("List of data sources")
  dataSources?: SnapshotDataSource[];

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Legacy API design uses unknown array type for validation results"
  @doc("Observer validation results")
  observerValidationResults?: unknown[];

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Legacy API design uses unknown array type for schemas"
  @doc("Observer schemas")
  observerSchemas?: unknown[];

  @doc("Dataset to datasource mappings")
  datasetToDatasourceMappings?: DatasetMapping[];
}

/**
 * Observer in snapshot
 */
@doc("Observer configuration and properties within a snapshot")
model SnapshotObserver {
  @doc("Name of the observer")
  name?: string;

  @doc("Type of the observer")
  type?: string;

  @doc("Reference to the data asset")
  dataAsset?: Reference;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Legacy API design uses unknown type for flexible type-specific properties"
  @doc("Type-specific properties of the observer")
  typeProperties?: unknown;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "ETag is a well-known property name in Azure APIs"
  @doc("Entity tag for the observer")
  ETag?: string;

  @doc("Creation timestamp")
  createdAt?: utcDateTime;

  @doc("Creator user ID")
  createdBy?: string;

  @doc("Observer ID")
  id?: string;

  @doc("Last modification timestamp")
  lastModifiedAt?: utcDateTime;

  @doc("Last modifier user ID")
  lastModifiedBy?: string;

  @doc("Reference to the business domain")
  businessDomain?: Reference;

  @doc("Reference to the data product")
  dataProduct?: Reference;
}

/**
 * Data source in snapshot
 */
@doc("Data source configuration within a snapshot")
model SnapshotDataSource {
  @doc("Name of the data source")
  name?: string;

  @doc("Description of the data source")
  description?: string;

  @doc("Type of the data source")
  type?: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Legacy API design uses unknown type for flexible credential configuration"
  @doc("Credential configuration")
  credential?: unknown;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Legacy API design uses unknown type for flexible type-specific properties"
  @doc("Type-specific properties")
  typeProperties?: unknown;

  @doc("Target resource ID")
  targetResourceId?: string;

  @doc("Region of the data source")
  region?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "VNet is a well-known Azure term and follows established naming convention"
  @doc("Whether VNet is enabled")
  isVNetEnabled?: boolean;

  @doc("Compute ID")
  computeId?: string;

  @doc("Data source type")
  dataSourceType?: string;

  @doc("Manage private endpoint ID")
  managePrivateEndPointId?: string;

  @doc("Manage private endpoint status")
  managePrivateEndpointStatus?: string;

  @doc("Reference to the business domain")
  businessDomain?: Reference;

  @doc("Creation timestamp")
  createdAt?: utcDateTime;

  @doc("Creator user ID")
  createdBy?: string;

  @doc("Data source ID")
  id?: string;

  @doc("Last modification timestamp")
  lastModifiedAt?: utcDateTime;

  @doc("Last modifier user ID")
  lastModifiedBy?: string;
}

/**
 * Dataset to datasource mapping
 */
@doc("Mapping between dataset alias and datasource ID")
model DatasetMapping {
  @doc("Dataset alias name")
  datasetAliasName?: string;

  @doc("Datasource identifier")
  datasourceId?: string;
}

/**
 * Rule with scoring information
 */
@doc("Rule definition with scoring and validation results")
model ScoredRule {
  @doc("Rule identifier")
  id?: string;

  @doc("Score for the rule")
  score?: float64;

  @doc("Name of the rule")
  name?: string;

  @doc("Description of the rule")
  description?: string;

  @doc("Type of the rule")
  type?: string;

  @doc("Status of the rule")
  status?: string;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Legacy API design uses unknown array type for flexible column data"
  @doc("Columns associated with the rule")
  columns?: unknown[];

  @doc("Total number of rows processed")
  totalRows?: int64;

  @doc("Number of failed rows")
  failedRows?: int64;

  @doc("Number of passed rows")
  passedRows?: int64;

  @doc("Number of empty rows")
  emptyRows?: int64;

  @doc("Number of miscast rows")
  miscastRows?: int64;

  @doc("The query which has been executed")
  queryExecuted?: string;

  @doc("Dimension of the rule")
  dimension?: string;

  @doc("Reference to the business domain")
  businessDomain?: Reference;

  @doc("Reference to the data product")
  dataProduct?: Reference;

  @doc("Reference to the data asset")
  dataAsset?: Reference;

  @doc("Properties related to the data asset")
  typeProperties?: TypeProperties;

  @doc("Last modification timestamp")
  lastModifiedAt?: utcDateTime;

  @doc("Last modifier user ID")
  lastModifiedBy?: string;

  @doc("Creator user ID")
  createdBy?: string;

  @doc("Creation timestamp")
  createdAt?: utcDateTime;
}

/**
 * Job information for snapshot
 */
@doc("Job information associated with a score snapshot")
model SnapshotJob {
  @doc("Job identifier")
  jobId?: string;

  @doc("Business domain identifier")
  businessDomainId?: string;
}

/**
 * Metadata entry for bulk operations containing all asset-related metadata
 */
@doc("Complete metadata entry for bulk operations including asset metadata, scoped metadata, rules, and score snapshot")
model BulkAssetMetadataEntry {
  @doc("Asset metadata information")
  assetMetadata: AssetMetadata;

  @doc("Asset scoped metadata information")
  assetScopedMetadata: ScopedAssetMetadata;

  @doc("Snapshot Details")
  scoreSnapshot: ScoreSnapshot;

  @doc("Global rules applied to the asset")
  globalRules: RuleEntity[];
}

/**
 * Response model for bulk asset metadata GET operations
 */
@doc("Response containing bulk asset metadata with pagination support")
model BulkAssetMetadataRequestResponse {
  @doc("Continuation token for pagination. Null when no more results are available.")
  continuationToken?: string;

  @doc("Array of metadata entries (up to 10 per response)")
  metadata: BulkAssetMetadataEntry[];
}

/**
 * Request model for bulk asset metadata POST operations
 */
@doc("Request containing bulk asset metadata for insertion")
model BulkAssetMetadataRequest {
  @doc("Array of metadata entries to insert")
  metadata: BulkAssetMetadataEntry[];
}
