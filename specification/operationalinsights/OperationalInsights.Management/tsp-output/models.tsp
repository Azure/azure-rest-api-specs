import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.OperationalInsights;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The type of the destination resource
 */
enum OperationalInsightsDataExportDestinationType {
  StorageAccount,
  EventHub,
}

/**
 * The kind of the DataSource.
 */
enum DataSourceKind {
  WindowsEvent,
  WindowsPerformanceCounter,
  IISLogs,
  LinuxSyslog,
  LinuxSyslogCollection,
  LinuxPerformanceObject,
  LinuxPerformanceCollection,
  CustomLog,
  CustomLogCollection,
  AzureAuditLog,
  AzureActivityLog,
  GenericDataSource,
  ChangeTrackingCustomPath,
  ChangeTrackingPath,
  ChangeTrackingServices,
  ChangeTrackingDataTypeConfiguration,
  ChangeTrackingDefaultRegistry,
  ChangeTrackingRegistry,
  ChangeTrackingLinuxPath,
  LinuxChangeTrackingPath,
  ChangeTrackingContentLocation,
  WindowsTelemetry,
  Office365,
  SecurityWindowsBaselineConfiguration,
  SecurityCenterSecurityWindowsBaselineConfiguration,
  SecurityEventCollectionConfiguration,
  SecurityInsightsSecurityEventCollectionConfiguration,
  ImportComputerGroup,
  NetworkMonitoring,
  Itsm,
  DnsAnalytics,
  ApplicationInsights,
  SqlDataClassification,
}

/**
 * The provisioning state of the linked service.
 */
enum LinkedServiceEntityStatus {
  Succeeded,
  Deleting,
  ProvisioningAccount,
  Updating,
}

/**
 * The state of the storage insight connection to the workspace
 */
enum StorageInsightState {
  OK,
  ERROR,
}

/**
 * The name of the Service Tier.
 */
enum SkuNameEnum {
  Free,
  Standard,
  Premium,
  PerNode,
  PerGB2018,
  Standalone,
  CapacityReservation,
}

/**
 * The sort order of the search.
 */
enum SearchSortEnum {
  asc,
  desc,
}

/**
 * Status of the operation represented by the requested Id.
 */
enum PurgeState {
  pending,
  completed,
}

/**
 * The name of the SKU.
 */
enum ClusterSkuNameEnum {
  CapacityReservation,
}

/**
 * The provisioning state of the cluster.
 */
enum ClusterEntityStatus {
  Creating,
  Succeeded,
  Failed,
  Canceled,
  Deleting,
  ProvisioningAccount,
  Updating,
}

/**
 * Configures whether billing will be only on the cluster or each workspace will be billed by its proportional use. This does not change the overall billing, only how it will be distributed. Default value is 'Cluster'
 */
enum BillingType {
  Cluster,
  Workspaces,
}

/**
 * The provisioning state of the workspace.
 */
enum WorkspaceEntityStatus {
  Creating,
  Succeeded,
  Failed,
  Canceled,
  Deleting,
  ProvisioningAccount,
  Updating,
}

/**
 * The name of the SKU.
 */
enum WorkspaceSkuNameEnum {
  Free,
  Standard,
  Premium,
  PerNode,
  PerGB2018,
  Standalone,
  CapacityReservation,
  LACluster,
}

/**
 * The status of data ingestion for this workspace.
 */
enum DataIngestionStatus {
  /**
   * Ingestion enabled following daily cap quota reset, or subscription enablement.
   */
  RespectQuota,

  /**
   * Ingestion started following service setting change.
   */
  ForceOn,

  /**
   * Ingestion stopped following service setting change.
   */
  ForceOff,

  /**
   * Reached daily cap quota, ingestion stopped.
   */
  OverQuota,

  /**
   * Ingestion stopped following suspended subscription.
   */
  SubscriptionSuspended,

  /**
   * 80% of daily cap quota reached.
   */
  ApproachingQuota,
}

/**
 * The network access type for operating on the Log Analytics Workspace. By default it is Enabled
 */
enum PublicNetworkAccessType {
  /**
   * Enables connectivity to Log Analytics through public DNS.
   */
  Enabled,

  /**
   * Disables public connectivity to Log Analytics through public DNS.
   */
  Disabled,
}

/**
 * Instruct the system how to handle and charge the logs ingested to this table.
 */
enum TablePlanEnum {
  /**
   * Logs  that are adjusted to support high volume low value verbose logs.
   */
  Basic,

  /**
   * Logs  that allow monitoring and analytics.
   */
  Analytics,
}

/**
 * Column data type.
 */
