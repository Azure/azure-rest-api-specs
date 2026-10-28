import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace KustoPools;

/**
 * Message providing the reason why the given name is invalid.
 */
union Reason {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * AlreadyExists
   */
  AlreadyExists: "AlreadyExists",
}

/**
 * SKU name.
 */
union SkuName {
  string,

  /**
   * Compute optimized
   */
  `Compute optimized`: "Compute optimized",

  /**
   * Storage optimized
   */
  `Storage optimized`: "Storage optimized",
}

/**
 * SKU size.
 */
union SkuSize {
  string,

  /**
   * Extra small
   */
  `Extra small`: "Extra small",

  /**
   * Small
   */
  Small: "Small",

  /**
   * Medium
   */
  Medium: "Medium",

  /**
   * Large
   */
  Large: "Large",
}

/**
 * The state of the resource.
 */
union State {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Unavailable
   */
  Unavailable: "Unavailable",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Deleted
   */
  Deleted: "Deleted",

  /**
   * Stopping
   */
  Stopping: "Stopping",

  /**
   * Stopped
   */
  Stopped: "Stopped",

  /**
   * Starting
   */
  Starting: "Starting",

  /**
   * Updating
   */
  Updating: "Updating",
}

/**
 * The provisioned state of the resource.
 */
union ResourceProvisioningState {
  string,

  /**
   * Running
   */
  Running: "Running",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Moving
   */
  Moving: "Moving",

  /**
   * Canceled
   */
  Canceled: "Canceled",
}

/**
 * Language extension that can run within KQL query.
 */
union LanguageExtensionName {
  string,

  /**
   * PYTHON
   */
  PYTHON: "PYTHON",

  /**
   * R
   */
  R: "R",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * Scale type.
 */
union AzureScaleType {
  string,

  /**
   * automatic
   */
  automatic: "automatic",

  /**
   * manual
   */
  manual: "manual",

  /**
   * none
   */
  none: "none",
}

/**
 * The default principals modification kind
 */
union DefaultPrincipalsModificationKind {
  string,

  /**
   * Union
   */
  Union: "Union",

  /**
   * Replace
   */
  Replace: "Replace",

  /**
   * None
   */
  None: "None",
}

/**
 * Kind of the database
 */
union Kind {
  string,

  /**
   * ReadWrite
   */
  ReadWrite: "ReadWrite",

  /**
   * ReadOnlyFollowing
   */
  ReadOnlyFollowing: "ReadOnlyFollowing",
}

/**
 * Kind of the endpoint for the data connection
 */
union DataConnectionKind {
  string,

  /**
   * EventHub
   */
  EventHub: "EventHub",

  /**
   * EventGrid
   */
  EventGrid: "EventGrid",

  /**
   * IotHub
   */
  IotHub: "IotHub",
}

/**
 * Cluster principal role.
 */
union ClusterPrincipalRole {
  string,

  /**
   * AllDatabasesAdmin
   */
  AllDatabasesAdmin: "AllDatabasesAdmin",

  /**
   * AllDatabasesViewer
   */
  AllDatabasesViewer: "AllDatabasesViewer",
}

/**
 * Principal type.
 */
union PrincipalType {
  string,

  /**
   * App
   */
  App: "App",

  /**
   * Group
   */
  Group: "Group",

  /**
   * User
   */
  User: "User",
}

/**
 * Database principal role.
 */
union DatabasePrincipalRole {
  string,

  /**
   * Admin
   */
  Admin: "Admin",

  /**
   * Ingestor
   */
  Ingestor: "Ingestor",

  /**
   * Monitor
   */
  Monitor: "Monitor",

  /**
   * User
   */
  User: "User",

  /**
   * UnrestrictedViewer
   */
  UnrestrictedViewer: "UnrestrictedViewer",

  /**
   * Viewer
   */
  Viewer: "Viewer",
}

/**
 * The principals modification kind of the database
 */
union PrincipalsModificationKind {
  string,

  /**
   * Union
   */
  Union: "Union",

  /**
   * Replace
   */
  Replace: "Replace",

