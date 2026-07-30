// Models for the Experiments data-plane surface.
// Provides experiment lifecycle for A/B version traffic-split on agents.

import "../common/models.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

const ExperimentsRequiredPreviews = #{
  conditional_previews: #[FoundryFeaturesOptInKeys.experiments_v1_preview],
};

// ---------------------------------------------------------------------------
// Enums / unions
// ---------------------------------------------------------------------------

/** The discriminated experiment kind. */
union ExperimentType {
  string,

  /** A/B experiment across agent versions with sticky-per-conversation routing. */
  agents_safe_rollout: "agents_safe_rollout",
}

/** The lifecycle state of the experiment. */
union ExperimentState {
  string,

  /** The experiment has been created but not yet started. */
  created: "created",

  /** The experiment is actively routing traffic. */
  running: "running",

  /** The experiment has been stopped; routing collapsed to control. */
  stopped: "stopped",

  /** The winning variant has been promoted. */
  promoted: "promoted",
}

/** The role of a variant in the experiment. */
union ExperimentVariantRole {
  string,

  /** The baseline variant (receives the majority of traffic). */
  control: "control",

  /** The candidate variant being tested. */
  treatment: "treatment",
}

/** The desired direction for a metric value. */
union ExperimentMetricDirection {
  string,

  /** Higher values are better. */
  increase: "increase",

  /** Lower values are better. */
  decrease: "decrease",

  /** The metric has no preferred direction. */
  neutral: "neutral",
}

/** The aggregation function for a metric. */
union ExperimentMetricAggregationType {
  string,

  /** Arithmetic mean. */
  average: "average",

  /** Percentile (requires the `percentile` parameter). */
  percentile: "percentile",
}

/** The type of metric source. */
union ExperimentMetricSourceType {
  string,

  /** An inline evaluator definition that the service materializes into a scheduled evaluation rule. */
  evaluator: "evaluator",

  /** A trace-level metric (e.g. latency_ms, error rate). */
  traces: "traces",
}

/** The state of a scorecard. */
union ScorecardState {
  string,

  /** The scorecard is ready and can be read. */
  ready: "ready",

  /** The scorecard is still being computed. */
  computing: "computing",

  /** The scorecard computation failed. */
  failed: "failed",
}

/** The granularity a scorecard metric is measured at. */
union ScorecardMetricLevel {
  string,

  /** The metric is measured per agent turn. */
  turn: "turn",

  /** The metric is measured per conversation. */
  conversation: "conversation",
}

/** The qualitative outcome of a metric's treatment-vs-control comparison. */
union ScorecardTreatmentEffect {
  string,

  /** Significant change in the desired direction. */
  improved: "improved",

  /** Significant change against the desired direction. */
  degraded: "degraded",

  /** Significant change on a neutral-direction metric (no preferred direction). */
  changed: "changed",

  /** Not statistically significant at the metric's threshold. */
  inconclusive: "inconclusive",

  /** Below the metric's minimum sample size. */
  insufficient_data: "insufficient_data",

  /** Neither variant produced any samples. */
  no_samples: "no_samples",

  /** The comparison could not be classified (e.g. no p-value). */
  `unknown`: "unknown",
}

// ---------------------------------------------------------------------------
// Models
// ---------------------------------------------------------------------------

/** A variant participating in the experiment. */
model ExperimentVariant {
  @doc("The variant identifier. For agents_safe_rollout this is the agent version number.")
  id: string;

  @doc("The role of this variant in the experiment.")
  role: ExperimentVariantRole;

  @doc("The percentage of traffic to route to this variant. Across all variants the percentages must sum to 100.")
  traffic_percentage: int32;

  @doc("The minimum number of observations required before this variant's scorecard results are considered reliable. If omitted, the service defaults to 100.")
  required_sample_size?: int32 = 100;
}

/** A contiguous range of hash buckets assigned to a variant. */
model ExperimentBucketRange {
  @doc("The inclusive start of the bucket range (0-based).")
  start: int32;

  @doc("The exclusive end of the bucket range.")
  end: int32;
}