enum ColumnTypeEnum {
  string,
  int,
  long,
  real,
  boolean,
  dateTime,
  guid,
  dynamic,
}

/**
 * Column data type logical hint.
 */
enum ColumnDataTypeHintEnum {
  /**
   * A string that matches the pattern of a URI, for example, scheme://username:password@host:1234/this/is/a/path?k1=v1&k2=v2#fragment
   */
  uri,

  /**
   * A standard 128-bit GUID following the standard shape, xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
   */
  guid,

  /**
   * An Azure Resource Model (ARM) path: /subscriptions/{...}/resourceGroups/{...}/providers/Microsoft.{...}/{...}/{...}/{...}...
   */
  armPath,

  /**
   * A standard V4/V6 ip address following the standard shape, x.x.x.x/y:y:y:y:y:y:y:y
   */
  ip,
}

/**
 * Table's creator.
 */
enum SourceEnum {
  /**
   * Tables provisioned by the system, as collected via Diagnostic Settings, the Agents, or any other standard data collection means.
   */
  microsoft,

  /**
   * Tables created by the owner of the Workspace, and only found in this Workspace.
   */
  customer,
}

/**
 * Table's creator.
 */
enum TableTypeEnum {
  /**
   * Standard data collected by Azure Monitor.
   */
  Microsoft,

  /**
   * Custom log table.
   */
  CustomLog,

  /**
   * Restored data.
   */
  RestoredLogs,

  /**
   * Data collected by a search job.
   */
  SearchResults,
}

/**
 * The subtype describes what APIs can be used to interact with the table, and what features are available against it.
 */
enum TableSubTypeEnum {
  /**
   * The default subtype with which built-in tables are created.
   */
  Any,

  /**
   * Indicates a table created through the Data Collector API or with the custom logs feature of the MMA agent, or any table against which Custom Fields were created.
   */
  Classic,

  /**
   * A table eligible to have data sent into it via any of the means supported by Data Collection Rules: the Data Collection Endpoint API, ingestion-time transformations, or any other mechanism provided by Data Collection Rules
   */
  DataCollectionRuleBased,
}

/**
 * Table's current provisioning state. If set to 'updating', indicates a resource lock due to ongoing operation, forbidding any update to the table until the ongoing operation is concluded.
 */
enum ProvisioningStateEnum {
  /**
   * Table schema is still being built and updated, table is currently locked for any changes till the procedure is done.
   */
  Updating,

  /**
   * Table schema is stable and without changes, table data is being updated.
   */
  InProgress,

  /**
   * Table state is stable and without changes, table is unlocked and open for new updates.
   */
  Succeeded,

  /**
   * Table state is deleting.
   */
  Deleting,
}

/**
 * Linked storage accounts type.
 */
@fixed
enum DataSourceType {
  CustomLogs,
  AzureWatson,
  Query,
  Ingestion,
  Alerts,
}

/**
 * Type of managed service identity.
 */
@fixed
enum IdentityType {
  SystemAssigned,
  UserAssigned,
  None,
}

/**
 * The capacity value
 */
@fixed
enum Capacity {
  `500`: 500,
  `1000`: 1000,
  `2000`: 2000,
  `5000`: 5000,
}

/**
 * The capacity reservation level in GB for this workspace, when CapacityReservation sku is selected.
 */
@fixed
enum CapacityReservationLevel {
  `100`: 100,
  `200`: 200,
  `300`: 300,
  `400`: 400,
  `500`: 500,
  `1000`: 1000,
  `2000`: 2000,
  `5000`: 5000,
}

/**
 * Properties that define a Log Analytics QueryPack resource.
 */
model LogAnalyticsQueryPackProperties {
  /**
   * The unique ID of your application. This field cannot be changed.
   */
  @visibility("read")
  queryPackId?: string;

  /**
   * Creation Date for the Log Analytics QueryPack, in ISO 8601 format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeCreated?: utcDateTime;

  /**
   * Last modified date of the Log Analytics QueryPack, in ISO 8601 format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeModified?: utcDateTime;

  /**
   * Current state of this QueryPack: whether or not is has been provisioned within the resource group it is defined. Users cannot change this value but are able to read from it. Values will include Succeeded, Deploying, Canceled, and Failed.
   */
  @visibility("read")
  provisioningState?: string;
}

/**
 * An azure resource object
 */