  /**
   * None
   */
  None: "None",
}

/**
 * The data format of the message. Optionally the data format can be added to each message.
 */
union EventHubDataFormat {
  string,

  /**
   * MULTIJSON
   */
  MULTIJSON: "MULTIJSON",

  /**
   * JSON
   */
  JSON: "JSON",

  /**
   * CSV
   */
  CSV: "CSV",

  /**
   * TSV
   */
  TSV: "TSV",

  /**
   * SCSV
   */
  SCSV: "SCSV",

  /**
   * SOHSV
   */
  SOHSV: "SOHSV",

  /**
   * PSV
   */
  PSV: "PSV",

  /**
   * TXT
   */
  TXT: "TXT",

  /**
   * RAW
   */
  RAW: "RAW",

  /**
   * SINGLEJSON
   */
  SINGLEJSON: "SINGLEJSON",

  /**
   * AVRO
   */
  AVRO: "AVRO",

  /**
   * TSVE
   */
  TSVE: "TSVE",

  /**
   * PARQUET
   */
  PARQUET: "PARQUET",

  /**
   * ORC
   */
  ORC: "ORC",

  /**
   * APACHEAVRO
   */
  APACHEAVRO: "APACHEAVRO",

  /**
   * W3CLOGFILE
   */
  W3CLOGFILE: "W3CLOGFILE",
}

/**
 * The compression type
 */
union Compression {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * GZip
   */
  GZip: "GZip",
}

/**
 * The data format of the message. Optionally the data format can be added to each message.
 */
union IotHubDataFormat {
  string,

  /**
   * MULTIJSON
   */
  MULTIJSON: "MULTIJSON",

  /**
   * JSON
   */
  JSON: "JSON",

  /**
   * CSV
   */
  CSV: "CSV",

  /**
   * TSV
   */
  TSV: "TSV",

  /**
   * SCSV
   */
  SCSV: "SCSV",

  /**
   * SOHSV
   */
  SOHSV: "SOHSV",

  /**
   * PSV
   */
  PSV: "PSV",

  /**
   * TXT
   */
  TXT: "TXT",

  /**
   * RAW
   */
  RAW: "RAW",

  /**
   * SINGLEJSON
   */
  SINGLEJSON: "SINGLEJSON",

  /**
   * AVRO
   */
  AVRO: "AVRO",

  /**
   * TSVE
   */
  TSVE: "TSVE",

  /**
   * PARQUET
   */
  PARQUET: "PARQUET",

  /**
   * ORC
   */
  ORC: "ORC",

  /**
   * APACHEAVRO
   */
  APACHEAVRO: "APACHEAVRO",

  /**
   * W3CLOGFILE
   */
  W3CLOGFILE: "W3CLOGFILE",
}

/**
 * The data format of the message. Optionally the data format can be added to each message.
 */
union EventGridDataFormat {
  string,

  /**
   * MULTIJSON
   */
  MULTIJSON: "MULTIJSON",

  /**
   * JSON
   */
  JSON: "JSON",

  /**
   * CSV
   */
  CSV: "CSV",

  /**
   * TSV
   */
  TSV: "TSV",

  /**
   * SCSV
   */
  SCSV: "SCSV",

  /**
   * SOHSV
   */
  SOHSV: "SOHSV",

  /**
   * PSV
   */
  PSV: "PSV",

  /**
   * TXT
   */
  TXT: "TXT",

  /**
   * RAW
   */
  RAW: "RAW",

  /**
   * SINGLEJSON
   */
  SINGLEJSON: "SINGLEJSON",

  /**
   * AVRO
   */
  AVRO: "AVRO",

  /**
   * TSVE
   */
  TSVE: "TSVE",

  /**
   * PARQUET
   */
  PARQUET: "PARQUET",

  /**
   * ORC
   */
  ORC: "ORC",

  /**
   * APACHEAVRO
   */
  APACHEAVRO: "APACHEAVRO",

  /**
   * W3CLOGFILE
   */
  W3CLOGFILE: "W3CLOGFILE",
}

/**
 * The name of blob storage event type to process.
 */
union BlobStorageEventType {
  string,

