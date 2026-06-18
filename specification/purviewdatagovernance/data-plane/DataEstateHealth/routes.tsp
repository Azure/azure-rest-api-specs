import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/http";
import "@typespec/openapi";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
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
  createOrUpdate(...ApiVersionParameter, @body body: AnalyticsScheduleRequest):
    | AnalyticsScheduleResponse
    | ErrorResponse;

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
  resetAll(...ApiVersionParameter): OkResponse | ErrorResponse;
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

  @doc("Create or update the global control schedule.")
  @route("/controls/schedule")
  @put
  createOrUpdate(...ApiVersionParameter, @body body: Schedule):
    | ScheduleResponse
    | ErrorResponse;
}

// ============================================================================
// Scores
// ============================================================================

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Service controller dispatches strictly on these two values via QueryStringConstraintAttribute; closed set is the wire truth."
@doc("Score query aggregation type.")
union ScoreQueryType {
  @doc("Aggregate by individual control.")
  ControlNode: "ControlNode",

  @doc("Aggregate by control group.")
  ControlGroup: "ControlGroup",
}

@doc("Operations for querying governance scores.")
interface Scores {
  @doc("Query scores aggregated by control or control group. Use 'type=ControlNode' with controlIds in body for individual controls, or 'type=ControlGroup' with controlGroupIds in body for control groups.")
  @route("/scores/query")
  @post
  query(
    ...ApiVersionParameter,

    @doc("Aggregation type: 'ControlNode' for individual controls, 'ControlGroup' for control groups.")
    @query
    type: ScoreQueryType,

    @body body: QueryScoresRequest,
  ): AggregatedScore[] | ErrorResponse;
}

// ============================================================================
// Settings
// ============================================================================

@doc("Operations for managing storage configuration and network settings.")
interface Settings {
  @doc("Get the current storage configuration.")
  @route("/settings/storageConfig")
  @get
  getStorageConfig(...ApiVersionParameter):
    | StorageConfigResponse
    | ErrorResponse;

  @doc("Update the storage configuration.")
  @route("/settings/storageConfig")
  @post
  updateStorageConfig(...ApiVersionParameter, @body body: StorageConfigUpdate):
    | Created201Response<StorageConfig>
    | ErrorResponse;

  @doc("Test storage configuration connectivity.")
  @route("/settings/storageConfig/connectivity")
  @post
  testStorageConfigConnectivity(
    ...ApiVersionParameter,
    @body body: StorageConfigUpdate,
  ): StorageConfigConnectivityResponse | ErrorResponse;

  @doc("Check if a managed private endpoint exists.")
  @route("/settings/mpe/exists")
  @post
  checkManagedPrivateEndpointExists(
    ...ApiVersionParameter,
    @body body: ManagedPrivateEndpointRequest,
  ):
    | ManagedPrivateEndpointExistsResponse
    | Created201Response<ManagedPrivateEndpointExistsResponse>
    | ErrorResponse;

  @doc("Create a managed private endpoint.")
  @route("/settings/mpe")
  @post
  createManagedPrivateEndpoint(
    ...ApiVersionParameter,
    @body body: ManagedPrivateEndpointRequest,
  ): Created201Response<NetworkProperties> | ErrorResponse;
}

// ============================================================================
// Response Type Models (named to avoid anonymous types in swagger)
// ============================================================================

alias AnalyticsScheduleResponse = AnalyticsScheduleRequest;
alias AnalyticsJobLogsResponse = AnalyticsJobLogs[];

@doc("Paged collection of assessment results.")
model AssessmentListResponse {
  ...PagedResults<Assessment>;
}

alias AssessmentResponse = Assessment;

@doc("Paged collection of control results.")
model ControlListResponse {
  ...PagedResults<Control>;
}

alias ControlResponse = Control;

alias ScheduleResponse = Schedule;

alias StorageConfigResponse = StorageConfig;
alias StorageConfigConnectivityResponse = StorageConfigConnectivityResult;
