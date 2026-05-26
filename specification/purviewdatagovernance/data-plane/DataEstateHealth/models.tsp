import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace PurviewDataEstateHealth;

// ============================================================================
// Common / Shared Models
// ============================================================================

@doc("A paged collection of results.")
model PagedResults<T> {
  @doc("The collection of items.")
  value: T[];

  @doc("The total count of items.")
  count: int32;

  @doc("Continuation token for the next page of results.")
  continuationToken?: string;
}

@doc("Ordering specification for query results.")
model OrderBy {
  @doc("The field name to order by.")
  field?: string;

  @doc("The order direction: 'asc' or 'desc'.")
  direction?: string;
}

@doc("Base request for paginated queries.")
model QueryBaseRequest {
  @doc("Continuation token from a previous response.")
  continuationToken?: string;

  @doc("The number of results per page.")
  pageSize?: int32 = 100;

  @doc("Ordering specifications.")
  orderBy?: OrderBy[];
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Open-ended model for extensible action properties."
@doc("An action resource.")
model Action {
  @doc("The unique identifier of the action.")
  id?: string;

  ...Record<unknown>;
}

@doc("Result of a storage configuration connectivity test.")
model StorageConfigConnectivityResult {
  @doc("Whether the connectivity test was successful.")
  succeeded: boolean;

  @doc("Diagnostic message describing the connectivity test outcome. Empty string when the test succeeded.")
  message: string;
}

// ============================================================================
// Action Models
// ============================================================================

@doc("Status of a data health action.")
union DataHealthActionStatus {
  @doc("The action has not been started.")
  NotStarted: "NotStarted",

  @doc("The action is in progress.")
  InProgress: "InProgress",

  @doc("The action is resolved.")
  Resolved: "Resolved",

  string,
}

@doc("Severity level of a data health action.")
union DataHealthActionSeverity {
  @doc("High severity.")
  High: "High",

  @doc("Medium severity.")
  Medium: "Medium",

  @doc("Low severity.")
  Low: "Low",

  string,
}

@doc("Target entity type for a data health action.")
union DataHealthActionTargetEntityType {
  @doc("A business domain entity.")
  BusinessDomain: "BusinessDomain",

  @doc("A data product entity.")
  DataProduct: "DataProduct",

  @doc("A glossary term entity.")
  GlossaryTerm: "GlossaryTerm",

  @doc("A data asset entity.")
  DataAsset: "DataAsset",

  @doc("A data quality asset entity.")
  DataQualityAsset: "DataQualityAsset",

  @doc("A critical data element entity.")
  CriticalDataElement: "CriticalDataElement",

  string,
}

@doc("Time range filter for action creation time.")
model CreateTimeRangeFilter {
  @doc("Start of the time range.")
  start?: utcDateTime;

  @doc("End of the time range.")
  end?: utcDateTime;
}

@doc("Filter payload for querying actions.")
model ActionFiltersPayload {
  @doc("Filter by action status values.")
  status?: string[];

  @doc("Filter by business domain IDs.")
  domainIds?: string[];

  @doc("Filter by action categories.")
  categories?: string[];

  @doc("Filter by assigned user IDs.")
  assignedTo?: string[];

  @doc("Filter by finding types.")
  findingTypes?: string[];

  @doc("Filter by finding sub-types.")
  findingSubTypes?: string[];

  @doc("Filter by finding names.")
  findingNames?: string[];

  @doc("Filter by severity level.")
  severity?: string;

  @doc("Filter by target entity type.")
  targetEntityType?: string;

  @doc("Filter by target entity IDs.")
  targetEntityIds?: string[];

  @doc("Filter by creation time range.")
  createTimeRange?: CreateTimeRangeFilter;
}

@doc("Request to query actions with pagination and filters.")
model ActionQueryRequest {
  ...QueryBaseRequest;

  @doc("Filters to apply to the action query.")
  filters?: ActionFiltersPayload;
}

@doc("Request to query actions grouped by a field.")
model ActionGroupedRequest {
  @doc("Filters to apply to the grouped action query.")
  filters?: ActionFiltersPayload;

  @doc("The field to group actions by.")
  groupBy?: string;
}

@doc("A facet request object specifying which facets to retrieve.")
model FacetRequestObject {
  @doc("The name of the facet.")
  name: string;
}

@doc("Request to retrieve action facets.")
model ActionFacetRequest {
  @doc("Filters to apply when computing facets.")
  filters?: ActionFiltersPayload;

  @doc("The facets to retrieve.")
  facets?: FacetRequestObject[];
}

@doc("A single facet value with its count.")
model FacetResponseObject {
  @doc("The facet value.")
  value?: string;

  @doc("The count of items matching this facet value.")
  count?: int32;
}

@doc("Response containing faceted aggregation results.")
model FacetResponse {
  @doc("A dictionary of facet name to facet values with counts.")
  facets: Record<FacetResponseObject[]>;
}

@doc("A group of actions under a common grouping key.")
model GroupedActions {
  @doc("The name of the group.")
  groupName?: string;

  @doc("The action items in this group.")
  items?: Record<unknown>[];
}

// ============================================================================
// Analytics Schedule Models
// ============================================================================

@doc("Frequency for analytics schedule.")
union DHAnalyticsScheduleFrequency {
  @doc("Hourly frequency.")
  Hour: "Hour",

  @doc("Daily frequency.")
  Day: "Day",

  @doc("Weekly frequency.")
  Week: "Week",

  @doc("Monthly frequency.")
  Month: "Month",

  string,
}

@doc("State of a schedule.")
union DHScheduleState {
  @doc("The schedule is enabled.")
  Enabled: "Enabled",

  @doc("The schedule is disabled.")
  Disabled: "Disabled",

  string,
}

@doc("System metadata for a resource.")
model SystemData {
  @doc("The unique identifier of the user who created the resource.")
  createdBy?: uuid;

  @doc("The timestamp when the resource was created.")
  createdAt?: utcDateTime;

  @doc("The unique identifier of the user who last modified the resource.")
  lastModifiedBy?: uuid;

  @doc("The timestamp when the resource was last modified.")
  lastModifiedAt?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "DH prefix matches existing service convention."
@doc("Request to create or update an analytics schedule.")
model DHAnalyticsScheduleRequest {
  @doc("The frequency of the analytics schedule.")
  frequency: DHAnalyticsScheduleFrequency;

  @doc("The interval between schedule runs.")
  interval: int32;

  @doc("The status of the schedule.")
  status?: DHScheduleState;

  @doc("The start time of the schedule.")
  startTime: utcDateTime;

  @doc("The end time of the schedule.")
  endTime?: utcDateTime;

  @doc("System metadata.")
  systemData?: SystemData;

  @doc("The time zone for the schedule.")
  timeZone?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "DEH prefix matches existing service convention."
@doc("Analytics job log entry.")
model DEHAnalyticsJobLogs {
  @doc("The unique identifier of the job.")
  jobId?: string;

  @doc("The status of the job.")
  jobStatus?: string;

  @doc("Error message if the job failed.")
  errorMessage?: string;

  @doc("The timestamp of the log entry.")
  timeStamp?: string;
}

// ============================================================================
// Assessment Models
// ============================================================================

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Open-ended model for extensible assessment properties."
@doc("An assessment resource.")
model Assessment {
  @doc("The unique identifier of the assessment.")
  id?: string;

  ...Record<unknown>;
}

// ============================================================================
// Control Models
// ============================================================================

@doc("Status of a governance control.")
union DHControlStatus {
  @doc("The control is enabled.")
  Enabled: "Enabled",

  @doc("The control is disabled.")
  Disabled: "Disabled",

  @doc("The control is in development.")
  InDevelopment: "InDevelopment",

  string,
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Open-ended model for extensible control properties."
@doc("A governance control resource.")
model Control {
  @doc("The unique identifier of the control.")
  id?: string;

  ...Record<unknown>;
}

// ============================================================================
// Schedule Models
// ============================================================================

@doc("Trigger type for a schedule callback.")
union DHScheduleCallbackTriggerType {
  @doc("Manual trigger.")
  Manually: "Manually",

  @doc("Scheduled trigger.")
  Schedule: "Schedule",

  string,
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Open-ended model for extensible schedule properties."
@doc("A schedule resource.")
model Schedule {
  ...Record<unknown>;
}

// ============================================================================
// Score Models
// ============================================================================

@doc("Time range for score queries.")
model QueryScoresRequestTimeRange {
  @doc("The start of the time range.")
  start: utcDateTime;

  @doc("The end of the time range.")
  end: utcDateTime;
}

@doc("Unified request for querying scores. When type=ControlNode, provide controlIds. When type=ControlGroup, provide controlGroupIds.")
model QueryScoresRequest {
  @doc("Filter by domain IDs.")
  domainIds?: string[];

  @doc("Number of latest score records to return.")
  recordLatestCounts?: int32;

  @doc("Time range filter for scores.")
  recordTimeRange?: QueryScoresRequestTimeRange;

  @doc("Filter by control status.")
  status?: string;

  @doc("The control IDs to query scores for. Required when type=ControlNode.")
  controlIds?: string[];

  @doc("The control group IDs to query scores for. Required when type=ControlGroup.")
  controlGroupIds?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "DH prefix matches existing service convention."
@doc("Score data aggregated by control or control group. The shape of items depends on the `type` query parameter used in the request: when `type=ControlNode`, `controlId` and `computingJobId` are populated; when `type=ControlGroup`, those fields are omitted.")
model DHScoreAggregated {
  @doc("The control group ID.")
  controlGroupId: string;

  @doc("The schedule run ID.")
  scheduleRunId: string;

  @doc("The timestamp of the score.")
  time: utcDateTime;

  @doc("The score value.")
  score: float64;

  @doc("The control ID. Present only when the query was issued with `type=ControlNode`.")
  controlId?: string;

  @doc("The computing job ID. Present only when the query was issued with `type=ControlNode`.")
  computingJobId?: string;
}

// ============================================================================
// Settings Models
// ============================================================================

@doc("Type of storage backing a Purview Data Estate Health storage configuration.")
union StorageType {
  @doc("Microsoft Fabric storage.")
  Fabric: "Fabric",

  @doc("Azure Data Lake Storage Gen2 storage.")
  ADLSGen2: "ADLSGen2",

  string,
}

@doc("Status of a Purview Data Estate Health storage configuration.")
union StorageStatus {
  @doc("The storage configuration is disabled.")
  Disabled: "Disabled",

  @doc("The storage configuration is enabled.")
  Enabled: "Enabled",

  string,
}

@doc("""
  Type-specific properties for the storage configuration. The actual fields
  populated depend on the parent StorageConfig.type: `locationURL` is set when
  type is `Fabric`; `endpoint` is set when type is `ADLSGen2`.
  """)
model StorageConfigTypeProperties {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name matches existing service wire format `locationURL` defined by DGCatalogStorageConfigFabricTypeProperties."
  @doc("Fabric workspace location URL. Required when StorageConfig.type is `Fabric`.")
  locationURL?: string;

  @doc("Azure Data Lake Storage Gen2 endpoint URL. Required when StorageConfig.type is `ADLSGen2`.")
  endpoint?: string;
}

@doc("Network properties associated with a storage configuration, including managed virtual network and managed private endpoint information.")
model StorageConfigNetworkProperties {
  @doc("Whether managed virtual network is enabled for this storage configuration.")
  isManagedVnetEnabled?: boolean;

  @doc("The Azure resource ID of the target storage resource.")
  targetResourceId?: string;

  @doc("The managed private endpoint identifier.")
  mpeId?: string;

  @doc("The status of the managed private endpoint. Possible values include `Approved`, `Rejected`, `Pending`, `Provisioning`, or an empty string when no endpoint exists.")
  mpeStatus?: string;

  @doc("Whether the managed private endpoint is marked for deletion.")
  markedForDeletion?: boolean;
}

@doc("Storage configuration for Purview Data Estate Health.")
model StorageConfig {
  @doc("Unique identifier of the storage configuration.")
  id: string;

  @doc("Type of storage backing this configuration.")
  type: StorageType;

  @doc("Status of the storage configuration.")
  status: StorageStatus;

  @doc("System data envelope for the storage configuration.")
  systemData: SystemData;

  @doc("Type-specific properties whose shape depends on the storage `type`.")
  typeProperties: StorageConfigTypeProperties;

  @doc("Network properties associated with the storage configuration.")
  networkProperties?: StorageConfigNetworkProperties;
}

@doc("Partial storage configuration payload used when updating the configuration or testing its connectivity. All properties are optional so callers can supply only the fields they want to change or validate.")
model StorageConfigUpdate is OptionalProperties<StorageConfig>;

@doc("Supported data source types for managed private endpoints.")
union DataSourceType {
  @doc("Microsoft Fabric data source.")
  Fabric: "Fabric",

  @doc("Azure Data Lake Storage Gen2 data source.")
  ADLSGen2: "ADLSGen2",

  string,
}

@doc("Request to check or create a managed private endpoint.")
model ManagedPrivateEndpointRequest {
  @doc("The Azure resource ID of the target resource.")
  targetResourceId: string;

  @doc("The data source type.")
  dataSourceType: DataSourceType;
}

@doc("Response indicating whether a managed private endpoint exists.")
model ManagedPrivateEndpointExistsResponse {
  @doc("The status of the managed private endpoint.")
  mpeStatus?: string;

  @doc("The managed private endpoint ID.")
  mpeId?: string;

  @doc("The Azure resource ID of the target resource.")
  targetResourceId?: string;

  @doc("The data source type.")
  dataSourceType?: string;
}

@doc("Network properties including managed private endpoint information.")
model NetworkProperties {
  @doc("Whether managed virtual network is enabled.")
  isManagedVnetEnabled?: boolean;

  @doc("The Azure resource ID of the target resource.")
  targetResourceId?: string;

  @doc("The data source type.")
  dataSourceType?: string;

  @doc("The status of the managed private endpoint.")
  mpeStatus?: string;

  @doc("The managed private endpoint ID.")
  mpeId?: string;

  @doc("Whether the endpoint is marked for deletion.")
  markedForDeletion?: boolean;
}