model QueryPacksResource {
  /**
   * Azure resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Azure resource name
   */
  @visibility("read")
  name?: string;

  /**
   * Azure resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Resource location
   */
  @visibility("read", "create")
  location: string;

  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * A container holding only the Tags for a resource, allowing the user to update the tags on a QueryPack instance.
 */
model TagsResource {
  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * Properties that define an Log Analytics QueryPack-Query resource.
 */
model LogAnalyticsQueryPackQueryProperties {
  /**
   * The unique ID of your application. This field cannot be changed.
   */
  @visibility("read")
  id?: string;

  /**
   * Unique display name for your query within the Query Pack.
   */
  displayName: string;

  /**
   * Creation Date for the Log Analytics Query, in ISO 8601 format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeCreated?: utcDateTime;

  /**
   * Last modified date of the Log Analytics Query, in ISO 8601 format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeModified?: utcDateTime;

  /**
   * Object Id of user creating the query.
   */
  @visibility("read")
  author?: string;

  /**
   * Description of the query.
   */
  description?: string;

  /**
   * Body of the query.
   */
  body: string;

  /**
   * The related metadata items for the function.
   */
  related?: LogAnalyticsQueryPackQueryPropertiesRelated;

  /**
   * Tags associated with the query.
   */
  tags?: Record<string[]>;

  /**
   * Additional properties that can be set for the query.
   */
  properties?: Record<unknown>;
}

/**
 * The related metadata items for the function.
 */
model LogAnalyticsQueryPackQueryPropertiesRelated {
  /**
   * The related categories for the function.
   */
  categories?: string[];

  /**
   * The related resource types for the function.
   */
  resourceTypes?: string[];

  /**
   * The related Log Analytics solutions for the function.
   */
  solutions?: string[];
}

/**
 * An Azure resource QueryPack-Query object
 */
model AzureResourceProperties {
  /**
   * Azure resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Azure resource name
   */
  @visibility("read")
  name?: string;

  /**
   * Azure resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Read only system data
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Properties that define an Log Analytics QueryPack-Query search properties.
 */
model LogAnalyticsQueryPackQuerySearchProperties {
  /**
   * The related metadata items for the function.
   */
  related?: LogAnalyticsQueryPackQuerySearchPropertiesRelated;

  /**
   * Tags associated with the query.
   */
  tags?: Record<string[]>;
}

/**
 * The related metadata items for the function.
 */
model LogAnalyticsQueryPackQuerySearchPropertiesRelated {
  /**
   * The related categories for the function.
   */
  categories?: string[];

  /**
   * The related resource types for the function.
   */
  resourceTypes?: string[];

  /**
   * The related Log Analytics solutions for the function.
   */
  solutions?: string[];
}

/**
 * Data Export properties.
 */
model DataExportProperties {
  /**
   * The data export rule ID.
   */
  dataExportId?: string;

  /**
   * An array of tables to export, for example: [“Heartbeat, SecurityEvent”].
   */
  tableNames: string[];

  /**
   * destination properties.
   */
  destination?: Destination;

  /**
   * Active when enabled.
   */
  enable?: boolean;

  /**
   * The latest data export rule modification time.
   */
  createdDate?: string;

  /**
   * Date and time when the export was last modified.
   */
  lastModifiedDate?: string;
}

/**
 * Destination properties.
 */
model Destination {
  /**
   * The destination resource ID. This can be copied from the Properties entry of the destination resource in Azure.
   */
  resourceId: string;

  /**
   * The type of the destination resource
   */
  @visibility("read")
  @projectedName("json", "type")
  destinationType?: OperationalInsightsDataExportDestinationType;

  /**
   * destination meta data.
   */
  metaData?: DestinationMetaData;
}

/**
 * Destination meta data.
 */
model DestinationMetaData {
  /**
   * Optional. Allows to define an Event Hub name. Not applicable when destination is Storage Account.
   */
  eventHubName?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;
}

/**
 * Intelligence Pack containing a string name and boolean indicating if it's enabled.
 */
model IntelligencePack {
  /**
   * The name of the intelligence pack.
   */
  name?: string;

  /**
   * The enabled boolean for the intelligence pack.
   */
  enabled?: boolean;

  /**
   * The display name of the intelligence pack.
   */
  displayName?: string;
}

/**
 * Linked service properties.
 */
model LinkedServiceProperties {
  /**
   * The resource id of the resource that will be linked to the workspace. This should be used for linking resources which require read access
   */
  resourceId?: string;

  /**
   * The resource id of the resource that will be linked to the workspace. This should be used for linking resources which require write access
   */
  writeAccessResourceId?: string;

  /**
   * The provisioning state of the linked service.
   */
  provisioningState?: LinkedServiceEntityStatus;
}

/**
 * Linked storage accounts properties.
 */
model LinkedStorageAccountsProperties {
  /**
   * Linked storage accounts type.
   */
  @visibility("read")
  dataSourceType?: DataSourceType;

  /**
   * Linked storage accounts resources ids.
   */
  storageAccountIds?: string[];
}

/**
 * The list workspace management groups operation response.
 */
@pagedResult
model WorkspaceListManagementGroupsResult {
  /**
   * Gets or sets a list of management groups attached to the workspace.
   */
  @items
  value?: ManagementGroup[];
}

/**
 * A management group that is connected to a workspace
 */
model ManagementGroup {
  /**
   * The properties of the management group.
   */
  properties?: ManagementGroupProperties;
}

/**
 * Management group properties.
 */
model ManagementGroupProperties {
  /**
   * The number of servers connected to the management group.
   */
  serverCount?: int32;

  /**
   * Gets or sets a value indicating whether the management group is a gateway.
   */
  isGateway?: boolean;

  /**
   * The name of the management group.
   */
  name?: string;

  /**
   * The unique ID of the management group.
   */
  id?: string;

  /**
   * The datetime that the management group was created.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The last datetime that the management group received data.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  dataReceived?: utcDateTime;

  /**
   * The version of System Center that is managing the management group.
   */
  version?: string;

  /**
   * The SKU of System Center that is managing the management group.
   */
  sku?: string;
}

/**
 * The shared keys for a workspace.
 */
model SharedKeys {
  /**
   * The primary shared key of a workspace.
   */
  primarySharedKey?: string;

  /**
   * The secondary shared key of a workspace.
   */
  secondarySharedKey?: string;
}

/**
 * The list workspace usages operation response.
 */
@pagedResult
model WorkspaceListUsagesResult {
  /**
   * Gets or sets a list of usage metrics for a workspace.
   */
  @items
  value?: UsageMetric[];
}

/**
 * A metric describing the usage of a resource.
 */
model UsageMetric {
  /**
   * The name of the metric.
   */
  name?: MetricName;

  /**
   * The units used for the metric.
   */
  unit?: string;

  /**
   * The current value of the metric.
   */
  currentValue?: float64;

  /**
   * The quota limit for the metric.
   */
  limit?: float64;

  /**
   * The time that the metric's value will reset.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextResetTime?: utcDateTime;

  /**
   * The quota period that determines the length of time between value resets.
   */
  quotaPeriod?: string;
}

/**
 * The name of a metric.
 */
model MetricName {
  /**
   * The system name of the metric.
   */
  value?: string;

  /**
   * The localized name of the metric.
   */
  localizedValue?: string;
}

/**
 * Storage insight properties.
 */
model StorageInsightProperties {
  /**
   * The names of the blob containers that the workspace should read
   */
  containers?: string[];

  /**
   * The names of the Azure tables that the workspace should read
   */
  tables?: string[];

  /**
   * The storage account connection details
   */
  storageAccount: StorageAccount;

  /**
   * The status of the storage insight
   */
  @visibility("read")
  status?: StorageInsightStatus;
}

/**
 * Describes a storage account connection.
 */
model StorageAccount {
  /**
   * The Azure Resource Manager ID of the storage account resource.
   */
  id: string;

  /**
   * The storage account key.
   */
  key: string;
}

/**
 * The status of the storage insight.
 */
model StorageInsightStatus {
  /**
   * The state of the storage insight connection to the workspace
   */
  state: StorageInsightState;

  /**
   * Description of the state of the storage insight.
   */
  description?: string;
}

/**
 * Value object for saved search results.
 */
model SavedSearchProperties {
  /**
   * The category of the saved search. This helps the user to find a saved search faster.
   */
  category: string;

  /**
   * Saved search display name.
   */
  displayName: string;

  /**
   * The query expression for the saved search.
   */
  query: string;

  /**
   * The function alias if query serves as a function.
   */
  functionAlias?: string;

  /**
   * The optional function parameters if query serves as a function. Value should be in the following format: 'param-name1:type1 = default_value1, param-name2:type2 = default_value2'. For more examples and proper syntax please refer to https://docs.microsoft.com/en-us/azure/kusto/query/functions/user-defined-functions.
   */
  functionParameters?: string;

  /**
   * The version number of the query language. The current version is 2 and is the default.
   */
  version?: int64;

  /**
   * The tags attached to the saved search.
   */
  tags?: Tag[];
}

/**
 * A tag of a saved search.
 */
model Tag {
  /**
   * The tag name.
   */
  name: string;

  /**
   * The tag value.
   */
  value: string;
}

/**
 * Service Tier details.
 */
model AvailableServiceTier {
  /**
   * The name of the Service Tier.
   */
  @visibility("read")
  serviceTier?: SkuNameEnum;

  /**
   * True if the Service Tier is enabled for the workspace.
   */
  @visibility("read")
  enabled?: boolean;

  /**
   * The minimum retention for the Service Tier, in days.
   */
  @visibility("read")
  minimumRetention?: int64;

  /**
   * The maximum retention for the Service Tier, in days.
   */
  @visibility("read")
  maximumRetention?: int64;

  /**
   * The default retention for the Service Tier, in days.
   */
  @visibility("read")
  defaultRetention?: int64;

  /**
   * The capacity reservation level in GB per day. Returned for the Capacity Reservation Service Tier.
   */
  @visibility("read")
  capacityReservationLevel?: int64;

  /**
   * Time when the sku was last updated for the workspace. Returned for the Capacity Reservation Service Tier.
   */
  @visibility("read")
  lastSkuUpdate?: string;
}

/**
 * The get schema operation response.
 */
model SearchGetSchemaResponse {
  /**
   * The metadata from search results.
   */
  metadata?: SearchMetadata;

  /**
   * The array of result values.
   */
  value?: SearchSchemaValue[];
}

/**
 * Metadata for search results.
 */
model SearchMetadata {
  /**
   * The request id of the search.
   */
  @projectedName("json", "requestId")
  searchId?: string;

  /**
   * The search result type.
   */
  resultType?: string;

  /**
   * The total number of search results.
   */
  total?: int64;

  /**
   * The number of top search results.
   */
  top?: int64;

  /**
   * The id of the search results request.
   */
  id?: string;

  /**
   * The core summaries.
   */
  coreSummaries?: CoreSummary[];

  /**
   * The status of the search results.
   */
  status?: string;

  /**
   * The start time for the search.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The time of last update.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  /**
   * The ETag of the search results.
   */
  eTag?: string;

  /**
   * How the results are sorted.
   */
  sort?: SearchSort[];

  /**
   * The request time.
   */
  requestTime?: int64;

  /**
   * The aggregated value field.
   */
  aggregatedValueField?: string;

  /**
   * The aggregated grouping fields.
   */
  aggregatedGroupingFields?: string;

  /**
   * The sum of all aggregates returned in the result set.
   */
  sum?: int64;

  /**
   * The max of all aggregates returned in the result set.
   */
  max?: int64;

  /**
   * The schema.
   */
  schema?: SearchMetadataSchema;
}

/**
 * The core summary of a search.
 */
model CoreSummary {
  /**
   * The status of a core summary.
   */
  status?: string;

  /**
   * The number of documents of a core summary.
   */
  numberOfDocuments: int64;
}

/**
 * The sort parameters for search.
 */
model SearchSort {
  /**
   * The name of the field the search query is sorted on.
   */
  name?: string;

  /**
   * The sort order of the search.
   */
  order?: SearchSortEnum;
}

/**
 * Schema metadata for search.
 */
model SearchMetadataSchema {
  /**
   * The name of the metadata schema.
   */
  name?: string;

  /**
   * The version of the metadata schema.
   */
  version?: int32;
}

/**
 * Value object for schema results.
 */
model SearchSchemaValue {
  /**
   * The name of the schema.
   */
  name?: string;

  /**
   * The display name of the schema.
   */
  displayName?: string;

  /**
   * The type.
   */
  type?: string;

  /**
   * The boolean that indicates the field is searchable as free text.
   */
  indexed: boolean;

  /**
   * The boolean that indicates whether or not the field is stored.
   */
  stored: boolean;

  /**
   * The boolean that indicates whether or not the field is a facet.
   */
  facet: boolean;

  /**
   * The array of workflows containing the field.
   */
  ownerType?: string[];
}

/**
 * Describes the body of a purge request for an App Insights Workspace
 */
model WorkspacePurgeBody {
  /**
   * Table from which to purge data.
   */
  table: string;

  /**
   * The set of columns and filters (queries) to run over them to purge the resulting data.
   */
  filters: WorkspacePurgeBodyFilters[];
}

/**
 * User-defined filters to return data which will be purged from the table.
 */
model WorkspacePurgeBodyFilters {
  /**
   * The column of the table over which the given query should run
   */
  column?: string;

  /**
   * A query operator to evaluate over the provided column and value(s). Supported operators are ==, =~, in, in~, >, >=, <, <=, between, and have the same behavior as they would in a KQL query.
   */
  operator?: string;

  /**
   * the value for the operator to function over. This can be a number (e.g., > 100), a string (timestamp >= '2017-09-01') or array of values.
   */
  value?: unknown;

  /**
   * When filtering over custom dimensions, this key will be used as the name of the custom dimension.
   */
  key?: string;
}

/**
 * Response containing operationId for a specific purge action.
 */
model WorkspacePurgeResponse {
  /**
   * Id to use when querying for status for a particular purge operation.
   */
  operationId: string;
}

/**
 * Response containing status for a specific purge operation.
 */
model WorkspacePurgeStatusResponse {
  /**
   * Status of the operation represented by the requested Id.
   */
  status: PurgeState;
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * Type of managed service identity.
   */
  type: IdentityType;

  /**
   * The list of user identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  userAssignedIdentities?: Record<UserIdentityProperties>;
}

/**
 * User assigned identity properties.
 */
model UserIdentityProperties {
  /**
   * The principal id of user assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility("read")
  clientId?: string;
}

/**
 * The cluster sku definition.
 */
model ClusterSku {
  /**
   * The capacity value
   */
  capacity?: Capacity;

  /**
   * The name of the SKU.
   */
  name?: ClusterSkuNameEnum;
}

/**
 * Cluster properties.
 */
model ClusterProperties {
  /**
   * The ID associated with the cluster.
   */
  @visibility("read")
  clusterId?: string;

  /**
   * The provisioning state of the cluster.
   */
  @visibility("read")
  provisioningState?: ClusterEntityStatus;

  /**
   * Configures whether cluster will use double encryption. This Property can not be modified after cluster creation. Default value is 'true'
   */
  @visibility("create")
  isDoubleEncryptionEnabled?: boolean;

  /**
   * Sets whether the cluster will support availability zones. This can be set as true only in regions where Azure Data Explorer support Availability Zones. This Property can not be modified after cluster creation. Default value is 'true' if region supports Availability Zones.
   */
  isAvailabilityZonesEnabled?: boolean;

  /**
   * The cluster's billing type.
   */
  billingType?: BillingType;

  /**
   * The associated key properties.
   */
  keyVaultProperties?: KeyVaultProperties;

  /**
   * The last time the cluster was updated.
   */
  @visibility("read")
  lastModifiedDate?: string;

  /**
   * The cluster creation time
   */
  @visibility("read")
  createdDate?: string;

  /**
   * The list of Log Analytics workspaces associated with the cluster
   */
  associatedWorkspaces?: AssociatedWorkspace[];

  /**
   * Additional properties for capacity reservation
   */
  capacityReservationProperties?: CapacityReservationProperties;
}

/**
 * The key vault properties.
 */
model KeyVaultProperties {
  /**
   * The Key Vault uri which holds they key associated with the Log Analytics cluster.
   */
  keyVaultUri?: string;

  /**
   * The name of the key associated with the Log Analytics cluster.
   */
  keyName?: string;

  /**
   * The version of the key associated with the Log Analytics cluster.
   */
  keyVersion?: string;

  /**
   * Selected key minimum required size.
   */
  keyRsaSize?: int32;
}

/**
 * The list of Log Analytics workspaces associated with the cluster.
 */
model AssociatedWorkspace {
  /**
   * The id of the assigned workspace.
   */
  @visibility("read")
  workspaceId?: string;

  /**
   * The name id the assigned workspace.
   */
  @visibility("read")
  workspaceName?: string;

  /**
   * The ResourceId id the assigned workspace.
   */
  @visibility("read")
  resourceId?: string;

  /**
   * The time of workspace association.
   */
  @visibility("read")
  associateDate?: string;
}

/**
 * The Capacity Reservation properties.
 */
model CapacityReservationProperties {
  /**
   * The last time Sku was updated.
   */
  @visibility("read")
  lastSkuUpdate?: string;

  /**
   * Minimum CapacityReservation value in GB.
   */
  @visibility("read")
  minCapacity?: int64;
}

/**
 * The top level Log Analytics cluster resource container.
 */
model ClusterPatch {
  /**
   * Log Analytics cluster properties.
   */
  properties?: ClusterPatchProperties;

  /**
   * The identity of the resource.
   */
  identity?: Identity;

  /**
   * The sku properties.
   */
  sku?: ClusterSku;

  /**
   * Resource tags.
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;
}

/**
 * Log Analytics cluster patch properties.
 */
model ClusterPatchProperties {
  /**
   * The associated key properties.
   */
  keyVaultProperties?: KeyVaultProperties;

  /**
   * The cluster's billing type.
   */
  billingType?: BillingType;
}

/**
 * Workspace properties.
 */
model WorkspaceProperties {
  /**
   * The provisioning state of the workspace.
   */
  @visibility("read")
  provisioningState?: WorkspaceEntityStatus;

  /**
   * This is a read-only property. Represents the ID associated with the workspace.
   */
  @visibility("read")
  customerId?: string;

  /**
   * The SKU of the workspace.
   */
  sku?: WorkspaceSku;

  /**
   * The workspace data retention in days. Allowed values are per pricing plan. See pricing tiers documentation for details.
   */
  retentionInDays?: int32;

  /**
   * The daily volume cap for ingestion.
   */
  workspaceCapping?: WorkspaceCapping;

  /**
   * Workspace creation date.
   */
  @visibility("read")
  createdDate?: string;

  /**
   * Workspace modification date.
   */
  @visibility("read")
  modifiedDate?: string;

  /**
   * The network access type for accessing Log Analytics ingestion.
   */
  publicNetworkAccessForIngestion?: PublicNetworkAccessType = PublicNetworkAccessType.Enabled;

  /**
   * The network access type for accessing Log Analytics query.
   */
  publicNetworkAccessForQuery?: PublicNetworkAccessType = PublicNetworkAccessType.Enabled;

  /**
   * Indicates whether customer managed storage is mandatory for query management.
   */
  forceCmkForQuery?: boolean;

  /**
   * List of linked private link scope resources.
   */
  @visibility("read")
  privateLinkScopedResources?: PrivateLinkScopedResource[];

  /**
   * Workspace features.
   */
  features?: WorkspaceFeatures;

  /**
   * The resource ID of the default Data Collection Rule to use for this workspace. Expected format is - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/dataCollectionRules/{dcrName}.
   */
  defaultDataCollectionRuleResourceId?: string;
}

/**
 * The SKU (tier) of a workspace.
 */
model WorkspaceSku {
  /**
   * The name of the SKU.
   */
  name: WorkspaceSkuNameEnum;

  /**
   * The capacity reservation level in GB for this workspace, when CapacityReservation sku is selected.
   */
  capacityReservationLevel?: CapacityReservationLevel;

  /**
   * The last time when the sku was updated.
   */
  @visibility("read")
  lastSkuUpdate?: string;
}

/**
 * The daily volume cap for ingestion.
 */
model WorkspaceCapping {
  /**
   * The workspace daily quota for ingestion.
   */
  dailyQuotaGb?: float64;

  /**
   * The time when the quota will be rest.
   */
  @visibility("read")
  quotaNextResetTime?: string;

  /**
   * The status of data ingestion for this workspace.
   */
  @visibility("read")
  dataIngestionStatus?: DataIngestionStatus;
}

/**
 * The private link scope resource reference.
 */
model PrivateLinkScopedResource {
  /**
   * The full resource Id of the private link scope resource.
   */
  resourceId?: string;

  /**
   * The private link scope unique Identifier.
   */
  scopeId?: string;
}

/**
 * Workspace features.
 */
model WorkspaceFeatures extends Record<unknown> {
  /**
   * Flag that indicate if data should be exported.
   */
  enableDataExport?: boolean;

  /**
   * Flag that describes if we want to remove the data after 30 days.
   */
  immediatePurgeDataOn30Days?: boolean;

  /**
   * Flag that indicate which permission to use - resource or workspace or both.
   */
  enableLogAccessUsingOnlyResourcePermissions?: boolean;

  /**
   * Dedicated LA cluster resourceId that is linked to the workspaces.
   */
  clusterResourceId?: string;

  /**
   * Disable Non-AAD based Auth.
   */
  disableLocalAuth?: boolean;
}

/**
 * The top level Workspace resource container.
 */
model WorkspacePatch extends AzureEntityResource {
  /**
   * Workspace properties.
   */
  properties?: WorkspaceProperties;

  /**
   * The identity of the resource.
   */
  identity?: Identity;

  /**
   * Resource tags. Optional.
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;
}

/**
 * The resource model definition for an Azure Resource Manager resource with an etag.
 */
model AzureEntityResource extends Resource {
  /**
   * Resource Etag.
   */
  @visibility("read")
  etag?: string;
}

/**
 * Table properties.
 */
model TableProperties {
  /**
   * The table retention in days, between 4 and 730. Setting this property to -1 will default to the workspace retention.
   */
  @maxValue(730)
  @minValue(4)
  retentionInDays?: int32;

  /**
   * The table total retention in days, between 4 and 2556. Setting this property to -1 will default to table retention.
   */
  @maxValue(2556)
  @minValue(4)
  totalRetentionInDays?: int32;

  /**
   * The table data archive retention in days. Calculated as (totalRetentionInDays-retentionInDays)
   */
  @visibility("read")
  archiveRetentionInDays?: int32;

  /**
   * Parameters of the search job that initiated this table.
   */
  searchResults?: SearchResults;

  /**
   * Parameters of the restore operation that initiated this table.
   */
  restoredLogs?: RestoredLogs;

  /**
   * Search job execution statistics.
   */
  @visibility("read")
  resultStatistics?: ResultStatistics;

  /**
   * Instruct the system how to handle and charge the logs ingested to this table.
   */
  plan?: TablePlanEnum;

  /**
   * The timestamp that table plan was last modified (UTC).
   */
  @visibility("read")
  lastPlanModifiedDate?: string;

  /**
   * Table schema.
   */
  schema?: Schema;

  /**
   * Table's current provisioning state. If set to 'updating', indicates a resource lock due to ongoing operation, forbidding any update to the table until the ongoing operation is concluded.
   */
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;

  /**
   * True - Value originates from workspace retention in days, False - Customer specific.
   */
  @visibility("read")
  retentionInDaysAsDefault?: boolean;

  /**
   * True - Value originates from retention in days, False - Customer specific.
   */
  @visibility("read")
  totalRetentionInDaysAsDefault?: boolean;
}

/**
 * Parameters of the search job that initiated this table.
 */
model SearchResults {
  /**
   * Search job query.
   */
  query?: string;

  /**
   * Search job Description.
   */
  description?: string;

  /**
   * Limit the search job to return up to specified number of rows.
   */
  limit?: int32;

  /**
   * The timestamp to start the search from (UTC)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startSearchTime?: utcDateTime;

  /**
   * The timestamp to end the search by (UTC)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endSearchTime?: utcDateTime;

  /**
   * The table used in the search job.
   */
  @visibility("read")
  sourceTable?: string;

  /**
   * Search results table async operation id.
   */
  @visibility("read")
  azureAsyncOperationId?: string;
}

/**
 * Restore parameters.
 */
model RestoredLogs {
  /**
   * The timestamp to start the restore from (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startRestoreTime?: utcDateTime;

  /**
   * The timestamp to end the restore by (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endRestoreTime?: utcDateTime;

  /**
   * The table to restore data from.
   */
  sourceTable?: string;

  /**
   * Search results table async operation id.
   */
  @visibility("read")
  azureAsyncOperationId?: string;
}

/**
 * Search job execution statistics.
 */
model ResultStatistics {
  /**
   * Search job completion percentage.
   */
  @visibility("read")
  progress?: float32;

  /**
   * The number of rows that were returned by the search job.
   */
  @visibility("read")
  ingestedRecords?: int32;

  /**
   * Search job: Amount of scanned data.
   */
  @visibility("read")
  scannedGb?: float32;
}

/**
 * Table's schema.
 */
model Schema {
  /**
   * Table name.
   */
  name?: string;

  /**
   * Table display name.
   */
  displayName?: string;

  /**
   * Table description.
   */
  description?: string;

  /**
   * A list of table custom columns.
   */
  columns?: Column[];

  /**
   * A list of table standard columns.
   */
  @visibility("read")
  standardColumns?: Column[];

  /**
   * Table category.
   */
  @visibility("read")
  categories?: string[];

  /**
   * Table labels.
   */
  @visibility("read")
  labels?: string[];

  /**
   * Table's creator.
   */
  @visibility("read")
  source?: SourceEnum;

  /**
   * Table's creator.
   */
  @visibility("read")
  tableType?: TableTypeEnum;

  /**
   * The subtype describes what APIs can be used to interact with the table, and what features are available against it.
   */
  @visibility("read")
  tableSubType?: TableSubTypeEnum;

  /**
   * List of solutions the table is affiliated with
   */
  @visibility("read")
  solutions?: string[];
}

/**
 * Table column.
 */
model Column {
  /**
   * Column name.
   */
  name?: string;

  /**
   * Column data type.
   */
  @projectedName("json", "type")
  columnType?: ColumnTypeEnum;

  /**
   * Column data type logical hint.
   */
  dataTypeHint?: ColumnDataTypeHintEnum;

  /**
   * Column display name.
   */
  displayName?: string;

  /**
   * Column description.
   */
  description?: string;

  /**
   * Is displayed by default.
   */
  @visibility("read")
  isDefaultDisplay?: boolean;

  /**
   * Is column hidden.
   */
  @visibility("read")
  isHidden?: boolean;
}

/**
 * DataSource filter. Right now, only filter by kind is supported.
 */
model DataSourceFilter {
  /**
   * The kind of the DataSource.
   */
  kind?: DataSourceKind;
}

/**
 * The status of operation.
 */
model OperationStatus {
  /**
   * The operation Id.
   */
  id?: string;

  /**
   * The operation name.
   */
  name?: string;

  /**
   * The start time of the operation.
   */
  startTime?: string;

  /**
   * The end time of the operation.
   */
  endTime?: string;

  /**
   * The status of the operation.
   */
  status?: string;

  /**
   * The error detail of the operation if any.
   */
  error?: ErrorResponse;
}
