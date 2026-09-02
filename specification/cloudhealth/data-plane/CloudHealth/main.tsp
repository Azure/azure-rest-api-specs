import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Foundations;

@useAuth(AadOauth2Auth<["https://data.cloudhealth.azure.com/.default"]>)
@service(#{ title: "Azure Monitor Health Models Data Plane" })
@versioned(Versions)
@server(
  "{endpoint}",
  "The data-plane endpoint.",
  {
    endpoint: url,
  }
)
namespace Microsoft.CloudHealth.HealthIntelligence.DataPlane;

alias NoResourceLifecycleTraits = Azure.Core.Traits.NoConditionalRequests &
  Azure.Core.Traits.NoRepeatableRequests &
  Azure.Core.Traits.NoClientRequestId;

alias EntityReadOperations = Azure.Core.ResourceOperations<
  NoResourceLifecycleTraits,
  NotFoundError | BadRequestError | EntityDiagnosticDefaultError
>;

@doc("Service API versions.")
enum Versions {
  @doc("The 2026-06-01-preview version.")
  @previewVersion
  v2026_06_01_preview: "2026-06-01-preview",
}

// Regex for proxy-resource name validation, mirroring the control-plane contract:
// up to 260 chars, alphanumeric and hyphens, must start and end with an alphanumeric character.
alias proxyResourceNameRegex = "^[a-zA-Z0-9][a-zA-Z0-9-]{1,258}[a-zA-Z0-9]$";

@maxLength(4096)
@doc("String with max length validation of 4096 characters")
scalar string4096 extends string;

@pattern(proxyResourceNameRegex)
@maxLength(260)
@doc("Entity resource name; matches the control-plane proxy-resource naming contract.")
scalar entityName extends string;

@pattern(proxyResourceNameRegex)
@maxLength(260)
@doc("Signal resource name; matches the control-plane proxy-resource naming contract.")
scalar signalName extends string;

@doc("Health state")
union HealthState {
  string,

  @doc("Healthy status")
  Healthy: "Healthy",

  @doc("Degraded status")
  Degraded: "Degraded",

  @doc("Unhealthy status")
  Unhealthy: "Unhealthy",

  @doc("Unknown status")
  Unknown: "Unknown",
}

@doc("A health state transition record")
model HealthStateTransition {
  @doc("Previous health state before the transition")
  previousState: HealthState;

  @doc("New health state after the transition")
  newState: HealthState;

  @doc("Timestamp when the transition occurred")
  occurredAt: utcDateTime;

  @doc("Opaque historical transition text recorded at event time; clients must treat this as descriptive history, not a typed current-state reason.")
  reason?: string4096;
}

@doc("Health state of the requested health model, echoed by data-plane operations.")
model QueryEchoResult {
  @doc("""
    Persisted resource name of the health model root entity.
    Always use this field directly and never parse the model identifier to derive entity identity.
    """)
  rootEntityName: entityName;

  @doc("True when a health model exists for the requested id.")
  healthModelExists: boolean;

  @doc("Health state of the health model; omitted when the health model does not exist.")
  healthModelState?: HealthState;
}

@doc("How an entity's health is transformed when propagated to its parent. The service emits documented values; the open string form lets clients retain future named values.")
union EntityImpact {
  string,

  @doc("Propagate the entity health state unchanged.")
  Standard: "Standard",

  @doc("Reduce Degraded to Healthy and Unhealthy to Degraded before propagation; Healthy and Unknown remain unchanged.")
  Limited: "Limited",

  @doc("Propagate Degraded or Unhealthy as Healthy; Healthy and Unknown remain unchanged.")
  Suppressed: "Suppressed",
}

@doc("Strategy used to combine a set of health inputs. The service emits documented values; the open string form lets clients retain future named values.")
union AggregationType {
  string,

  @doc("Select the greatest-severity member health state, where severity order is Unknown, then Healthy, then Degraded, then Unhealthy.")
  WorstOf: "WorstOf",

  @doc("Select the least-severe non-Unknown member health state; Unknown is always excluded.")
  BestOf: "BestOf",

  @doc("Apply Healthy-count/percentage thresholds over included inputs: at or below the unhealthy threshold yields Unhealthy; otherwise at or below the degraded threshold yields Degraded; otherwise Healthy.")
  MinHealthy: "MinHealthy",

  @doc("Apply non-Healthy-count/percentage thresholds over included inputs: at or above the unhealthy threshold yields Unhealthy; otherwise at or above the degraded threshold yields Degraded; otherwise Healthy.")
  MaxNotHealthy: "MaxNotHealthy",
}

@doc("Unit applied to threshold-bearing aggregation strategies. The service emits documented values; the open string form lets clients retain future named values.")
union AggregationUnit {
  string,

  @doc("Thresholds are interpreted as absolute counts of included inputs.")
  Absolute: "Absolute",

  @doc("Thresholds are interpreted as percentages of included inputs.")
  Percentage: "Percentage",
}

@doc("Reason recorded for the current entity's most recent composite health-state transition. The service emits documented values; the open string form lets clients retain future named values.")
union EntityTransitionReason {
  string,

  @doc("Transition caused by an inbound signal transition.")
  SignalTransition: "SignalTransition",

  @doc("Transition caused by signal expiration.")
  SignalExpiration: "SignalExpiration",

  @doc("Transition caused by signal deletion.")
  SignalDeletion: "SignalDeletion",

  @doc("Transition caused by a child-entity transition.")
  ChildEntityTransition: "ChildEntityTransition",

  @doc("Transition caused by child-entity deletion.")
  ChildEntityDeletion: "ChildEntityDeletion",

  @doc("Transition caused by dependency aggregation configuration changes.")
  DependencyConfigChanged: "DependencyConfigChanged",

  @doc("Transition caused by signal-aggregation configuration changes.")
  SignalAggregationConfigChanged: "SignalAggregationConfigChanged",
}

@doc("How the effective aggregation configuration was resolved for diagnostics.")
union EntityDiagnosticAggregationResolution {
  string,

  @doc("The service applied an implicit default because no explicit configuration was present.")
  ImplicitDefault: "ImplicitDefault",

  @doc("The service used an explicitly configured aggregation.")
  Configured: "Configured",

  @doc("The service used a fallback aggregation because configuration could not be applied directly.")
  Fallback: "Fallback",
}

@doc("Name and effective health state of a diagnostic input member.")
model EntityDiagnosticHealthInput {
  @doc("Name of the contributing entity or signal.")
  name: string;

  @doc("Effective health state contributed by this input.")
  effectiveHealthState: HealthState;
}

@doc("Aggregation configuration used by diagnostics for a dependency or signal group.")
model EntityDiagnosticAggregationConfiguration {
  @doc("Aggregation algorithm used to combine member health states.")
  aggregationType: AggregationType;

  @doc("Optional degraded threshold used when the aggregation algorithm supports thresholds.")
  degradedThreshold?: float64;

  @doc("Optional unhealthy threshold used when the aggregation algorithm supports thresholds.")
  unhealthyThreshold?: float64;

  @doc("Optional threshold unit used when thresholds are provided.")
  unit?: AggregationUnit;

  @doc("Unknown-input handling flag for threshold strategies: inert for WorstOf, always ignored for BestOf, and for MinHealthy/MaxNotHealthy controls Unknown inclusion in counts/percentages (and their denominator).")
  ignoreUnknown: boolean;
}

@doc("Effective aggregation details applied by the service.")
model EntityDiagnosticEffectiveAggregation {
  @doc("Aggregation configuration that was applied.")
  configuration: EntityDiagnosticAggregationConfiguration;

  @doc("How the effective aggregation was resolved.")
  resolution: EntityDiagnosticAggregationResolution;
}

@doc("Diagnostic details for one signal-aggregation group.")
model EntityDiagnosticSignalAggregationGroup {
  @doc("Name of the signal-aggregation group.")
  name: string;

  @doc("Configured signal names for this group, preserving names exactly as configured (including spelling and occurrences).")
  members: string[];

  @doc("Effective aggregation applied to this group.")
  effectiveAggregation: EntityDiagnosticEffectiveAggregation;

  @doc("Aggregated health state produced for this group.")
  aggregatedHealthState: HealthState;

  @doc("Configured signal names that could not be resolved; names are preserved as configured (including spelling and occurrences) and are absent from active signals.")
  unresolvedMembers: string[];
}

@doc("Current diagnostic snapshot for an entity.")
@resource("api/entities")
model EntityDiagnosticSnapshot {
  @doc("Name of the entity represented by this diagnostic snapshot.")
  @key("entityName")
  @visibility(Lifecycle.Read)
  entityName: entityName;

  @doc("Current health state of the entity.")
  healthState: HealthState;

  @doc("Timestamp when the current health state became active (UTC), when known.")
  lastHealthTransitionAt?: utcDateTime;

  @doc("Typed reason for the current health-state transition, when available.")
  lastHealthTransitionReason?: EntityTransitionReason;

  @doc("Current impact classification of the entity.")
  impact: EntityImpact;

  @doc("Signal inputs currently contributing to the entity health evaluation.")
  signalInputs: EntityDiagnosticHealthInput[];

  @doc("Dependency inputs currently contributing to the entity health evaluation.")
  dependencyInputs: EntityDiagnosticHealthInput[];

  @doc("Effective dependency aggregation currently applied to dependency inputs.")
  effectiveDependencyAggregation: EntityDiagnosticEffectiveAggregation;

  @doc("Signal-aggregation groups considered in the current health evaluation.")
  signalAggregationGroups: EntityDiagnosticSignalAggregationGroup[];
}

@doc("Routing resource that identifies a signal under an entity.")
@resource("signals")
@parentResource(EntityDiagnosticSnapshot)
model EntitySignalRoute {
  @doc("Name of the signal under an entity.")
  @key("signalName")
  @visibility(Lifecycle.Read)
  signalName: signalName;
}

@error
@doc("Returned when the requested health model does not exist.")
model ModelNotFoundError is Azure.Core.Foundations.ErrorResponse {
  @doc("HTTP status code indicating that the requested health model was not found.")
  @statusCode
  statusCode: 404;
}

@error
@doc("Returned when the requested resource does not exist.")
model NotFoundError is Azure.Core.Foundations.ErrorResponse {
  @doc("HTTP status code indicating that the requested resource was not found.")
  @statusCode
  statusCode: 404;
}

@error
@doc("Returned when the request is malformed, or a query parameter is invalid.")
model BadRequestError is Azure.Core.Foundations.ErrorResponse {
  @doc("HTTP status code indicating that the request was invalid.")
  @statusCode
  statusCode: 400;
}

@error
@doc("Returned when entity diagnostics fail for reasons outside the explicit user-fault contract.")
model EntityDiagnosticDefaultError is Azure.Core.Foundations.ErrorResponse {
  @doc("Retry guidance supplied by the service as an HTTP date or delay in seconds.")
  @header("Retry-After")
  retryAfter?: string;
}

@doc("A contiguous interval during which the entity held a single health state.")
model EntityHealthStatePeriod {
  @doc("Health state held during this period.")
  healthState: HealthState;

  @doc("""
    When this state became active (UTC). Omitted when the state was already active at the
    earliest point observable from retained data — i.e. its true start is older than the
    ~30-day data-retention window, predates the entity's first recorded transition, or lies
    beyond the result cap.
    """)
  startAt?: utcDateTime;

  @doc("""
    When the entity transitioned away from this state (UTC). Omitted when the state is still
    active now (no later transition recorded).
    """)
  endAt?: utcDateTime;
}

@doc("Health-state transitions recorded for an entity, returned as a pageable result.")
model EntityTransitionHistoryPage {
  @doc("The health-state transitions, ordered newest first.")
  @pageItems
  value: HealthStateTransition[];

  @doc("The full URI to fetch the next page of results; absent when there is no next page.")
  @nextLink
  nextLink?: url;
}

@doc("Health-state periods overlapping the requested window, newest first.")
model EntityHealthStateHistoryPage {
  @doc("The health-state periods, ordered newest first.")
  @pageItems
  value: EntityHealthStatePeriod[];

  @doc("The full URI to fetch the next page of results; absent when there is no next page.")
  @nextLink
  nextLink?: url;
}

@doc("A single recorded signal data point.")
model SignalHistoryDataPoint {
  @doc("Timestamp when the data point occurred (UTC).")
  occurredAt: utcDateTime;

  @doc("Value of the signal at this point; omitted when the signal has no numeric value at this point.")
  value?: float64;

  @doc("Health state of the signal at this point.")
  healthState: HealthState;

  @doc("Additional context for this data point; omitted when none is recorded.")
  additionalContext?: string4096;
}

@doc("Signal data points recorded for an entity's signal, newest first.")
model SignalDataPointHistoryPage {
  @doc("The signal data points, ordered newest first.")
  @pageItems
  value: SignalHistoryDataPoint[];

  @doc("The full URI to fetch the next page of results; absent when there is no next page.")
  @nextLink
  nextLink?: url;
}

@doc("A data annotation recorded for an entity.")
model DataAnnotation {
  @doc("Unique identifier of the annotation.")
  annotationId: string;

  @doc("Timestamp when the annotation was created (UTC).")
  createdAt: utcDateTime;

  @doc("Description of the annotation; omitted when none is recorded.")
  description?: string4096;

  @doc("Additional details for the annotation; omitted when none is recorded.")
  annotationDetails?: Record<string4096>;
}

@doc("Data annotations recorded for an entity, newest first.")
model DataAnnotationsPage {
  @doc("The data annotations, ordered newest first.")
  @pageItems
  value: DataAnnotation[];

  @doc("The full URI to fetch the next page of results; absent when there is no next page.")
  @nextLink
  nextLink?: url;
}

@doc("Comparison operators accepted by threshold rules.")
union SignalOperator {
  string,

  @doc("Less than.")
  LessThan: "LessThan",

  @doc("Less than or equal.")
  LessThanOrEqual: "LessThanOrEqual",

  @doc("Greater than.")
  GreaterThan: "GreaterThan",

  @doc("Greater than or equal.")
  GreaterThanOrEqual: "GreaterThanOrEqual",

  @doc("Equal.")
  Equal: "Equal",

  @doc("Not equal.")
  NotEqual: "NotEqual",

  @doc("Dynamic operator.")
  Dynamic: "Dynamic",
}

@doc("Threshold-based rule used to evaluate health state.")
model ThresholdRule {
  @doc("Comparison operator for the threshold rule.")
  operator: SignalOperator;

  @doc("Threshold value used with the selected operator.")
  threshold?: float64;
}

@doc("Evaluation rules used to derive a health state.")
model EvaluationRule {
  @doc("Rule used to determine degraded state.")
  degradedRule?: ThresholdRule;

  @doc("Rule used to determine unhealthy state.")
  unhealthyRule: ThresholdRule;
}

@doc("Evaluation rules for the health report.")
model HealthReportEvaluationRule {
  ...EvaluationRule;
}

@doc("Health report submitted for a specific signal.")
model HealthReportPayload {
  @doc("Name of the entity signal to report health for.")
  signalName: signalName;

  @doc("Health state to report for the signal.")
  healthState: HealthState;

  @doc("Reported value of the signal.")
  value?: float64;

  @doc("Evaluation rules that were used to determine the reported health state.")
  evaluationRules?: HealthReportEvaluationRule;

  @doc("Number of minutes until the health report expires. Defaults to 60 (1 hour) if not specified.")
  @minValue(1)
  @maxValue(10080)
  expiresInMinutes?: int32 = 60;

  @doc("Optional additional context or description for the health report.")
  additionalContext?: string4096;
}

@doc("Confirmation that a health report was durably accepted for processing.")
model IngestHealthReportResult {
  @doc("Indicates that the health report was durably accepted into the ingestion pipeline.")
  accepted: boolean;
}

@doc("Health-report ingestion completed successfully.")
model IngestHealthReportSuccess {
  ...TypeSpec.Http.OkResponse;

  @doc("Confirmation that the report was durably accepted into the ingestion pipeline.")
  @body
  body: IngestHealthReportResult;
}

@error
@doc("The health-report ingestion request payload exceeded the size limit of 32 KiB (32768 bytes).")
model PayloadTooLargeError is Azure.Core.Foundations.ErrorResponse {
  @doc("HTTP status code indicating that the request payload was too large.")
  @statusCode
  statusCode: 413;
}

@error
@doc("Too many health-report ingestion requests were received.")
model TooManyRequestsError is Azure.Core.Foundations.ErrorResponse {
  @doc("HTTP status code indicating that the request rate limit was exceeded.")
  @statusCode
  statusCode: 429;

  @doc("Retry guidance supplied by the service as an HTTP date or delay in seconds.")
  @header("Retry-After")
  // RFC 9110 §10.2.3 defines Retry-After as an HTTP-date or delay-seconds, so it is
  // not an int32; the pinned emitter also cannot render non-string headers into its
  // Dictionary<string, string> header map.
  retryAfter: string;
}

@error
@doc("Returned when the ingestion request's Content-Type is not supported.")
model UnsupportedMediaTypeError is Azure.Core.Foundations.ErrorResponse {
  @doc("HTTP status code indicating that the request content type was unsupported.")
  @statusCode
  statusCode: 415;
}

@error
@doc("Health-report ingestion service is temporarily unavailable; the client may retry after the given delay.")
model ServiceUnavailableError is Azure.Core.Foundations.ErrorResponse {
  @doc("HTTP status code indicating that the service was temporarily unavailable.")
  @statusCode
  statusCode: 503;

  @doc("Retry guidance supplied by the service as an HTTP date or delay in seconds.")
  @header("Retry-After")
  // RFC 9110 §10.2.3 defines Retry-After as an HTTP-date or delay-seconds, so it is
  // not an int32; the pinned emitter also cannot render non-string headers into its
  // Dictionary<string, string> header map.
  retryAfter?: string;
}

interface Model {
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name mirrors the implemented data-plane contract ('status'); renaming would diverge from the deployed service."
  @doc("Return whether the health model exists and its current health state.")
  @route("/api")
  @get
  status is RpcOperation<
    {},
    QueryEchoResult,
    {},
    ModelNotFoundError | BadRequestError | EntityDiagnosticDefaultError
  >;
}

@route("/api/entities/{entityName}/transitions")
interface EntityTransitionHistory {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Transition history must keep the deployed '/transitions' subpath and pageable history payload shape; no resource-lifecycle template preserves this wire contract."
  @doc("Return the health-state transitions recorded for an entity, newest first.")
  @list
  @get
  list is Operation<
    Azure.Core.Foundations.ItemKeysOf<EntityDiagnosticSnapshot> & {
      @doc("Start of the requested window (UTC); defaults to 24 hours before now when omitted.")
      @query
      startAt?: utcDateTime;

      @doc("End of the requested window (UTC); defaults to now when omitted.")
      @query
      endAt?: utcDateTime;

      @doc("Maximum page size of transitions to return; defaults to 1000 when omitted.")
      @query("maxpagesize")
      @maxValue(1000)
      @minValue(1)
      maxPageSize?: int32;

      @doc("An opaque string value that identifies the portion of the result set to be returned with the next operation.")
      @query
      @continuationToken
      nextMarker?: string4096;
    },
    EntityTransitionHistoryPage,
    {},
    ModelNotFoundError | BadRequestError | EntityDiagnosticDefaultError
  >;
}

interface Entity {
  @doc("Return the current diagnostic snapshot for an entity.")
  get is EntityReadOperations.ResourceRead<EntityDiagnosticSnapshot>;
}

@route("/api/entities/{entityName}/healthStateHistory")
interface EntityHealthStateHistory {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Health-state history must keep the deployed '/healthStateHistory' subpath and pageable history payload shape; no resource-lifecycle template preserves this wire contract."
  @doc("Return the health-state periods active during the requested window for an entity.")
  @list
  @get
  list is Operation<
    Azure.Core.Foundations.ItemKeysOf<EntityDiagnosticSnapshot> & {
      @doc("Start of the requested window (UTC); defaults to 24 hours before now when omitted.")
      @query
      startAt?: utcDateTime;

      @doc("End of the requested window (UTC); defaults to now when omitted.")
      @query
      endAt?: utcDateTime;

      @doc("Maximum page size of history periods to return; defaults to 1000 when omitted.")
      @query("maxpagesize")
      @maxValue(1000)
      @minValue(1)
      maxPageSize?: int32;

      @doc("An opaque string value that identifies the portion of the result set to be returned with the next operation.")
      @query
      @continuationToken
      nextMarker?: string4096;
    },
    EntityHealthStateHistoryPage,
    {},
    ModelNotFoundError | BadRequestError | EntityDiagnosticDefaultError
  >;
}

@route("/api/entities/{entityName}/signals/{signalName}/history")
interface SignalHistory {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Signal history must keep the deployed '/signals/{signalName}/history' subpath and pageable time-series payload shape; no resource-lifecycle template preserves this wire contract."
  @doc("Return the data points recorded for an entity's signal, newest first.")
  @list
  @get
  list is Operation<
    Azure.Core.Foundations.ItemKeysOf<EntitySignalRoute> & {
      @doc("Start of the requested window (UTC); defaults to 24 hours before now when omitted.")
      @query
      startAt?: utcDateTime;

      @doc("End of the requested window (UTC); defaults to now when omitted.")
      @query
      endAt?: utcDateTime;

      @doc("Maximum page size of data points to return; defaults to 1000 when omitted.")
      @query("maxpagesize")
      @maxValue(1000)
      @minValue(1)
      maxPageSize?: int32;

      @doc("An opaque string value that identifies the portion of the result set to be returned with the next operation.")
      @query
      @continuationToken
      nextMarker?: string4096;
    },
    SignalDataPointHistoryPage,
    {},
    ModelNotFoundError | BadRequestError | EntityDiagnosticDefaultError
  >;
}

@route("/api/entities/{entityName}/dataAnnotations")
interface DataAnnotations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Data annotations must keep the deployed '/dataAnnotations' subpath and pageable annotation payload shape; no resource-lifecycle template preserves this wire contract."
  @doc("Return the data annotations recorded for an entity, newest first.")
  @list
  @get
  list is Operation<
    Azure.Core.Foundations.ItemKeysOf<EntityDiagnosticSnapshot> & {
      @doc("Start of the requested window (UTC); defaults to 24 hours before now when omitted.")
      @query
      startAt?: utcDateTime;

      @doc("End of the requested window (UTC); defaults to now when omitted.")
      @query
      endAt?: utcDateTime;

      @doc("Maximum page size of annotations to return; defaults to 100 when omitted.")
      @query("maxpagesize")
      @maxValue(100)
      @minValue(1)
      maxPageSize?: int32;

      @doc("An opaque string value that identifies the portion of the result set to be returned with the next operation.")
      @query
      @continuationToken
      nextMarker?: string4096;
    },
    DataAnnotationsPage,
    {},
    ModelNotFoundError | BadRequestError | EntityDiagnosticDefaultError
  >;
}

