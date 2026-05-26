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

model Accepted202Response<T> {
  @statusCode statusCode: 202;
  @header("Operation-Location") operationLocation: string;
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
  query(...ApiVersionParameter, @body body: ActionQueryRequest):
    | ActionQueryResponse
    | ErrorResponse;

  @doc("Query actions grouped by a specified field.")
  @route("/actions/grouped")
  @post
  queryGrouped(...ApiVersionParameter, @body body: ActionGroupedRequest):
    | GroupedActionsResponse
    | ErrorResponse;

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
  getFacets(...ApiVersionParameter, @body body: ActionFacetRequest):
    | FacetResponse
    | ErrorResponse;
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
  trigger(...ApiVersionParameter, @body body: TriggerScheduleRequest):
    | ScheduleTriggerResponse
    | ErrorResponse;

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

@doc("Score query aggregation type.")
union ScoreQueryType {
  @doc("Aggregate by individual control.")
  ControlNode: "ControlNode",

  @doc("Aggregate by control group.")
  ControlGroup: "ControlGroup",

  string,
}

@doc("Kind of health score requested for data product or data asset score endpoints.")
union HealthScoreKind {
  @doc("Data governance health score.")
  DataGovernance: "DataGovernance",

  @doc("Data quality health score.")
  DataQuality: "DataQuality",

  @doc("Data curation health score.")
  DataCuration: "DataCuration",

  string,
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
  ): ScoreQueryResponse | ErrorResponse;

  @doc("List health scores for all data products in a business domain.")
  @route("/scores/businessDomains/{domainId}/dataProducts/bulk")
  @get
  listAllDataProducts(
    ...ApiVersionParameter,

    @doc("The unique identifier of the business domain.")
    @path
    @maxLength(256)
    domainId: string,

    @doc("Kind of health score to retrieve.")
    @query("kind")
    kind: HealthScoreKind,
  ): DataProductHealthScoreListResponse | ErrorResponse;

  @doc("Get the health score for a specific data product within a business domain.")
  @route("/scores/businessDomains/{domainId}/dataProducts/{dataProductId}")
  @get
  getDataProduct(
    ...ApiVersionParameter,

    @doc("The unique identifier of the business domain.")
    @path
    @maxLength(256)
    domainId: string,

    @doc("The unique identifier of the data product.")
    @path
    @maxLength(256)
    dataProductId: string,

    @doc("Kind of health score to retrieve.")
    @query("kind")
    kind: HealthScoreKind,
  ): DataProductHealthScoreResponse | ErrorResponse;

  @doc("List health scores for all data assets within a data product in a business domain.")
  @route("/scores/businessDomains/{domainId}/dataProducts/{dataProductId}/dataAssets/bulk")
  @get
  listAllDataAssets(
    ...ApiVersionParameter,

    @doc("The unique identifier of the business domain.")
    @path
    @maxLength(256)
    domainId: string,

    @doc("The unique identifier of the data product.")
    @path
    @maxLength(256)
    dataProductId: string,

    @doc("Kind of health score to retrieve.")
    @query("kind")
    kind: HealthScoreKind,
  ): DataAssetHealthScoreListResponse | ErrorResponse;
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
  updateStorageConfig(
    ...ApiVersionParameter,
    @body body: OptionalProperties<StorageConfig>,
  ): Created201Response<StorageConfig> | ErrorResponse;

  @doc("Test storage configuration connectivity.")
  @route("/settings/storageConfig/connectivity")
  @post
  testStorageConfigConnectivity(
    ...ApiVersionParameter,
    @body body: OptionalProperties<StorageConfig>,
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

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom LRO operation requires x-ms-long-running-operation extension."
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "LRO polling is handled by the service client, not via a standard polling operation."
  @doc("Create a managed private endpoint.")
  @route("/settings/mpe")
  @post
  @extension("x-ms-long-running-operation", true)
  createManagedPrivateEndpoint(
    ...ApiVersionParameter,
    @body body: ManagedPrivateEndpointRequest,
  ): Accepted202Response<NetworkProperties> | ErrorResponse;
}

// ============================================================================
// Response Type Models (named to avoid anonymous types in swagger)
// ============================================================================

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Open-ended paged results for actions."
@doc("Paged collection of action results.")
model ActionQueryResponse {
  ...PagedResults<Action>;
}

alias GroupedActionsResponse = GroupedActions[];
alias ActionResponse = Action;
alias AnalyticsScheduleResponse = DHAnalyticsScheduleRequest;
alias AnalyticsJobLogsResponse = DEHAnalyticsJobLogs[];

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Open-ended paged results for assessments."
@doc("Paged collection of assessment results.")
model AssessmentListResponse {
  ...PagedResults<Assessment>;
}

alias AssessmentResponse = Assessment;

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Open-ended paged results for controls."
@doc("Paged collection of control results.")
model ControlListResponse {
  ...PagedResults<Control>;
}

alias ControlResponse = Control;

alias ScheduleResponse = Schedule;
alias ScheduleTriggerResponse = TriggerScheduleResponse;

alias ScoreQueryResponse = ScoreRecord[];

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Open-ended paged results for data product health scores."
@doc("Paged collection of data product health scores.")
model DataProductHealthScoreListResponse {
  ...PagedResults<ScoreRecord>;
}

alias DataProductHealthScoreResponse = ScoreRecord;

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Open-ended paged results for data asset health scores."
@doc("Paged collection of data asset health scores.")
model DataAssetHealthScoreListResponse {
  ...PagedResults<ScoreRecord>;
}

alias StorageConfigResponse = StorageConfig;
alias StorageConfigConnectivityResponse = StorageConfigConnectivityResult;
