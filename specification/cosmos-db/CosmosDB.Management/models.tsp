import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DocumentDB;

model FleetListResult is ResourceListResult<FleetResource>;
model ThroughputPoolsListResult is ResourceListResult<ThroughputPoolResource>;
model TableRoleDefinitionListResult
  is ResourceListResult<TableRoleDefinitionResource>;

model ThroughputPoolAccountsListResult
  is ResourceListResult<ThroughputPoolAccountResource>;

model TableRoleAssignmentListResult
  is ResourceListResult<TableRoleAssignmentResource>;

model FleetAnalyticsListResult is ResourceListResult<FleetAnalyticsResource>;
/**
 * Result of the request to list Resource Provider operations. It contains a list of operations and a URL link to get the next set of results.
 */
model OperationListResult {
  /** List of operations supported by the Resource Provider. */
  @pageItems
  value: Operation[];

  /** URL to get the next set of operation list results if there are any. */
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * Copy Job Type
 */
union CopyJobType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CassandraRUToCassandraRU: "CassandraRUToCassandraRU",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CassandraRUToAzureBlobStorage: "CassandraRUToAzureBlobStorage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureBlobStorageToCassandraRU: "AzureBlobStorageToCassandraRU",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MongoRUToMongoRU: "MongoRUToMongoRU",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MongoRUToMongoVCore: "MongoRUToMongoVCore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NoSqlRUToNoSqlRU: "NoSqlRUToNoSqlRU",
}

/**
 * Job Status
 */
union CopyJobStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Partitioning: "Partitioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Paused: "Paused",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Faulted: "Faulted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Cancelled: "Cancelled",
}

/**
 * Mode of job execution
 */
union CopyJobMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Offline: "Offline",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Online: "Online",
}

/**
 * Indicates the type of database account. This can only be set at database account creation.
 */
union DatabaseAccountKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GlobalDocumentDB: "GlobalDocumentDB",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MongoDB: "MongoDB",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Parse: "Parse",
}

/**
 * The cassandra connector offer type for the Cosmos DB C* database account.
 */
union ConnectorOffer {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Small: "Small",
}

/**
 * Whether requests from Public Network are allowed
 */
union PublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SecuredByPerimeter: "SecuredByPerimeter",
}

/**
 * Describes the version of the MongoDB account.
 */
union ServerVersion {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Three2: "3.2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Three6: "3.6",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Four0: "4.0",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Four2: "4.2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Five0: "5.0",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Six0: "6.0",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Seven0: "7.0",
}

/**
 * Describes the types of schema for analytical storage.
 */
union AnalyticalStorageSchemaType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WellDefined: "WellDefined",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FullFidelity: "FullFidelity",
}

/**
 * Enum to indicate the mode of account creation.
 */
union CreateMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Restore: "Restore",
}

/**
 * Describes the mode of the restore.
 */
union RestoreMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PointInTime: "PointInTime",
}

/**
 * Describes the mode of backups.
 */
union BackupPolicyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Periodic: "Periodic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Continuous: "Continuous",
}

/**
 * Describes the status of migration between backup policy types.
 */
union BackupPolicyMigrationStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
}

/**
 * Indicates the capacity mode of the account.
 */
union CapacityMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioned: "Provisioned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Serverless: "Serverless",
}

/**
 * The transition status of capacity mode.
 */
union CapacityModeTransitionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Initialized: "Initialized",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
}

/**
 * Indicates the minimum allowed Tls version. The default is Tls 1.0, except for Cassandra and Mongo API's, which only work with Tls 1.2.
 */
union MinimalTlsVersion {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Tls: "Tls",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Tls11: "Tls11",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Tls12: "Tls12",
}

/**
 * Enum to indicate default priorityLevel of requests
 */
union DefaultPriorityLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  High: "High",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Low: "Low",
}

/**
 * Kind of the connection string key
 */
union Kind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Primary: "Primary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Secondary: "Secondary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PrimaryReadonly: "PrimaryReadonly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SecondaryReadonly: "SecondaryReadonly",
}

/**
 * Type of the connection string
 */
union Type {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Sql: "Sql",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Table: "Table",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MongoDB: "MongoDB",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Cassandra: "Cassandra",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CassandraConnectorMetadata: "CassandraConnectorMetadata",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Gremlin: "Gremlin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SqlDedicatedGateway: "SqlDedicatedGateway",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GremlinV2: "GremlinV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Undefined: "Undefined",
}

/**
 * The access key to regenerate.
 */
union KeyKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Primary: "primary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Secondary: "secondary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PrimaryReadonly: "primaryReadonly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SecondaryReadonly: "secondaryReadonly",
}

/**
 * The unit of the metric.
 */
union UnitType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Count: "Count",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Bytes: "Bytes",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Seconds: "Seconds",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Percent: "Percent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CountPerSecond: "CountPerSecond",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BytesPerSecond: "BytesPerSecond",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Milliseconds: "Milliseconds",
}

/**
 * The primary aggregation type of the metric.
 */
union PrimaryAggregationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Average: "Average",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Total: "Total",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Minimum: "Minimum",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Maximum: "Maximum",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Last: "Last",
}

/**
 * Indicates the indexing mode.
 */
union IndexingMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Consistent: "consistent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Lazy: "lazy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "none",
}

/**
 * The datatype for which the indexing behavior is applied to.
 */
union DataType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  String: "String",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Number: "Number",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Point: "Point",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Polygon: "Polygon",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LineString: "LineString",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MultiPolygon: "MultiPolygon",
}

/**
 * Indicates the type of index.
 */
union IndexKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Hash: "Hash",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Range: "Range",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Spatial: "Spatial",
}

/**
 * Sort order for composite paths.
 */
union CompositePathSortOrder {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Ascending: "ascending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Descending: "descending",
}

/**
 * Indicates the spatial type of index.
 */
union SpatialType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Point: "Point",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LineString: "LineString",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Polygon: "Polygon",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MultiPolygon: "MultiPolygon",
}

/**
 * The index type of the vector. Currently, flat, diskANN, and quantizedFlat are supported.
 */
union VectorIndexType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Flat: "flat",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DiskANN: "diskANN",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  QuantizedFlat: "quantizedFlat",
}

/**
 * Indicates the kind of algorithm used for partitioning. For MultiHash, multiple partition keys (upto three maximum) are supported for container create
 */
union PartitionKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Hash: "Hash",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Range: "Range",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MultiHash: "MultiHash",
}

/**
 * Indicates the conflict resolution mode.
 */
union ConflictResolutionMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LastWriterWins: "LastWriterWins",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Custom: "Custom",
}

/**
 * Indicates the data type of vector.
 */
union VectorDataType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Float32: "float32",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Uint8: "uint8",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Int8: "int8",
}

/**
 * The distance function to use for distance calculation in between vectors.
 */
union DistanceFunction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Euclidean: "euclidean",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Cosine: "cosine",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Dotproduct: "dotproduct",
}

/**
 * ThroughputPolicy to apply for throughput redistribution
 */
union ThroughputPolicyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "none",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Equal: "equal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Custom: "custom",
}

/**
 * Type of the Trigger
 */
union TriggerType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pre: "Pre",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Post: "Post",
}

/**
 * The operation the trigger is associated with
 */
union TriggerOperation {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  All: "All",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Create: "Create",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Update: "Update",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Delete: "Delete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Replace: "Replace",
}

/**
 * Enum to indicate type of backup storage redundancy.
 */
union BackupStorageRedundancy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Geo: "Geo",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Local: "Local",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Zone: "Zone",
}

/**
 * Enum to indicate current buildout status of the region.
 */
union Status {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Uninitialized: "Uninitialized",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Initializing: "Initializing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InternallyReady: "InternallyReady",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Online: "Online",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union DataTransferComponent {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CosmosDBCassandra: "CosmosDBCassandra",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CosmosDBMongo: "CosmosDBMongo",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CosmosDBMongoVCore: "CosmosDBMongoVCore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CosmosDBSql: "CosmosDBSql",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureBlobStorage: "AzureBlobStorage",
}

/**
 * Mode of job execution
 */
union DataTransferJobMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Offline: "Offline",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Online: "Online",
}

/**
 * The status of the resource at the time the operation was called.
 */
union ManagedCassandraProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
}

/**
 * Which authentication method Cassandra should use to authenticate clients. 'None' turns off authentication, so should not be used except in emergencies. 'Cassandra' is the default password based authentication. The default is 'Cassandra'.
 */
union AuthenticationMethod {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Cassandra: "Cassandra",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Ldap: "Ldap",
}

/**
 * The form of AutoReplicate that is being used by this cluster.
 */
union AutoReplicate {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemKeyspaces: "SystemKeyspaces",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AllKeyspaces: "AllKeyspaces",
}

/**
 * Type of the cluster. If set to Production, some operations might not be permitted on cluster.
 */
union ClusterType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Production: "Production",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NonProduction: "NonProduction",
}

/**
 * How the nodes in the cluster react to scheduled events
 */
union ScheduledEventStrategy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Ignore: "Ignore",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  StopAny: "StopAny",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  StopByRack: "StopByRack",
}

/**
 * How to connect to the azure services needed for running the cluster
 */
union AzureConnectionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VPN: "VPN",
}

/**
 * The type of the resource.
 */
union ManagedCassandraResourceIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
}

/**
 * Status of the command.
 */
union CommandStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Done: "Done",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enqueue: "Enqueue",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Processing: "Processing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Finished: "Finished",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
}

/**
 * The current state of the backup.
 */
union BackupState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Initiated: "Initiated",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
}

/**
 * The kind of connection error that occurred.
 */
union ConnectionState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OK: "OK",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OperatorToDataCenterNetworkError: "OperatorToDataCenterNetworkError",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DatacenterToDatacenterNetworkError: "DatacenterToDatacenterNetworkError",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InternalOperatorToDataCenterCertificateError: "InternalOperatorToDataCenterCertificateError",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InternalError: "InternalError",
}

/**
 * The state of the node in Cassandra ring.
 */
union NodeState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Normal: "Normal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Leaving: "Leaving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Joining: "Joining",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Stopped: "Stopped",
}

/**
 * Type of issue
 */
union IssueType {
  string,

  /**
   * Unknown issue type
   */
  Unknown: "Unknown",

  /**
   * An error occurred while applying the network security perimeter (NSP) configuration.
   */
  ConfigurationPropagationFailure: "ConfigurationPropagationFailure",

  /**
   * A network connectivity issue is happening on the resource which could be addressed either by adding new resources to the network security perimeter (NSP) or by modifying access rules.
   */
  MissingPerimeterConfiguration: "MissingPerimeterConfiguration",

  /**
   * An managed identity hasn't been associated with the resource. The resource will still be able to validate inbound traffic from the network security perimeter (NSP) or matching inbound access rules, but it won't be able to perform outbound access as a member of the NSP.
   */
  MissingIdentityConfiguration: "MissingIdentityConfiguration",
}

/**
 * Severity of the issue.
 */
union Severity {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Warning: "Warning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union NotebookWorkspaceName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Default: "default",
}

/**
 * Enum to indicate the API type of the restorable database account.
 */
union ApiType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MongoDB: "MongoDB",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Gremlin: "Gremlin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Cassandra: "Cassandra",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Table: "Table",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Sql: "Sql",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GremlinV2: "GremlinV2",
}

/**
 * Enum to indicate the operation type of the event.
 */
union OperationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Create: "Create",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Replace: "Replace",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Delete: "Delete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Recreate: "Recreate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemOperation: "SystemOperation",
}

/**
 * Instance type for the service.
 */
union ServiceSize {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CosmosD4S: "Cosmos.D4s",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CosmosD8S: "Cosmos.D8s",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CosmosD16S: "Cosmos.D16s",
}

/**
 * ServiceType for the service.
 */
union ServiceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SqlDedicatedGateway: "SqlDedicatedGateway",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DataTransfer: "DataTransfer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GraphAPICompute: "GraphAPICompute",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MaterializedViewsBuilder: "MaterializedViewsBuilder",
}

/**
 * Describes the status of a service.
 */
union ServiceStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Stopped: "Stopped",
}

/**
 * The type of the fleet analytics resource.
 */
union FleetAnalyticsPropertiesStorageLocationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  StorageAccount: "StorageAccount",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FabricLakehouse: "FabricLakehouse",
}

/**
 * The kind of API this fleetspace belongs to. Acceptable values: 'NoSQL'
 */
union FleetspacePropertiesFleetspaceApiKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NoSQL: "NoSQL",
}

/**
 * Service Tier for the fleetspace. GeneralPurpose types refers to single write region accounts that can be added to this fleetspace, whereas BusinessCritical refers to multi write region.
 */
union FleetspacePropertiesThroughputPoolConfigurationServiceTier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GeneralPurpose: "GeneralPurpose",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BusinessCritical: "BusinessCritical",
}

/**
 * Enum to indicate type of Continuous backup tier.
 */
union ContinuousTier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Continuous7Days: "Continuous7Days",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Continuous30Days: "Continuous30Days",
}

/**
 * DedicatedGatewayType for the service.
 */
union DedicatedGatewayType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IntegratedCache: "IntegratedCache",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DistributedQuery: "DistributedQuery",
}

/**
 * Indicates whether the node is functioning or not.
 */
union NodeStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Up: "Up",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Down: "Down",
}

/**
 * Indicates whether what action to take for the Chaos Fault.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SupportedActions {
  Enable,
  Disable,
}

/**
 * The default consistency level and configuration settings of the Cosmos DB account.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum DefaultConsistencyLevel {
  Eventual,
  Session,
  BoundedStaleness,
  Strong,
  ConsistentPrefix,
}

/**
 * Indicates what services are allowed to bypass firewall checks.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum NetworkAclBypass {
  None,
  AzureServices,
}

/**
 * Describe the level of detail with which queries are to be logged.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum EnableFullTextQuery {
  None,
  True,
  False,
}

/**
 * The type of identity used for the resource. The type 'SystemAssigned,UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the service.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  SystemAssignedUserAssigned: "SystemAssigned,UserAssigned",
  None,
}

/**
 * Indicates whether the Role Definition was built-in or user created.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum MongoRoleDefinitionType {
  BuiltInRole,
  CustomRole,
}

/**
 * Indicates whether the Role Definition was built-in or user created.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum RoleDefinitionType {
  BuiltInRole,
  CustomRole,
}

/**
 * Chaos Fault List Response.
 */
model ChaosFaultListResponse is Azure.Core.Page<ChaosFaultResource>;

/**
 * A request object to enable/disable the chaos fault.
 */
model ChaosFaultProperties {
  /**
   * Indicates whether what action to take for the Chaos Fault.
   */
  action?: SupportedActions;

  /**
   * Region of the account where the Chaos Fault is to be enabled/disabled.
   */
  region?: string;

  /**
   * Database name.
   */
  databaseName?: string;

  /**
   * Container name.
   */
  containerName?: string;

  /**
   * A provisioning state of the Chaos Fault.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * The properties of a Copy Job
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CopyJobProperties {
  /**
   * Job Properties
   */
  jobProperties: BaseCopyJobProperties;

  /**
   * Job Status
   */
  @visibility(Lifecycle.Read)
  status?: CopyJobStatus;

  /**
   * Processed Count
   */
  @visibility(Lifecycle.Read)
  processedCount?: int64;

  /**
   * Total Count
   */
  @visibility(Lifecycle.Read)
  totalCount?: int64;

  /**
   * Last Updated Time (ISO-8601 format)
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedUtcTime?: utcDateTime;

  /**
   * Worker count
   */
  @minValue(0)
  workerCount?: int32;

  /**
   * Error response for Faulted job
   */
  @visibility(Lifecycle.Read)
  error?: ErrorResponse;

  /**
   * Total Duration of Job
   */
  @visibility(Lifecycle.Read)
  duration?: string;

  /**
   * Mode of job execution
   */
  mode?: CopyJobMode;
}

/**
 * Base copy job properties
 */
@discriminator("jobType")
model BaseCopyJobProperties {
  /**
   * Copy Job Type
   */
  jobType: CopyJobType = CopyJobType.NoSqlRUToNoSqlRU;
}

/**
 * The resource model definition for a ARM proxy resource. It will have everything other than required location and tags
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ARMProxyResource {
  /**
   * The unique resource identifier of the database account.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the database account.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of Azure resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * An error response from the service.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
@Azure.ResourceManager.Legacy.armExternalType
model CloudError {
  /**
   * Error Response.
   */
  error?: ErrorResponse;
}

/**
 * The List operation response, that contains the Copy Jobs and their properties.
 */
model CopyJobFeedResults is Azure.Core.Page<CopyJobGetResults>;

/**
 * Properties for the database account.
 */
model DatabaseAccountGetProperties {
  /**
   * The provisioning state of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The connection endpoint for the Cosmos DB database account.
   */
  @visibility(Lifecycle.Read)
  documentEndpoint?: string;

  /**
   * The offer type for the Cosmos DB database account. Default value: Standard.
   */
  @visibility(Lifecycle.Read)
  databaseAccountOfferType?: "Standard";

  /**
   * List of IpRules.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  ipRules?: IpAddressOrRange[];

  /**
   * Flag to indicate whether to enable/disable Virtual Network ACL rules.
   */
  isVirtualNetworkFilterEnabled?: boolean;

  /**
   * Enables automatic failover of the write region in the rare event that the region is unavailable due to an outage. Automatic failover will result in a new write region for the account and is chosen based on the failover priorities configured for the account.
   */
  enableAutomaticFailover?: boolean;

  /**
   * The consistency policy for the Cosmos DB database account.
   */
  consistencyPolicy?: ConsistencyPolicy;

  /**
   * List of Cosmos DB capabilities for the account
   */
  capabilities?: Capability[];

  /**
   * An array that contains the write location for the Cosmos DB account.
   */
  @visibility(Lifecycle.Read)
  writeLocations?: Location[];

  /**
   * An array that contains of the read locations enabled for the Cosmos DB account.
   */
  @visibility(Lifecycle.Read)
  readLocations?: Location[];

  /**
   * An array that contains all of the locations enabled for the Cosmos DB account.
   */
  @visibility(Lifecycle.Read)
  locations?: Location[];

  /**
   * An array that contains the regions ordered by their failover priorities.
   */
  @visibility(Lifecycle.Read)
  failoverPolicies?: FailoverPolicy[];

  /**
   * List of Virtual Network ACL rules configured for the Cosmos DB account.
   */
  virtualNetworkRules?: VirtualNetworkRule[];

  /**
   * List of Private Endpoint Connections configured for the Cosmos DB account.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Enables the account to write in multiple locations
   */
  enableMultipleWriteLocations?: boolean;

  /**
   * Enables the cassandra connector on the Cosmos DB C* account
   */
  enableCassandraConnector?: boolean;

  /**
   * The cassandra connector offer type for the Cosmos DB database C* account.
   */
  connectorOffer?: ConnectorOffer;

  /**
   * Disable write operations on metadata resources (databases, containers, throughput) via account keys
   */
  disableKeyBasedMetadataWriteAccess?: boolean;

  /**
   * The URI of the key vault
   */
  keyVaultKeyUri?: string;

  /**
   * The default identity for accessing key vault used in features like customer managed keys. The default identity needs to be explicitly set by the users. It can be "FirstPartyIdentity", "SystemAssignedIdentity" and more.
   */
  defaultIdentity?: string;

  /**
   * Whether requests from Public Network are allowed
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Flag to indicate whether Free Tier is enabled.
   */
  enableFreeTier?: boolean;

  /**
   * API specific properties.
   */
  apiProperties?: ApiProperties;

  /**
   * Flag to indicate whether to enable storage analytics.
   */
  enableAnalyticalStorage?: boolean;

  /**
   * Analytical storage specific properties.
   */
  analyticalStorageConfiguration?: AnalyticalStorageConfiguration;

  /**
   * A unique identifier assigned to the database account
   */
  @visibility(Lifecycle.Read)
  instanceId?: string;

  /**
   * Enum to indicate the mode of account creation.
   */
  createMode?: CreateMode = CreateMode.Default;

  /**
   * Parameters to indicate the information about the restore.
   */
  restoreParameters?: RestoreParameters;

  /**
   * The object representing the policy for taking backups on an account.
   */
  backupPolicy?: BackupPolicy;

  /**
   * The CORS policy for the Cosmos DB database account.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  cors?: CorsPolicy[];

  /**
   * Indicates what services are allowed to bypass firewall checks.
   */
  networkAclBypass?: NetworkAclBypass;

  /**
   * An array that contains the Resource Ids for Network Acl Bypass for the Cosmos DB account.
   */
  networkAclBypassResourceIds?: Azure.Core.armResourceIdentifier[];

  /**
   * The Object representing the different Diagnostic log settings for the Cosmos DB Account.
   */
  diagnosticLogSettings?: DiagnosticLogSettings;

  /**
   * Opt-out of local authentication and ensure only MSI and AAD can be used exclusively for authentication.
   */
  disableLocalAuth?: boolean;

  /**
   * The object that represents all properties related to capacity enforcement on an account.
   */
  capacity?: Capacity;

  /**
   * Indicates the capacityMode of the Cosmos DB account.
   */
  capacityMode?: CapacityMode;

  /**
   * The object that represents the migration state for the CapacityMode of the Cosmos DB account.
   */
  capacityModeChangeTransitionState?: CapacityModeChangeTransitionState;

  /**
   * Flag to indicate whether to enable MaterializedViews on the Cosmos DB account
   */
  enableMaterializedViews?: boolean;

  /**
   * The object that represents the metadata for the Account Keys of the Cosmos DB account.
   */
  @visibility(Lifecycle.Read)
  keysMetadata?: DatabaseAccountKeysMetadata;

  /**
   * Flag to indicate enabling/disabling of Partition Merge feature on the account
   */
  enablePartitionMerge?: boolean;

  /**
   * Flag to indicate enabling/disabling of Burst Capacity Preview feature on the account
   */
  enableBurstCapacity?: boolean;

  /**
   * Indicates the minimum allowed Tls version. The default is Tls 1.0, except for Cassandra and Mongo API's, which only work with Tls 1.2.
   */
  minimalTlsVersion?: MinimalTlsVersion;

  /**
   * Indicates the status of the Customer Managed Key feature on the account. In case there are errors, the property provides troubleshooting guidance.
   */
  customerManagedKeyStatus?: string;

  /**
   * Flag to indicate enabling/disabling of Priority Based Execution Preview feature on the account
   */
  enablePriorityBasedExecution?: boolean;

  /**
   * Enum to indicate default Priority Level of request for Priority Based Execution.
   */
  defaultPriorityLevel?: DefaultPriorityLevel;

  /**
   * Flag to indicate enabling/disabling of Per-Region Per-partition autoscale Preview feature on the account
   */
  enablePerRegionPerPartitionAutoscale?: boolean;

  /**
   * Flag to indicate if All Versions and Deletes Change feed feature is enabled on the account
   */
  enableAllVersionsAndDeletesChangeFeed?: boolean;
}