/** Traffic allocation map for a single variant within an experiment step. */
model ExperimentVariantTrafficMap {
  @doc("The variant identifier this traffic map applies to.")
  variant_id: string;

  @doc("The traffic percentage for this variant.")
  percentage: int32;

  @doc("The hash bucket ranges assigned to this variant.")
  bucket_ranges: ExperimentBucketRange[];
}

/** A step in the experiment with traffic allocation details. */
model ExperimentStep {
  @doc("The identifier for this experiment step.")
  id: string;

  @doc("The Unix timestamp (seconds) when this step started.")
  started_at: FoundryTimestamp;

  @doc("The Unix timestamp (seconds) when this step stopped. Null if still running.")
  stopped_at?: FoundryTimestamp | null;

  @doc("The traffic allocation for each variant in this step.")
  variant_traffic_maps: ExperimentVariantTrafficMap[];
}

/** Properties controlling how traffic is assigned to variants. */
model ExperimentAssignmentProperties {
  @doc("An immutable bucketing seed minted when the experiment starts. Re-salting re-randomizes every bucket.")
  @visibility(Lifecycle.Read)
  salt: string;

  @doc("The unit used for sticky bucketing (e.g. conversationId).")
  @visibility(Lifecycle.Read)
  assignment_unit: string;
}

/** Aggregation configuration for a metric. */
model ExperimentMetricAggregation {
  @doc("The aggregation function.")
  type: ExperimentMetricAggregationType;

  @doc("The percentile value (e.g. 95). Required when type is 'percentile'.")
  percentile?: int32;
}

/** The source of a metric value, discriminated by type. */
@discriminator("type")
model ExperimentMetricSource {
  @doc("The type of metric source.")
  type: ExperimentMetricSourceType;
}

/** A metric sourced from an evaluator (a judge that scores agent output). */
model EvaluatorMetricSource extends ExperimentMetricSource {
  @doc("The evaluator source kind.")
  type: ExperimentMetricSourceType.evaluator;

  @doc("The evaluator name.")
  evaluator_name: string;

  @doc("The evaluator version to pin. If omitted, the service uses the latest version.")
  evaluator_version?: string;

  @doc("Additional evaluator parameters.")
  parameters?: Record<unknown>;
}

/** A metric sourced from trace/event attributes. */
model TracesMetricSource extends ExperimentMetricSource {
  @doc("The traces source kind.")
  type: ExperimentMetricSourceType.traces;

  @doc("Trace attribute names the metric value is read from. Each attribute must be numeric, or boolean (coerced to 1/0). When more than one is given, the per-event value is the sum of the attributes; a missing attribute contributes 0 (partial rows are kept), and the event value is null only when every listed attribute is null.")
  attribute_names: string[];
}

/** The definition of a metric — wraps the data source and optional aggregation. */
model ExperimentMetricDefinition {
  @doc("The source of the metric data.")
  source: ExperimentMetricSource;

  @doc("Optional aggregation configuration. If omitted, the service uses the evaluator's default aggregation.")
  aggregation?: ExperimentMetricAggregation;
}

/** A metric attached to the experiment — defines what to measure, how to aggregate, and where the data comes from. */
model ExperimentMetric {
  @doc("The caller-defined metric name, unique within the experiment.")
  name: string;

  @doc("The desired direction for this metric. Optional; if omitted, the service infers from the evaluator defaults.")
  desired_direction?: ExperimentMetricDirection;

  @doc("The metric definition including data source and optional aggregation.")
  definition: ExperimentMetricDefinition;
}

/** Structured failure detail for a scorecard whose state is 'failed'. */
model ScorecardError {
  @doc("Stable, machine-readable failure category (e.g. 'compute_failed', 'internal_error', 'publish_failed').")
  code: string;

  @doc("Human-readable (truncated) failure description.")
  message: string;
}

