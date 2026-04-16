import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/http";

using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace PurviewDataEstateHealth;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;
alias DataEstateHealthOperations = Azure.Core.ResourceOperations<ServiceTraits>;

// Common response models for non-200 status codes
model Created201Response<T> {
  @statusCode statusCode: 201;
  @body body: T;
}

model Accepted202Response<T> {
  @statusCode statusCode: 202;
  @body body: T;
}

// ============================================================================
// Actions
// ============================================================================

@doc("Operations for managing data health actions.")
interface Actions {
  @doc("Query actions with filters and pagination.")
  @route("/actions/query")
  @post
  query(
    ...ApiVersionParameter,
    @body body: ActionQueryRequest,
  ): ActionQueryResponse | ErrorResponse;

  @doc("Query actions grouped by a specified field.")
  @route("/actions/grouped")
  @post
  queryGrouped(
    ...ApiVersionParameter,
    @body body: ActionGroupedRequest,
  ): GroupedActionsResponse | ErrorResponse;

  @doc("Get an action by its unique identifier.")
  @route("/actions/{actionId}")
  @get
  get(
    ...ApiVersionParameter,

    @doc("The unique identifier of the action.")
    @path
    @maxLength(256)
    actionId: string,
  ): ActionResponse | ErrorResponse;

  @doc("Update an action by its unique identifier.")
  @route("/actions/{actionId}")
  @put
  update(
    ...ApiVersionParameter,

    @doc("The unique identifier of the action.")
    @path
    @maxLength(256)
    actionId: string,

    @body body: Action,
  ): ActionResponse | ErrorResponse;

  @doc("Get faceted aggregations for actions based on filters.")
  @route("/actions/facets")
  @post
  getFacets(
    ...ApiVersionParameter,
    @body body: ActionFacetRequest,
  ): FacetResponse | ErrorResponse;
}

// ============================================================================
// Alerts
// ============================================================================

@doc("Operations for managing governance alerts.")
interface Alerts {
  @doc("List all alerts.")
  @route("/controls/alerts")
  @get
  list(...ApiVersionParameter): AlertListResponse | ErrorResponse;

  @doc("Create a new alert.")
  @route("/controls/alerts")
  @post
  create(
    ...ApiVersionParameter,
    @body body: Alert,
  ): Created201Response<Alert> | ErrorResponse;

  @doc("Get an alert by its unique identifier.")
  @route("/controls/alerts/{id}")
  @get
  get(
    ...ApiVersionParameter,

    @doc("The unique identifier of the alert.")
    @path
    @maxLength(256)
    id: string,
  ): AlertResponse | ErrorResponse;

  @doc("Update an alert by its unique identifier.")
  @route("/controls/alerts/{id}")
  @put
  update(
    ...ApiVersionParameter,

    @doc("The unique identifier of the alert.")
    @path
    @maxLength(256)
    id: string,

    @body body: Alert,
  ): AlertResponse | ErrorResponse;

  @doc("Delete an alert by its unique identifier.")
  @route("/controls/alerts/{id}")
  @delete
  delete(
    ...ApiVersionParameter,

    @doc("The unique identifier of the alert.")
    @path
    @maxLength(256)
    id: string,
  ): void | ErrorResponse;
}

// ============================================================================
// Analytics Schedule
// ============================================================================

@doc("Operations for managing analytics schedules.")
interface AnalyticsSchedules {
  @doc("Get the analytics global schedule.")
  @route("/analytics/schedule")
  @get
  get(...ApiVersionParameter): AnalyticsScheduleResponse | ErrorResponse;

  @doc("Create or update the analytics global schedule.")
  @route("/analytics/schedule")
  @put
  createOrUpdate(
    ...ApiVersionParameter,
    @body body: DHAnalyticsScheduleRequest,
  ): AnalyticsScheduleResponse | ErrorResponse;

  @doc("Get analytics job logs for the global schedule.")
  @route("/analytics/schedule/getjoblogs")
  @get
  getJobLogs(...ApiVersionParameter): AnalyticsJobLogsResponse | ErrorResponse;
}

// ============================================================================
// Assessments
// ============================================================================