/**
 * IpAddressOrRange object
 */
model IpAddressOrRange {
  /**
   * A single IPv4 address or a single IPv4 address range in CIDR format. Provided IPs must be well-formatted and cannot be contained in one of the following ranges: 10.0.0.0/8, 100.64.0.0/10, 172.16.0.0/12, 192.168.0.0/16, since these are not enforceable by the IP address filter. Example of valid inputs: “23.40.210.245” or “23.40.210.0/8”.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ipAddressOrRange?: string;
}

/**
 * The consistency policy for the Cosmos DB database account.
 */
model ConsistencyPolicy {
  /**
   * The default consistency level and configuration settings of the Cosmos DB account.
   */
  defaultConsistencyLevel: DefaultConsistencyLevel;

  /**
   * When used with the Bounded Staleness consistency level, this value represents the number of stale requests tolerated. Accepted range for this value is 1 – 2,147,483,647. Required when defaultConsistencyPolicy is set to 'BoundedStaleness'.
   */
  @maxValue(2147483647)
  @minValue(1)
  maxStalenessPrefix?: int64;

  /**
   * When used with the Bounded Staleness consistency level, this value represents the time amount of staleness (in seconds) tolerated. Accepted range for this value is 5 - 86400. Required when defaultConsistencyPolicy is set to 'BoundedStaleness'.
   */
  @maxValue(86400)
  @minValue(5)
  maxIntervalInSeconds?: int32;
}

/**
 * Cosmos DB capability object
 */
model Capability {
  /**
   * Name of the Cosmos DB capability. For example, "name": "EnableCassandra". Current values also include "EnableTable" and "EnableGremlin".
   */
  name?: string;
}

/**
 * A region in which the Azure Cosmos DB database account is deployed.
 */
model Location {
  /**
   * The unique identifier of the region within the database account. Example: &lt;accountName&gt;-&lt;locationName&gt;.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the region.
   */
  locationName?: string;

  /**
   * The connection endpoint for the specific region. Example: https://&lt;accountName&gt;-&lt;locationName&gt;.documents.azure.com:443/
   */
  @visibility(Lifecycle.Read)
  documentEndpoint?: string;

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The failover priority of the region. A failover priority of 0 indicates a write region. The maximum value for a failover priority = (total number of regions - 1). Failover priority values must be unique for each of the regions in which the database account exists.
   */
  @minValue(0)
  failoverPriority?: int32;

  /**
   * Flag to indicate whether or not this region is an AvailabilityZone region
   */
  isZoneRedundant?: boolean;
}

/**
 * The failover policy for a given region of a database account.
 */
model FailoverPolicy {
  /**
   * The unique identifier of the region in which the database account replicates to. Example: &lt;accountName&gt;-&lt;locationName&gt;.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the region in which the database account exists.
   */
  locationName?: string;

  /**
   * The failover priority of the region. A failover priority of 0 indicates a write region. The maximum value for a failover priority = (total number of regions - 1). Failover priority values must be unique for each of the regions in which the database account exists.
   */
  @minValue(0)
  failoverPriority?: int32;
}

/**
 * Virtual Network ACL Rule object
 */
model VirtualNetworkRule {
  /**
   * Resource ID of a subnet, for example: /subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}.
   */
  id?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * Create firewall rule before the virtual network has vnet service endpoint enabled.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ignoreMissingVNetServiceEndpoint?: boolean;
}

/**
 * Properties of a private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * Private endpoint which the connection belongs to.
   */
  privateEndpoint?: PrivateEndpointProperty;

  /**
   * Connection State of the Private Endpoint Connection.
   */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionStateProperty;

  /**
   * Group id of the private endpoint.
   */
  groupId?: string;

  /**
   * Provisioning state of the private endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: string;
}

/**
 * Private endpoint which the connection belongs to.
 */
model PrivateEndpointProperty {
  /**
   * Resource id of the private endpoint.
   */
  id?: string;
}

/**
 * Connection State of the Private Endpoint Connection.
 */
model PrivateLinkServiceConnectionStateProperty {
  /**
   * The private link service connection status.
   */
  status?: string;

  /**
   * The private link service connection description.
   */
  description?: string;

  /**
   * Any action that is required beyond basic workflow (approve/ reject/ disconnect)
   */
  @visibility(Lifecycle.Read)
  actionsRequired?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ApiProperties {
  /**
   * Describes the version of the MongoDB account.
   */
  serverVersion?: ServerVersion;
}

/**
 * Analytical storage specific properties.
 */
model AnalyticalStorageConfiguration {
  /**
   * Describes the types of schema for analytical storage.
   */
  schemaType?: AnalyticalStorageSchemaType;
}

/**
 * Parameters to indicate the information about the restore.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RestoreParameters extends RestoreParametersBase {
  /**
   * Describes the mode of the restore.
   */
  restoreMode?: RestoreMode;

  /**
   * List of specific databases available for restore.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  databasesToRestore?: DatabaseRestoreResource[];

  /**
   * List of specific gremlin databases available for restore.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  gremlinDatabasesToRestore?: GremlinDatabaseRestoreResource[];

  /**
   * List of specific tables available for restore.
   */
  tablesToRestore?: string[];

  /**
   * The source backup location for restore.
   */
  sourceBackupLocation?: string;
}

/**
 * Specific Databases to restore.
 */
model DatabaseRestoreResource {
  /**
   * The name of the database available for restore.
   */
  databaseName?: string;

  /**
   * The names of the collections available for restore.
   */
  collectionNames?: string[];
}

/**
 * Specific Gremlin Databases to restore.
 */
model GremlinDatabaseRestoreResource {
  /**
   * The name of the gremlin database available for restore.
   */
  databaseName?: string;

  /**
   * The names of the graphs available for restore.
   */
  graphNames?: string[];
}

/**
 * Parameters to indicate the information about the restore.
 */
model RestoreParametersBase {
  /**
   * The id of the restorable database account from which the restore has to be initiated. For example: /subscriptions/{subscriptionId}/providers/Microsoft.DocumentDB/locations/{location}/restorableDatabaseAccounts/{restorableDatabaseAccountName}
   */
  restoreSource?: string;

  /**
   * Time to which the account has to be restored (ISO-8601 format).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  restoreTimestampInUtc?: utcDateTime;

  /**
   * Specifies whether the restored account will have Time-To-Live disabled upon the successful restore.
   */
  restoreWithTtlDisabled?: boolean;
}

/**
 * The object representing the policy for taking backups on an account.
 */
@discriminator("type")
model BackupPolicy {
  /**
   * Describes the mode of backups.
   */
  type: BackupPolicyType;

  /**
   * The object representing the state of the migration between the backup policies.
   */
  migrationState?: BackupPolicyMigrationState;
}

/**
 * The object representing the state of the migration between the backup policies.
 */
model BackupPolicyMigrationState {
  /**
   * Describes the status of migration between backup policy types.
   */
  status?: BackupPolicyMigrationStatus;

  /**
   * Describes the target backup policy type of the backup policy migration.
   */
  targetType?: BackupPolicyType;

  /**
   * Time at which the backup policy migration started (ISO-8601 format).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;
}

/**
 * The CORS policy for the Cosmos DB database account.
 */
model CorsPolicy {
  /**
   * The origin domains that are permitted to make a request against the service via CORS.
   */
  allowedOrigins: string;

  /**
   * The methods (HTTP request verbs) that the origin domain may use for a CORS request.
   */
  allowedMethods?: string;

  /**
   * The request headers that the origin domain may specify on the CORS request.
   */
  allowedHeaders?: string;

  /**
   * The response headers that may be sent in the response to the CORS request and exposed by the browser to the request issuer.
   */
  exposedHeaders?: string;

  /**
   * The maximum amount time that a browser should cache the preflight OPTIONS request.
   */
  @maxValue(2147483647)
  @minValue(1)
  maxAgeInSeconds?: int64;
}

/**
 * Indicates what diagnostic log settings are to be enabled.
 */
model DiagnosticLogSettings {
  /**
   * Describe the level of detail with which queries are to be logged.
   */
  enableFullTextQuery?: EnableFullTextQuery;
}

/**
 * The object that represents all properties related to capacity enforcement on an account.
 */
model Capacity {
  /**
   * The total throughput limit imposed on the account. A totalThroughputLimit of 2000 imposes a strict limit of max throughput that can be provisioned on that account to be 2000. A totalThroughputLimit of -1 indicates no limits on provisioning of throughput.
   */
  @minValue(-1)
  totalThroughputLimit?: int32;
}

/**
 * The transition state information related capacity mode change with update request.
 */
model CapacityModeChangeTransitionState {
  /**
   * The transition status of capacity mode.
   */
  capacityModeTransitionStatus?: CapacityModeTransitionStatus;

  /**
   * Indicates the current capacity mode of the account.
   */
  currentCapacityMode?: CapacityMode;

  /**
   * Indicates the previous capacity mode of the account before successful transition.
   */
  previousCapacityMode?: CapacityMode;

  /**
   * Begin time in UTC of the capacity mode change.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  capacityModeTransitionBeginTimestamp?: utcDateTime;

  /**
   * End time in UTC of the capacity mode change.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  capacityModeTransitionEndTimestamp?: utcDateTime;

  /**
   * End time in UTC of the last successful capacity mode change.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  capacityModeLastSuccessfulTransitionEndTimestamp?: utcDateTime;
}

/**
 * The metadata related to each access key for the given Cosmos DB database account.
 */
model DatabaseAccountKeysMetadata {
  /**
   * The metadata related to the Primary Read-Write Key for the given Cosmos DB database account.
   */
  @visibility(Lifecycle.Read)
  primaryMasterKey?: AccountKeyMetadata;

  /**
   * The metadata related to the Secondary Read-Write Key for the given Cosmos DB database account.
   */
  @visibility(Lifecycle.Read)
  secondaryMasterKey?: AccountKeyMetadata;

  /**
   * The metadata related to the Primary Read-Only Key for the given Cosmos DB database account.
   */
  @visibility(Lifecycle.Read)
  primaryReadonlyMasterKey?: AccountKeyMetadata;

  /**
   * The metadata related to the Secondary Read-Only Key for the given Cosmos DB database account.
   */
  @visibility(Lifecycle.Read)
  secondaryReadonlyMasterKey?: AccountKeyMetadata;
}

/**
 * The metadata related to an access key for a given database account.
 */
model AccountKeyMetadata {
  /**
   * Generation time in UTC of the key in ISO-8601 format. If the value is missing from the object, it means that the last key regeneration was triggered before 2022-06-18.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  generationTime?: utcDateTime;
}

/**
 * The core properties of ARM resources.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ARMResourceProperties {
  /**
   * The unique resource identifier of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of Azure resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The location of the resource group to which the resource belongs.
   */
  location?: string;

  /**
   * Tags are a list of key-value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups). A maximum of 15 tags can be provided for a resource. Each tag must have a key no greater than 128 characters and value no greater than 256 characters. For example, the default experience for a template type is set with "defaultExperience": "Cassandra". Current "defaultExperience" values also include "Table", "Graph", "DocumentDB", and "MongoDB".
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Identity for the resource.
   */
  identity?: ManagedServiceIdentity;
}

/**
 * Identity for the resource.
 */
model ManagedServiceIdentity {
  /**
   * The principal id of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant id of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The type of identity used for the resource. The type 'SystemAssigned,UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the service.
   */
  type?: ResourceIdentityType;

  /**
   * The list of user identities associated with resource. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<Components1Jq1T4ISchemasManagedserviceidentityPropertiesUserassignedidentitiesAdditionalproperties>;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Components1Jq1T4ISchemasManagedserviceidentityPropertiesUserassignedidentitiesAdditionalproperties {
  /**
   * The principal id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * Parameters for patching Azure Cosmos DB database account properties.
 */
model DatabaseAccountUpdateParameters {
  /**
   * Tags are a list of key-value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups). A maximum of 15 tags can be provided for a resource. Each tag must have a key no greater than 128 characters and value no greater than 256 characters. For example, the default experience for a template type is set with "defaultExperience": "Cassandra". Current "defaultExperience" values also include "Table", "Graph", "DocumentDB", and "MongoDB".
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The location of the resource group to which the resource belongs.
   */
  location?: string;

  /**
   * Identity for the resource.
   */
  identity?: ManagedServiceIdentity;

  /**
   * Properties to update Azure Cosmos DB database accounts.
   */
  properties?: DatabaseAccountUpdateProperties;
}

/**
 * Properties to update Azure Cosmos DB database accounts.
 */
model DatabaseAccountUpdateProperties {
  /**
   * The consistency policy for the Cosmos DB account.
   */
  consistencyPolicy?: ConsistencyPolicy;

  /**
   * An array that contains the georeplication locations enabled for the Cosmos DB account.
   */
  locations?: Location[];

  /**
   * List of IpRules.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  ipRules?: IpAddressOrRange[];

  /**
   * Flag to indicate whether to enable/disable Virtual Network ACL rules.
   */
  isVirtualNetworkFilterEnabled?: boolean;

  /**
   * Enables automatic failover of the write region in the rare event that the region is unavailable due to an outage. Automatic failover will result in a new write region for the account and is chosen based on the failover priorities configured for the account.
   */
  enableAutomaticFailover?: boolean;

  /**
   * List of Cosmos DB capabilities for the account
   */
  capabilities?: Capability[];

  /**
   * List of Virtual Network ACL rules configured for the Cosmos DB account.
   */
  virtualNetworkRules?: VirtualNetworkRule[];

  /**
   * Enables the account to write in multiple locations
   */
  enableMultipleWriteLocations?: boolean;

  /**
   * Enables the cassandra connector on the Cosmos DB C* account
   */
  enableCassandraConnector?: boolean;

  /**
   * The cassandra connector offer type for the Cosmos DB database C* account.
   */
  connectorOffer?: ConnectorOffer;

  /**
   * Disable write operations on metadata resources (databases, containers, throughput) via account keys
   */
  disableKeyBasedMetadataWriteAccess?: boolean;

  /**
   * The URI of the key vault
   */
  keyVaultKeyUri?: string;

  /**
   * The default identity for accessing key vault used in features like customer managed keys. The default identity needs to be explicitly set by the users. It can be "FirstPartyIdentity", "SystemAssignedIdentity" and more.
   */
  defaultIdentity?: string;

  /**
   * Whether requests from Public Network are allowed
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Flag to indicate whether Free Tier is enabled.
   */
  enableFreeTier?: boolean;

  /**
   * API specific properties. Currently, supported only for MongoDB API.
   */
  apiProperties?: ApiProperties;

  /**
   * Flag to indicate whether to enable storage analytics.
   */
  enableAnalyticalStorage?: boolean;

  /**
   * Analytical storage specific properties.
   */
  analyticalStorageConfiguration?: AnalyticalStorageConfiguration;

  /**
   * The object representing the policy for taking backups on an account.
   */
  backupPolicy?: BackupPolicy;

  /**
   * The CORS policy for the Cosmos DB database account.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  cors?: CorsPolicy[];

  /**
   * Indicates what services are allowed to bypass firewall checks.
   */
  networkAclBypass?: NetworkAclBypass;

  /**
   * An array that contains the Resource Ids for Network Acl Bypass for the Cosmos DB account.
   */
  networkAclBypassResourceIds?: string[];

  /**
   * The Object representing the different Diagnostic log settings for the Cosmos DB Account.
   */
  diagnosticLogSettings?: DiagnosticLogSettings;

  /**
   * Opt-out of local authentication and ensure only MSI and AAD can be used exclusively for authentication.
   */
  disableLocalAuth?: boolean;

  /**
   * The object that represents all properties related to capacity enforcement on an account.
   */
  capacity?: Capacity;

  /**
   * Indicates the capacityMode of the Cosmos DB account.
   */
  capacityMode?: CapacityMode;

  /**
   * Flag to indicate whether to enable MaterializedViews on the Cosmos DB account
   */
  enableMaterializedViews?: boolean;

  /**
   * This property is ignored during the update operation, as the metadata is read-only. The object represents the metadata for the Account Keys of the Cosmos DB account.
   */
  @visibility(Lifecycle.Read)
  keysMetadata?: DatabaseAccountKeysMetadata;

  /**
   * Flag to indicate enabling/disabling of Partition Merge feature on the account
   */
  enablePartitionMerge?: boolean;

  /**
   * Flag to indicate enabling/disabling of Burst Capacity Preview feature on the account
   */
  enableBurstCapacity?: boolean;

  /**
   * Indicates the minimum allowed Tls version. The default is Tls 1.0, except for Cassandra and Mongo API's, which only work with Tls 1.2.
   */
  minimalTlsVersion?: MinimalTlsVersion;

  /**
   * Indicates the status of the Customer Managed Key feature on the account. In case there are errors, the property provides troubleshooting guidance.
   */
  customerManagedKeyStatus?: string;

  /**
   * Flag to indicate enabling/disabling of Priority Based Execution Preview feature on the account
   */
  enablePriorityBasedExecution?: boolean;

  /**
   * Enum to indicate default Priority Level of request for Priority Based Execution.
   */
  defaultPriorityLevel?: DefaultPriorityLevel;

  /**
   * Flag to indicate enabling/disabling of Per-Region Per-partition autoscale Preview feature on the account
   */
  enablePerRegionPerPartitionAutoscale?: boolean;

  /**
   * Flag to indicate if All Versions and Deletes Change feed feature is enabled on the account
   */
  enableAllVersionsAndDeletesChangeFeed?: boolean;
}

/**
 * Parameters to create and update Cosmos DB database accounts.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseAccountCreateUpdateParameters extends ARMResourceProperties {
  /**
   * Indicates the type of database account. This can only be set at database account creation.
   */
  kind?: DatabaseAccountKind = DatabaseAccountKind.GlobalDocumentDB;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedServiceIdentity;

  /**
   * Properties to create and update Azure Cosmos DB database accounts.
   */
  properties: DatabaseAccountCreateUpdateProperties;
}

/**
 * Properties to create and update Azure Cosmos DB database accounts.
 */
model DatabaseAccountCreateUpdateProperties {
  /**
   * The consistency policy for the Cosmos DB account.
   */
  consistencyPolicy?: ConsistencyPolicy;

  /**
   * An array that contains the georeplication locations enabled for the Cosmos DB account.
   */
  locations: Location[];

  /**
   * The offer type for the Cosmos DB database account.
   */
  databaseAccountOfferType: "Standard";

  /**
   * List of IpRules.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  ipRules?: IpAddressOrRange[];

  /**
   * Flag to indicate whether to enable/disable Virtual Network ACL rules.
   */
  isVirtualNetworkFilterEnabled?: boolean;

  /**
   * Enables automatic failover of the write region in the rare event that the region is unavailable due to an outage. Automatic failover will result in a new write region for the account and is chosen based on the failover priorities configured for the account.
   */
  enableAutomaticFailover?: boolean;

  /**
   * List of Cosmos DB capabilities for the account
   */
  capabilities?: Capability[];

  /**
   * List of Virtual Network ACL rules configured for the Cosmos DB account.
   */
  virtualNetworkRules?: VirtualNetworkRule[];

  /**
   * Enables the account to write in multiple locations
   */
  enableMultipleWriteLocations?: boolean;

  /**
   * Enables the cassandra connector on the Cosmos DB C* account
   */
  enableCassandraConnector?: boolean;

  /**
   * The cassandra connector offer type for the Cosmos DB database C* account.
   */
  connectorOffer?: ConnectorOffer;

  /**
   * Disable write operations on metadata resources (databases, containers, throughput) via account keys
   */
  disableKeyBasedMetadataWriteAccess?: boolean;

  /**
   * The URI of the key vault
   */
  keyVaultKeyUri?: string;

  /**
   * The default identity for accessing key vault used in features like customer managed keys. The default identity needs to be explicitly set by the users. It can be "FirstPartyIdentity", "SystemAssignedIdentity" and more.
   */
  defaultIdentity?: string;

  /**
   * Whether requests from Public Network are allowed
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Flag to indicate whether Free Tier is enabled.
   */
  enableFreeTier?: boolean;

  /**
   * API specific properties. Currently, supported only for MongoDB API.
   */
  apiProperties?: ApiProperties;

  /**
   * Flag to indicate whether to enable storage analytics.
   */
  enableAnalyticalStorage?: boolean;

  /**
   * Analytical storage specific properties.
   */
  analyticalStorageConfiguration?: AnalyticalStorageConfiguration;

  /**
   * Enum to indicate the mode of account creation.
   */
  createMode?: CreateMode = CreateMode.Default;

  /**
   * The object representing the policy for taking backups on an account.
   */
  backupPolicy?: BackupPolicy;

  /**
   * The CORS policy for the Cosmos DB database account.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  cors?: CorsPolicy[];

  /**
   * Indicates what services are allowed to bypass firewall checks.
   */
  networkAclBypass?: NetworkAclBypass;

  /**
   * An array that contains the Resource Ids for Network Acl Bypass for the Cosmos DB account.
   */
  networkAclBypassResourceIds?: string[];

  /**
   * The Object representing the different Diagnostic log settings for the Cosmos DB Account.
   */
  diagnosticLogSettings?: DiagnosticLogSettings;

  /**
   * Opt-out of local authentication and ensure only MSI and AAD can be used exclusively for authentication.
   */
  disableLocalAuth?: boolean;

  /**
   * Parameters to indicate the information about the restore.
   */
  restoreParameters?: RestoreParameters;

  /**
   * The object that represents all properties related to capacity enforcement on an account.
   */
  capacity?: Capacity;

  /**
   * Indicates the capacityMode of the Cosmos DB account.
   */
  capacityMode?: CapacityMode;

  /**
   * Flag to indicate whether to enable MaterializedViews on the Cosmos DB account
   */
  enableMaterializedViews?: boolean;

  /**
   * This property is ignored during the update/create operation, as the metadata is read-only. The object represents the metadata for the Account Keys of the Cosmos DB account.
   */
  @visibility(Lifecycle.Read)
  keysMetadata?: DatabaseAccountKeysMetadata;

  /**
   * Flag to indicate enabling/disabling of Partition Merge feature on the account
   */
  enablePartitionMerge?: boolean;

  /**
   * Flag to indicate enabling/disabling of Burst Capacity Preview feature on the account
   */
  enableBurstCapacity?: boolean;

  /**
   * Indicates the minimum allowed Tls version. The default is Tls 1.0, except for Cassandra and Mongo API's, which only work with Tls 1.2.
   */
  minimalTlsVersion?: MinimalTlsVersion;

  /**
   * Indicates the status of the Customer Managed Key feature on the account. In case there are errors, the property provides troubleshooting guidance.
   */
  customerManagedKeyStatus?: string;

  /**
   * Flag to indicate enabling/disabling of Priority Based Execution Preview feature on the account
   */
  enablePriorityBasedExecution?: boolean;

  /**
   * Enum to indicate default Priority Level of request for Priority Based Execution.
   */
  defaultPriorityLevel?: DefaultPriorityLevel;

  /**
   * Flag to indicate enabling/disabling of Per-Region Per-partition autoscale Preview feature on the account
   */
  enablePerRegionPerPartitionAutoscale?: boolean;

  /**
   * Flag to indicate if All Versions and Deletes Change feed feature is enabled on the account
   */
  enableAllVersionsAndDeletesChangeFeed?: boolean;
}

/**
 * The list of new failover policies for the failover priority change.
 */
model FailoverPolicies {
  /**
   * List of failover policies.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  failoverPolicies: FailoverPolicy[];
}

/**
 * The List operation response, that contains the database accounts and their properties.
 */
model DatabaseAccountsListResult {
  /**
   * List of database account and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: DatabaseAccountGetResults[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The access keys for the given database account.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatabaseAccountListKeysResult
  extends DatabaseAccountListReadOnlyKeysResult {
  /**
   * Base 64 encoded value of the primary read-write key.
   */
  @visibility(Lifecycle.Read)
  primaryMasterKey?: string;

  /**
   * Base 64 encoded value of the secondary read-write key.
   */
  @visibility(Lifecycle.Read)
  secondaryMasterKey?: string;
}

/**
 * The read-only access keys for the given database account.
 */
model DatabaseAccountListReadOnlyKeysResult {
  /**
   * Base 64 encoded value of the primary read-only key.
   */
  @visibility(Lifecycle.Read)
  primaryReadonlyMasterKey?: string;

  /**
   * Base 64 encoded value of the secondary read-only key.
   */
  @visibility(Lifecycle.Read)
  secondaryReadonlyMasterKey?: string;
}

/**
 * The connection strings for the given database account.
 */
model DatabaseAccountListConnectionStringsResult {
  /**
   * An array that contains the connection strings for the Cosmos DB account.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  connectionStrings?: DatabaseAccountConnectionString[];
}

/**
 * Connection string for the Cosmos DB account
 */
model DatabaseAccountConnectionString {
  /**
   * Value of the connection string
   */
  @visibility(Lifecycle.Read)
  connectionString?: string;

  /**
   * Description of the connection string
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Kind of the connection string key
   */
  @visibility(Lifecycle.Read)
  keyKind?: Kind;

  /**
   * Type of the connection string
   */
  @visibility(Lifecycle.Read)
  type?: Type;
}

/**
 * Cosmos DB region to online or offline.
 */
model RegionForOnlineOffline {
  /**
   * Cosmos DB region, with spaces between words and each word capitalized.
   */
  region: string;
}

/**
 * Parameters to regenerate the keys within the database account.
 */
model DatabaseAccountRegenerateKeyParameters {
  /**
   * The access key to regenerate.
   */
  keyKind: KeyKind;
}

/**
 * REST API operation
 */
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * The object that represents the operation.
   */
  display?: OperationDisplay;
}

/**
 * The object that represents the operation.
 */
model OperationDisplay {
  /**
   * Service provider: Microsoft.ResourceProvider
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provider?: string;

  /**
   * Resource on which the operation is performed: Profile, endpoint, etc.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Resource?: string;

  /**
   * Operation type: Read, write, delete, etc.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Operation?: string;

  /**
   * Description of operation
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Description?: string;
}

/**
 * The response to a list metrics request.
 */
model MetricListResult {
  /**
   * The list of metrics for the account.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: Metric[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * Metric data
 */
model Metric {
  /**
   * The start time for the metric (ISO-8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The end time for the metric (ISO-8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The time grain to be used to summarize the metric values.
   */
  @visibility(Lifecycle.Read)
  timeGrain?: string;

  /**
   * The unit of the metric.
   */
  @visibility(Lifecycle.Read)
  unit?: UnitType;

  /**
   * The name information for the metric.
   */
  @visibility(Lifecycle.Read)
  name?: MetricName;

  /**
   * The metric values for the specified time window and timestep.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  @visibility(Lifecycle.Read)
  metricValues?: MetricValue[];
}

/**
 * A metric name.
 */
model MetricName {
  /**
   * The name of the metric.
   */
  @visibility(Lifecycle.Read)
  value?: string;

  /**
   * The friendly name of the metric.
   */
  @visibility(Lifecycle.Read)
  localizedValue?: string;
}

/**
 * Represents metrics values.
 */
model MetricValue {
  /**
   * The number of values for the metric.
   */
  @visibility(Lifecycle.Read)
  _count?: int32;

  /**
   * The average value of the metric.
   */
  @visibility(Lifecycle.Read)
  average?: float64;

  /**
   * The max value of the metric.
   */
  @visibility(Lifecycle.Read)
  maximum?: float64;

  /**
   * The min value of the metric.
   */
  @visibility(Lifecycle.Read)
  minimum?: float64;

  /**
   * The metric timestamp (ISO-8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * The total value of the metric.
   */
  @visibility(Lifecycle.Read)
  total?: float64;
}

/**
 * The response to a list percentile metrics request.
 */
model PercentileMetricListResult {
  /**
   * The list of percentile metrics for the account.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: PercentileMetric[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * Percentile Metric data
 */
model PercentileMetric {
  /**
   * The start time for the metric (ISO-8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The end time for the metric (ISO-8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The time grain to be used to summarize the metric values.
   */
  @visibility(Lifecycle.Read)
  timeGrain?: string;

  /**
   * The unit of the metric.
   */
  @visibility(Lifecycle.Read)
  unit?: UnitType;

  /**
   * The name information for the metric.
   */
  @visibility(Lifecycle.Read)
  name?: MetricName;

  /**
   * The percentile metric values for the specified time window and timestep.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  @visibility(Lifecycle.Read)
  metricValues?: PercentileMetricValue[];
}

/**
 * Represents percentile metrics values.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PercentileMetricValue extends MetricValue {
  /**
   * The 10th percentile value for the metric.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  P10?: float64;

  /**
   * The 25th percentile value for the metric.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  P25?: float64;

  /**
   * The 50th percentile value for the metric.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  P50?: float64;

  /**
   * The 75th percentile value for the metric.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  P75?: float64;

  /**
   * The 90th percentile value for the metric.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  P90?: float64;

  /**
   * The 95th percentile value for the metric.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  P95?: float64;

  /**
   * The 99th percentile value for the metric.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  P99?: float64;
}

/**
 * The response to a list partition metrics request.
 */
model PartitionMetricListResult {
  /**
   * The list of partition-level metrics for the account.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: PartitionMetric[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The metric values for a single partition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PartitionMetric extends Metric {
  /**
   * The partition id (GUID identifier) of the metric values.
   */
  @visibility(Lifecycle.Read)
  partitionId?: string;

  /**
   * The partition key range id (integer identifier) of the metric values.
   */
  @visibility(Lifecycle.Read)
  partitionKeyRangeId?: string;
}

/**
 * The response to a list usage request.
 */
model UsagesResult {
  /**
   * The list of usages for the database. A usage is a point in time metric
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: Usage[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The usage data for a usage request.
 */
model Usage {
  /**
   * The unit of the metric.
   */
  @visibility(Lifecycle.Read)
  unit?: UnitType;

  /**
   * The name information for the metric.
   */
  @visibility(Lifecycle.Read)
  name?: MetricName;

  /**
   * The quota period used to summarize the usage values.
   */
  @visibility(Lifecycle.Read)
  quotaPeriod?: string;

  /**
   * Maximum value for this metric
   */
  @visibility(Lifecycle.Read)
  limit?: int64;

  /**
   * Current value for this metric
   */
  @visibility(Lifecycle.Read)
  currentValue?: int64;
}

/**
 * The response to a list partition level usage request.
 */
model PartitionUsagesResult {
  /**
   * The list of partition-level usages for the database. A usage is a point in time metric
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: PartitionUsage[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The partition level usage data for a usage request.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PartitionUsage extends Usage {
  /**
   * The partition id (GUID identifier) of the usages.
   */
  @visibility(Lifecycle.Read)
  partitionId?: string;

  /**
   * The partition key range id (integer identifier) of the usages.
   */
  @visibility(Lifecycle.Read)
  partitionKeyRangeId?: string;
}

/**
 * The response to a list metric definitions request.
 */
model MetricDefinitionsListResult {
  /**
   * The list of metric definitions for the account.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: MetricDefinition[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The definition of a metric.
 */
model MetricDefinition {
  /**
   * The list of metric availabilities for the account.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  @visibility(Lifecycle.Read)
  metricAvailabilities?: MetricAvailability[];

  /**
   * The primary aggregation type of the metric.
   */
  @visibility(Lifecycle.Read)
  primaryAggregationType?: PrimaryAggregationType;

  /**
   * The unit of the metric.
   */
  @visibility(Lifecycle.Read)
  unit?: UnitType;

  /**
   * The resource uri of the database.
   */
  @visibility(Lifecycle.Read)
  resourceUri?: string;

  /**
   * The name information for the metric.
   */
  @visibility(Lifecycle.Read)
  name?: MetricName;
}

/**
 * The availability of the metric.
 */
model MetricAvailability {
  /**
   * The time grain to be used to summarize the metric values.
   */
  @visibility(Lifecycle.Read)
  timeGrain?: string;

  /**
   * The retention for the metric values.
   */
  @visibility(Lifecycle.Read)
  retention?: string;
}

/**
 * The List operation response, that contains the Graph resource and their properties.
 */
model GraphResourcesListResult {
  /**
   * List of Graph resource and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: GraphResourceGetResults[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The properties of an Azure Cosmos DB SQL database
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GraphResourceGetProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource?: GraphResourceGetPropertiesResource;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  options?: GraphResourceGetPropertiesOptions;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GraphResourceGetPropertiesResource extends GraphResource {}

/**
 * Cosmos DB Graph resource object
 */
model GraphResource {
  /**
   * Name of the Cosmos DB Graph
   */
  id: string;
}
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GraphResourceGetPropertiesOptions extends OptionsResource {}

/**
 * Cosmos DB options resource object
 */
model OptionsResource {
  /**
   * Value of the Cosmos DB resource throughput or autoscaleSettings. Use the ThroughputSetting resource when retrieving offer details.
   */
  throughput?: int32;

  /**
   * Specifies the Autoscale settings.
   */
  autoscaleSettings?: AutoscaleSettings;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AutoscaleSettings {
  /**
   * Represents maximum throughput, the resource can scale up to.
   */
  maxThroughput?: int32;
}

/**
 * Parameters to create and update Cosmos DB Graph resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GraphResourceCreateUpdateParameters extends ARMResourceProperties {
  /**
   * Properties to create and update Azure Cosmos DB Graph resource.
   */
  properties: GraphResourceCreateUpdateProperties;
}

/**
 * Properties to create and update Azure Cosmos DB Graph resource.
 */
model GraphResourceCreateUpdateProperties {
  /**
   * The standard JSON format of a Graph resource
   */
  resource: GraphResource;

  /**
   * A key-value pair of options to be applied for the request. This corresponds to the headers sent with the request.
   */
  options?: CreateUpdateOptions;
}

/**
 * CreateUpdateOptions are a list of key-value pairs that describe the resource. Supported keys are "If-Match", "If-None-Match", "Session-Token" and "Throughput"
 */
model CreateUpdateOptions {
  /**
   * Request Units per second. For example, "throughput": 10000.
   */
  throughput?: int32;

  /**
   * Specifies the Autoscale settings. Note: Either throughput or autoscaleSettings is required, but not both.
   */
  autoscaleSettings?: AutoscaleSettings;
}

/**
 * The List operation response, that contains the SQL databases and their properties.
 */
model SqlDatabaseListResult {
  /**
   * List of SQL databases and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: SqlDatabaseGetResults[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The properties of an Azure Cosmos DB SQL database
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlDatabaseGetProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource?: SqlDatabaseGetPropertiesResource;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  options?: SqlDatabaseGetPropertiesOptions;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlDatabaseGetPropertiesResource {
  ...SqlDatabaseResource;
  ...ExtendedResourceProperties;

  /**
   * A system generated property that specified the addressable path of the collections resource.
   */
  _colls?: string;

  /**
   * A system generated property that specifies the addressable path of the users resource.
   */
  _users?: string;
}

/**
 * Cosmos DB SQL database resource object
 */
model SqlDatabaseResource {
  /**
   * Name of the Cosmos DB SQL database
   */
  id: string;

  /**
   * Parameters to indicate the information about the restore
   */
  restoreParameters?: ResourceRestoreParameters;

  /**
   * Enum to indicate the mode of account creation.
   */
  createMode?: CreateMode = CreateMode.Default;
}

/**
 * Parameters to indicate the information about the restore.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceRestoreParameters extends RestoreParametersBase {}

/**
 * The system generated resource properties associated with SQL databases, SQL containers, Gremlin databases and Gremlin graphs.
 */
model ExtendedResourceProperties {
  /**
   * A system generated property. A unique identifier.
   */
  @visibility(Lifecycle.Read)
  _rid?: string;

  /**
   * A system generated property that denotes the last updated timestamp of the resource.
   */
  @visibility(Lifecycle.Read)
  _ts?: float32;

  /**
   * A system generated property representing the resource etag required for optimistic concurrency control.
   */
  @visibility(Lifecycle.Read)
  _etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlDatabaseGetPropertiesOptions extends OptionsResource {}

/**
 * Parameters to create and update Cosmos DB SQL database.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlDatabaseCreateUpdateParameters extends ARMResourceProperties {
  /**
   * Properties to create and update Azure Cosmos DB SQL database.
   */
  properties: SqlDatabaseCreateUpdateProperties;
}

/**
 * Properties to create and update Azure Cosmos DB SQL database.
 */
model SqlDatabaseCreateUpdateProperties {
  /**
   * The standard JSON format of a SQL database
   */
  resource: SqlDatabaseResource;

  /**
   * A key-value pair of options to be applied for the request. This corresponds to the headers sent with the request.
   */
  options?: CreateUpdateOptions;
}

/**
 * The properties of an Azure Cosmos DB resource throughput
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ThroughputSettingsGetProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource?: ThroughputSettingsGetPropertiesResource;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ThroughputSettingsGetPropertiesResource {
  ...ThroughputSettingsResource;
  ...ExtendedResourceProperties;
}

/**
 * Cosmos DB resource throughput object. Either throughput is required or autoscaleSettings is required, but not both.
 */
model ThroughputSettingsResource {
  /**
   * Value of the Cosmos DB resource throughput. Either throughput is required or autoscaleSettings is required, but not both.
   */
  throughput?: int32;

  /**
   * Cosmos DB resource for autoscale settings. Either throughput is required or autoscaleSettings is required, but not both.
   */
  autoscaleSettings?: AutoscaleSettingsResource;

  /**
   * The minimum throughput of the resource
   */
  @visibility(Lifecycle.Read)
  minimumThroughput?: string;

  /**
   * The throughput replace is pending
   */
  @visibility(Lifecycle.Read)
  offerReplacePending?: string;

  /**
   * The offer throughput value to instantly scale up without triggering splits
   */
  @visibility(Lifecycle.Read)
  instantMaximumThroughput?: string;

  /**
   * The maximum throughput value or the maximum maxThroughput value (for autoscale) that can be specified
   */
  @visibility(Lifecycle.Read)
  softAllowedMaximumThroughput?: string;

  /**
   * Array of Throughput Bucket limits to be applied to the Cosmos DB container
   */
  throughputBuckets?: ThroughputBucketResource[];
}

/**
 * Cosmos DB provisioned throughput settings object
 */
model AutoscaleSettingsResource {
  /**
   * Represents maximum throughput container can scale up to.
   */
  maxThroughput: int32;

  /**
   * Cosmos DB resource auto-upgrade policy
   */
  autoUpgradePolicy?: AutoUpgradePolicyResource;

  /**
   * Represents target maximum throughput container can scale up to once offer is no longer in pending state.
   */
  @visibility(Lifecycle.Read)
  targetMaxThroughput?: int32;
}

/**
 * Cosmos DB resource auto-upgrade policy
 */
model AutoUpgradePolicyResource {
  /**
   * Represents throughput policy which service must adhere to for auto-upgrade
   */
  throughputPolicy?: ThroughputPolicyResource;
}

/**
 * Cosmos DB resource throughput policy
 */
model ThroughputPolicyResource {
  /**
   * Determines whether the ThroughputPolicy is active or not
   */
  isEnabled?: boolean;

  /**
   * Represents the percentage by which throughput can increase every time throughput policy kicks in.
   */
  incrementPercent?: int32;
}

/**
 * Cosmos DB throughput bucket object
 */
model ThroughputBucketResource {
  /**
   * Represents the throughput bucket id
   */
  id: int32;

  /**
   * Represents maximum percentage throughput that can be used by the bucket
   */
  maxThroughputPercentage: int32;
}

/**
 * Parameters to update Cosmos DB resource throughput.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ThroughputSettingsUpdateParameters extends ARMResourceProperties {
  /**
   * Properties to update Azure Cosmos DB resource throughput.
   */
  properties: ThroughputSettingsUpdateProperties;
}

/**
 * Properties to update Azure Cosmos DB resource throughput.
 */
model ThroughputSettingsUpdateProperties {
  /**
   * The standard JSON format of a resource throughput
   */
  resource: ThroughputSettingsResource;
}

/**
 * The List operation response, that contains the client encryption keys and their properties.
 */
model ClientEncryptionKeysListResult {
  /**
   * List of client encryption keys and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: ClientEncryptionKeyGetResults[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The properties of a ClientEncryptionKey resource
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ClientEncryptionKeyGetProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource?: ClientEncryptionKeyGetPropertiesResource;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ClientEncryptionKeyGetPropertiesResource {
  ...ClientEncryptionKeyResource;
  ...ExtendedResourceProperties;
}

/**
 * Cosmos DB client encryption key resource object.
 */
model ClientEncryptionKeyResource {
  /**
   * Name of the ClientEncryptionKey
   */
  id?: string;

  /**
   * Encryption algorithm that will be used along with this client encryption key to encrypt/decrypt data.
   */
  encryptionAlgorithm?: string;

  /**
   * Wrapped (encrypted) form of the key represented as a byte array.
   */
  wrappedDataEncryptionKey?: bytes;

  /**
   * Metadata for the wrapping provider that can be used to unwrap the wrapped client encryption key.
   */
  keyWrapMetadata?: KeyWrapMetadata;
}

/**
 * Represents key wrap metadata that a key wrapping provider can use to wrap/unwrap a client encryption key.
 */
model KeyWrapMetadata {
  /**
   * The name of associated KeyEncryptionKey (aka CustomerManagedKey).
   */
  name?: string;

  /**
   * ProviderName of KeyStoreProvider.
   */
  type?: string;

  /**
   * Reference / link to the KeyEncryptionKey.
   */
  value?: string;

  /**
   * Algorithm used in wrapping and unwrapping of the data encryption key.
   */
  algorithm?: string;
}

/**
 * Parameters to create and update ClientEncryptionKey.
 */
model ClientEncryptionKeyCreateUpdateParameters {
  /**
   * Properties to create and update ClientEncryptionKey.
   */
  properties: ClientEncryptionKeyCreateUpdateProperties;
}

/**
 * Properties to create and update ClientEncryptionKey.
 */
model ClientEncryptionKeyCreateUpdateProperties {
  /**
   * The standard JSON format of a ClientEncryptionKey
   */
  resource: ClientEncryptionKeyResource;
}

/**
 * The List operation response, that contains the containers and their properties.
 */
model SqlContainerListResult {
  /**
   * List of containers and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: SqlContainerGetResults[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The properties of an Azure Cosmos DB container
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlContainerGetProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource?: SqlContainerGetPropertiesResource;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  options?: SqlContainerGetPropertiesOptions;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlContainerGetPropertiesResource {
  ...SqlContainerResource;
  ...ExtendedResourceProperties;
}

/**
 * Cosmos DB SQL container resource object
 */
model SqlContainerResource {
  /**
   * Name of the Cosmos DB SQL container
   */
  id: string;

  /**
   * The configuration of the indexing policy. By default, the indexing is automatic for all document paths within the container
   */
  indexingPolicy?: IndexingPolicy;

  /**
   * The configuration of the partition key to be used for partitioning data into multiple partitions
   */
  partitionKey?: ContainerPartitionKey;

  /**
   * Default time to live
   */
  defaultTtl?: int32;

  /**
   * The unique key policy configuration for specifying uniqueness constraints on documents in the collection in the Azure Cosmos DB service.
   */
  uniqueKeyPolicy?: UniqueKeyPolicy;

  /**
   * The conflict resolution policy for the container.
   */
  conflictResolutionPolicy?: ConflictResolutionPolicy;

  /**
   * The client encryption policy for the container.
   */
  clientEncryptionPolicy?: ClientEncryptionPolicy;

  /**
   * Analytical TTL.
   */
  analyticalStorageTtl?: int64;

  /**
   * Parameters to indicate the information about the restore
   */
  restoreParameters?: ResourceRestoreParameters;

  /**
   * Enum to indicate the mode of account creation.
   */
  createMode?: CreateMode = CreateMode.Default;

  /**
   * The configuration for defining Materialized Views. This must be specified only for creating a Materialized View container.
   */
  materializedViewDefinition?: MaterializedViewDefinition;

  /**
   * Materialized Views defined on the container.
   */
  materializedViews?: MaterializedViewDetails[];

  /**
   * List of computed properties
   */
  computedProperties?: ComputedProperty[];

  /**
   * The vector embedding policy for the container.
   */
  vectorEmbeddingPolicy?: VectorEmbeddingPolicy;

  /**
   * The FullText policy for the container.
   */
  fullTextPolicy?: FullTextPolicy;
}

/**
 * Cosmos DB indexing policy
 */
model IndexingPolicy {
  /**
   * Indicates if the indexing policy is automatic
   */
  automatic?: boolean;

  /**
   * Indicates the indexing mode.
   */
  indexingMode?: IndexingMode = IndexingMode.Consistent;

  /**
   * List of paths to include in the indexing
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  includedPaths?: IncludedPath[];

  /**
   * List of paths to exclude from indexing
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  excludedPaths?: ExcludedPath[];

  /**
   * List of composite path list
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  compositeIndexes?: CompositePath[][];

  /**
   * List of spatial specifics
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  spatialIndexes?: SpatialSpec[];

  /**
   * List of paths to include in the vector indexing
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  vectorIndexes?: VectorIndex[];
}

/**
 * The paths that are included in indexing
 */
model IncludedPath {
  /**
   * The path for which the indexing behavior applies to. Index paths typically start with root and end with wildcard (/path/*)
   */
  path?: string;

  /**
   * List of indexes for this path
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  indexes?: Indexes[];
}

/**
 * The indexes for the path.
 */
model Indexes {
  /**
   * The datatype for which the indexing behavior is applied to.
   */
  dataType?: DataType = DataType.String;

  /**
   * The precision of the index. -1 is maximum precision.
   */
  precision?: int32;

  /**
   * Indicates the type of index.
   */
  kind?: IndexKind = IndexKind.Hash;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ExcludedPath {
  /**
   * The path for which the indexing behavior applies to. Index paths typically start with root and end with wildcard (/path/*)
   */
  path?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CompositePath {
  /**
   * The path for which the indexing behavior applies to. Index paths typically start with root and end with wildcard (/path/*)
   */
  path?: string;

  /**
   * Sort order for composite paths.
   */
  order?: CompositePathSortOrder;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SpatialSpec {
  /**
   * The path for which the indexing behavior applies to. Index paths typically start with root and end with wildcard (/path/*)
   */
  path?: string;

  /**
   * List of path's spatial type
   */
  types?: SpatialType[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VectorIndex {
  /**
   * The path to the vector field in the document.
   */
  path: string;

  /**
   * The index type of the vector. Currently, flat, diskANN, and quantizedFlat are supported.
   */
  type: VectorIndexType;
}

/**
 * The configuration of the partition key to be used for partitioning data into multiple partitions
 */
model ContainerPartitionKey {
  /**
   * List of paths using which data within the container can be partitioned
   */
  paths?: string[];

  /**
   * Indicates the kind of algorithm used for partitioning. For MultiHash, multiple partition keys (upto three maximum) are supported for container create
   */
  kind?: PartitionKind = PartitionKind.Hash;

  /**
   * Indicates the version of the partition key definition
   */
  @maxValue(2)
  @minValue(1)
  version?: int32;

  /**
   * Indicates if the container is using a system generated partition key
   */
  @visibility(Lifecycle.Read)
  systemKey?: boolean;
}

/**
 * The unique key policy configuration for specifying uniqueness constraints on documents in the collection in the Azure Cosmos DB service.
 */
model UniqueKeyPolicy {
  /**
   * List of unique keys on that enforces uniqueness constraint on documents in the collection in the Azure Cosmos DB service.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  uniqueKeys?: UniqueKey[];
}

/**
 * The unique key on that enforces uniqueness constraint on documents in the collection in the Azure Cosmos DB service.
 */
model UniqueKey {
  /**
   * List of paths must be unique for each document in the Azure Cosmos DB service
   */
  paths?: string[];
}

/**
 * The conflict resolution policy for the container.
 */
model ConflictResolutionPolicy {
  /**
   * Indicates the conflict resolution mode.
   */
  mode?: ConflictResolutionMode = ConflictResolutionMode.LastWriterWins;

  /**
   * The conflict resolution path in the case of LastWriterWins mode.
   */
  conflictResolutionPath?: string;

  /**
   * The procedure to resolve conflicts in the case of custom mode.
   */
  conflictResolutionProcedure?: string;
}

/**
 * Cosmos DB client encryption policy.
 */
model ClientEncryptionPolicy {
  /**
   * Paths of the item that need encryption along with path-specific settings.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  includedPaths: ClientEncryptionIncludedPath[];

  /**
   * Version of the client encryption policy definition. Supported versions are 1 and 2. Version 2 supports id and partition key path encryption.
   */
  @maxValue(2)
  @minValue(1)
  policyFormatVersion: int32;
}

/**
 * .
 */
model ClientEncryptionIncludedPath {
  /**
   * Path that needs to be encrypted.
   */
  path: string;

  /**
   * The identifier of the Client Encryption Key to be used to encrypt the path.
   */
  clientEncryptionKeyId: string;

  /**
   * The type of encryption to be performed. Eg - Deterministic, Randomized.
   */
  encryptionType: string;

  /**
   * The encryption algorithm which will be used. Eg - AEAD_AES_256_CBC_HMAC_SHA256.
   */
  encryptionAlgorithm: string;
}

/**
 * Materialized View definition for the container.
 */
model MaterializedViewDefinition {
  /**
   * An unique identifier for the source collection. This is a system generated property.
   */
  @visibility(Lifecycle.Read)
  sourceCollectionRid?: string;

  /**
   * The name of the source container on which the Materialized View will be created.
   */
  sourceCollectionId: string;

  /**
   * The definition should be an SQL query which would be used to fetch data from the source container to populate into the Materialized View container.
   */
  definition: string;
}

/**
 * MaterializedViewDetails, contains Id & _rid fields of materialized view.
 */
model MaterializedViewDetails {
  /**
   * Id field of Materialized container.
   */
  id?: string;

  /**
   * _rid field of Materialized container.
   */
  _rid?: string;
}

/**
 * The definition of a computed property
 */
model ComputedProperty {
  /**
   * The name of a computed property, for example - "cp_lowerName"
   */
  name?: string;

  /**
   * The query that evaluates the value for computed property, for example - "SELECT VALUE LOWER(c.name) FROM c"
   */
  query?: string;
}

/**
 * Cosmos DB Vector Embedding Policy
 */
model VectorEmbeddingPolicy {
  /**
   * List of vector embeddings
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  vectorEmbeddings?: VectorEmbedding[];
}

/**
 * Represents a vector embedding. A vector embedding is used to define a vector field in the documents.
 */
model VectorEmbedding {
  /**
   * The path to the vector field in the document.
   */
  path: string;

  /**
   * Indicates the data type of vector.
   */
  dataType: VectorDataType;

  /**
   * The distance function to use for distance calculation in between vectors.
   */
  distanceFunction: DistanceFunction;

  /**
   * The number of dimensions in the vector.
   */
  dimensions: int32;
}

/**
 * Cosmos DB FullText Policy
 */
model FullTextPolicy {
  /**
   * The default language for a full text paths.
   */
  defaultLanguage?: string;

  /**
   * List of FullText Paths
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  fullTextPaths?: FullTextPath[];
}

/**
 * Represents the full text path specification.
 */
model FullTextPath {
  /**
   * The path to the full text field in the document.
   */
  path: string;

  /**
   * The language of the full text field in the document.
   */
  language?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlContainerGetPropertiesOptions extends OptionsResource {}

/**
 * Parameters to create and update Cosmos DB container.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlContainerCreateUpdateParameters extends ARMResourceProperties {
  /**
   * Properties to create and update Azure Cosmos DB container.
   */
  properties: SqlContainerCreateUpdateProperties;
}

/**
 * Properties to create and update Azure Cosmos DB container.
 */
model SqlContainerCreateUpdateProperties {
  /**
   * The standard JSON format of a container
   */
  resource: SqlContainerResource;

  /**
   * A key-value pair of options to be applied for the request. This corresponds to the headers sent with the request.
   */
  options?: CreateUpdateOptions;
}

/**
 * The properties of an Azure Cosmos DB merge operations
 */
model MergeParameters {
  /**
   * Specifies whether the operation is a real merge operation or a simulation.
   */
  isDryRun?: boolean;
}

/**
 * List of physical partitions and their properties returned by a merge operation.
 */
model PhysicalPartitionStorageInfoCollection {
  /**
   * List of physical partitions and their properties.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  physicalPartitionStorageInfoCollection?: physicalPartitionStorageInfo[];
}

/**
 * The storage of a physical partition
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model physicalPartitionStorageInfo {
  /**
   * The unique identifier of the partition.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The storage in KB for the physical partition.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  storageInKB?: float64;
}

/**
 * Cosmos DB retrieve throughput parameters object
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RetrieveThroughputParameters extends ARMResourceProperties {
  /**
   * Properties to retrieve throughput parameters object
   */
  properties: RetrieveThroughputProperties;
}

/**
 * Properties to retrieve throughput for Azure Cosmos DB resource.
 */
model RetrieveThroughputProperties {
  /**
   * The standard JSON format of a resource throughput
   */
  resource: RetrieveThroughputPropertiesResource;
}

/**
 * Resource to retrieve throughput information for Cosmos DB resource
 */
model RetrieveThroughputPropertiesResource {
  /**
   * Array of PhysicalPartitionId objects.
   */
  physicalPartitionIds: PhysicalPartitionId[];
}

/**
 * PhysicalPartitionId object
 */
model PhysicalPartitionId {
  /**
   * Id of a physical partition
   */
  id: string;
}

/**
 * An Azure Cosmos DB PhysicalPartitionThroughputInfoResult object.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PhysicalPartitionThroughputInfoResult extends ARMResourceProperties {
  /**
   * The properties of an Azure Cosmos DB PhysicalPartitionThroughputInfoResult object
   */
  properties?: PhysicalPartitionThroughputInfoResultProperties;
}

/**
 * The properties of an Azure Cosmos DB PhysicalPartitionThroughputInfoResult object
 */
model PhysicalPartitionThroughputInfoResultProperties {
  /**
   * properties of physical partition throughput info
   */
  resource?: PhysicalPartitionThroughputInfoResultPropertiesResource;
}

/**
 * properties of physical partition throughput info
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PhysicalPartitionThroughputInfoResultPropertiesResource
  extends PhysicalPartitionThroughputInfoProperties {}

/**
 * The properties of an Azure Cosmos DB PhysicalPartitionThroughputInfoProperties object
 */
model PhysicalPartitionThroughputInfoProperties {
  /**
   * Array of physical partition throughput info objects
   */
  physicalPartitionThroughputInfo?: PhysicalPartitionThroughputInfoResource[];
}

/**
 * PhysicalPartitionThroughputInfo object
 */
model PhysicalPartitionThroughputInfoResource {
  /**
   * Id of a physical partition
   */
  id: string;

  /**
   * Throughput of a physical partition
   */
  throughput?: float64;

  /**
   * Target throughput of a physical partition
   */
  targetThroughput?: float64;
}

/**
 * Cosmos DB redistribute throughput parameters object
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RedistributeThroughputParameters extends ARMResourceProperties {
  /**
   * Properties to redistribute throughput parameters object
   */
  properties: RedistributeThroughputProperties;
}

/**
 * Properties to redistribute throughput for Azure Cosmos DB resource.
 */
model RedistributeThroughputProperties {
  /**
   * The standard JSON format of a resource throughput
   */
  resource: RedistributeThroughputPropertiesResource;
}

/**
 * Resource to redistribute throughput for Azure Cosmos DB resource
 */
model RedistributeThroughputPropertiesResource {
  /**
   * ThroughputPolicy to apply for throughput redistribution
   */
  throughputPolicy: ThroughputPolicyType;

  /**
   * Array of PhysicalPartitionThroughputInfoResource objects.
   */
  targetPhysicalPartitionThroughputInfo: PhysicalPartitionThroughputInfoResource[];

  /**
   * Array of PhysicalPartitionThroughputInfoResource objects.
   */
  sourcePhysicalPartitionThroughputInfo: PhysicalPartitionThroughputInfoResource[];
}

/**
 * The List operation response, that contains the storedProcedures and their properties.
 */
model SqlStoredProcedureListResult {
  /**
   * List of storedProcedures and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: SqlStoredProcedureGetResults[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The properties of an Azure Cosmos DB StoredProcedure
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlStoredProcedureGetProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource?: SqlStoredProcedureGetPropertiesResource;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlStoredProcedureGetPropertiesResource {
  ...SqlStoredProcedureResource;
  ...ExtendedResourceProperties;
}

/**
 * Cosmos DB SQL storedProcedure resource object
 */
model SqlStoredProcedureResource {
  /**
   * Name of the Cosmos DB SQL storedProcedure
   */
  id: string;

  /**
   * Body of the Stored Procedure
   */
  body?: string;
}

/**
 * Parameters to create and update Cosmos DB storedProcedure.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlStoredProcedureCreateUpdateParameters extends ARMResourceProperties {
  /**
   * Properties to create and update Azure Cosmos DB storedProcedure.
   */
  properties: SqlStoredProcedureCreateUpdateProperties;
}

/**
 * Properties to create and update Azure Cosmos DB storedProcedure.
 */
model SqlStoredProcedureCreateUpdateProperties {
  /**
   * The standard JSON format of a storedProcedure
   */
  resource: SqlStoredProcedureResource;

  /**
   * A key-value pair of options to be applied for the request. This corresponds to the headers sent with the request.
   */
  options?: CreateUpdateOptions;
}

/**
 * The List operation response, that contains the userDefinedFunctions and their properties.
 */
model SqlUserDefinedFunctionListResult {
  /**
   * List of userDefinedFunctions and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: SqlUserDefinedFunctionGetResults[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The properties of an Azure Cosmos DB userDefinedFunction
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlUserDefinedFunctionGetProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource?: SqlUserDefinedFunctionGetPropertiesResource;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlUserDefinedFunctionGetPropertiesResource {
  ...SqlUserDefinedFunctionResource;
  ...ExtendedResourceProperties;
}

/**
 * Cosmos DB SQL userDefinedFunction resource object
 */
model SqlUserDefinedFunctionResource {
  /**
   * Name of the Cosmos DB SQL userDefinedFunction
   */
  id: string;

  /**
   * Body of the User Defined Function
   */
  body?: string;
}

/**
 * Parameters to create and update Cosmos DB userDefinedFunction.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlUserDefinedFunctionCreateUpdateParameters
  extends ARMResourceProperties {
  /**
   * Properties to create and update Azure Cosmos DB userDefinedFunction.
   */
  properties: SqlUserDefinedFunctionCreateUpdateProperties;
}

/**
 * Properties to create and update Azure Cosmos DB userDefinedFunction.
 */
model SqlUserDefinedFunctionCreateUpdateProperties {
  /**
   * The standard JSON format of a userDefinedFunction
   */
  resource: SqlUserDefinedFunctionResource;

  /**
   * A key-value pair of options to be applied for the request. This corresponds to the headers sent with the request.
   */
  options?: CreateUpdateOptions;
}

/**
 * The List operation response, that contains the triggers and their properties.
 */
model SqlTriggerListResult {
  /**
   * List of triggers and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: SqlTriggerGetResults[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The properties of an Azure Cosmos DB trigger
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlTriggerGetProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource?: SqlTriggerGetPropertiesResource;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlTriggerGetPropertiesResource {
  ...SqlTriggerResource;
  ...ExtendedResourceProperties;
}

/**
 * Cosmos DB SQL trigger resource object
 */
model SqlTriggerResource {
  /**
   * Name of the Cosmos DB SQL trigger
   */
  id: string;

  /**
   * Body of the Trigger
   */
  body?: string;

  /**
   * Type of the Trigger
   */
  triggerType?: TriggerType;

  /**
   * The operation the trigger is associated with
   */
  triggerOperation?: TriggerOperation;
}

/**
 * Parameters to create and update Cosmos DB trigger.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlTriggerCreateUpdateParameters extends ARMResourceProperties {
  /**
   * Properties to create and update Azure Cosmos DB trigger.
   */
  properties: SqlTriggerCreateUpdateProperties;
}

/**
 * Properties to create and update Azure Cosmos DB trigger.
 */
model SqlTriggerCreateUpdateProperties {
  /**
   * The standard JSON format of a trigger
   */
  resource: SqlTriggerResource;

  /**
   * A key-value pair of options to be applied for the request. This corresponds to the headers sent with the request.
   */
  options?: CreateUpdateOptions;
}

/**
 * The List operation response, that contains the MongoDB databases and their properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoDBDatabaseListResult {
  /**
   * List of MongoDB databases and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: MongoDBDatabaseGetResults[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The properties of an Azure Cosmos DB MongoDB database
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoDBDatabaseGetProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource?: MongoDBDatabaseGetPropertiesResource;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  options?: MongoDBDatabaseGetPropertiesOptions;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoDBDatabaseGetPropertiesResource {
  ...MongoDBDatabaseResource;
  ...ExtendedResourceProperties;
}

/**
 * Cosmos DB MongoDB database resource object
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoDBDatabaseResource {
  /**
   * Name of the Cosmos DB MongoDB database
   */
  id: string;

  /**
   * Parameters to indicate the information about the restore
   */
  restoreParameters?: ResourceRestoreParameters;

  /**
   * Enum to indicate the mode of account creation.
   */
  createMode?: CreateMode = CreateMode.Default;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoDBDatabaseGetPropertiesOptions extends OptionsResource {}

/**
 * Parameters to create and update Cosmos DB MongoDB database.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoDBDatabaseCreateUpdateParameters extends ARMResourceProperties {
  /**
   * Properties to create and update Azure Cosmos DB MongoDB database.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties: MongoDBDatabaseCreateUpdateProperties;
}

/**
 * Properties to create and update Azure Cosmos DB MongoDB database.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoDBDatabaseCreateUpdateProperties {
  /**
   * The standard JSON format of a MongoDB database
   */
  resource: MongoDBDatabaseResource;

  /**
   * A key-value pair of options to be applied for the request. This corresponds to the headers sent with the request.
   */
  options?: CreateUpdateOptions;
}

/**
 * The List operation response, that contains the MongoDB collections and their properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoDBCollectionListResult {
  /**
   * List of MongoDB collections and their properties.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @pageItems
  value?: MongoDBCollectionGetResults[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The properties of an Azure Cosmos DB MongoDB collection
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoDBCollectionGetProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource?: MongoDBCollectionGetPropertiesResource;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  options?: MongoDBCollectionGetPropertiesOptions;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoDBCollectionGetPropertiesResource {
  ...MongoDBCollectionResource;
  ...ExtendedResourceProperties;
}

/**
 * Cosmos DB MongoDB collection resource object
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoDBCollectionResource {
  /**
   * Name of the Cosmos DB MongoDB collection
   */
  id: string;

  /**
   * A key-value pair of shard keys to be applied for the request.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  shardKey?: Record<string>;

  /**
   * List of index keys
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  indexes?: MongoIndex[];

  /**
   * Analytical TTL.
   */
  analyticalStorageTtl?: int32;

  /**
   * Parameters to indicate the information about the restore
   */
  restoreParameters?: ResourceRestoreParameters;

  /**
   * Enum to indicate the mode of resource creation.
   */
  createMode?: CreateMode = CreateMode.Default;
}

/**
 * Cosmos DB MongoDB collection index key
 */
model MongoIndex {
  /**
   * Cosmos DB MongoDB collection index keys
   */
  key?: MongoIndexKeys;

  /**
   * Cosmos DB MongoDB collection index key options
   */
  options?: MongoIndexOptions;
}

/**
 * Cosmos DB MongoDB collection resource object
 */
model MongoIndexKeys {
  /**
   * List of keys for each MongoDB collection in the Azure Cosmos DB service
   */
  keys?: string[];
}

/**
 * Cosmos DB MongoDB collection index options
 */
model MongoIndexOptions {
  /**
   * Expire after seconds
   */
  expireAfterSeconds?: int32;

  /**
   * Is unique or not
   */
  unique?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoDBCollectionGetPropertiesOptions extends OptionsResource {}

/**
 * Parameters to create and update Cosmos DB MongoDB collection.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoDBCollectionCreateUpdateParameters extends ARMResourceProperties {
  /**
   * Properties to create and update Azure Cosmos DB MongoDB collection.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties: MongoDBCollectionCreateUpdateProperties;
}

/**
 * Properties to create and update Azure Cosmos DB MongoDB collection.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoDBCollectionCreateUpdateProperties {
  /**
   * The standard JSON format of a MongoDB collection
   */
  resource: MongoDBCollectionResource;

  /**
   * A key-value pair of options to be applied for the request. This corresponds to the headers sent with the request.
   */
  options?: CreateUpdateOptions;
}

/**
 * The List operation response, that contains the Table and their properties.
 */
model TableListResult {
  /**
   * List of Table and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: TableGetResults[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The properties of an Azure Cosmos Table
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TableGetProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource?: TableGetPropertiesResource;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  options?: TableGetPropertiesOptions;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TableGetPropertiesResource {
  ...TableResource;
  ...ExtendedResourceProperties;
}

/**
 * Cosmos DB table resource object
 */
model TableResource {
  /**
   * Name of the Cosmos DB table
   */
  id: string;

  /**
   * Parameters to indicate the information about the restore
   */
  restoreParameters?: ResourceRestoreParameters;

  /**
   * Enum to indicate the mode of account creation.
   */
  createMode?: CreateMode = CreateMode.Default;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TableGetPropertiesOptions extends OptionsResource {}

/**
 * Parameters to create and update Cosmos DB Table.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TableCreateUpdateParameters extends ARMResourceProperties {
  /**
   * Properties to create and update Azure Cosmos DB Table.
   */
  properties: TableCreateUpdateProperties;
}

/**
 * Properties to create and update Azure Cosmos DB Table.
 */
model TableCreateUpdateProperties {
  /**
   * The standard JSON format of a Table
   */
  resource: TableResource;

  /**
   * A key-value pair of options to be applied for the request. This corresponds to the headers sent with the request.
   */
  options?: CreateUpdateOptions;
}

/**
 * The List operation response, that contains the Cassandra keyspaces and their properties.
 */
model CassandraKeyspaceListResult {
  /**
   * List of Cassandra keyspaces and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: CassandraKeyspaceGetResults[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The properties of an Azure Cosmos DB Cassandra keyspace
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CassandraKeyspaceGetProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource?: CassandraKeyspaceGetPropertiesResource;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  options?: CassandraKeyspaceGetPropertiesOptions;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CassandraKeyspaceGetPropertiesResource {
  ...CassandraKeyspaceResource;
  ...ExtendedResourceProperties;
}

/**
 * Cosmos DB Cassandra keyspace resource object
 */
model CassandraKeyspaceResource {
  /**
   * Name of the Cosmos DB Cassandra keyspace
   */
  id: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CassandraKeyspaceGetPropertiesOptions extends OptionsResource {}

/**
 * Parameters to create and update Cosmos DB Cassandra keyspace.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CassandraKeyspaceCreateUpdateParameters extends ARMResourceProperties {
  /**
   * Properties to create and update Azure Cosmos DB Cassandra keyspace.
   */
  properties: CassandraKeyspaceCreateUpdateProperties;
}

/**
 * Properties to create and update Azure Cosmos DB Cassandra keyspace.
 */
model CassandraKeyspaceCreateUpdateProperties {
  /**
   * The standard JSON format of a Cassandra keyspace
   */
  resource: CassandraKeyspaceResource;

  /**
   * A key-value pair of options to be applied for the request. This corresponds to the headers sent with the request.
   */
  options?: CreateUpdateOptions;
}

/**
 * The List operation response, that contains the Cassandra tables and their properties.
 */
model CassandraTableListResult {
  /**
   * List of Cassandra tables and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: CassandraTableGetResults[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The properties of an Azure Cosmos DB Cassandra table
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CassandraTableGetProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource?: CassandraTableGetPropertiesResource;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  options?: CassandraTableGetPropertiesOptions;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CassandraTableGetPropertiesResource {
  ...CassandraTableResource;
  ...ExtendedResourceProperties;
}

/**
 * Cosmos DB Cassandra table resource object
 */
model CassandraTableResource {
  /**
   * Name of the Cosmos DB Cassandra table
   */
  id: string;

  /**
   * Time to live of the Cosmos DB Cassandra table
   */
  defaultTtl?: int32;

  /**
   * Schema of the Cosmos DB Cassandra table
   */
  schema?: CassandraSchema;

  /**
   * Analytical TTL.
   */
  analyticalStorageTtl?: int32;
}

/**
 * Cosmos DB Cassandra table schema
 */
model CassandraSchema {
  /**
   * List of Cassandra table columns.
   */
  columns?: Column[];

  /**
   * List of partition key.
   */
  partitionKeys?: CassandraPartitionKey[];

  /**
   * List of cluster key.
   */
  clusterKeys?: ClusterKey[];
}

/**
 * Cosmos DB Cassandra table column
 */
model Column {
  /**
   * Name of the Cosmos DB Cassandra table column
   */
  name?: string;

  /**
   * Type of the Cosmos DB Cassandra table column
   */
  type?: string;
}

/**
 * Cosmos DB Cassandra table partition key
 */
model CassandraPartitionKey {
  /**
   * Name of the Cosmos DB Cassandra table partition key
   */
  name?: string;
}

/**
 * Cosmos DB Cassandra table cluster key
 */
model ClusterKey {
  /**
   * Name of the Cosmos DB Cassandra table cluster key
   */
  name?: string;

  /**
   * Order of the Cosmos DB Cassandra table cluster key, only support "Asc" and "Desc"
   */
  orderBy?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CassandraTableGetPropertiesOptions extends OptionsResource {}

/**
 * Parameters to create and update Cosmos DB Cassandra table.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CassandraTableCreateUpdateParameters extends ARMResourceProperties {
  /**
   * Properties to create and update Azure Cosmos DB Cassandra table.
   */
  properties: CassandraTableCreateUpdateProperties;
}

/**
 * Properties to create and update Azure Cosmos DB Cassandra table.
 */
model CassandraTableCreateUpdateProperties {
  /**
   * The standard JSON format of a Cassandra table
   */
  resource: CassandraTableResource;

  /**
   * A key-value pair of options to be applied for the request. This corresponds to the headers sent with the request.
   */
  options?: CreateUpdateOptions;
}

/**
 * The List operation response, that contains the Gremlin databases and their properties.
 */
model GremlinDatabaseListResult {
  /**
   * List of Gremlin databases and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: GremlinDatabaseGetResults[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The properties of an Azure Cosmos DB SQL database
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GremlinDatabaseGetProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource?: GremlinDatabaseGetPropertiesResource;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  options?: GremlinDatabaseGetPropertiesOptions;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GremlinDatabaseGetPropertiesResource {
  ...GremlinDatabaseResource;
  ...ExtendedResourceProperties;
}

/**
 * Cosmos DB Gremlin database resource object
 */
model GremlinDatabaseResource {
  /**
   * Name of the Cosmos DB Gremlin database
   */
  id: string;

  /**
   * Parameters to indicate the information about the restore
   */
  restoreParameters?: ResourceRestoreParameters;

  /**
   * Enum to indicate the mode of resource creation.
   */
  createMode?: CreateMode = CreateMode.Default;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GremlinDatabaseGetPropertiesOptions extends OptionsResource {}

/**
 * Parameters to create and update Cosmos DB Gremlin database.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GremlinDatabaseCreateUpdateParameters extends ARMResourceProperties {
  /**
   * Properties to create and update Azure Cosmos DB Gremlin database.
   */
  properties: GremlinDatabaseCreateUpdateProperties;
}

/**
 * Properties to create and update Azure Cosmos DB Gremlin database.
 */
model GremlinDatabaseCreateUpdateProperties {
  /**
   * The standard JSON format of a Gremlin database
   */
  resource: GremlinDatabaseResource;

  /**
   * A key-value pair of options to be applied for the request. This corresponds to the headers sent with the request.
   */
  options?: CreateUpdateOptions;
}

/**
 * The List operation response, that contains the graphs and their properties.
 */
model GremlinGraphListResult {
  /**
   * List of graphs and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: GremlinGraphGetResults[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The properties of an Azure Cosmos DB Gremlin graph
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GremlinGraphGetProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource?: GremlinGraphGetPropertiesResource;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  options?: GremlinGraphGetPropertiesOptions;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GremlinGraphGetPropertiesResource {
  ...GremlinGraphResource;
  ...ExtendedResourceProperties;
}

/**
 * Cosmos DB Gremlin graph resource object
 */
model GremlinGraphResource {
  /**
   * Name of the Cosmos DB Gremlin graph
   */
  id: string;

  /**
   * The configuration of the indexing policy. By default, the indexing is automatic for all document paths within the graph
   */
  indexingPolicy?: IndexingPolicy;

  /**
   * The configuration of the partition key to be used for partitioning data into multiple partitions
   */
  partitionKey?: ContainerPartitionKey;

  /**
   * Default time to live
   */
  defaultTtl?: int32;

  /**
   * The unique key policy configuration for specifying uniqueness constraints on documents in the collection in the Azure Cosmos DB service.
   */
  uniqueKeyPolicy?: UniqueKeyPolicy;

  /**
   * The conflict resolution policy for the graph.
   */
  conflictResolutionPolicy?: ConflictResolutionPolicy;

  /**
   * Analytical TTL.
   */
  analyticalStorageTtl?: int64;

  /**
   * Parameters to indicate the information about the restore
   */
  restoreParameters?: ResourceRestoreParameters;

  /**
   * Enum to indicate the mode of resource creation.
   */
  createMode?: CreateMode = CreateMode.Default;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GremlinGraphGetPropertiesOptions extends OptionsResource {}

/**
 * Parameters to create and update Cosmos DB Gremlin graph.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GremlinGraphCreateUpdateParameters extends ARMResourceProperties {
  /**
   * Properties to create and update Azure Cosmos DB Gremlin graph.
   */
  properties: GremlinGraphCreateUpdateProperties;
}

/**
 * Properties to create and update Azure Cosmos DB Gremlin graph.
 */
model GremlinGraphCreateUpdateProperties {
  /**
   * The standard JSON format of a Gremlin graph
   */
  resource: GremlinGraphResource;

  /**
   * A key-value pair of options to be applied for the request. This corresponds to the headers sent with the request.
   */
  options?: CreateUpdateOptions;
}

/**
 * The List operation response, that contains Cosmos DB locations and their properties.
 */
model LocationListResult {
  /**
   * List of Cosmos DB locations and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: LocationGetResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * Cosmos DB location metadata
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocationProperties {
  /**
   * Flag indicating whether the location supports availability zones or not.
   */
  @visibility(Lifecycle.Read)
  supportsAvailabilityZone?: boolean;

  /**
   * Flag indicating whether the location is residency sensitive.
   */
  @visibility(Lifecycle.Read)
  isResidencyRestricted?: boolean;

  /**
   * The properties of available backup storage redundancies.
   */
  @visibility(Lifecycle.Read)
  backupStorageRedundancies?: BackupStorageRedundancy[];

  /**
   * Flag indicating whether the subscription have access in region for Non-Availability Zones.
   */
  @visibility(Lifecycle.Read)
  isSubscriptionRegionAccessAllowedForRegular?: boolean;

  /**
   * Flag indicating whether the subscription have access in region for Availability Zones(Az).
   */
  @visibility(Lifecycle.Read)
  isSubscriptionRegionAccessAllowedForAz?: boolean;

  /**
   * Enum to indicate current buildout status of the region.
   */
  @visibility(Lifecycle.Read)
  status?: Status;
}

/**
 * The List operation response, that contains the Cassandra views and their properties.
 */
model CassandraViewListResult {
  /**
   * List of Cassandra views and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: CassandraViewGetResults[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The properties of an Azure Cosmos DB Cassandra view
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CassandraViewGetProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource?: CassandraViewGetPropertiesResource;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  options?: CassandraViewGetPropertiesOptions;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CassandraViewGetPropertiesResource {
  ...CassandraViewResource;
  ...ExtendedResourceProperties;
}

/**
 * Cosmos DB Cassandra view resource object
 */
model CassandraViewResource {
  /**
   * Name of the Cosmos DB Cassandra view
   */
  id: string;

  /**
   * View Definition of the Cosmos DB Cassandra view
   */
  viewDefinition: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CassandraViewGetPropertiesOptions extends OptionsResource {}

/**
 * Parameters to create and update Cosmos DB Cassandra view.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CassandraViewCreateUpdateParameters extends ARMResourceProperties {
  /**
   * Properties to create and update Azure Cosmos DB Cassandra view.
   */
  properties: CassandraViewCreateUpdateProperties;
}

/**
 * Properties to create and update Azure Cosmos DB Cassandra view.
 */
model CassandraViewCreateUpdateProperties {
  /**
   * The standard JSON format of a Cassandra view
   */
  resource: CassandraViewResource;

  /**
   * A key-value pair of options to be applied for the request. This corresponds to the headers sent with the request.
   */
  options?: CreateUpdateOptions;
}

/**
 * Parameters to create Data Transfer Job
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CreateJobRequest extends ARMProxyResource {
  /**
   * Data Transfer Create Job Properties
   */
  properties: DataTransferJobProperties;
}

/**
 * The properties of a DataTransfer Job
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataTransferJobProperties {
  /**
   * Job Name
   */
  @visibility(Lifecycle.Read)
  jobName?: string;

  /**
   * Source DataStore details
   */
  source: DataTransferDataSourceSink;

  /**
   * Destination DataStore details
   */
  destination: DataTransferDataSourceSink;

  /**
   * Job Status
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Processed Count.
   */
  @visibility(Lifecycle.Read)
  processedCount?: int64;

  /**
   * Total Count.
   */
  @visibility(Lifecycle.Read)
  totalCount?: int64;

  /**
   * Last Updated Time (ISO-8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedUtcTime?: utcDateTime;

  /**
   * Worker count
   */
  @minValue(0)
  workerCount?: int32;

  /**
   * Error response for Faulted job
   */
  @visibility(Lifecycle.Read)
  error?: ErrorResponse;

  /**
   * Total Duration of Job
   */
  @visibility(Lifecycle.Read)
  duration?: string;

  /**
   * Mode of job execution
   */
  mode?: DataTransferJobMode;
}

/**
 * Base class for all DataTransfer source/sink
 */
@discriminator("component")
model DataTransferDataSourceSink {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  component: DataTransferComponent = DataTransferComponent.CosmosDBCassandra;
}

/**
 * The List operation response, that contains the Data Transfer jobs and their properties.
 */
model DataTransferJobFeedResults is Azure.Core.Page<DataTransferJobGetResults>;

/**
 * List of managed Cassandra clusters.
 */
model ListClusters {
  /**
   * Container for the array of clusters.
   */
  @pageItems
  value?: ClusterResource[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * Properties of a managed Cassandra cluster.
 */
model ClusterResourceProperties {
  /**
   * The status of the resource at the time the operation was called.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: ManagedCassandraProvisioningState;

  /**
   * To create an empty cluster, omit this field or set it to null. To restore a backup into a new cluster, set this field to the resource id of the backup.
   */
  @visibility(Lifecycle.Create)
  restoreFromBackupId?: string;

  /**
   * Resource id of a subnet that this cluster's management service should have its network interface attached to. The subnet must be routable to all subnets that will be delegated to data centers. The resource id must be of the form '/subscriptions/<subscription id>/resourceGroups/<resource group>/providers/Microsoft.Network/virtualNetworks/<virtual network>/subnets/<subnet>'
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  delegatedManagementSubnetId?: string;

  /**
   * Which version of Cassandra should this cluster converge to running (e.g., 3.11). When updated, the cluster may take some time to migrate to the new version.
   */
  cassandraVersion?: string;

  /**
   * If you need to set the clusterName property in cassandra.yaml to something besides the resource name of the cluster, set the value to use on this property.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  clusterNameOverride?: string;

  /**
   * Which authentication method Cassandra should use to authenticate clients. 'None' turns off authentication, so should not be used except in emergencies. 'Cassandra' is the default password based authentication. The default is 'Cassandra'.
   */
  authenticationMethod?: AuthenticationMethod;

  /**
   * Initial password for clients connecting as admin to the cluster. Should be changed after cluster creation. Returns null on GET. This field only applies when the authenticationMethod field is 'Cassandra'.
   */
  @visibility(Lifecycle.Create)
  @secret
  initialCassandraAdminPassword?: string;

  /**
   * Hostname or IP address where the Prometheus endpoint containing data about the managed Cassandra nodes can be reached.
   */
  prometheusEndpoint?: SeedNode;

  /**
   * Should automatic repairs run on this cluster? If omitted, this is true, and should stay true unless you are running a hybrid cluster where you are already doing your own repairs.
   */
  repairEnabled?: boolean;

  /**
   * The form of AutoReplicate that is being used by this cluster.
   */
  autoReplicate?: AutoReplicate;

  /**
   * List of TLS certificates used to authorize clients connecting to the cluster. All connections are TLS encrypted whether clientCertificates is set or not, but if clientCertificates is set, the managed Cassandra cluster will reject all connections not bearing a TLS client certificate that can be validated from one or more of the public certificates in this property.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  clientCertificates?: Certificate[];

  /**
   * List of TLS certificates used to authorize gossip from unmanaged data centers. The TLS certificates of all nodes in unmanaged data centers must be verifiable using one of the certificates provided in this property.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  externalGossipCertificates?: Certificate[];

  /**
   * List of TLS certificates that unmanaged nodes must trust for gossip with managed nodes. All managed nodes will present TLS client certificates that are verifiable using one of the certificates provided in this property.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  @visibility(Lifecycle.Read)
  gossipCertificates?: Certificate[];

  /**
   * List of IP addresses of seed nodes in unmanaged data centers. These will be added to the seed node lists of all managed nodes.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  externalSeedNodes?: SeedNode[];

  /**
   * List of IP addresses of seed nodes in the managed data centers. These should be added to the seed node lists of all unmanaged nodes.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  @visibility(Lifecycle.Read)
  seedNodes?: SeedNode[];

  /**
   * List of the data center names for unmanaged data centers in this cluster to be included in auto-replication.
   */
  externalDataCenters?: string[];

  /**
   * (Deprecated) Number of hours to wait between taking a backup of the cluster.
   */
  hoursBetweenBackups?: int32;

  /**
   * Whether the cluster and associated data centers has been deallocated.
   */
  deallocated?: boolean;

  /**
   * Whether Cassandra audit logging is enabled
   */
  cassandraAuditLoggingEnabled?: boolean;

  /**
   * Type of the cluster. If set to Production, some operations might not be permitted on cluster.
   */
  clusterType?: ClusterType;

  /**
   * Error related to resource provisioning.
   */
  provisionError?: CassandraError;

  /**
   * Extensions to be added or updated on cluster.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  extensions?: string[];

  /**
   * List of backup schedules that define when you want to back up your data.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  backupSchedules?: BackupSchedule[];

  /**
   * How the nodes in the cluster react to scheduled events
   */
  scheduledEventStrategy?: ScheduledEventStrategy;

  /**
   * How to connect to the azure services needed for running the cluster
   */
  azureConnectionMethod?: AzureConnectionType;

  /**
   * If the Connection Method is Vpn, this is the Id of the private link resource that the datacenters need to connect to.
   */
  @visibility(Lifecycle.Read)
  privateLinkResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/privateLinkServices";
    }
  ]>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SeedNode {
  /**
   * IP address of this seed node.
   */
  ipAddress?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Certificate {
  /**
   * PEM formatted public key.
   */
  pem?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CassandraError {
  /**
   * The code of error that occurred.
   */
  code?: string;

  /**
   * The message of the error.
   */
  message?: string;

  /**
   * The target resource of the error.
   */
  target?: string;

  /**
   * Additional information about the error.
   */
  additionalErrorInfo?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BackupSchedule {
  /**
   * The unique identifier of backup schedule.
   */
  scheduleName?: string;

  /**
   * The cron expression that defines when you want to back up your data.
   */
  cronExpression?: string;

  /**
   * The retention period (hours) of the backups. If you want to retain data forever, set retention to 0.
   */
  retentionInHours?: int32;
}

/**
 * The core properties of ARM resources.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedCassandraARMResourceProperties {
  /**
   * The unique resource identifier of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of Azure resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The location of the resource group to which the resource belongs.
   */
  location?: string;

  /**
   * Tags are a list of key-value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups). A maximum of 15 tags can be provided for a resource. Each tag must have a key no greater than 128 characters and value no greater than 256 characters. For example, the default experience for a template type is set with "defaultExperience": "Cassandra". Current "defaultExperience" values also include "Table", "Graph", "DocumentDB", and "MongoDB".
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Identity for the resource.
   */
  identity?: ManagedCassandraManagedServiceIdentity;
}

/**
 * Identity for the resource.
 */
model ManagedCassandraManagedServiceIdentity {
  /**
   * The object id of the identity resource.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant id of the resource.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The type of the resource.
   */
  type?: ManagedCassandraResourceIdentityType;
}

/**
 * Specification of which command to run where
 */
model CommandPostBody {
  /**
   * The command which should be run
   */
  command: string;

  /**
   * The arguments for the command to be run
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  arguments?: Record<string>;

  /**
   * IP address of the cassandra host to run the command on
   */
  host: string;

  /**
   * If true, stops cassandra before executing the command and then start it again
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `cassandra-stop-start`?: boolean;

  /**
   * If true, allows the command to *write* to the cassandra directory, otherwise read-only.
   */
  readwrite?: boolean;
}

/**
 * Response of /command api
 */
model CommandOutput {
  /**
   * Output of the command.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  commandOutput?: string;
}

/**
 * Specification of which command to run where
 */
model CommandAsyncPostBody {
  /**
   * The command which should be run
   */
  command: string;

  /**
   * The arguments for the command to be run
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  arguments?: unknown;

  /**
   * IP address of the cassandra host to run the command on
   */
  host: string;

  /**
   * If true, stops cassandra before executing the command and then start it again
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `cassandra-stop-start`?: boolean;

  /**
   * If true, allows the command to *write* to the cassandra directory, otherwise read-only.
   */
  readWrite?: boolean;
}

/**
 * resource representing a command
 */
model CommandPublicResource {
  /**
   * The command which should be run
   */
  command?: string;

  /**
   * The unique id of command
   */
  commandId?: string;

  /**
   * The arguments for the command to be run
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  arguments?: unknown;

  /**
   * IP address of the cassandra host to run the command on
   */
  host?: string;

  /**
   * Whether command has admin privileges
   */
  isAdmin?: boolean;

  /**
   * If true, stops cassandra before executing the command and then start it again
   */
  cassandraStopStart?: boolean;

  /**
   * If true, allows the command to *write* to the cassandra directory, otherwise read-only.
   */
  readWrite?: boolean;

  /**
   * Result output of the command.
   */
  result?: string;

  /**
   * Status of the command.
   */
  status?: CommandStatus;

  /**
   * The name of the file where the result is written.
   */
  outputFile?: string;
}

/**
 * List of commands for cluster.
 */
model ListCommands {
  /**
   * Container for array of commands.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  @OpenAPI.extension("x-ms-identifiers", #[])
  value?: CommandPublicResource[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * List of restorable backups for a Cassandra cluster.
 */
model ListBackups {
  /**
   * Container for array of backups.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  @OpenAPI.extension("x-ms-identifiers", #[])
  value?: BackupResource[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * A restorable backup of a Cassandra cluster.
 */
model BackupResource {
  /**
   * The unique identifier of backup.
   */
  backupId?: string;

  /**
   * The current state of the backup.
   */
  backupState?: BackupState;

  /**
   * The time at which the backup process begins.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupStartTimestamp?: utcDateTime;

  /**
   * The time at which the backup process ends.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupStopTimestamp?: utcDateTime;

  /**
   * The time at which the backup will expire.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  backupExpiryTimestamp?: utcDateTime;
}

/**
 * List of managed Cassandra data centers and their properties.
 */
model ListDataCenters {
  /**
   * Container for array of data centers.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: DataCenterResource[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * Properties of a managed Cassandra data center.
 */
model DataCenterResourceProperties {
  /**
   * The status of the resource at the time the operation was called.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: ManagedCassandraProvisioningState;

  /**
   * The region this data center should be created in.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataCenterLocation?: string;

  /**
   * Resource id of a subnet the nodes in this data center should have their network interfaces connected to. The subnet must be in the same region specified in 'dataCenterLocation' and must be able to route to the subnet specified in the cluster's 'delegatedManagementSubnetId' property. This resource id will be of the form '/subscriptions/<subscription id>/resourceGroups/<resource group>/providers/Microsoft.Network/virtualNetworks/<virtual network>/subnets/<subnet>'.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  delegatedSubnetId?: string;

  /**
   * The number of nodes the data center should have. This is the desired number. After it is set, it may take some time for the data center to be scaled to match. To monitor the number of nodes and their status, use the fetchNodeStatus method on the cluster.
   */
  nodeCount?: int32;

  /**
   * IP addresses for seed nodes in this data center. This is for reference. Generally you will want to use the seedNodes property on the cluster, which aggregates the seed nodes from all data centers in the cluster.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  @visibility(Lifecycle.Read)
  seedNodes?: SeedNode[];

  /**
   * A fragment of a cassandra.yaml configuration file to be included in the cassandra.yaml for all nodes in this data center. The fragment should be Base64 encoded, and only a subset of keys are allowed.
   */
  base64EncodedCassandraYamlFragment?: string;

  /**
   * Key uri to use for encryption of managed disks. Ensure the system assigned identity of the cluster has been assigned appropriate permissions(key get/wrap/unwrap permissions) on the key.
   */
  managedDiskCustomerKeyUri?: string;

  /**
   * Indicates the Key Uri of the customer key to use for encryption of the backup storage account.
   */
  backupStorageCustomerKeyUri?: string;

  /**
   * Virtual Machine SKU used for data centers. Default value is Standard_DS14_v2
   */
  sku?: string;

  /**
   * Disk SKU used for data centers. Default value is P30.
   */
  diskSku?: string;

  /**
   * Number of disks attached to each node. Default is 4.
   */
  diskCapacity?: int32;

  /**
   * If the data center has Availability Zone support, apply it to the Virtual Machine ScaleSet that host the cassandra data center virtual machines.
   */
  availabilityZone?: boolean;

  /**
   * Ldap authentication method properties. This feature is in preview.
   */
  authenticationMethodLdapProperties?: AuthenticationMethodLdapProperties;

  /**
   * Whether the data center has been deallocated.
   */
  deallocated?: boolean;

  /**
   * Error related to resource provisioning.
   */
  provisionError?: CassandraError;

  /**
   * Ip of the VPN Endpoint for this data center.
   */
  privateEndpointIpAddress?: string;
}

/**
 * Ldap authentication method properties. This feature is in preview.
 */
model AuthenticationMethodLdapProperties {
  /**
   * Hostname of the LDAP server.
   */
  serverHostname?: string;

  /**
   * Port of the LDAP server.
   */
  serverPort?: int32;

  /**
   * Distinguished name of the look up user account, who can look up user details on authentication.
   */
  serviceUserDistinguishedName?: string;

  /**
   * Password of the look up user.
   */
  serviceUserPassword?: string;

  /**
   * Distinguished name of the object to start the recursive search of users from.
   */
  searchBaseDistinguishedName?: string;

  /**
   * Template to use for searching. Defaults to (cn=%s) where %s will be replaced by the username used to login.
   */
  searchFilterTemplate?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  serverCertificates?: Certificate[];

  /**
   * Timeout for connecting to the LDAP server in miliseconds. The default is 5000 ms.
   */
  connectionTimeoutInMs?: int32;
}

/**
 * Properties of a managed Cassandra cluster public status.
 */
model CassandraClusterPublicStatus {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  eTag?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  reaperStatus?: ManagedCassandraReaperStatus;

  /**
   * List relevant information about any connection errors to the Datacenters.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  connectionErrors?: ConnectionError[];

  /**
   * List relevant information about any errors about cluster, data center and connection error.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  errors?: CassandraError[];

  /**
   * List of the status of each datacenter in this cluster.
   */
  dataCenters?: CassandraClusterPublicStatusDataCentersItem[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedCassandraReaperStatus {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  healthy?: boolean;

  /**
   * Dictionary of <string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  repairRunIds?: Record<string>;

  /**
   * Dictionary of <string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  repairSchedules?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConnectionError {
  /**
   * The kind of connection error that occurred.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionState?: ConnectionState;

  /**
   * The IP of host that originated the failed connection.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  iPFrom?: string;

  /**
   * The IP that the connection attempted to reach.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  iPTo?: string;

  /**
   * The TCP port the connection was attempted on.
   */
  port?: int32;

  /**
   * Detailed error message about the failed connection.
   */
  exception?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CassandraClusterPublicStatusDataCentersItem {
  /**
   * The name of this Datacenter.
   */
  name?: string;

  /**
   * A list of all seed nodes in the cluster, managed and unmanaged.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  seedNodes?: string[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  nodes?: ComponentsM9L909SchemasCassandraclusterpublicstatusPropertiesDatacentersItemsPropertiesNodesItems[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ComponentsM9L909SchemasCassandraclusterpublicstatusPropertiesDatacentersItemsPropertiesNodesItems {
  /**
   * The node's IP address.
   */
  address?: string;

  /**
   * The state of the node in Cassandra ring.
   */
  state?: NodeState;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  status?: string;

  /**
   * Cassandra service status on this node
   */
  cassandraProcessStatus?: string;

  /**
   * The amount of file system data in the data directory (e.g., 47.66 kB), excluding all content in the snapshots subdirectories. Because all SSTable data files are included, any data that is not cleaned up (such as TTL-expired cells or tombstones) is counted.
   */
  load?: string;

  /**
   * List of tokens this node covers.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tokens?: string[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  size?: int32;

  /**
   * The network ID of the node.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  hostID?: string;

  /**
   * The rack this node is part of.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rack?: string;

  /**
   * The timestamp when these statistics were captured.
   */
  timestamp?: string;

  /**
   * The amount of disk used, in kB, of the directory /var/lib/cassandra.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  diskUsedKB?: int64;

  /**
   * The amount of disk free, in kB, of the directory /var/lib/cassandra.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  diskFreeKB?: int64;

  /**
   * Used memory (calculated as total - free - buffers - cache), in kB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  memoryUsedKB?: int64;

  /**
   * Memory used by kernel buffers (Buffers in /proc/meminfo) and page cache and slabs (Cached and SReclaimable in /proc/meminfo), in kB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  memoryBuffersAndCachedKB?: int64;

  /**
   * Unused memory (MemFree and SwapFree in /proc/meminfo), in kB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  memoryFreeKB?: int64;

  /**
   * Total installed memory (MemTotal and SwapTotal in /proc/meminfo), in kB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  memoryTotalKB?: int64;

  /**
   * A float representing the current system-wide CPU utilization as a percentage.
   */
  cpuUsage?: float64;

  /**
   * If node has been updated to latest model
   */
  isLatestModel?: boolean;
}

/**
 * Azure Cosmos DB Mongo Role Definition resource object.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoRoleDefinitionResource {
  /**
   * A user-friendly name for the Role Definition. Must be unique for the database account.
   */
  roleName?: string;

  /**
   * Indicates whether the Role Definition was built-in or user created.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type?: MongoRoleDefinitionType;

  /**
   * The database name for which access is being granted for this Role Definition.
   */
  databaseName?: string;

  /**
   * A set of privileges contained by the Role Definition. This will allow application of this Role Definition on the entire database account or any underlying Database / Collection. Scopes higher than Database are not enforceable as privilege.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  privileges?: Privilege[];

  /**
   * The set of roles inherited by this Role Definition.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  roles?: Role[];
}

/**
 * The set of data plane operations permitted through this Role Definition.
 */
model Privilege {
  /**
   * An Azure Cosmos DB Mongo DB Resource.
   */
  resource?: PrivilegeResource;

  /**
   * An array of actions that are allowed.
   */
  actions?: string[];
}

/**
 * An Azure Cosmos DB Mongo DB Resource.
 */
model PrivilegeResource {
  /**
   * The database name the role is applied.
   */
  db?: string;

  /**
   * The collection name the role is applied.
   */
  collection?: string;
}

/**
 * The set of roles permitted through this Role Definition.
 */
model Role {
  /**
   * The database name the role is applied.
   */
  db?: string;

  /**
   * The role name.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  role?: string;
}

/**
 * Parameters to create and update an Azure Cosmos DB Mongo Role Definition.
 */
model MongoRoleDefinitionCreateUpdateParameters {
  /**
   * Properties to create and update an Azure Cosmos DB Mongo Role Definition.
   */
  properties?: MongoRoleDefinitionResource;
}

/**
 * The relevant Mongo Role Definitions.
 */
model MongoRoleDefinitionListResult {
  /**
   * List of Mongo Role Definitions and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: MongoRoleDefinitionGetResults[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * Azure Cosmos DB Mongo User Definition resource object.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoUserDefinitionResource {
  /**
   * The user name for User Definition.
   */
  userName?: string;

  /**
   * The password for User Definition. Response does not contain user password.
   */
  password?: string;

  /**
   * The database name for which access is being granted for this User Definition.
   */
  databaseName?: string;

  /**
   * A custom definition for the USer Definition.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  customData?: string;

  /**
   * The set of roles inherited by the User Definition.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  roles?: Role[];

  /**
   * The Mongo Auth mechanism. For now, we only support auth mechanism SCRAM-SHA-256.
   */
  mechanisms?: string;
}

/**
 * Parameters to create and update an Azure Cosmos DB Mongo User Definition.
 */
model MongoUserDefinitionCreateUpdateParameters {
  /**
   * Properties to create and update an Azure Cosmos DB Mongo User Definition.
   */
  properties?: MongoUserDefinitionResource;
}

/**
 * The relevant User Definition.
 */
model MongoUserDefinitionListResult {
  /**
   * List of User Definition and their properties
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: MongoUserDefinitionGetResults[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * Subscription identifiers
 */
model AccessRulePropertiesSubscriptionsItem {
  /**
   * The fully qualified Azure resource ID of the subscription e.g. ('/subscriptions/00000000-0000-0000-0000-000000000000')
   */
  id?: Azure.Core.armResourceIdentifier;
}

/**
 * A list of notebook workspace resources
 */
model NotebookWorkspaceListResult {
  /**
   * Array of notebook workspace resources
   */
  @pageItems
  value?: NotebookWorkspace[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * Properties of a notebook workspace resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NotebookWorkspaceProperties {
  /**
   * Specifies the endpoint of Notebook server.
   */
  @visibility(Lifecycle.Read)
  notebookServerEndpoint?: string;

  /**
   * Status of the notebook workspace. Possible values are: Creating, Online, Deleting, Failed, Updating.
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

/**
 * Parameters to create a notebook workspace resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NotebookWorkspaceCreateUpdateParameters extends ARMProxyResource {}

/**
 * The connection info for the given notebook workspace
 */
model NotebookWorkspaceConnectionInfoResult {
  /**
   * Specifies auth token used for connecting to Notebook server (uses token-based auth).
   */
  @visibility(Lifecycle.Read)
  authToken?: string;

  /**
   * Specifies the endpoint of Notebook server.
   */
  @visibility(Lifecycle.Read)
  notebookServerEndpoint?: string;
}

/**
 * A list of private endpoint connections
 */
model PrivateEndpointConnectionListResult {
  /**
   * Array of private endpoint connections
   */
  @pageItems
  value?: PrivateEndpointConnection[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * A list of private link resources
 */
model PrivateLinkResourceListResult {
  /**
   * Array of private link resources
   */
  @pageItems
  value?: PrivateLinkResource[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * Properties of a private link resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * The private link resource required zone names.
   */
  @visibility(Lifecycle.Read)
  requiredZoneNames?: string[];
}

/**
 * Azure Cosmos DB SQL Role Definition resource object.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlRoleDefinitionResource {
  /**
   * A user-friendly name for the Role Definition. Must be unique for the database account.
   */
  roleName?: string;

  /**
   * Indicates whether the Role Definition was built-in or user created.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type?: RoleDefinitionType;

  /**
   * A set of fully qualified Scopes at or below which Role Assignments may be created using this Role Definition. This will allow application of this Role Definition on the entire database account or any underlying Database / Collection. Must have at least one element. Scopes higher than Database account are not enforceable as assignable Scopes. Note that resources referenced in assignable Scopes need not exist.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  assignableScopes?: string[];

  /**
   * The set of operations allowed through this Role Definition.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  permissions?: Permission[];
}

/**
 * The set of data plane operations permitted through this Role Definition.
 */
model Permission {
  /**
   * The id for the permission.
   */
  id?: string;

  /**
   * An array of data actions that are allowed.
   */
  dataActions?: string[];

  /**
   * An array of data actions that are denied.
   */
  notDataActions?: string[];
}

/**
 * Parameters to create and update an Azure Cosmos DB SQL Role Definition.
 */
model SqlRoleDefinitionCreateUpdateParameters {
  /**
   * Properties to create and update an Azure Cosmos DB SQL Role Definition.
   */
  properties?: SqlRoleDefinitionResource;
}

/**
 * The relevant Role Definitions.
 */
model SqlRoleDefinitionListResult {
  /**
   * List of Role Definitions and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: SqlRoleDefinitionGetResults[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * Azure Cosmos DB SQL Role Assignment resource object.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlRoleAssignmentResource {
  /**
   * The unique identifier for the associated Role Definition.
   */
  roleDefinitionId?: string;

  /**
   * The data plane resource path for which access is being granted through this Role Assignment.
   */
  scope?: string;

  /**
   * The unique identifier for the associated AAD principal in the AAD graph to which access is being granted through this Role Assignment. Tenant ID for the principal is inferred using the tenant associated with the subscription.
   */
  principalId?: string;
}

/**
 * Parameters to create and update an Azure Cosmos DB SQL Role Assignment.
 */
model SqlRoleAssignmentCreateUpdateParameters {
  /**
   * Properties to create and update an Azure Cosmos DB SQL Role Assignment.
   */
  properties?: SqlRoleAssignmentResource;
}

/**
 * The relevant Role Assignments.
 */
model SqlRoleAssignmentListResult {
  /**
   * List of Role Assignments and their properties
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: SqlRoleAssignmentGetResults[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The List operation response, that contains the restorable database accounts and their properties.
 */
model RestorableDatabaseAccountsListResult {
  /**
   * List of restorable database accounts and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: RestorableDatabaseAccountGetResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * The properties of a restorable database account.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RestorableDatabaseAccountProperties {
  /**
   * The name of the global database account
   */
  accountName?: string;

  /**
   * The creation time of the restorable database account (ISO-8601 format).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * The least recent time at which the database account can be restored to (ISO-8601 format).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  oldestRestorableTime?: utcDateTime;

  /**
   * The time at which the restorable database account has been deleted (ISO-8601 format).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionTime?: utcDateTime;

  /**
   * The API type of the restorable database account.
   */
  @visibility(Lifecycle.Read)
  apiType?: ApiType;

  /**
   * List of regions where the of the database account can be restored from.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  restorableLocations?: RestorableLocationResource[];
}

/**
 * Properties of the regional restorable account.
 */
model RestorableLocationResource {
  /**
   * The location of the regional restorable account.
   */
  @visibility(Lifecycle.Read)
  locationName?: string;

  /**
   * The instance id of the regional restorable account.
   */
  @visibility(Lifecycle.Read)
  regionalDatabaseAccountInstanceId?: string;

  /**
   * The creation time of the regional restorable database account (ISO-8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * The time at which the regional restorable database account has been deleted (ISO-8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionTime?: utcDateTime;
}

/**
 * Properties of the regional restorable account.
 */
model ContinuousBackupRestoreLocation {
  /**
   * The name of the continuous backup restore location.
   */
  location?: string;
}

/**
 * Backup information of a resource.
 */
model BackupInformation {
  /**
   * Information about the status of continuous backups.
   */
  @visibility(Lifecycle.Read)
  continuousBackupInformation?: ContinuousBackupInformation;
}

/**
 * Information about the status of continuous backups.
 */
model ContinuousBackupInformation {
  /**
   * The latest restorable timestamp for a resource.
   */
  latestRestorableTimestamp?: string;
}

/**
 * The List operation response, that contains the SQL database events and their properties.
 */
model RestorableSqlDatabasesListResult {
  /**
   * List of SQL database events and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: RestorableSqlDatabaseGetResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * An Azure Cosmos DB SQL database event
 */
model RestorableSqlDatabaseGetResult {
  /**
   * The properties of a SQL database event.
   */
  properties?: RestorableSqlDatabaseProperties;

  /**
   * The unique resource Identifier of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of Azure resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The properties of an Azure Cosmos DB SQL database event
 */
model RestorableSqlDatabaseProperties {
  /**
   * The resource of an Azure Cosmos DB SQL database event
   */
  resource?: RestorableSqlDatabasePropertiesResource;
}

/**
 * The resource of an Azure Cosmos DB SQL database event
 */
model RestorableSqlDatabasePropertiesResource {
  /**
   * A system generated property. A unique identifier.
   */
  @visibility(Lifecycle.Read)
  _rid?: string;

  /**
   * The operation type of this database event.
   */
  @visibility(Lifecycle.Read)
  operationType?: OperationType;

  /**
   * A state of this database to identify if this database is restorable in same account.
   */
  @visibility(Lifecycle.Read)
  canUndelete?: string;

  /**
   * The reason why this database can not be restored in same account.
   */
  @visibility(Lifecycle.Read)
  canUndeleteReason?: string;

  /**
   * The time when this database event happened.
   */
  @visibility(Lifecycle.Read)
  eventTimestamp?: string;

  /**
   * The name of the SQL database.
   */
  @visibility(Lifecycle.Read)
  ownerId?: string;

  /**
   * The resource ID of the SQL database.
   */
  @visibility(Lifecycle.Read)
  ownerResourceId?: string;

  /**
   * Cosmos DB SQL database resource object
   */
  database?: RestorableSqlDatabasePropertiesResourceDatabase;
}

/**
 * Cosmos DB SQL database resource object
 */
model RestorableSqlDatabasePropertiesResourceDatabase {
  ...SqlDatabaseResource;
  ...ExtendedResourceProperties;

  /**
   * A system generated property that specified the addressable path of the collections resource.
   */
  @visibility(Lifecycle.Read)
  _colls?: string;

  /**
   * A system generated property that specifies the addressable path of the users resource.
   */
  @visibility(Lifecycle.Read)
  _users?: string;

  /**
   * A system generated property that specifies the addressable path of the database resource.
   */
  @visibility(Lifecycle.Read)
  _self?: string;
}

/**
 * The List operation response, that contains the SQL container events and their properties.
 */
model RestorableSqlContainersListResult {
  /**
   * List of SQL container events and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: RestorableSqlContainerGetResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * An Azure Cosmos DB SQL container event
 */
model RestorableSqlContainerGetResult {
  /**
   * The properties of a SQL container event.
   */
  properties?: RestorableSqlContainerProperties;

  /**
   * The unique resource Identifier of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of Azure resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The properties of an Azure Cosmos DB SQL container event
 */
model RestorableSqlContainerProperties {
  /**
   * The resource of an Azure Cosmos DB SQL container event
   */
  resource?: RestorableSqlContainerPropertiesResource;
}

/**
 * The resource of an Azure Cosmos DB SQL container event
 */
model RestorableSqlContainerPropertiesResource {
  /**
   * A system generated property. A unique identifier.
   */
  @visibility(Lifecycle.Read)
  _rid?: string;

  /**
   * The operation type of this container event.
   */
  @visibility(Lifecycle.Read)
  operationType?: OperationType;

  /**
   * A state of this container to identify if this container is restorable in same account.
   */
  @visibility(Lifecycle.Read)
  canUndelete?: string;

  /**
   * The reason why this container can not be restored in same account.
   */
  @visibility(Lifecycle.Read)
  canUndeleteReason?: string;

  /**
   * The when this container event happened.
   */
  @visibility(Lifecycle.Read)
  eventTimestamp?: string;

  /**
   * The name of this SQL container.
   */
  @visibility(Lifecycle.Read)
  ownerId?: string;

  /**
   * The resource ID of this SQL container.
   */
  @visibility(Lifecycle.Read)
  ownerResourceId?: string;

  /**
   * Cosmos DB SQL container resource object
   */
  container?: RestorableSqlContainerPropertiesResourceContainer;
}

/**
 * Cosmos DB SQL container resource object
 */
model RestorableSqlContainerPropertiesResourceContainer {
  ...SqlContainerResource;
  ...ExtendedResourceProperties;

  /**
   * A system generated property that specifies the addressable path of the container resource.
   */
  @visibility(Lifecycle.Read)
  _self?: string;
}

/**
 * The List operation response, that contains the restorable SQL resources.
 */
model RestorableSqlResourcesListResult {
  /**
   * List of restorable SQL resources, including the database and collection names.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: RestorableSqlResourcesGetResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * Specific Databases to restore.
 */
model RestorableSqlResourcesGetResult {
  /**
   * The unique resource identifier of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of Azure resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The name of the database available for restore.
   */
  databaseName?: string;

  /**
   * The names of the collections available for restore.
   */
  collectionNames?: string[];
}

/**
 * The List operation response, that contains the MongoDB database events and their properties.
 */
model RestorableMongodbDatabasesListResult {
  /**
   * List of MongoDB database events and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: RestorableMongodbDatabaseGetResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * An Azure Cosmos DB MongoDB database event
 */
model RestorableMongodbDatabaseGetResult {
  /**
   * The properties of a MongoDB database event.
   */
  properties?: RestorableMongodbDatabaseProperties;

  /**
   * The unique resource Identifier of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of Azure resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The properties of an Azure Cosmos DB MongoDB database event
 */
model RestorableMongodbDatabaseProperties {
  /**
   * The resource of an Azure Cosmos DB MongoDB database event
   */
  resource?: RestorableMongodbDatabasePropertiesResource;
}

/**
 * The resource of an Azure Cosmos DB MongoDB database event
 */
model RestorableMongodbDatabasePropertiesResource {
  /**
   * A system generated property. A unique identifier.
   */
  @visibility(Lifecycle.Read)
  _rid?: string;

  /**
   * The operation type of this database event.
   */
  @visibility(Lifecycle.Read)
  operationType?: OperationType;

  /**
   * A state of this database to identify if this database is restorable in same account.
   */
  @visibility(Lifecycle.Read)
  canUndelete?: string;

  /**
   * The reason why this database can not be restored in same account.
   */
  @visibility(Lifecycle.Read)
  canUndeleteReason?: string;

  /**
   * The time when this database event happened.
   */
  @visibility(Lifecycle.Read)
  eventTimestamp?: string;

  /**
   * The name of this MongoDB database.
   */
  @visibility(Lifecycle.Read)
  ownerId?: string;

  /**
   * The resource ID of this MongoDB database.
   */
  @visibility(Lifecycle.Read)
  ownerResourceId?: string;
}

/**
 * The List operation response, that contains the MongoDB collection events and their properties.
 */
model RestorableMongodbCollectionsListResult {
  /**
   * List of MongoDB collection events and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: RestorableMongodbCollectionGetResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * An Azure Cosmos DB MongoDB collection event
 */
model RestorableMongodbCollectionGetResult {
  /**
   * The properties of a MongoDB collection event.
   */
  properties?: RestorableMongodbCollectionProperties;

  /**
   * The unique resource Identifier of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of Azure resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The properties of an Azure Cosmos DB MongoDB collection event
 */
model RestorableMongodbCollectionProperties {
  /**
   * The resource of an Azure Cosmos DB MongoDB collection event
   */
  resource?: RestorableMongodbCollectionPropertiesResource;
}

/**
 * The resource of an Azure Cosmos DB MongoDB collection event
 */
model RestorableMongodbCollectionPropertiesResource {
  /**
   * A system generated property. A unique identifier.
   */
  @visibility(Lifecycle.Read)
  _rid?: string;

  /**
   * The operation type of this collection event.
   */
  @visibility(Lifecycle.Read)
  operationType?: OperationType;

  /**
   * A state of this collection to identify if this container is restorable in same account.
   */
  @visibility(Lifecycle.Read)
  canUndelete?: string;

  /**
   * The reason why this collection can not be restored in same account.
   */
  @visibility(Lifecycle.Read)
  canUndeleteReason?: string;

  /**
   * The time when this collection event happened.
   */
  @visibility(Lifecycle.Read)
  eventTimestamp?: string;

  /**
   * The name of this MongoDB collection.
   */
  @visibility(Lifecycle.Read)
  ownerId?: string;

  /**
   * The resource ID of this MongoDB collection.
   */
  @visibility(Lifecycle.Read)
  ownerResourceId?: string;
}

/**
 * The List operation response, that contains the restorable MongoDB resources.
 */
model RestorableMongodbResourcesListResult {
  /**
   * List of restorable MongoDB resources, including the database and collection names.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: RestorableMongodbResourcesGetResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * Specific Databases to restore.
 */
model RestorableMongodbResourcesGetResult {
  /**
   * The unique resource identifier of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of Azure resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The name of the database available for restore.
   */
  databaseName?: string;

  /**
   * The names of the collections available for restore.
   */
  collectionNames?: string[];
}

/**
 * The List operation response, that contains the Gremlin database events and their properties.
 */
model RestorableGremlinDatabasesListResult {
  /**
   * List of Gremlin database events and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: RestorableGremlinDatabaseGetResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * An Azure Cosmos DB Gremlin database event
 */
model RestorableGremlinDatabaseGetResult {
  /**
   * The properties of a Gremlin database event.
   */
  properties?: RestorableGremlinDatabaseProperties;

  /**
   * The unique resource Identifier of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of Azure resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The properties of an Azure Cosmos DB Gremlin database event
 */
model RestorableGremlinDatabaseProperties {
  /**
   * The resource of an Azure Cosmos DB Gremlin database event
   */
  resource?: RestorableGremlinDatabasePropertiesResource;
}

/**
 * The resource of an Azure Cosmos DB Gremlin database event
 */
model RestorableGremlinDatabasePropertiesResource {
  /**
   * A system generated property. A unique identifier.
   */
  @visibility(Lifecycle.Read)
  _rid?: string;

  /**
   * The operation type of this database event.
   */
  @visibility(Lifecycle.Read)
  operationType?: OperationType;

  /**
   * A state of this database to identify if this database is restorable in same account.
   */
  @visibility(Lifecycle.Read)
  canUndelete?: string;

  /**
   * The reason why this database can not be restored in same account.
   */
  @visibility(Lifecycle.Read)
  canUndeleteReason?: string;

  /**
   * The time when this database event happened.
   */
  @visibility(Lifecycle.Read)
  eventTimestamp?: string;

  /**
   * The name of this Gremlin database.
   */
  @visibility(Lifecycle.Read)
  ownerId?: string;

  /**
   * The resource ID of this Gremlin database.
   */
  @visibility(Lifecycle.Read)
  ownerResourceId?: string;
}

/**
 * The List operation response, that contains the Gremlin graph events and their properties.
 */
model RestorableGremlinGraphsListResult {
  /**
   * List of Gremlin graph events and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: RestorableGremlinGraphGetResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * An Azure Cosmos DB Gremlin graph event
 */
model RestorableGremlinGraphGetResult {
  /**
   * The properties of a Gremlin graph event.
   */
  properties?: RestorableGremlinGraphProperties;

  /**
   * The unique resource Identifier of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of Azure resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The properties of an Azure Cosmos DB Gremlin graph event
 */
model RestorableGremlinGraphProperties {
  /**
   * The resource of an Azure Cosmos DB Gremlin graph event
   */
  resource?: RestorableGremlinGraphPropertiesResource;
}

/**
 * The resource of an Azure Cosmos DB Gremlin graph event
 */
model RestorableGremlinGraphPropertiesResource {
  /**
   * A system generated property. A unique identifier.
   */
  @visibility(Lifecycle.Read)
  _rid?: string;

  /**
   * The operation type of this graph event.
   */
  @visibility(Lifecycle.Read)
  operationType?: OperationType;

  /**
   * A state of this graph to identify if this graph is restorable in same account.
   */
  @visibility(Lifecycle.Read)
  canUndelete?: string;

  /**
   * The reason why this graph can not be restored in same account.
   */
  @visibility(Lifecycle.Read)
  canUndeleteReason?: string;

  /**
   * The time when this graph event happened.
   */
  @visibility(Lifecycle.Read)
  eventTimestamp?: string;

  /**
   * The name of this Gremlin graph.
   */
  @visibility(Lifecycle.Read)
  ownerId?: string;

  /**
   * The resource ID of this Gremlin graph.
   */
  @visibility(Lifecycle.Read)
  ownerResourceId?: string;
}

/**
 * The List operation response, that contains the restorable Gremlin resources.
 */
model RestorableGremlinResourcesListResult {
  /**
   * List of restorable Gremlin resources, including the gremlin database and graph names.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: RestorableGremlinResourcesGetResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * Specific Databases to restore.
 */
model RestorableGremlinResourcesGetResult {
  /**
   * The unique resource identifier of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of Azure resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The name of the gremlin database available for restore.
   */
  databaseName?: string;

  /**
   * The names of the graphs available for restore.
   */
  graphNames?: string[];
}

/**
 * The List operation response, that contains the Table events and their properties.
 */
model RestorableTablesListResult {
  /**
   * List of Table events and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: RestorableTableGetResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * An Azure Cosmos DB Table event
 */
model RestorableTableGetResult {
  /**
   * The properties of a Table event.
   */
  properties?: RestorableTableProperties;

  /**
   * The unique resource Identifier of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of Azure resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The properties of an Azure Cosmos DB Table event
 */
model RestorableTableProperties {
  /**
   * The resource of an Azure Cosmos DB Table event
   */
  resource?: RestorableTablePropertiesResource;
}

/**
 * The resource of an Azure Cosmos DB Table event
 */
model RestorableTablePropertiesResource {
  /**
   * A system generated property. A unique identifier.
   */
  @visibility(Lifecycle.Read)
  _rid?: string;

  /**
   * The operation type of this table event.
   */
  @visibility(Lifecycle.Read)
  operationType?: OperationType;

  /**
   * A state of this table to identify if this table is restorable in same account.
   */
  @visibility(Lifecycle.Read)
  canUndelete?: string;

  /**
   * The reason why this table can not be restored in same account.
   */
  @visibility(Lifecycle.Read)
  canUndeleteReason?: string;

  /**
   * The time when this table event happened.
   */
  @visibility(Lifecycle.Read)
  eventTimestamp?: string;

  /**
   * The name of this Table.
   */
  @visibility(Lifecycle.Read)
  ownerId?: string;

  /**
   * The resource ID of this Table.
   */
  @visibility(Lifecycle.Read)
  ownerResourceId?: string;
}

/**
 * List of restorable table names.
 */
model RestorableTableResourcesListResult {
  /**
   * List of restorable table names.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: RestorableTableResourcesGetResult[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * Specific Databases to restore.
 */
model RestorableTableResourcesGetResult {
  /**
   * The unique resource identifier of the ARM resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the Table.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of Azure resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The List operation response, that contains the Service Resource and their properties.
 */
model ServiceResourceListResult {
  /**
   * List of Service Resource and their properties.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: ServiceResource[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * Services response resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("serviceType")
model ServiceResourceProperties {
  ...Record<unknown>;

  /**
   * Time of the last state change (ISO-8601 format).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Instance type for the service.
   */
  instanceSize?: ServiceSize;

  /**
   * Instance count for the service.
   */
  @minValue(0)
  instanceCount?: int32;

  /**
   * ServiceType for the service.
   */
  serviceType: ServiceType;

  /**
   * Describes the status of a service.
   */
  @visibility(Lifecycle.Read)
  status?: ServiceStatus;
}

/**
 * Parameters for Create or Update request for ServiceResource
 */
model ServiceResourceCreateUpdateParameters {
  /**
   * Properties in ServiceResourceCreateUpdateParameters.
   */
  properties?: ServiceResourceCreateUpdateProperties;
}

/**
 * Properties in ServiceResourceCreateUpdateParameters.
 */
@discriminator("serviceType")
model ServiceResourceCreateUpdateProperties {
  /**
   * Instance type for the service.
   */
  instanceSize?: ServiceSize;

  /**
   * Instance count for the service.
   */
  @minValue(0)
  instanceCount?: int32;

  /**
   * ServiceType for the service.
   */
  serviceType: ServiceType;
}

/**
 * Azure Cosmos DB Table Role Definition resource object.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TableRoleDefinitionResourceProperties {
  /**
   * The path id for the Role Definition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  id?: string;

  /**
   * A user-friendly name for the Role Definition. Must be unique for the database account.
   */
  roleName?: string;

  /**
   * Indicates whether the Role Definition was built-in or user created.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type?: RoleDefinitionType;

  /**
   * A set of fully qualified Scopes at or below which Table Role Assignments may be created using this Role Definition. This will allow application of this Role Definition on the entire database account or any underlying Database / Collection. Must have at least one element. Scopes higher than Database account are not enforceable as assignable Scopes. Note that resources referenced in assignable Scopes need not exist.
   */
  assignableScopes?: string[];

  /**
   * The set of operations allowed through this Role Definition.
   */
  permissions?: Permission[];
}

/**
 * Azure Cosmos DB Table Role Assignment resource object.
 */
model TableRoleAssignmentResourceProperties {
  /**
   * The unique identifier for the associated Role Definition.
   */
  roleDefinitionId?: string;

  /**
   * The data plane resource path for which access is being granted through this Table Role Assignment.
   */
  scope?: string;

  /**
   * The unique identifier for the associated AAD principal in the AAD graph to which access is being granted through this Table Role Assignment. Tenant ID for the principal is inferred using the tenant associated with the subscription.
   */
  principalId?: string;

  /**
   * Provisioning state of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Properties to update Azure Cosmos DB throughput pool.
 */
model ThroughputPoolProperties {
  /**
   * A provisioning state of the ThroughputPool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: Status;

  /**
   * Value for throughput to be shared among CosmosDB resources in the pool.
   */
  maxThroughput?: int32;
}

/**
 * Represents a throughput pool resource for updates.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ThroughputPoolUpdate {
  /**
   * Properties of the throughput pool.
   */
  properties?: ThroughputPoolProperties;
}

/**
 * An Azure Cosmos DB Global Database Account which is part of a Throughputpool.
 */
model ThroughputPoolAccountProperties {
  /**
   * A provisioning state of the ThroughputPool Account.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: Status;

  /**
   * The resource identifier of global database account in the throughputPool.
   */
  accountResourceIdentifier?: string;

  /**
   * The location of  global database account in the throughputPool.
   */
  accountLocation?: string;

  /**
   * The instance id of global database account in the throughputPool.
   */
  @visibility(Lifecycle.Read)
  accountInstanceId?: string;
}

/**
 * Azure Cosmos DB Cassandra Role Definition resource object.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CassandraRoleDefinitionResourceProperties {
  /**
   * The path id for the Role Definition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  id?: string;

  /**
   * A user-friendly name for the Role Definition. Must be unique for the database account.
   */
  roleName?: string;

  /**
   * Indicates whether the Role Definition was built-in or user created.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type?: RoleDefinitionType;

  /**
   * A set of fully qualified Scopes at or below which Cassandra Role Assignments may be created using this Role Definition. This will allow application of this Role Definition on the entire database account or any underlying Database / Collection. Must have at least one element. Scopes higher than Database account are not enforceable as assignable Scopes. Note that resources referenced in assignable Scopes need not exist.
   */
  assignableScopes?: string[];

  /**
   * The set of operations allowed through this Role Definition.
   */
  permissions?: Permission[];
}

/**
 * Azure Cosmos DB Cassandra Role Assignment resource object.
 */
model CassandraRoleAssignmentResourceProperties {
  /**
   * The unique identifier for the associated Role Definition.
   */
  roleDefinitionId?: string;

  /**
   * The data plane resource path for which access is being granted through this Cassandra Role Assignment.
   */
  scope?: string;

  /**
   * The unique identifier for the associated AAD principal in the AAD graph to which access is being granted through this Cassandra Role Assignment. Tenant ID for the principal is inferred using the tenant associated with the subscription.
   */
  principalId?: string;

  /**
   * Provisioning state of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Azure Cosmos DB MongoMI Role Definition resource object.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoMIRoleDefinitionResourceProperties {
  /**
   * The path id for the Role Definition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  id?: string;

  /**
   * A user-friendly name for the Role Definition. Must be unique for the database account.
   */
  roleName?: string;

  /**
   * Indicates whether the Role Definition was built-in or user created.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type?: RoleDefinitionType;

  /**
   * A set of fully qualified Scopes at or below which MongoMI Role Assignments may be created using this Role Definition. This will allow application of this Role Definition on the entire database account or any underlying Database / Collection. Must have at least one element. Scopes higher than Database account are not enforceable as assignable Scopes. Note that resources referenced in assignable Scopes need not exist.
   */
  assignableScopes?: string[];

  /**
   * The set of operations allowed through this Role Definition.
   */
  permissions?: Permission[];
}

/**
 * Azure Cosmos DB MongoMI Role Assignment resource object.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoMIRoleAssignmentResourceProperties {
  /**
   * The unique identifier for the associated Role Definition.
   */
  roleDefinitionId?: string;

  /**
   * The data plane resource path for which access is being granted through this MongoMI Role Assignment.
   */
  scope?: string;

  /**
   * The unique identifier for the associated AAD principal in the AAD graph to which access is being granted through this MongoMI Role Assignment. Tenant ID for the principal is inferred using the tenant associated with the subscription.
   */
  principalId?: string;

  /**
   * Provisioning state of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Azure Cosmos DB Gremlin Role Definition resource object.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GremlinRoleDefinitionResourceProperties {
  /**
   * The path id for the Role Definition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  id?: string;

  /**
   * A user-friendly name for the Role Definition. Must be unique for the database account.
   */
  roleName?: string;

  /**
   * Indicates whether the Role Definition was built-in or user created.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type?: RoleDefinitionType;

  /**
   * A set of fully qualified Scopes at or below which Gremlin Role Assignments may be created using this Role Definition. This will allow application of this Role Definition on the entire database account or any underlying Database / Collection. Must have at least one element. Scopes higher than Database account are not enforceable as assignable Scopes. Note that resources referenced in assignable Scopes need not exist.
   */
  assignableScopes?: string[];

  /**
   * The set of operations allowed through this Role Definition.
   */
  permissions?: Permission[];
}

/**
 * Azure Cosmos DB Gremlin Role Assignment resource object.
 */
model GremlinRoleAssignmentResourceProperties {
  /**
   * The unique identifier for the associated Role Definition.
   */
  roleDefinitionId?: string;

  /**
   * The data plane resource path for which access is being granted through this Gremlin Role Assignment.
   */
  scope?: string;

  /**
   * The unique identifier for the associated AAD principal in the AAD graph to which access is being granted through this Gremlin Role Assignment. Tenant ID for the principal is inferred using the tenant associated with the subscription.
   */
  principalId?: string;

  /**
   * Provisioning state of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Properties to update Azure Cosmos DB fleet resource.
 */
model FleetResourceProperties {
  /**
   * A provisioning state of the Fleet.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: Status;
}

/**
 * Represents a fleet resource for updates.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FleetResourceUpdate {
  /**
   * Properties to update Azure Cosmos DB fleet resource.
   */
  properties?: FleetResourceProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FleetAnalyticsProperties {
  /**
   * A provisioning state of the FleetAnalytics.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: Status;

  /**
   * The type of the fleet analytics resource.
   */
  storageLocationType?: FleetAnalyticsPropertiesStorageLocationType;

  /**
   * The unique identifier of the fleet analytics resource.
   */
  storageLocationUri?: string;
}

/**
 * Properties to update Azure Cosmos DB Fleetspace.
 */
model FleetspaceProperties {
  /**
   * A provisioning state of the Fleetspace.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: Status;

  /**
   * The kind of API this fleetspace belongs to. Acceptable values: 'NoSQL'
   */
  fleetspaceApiKind?: FleetspacePropertiesFleetspaceApiKind;

  /**
   * Configuration for throughput pool in the fleetspace.
   */
  throughputPoolConfiguration?: FleetspacePropertiesThroughputPoolConfiguration;
}

/**
 * Configuration for throughput pool in the fleetspace.
 */
model FleetspacePropertiesThroughputPoolConfiguration {
  /**
   * Minimum throughput for the pool.
   */
  minThroughput?: int32;

  /**
   * Maximum throughput for the pool.
   */
  maxThroughput?: int32;

  /**
   * Service Tier for the fleetspace. GeneralPurpose types refers to single write region accounts that can be added to this fleetspace, whereas BusinessCritical refers to multi write region.
   */
  serviceTier?: FleetspacePropertiesThroughputPoolConfigurationServiceTier;

  /**
   * List of data regions assigned to the fleetspace. Eg [westus2]
   */
  dataRegions?: string[];
}

/**
 * Represents a fleetspace resource for updates.
 */
model FleetspaceUpdate {
  /**
   * Properties of the fleetspace.
   */
  properties?: FleetspaceProperties;
}

/**
 * An Azure Cosmos DB Global Database Account which is part of a Fleetspace Account.
 */
model FleetspaceAccountProperties {
  /**
   * A provisioning state of the Fleetspace Account.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: Status;

  /**
   * Configuration for fleetspace Account in the fleetspace.
   */
  globalDatabaseAccountProperties?: FleetspaceAccountPropertiesGlobalDatabaseAccountProperties;
}

/**
 * Configuration for fleetspace Account in the fleetspace.
 */
model FleetspaceAccountPropertiesGlobalDatabaseAccountProperties {
  /**
   * The resource identifier of global database account in the Fleetspace Account.
   */
  resourceId?: string;

  /**
   * The location of  global database account in the Fleetspace Account.
   */
  armLocation?: string;
}

/**
 * A CosmosDB data source/sink details
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CosmosDBSourceSinkDetails {
  /**
   * Name of remote account in case of cross-account data transfer.
   */
  remoteAccountName?: string;
}

/**
 * A CosmosDB Mongo vCore data source/sink details
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoVCoreSourceSinkDetails {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  hostName?: string;

  /**
   * URI of Azure KeyVault secret containing connection string.
   */
  @pattern("^https?://[^/$.?# ]+.[^ ]*$")
  connectionStringKeyVaultUri?: string;
}

/**
 * An Azure Blob Storage data source/sink
 */
model AzureBlobSourceSinkDetails {
  /**
   * Azure Blob container endpoint.
   */
  @pattern("^https?://[^/$.?# ]+.[^ ]*$")
  endpointUrl: string;
}
/**
 * A CosmosDB Cassandra table
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CosmosDBCassandraTable {
  /**
   * Azure Cosmos DB for Apache Cassandra keyspace.
   */
  keyspaceName: string;

  /**
   * Azure Cosmos DB for Apache Cassandra table.
   */
  tableName: string;
}

/**
 * A CosmosDB Mongo collection
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CosmosDBMongoCollection {
  /**
   * Azure Cosmos DB for MongoDB (RU) database.
   */
  databaseName: string;

  /**
   * Azure Cosmos DB for MongoDB (RU) collection.
   */
  collectionName: string;
}

/**
 * A CosmosDB Mongo vCore collection
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CosmosDBMongoVCoreCollection {
  /**
   * Azure Cosmos DB for MongoDB (vCore) database.
   */
  databaseName: string;

  /**
   * Azure Cosmos DB for MongoDB (vCore) collection.
   */
  collectionName: string;
}

/**
 * A CosmosDB NoSQL container
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CosmosDBNoSqlContainer {
  /**
   * Azure Cosmos DB for NoSQL database.
   */
  databaseName: string;

  /**
   * Azure Cosmos DB for NoSQL container.
   */
  containerName: string;
}

/**
 * An Azure Blob container
 */
model AzureBlobContainer {
  /**
   * Azure Blob container.
   */
  containerName: string;
}

/**
 * The properties of a Copy Job Task
 */
model BaseCopyJobTask {
  /**
   * Task level Total Count.
   */
  @visibility(Lifecycle.Read)
  totalCount?: int64;

  /**
   * Task level Processed Count.
   */
  @visibility(Lifecycle.Read)
  processedCount?: int64;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BlobToCassandraRUCopyJobTask extends BaseCopyJobTask {
  /**
   * Source Azure Blob container
   */
  source: AzureBlobContainer;

  /**
   * Destination Cassandra table
   */
  destination: CosmosDBCassandraTable;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CassandraRUToBlobCopyJobTask extends BaseCopyJobTask {
  /**
   * Source Cassandra table
   */
  source: CosmosDBCassandraTable;

  /**
   * Destination Azure Blob container
   */
  destination: AzureBlobContainer;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CassandraRUToCassandraRUCopyJobTask extends BaseCopyJobTask {
  /**
   * Source Cassandra table
   */
  source: CosmosDBCassandraTable;

  /**
   * Destination Cassandra table
   */
  destination: CosmosDBCassandraTable;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoRUToMongoRUCopyJobTask extends BaseCopyJobTask {
  /**
   * Source Mongo (RU) collection
   */
  source: CosmosDBMongoCollection;

  /**
   * Destination Mongo (RU) collection
   */
  destination: CosmosDBMongoCollection;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoRUToMongoVCoreCopyJobTask extends BaseCopyJobTask {
  /**
   * Source Mongo (RU) collection
   */
  source: CosmosDBMongoCollection;

  /**
   * Destination Mongo (vCore) collection
   */
  destination: CosmosDBMongoVCoreCollection;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NoSqlRUToNoSqlRUCopyJobTask extends BaseCopyJobTask {
  /**
   * Source SQL container
   */
  source: CosmosDBNoSqlContainer;

  /**
   * Destination SQL container
   */
  destination: CosmosDBNoSqlContainer;
}

/**
 * Source Cassandra to Destination Cassandra copy job properties
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CassandraRUToCassandraRUCopyJobProperties extends BaseCopyJobProperties {
  /**
   * Source Cassandra DataStore details
   */
  sourceDetails?: CosmosDBSourceSinkDetails;

  /**
   * Destination Cassandra DataStore details
   */
  destinationDetails?: CosmosDBSourceSinkDetails;

  /**
   * Copy Job tasks.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  tasks: CassandraRUToCassandraRUCopyJobTask[];

  /**
   * Copy Job Type
   */
  jobType: "CassandraRUToCassandraRU";
}

/**
 * Source Azure Blob Storage to Destination Cassandra copy job properties
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BlobToCassandraRUCopyJobProperties extends BaseCopyJobProperties {
  /**
   * Azure Storage container DataStore details
   */
  sourceDetails: AzureBlobSourceSinkDetails;

  /**
   * Destination Cassandra DataStore details
   */
  destinationDetails?: CosmosDBSourceSinkDetails;

  /**
   * Copy Job tasks.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  tasks: BlobToCassandraRUCopyJobTask[];

  /**
   * Copy Job Type
   */
  jobType: "AzureBlobStorageToCassandraRU";
}

/**
 * Source Cassandra to Destination Azure Blob Storage copy job properties
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CassandraRUToBlobCopyJobProperties extends BaseCopyJobProperties {
  /**
   * Source Cassandra DataStore details
   */
  sourceDetails?: CosmosDBSourceSinkDetails;

  /**
   * Destination Cassandra DataStore details
   */
  destinationDetails: AzureBlobSourceSinkDetails;

  /**
   * Copy Job tasks.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  tasks: CassandraRUToBlobCopyJobTask[];

  /**
   * Copy Job Type
   */
  jobType: "CassandraRUToAzureBlobStorage";
}

/**
 * Source Mongo to Destination Mongo copy job properties
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoRUToMongoRUCopyJobProperties extends BaseCopyJobProperties {
  /**
   * Source Mongo DataStore details
   */
  sourceDetails?: CosmosDBSourceSinkDetails;

  /**
   * Destination Mongo DataStore details
   */
  destinationDetails?: CosmosDBSourceSinkDetails;

  /**
   * Copy Job tasks.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  tasks: MongoRUToMongoRUCopyJobTask[];

  /**
   * Copy Job Type
   */
  jobType: "MongoRUToMongoRU";
}

/**
 * Source Mongo to Destination Mongo vCore copy job properties
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MongoRUToMongoVCoreCopyJobProperties extends BaseCopyJobProperties {
  /**
   * Source Mongo (RU) DataStore details
   */
  sourceDetails?: CosmosDBSourceSinkDetails;

  /**
   * Destination Mongo (vCore) DataStore details
   */
  destinationDetails: MongoVCoreSourceSinkDetails;

  /**
   * Copy Job tasks.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  tasks: MongoRUToMongoVCoreCopyJobTask[];

  /**
   * Copy Job Type
   */
  jobType: "MongoRUToMongoVCore";
}

/**
 * Source SQL to Destination SQL copy job properties
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NoSqlRUToNoSqlRUCopyJobProperties extends BaseCopyJobProperties {
  /**
   * Source SQL DataStore details
   */
  sourceDetails?: CosmosDBSourceSinkDetails;

  /**
   * Destination SQL DataStore details
   */
  destinationDetails?: CosmosDBSourceSinkDetails;

  /**
   * Copy Job tasks.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  tasks: NoSqlRUToNoSqlRUCopyJobTask[];

  /**
   * Copy Job Type
   */
  jobType: "NoSqlRUToNoSqlRU";
}

/**
 * The object representing periodic mode backup policy.
 */
model PeriodicModeBackupPolicy extends BackupPolicy {
  /**
   * Configuration values for periodic mode backup
   */
  periodicModeProperties?: PeriodicModeProperties;

  /**
   * Describes the mode of backups.
   */
  type: "Periodic";
}

/**
 * Configuration values for periodic mode backup
 */
model PeriodicModeProperties {
  /**
   * An integer representing the interval in minutes between two backups
   */
  @minValue(0)
  backupIntervalInMinutes?: int32;

  /**
   * An integer representing the time (in hours) that each backup is retained
   */
  @minValue(0)
  backupRetentionIntervalInHours?: int32;

  /**
   * Enum to indicate type of backup residency
   */
  backupStorageRedundancy?: BackupStorageRedundancy;
}

/**
 * The object representing continuous mode backup policy.
 */
model ContinuousModeBackupPolicy extends BackupPolicy {
  /**
   * Configuration values for continuous mode backup
   */
  continuousModeProperties?: ContinuousModeProperties;

  /**
   * Describes the mode of backups.
   */
  type: "Continuous";
}

/**
 * Configuration values for periodic mode backup
 */
model ContinuousModeProperties {
  /**
   * Enum to indicate type of Continuos backup mode
   */
  tier?: ContinuousTier;
}

/**
 * A base CosmosDB data source/sink
 */
model BaseCosmosDataTransferDataSourceSink is DataTransferDataSourceSink {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  remoteAccountName?: string;
}

alias BaseCosmosDataTransferDataSourceSinkProperties = {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  remoteAccountName?: string;
};

/**
 * A CosmosDB Cassandra API data source/sink
 */
#suppress "@azure-tools/typespec-client-generator-core/legacy-hierarchy-building-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  BaseCosmosDataTransferDataSourceSink
)
model CosmosCassandraDataTransferDataSourceSink
  extends DataTransferDataSourceSink {
  ...BaseCosmosDataTransferDataSourceSinkProperties;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keyspaceName: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tableName: string;
  component: DataTransferComponent.CosmosDBCassandra;
}

/**
 * A CosmosDB Mongo API data source/sink
 */
#suppress "@azure-tools/typespec-client-generator-core/legacy-hierarchy-building-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  BaseCosmosDataTransferDataSourceSink
)
model CosmosMongoDataTransferDataSourceSink extends DataTransferDataSourceSink {
  ...BaseCosmosDataTransferDataSourceSinkProperties;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  databaseName: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  collectionName: string;
  component: DataTransferComponent.CosmosDBMongo;
}

/**
 * A CosmosDB Mongo vCore API data source/sink
 */
#suppress "@azure-tools/typespec-client-generator-core/legacy-hierarchy-building-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  BaseCosmosDataTransferDataSourceSink
)
model CosmosMongoVCoreDataTransferDataSourceSink
  extends DataTransferDataSourceSink {
  ...BaseCosmosDataTransferDataSourceSinkProperties;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  databaseName: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  collectionName: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  hostName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connectionStringKeyVaultUri?: string;
  component: DataTransferComponent.CosmosDBMongoVCore;
}

/**
 * A CosmosDB No Sql API data source/sink
 */
#suppress "@azure-tools/typespec-client-generator-core/legacy-hierarchy-building-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  BaseCosmosDataTransferDataSourceSink
)
model CosmosSqlDataTransferDataSourceSink extends DataTransferDataSourceSink {
  ...BaseCosmosDataTransferDataSourceSinkProperties;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  databaseName: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  containerName: string;
  component: DataTransferComponent.CosmosDBSql;
}

/**
 * An Azure Blob Storage data source/sink
 */
#suppress "@azure-tools/typespec-client-generator-core/legacy-hierarchy-building-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  BaseCosmosDataTransferDataSourceSink
)
model AzureBlobDataTransferDataSourceSink extends DataTransferDataSourceSink {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  containerName: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endpointUrl?: string;
  component: DataTransferComponent.AzureBlobStorage;
}

/**
 * Describes the service response property.
 */
model DataTransferServiceResource {
  /**
   * Properties for DataTransferServiceResource.
   */
  properties?: DataTransferServiceResourceProperties;
}

/**
 * Properties for DataTransferServiceResource.
 */
model DataTransferServiceResourceProperties extends ServiceResourceProperties {
  /**
   * An array that contains all of the locations for the service.
   */
  @visibility(Lifecycle.Read)
  locations?: DataTransferRegionalServiceResource[];

  /**
   * ServiceType for the service.
   */
  serviceType: "DataTransfer";
}

/**
 * Resource for a regional service location.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataTransferRegionalServiceResource extends RegionalServiceResource {}

/**
 * Resource for a regional service location.
 */
model RegionalServiceResource {
  /**
   * The regional service name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The location name.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Describes the status of a service.
   */
  @visibility(Lifecycle.Read)
  status?: ServiceStatus;
}

/**
 * Properties for Create or Update request for DataTransferServiceResource
 */
model DataTransferServiceResourceCreateUpdateProperties
  extends ServiceResourceCreateUpdateProperties {
  /**
   * ServiceType for the service.
   */
  serviceType: "DataTransfer";
}

/**
 * Properties for Create or Update request for SqlDedicatedGatewayServiceResource
 */
model SqlDedicatedGatewayServiceResourceCreateUpdateProperties
  extends ServiceResourceCreateUpdateProperties {
  /**
   * DedicatedGatewayType for the service.
   */
  dedicatedGatewayType?: DedicatedGatewayType;

  /**
   * ServiceType for the service.
   */
  serviceType: "SqlDedicatedGateway";
}

/**
 * Describes the service response property for SqlDedicatedGateway.
 */
model SqlDedicatedGatewayServiceResource {
  /**
   * Properties for SqlDedicatedGatewayServiceResource.
   */
  properties?: SqlDedicatedGatewayServiceResourceProperties;
}

/**
 * Properties for SqlDedicatedGatewayServiceResource.
 */
model SqlDedicatedGatewayServiceResourceProperties
  extends ServiceResourceProperties {
  /**
   * SqlDedicatedGateway endpoint for the service.
   */
  sqlDedicatedGatewayEndpoint?: string;

  /**
   * DedicatedGatewayType for the service.
   */
  dedicatedGatewayType?: DedicatedGatewayType;

  /**
   * An array that contains all of the locations for the service.
   */
  @visibility(Lifecycle.Read)
  locations?: SqlDedicatedGatewayRegionalServiceResource[];

  /**
   * ServiceType for the service.
   */
  serviceType: "SqlDedicatedGateway";
}

/**
 * Resource for a regional service location.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlDedicatedGatewayRegionalServiceResource
  extends RegionalServiceResource {
  /**
   * The regional endpoint for SqlDedicatedGateway.
   */
  @visibility(Lifecycle.Read)
  sqlDedicatedGatewayEndpoint?: string;
}

/**
 * Describes the service response property for GraphAPICompute.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GraphAPIComputeServiceResource {
  /**
   * Properties for GraphAPIComputeServiceResource.
   */
  properties?: GraphAPIComputeServiceResourceProperties;
}

/**
 * Properties for GraphAPIComputeServiceResource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GraphAPIComputeServiceResourceProperties
  extends ServiceResourceProperties {
  /**
   * GraphAPICompute endpoint for the service.
   */
  graphApiComputeEndpoint?: string;

  /**
   * An array that contains all of the locations for the service.
   */
  @visibility(Lifecycle.Read)
  locations?: GraphAPIComputeRegionalServiceResource[];

  /**
   * ServiceType for the service.
   */
  serviceType: "GraphAPICompute";
}

/**
 * Resource for a regional service location.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GraphAPIComputeRegionalServiceResource extends RegionalServiceResource {
  /**
   * The regional endpoint for GraphAPICompute.
   */
  @visibility(Lifecycle.Read)
  graphApiComputeEndpoint?: string;
}

/**
 * Properties for Create or Update request for GraphAPIComputeServiceResource
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GraphAPIComputeServiceResourceCreateUpdateProperties
  extends ServiceResourceCreateUpdateProperties {
  /**
   * ServiceType for the service.
   */
  serviceType: "GraphAPICompute";
}

/**
 * Describes the service response property for MaterializedViewsBuilder.
 */
model MaterializedViewsBuilderServiceResource {
  /**
   * Properties for MaterializedViewsBuilderServiceResource.
   */
  properties?: MaterializedViewsBuilderServiceResourceProperties;
}

/**
 * Properties for MaterializedViewsBuilderServiceResource.
 */
model MaterializedViewsBuilderServiceResourceProperties
  extends ServiceResourceProperties {
  /**
   * An array that contains all of the locations for the service.
   */
  @visibility(Lifecycle.Read)
  locations?: MaterializedViewsBuilderRegionalServiceResource[];

  /**
   * ServiceType for the service.
   */
  serviceType: "MaterializedViewsBuilder";
}

/**
 * Resource for a regional service location.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MaterializedViewsBuilderRegionalServiceResource
  extends RegionalServiceResource {}

/**
 * Properties for Create or Update request for MaterializedViewsBuilderServiceResource
 */
model MaterializedViewsBuilderServiceResourceCreateUpdateProperties
  extends ServiceResourceCreateUpdateProperties {
  /**
   * ServiceType for the service.
   */
  serviceType: "MaterializedViewsBuilder";
}

/**
 * Parameters for creating a Azure Cosmos DB throughput pool account.
 */
model ThroughputPoolAccountCreateParameters {
  /**
   * Tags are a list of key-value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups). A maximum of 15 tags can be provided for a resource. Each tag must have a key no greater than 128 characters and value no greater than 256 characters. For example, the default experience for a template type is set with "defaultExperience": "Cassandra". Current "defaultExperience" values also include "Table", "Graph", "DocumentDB", and "MongoDB".
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Properties to update Azure Cosmos DB throughput pool.
   */
  properties?: ThroughputPoolAccountCreateProperties;
}

/**
 * Properties to update Azure Cosmos DB throughput pool.
 */
model ThroughputPoolAccountCreateProperties {
  /**
   * The resource identifier of global database account in the throughputPool.
   */
  accountResourceIdentifier?: string;

  /**
   * The location of global database account in the throughputPool.
   */
  accountLocation?: string;
}
