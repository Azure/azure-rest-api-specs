// Job and result models for the AgentsOptimization data-plane surface (v1 GA).

import "./inputs.tsp";
import "./candidates.tsp";
import "../common/models.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.Rest;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Job and result enums / unions
// ---------------------------------------------------------------------------

/** Reason the optimization process ended. Early termination reasons still indicate a successful job; completed candidates remain available. */
union AgentOptimizationTerminationReason {
  string,

  @doc("The optimization process completed normally.")
  completed: "completed",

  @doc("The job succeeded with its completed candidates, but stopped before producing more candidates because its bounded evaluation-call budget was consumed.")
  budget_exhausted: "budget_exhausted",

  @doc("The job succeeded with its completed candidates, but stopped after the configured number of consecutive proposed candidates failed screening.")
  candidate_screening_stalled: "candidate_screening_stalled",
}

/** Stage of optimization that consumed model resources. */
union AgentOptimizationStage {
  string,

  @doc("Calls made by the agent being optimized.")
  agent: "agent",

  @doc("Calls that evaluate candidate quality.")
  evaluation: "evaluation",

  @doc("Calls that generate candidate changes.")
  optimization: "optimization",
}

// ---------------------------------------------------------------------------
// Result models
// ---------------------------------------------------------------------------

@doc("Aggregated token usage for one optimization stage and model.")
model AgentOptimizationJobTokenUsage {
  @doc("Optimization stage that generated these calls.")
  stage: AgentOptimizationStage;

  @doc("Model name or deployment name that served the calls.")
  `model`?: string;

  @doc("Total input tokens. Omitted when unmeasured.")
  input_tokens?: int64;

  @doc("Total output tokens. Omitted when unmeasured.")
  output_tokens?: int64;

  @doc("Sum of input_tokens + output_tokens. Omitted when unmeasured.")
  total_tokens?: int64;

  @doc("Input tokens served from the model's cache. Included in input_tokens and not additive. Defaults to 0 when omitted.")
  cached_tokens?: int64 = 0;

  @doc("Reasoning tokens counted separately by reasoning models. Included in output_tokens and not additive. Defaults to 0 when omitted.")
  reasoning_tokens?: int64 = 0;
}

@doc("Average latency for one optimization stage and model.")
model AgentOptimizationJobLatency {
  @doc("Optimization stage measured by this entry.")
  stage: AgentOptimizationStage;

  @doc("Model name or deployment name measured by this entry.")
  `model`?: string;

  @doc("Average per-call latency, rounded to milliseconds.")
  avg_latency_ms: int64;

  @doc("Total number of calls contributing to this entry.")
  call_count: int64;
}

@doc("Summary of candidates produced by an agent optimization job.")
model AgentOptimizationResultCandidateSummary {
  @doc("Number of completed candidates, including the baseline once completed.")
  completed_candidate_count: int32;

  @doc("Candidate ID of the original baseline. Omitted until the baseline candidate is available.")
  baseline_id?: string;

  @doc("Candidate ID of the highest-scoring candidate for evaluated jobs, or the selected transformed output for non-comparative jobs. Omitted until a candidate has been selected.")
  best_id?: string;

  @doc("Score of the baseline candidate for a comparatively evaluated job. Omitted otherwise and until baseline evaluation completes.")
  baseline_score?: float64;

  @doc("Best score observed for a comparatively evaluated job. Omitted otherwise and until a candidate completes evaluation.")
  best_score?: float64;
}

@doc("Partial or terminal result produced by an agent optimization job.")
model AgentOptimizationJobResult {
  @doc("Summary of candidates produced by the job. Omitted until candidate processing begins.")
  candidate_summary?: AgentOptimizationResultCandidateSummary;

  @doc("Aggregate token usage per stage and model. Always present; empty array when no calls were measured.")
  token_usage: AgentOptimizationJobTokenUsage[];

  @doc("Aggregate latency per stage and model. Always present; empty when no server-measured latency is available.")
  latency_usage: AgentOptimizationJobLatency[];

  @doc("Reason the candidate search terminated. Omitted for jobs that do not comparatively evaluate candidates and until the job reaches a terminal state.")
  termination_reason?: AgentOptimizationTerminationReason;
}

// ---------------------------------------------------------------------------
// Job resource — extends JobLike per Foundry job guidelines
// ---------------------------------------------------------------------------

@doc("Agent optimization job resource — a long-running job that produces candidate changes to a Foundry agent configuration.")
model AgentOptimizationJob is JobLike<
  AgentOptimizationJobResult,
  never
> {
  @doc("Human-readable label. Omitted when no label is needed; it has no uniqueness, routing, or idempotency semantics.")
  @maxLength(256)
  display_name?: string;

  @doc("Foundry agent whose configuration is optimized. Omitted when the workflow does not target a registered Foundry agent.")
  target_configuration?: AgentOptimizationTargetConfiguration;

  @doc("Model used to generate candidate changes. An existing deployment name is also accepted.")
  optimization_model_configuration: AgentOptimizationModelConfiguration;

  @doc("Type-specific optimization configuration.")
  optimization_configuration: AgentOptimizationConfigurationBase;

  @doc("The timestamp when the job was created, represented in Unix time.")
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  @doc("The timestamp when the job was last updated, represented in Unix time.")
  @visibility(Lifecycle.Read)
  updated_at: FoundryTimestamp;

  @doc("Non-fatal warnings emitted during optimization. Omitted when no warnings were produced.")
  @visibility(Lifecycle.Read)
  warnings?: string[];
}

@doc("Configuration used to create an agent optimization job.")
model AgentOptimizationJobCreate is PickProperties<
  AgentOptimizationJob,
  "display_name"
    | "target_configuration"
    | "optimization_model_configuration"
    | "optimization_configuration"
>;
