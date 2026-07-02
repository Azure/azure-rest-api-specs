// Models for the Experiments data-plane surface.
// Provides experiment lifecycle for A/B version traffic-split on agents.

import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "../agents/models.tsp";

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
}

/** The aggregation function for a metric. */
union ExperimentMetricAggregationType {
  string,

  /** Arithmetic mean. */
  average: "average",

  /** Percentile (requires the `percentile` parameter). */
  percentile: "percentile",

  /** Rate (count of occurrences / total). */
  rate: "rate",
}

/** The type of metric source. */
union ExperimentMetricSourceType {
  string,

  /** References an existing continuous evaluation rule by its schedule ID. */
  continuous_evaluation_rule: "continuous_evaluation_rule",

  /** An inline evaluator definition that the service materializes into a continuous evaluation rule. */
  evaluator: "evaluator",

  /** A trace-level metric (e.g. latency, error rate). */
  trace_metric: "trace_metric",
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

// ---------------------------------------------------------------------------
// Models
// ---------------------------------------------------------------------------

/** A variant participating in the experiment. */
model ExperimentVariant {
  @doc("The variant identifier. For agents_safe_rollout this is the agent version number.")
  id: string;

  @doc("The role of this variant in the experiment.")
  role: ExperimentVariantRole;

  @doc("The percentage of traffic to route to this variant. Required on create; may be omitted in materialized responses (use experiment_steps instead).")
  traffic_percentage?: int32;
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
  started_at?: FoundryTimestamp | null;

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
model ExperimentMetricSource {
  @doc("The type of metric source.")
  type: ExperimentMetricSourceType;

  @doc("The schedule ID of a continuous evaluation rule. Required when type is 'continuous_evaluation_rule'.")
  rule_id?: string;

  @doc("The built-in evaluator name (e.g. 'builtin.groundedness'). Required when type is 'evaluator'.")
  evaluator_name?: string;

  @doc("The trace metric name (e.g. 'latency_ms'). Required when type is 'trace_metric'.")
  name?: string;
}

/** Guardrail threshold for a metric. Metrics with guardrails are monitored for safety bounds. */
model ExperimentMetricGuardrail {
  @doc("Maximum allowed relative delta as a percentage. If the treatment deviates by more than this, the guardrail is breached.")
  max_delta_percent?: float64;

  @doc("Maximum allowed absolute value. If the treatment exceeds this, the guardrail is breached.")
  max_absolute?: float64;

  @doc("The current guardrail state (e.g. 'monitoring', 'breached'). Service-managed.")
  @visibility(Lifecycle.Read)
  state?: string;
}

/** A metric attached to the experiment — defines what to measure, how to aggregate, where the data comes from, and optional guardrails. */
model ExperimentMetric {
  @doc("The metric identifier, unique within the experiment.")
  id: string;

  @doc("The desired direction for this metric.")
  direction: ExperimentMetricDirection;

  @doc("The aggregation configuration.")
  aggregation: ExperimentMetricAggregation;

  @doc("The source of the metric data.")
  source: ExperimentMetricSource;

  @doc("Optional guardrail threshold. Metrics with guardrails are monitored for safety bounds.")
  guardrail?: ExperimentMetricGuardrail;
}

/** A single row in a scorecard table — one metric comparison between control and treatment. */
model ScorecardRow {
  @doc("The metric identifier this row corresponds to.")
  metric_id: string;

  @doc("A human-readable label for the metric.")
  label: string;

  @doc("The metric value for the control variant.")
  control_value: float64;

  @doc("The metric value for the treatment variant.")
  treatment_value: float64;

  @doc("The absolute delta between treatment and control.")
  delta: float64;

  @doc("The p-value for statistical significance.")
  p_value: float64;

  @doc("Whether this row corresponds to a guardrail metric.")
  guardrail?: boolean;
}

/** A generated scorecard artifact — a table comparing metric values between variants. */
model Scorecard {
  @doc("The unique identifier of the scorecard.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The experiment this scorecard belongs to.")
  experiment_id: string;

  @doc("The state of the scorecard.")
  state: ScorecardState;

  @doc("The URI to the scorecard artifact in the user's blob storage.")
  artifact_uri: string;

  @doc("The metric comparison rows.")
  rows: ScorecardRow[];
}

/** Represents an experiment that binds version routing to a lifecycle for A/B testing. */
model Experiment {
  @doc("The unique identifier of the experiment.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The discriminated experiment kind.")
  type: ExperimentType;

  @doc("The lifecycle state of the experiment.")
  state: ExperimentState;

  @doc("A human-readable display name for the experiment.")
  display_name: string;

  @doc("A human-readable description of the experiment.")
  description?: string;

  @doc("The name of the agent this experiment targets. Required for agents_safe_rollout type.")
  target_agent?: string;

  @doc("The list of variants participating in the experiment.")
  variants: ExperimentVariant[];

  @doc("The list of experiment steps with traffic allocation details. Materialized by the service.")
  @visibility(Lifecycle.Read)
  experiment_steps: ExperimentStep[];

  @doc("Properties controlling how traffic is assigned to variants.")
  assignment_properties: ExperimentAssignmentProperties;

  @doc("The list of metrics (evaluation rules or inline evaluators) attached to the experiment.")
  metrics: ExperimentMetric[];

  @doc("The scheduled start time for the experiment. Null if started immediately.")
  scheduled_start_at?: FoundryTimestamp | null;

  @doc("The scheduled end time for the experiment. Null if no end is scheduled.")
  scheduled_end_at?: FoundryTimestamp | null;
}

/** Request body for creating an experiment. */
model CreateExperimentRequest {
  @doc("The discriminated experiment kind.")
  type: ExperimentType;

  @doc("The name of the agent this experiment targets. Required for agents_safe_rollout type.")
  target_agent?: string;

  @doc("A human-readable display name for the experiment.")
  display_name: string;

  @doc("A human-readable description of the experiment.")
  description?: string;

  @doc("The list of variants. Each variant id is an agent version number. Exactly one must have role 'control'. traffic_percentage must sum to 100.")
  variants: ExperimentVariant[];

  @doc("Optional list of metrics (evaluation rules or inline evaluators) to attach to the experiment.")
  metrics?: ExperimentMetric[];
}

/** Request body for promoting an experiment. */
model PromoteExperimentRequest {
  @doc("The variant id (agent version) to promote as the winner. The agent's version selector is replaced with a single 100% rule for this version.")
  winner_variant_id: string;
}