@doc("Operations for managing governance assessments.")
interface Assessments {
  @doc("List all assessments.")
  @route("/controls/assessments")
  @get
  list(...ApiVersionParameter): AssessmentListResponse | ErrorResponse;

  @doc("Create a new assessment.")
  @route("/controls/assessments")
  @post
  create(
    ...ApiVersionParameter,
    @body body: Assessment,
  ): Created201Response<Assessment> | ErrorResponse;

  @doc("Get an assessment by its unique identifier.")
  @route("/controls/assessments/{id}")
  @get
  get(
    ...ApiVersionParameter,

    @doc("The unique identifier of the assessment.")
    @path
    @maxLength(256)
    id: string,
  ): AssessmentResponse | ErrorResponse;

  @doc("Update an assessment by its unique identifier.")
  @route("/controls/assessments/{id}")
  @put
  update(
    ...ApiVersionParameter,

    @doc("The unique identifier of the assessment.")
    @path
    @maxLength(256)
    id: string,

    @body body: Assessment,
  ): AssessmentResponse | ErrorResponse;

  @doc("Delete an assessment by its unique identifier.")
  @route("/controls/assessments/{id}")
  @delete
  delete(
    ...ApiVersionParameter,

    @doc("The unique identifier of the assessment.")
    @path
    @maxLength(256)
    id: string,
  ): void | ErrorResponse;

  @doc("Reset an assessment by its unique identifier.")
  @route("/controls/assessments/{id}/reset")
  @post
  reset(
    ...ApiVersionParameter,

    @doc("The unique identifier of the assessment.")
    @path
    @maxLength(256)
    id: string,
  ): AssessmentResponse | ErrorResponse;
}

// ============================================================================
// Controls
// ============================================================================

@doc("Operations for managing governance controls.")
interface Controls {
  @doc("List all governance controls.")
  @route("/controls")
  @get
  list(...ApiVersionParameter): ControlListResponse | ErrorResponse;

  @doc("Create a new governance control.")
  @route("/controls")
  @post
  create(
    ...ApiVersionParameter,

    @doc("Whether to create a new assessment along with the control.")
    @query
    withNewAssessment?: boolean,

    @body body: Control,
  ): Created201Response<Control> | ErrorResponse;

  @doc("Get a governance control by its unique identifier.")
  @route("/controls/{id}")
  @get
  get(
    ...ApiVersionParameter,

    @doc("The unique identifier of the control.")
    @path
    @maxLength(256)
    id: string,
  ): ControlResponse | ErrorResponse;

  @doc("Update a governance control by its unique identifier.")
  @route("/controls/{id}")
  @put
  update(
    ...ApiVersionParameter,

    @doc("The unique identifier of the control.")
    @path
    @maxLength(256)
    id: string,

    @body body: Control,
  ): ControlResponse | ErrorResponse;

  @doc("Delete a governance control by its unique identifier.")
  @route("/controls/{id}")
  @delete
  delete(
    ...ApiVersionParameter,

    @doc("The unique identifier of the control.")
    @path
    @maxLength(256)
    id: string,

    @doc("Whether to also delete the associated assessment.")
    @query
    deleteAssessment?: boolean,
  ): void | ErrorResponse;

  @doc("Reset a governance control by its unique identifier.")
  @route("/controls/{id}/reset")
  @post
  reset(
    ...ApiVersionParameter,

    @doc("The unique identifier of the control.")
    @path
    @maxLength(256)
    id: string,
  ): ControlResponse | ErrorResponse;

  @doc("Reset all governance controls.")
  @route("/controls/reset")
  @post
  resetAll(...ApiVersionParameter): void | ErrorResponse;
}

// ============================================================================
// Monitoring
// ============================================================================

@doc("Operations for querying control monitoring data.")
interface Monitoring {
  @doc("Query monitoring data for controls.")
  @route("/controls/monitoring/query")
  @post
  query(
    ...ApiVersionParameter,
    @body body: QueryMonitoringRequest,
  ): MonitoringQueryResponse | ErrorResponse;
}

// ============================================================================
// Schedules
// ============================================================================

