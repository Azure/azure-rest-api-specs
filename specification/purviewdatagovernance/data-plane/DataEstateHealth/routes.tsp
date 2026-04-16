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
  queryActions(
    ...ApiVersionParameter,
    @body body: ActionQueryRequest,
  ): ActionQueryResponse | ErrorResponse;

  @doc("Query actions grouped by a specified field.")
  @route("/actions/grouped")
  @post
  queryGroupedActions(
    ...ApiVersionParameter,
    @body body: ActionGroupedRequest,
  ): GroupedActionsResponse | ErrorResponse;

  @doc("Get an action by its unique identifier.")
  @route("/actions/{actionId}")
  @get
  getAction(
    ...ApiVersionParameter,

    @doc("The unique identifier of the action.")
    @path
    @maxLength(256)
    actionId: string,
  ): ActionResponse | ErrorResponse;

  @doc("Update an action by its unique identifier.")
  @route("/actions/{actionId}")
  @put
  updateAction(
    ...ApiVersionParameter,

    @doc("The unique identifier of the action.")
    @path
    @maxLength(256)
    actionId: string,

    @body body: Record<unknown>,
  ): ActionResponse | ErrorResponse;

  @doc("Get faceted aggregations for actions based on filters.")
  @route("/actions/facets")
  @post
  getActionFacets(
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
  listAlerts(...ApiVersionParameter): AlertListResponse | ErrorResponse;

  @doc("Create a new alert.")
  @route("/controls/alerts")
  @post
  createAlert(
    ...ApiVersionParameter,
    @body body: Record<unknown>,
  ): Created201Response<Record<unknown>> | ErrorResponse;

  @doc("Get an alert by its unique identifier.")
  @route("/controls/alerts/{id}")
  @get
  getAlert(
    ...ApiVersionParameter,

    @doc("The unique identifier of the alert.")
    @path
    @maxLength(256)
    id: string,
  ): AlertResponse | ErrorResponse;

  @doc("Update an alert by its unique identifier.")
  @route("/controls/alerts/{id}")
  @put
  updateAlert(
    ...ApiVersionParameter,

    @doc("The unique identifier of the alert.")
    @path
    @maxLength(256)
    id: string,

    @body body: Record<unknown>,
  ): AlertResponse | ErrorResponse;

  @doc("Delete an alert by its unique identifier.")
  @route("/controls/alerts/{id}")
  @delete
  deleteAlert(
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
  getAnalyticsSchedule(...ApiVersionParameter): AnalyticsScheduleResponse | ErrorResponse;

  @doc("Create or update the analytics global schedule.")
  @route("/analytics/schedule")
  @put
  createOrUpdateAnalyticsSchedule(
    ...ApiVersionParameter,
    @body body: DHAnalyticsScheduleRequest,
  ): AnalyticsScheduleResponse | ErrorResponse;

  @doc("Get analytics job logs for the global schedule.")
  @route("/analytics/schedule/getjoblogs")
  @get
  getAnalyticsJobLogs(...ApiVersionParameter): AnalyticsJobLogsResponse | ErrorResponse;
}

// ============================================================================
// Assessments
// ============================================================================

@doc("Operations for managing governance assessments.")
interface Assessments {
  @doc("List all assessments.")
  @route("/controls/assessments")
  @get
  listAssessments(...ApiVersionParameter): AssessmentListResponse | ErrorResponse;

  @doc("Create a new assessment.")
  @route("/controls/assessments")
  @post
  createAssessment(
    ...ApiVersionParameter,
    @body body: Record<unknown>,
  ): Created201Response<Record<unknown>> | ErrorResponse;

  @doc("Get an assessment by its unique identifier.")
  @route("/controls/assessments/{id}")
  @get
  getAssessment(
    ...ApiVersionParameter,

    @doc("The unique identifier of the assessment.")
    @path
    @maxLength(256)
    id: string,
  ): AssessmentResponse | ErrorResponse;

  @doc("Update an assessment by its unique identifier.")
  @route("/controls/assessments/{id}")
  @put
  updateAssessment(
    ...ApiVersionParameter,

    @doc("The unique identifier of the assessment.")
    @path
    @maxLength(256)
    id: string,

    @body body: Record<unknown>,
  ): AssessmentResponse | ErrorResponse;

  @doc("Delete an assessment by its unique identifier.")
  @route("/controls/assessments/{id}")
  @delete
  deleteAssessment(
    ...ApiVersionParameter,

    @doc("The unique identifier of the assessment.")
    @path
    @maxLength(256)
    id: string,
  ): void | ErrorResponse;

  @doc("Reset an assessment by its unique identifier.")
  @route("/controls/assessments/{id}/reset")
  @post
  resetAssessment(
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
  listControls(...ApiVersionParameter): ControlListResponse | ErrorResponse;

  @doc("Create a new governance control.")
  @route("/controls")
  @post
  createControl(
    ...ApiVersionParameter,

    @doc("Whether to create a new assessment along with the control.")
    @query
    withNewAssessment?: boolean,

    @body body: Record<unknown>,
  ): Created201Response<Record<unknown>> | ErrorResponse;

  @doc("Get a governance control by its unique identifier.")
  @route("/controls/{id}")
  @get
  getControl(
    ...ApiVersionParameter,

    @doc("The unique identifier of the control.")
    @path
    @maxLength(256)
    id: string,
  ): ControlResponse | ErrorResponse;

  @doc("Update a governance control by its unique identifier.")
  @route("/controls/{id}")
  @put
  updateControl(
    ...ApiVersionParameter,

    @doc("The unique identifier of the control.")
    @path
    @maxLength(256)
    id: string,

    @body body: Record<unknown>,
  ): ControlResponse | ErrorResponse;

  @doc("Delete a governance control by its unique identifier.")
  @route("/controls/{id}")
  @delete
  deleteControl(
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
  resetControl(
    ...ApiVersionParameter,

    @doc("The unique identifier of the control.")
    @path
    @maxLength(256)
    id: string,
  ): ControlResponse | ErrorResponse;

  @doc("Reset all governance controls.")
  @route("/controls/reset")
  @post
  resetAllControls(...ApiVersionParameter): void | ErrorResponse;
}

// ============================================================================
// Monitoring
// ============================================================================

@doc("Operations for querying control monitoring data.")
interface Monitoring {
  @doc("Query monitoring data for controls.")
  @route("/controls/monitoring/query")
  @post
  queryMonitoring(
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
  getSchedule(...ApiVersionParameter): ScheduleResponse | ErrorResponse;

  @doc("Trigger a control schedule run.")
  @route("/controls/schedule/trigger")
  @post
  triggerSchedule(
    ...ApiVersionParameter,
    @body body: TriggerScheduleRequest,
  ): ScheduleTriggerResponse | ErrorResponse;

  @doc("Create or update the global control schedule.")
  @route("/controls/schedule")
  @put
  createOrUpdateSchedule(
    ...ApiVersionParameter,
    @body body: Record<unknown>,
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
  listScores(...ApiVersionParameter): ScoreListResponse | ErrorResponse;

  @doc("Query scores aggregated by control or control group. Use 'type=ControlNode' with controlIds in body for individual controls, or 'type=ControlGroup' with controlGroupIds in body for control groups.")
  @route("/scores/query")
  @post
  queryScores(
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
  listControlScores(...ApiVersionParameter): ScoreListResponse | ErrorResponse;

  @doc("Query scores via /controls/scores/query (alias for /scores/query).")
  @route("/controls/scores/query")
  @post
  queryControlScores(
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
  getStorageConfig(...ApiVersionParameter): StorageConfigResponse | ErrorResponse;

  @doc("Update the storage configuration.")
  @route("/settings/storageConfig")
  @post
  updateStorageConfig(
    ...ApiVersionParameter,
    @body body: Record<unknown>,
  ): Created201Response<Record<unknown>> | ErrorResponse;

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
    @body body: Record<unknown>,
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
  listStatusPalettes(...ApiVersionParameter): StatusPaletteListResponse | ErrorResponse;

  @doc("Create a new status palette.")
  @route("/controls/statusPalette")
  @post
  createStatusPalette(
    ...ApiVersionParameter,
    @body body: Record<unknown>,
  ): Created201Response<Record<unknown>> | ErrorResponse;

  @doc("Get a status palette by its unique identifier.")
  @route("/controls/statusPalette/{id}")
  @get
  getStatusPalette(
    ...ApiVersionParameter,

    @doc("The unique identifier of the status palette.")
    @path
    @maxLength(256)
    id: string,
  ): StatusPaletteResponse | ErrorResponse;

  @doc("Update a status palette by its unique identifier.")
  @route("/controls/statusPalette/{id}")
  @put
  updateStatusPalette(
    ...ApiVersionParameter,

    @doc("The unique identifier of the status palette.")
    @path
    @maxLength(256)
    id: string,

    @body body: Record<unknown>,
  ): StatusPaletteResponse | ErrorResponse;

  @doc("Delete a status palette by its unique identifier.")
  @route("/controls/statusPalette/{id}")
  @delete
  deleteStatusPalette(
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
  executeSynapseQuery(
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
  getTipEntities(
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
alias ActionResponse = Record<unknown>;
alias AlertListResponse = PagedResults<Record<unknown>>;
alias AlertResponse = Record<unknown>;
alias AnalyticsScheduleResponse = Record<unknown>;
alias AnalyticsJobLogsResponse = DEHAnalyticsJobLogs[];
alias AssessmentListResponse = PagedResults<Record<unknown>>;
alias AssessmentResponse = Record<unknown>;
alias ControlListResponse = PagedResults<Record<unknown>>;
alias ControlResponse = Record<unknown>;
alias MonitoringQueryResponse = PagedResults<DHComputingJobWrapper>;
alias ScheduleResponse = Record<unknown>;
alias ScheduleTriggerResponse = TriggerScheduleResponse;
alias ScoreListResponse = PagedResults<Record<unknown>>;
alias ScoreQueryResponse = Record<unknown>[];
alias StorageConfigResponse = Record<unknown>;
alias MITokenResponse = Record<unknown>;
alias StorageConfigConnectivityResponse = Record<unknown>;
alias StatusPaletteListResponse = PagedResults<Record<unknown>>;
alias StatusPaletteResponse = Record<unknown>;
alias TipEntitiesResponse = Record<unknown>[];