interface HealthReportIngestion {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Health report ingestion must keep the deployed '/healthReports' subpath and accepts a report into a durable asynchronous processing pipeline."
  @doc("""
    Durably accept a health report for asynchronous processing.
    A successful response confirms that the report is safely queued, not that downstream health evaluation has completed.
    Use the signal history and entity diagnostic operations to observe the resulting health state.
    Retrying the same logical submission with the same repeatability headers does not ingest the report twice.
    """)
  @route("/api/entities/{entityName}/healthReports")
  @post
  ingestHealthReport is Operation<
    Azure.Core.Foundations.ItemKeysOf<EntityDiagnosticSnapshot> & {
      ...Azure.Core.Traits.Private.TraitProperties<
        Azure.Core.Traits.SupportsRepeatableRequests,
        Azure.Core.Traits.TraitLocation.Parameters,
        Azure.Core.Traits.TraitContext.Action
      >;

      @doc("Health report payload. Must not exceed 32 KiB (32768 bytes).")
      @body
      body: HealthReportPayload;
    },
    IngestHealthReportSuccess &
      Azure.Core.Traits.Private.TraitProperties<
        Azure.Core.Traits.SupportsRepeatableRequests,
        Azure.Core.Traits.TraitLocation.Response,
        Azure.Core.Traits.TraitContext.Action
      >,
    Azure.Core.Traits.SupportsRepeatableRequests,
    | BadRequestError
    | ModelNotFoundError
    | PayloadTooLargeError
    | UnsupportedMediaTypeError
    | TooManyRequestsError
    | ServiceUnavailableError
    | EntityDiagnosticDefaultError
  >;
}