@doc("Operations for managing control schedules.")
interface Schedules {
  @doc("Get the global control schedule.")
  @route("/controls/schedule")
  @get
  get(...ApiVersionParameter): ScheduleResponse | ErrorResponse;

  @doc("Trigger a control schedule run.")
  @route("/controls/schedule/trigger")
  @post
  trigger(
    ...ApiVersionParameter,
    @body body: TriggerScheduleRequest,
  ): ScheduleTriggerResponse | ErrorResponse;

  @doc("Create or update the global control schedule.")
  @route("/controls/schedule")
  @put
  createOrUpdate(
    ...ApiVersionParameter,
    @body body: Schedule,
  ): ScheduleResponse | ErrorResponse;
}

// ============================================================================
// Scores
// ============================================================================

@doc("Score query aggregation type.")
union ScoreQueryType {
  @doc("Aggregate by individual control.")
  ControlNode: "ControlNode",

  @doc("Aggregate by control group.")
  ControlGroup: "ControlGroup",

  string,
}

@doc("Operations for querying governance scores.")
interface Scores {
  @doc("List all governance scores.")
  @route("/scores")
  @get
  list(...ApiVersionParameter): ScoreListResponse | ErrorResponse;

  @doc("Query scores aggregated by control or control group. Use 'type=ControlNode' with controlIds in body for individual controls, or 'type=ControlGroup' with controlGroupIds in body for control groups.")
  @route("/scores/query")
  @post
  query(
    ...ApiVersionParameter,

    @doc("Aggregation type: 'ControlNode' for individual controls, 'ControlGroup' for control groups.")
    @query
    type: ScoreQueryType,

    @body body: QueryScoresRequest,
  ): ScoreQueryResponse | ErrorResponse;
}

@doc("Alias operations for querying governance scores via /controls/scores path.")
interface ControlScores {
  @doc("List all governance scores (alias for /scores).")
  @route("/controls/scores")
  @get
  list(...ApiVersionParameter): ScoreListResponse | ErrorResponse;

  @doc("Query scores via /controls/scores/query (alias for /scores/query).")
  @route("/controls/scores/query")
  @post
  query(
    ...ApiVersionParameter,

    @doc("Aggregation type: 'ControlNode' for individual controls, 'ControlGroup' for control groups.")
    @query
    type: ScoreQueryType,

    @body body: QueryScoresRequest,
  ): ScoreQueryResponse | ErrorResponse;
}

// ============================================================================
// Settings
// ============================================================================

@doc("Operations for managing storage configuration and network settings.")
interface Settings {
  @doc("Get the current storage configuration.")
  @route("/settings/storageConfig")
  @get
  getStorageConfig(
    ...ApiVersionParameter,
  ): StorageConfigResponse | ErrorResponse;

  @doc("Update the storage configuration.")
  @route("/settings/storageConfig")
  @post
  updateStorageConfig(
    ...ApiVersionParameter,
    @body body: StorageConfig,
  ): Created201Response<StorageConfig> | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "MI is a well-known abbreviation for Managed Identity."
  @doc("Get a managed identity token for storage access.")
  @route("/settings/storageConfig/mitoken")
  @get
  getMIToken(...ApiVersionParameter): MITokenResponse | ErrorResponse;

  @doc("Test storage configuration connectivity.")
  @route("/settings/storageConfig/connectivity")
  @post
  testStorageConfigConnectivity(
    ...ApiVersionParameter,
    @body body: StorageConfig,
  ): StorageConfigConnectivityResponse | ErrorResponse;

  @doc("Check if a managed private endpoint exists.")
  @route("/settings/mpe/exists")
  @post
  checkManagedPrivateEndpointExists(
    ...ApiVersionParameter,
    @body body: ManagedPrivateEndpointRequest,
  ): ManagedPrivateEndpointExistsResponse | Created201Response<ManagedPrivateEndpointExistsResponse> | ErrorResponse;

  @doc("Create a managed private endpoint.")
  @route("/settings/mpe")
  @post
  createManagedPrivateEndpoint(
    ...ApiVersionParameter,
    @body body: ManagedPrivateEndpointRequest,
  ): Accepted202Response<NetworkProperties> | ErrorResponse;
}

