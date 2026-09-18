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

/** Outcome of an optimization job that evaluated candidates against a baseline. */
union AgentOptimizationJobOutcome {
  string,

  @doc("Best candidate exceeded the baseline score.")
  improved: "improved",

  @doc("Optimization completed but no candidate outperformed the baseline.")
  no_improvement: "no_improvement",
}

/** Reason an evaluated candidate search ended. These values describe successful search completion and do not indicate job failure. */
union AgentOptimizationJobTerminationReason {
  string,

  @doc("The candidate search completed normally.")
  completed: "completed",

  @doc("The successful job stopped early after exhausting its evaluation budget.")
  budget_exhausted: "budget_exhausted",

  @doc("The successful job stopped early after the configured number of consecutive failed candidate screens.")
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

@doc("Partial or terminal result produced by an agent optimization job.")
model AgentOptimizationJobResult {
  @doc("Candidate ID of the original baseline. Omitted until the baseline candidate is available.")
  baseline_candidate_id?: string;

  @doc("Stable candidate resource IDs, populated progressively in candidate-slot order. The baseline candidate is always first. Use candidate GET or LIST for lifecycle and full candidate details.")
  candidate_ids?: string[];

  @doc("Score of the baseline candidate. Omitted until baseline evaluation completes.")
  baseline_score?: float64;

  @doc("Best score observed across completed candidates. Omitted until a candidate completes evaluation.")
  best_score?: float64;

  @doc("Aggregate token usage per stage and model. Always present; empty array when no calls were measured.")
  token_usage: AgentOptimizationJobTokenUsage[];

  @doc("Aggregate latency per stage and model. Always present; empty when no server-measured latency is available.")
  latency_usage: AgentOptimizationJobLatency[];

  @doc("Candidate ID of the highest-scoring candidate. Omitted for jobs that do not comparatively evaluate candidates and until a candidate has been selected.")
  best_candidate_id?: string;

  @doc("Outcome of comparative evaluation. Omitted for jobs that do not comparatively evaluate candidates and until the job reaches a terminal state.")
  outcome?: AgentOptimizationJobOutcome;

  @doc("Reason the candidate search terminated. Omitted for jobs that do not comparatively evaluate candidates and until the job reaches a terminal state.")
  termination_reason?: AgentOptimizationJobTerminationReason;

  @doc("Candidate ID produced by a transformation job that does not comparatively evaluate candidates. Omitted for evaluated jobs and until the output candidate is available.")
  output_candidate_id?: string;
}

// ---------------------------------------------------------------------------
// Job resource — extends JobLike per Foundry job guidelines
// ---------------------------------------------------------------------------

@doc("Agent optimization job resource — a long-running job that produces candidate changes to a Foundry agent configuration.")
model AgentOptimizationJob is JobLike<
  AgentOptimizationJobResult,
  never
> {
  ...AgentOptimizationJobInputs;

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