/** A treatment variant's comparison against the scorecard's control for one metric. */
model ScorecardPairComparison {
  @doc("The signed delta: this variant's average minus the control's.")
  delta: float64;

  @doc("The p-value for significance vs. the control.")
  p_value: float64;

  @doc("The relative difference vs. the control, or null when the control average is zero.")
  relative_difference?: float64 | null;

  @doc("The qualitative treatment effect vs. the control, classified from the p-value and thresholds.")
  treatment_effect: ScorecardTreatmentEffect;
}

/** One variant's result for a metric row: its raw aggregates plus, for treatment variants, the comparison against the control. */
model ScorecardVariantResult {
  @doc("The variant identifier (for agents_safe_rollout this is the agent version number).")
  variant_id: string;

  @doc("The number of observations.")
  count: int32;

  @doc("The arithmetic mean of the metric values.")
  average: float64;

  @doc("The standard deviation of the metric values.")
  std_dev: float64;

  @doc("This variant's comparison against the scorecard's control. Null for the control variant.")
  comparison?: ScorecardPairComparison;
}

/** A single row in a scorecard table — one metric compared across every variant. */
model ScorecardRow {
  @doc("The metric name this row corresponds to.")
  metric_name: string;

  @doc("The granularity this metric is measured at (turn or conversation).")
  level: ScorecardMetricLevel;

  @doc("The kind of source this metric is derived from (evaluator or traces).")
  category: ExperimentMetricSourceType;

  @doc("The desired direction for this metric.")
  desired_direction: ExperimentMetricDirection;

  @doc("One result per variant (control plus every treatment) for this metric.")
  variants: ScorecardVariantResult[];
}

/** Fields shared by the scorecard summary and detail representations. */
model ScorecardBase {
  @doc("The unique identifier of the scorecard.")
  id: string;

  @doc("The experiment this scorecard belongs to.")
  experiment_id: string;

  @doc("The control (baseline) variant used by this scorecard.")
  control_variant_id: string;

  @doc("The treatment variants compared against the control in this scorecard.")
  treatment_variant_ids: string[];

  @doc("The inclusive start of the observation window this scorecard was computed over, as a Unix timestamp (seconds).")
  window_start: FoundryTimestamp;

  @doc("The exclusive end of the observation window this scorecard was computed over, as a Unix timestamp (seconds).")
  window_end: FoundryTimestamp;

  @doc("The Unix timestamp (seconds) when this scorecard was generated.")
  created_at: FoundryTimestamp;

  @doc("The state of the scorecard.")
  state: ScorecardState;

  @doc("Failure detail when the state is 'failed'. Null otherwise.")
  error?: ScorecardError;

  @doc("Optional open key-value metadata for forward-compatible extension (e.g. compute window, template version). First-class data stays in typed fields, not here.")
  metadata?: Record<string>;
}

/** Lightweight scorecard projection returned by list operations. The full metric rows are available only from the individual scorecard resource. */
model ScorecardSummary {
  ...ScorecardBase;

  @doc("The number of metric rows in the full scorecard.")
  metric_count: int32;
}

/** A generated scorecard artifact — a table comparing metric values between variants. */
model Scorecard {
  ...ScorecardBase;

  @doc("The metric comparison rows.")
  rows: ScorecardRow[];
}

/** Configuration and service-managed resources for scheduled experiment evaluation. */
model ExperimentEvaluation {
  @doc("The deployed model used by evaluator-backed metrics.")
  `model`?: string;

  @doc("The service-managed evaluation group identifier.")
  @visibility(Lifecycle.Read)
  eval_id?: string;

  @doc("The service-managed schedule identifier.")
  @visibility(Lifecycle.Read)
  schedule_id?: string;
}

