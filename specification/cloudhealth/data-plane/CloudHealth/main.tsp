import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Foundations;

@useAuth(AadOauth2Auth<["https://data.cloudhealth.azure.com/.default"]>)
@service(#{ title: "Azure Monitor Health Models" })
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
  EntityDiagnosticDefaultError
>;

@doc("Service API versions.")
enum Versions {
  @doc("The 2026-10-01-preview version.")
  @previewVersion
  v2026_10_01_preview: "2026-10-01-preview",
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

  @doc("Optional set of labels (key-value pairs)")
  tags?: Record<string4096>;
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

@doc("Outcome of evaluating an entity's health evidence.")
union EntityDiagnosisOutcome {
  string,

  @doc("The entity health state is derived from contributing signal/dependency inputs and aggregation results.")
  ContributingInputsAndAggregation: "ContributingInputsAndAggregation",

  @doc("The entity health state is determined by aggregation configuration without active non-healthy contributors.")
  AggregationOnly: "AggregationOnly",

  @doc("No active degradation exists for the entity at observation time.")
  NoActiveDegradation: "NoActiveDegradation",

  @doc("The entity health state cannot be determined from available data.")
  HealthUnknown: "HealthUnknown",

  @doc("Evaluation is pending and has not yet produced final evidence.")
  EvaluationPending: "EvaluationPending",
}

@doc("Kind of signal evidence emitted by diagnosis.")
union EntityDiagnosisSignalKind {
  string,

  @doc("Evidence from a direct signal on the entity.")
  Signal: "Signal",

  @doc("Evidence from a nested health model signal projection.")
  NestedHealthModel: "NestedHealthModel",

  @doc("Configured signal reference that could not be resolved.")
  UnresolvedSignal: "UnresolvedSignal",
}

@doc("Availability status of signal history in diagnosis evidence.")
union EntityDiagnosisSignalHistoryStatus {
  string,

  @doc("Signal history is available in the response.")
  Available: "Available",

  @doc("Signal history is unavailable for this signal.")
  Unavailable: "Unavailable",

  @doc("Signal history was limited due to evaluation budget constraints.")
  BudgetLimited: "BudgetLimited",
}

@doc("Boundary classification for dependency traversal in diagnosis evidence.")
union EntityDiagnosisDependencyBoundary {
  string,

  @doc("Dependency traversal encountered a cycle.")
  Cycle: "Cycle",

  @doc("Dependency was shared and traversal stopped to avoid duplication.")
  Shared: "Shared",

  @doc("Dependency health was unknown at observation time.")
  HealthUnknown: "HealthUnknown",

  @doc("Dependency evidence is deferred beyond this diagnosis continuation chain. Not used for routine page breaks.")
  Deferred: "Deferred",

  @doc("Dependency evidence was unavailable.")
  Unavailable: "Unavailable",

  @doc("Dependency edge was not expanded because the child lies beyond the requested maxDepth.")
  MaxDepth: "MaxDepth",
}

@doc("Category of input that determined an aggregation outcome.")
union EntityDiagnosisDeterminingInputCategory {
  string,

  @doc("A direct signal input determined the aggregation outcome.")
  Signal: "Signal",

  @doc("A signal-group aggregation input determined the aggregation outcome.")
  SignalGroup: "SignalGroup",

  @doc("A dependency input determined the aggregation outcome.")
  Dependency: "Dependency",
}

@doc("Metric describing how the aggregation calculation was derived.")
union EntityDiagnosisAggregationMetric {
  string,

  @doc("Worst contributed input health state.")
  WorstInputHealthState: "WorstInputHealthState",

  @doc("Best contributed input health state.")
  BestInputHealthState: "BestInputHealthState",

  @doc("Count of healthy evaluated inputs.")
  HealthyInputs: "HealthyInputs",

  @doc("Count of non-healthy evaluated inputs.")
  NotHealthyInputs: "NotHealthyInputs",
}

@doc("A single signal history point in diagnosis evidence.")
model EntityDiagnosisSignalHistoryPoint {
  @doc("Timestamp when the signal point occurred (UTC).")
  occurredAt: utcDateTime;

  @doc("Health state of the signal at this point.")
  healthState: HealthState;

  @doc("Numeric signal value at this point, when available.")
  value?: float64;
}

@doc("Signal history attached to diagnosis evidence.")
model EntityDiagnosisSignalHistory {
  @doc("Availability status for signal history in the current response.")
  status: EntityDiagnosisSignalHistoryStatus;

  @doc("True when history has additional points not included in this response.")
  truncated: boolean;

  @doc("Signal history points included in this response, newest first.")
  value: EntityDiagnosisSignalHistoryPoint[];
}

@doc("Signal-level diagnosis evidence.")
model EntityDiagnosisSignalEvidence {
  @doc("Signal evidence kind.")
  kind: EntityDiagnosisSignalKind;

  @doc("Signal name when this evidence maps to a configured signal.")
  signalName?: signalName;

  @doc("Observed health state of the signal evidence.")
  healthState: HealthState;

  @doc("Signal history evidence when available.")
  history?: EntityDiagnosisSignalHistory;
}

@doc("Dependency-level diagnosis evidence.")
model EntityDiagnosisDependencyEvidence {
  @doc("Dependency entity name.")
  entityName: entityName;

  @doc("Health state contribution propagated from the dependency.")
  contributedHealthState: HealthState;

  @doc("Boundary classification when dependency evidence is not expanded. Omitted when the child fragment is on a later page.")
  boundary?: EntityDiagnosisDependencyBoundary;

  @doc("Azure resource ID of the dependency entity when it is configured with a qualifying Azure resource; omitted otherwise. Present for boundary dependencies even when no child fragment is returned.")
  azureResourceId?: string;
}

@doc("Input counts used by bounded aggregation evidence.")
model EntityDiagnosisAggregationInputCounts {
  @doc("Total configured inputs considered by the aggregation.")
  @minValue(0)
  total: int32;

  @doc("Inputs evaluated after Unknown-handling rules were applied.")
  @minValue(0)
  evaluated: int32;

  @doc("Inputs in a Healthy state from the complete pre-filter aggregation input population.")
  @minValue(0)
  healthy: int32;

  @doc("Inputs in a Degraded state from the complete pre-filter aggregation input population.")
  @minValue(0)
  degraded: int32;

  @doc("Inputs in an Unhealthy state from the complete pre-filter aggregation input population.")
  @minValue(0)
  unhealthy: int32;

  @doc("Inputs in an Unknown state from the complete pre-filter aggregation input population.")
  @minValue(0)
  `unknown`: int32;
}

@doc("Numeric boundary used by aggregation classification bands.")
model EntityDiagnosisAggregationBound {
  @doc("Boundary value.")
  value: float64;

  @doc("True when the boundary value is inclusive.")
  inclusive: boolean;
}

@doc("Optional lower and upper classification boundaries for aggregation values.")
model EntityDiagnosisAggregationClassificationBand {
  @doc("Optional lower boundary for the classification.")
  lowerBound?: EntityDiagnosisAggregationBound;

  @doc("Optional upper boundary for the classification.")
  upperBound?: EntityDiagnosisAggregationBound;
}

@doc("Optional aggregation calculation details.")
model EntityDiagnosisAggregationCalculation {
  @doc("Metric used for the calculation.")
  metric: EntityDiagnosisAggregationMetric;

  @doc("Numeric value produced by the calculation, when available.")
  value?: float64;

  @doc("Unit for threshold-based calculations, when available.")
  unit?: AggregationUnit;

  @doc("Optional lower/upper classification boundaries.")
  classificationBand?: EntityDiagnosisAggregationClassificationBand;
}

@doc("Bounded aggregation evidence explaining a computed diagnosis state.")
model EntityDiagnosisAggregationEvidence {
  @doc("Effective aggregation and provenance used for this computation.")
  effectiveAggregation: EntityDiagnosticEffectiveAggregation;

  @doc("Health state from applying the effective aggregation.")
  healthState: HealthState;

  @doc("Input counts that explain the aggregation outcome.")
  inputCounts: EntityDiagnosisAggregationInputCounts;

  @doc("Optional calculation details for the aggregation outcome.")
  calculation?: EntityDiagnosisAggregationCalculation;
}

@doc("Causal signal-group aggregation evidence for one contributing group.")
model EntityDiagnosisSignalGroupAggregationEvidence {
  @doc("Signal-aggregation group name.")
  name: string;

  @doc("Bounded aggregation evidence for this signal group.")
  aggregation: EntityDiagnosisAggregationEvidence;
}

@doc("Entity-level diagnosis evidence.")
model EntityDiagnosisEntityEvidence {
  @doc("Observed health state for the entity.")
  healthState: HealthState;

  @doc("Timestamp when the current health state became active (UTC), when known.")
  lastHealthTransitionAt?: utcDateTime;

  @doc("Outcome that explains how this entity health state was derived.")
  outcome: EntityDiagnosisOutcome;

  @doc("Input categories that determined this entity's diagnosed health state.")
  @maxItems(3)
  determiningInputCategories: EntityDiagnosisDeterminingInputCategory[];

  @doc("Signal evidence contributing to the entity diagnosis.")
  signals: EntityDiagnosisSignalEvidence[];

  @doc("Dependency evidence contributing to the entity diagnosis.")
  dependencies: EntityDiagnosisDependencyEvidence[];

  @doc("Dependency aggregation evidence explaining how dependency inputs were combined.")
  dependencyAggregation?: EntityDiagnosisAggregationEvidence;

  @doc("Causal signal-group aggregation evidence for groups that contributed to the entity state.")
  signalGroupAggregations: EntityDiagnosisSignalGroupAggregationEvidence[];
}

@doc("A diagnosis fragment in the entity diagnosis response.")
model EntityDiagnosisFragment {
  @doc("Entity name represented by this diagnosis fragment.")
  entityName: entityName;

  @doc("Entity diagnosis evidence for this fragment.")
  evidence: EntityDiagnosisEntityEvidence;

  @doc("Parent entity name for nested evidence fragments, when applicable.")
  parentEntityName?: entityName;

  @doc("Health-state contribution from the fragment to its parent, when applicable.")
  contributedHealthState?: HealthState;

  @doc("Names of this entity's configured dependencies that are not causal contributors to its diagnosed state. Computed over the complete dependency set before any response paging or fragment slicing, so it is complete on every returned fragment; names only, and empty when none qualify.")
  nonContributingDependencyNames: string[];

  @doc("Azure resource ID of this entity when it is configured with a qualifying Azure resource; omitted otherwise.")
  azureResourceId?: string;

  @doc("Optional set of labels (key-value pairs)")
  tags?: Record<string4096>;
}

@doc("One page of a bounded entity diagnosis.")
model EntityDiagnosisResult is Page<EntityDiagnosisFragment>;

@@doc(
  EntityDiagnosisResult.value,
  "Diagnosis fragments on this page."
);
@@doc(
  EntityDiagnosisResult.nextLink,
  "URI of the next page, preserving entity, api-version, maxDepth and timestamp. Sole indicator of more pages; absent on the last page."
);

@error
@doc("Returned when a data-plane request fails.")
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
model EntityTransitionHistoryPage is Page<HealthStateTransition>;

@@doc(
  EntityTransitionHistoryPage.value,
  "The health-state transitions, ordered newest first."
);
@@doc(
  EntityTransitionHistoryPage.nextLink,
  "The full URI to fetch the next page of results; absent when there is no next page."
);

@doc("Health-state periods overlapping the requested window, newest first.")
model EntityHealthStateHistoryPage is Page<EntityHealthStatePeriod>;

@@doc(
  EntityHealthStateHistoryPage.value,
  "The health-state periods, ordered newest first."
);
@@doc(
  EntityHealthStateHistoryPage.nextLink,
  "The full URI to fetch the next page of results; absent when there is no next page."
);

@doc("Whether an objective result is conclusive for its requested window.")
union EntityHealthObjectiveEvaluationStatus {
  string,

  @doc("The objective was evaluated over a completely covered window.")
  Complete: "Complete",

  @doc("The objective is not conclusive because the requested window has incomplete coverage.")
  InsufficientCoverage: "InsufficientCoverage",

  @doc("No Health Objective was available from the entity configuration effective at `objective.timestamp`.")
  NotConfigured: "NotConfigured",
}

@doc("Health-objective calculation for one analysis window.")
model EntityHealthObjectiveAnalysis {
  @doc("""
    Point in time whose entity configuration supplied `healthObjective`: the `timestamp` query parameter
    when supplied, otherwise the current service time. Only the objective is resolved at this instant.
    """)
  timestamp: utcDateTime;

  @doc("Whether the objective result is complete, inconclusive, or not configured.")
  evaluationStatus: EntityHealthObjectiveEvaluationStatus;

  @doc("Health Objective as a percentage of time the entity should be healthy.")
  @minValue(0)
  @maxValue(100)
  healthObjective?: float32;

  @doc("Percentage of measured time the objective allows the entity to spend Non-Healthy; `100 - healthObjective`.")
  @minValue(0)
  @maxValue(100)
  allowedNonHealthyPercent?: float64;

  @doc("Percentage of measured time — the summed `stateDurations` — spent Non-Healthy (Degraded, Unhealthy, or Unknown).")
  @minValue(0)
  @maxValue(100)
  actualNonHealthyPercent?: float64;

  @doc("""
    Percentage by which actual Non-Healthy time exceeded the allowance, relative to that allowance:
    `max((actualNonHealthyPercent - allowedNonHealthyPercent) / allowedNonHealthyPercent * 100, 0)`.
    Omitted when `allowedNonHealthyPercent` is zero because division by zero is undefined.
    """)
  @minValue(0)
  exceededNonHealthyPercent?: float64;

  @doc("Non-Healthy duration `healthObjective` allows over the measured time; the time equivalent of `allowedNonHealthyPercent`.")
  allowedNonHealthyDuration?: duration;

  @doc("Duration spent Non-Healthy (Degraded, Unhealthy, or Unknown) within the measured time.")
  actualNonHealthyDuration: duration;

  @doc("Non-Healthy duration beyond the allowance; zero when the allowance was not exceeded.")
  exceededNonHealthyDuration?: duration;

  @doc("""
    Whether the objective was met, judged using the exact values underlying `actualNonHealthyDuration` and
    `allowedNonHealthyDuration` before response rounding. Omitted when the evaluation is not conclusive.
    Comparing the rounded percentage fields instead can report a window that overspent its allowance as
    having met the objective.
    """)
  isMet?: boolean;
}

@doc("Time spent in each health state within an analysis window.")
model EntityHealthStateDurations {
  @doc("Duration spent Healthy.")
  healthy: duration;

  @doc("Duration spent Degraded.")
  degraded: duration;

  @doc("Duration spent Unhealthy.")
  unhealthy: duration;

  @doc("Duration spent Unknown.")
  `unknown`: duration;
}

@doc("Health-state durations and evaluation of the entity's configured Health Objective for one lookback window.")
model EntityHealthAnalysisResult {
  @doc("Requested ISO 8601 lookback duration.")
  lookback: duration;

  @doc("Inclusive start of the requested analysis window; `endAt - lookback`.")
  startAt: utcDateTime;

  @doc("Effective exclusive end of the requested analysis window.")
  endAt: utcDateTime;

  @doc("Health-state durations observed within the window; every state is present, including zero-valued ones.")
  stateDurations: EntityHealthStateDurations;

  @doc("Health-objective calculation for the requested window.")
  objective: EntityHealthObjectiveAnalysis;
}

@doc("Health analysis for an entity over the requested lookback windows.")
model EntityHealthAnalysisQueryResult {
  @doc("The analysis results, in the same order as the requested lookbacks.")
  value: EntityHealthAnalysisResult[];
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
model SignalDataPointHistoryPage is Page<SignalHistoryDataPoint>;

@@doc(
  SignalDataPointHistoryPage.value,
  "The signal data points, ordered newest first."
);
@@doc(
  SignalDataPointHistoryPage.nextLink,
  "The full URI to fetch the next page of results; absent when there is no next page."
);

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
model DataAnnotationsPage is Page<DataAnnotation>;

@@doc(DataAnnotationsPage.value, "The data annotations, ordered newest first.");
@@doc(
  DataAnnotationsPage.nextLink,
  "The full URI to fetch the next page of results; absent when there is no next page."
);

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

@doc("Current health observation submitted for a specific signal.")
model HealthReportPayload {
  @doc("Name of the entity signal to report health for. An unknown name creates an external signal instance.")
  signalName: signalName;

  @doc("Display name of the entity signal to report health for")
  @minLength(1)
  @maxLength(260)
  displayName?: string;

  @doc("Authoritative health state reported by the submitter. The service does not recalculate it from the reported value or evaluation rules.")
  healthState: HealthState;

  @doc("Reported value of the signal.")
  value?: float64;

  @doc("Optional snapshot of the evaluation rules used by the submitter to determine the reported health state. These rules are provenance and do not modify configured signal rules.")
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
  status is RpcOperation<{}, QueryEchoResult, {}, EntityDiagnosticDefaultError>;
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
    EntityDiagnosticDefaultError
  >;
}

interface Entity {
  @doc("Return the current diagnostic snapshot for an entity.")
  get is EntityReadOperations.ResourceRead<
    EntityDiagnosticSnapshot,
    Azure.Core.Traits.QueryParametersTrait<
      {
        @doc("Timestamp to use for the operation. When specified, the version of the entity at this point in time is retrieved. If not specified, the latest version is used.")
        @query
        timestamp?: utcDateTime;
      },
      Azure.Core.Traits.TraitContext.Read
    >
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Paged diagnosis must keep the '/diagnosis' subpath of the entity and pageable diagnosis fragment payload shape; no Azure.Core resource operation template preserves this wire contract."
  @route("/api/entities/{entityName}/diagnosis")
  @doc("Return one bounded diagnosis for an entity, paged through nextLink.")
  @list
  @get
  listDiagnosis is Operation<
    Azure.Core.Foundations.ItemKeysOf<EntityDiagnosticSnapshot> & {
      @doc("Maximum dependency depth for the whole diagnosis across all pages, from 0 through 10; defaults to 10. The root is depth 0; 0 returns only the root fragment with dependency summaries. Continuation never resets depth or extends scope.")
      @query
      @minValue(0)
      @maxValue(10)
      maxDepth?: int32 = 10;

      @doc("An opaque string value that identifies the next page of the diagnosis.")
      @query
      @continuationToken
      nextMarker?: string4096;

      @doc("As-of time for the diagnosis. If not specified, the latest time is resolved on the first page and reused by all pages.")
      @query
      timestamp?: utcDateTime;
    },
    EntityDiagnosisResult,
    {},
    EntityDiagnosticDefaultError
  >;
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
    EntityDiagnosticDefaultError
  >;
}

@route("/api/entities/{entityName}/healthAnalysis")
interface EntityHealthAnalysis {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This operation computes bounded multi-window health-analysis results on the /healthAnalysis subpath rather than reading or listing a resource, and the resource lifecycle templates do not represent its request and response contract."
  @doc("Calculate health-state durations and evaluate the entity's configured Health Objective over one or more lookback windows.")
  @get
  getHealthAnalysis is Operation<
    Azure.Core.Foundations.ItemKeysOf<EntityDiagnosticSnapshot> & {
      @doc("End of the requested analysis window (UTC); defaults to now when omitted. Must be no more than 30 days in the past.")
      @query
      endAt?: utcDateTime;

      @doc("Lookback periods measured back from `endAt`. Each must be a unique, positive fixed ISO 8601 duration whose window starts within the last 30 days.")
      @query
      @minItems(1)
      @maxItems(10)
      lookbacks: string[];

      @doc("Timestamp to use for the operation. When specified, the version of the resource at this point in time is retrieved. If not specified, the latest version is used.")
      @query
      timestamp?: utcDateTime;
    },
    EntityHealthAnalysisQueryResult,
    {},
    EntityDiagnosticDefaultError
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
    EntityDiagnosticDefaultError
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
    EntityDiagnosticDefaultError
  >;
}

interface HealthReportIngestion {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Health report ingestion must keep the deployed '/healthReports' subpath and accepts a report into a durable asynchronous processing pipeline."
  @doc("""
    Durably accept a health report for asynchronous processing.
    A successful response confirms that the report is safely queued, not that downstream health evaluation has completed.
    Use the signal history and entity diagnostic operations to observe the resulting health state.
    A later report for the same signal replaces its current observation while previous values and health states remain available in signal history.
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
    | PayloadTooLargeError
    | UnsupportedMediaTypeError
    | TooManyRequestsError
    | ServiceUnavailableError
    | EntityDiagnosticDefaultError
  >;
}