  /**
   * Microsoft.Storage.BlobCreated
   */
  `Microsoft.Storage.BlobCreated`: "Microsoft.Storage.BlobCreated",

  /**
   * Microsoft.Storage.BlobRenamed
   */
  `Microsoft.Storage.BlobRenamed`: "Microsoft.Storage.BlobRenamed",
}

/**
 * The type of resource, for instance Microsoft.Synapse/workspaces/kustoPools/databases.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum Type {
  /**
   * Microsoft.Synapse/workspaces/kustoPools/databases
   */
  `Microsoft.Synapse/workspaces/kustoPools/databases`,

  /**
   * Microsoft.Synapse/workspaces/kustoPools/attachedDatabaseConfigurations
   */
  `Microsoft.Synapse/workspaces/kustoPools/attachedDatabaseConfigurations`,
}

/**
 * Result of the request to list REST API operations. It contains a list of operations and a URL nextLink to get the next set of results.
 */
model OperationListResult is Azure.Core.Page<Operation>;

/**
 * A REST API operation
 */
model Operation {
  /**
   * This is of the format {provider}/{resource}/{operation}.
   */
  name?: string;

  /**
   * The object that describes the operation.
   */
  display?: OperationDisplay;

  /**
   * The intended executor of the operation.
   */
  origin?: string;

  /**
   * Properties of the operation.
   */
  properties?: unknown;
}

/**
 * The object that describes the operation.
 */
model OperationDisplay {
  /**
   * Friendly name of the resource provider.
   */
  provider?: string;

  /**
   * For example: read, write, delete.
   */
  operation?: string;

  /**
   * The resource type on which the operation is performed.
   */
  resource?: string;

  /**
   * The friendly name of the operation.
   */
  description?: string;
}

/**
 * The list of the SKU descriptions
 */
