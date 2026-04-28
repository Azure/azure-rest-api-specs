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

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Open-ended model for extensible score record properties."
@doc("A score record.")
model ScoreRecord {
  ...Record<unknown>;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Open-ended model for extensible MI token properties."
#suppress "@azure-tools/typespec-azure-core/casing-style" "MI is a well-known abbreviation for Managed Identity."
@doc("A managed identity token response.")
model MITokenInfo {
  @doc("The managed identity token.")
  token?: string;

  ...Record<unknown>;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Open-ended model for extensible connectivity result properties."
@doc("Result of a storage configuration connectivity test.")
model StorageConfigConnectivityResult {
  @doc("Whether the connectivity test was successful.")
  isConnected?: boolean;

  ...Record<unknown>;
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
// Alert Models
// ============================================================================

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Open-ended model for extensible alert properties."
@doc("An alert resource.")
model Alert {
  @doc("The unique identifier of the alert.")
  id?: string;

  ...Record<unknown>;
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
// Monitoring Models
// ============================================================================

@doc("Status of a computing job.")
union DHComputingJobStatus {
  @doc("Unknown status.")
  Unknown: "Unknown",

  @doc("The job has been created.")
  Created: "Created",

  @doc("The job failed.")
  Failed: "Failed",

  @doc("The job completed successfully.")
  Succeeded: "Succeeded",

  @doc("The job is in progress.")
  InProgress: "InProgress",

  @doc("The job is being cancelled.")
  Cancelling: "Cancelling",

  @doc("The job was cancelled.")
  Cancelled: "Cancelled",

  @doc("The job is queued.")
  Queued: "Queued",

  @doc("The job has been accepted.")
  Accepted: "Accepted",

  @doc("The job was rejected.")
  Rejected: "Rejected",

  @doc("The job was skipped.")
  Skipped: "Skipped",

  @doc("The job is being deleted.")
  Deleting: "Deleting",

  string,
}

@doc("Request to query monitoring data for a control.")
model QueryMonitoringRequest {
  @doc("The control ID to query monitoring data for.")
  controlId: string;

  @doc("The start time of the monitoring window.")
  startTime: utcDateTime;

  @doc("The end time of the monitoring window.")
  endTime: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "DH prefix matches existing service convention."
@doc("A computing job wrapper with job details.")
model DHComputingJobWrapper {
  @doc("The data quality job ID.")
  dqJobId?: string;

  @doc("The control ID associated with this job.")
  controlId?: string;

  @doc("The schedule run ID.")
  scheduleRunId?: string;

  @doc("The time the job was created.")
  createTime?: utcDateTime;

  @doc("The time the job started.")
  startTime?: utcDateTime;

  @doc("The time the job ended.")
  endTime?: utcDateTime;

  @doc("The current status of the job.")
  status?: DHComputingJobStatus;
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

@doc("Request to trigger a schedule run.")
model TriggerScheduleRequest {
  @doc("The control ID to trigger the schedule for.")
  controlId: string;
}

@doc("Response from triggering a schedule run.")
model TriggerScheduleResponse {
  @doc("The schedule run ID that was triggered.")
  scheduleRunId: string;
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
@doc("Score data aggregated by individual control.")
model DHScoreAggregatedByControl {
  @doc("The control group ID.")
  controlGroupId: string;

  @doc("The control ID.")
  controlId: string;

  @doc("The schedule run ID.")
  scheduleRunId: string;

  @doc("The computing job ID.")
  computingJobId: string;

  @doc("The timestamp of the score.")
  time: utcDateTime;

  @doc("The score value.")
  score: float64;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "DH prefix matches existing service convention."
@doc("Score data aggregated by control group.")
model DHScoreAggregatedByControlGroup {
  @doc("The control group ID.")
  controlGroupId: string;

  @doc("The schedule run ID.")
  scheduleRunId: string;

  @doc("The timestamp of the score.")
  time: utcDateTime;

  @doc("The score value.")
  score: float64;
}

// ============================================================================
// Settings Models
// ============================================================================

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Open-ended model for extensible storage config properties."
@doc("A storage configuration resource.")
model StorageConfig {
  ...Record<unknown>;
}

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

// ============================================================================
// Status Palette Models
// ============================================================================

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Open-ended model for extensible status palette properties."
@doc("A status palette resource for controls.")
model StatusPalette {
  @doc("The unique identifier of the status palette.")
  id?: string;

  ...Record<unknown>;
}

// ============================================================================
// Synapse Query Models
// ============================================================================

@doc("Request to execute an ad-hoc Synapse Serverless SQL query.")
model ExecuteSynapseQueryRequestPayload {
  @doc("The SQL query to execute.")
  query: string;

  @doc("Whether the query is Base64 encoded.")
  isBase64Encoded?: boolean;

  @doc("Maximum number of rows to return.")
  maxRows?: int32 = 100;

  @doc("Connection timeout in seconds.")
  connectTimeoutSeconds?: int32 = 30;

  @doc("Command execution timeout in seconds.")
  commandTimeoutSeconds?: int32 = 120;
}

@doc("Response from a Synapse query execution.")
model SynapseQueryResultResponse {
  @doc("The column names in the result set.")
  columns: string[];

  @doc("The result rows, each as a dictionary of column name to value.")
  rows: Record<unknown>[];

  @doc("Total number of rows returned.")
  rowCount: int32;

  @doc("Whether the result set was truncated.")
  truncated: boolean;
}

// ============================================================================
// Tips Models
// ============================================================================

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Open-ended model for extensible tip entity properties."
@doc("A tip entity.")
model TipEntity {
  ...Record<unknown>;
}