// ============================================================================
// Status Palettes
// ============================================================================

@doc("Operations for managing control status palettes.")
interface StatusPalettes {
  @doc("List all status palettes.")
  @route("/controls/statusPalette")
  @get
  list(...ApiVersionParameter): StatusPaletteListResponse | ErrorResponse;

  @doc("Create a new status palette.")
  @route("/controls/statusPalette")
  @post
  create(
    ...ApiVersionParameter,
    @body body: StatusPalette,
  ): Created201Response<StatusPalette> | ErrorResponse;

  @doc("Get a status palette by its unique identifier.")
  @route("/controls/statusPalette/{id}")
  @get
  get(
    ...ApiVersionParameter,

    @doc("The unique identifier of the status palette.")
    @path
    @maxLength(256)
    id: string,
  ): StatusPaletteResponse | ErrorResponse;

  @doc("Update a status palette by its unique identifier.")
  @route("/controls/statusPalette/{id}")
  @put
  update(
    ...ApiVersionParameter,

    @doc("The unique identifier of the status palette.")
    @path
    @maxLength(256)
    id: string,

    @body body: StatusPalette,
  ): StatusPaletteResponse | ErrorResponse;

  @doc("Delete a status palette by its unique identifier.")
  @route("/controls/statusPalette/{id}")
  @delete
  delete(
    ...ApiVersionParameter,

    @doc("The unique identifier of the status palette.")
    @path
    @maxLength(256)
    id: string,
  ): void | ErrorResponse;
}

// ============================================================================
// Synapse Query
// ============================================================================

@doc("Operations for executing ad-hoc Synapse SQL queries.")
interface SynapseQuery {
  @doc("Execute an ad-hoc Synapse Serverless SQL query.")
  @route("/settings/executeSynapseQuery")
  @post
  execute(
    ...ApiVersionParameter,
    @body body: ExecuteSynapseQueryRequestPayload,
  ): SynapseQueryResultResponse | ErrorResponse;
}

// ============================================================================
// Tips
// ============================================================================

@doc("Operations for retrieving tip entities.")
interface Tips {
  @doc("Get tip entities from a container.")
  @route("/tips/{containerName}")
  @get
  getEntities(
    ...ApiVersionParameter,

    @doc("The name of the tips container.")
    @path
    @maxLength(256)
    containerName: string,

    @doc("Filter by entity ID.")
    @query
    entityId?: string,

    @doc("Filter by entity name.")
    @query
    entityName?: string,

    @doc("Maximum number of results to return. Default is 50.")
    @query
    top?: int32 = 50,
  ): TipEntitiesResponse | ErrorResponse;
}

// ============================================================================
// Response Type Aliases
// ============================================================================

alias ActionQueryResponse = PagedResults<Record<unknown>>;
alias GroupedActionsResponse = GroupedActions[];
alias ActionResponse = Action;
alias AlertListResponse = PagedResults<Record<unknown>>;
alias AlertResponse = Alert;
alias AnalyticsScheduleResponse = DHAnalyticsScheduleRequest;
alias AnalyticsJobLogsResponse = DEHAnalyticsJobLogs[];
alias AssessmentListResponse = PagedResults<Record<unknown>>;
alias AssessmentResponse = Assessment;
alias ControlListResponse = PagedResults<Record<unknown>>;
alias ControlResponse = Control;
alias MonitoringQueryResponse = PagedResults<DHComputingJobWrapper>;
alias ScheduleResponse = Schedule;
alias ScheduleTriggerResponse = TriggerScheduleResponse;
alias ScoreListResponse = PagedResults<Record<unknown>>;
alias ScoreQueryResponse = ScoreRecord[];
alias StorageConfigResponse = StorageConfig;
alias MITokenResponse = MITokenInfo;
alias StorageConfigConnectivityResponse = StorageConfigConnectivityResult;
alias StatusPaletteListResponse = PagedResults<Record<unknown>>;
alias StatusPaletteResponse = StatusPalette;
alias TipEntitiesResponse = TipEntity[];