model SkuDescriptionList {
  /**
   * SKU descriptions
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: SkuDescription[];
}

/**
 * The Kusto SKU description of given resource type
 */
model SkuDescription {
  /**
   * The resource type
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * The name of the SKU
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The size of the SKU
   */
  @visibility(Lifecycle.Read)
  size?: string;

  /**
   * The set of locations that the SKU is available
   */
  @visibility(Lifecycle.Read)
  locations?: string[];

  /**
   * Locations and zones
   */
  @visibility(Lifecycle.Read)
  locationInfo?: SkuLocationInfoItem[];

  /**
   * The restrictions because of which SKU cannot be used
   */
  @visibility(Lifecycle.Read)
  restrictions?: unknown[];
}

/**
 * The locations and zones info for SKU.
 */
model SkuLocationInfoItem {
  /**
   * The available location of the SKU.
   */
  location: string;

  /**
   * The available zone of the SKU.
   */
  zones?: string[];
}

/**
 * The object sent for a kusto pool check name availability request.
 */
model KustoPoolCheckNameRequest {
  /**
   * Kusto Pool name.
   */
  name: string;

  /**
   * The type of resource, Microsoft.Synapse/workspaces/kustoPools.
   */
  type: "Microsoft.Synapse/workspaces/kustoPools";
}

/**
 * The result returned from a check name availability request.
 */
model CheckNameResult {
  /**
   * Specifies a Boolean value that indicates if the name is available.
   */
  nameAvailable?: boolean;

  /**
   * The name that was checked.
   */
  name?: string;

  /**
   * Message indicating an unavailable name due to a conflict, or a description of the naming rules that are violated.
   */
  message?: string;

  /**
   * Message providing the reason why the given name is invalid.
   */
  reason?: Reason;
}

/**
 * The list Kusto pools operation response.
 */
model KustoPoolListResult {
  /**
   * The list of Kusto pools.
   */
  @pageItems
  value?: KustoPool[];
}

/**
 * Azure SKU definition.
 */
model AzureSku {
  /**
   * SKU name.
   */
  name: SkuName;

  /**
   * The number of instances of the cluster.
   */
  capacity?: int32;

  /**
   * SKU size.
   */
  size: SkuSize;
}

/**
 * Class representing the Kusto pool properties.
 */
model KustoPoolProperties {
  /**
   * The state of the resource.
   */
  @visibility(Lifecycle.Read)
  state?: State;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The Kusto Pool URI.
   */
  @visibility(Lifecycle.Read)
  uri?: string;

  /**
   * The Kusto Pool data ingestion URI.
   */
  @visibility(Lifecycle.Read)
  dataIngestionUri?: string;

  /**
   * The reason for the Kusto Pool's current state.
   */
  @visibility(Lifecycle.Read)
  stateReason?: string;

  /**
   * Optimized auto scale definition.
   */
  optimizedAutoscale?: OptimizedAutoscale;

  /**
   * A boolean value that indicates if the streaming ingest is enabled.
   */
  enableStreamingIngest?: boolean;

  /**
   * A boolean value that indicates if the purge operations are enabled.
   */
  enablePurge?: boolean;

  /**
   * List of the Kusto Pool's language extensions.
   */
  @visibility(Lifecycle.Read)
  languageExtensions?: LanguageExtensionsList;

  /**
   * The workspace unique identifier.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  workspaceUID?: string;
}

/**
 * A class that contains the optimized auto scale definition.
 */
model OptimizedAutoscale {
  /**
   * The version of the template defined, for instance 1.
   */
  version: int32;

  /**
   * A boolean value that indicate if the optimized autoscale feature is enabled or not.
   */
  isEnabled: boolean;

  /**
   * Minimum allowed instances count.
   */
  minimum: int32;

  /**
   * Maximum allowed instances count.
   */
  maximum: int32;
}

/**
 * The list of language extension objects.
 */
model LanguageExtensionsList {
  /**
   * The list of language extensions.
   */
  @pageItems
  value?: LanguageExtension[];
}

/**
 * The language extension object.
 */
model LanguageExtension {
  /**
   * The language extension name.
   */
  languageExtensionName?: LanguageExtensionName;
}

/**
 * Class representing an update to a Kusto kusto pool.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model KustoPoolUpdate extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * The SKU of the kusto pool.
   */
  sku?: AzureSku;

  /**
   * The kusto pool properties.
   */
  properties?: KustoPoolProperties;
}

/**
 * List of available SKUs for a Kusto Pool.
 */
model ListResourceSkusResult {
  /**
   * The collection of available SKUs for an existing resource.
   */
  @pageItems
  value?: AzureResourceSku[];
}

/**
 * Azure resource SKU definition.
 */
model AzureResourceSku {
  /**
   * Resource Namespace and Type.
   */
  resourceType?: string;

  /**
   * The SKU details.
   */
  sku?: AzureSku;

  /**
   * The number of instances of the cluster.
   */
  capacity?: AzureCapacity;
}

/**
 * Azure capacity definition.
 */
model AzureCapacity {
  /**
   * Scale type.
   */
  scaleType: AzureScaleType;

  /**
   * Minimum allowed capacity.
   */
  minimum: int32;

  /**
   * Maximum allowed capacity.
   */
  maximum: int32;

  /**
   * The default capacity that would be used.
   */
  default: int32;
}

/**
 * The result returned from a database check name availability request.
 */
model DatabaseCheckNameRequest {
  /**
   * Resource name.
   */
  name: string;

  /**
   * The type of resource, for instance Microsoft.Synapse/workspaces/kustoPools/databases.
   */
  type: Type;
}

/**
 * The list Kusto database principals operation response.
 */
model FollowerDatabaseListResult {
  /**
   * The list of follower database result.
   */
  @pageItems
  value?: FollowerDatabaseDefinition[];
}

/**
 * A class representing follower database request.
 */
model FollowerDatabaseDefinition {
  /**
   * Resource id of the cluster that follows a database owned by this cluster.
   */
  clusterResourceId: string;

  /**
   * Resource name of the attached database configuration in the follower cluster.
   */
  attachedDatabaseConfigurationName: string;

  /**
   * The database name owned by this cluster that was followed. * in case following all databases.
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;
}

/**
 * The list attached database configurations operation response.
 */
model AttachedDatabaseConfigurationListResult {
  /**
   * The list of attached database configurations.
   */
  @pageItems
  value?: AttachedDatabaseConfiguration[];
}

/**
 * Class representing the an attached database configuration properties of kind specific.
 */
model AttachedDatabaseConfigurationProperties {
  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The name of the database which you would like to attach, use * if you want to follow all current and future databases.
   */
  databaseName: string;

  /**
   * The resource id of the kusto pool where the databases you would like to attach reside.
   */
  clusterResourceId: string;

  /**
   * The list of databases from the clusterResourceId which are currently attached to the kusto pool.
   */
  @visibility(Lifecycle.Read)
  attachedDatabaseNames?: string[];

  /**
   * The default principals modification kind
   */
  defaultPrincipalsModificationKind: DefaultPrincipalsModificationKind;

  /**
   * Table level sharing specifications
   */
  tableLevelSharingProperties?: TableLevelSharingProperties;
}

/**
 * Tables that will be included and excluded in the follower database
 */
model TableLevelSharingProperties {
  /**
   * List of tables to include in the follower database
   */
  tablesToInclude?: string[];

  /**
   * List of tables to exclude from the follower database
   */
  tablesToExclude?: string[];

  /**
   * List of external tables to include in the follower database
   */
  externalTablesToInclude?: string[];

  /**
   * List of external tables exclude from the follower database
   */
  externalTablesToExclude?: string[];

  /**
   * List of materialized views to include in the follower database
   */
  materializedViewsToInclude?: string[];

  /**
   * List of materialized views exclude from the follower database
   */
  materializedViewsToExclude?: string[];
}

/**
 * The list Kusto databases operation response.
 */
model DatabaseListResult {
  /**
   * The list of Kusto databases.
   */
  @pageItems
  value?: Database[];
}

/**
 * A data connection check name availability request.
 */
model DataConnectionCheckNameRequest {
  /**
   * Data Connection name.
   */
  name: string;

  /**
   * The type of resource, Microsoft.Synapse/workspaces/kustoPools/databases/dataConnections.
   */
  type: "Microsoft.Synapse/workspaces/kustoPools/databases/dataConnections";
}

/**
 * Class representing an data connection validation.
 */
model DataConnectionValidation {
  /**
   * The name of the data connection.
   */
  dataConnectionName?: string;

  /**
   * The data connection properties to validate.
   */
  properties?: DataConnection;
}

/**
 * The list Kusto data connection validation result.
 */
model DataConnectionValidationListResult {
  /**
   * The list of Kusto data connection validation errors.
   */
  @pageItems
  value?: DataConnectionValidationResult[];
}

/**
 * The result returned from a data connection validation request.
 */
model DataConnectionValidationResult {
  /**
   * A message which indicates a problem in data connection validation.
   */
  errorMessage?: string;
}

/**
 * The list Kusto data connections operation response.
 */
model DataConnectionListResult {
  /**
   * The list of Kusto data connections.
   */
  @pageItems
  value?: DataConnection[];
}

/**
 * A principal assignment check name availability request.
 */
model ClusterPrincipalAssignmentCheckNameRequest {
  /**
   * Principal Assignment resource name.
   */
  name: string;

  /**
   * The type of resource, Microsoft.Synapse/workspaces/kustoPools/principalAssignments.
   */
  type: "Microsoft.Synapse/workspaces/kustoPools/principalAssignments";
}

/**
 * The list Kusto cluster principal assignments operation response.
 */
model ClusterPrincipalAssignmentListResult {
  /**
   * The list of Kusto cluster principal assignments.
   */
  @pageItems
  value?: ClusterPrincipalAssignment[];
}

/**
 * A class representing cluster principal property.
 */
model ClusterPrincipalProperties {
  /**
   * The principal ID assigned to the cluster principal. It can be a user email, application ID, or security group name.
   */
  principalId: string;

  /**
   * Cluster principal role.
   */
  role: ClusterPrincipalRole;

  /**
   * The tenant id of the principal
   */
  tenantId?: string;

  /**
   * Principal type.
   */
  principalType: PrincipalType;

  /**
   * The tenant name of the principal
   */
  @visibility(Lifecycle.Read)
  tenantName?: string;

  /**
   * The principal name
   */
  @visibility(Lifecycle.Read)
  principalName?: string;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The service principal object id in AAD (Azure active directory)
   */
  @visibility(Lifecycle.Read)
  aadObjectId?: string;
}

/**
 * A principal assignment check name availability request.
 */
model DatabasePrincipalAssignmentCheckNameRequest {
  /**
   * Principal Assignment resource name.
   */
  name: string;

  /**
   * The type of resource, Microsoft.Synapse/workspaces/kustoPools/databases/principalAssignments.
   */
  type: "Microsoft.Synapse/workspaces/kustoPools/databases/principalAssignments";
}

/**
 * The list Kusto database principal assignments operation response.
 */
model DatabasePrincipalAssignmentListResult {
  /**
   * The list of Kusto database principal assignments.
   */
  @pageItems
  value?: DatabasePrincipalAssignment[];
}

/**
 * A class representing database principal property.
 */
model DatabasePrincipalProperties {
  /**
   * The principal ID assigned to the database principal. It can be a user email, application ID, or security group name.
   */
  principalId: string;

  /**
   * Database principal role.
   */
  role: DatabasePrincipalRole;

  /**
   * The tenant id of the principal
   */
  tenantId?: string;

  /**
   * Principal type.
   */
  principalType: PrincipalType;

  /**
   * The tenant name of the principal
   */
  @visibility(Lifecycle.Read)
  tenantName?: string;

  /**
   * The principal name
   */
  @visibility(Lifecycle.Read)
  principalName?: string;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The service principal object id in AAD (Azure active directory)
   */
  @visibility(Lifecycle.Read)
  aadObjectId?: string;
}

/**
 * The list Kusto Private Link Resources operation response.
 */
model PrivateLinkResources {
  /**
   * The list of Kusto Private Link Resources.
   */
  @pageItems
  value?: KustoPoolPrivateLinkResources[];
}

/**
 * Class representing a Private Link Resources.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model KustoPoolPrivateLinkResources
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * The Private Link Resources.
   */
  properties?: PrivateLinkResourcesProperties;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Private Link Resources Properties.
 */
model PrivateLinkResourcesProperties {
  /**
   * The Private link resources GroupId
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

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

/**
 * Class representing a read write database.
 */
model ReadWriteDatabase extends Database {
  /**
   * The database properties.
   */
  properties?: ReadWriteDatabaseProperties;

  /**
   * Kind of the database
   */
  kind: "ReadWrite";
}

/**
 * Class representing the Kusto database properties.
 */
model ReadWriteDatabaseProperties {
  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The time the data should be kept before it stops being accessible to queries in TimeSpan.
   */
  softDeletePeriod?: duration;

  /**
   * The time the data should be kept in cache for fast queries in TimeSpan.
   */
  hotCachePeriod?: duration;

  /**
   * The statistics of the database.
   */
  @visibility(Lifecycle.Read)
  statistics?: DatabaseStatistics;

  /**
   * Indicates whether the database is followed.
   */
  @visibility(Lifecycle.Read)
  isFollowed?: boolean;
}

/**
 * A class that contains database statistics information.
 */
model DatabaseStatistics {
  /**
   * The database size - the total size of compressed data and index in bytes.
   */
  size?: float32;
}

/**
 * Class representing a read only following database.
 */
model ReadOnlyFollowingDatabase extends Database {
  /**
   * The database properties.
   */
  properties?: ReadOnlyFollowingDatabaseProperties;

  /**
   * Kind of the database
   */
  kind: "ReadOnlyFollowing";
}

/**
 * Class representing the Kusto database properties.
 */
model ReadOnlyFollowingDatabaseProperties {
  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The time the data should be kept before it stops being accessible to queries in TimeSpan.
   */
  @visibility(Lifecycle.Read)
  softDeletePeriod?: duration;

  /**
   * The time the data should be kept in cache for fast queries in TimeSpan.
   */
  hotCachePeriod?: duration;

  /**
   * The statistics of the database.
   */
  @visibility(Lifecycle.Read)
  statistics?: DatabaseStatistics;

  /**
   * The name of the leader cluster
   */
  @visibility(Lifecycle.Read)
  leaderClusterResourceId?: string;

  /**
   * The name of the attached database configuration cluster
   */
  @visibility(Lifecycle.Read)
  attachedDatabaseConfigurationName?: string;

  /**
   * The principals modification kind of the database
   */
  @visibility(Lifecycle.Read)
  principalsModificationKind?: PrincipalsModificationKind;
}

/**
 * Class representing an event hub data connection.
 */
model EventHubDataConnection extends DataConnection {
  /**
   * The Event Hub data connection properties to validate.
   */
  properties?: EventHubConnectionProperties;

  /**
   * Kind of the endpoint for the data connection
   */
  kind: "EventHub";
}

/**
 * Class representing the Kusto event hub connection properties.
 */
model EventHubConnectionProperties {
  /**
   * The resource ID of the event hub to be used to create a data connection.
   */
  eventHubResourceId: string;

  /**
   * The event hub consumer group.
   */
  consumerGroup: string;

  /**
   * The table where the data should be ingested. Optionally the table information can be added to each message.
   */
  tableName?: string;

  /**
   * The mapping rule to be used to ingest the data. Optionally the mapping information can be added to each message.
   */
  mappingRuleName?: string;

  /**
   * The data format of the message. Optionally the data format can be added to each message.
   */
  dataFormat?: EventHubDataFormat;

  /**
   * System properties of the event hub
   */
  eventSystemProperties?: string[];

  /**
   * The event hub messages compression type
   */
  compression?: Compression;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The resource ID of a managed identity (system or user assigned) to be used to authenticate with event hub.
   */
  managedIdentityResourceId?: string;
}

/**
 * Class representing an iot hub data connection.
 */
model IotHubDataConnection extends DataConnection {
  /**
   * The Iot Hub data connection properties.
   */
  properties?: IotHubConnectionProperties;

  /**
   * Kind of the endpoint for the data connection
   */
  kind: "IotHub";
}

/**
 * Class representing the Kusto Iot hub connection properties.
 */
model IotHubConnectionProperties {
  /**
   * The resource ID of the Iot hub to be used to create a data connection.
   */
  iotHubResourceId: string;

  /**
   * The iot hub consumer group.
   */
  consumerGroup: string;

  /**
   * The table where the data should be ingested. Optionally the table information can be added to each message.
   */
  tableName?: string;

  /**
   * The mapping rule to be used to ingest the data. Optionally the mapping information can be added to each message.
   */
  mappingRuleName?: string;

  /**
   * The data format of the message. Optionally the data format can be added to each message.
   */
  dataFormat?: IotHubDataFormat;

  /**
   * System properties of the iot hub
   */
  eventSystemProperties?: string[];

  /**
   * The name of the share access policy
   */
  sharedAccessPolicyName: string;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

/**
 * Class representing an Event Grid data connection.
 */
model EventGridDataConnection extends DataConnection {
  /**
   * The properties of the Event Grid data connection.
   */
  properties?: EventGridConnectionProperties;

  /**
   * Kind of the endpoint for the data connection
   */
  kind: "EventGrid";
}

/**
 * Class representing the Kusto event grid connection properties.
 */
model EventGridConnectionProperties {
  /**
   * The resource ID of the storage account where the data resides.
   */
  storageAccountResourceId: string;

  /**
   * The resource ID where the event grid is configured to send events.
   */
  eventHubResourceId: string;

  /**
   * The event hub consumer group.
   */
  consumerGroup: string;

  /**
   * The table where the data should be ingested. Optionally the table information can be added to each message.
   */
  tableName?: string;

  /**
   * The mapping rule to be used to ingest the data. Optionally the mapping information can be added to each message.
   */
  mappingRuleName?: string;

  /**
   * The data format of the message. Optionally the data format can be added to each message.
   */
  dataFormat?: EventGridDataFormat;

  /**
   * A Boolean value that, if set to true, indicates that ingestion should ignore the first record of every file
   */
  ignoreFirstRecord?: boolean;

  /**
   * The name of blob storage event type to process.
   */
  blobStorageEventType?: BlobStorageEventType;

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}