/** A materialized experiment that binds version routing to a lifecycle for A/B testing. */
@discriminator("type")
model Experiment {
  @doc("The unique identifier of the experiment.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The discriminated experiment kind.")
  type: ExperimentType;

  @doc("The lifecycle state of the experiment.")
  @visibility(Lifecycle.Read)
  state: ExperimentState;

  @doc("A human-readable display name for the experiment.")
  display_name: string;

  @doc("A human-readable description of the experiment.")
  description?: string;

  @doc("The experiment duration in days. Drives only the service-managed scorecard refresh horizon (how long scorecards keep refreshing after start); it does not end the experiment — the experiment ends only when the caller stops or promotes it. Defaults to 7 when omitted.")
  duration_in_days?: int32;

  @doc("The list of variants participating in the experiment.")
  variants: ExperimentVariant[];

  @doc("The list of metrics attached to the experiment.")
  metrics: ExperimentMetric[];

  @doc("Configuration and service-managed resources for scheduled evaluation.")
  evaluation?: ExperimentEvaluation;

  @doc("The list of experiment steps with traffic allocation details. Materialized by the service.")
  @visibility(Lifecycle.Read)
  experiment_steps: ExperimentStep[];

  @doc("Properties controlling how traffic is assigned to variants.")
  @visibility(Lifecycle.Read)
  assignment_properties: ExperimentAssignmentProperties;

  @doc("The Unix timestamp (seconds) when the experiment was created.")
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  @doc("The Unix timestamp (seconds) when the experiment was started. Null if not yet started.")
  @visibility(Lifecycle.Read)
  started_at?: FoundryTimestamp | null;

  @doc("The actual end time (Unix seconds), set when the experiment is stopped or promoted. Null while the experiment is created or running.")
  @visibility(Lifecycle.Read)
  end_at?: FoundryTimestamp | null;
}

/** An experiment that safely rolls traffic between versions of one agent. */
model AgentsSafeRolloutExperiment extends Experiment {
  @doc("The A/B safe-rollout experiment kind.")
  type: ExperimentType.agents_safe_rollout;

  @doc("The name of the agent whose versions participate in the rollout.")
  target_agent: string;
}

/** Request body for creating an experiment. */
@discriminator("type")
model CreateExperimentRequest {
  @doc("The discriminated experiment kind.")
  type: ExperimentType;

  @doc("A human-readable display name for the experiment.")
  display_name: string;

  @doc("A human-readable description of the experiment.")
  description?: string;

  @doc("The experiment duration in days. Drives only the service-managed scorecard refresh horizon; it does not end the experiment. If omitted, the service defaults to 7.")
  duration_in_days?: int32 = 7;

  @doc("The list of variants. Each variant id is an agent version number. Exactly one must have role 'control'. traffic_percentage must sum to 100.")
  variants: ExperimentVariant[];

  @doc("Optional list of metrics to attach to the experiment.")
  metrics?: ExperimentMetric[];

  @doc("Optional scheduled evaluation configuration.")
  evaluation?: ExperimentEvaluation;
}

/** Request body for creating an agents_safe_rollout experiment. */
model CreateAgentsSafeRolloutExperimentRequest extends CreateExperimentRequest {
  @doc("The A/B safe-rollout experiment kind.")
  type: ExperimentType.agents_safe_rollout;

  @doc("The name of the agent targeted by the experiment.")
  target_agent: string;
}

/**
 * Request body for patching an experiment. Only experiments still in the 'created' state may be
 * updated; omitted fields are left unchanged. Type-specific identity (e.g. agents_safe_rollout
 * target_agent) is immutable and cannot be changed here.
 */
model PatchExperimentRequest {
  @doc("The experiment kind. Must match the existing experiment.")
  type: ExperimentType;

  @doc("The new display name. Left unchanged when omitted.")
  display_name?: string;

  @doc("The new description. Left unchanged when omitted.")
  description?: string;

  @doc("The new duration in days. Left unchanged when omitted.")
  duration_in_days?: int32;

  @doc("The replacement variant list. When provided it fully replaces the existing variants and must satisfy the same rules as on create.")
  variants?: ExperimentVariant[];

  @doc("The replacement metric list. When provided it fully replaces the existing metrics.")
  metrics?: ExperimentMetric[];

  @doc("The replacement scheduled evaluation configuration. Left unchanged when omitted.")
  evaluation?: ExperimentEvaluation;
}

/** Request body for promoting an experiment. */
model PromoteExperimentRequest {
  @doc("The variant id (agent version) to promote as the winner. The agent's version selector is replaced with a single 100% rule for this version.")
  winner_variant_id: string;
}
