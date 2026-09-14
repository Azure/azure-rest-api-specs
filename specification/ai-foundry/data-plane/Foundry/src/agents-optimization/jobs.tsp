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
union AgentOptimizationEvaluationOutcome {
  string,

  @doc("Best candidate exceeded the baseline score.")
  improved: "improved",

  @doc("Optimization completed but no candidate outperformed the baseline.")
  no_improvement: "no_improvement",
}

/** Reason an evaluated candidate search terminated. */
union AgentOptimizationTerminationReason {
  string,

  @doc("The candidate search completed normally.")
  completed: "completed",

  @doc("The candidate search exhausted its evaluation budget.")
  budget_exhausted: "budget_exhausted",

  @doc("The candidate search stopped after the configured number of consecutive failed candidate screens.")
  candidate_screening_stalled: "candidate_screening_stalled",
}

/** Whether a candidate was evaluated against the job's evaluation configuration. */
union AgentOptimizationCandidateEvaluationStatus {
  string,

  @doc("The candidate was evaluated and its evaluation-derived fields may be populated.")
  evaluated: "evaluated",

  @doc("The candidate was generated without comparative evaluation.")
  not_evaluated: "not_evaluated",
}

/**
 * Which layer of the optimization loop generated a token/latency usage entry.
 *
 * Population status for `latency_usage` (as of the initial GA of this contract):
 * - `agent`     — populated when Foundry's agent runtime surfaces `sample.latency_ms`
 *                 (server-measured on the target rollout).
 * - `judge`     — populated when a Foundry evaluator surfaces `sample.latency_ms`
 *                 (server-measured on the evaluator call).
 * - `reflection`— **not currently populated**. The optimizer's reflection/mutation
 *                 model calls are not yet reported with a server-measured latency
 *                 source; this member is reserved so consumers can begin filtering
 *                 for it today without a breaking change when the signal ships.
 *
 * `token_usage` populates all three layers.
 */
union AgentOptimizationLayer {
  string,

  @doc("Agent inference calls (the agent being optimized). Populated on latency_usage from Foundry-reported sample.latency_ms.")
  agent: "agent",

  @doc("Judge / evaluator model calls. Populated on latency_usage when the evaluator surfaces sample.latency_ms.")
  judge: "judge",

  @doc("Reflection / optimization strategy model calls. Populated on token_usage; NOT yet populated on latency_usage — reserved until a server-measured latency source is wired.")
  reflection: "reflection",
}

// ---------------------------------------------------------------------------
// Progress / result models
// ---------------------------------------------------------------------------

@doc("Metadata for the candidate currently under evaluation. Omitted unless a job is in progress with an active candidate.")
model AgentOptimizationInProgressCandidateInfo {
  @doc("Timestamp when the current candidate began evaluation, represented in Unix time. Omitted when the start time is unavailable.")
  created_at?: FoundryTimestamp;

  @doc("Whether the candidate configuration has been fully generated (vs. still being reflected on).")
  candidate_generated: boolean;
}

@doc("In-flight progress. Preserved on terminal states (with in_progress_candidate omitted).")
model AgentOptimizationJobProgress {
  @doc("Number of candidates whose evaluation has completed so far.")
  candidates_completed: int32;

  @doc("Score of the baseline (un-optimized) evaluation. Omitted until the baseline eval completes.")
  baseline_score?: float64;

  @doc("Best score observed so far across all candidates. Omitted until at least one score is available.")
  best_score?: float64;

  @doc("Wall-clock time elapsed since the job began executing. Wire representation: seconds as a float.")
  @encode(DurationKnownEncoding.seconds, float64)
  elapsed_seconds: duration;

  @doc("Metadata for the candidate currently under evaluation. Omitted when no candidate is active and on terminal states.")
  in_progress_candidate?: AgentOptimizationInProgressCandidateInfo;

  @doc("Promotion metadata. Omitted until a candidate from this job has been promoted.")
  promotion?: PromotionInfo;
}

@doc("Aggregated token usage attributable to a single layer of the optimization loop.")
model AgentOptimizationTokenUsageEntry {
  @doc("Which layer of the optimization loop generated these calls.")
  layer: AgentOptimizationLayer;

  @doc("Model deployment name that served the calls. Empty string when the source sample didn't attribute a model.")
  `model`: string;

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

@doc("Aggregated wall-clock latency attributable to a single layer of the optimization loop. Sourced from server-measured signals (Foundry's `sample.latency_ms` on the target rollout and evaluator responses). Layers without a server-measured source are omitted from the array rather than populated with client-observed timings that would conflate real model latency with local retry/network overhead.")
model AgentOptimizationLatencyUsageEntry {
  @doc("Which layer of the optimization loop generated these calls. See `AgentOptimizationLayer` for per-layer population status.")
  layer: AgentOptimizationLayer;

  @doc("Model deployment name that served the calls.")
  `model`: string;

  #suppress "@azure-tools/typespec-azure-core/known-encoding" "AgentsOptimization wire uses floating-point milliseconds; preserve the existing wire contract while exposing a semantic duration type."
  @doc("Average per-call latency. Wire representation: milliseconds as a float.")
  @encode(DurationKnownEncoding.milliseconds, float64)
  avg_latency_ms: duration;

  @doc("Total number of calls contributing to this entry.")
  call_count: int64;
}

@doc("Fields shared by evaluated and unevaluated optimization results.")
@discriminator("evaluation_status")
model AgentOptimizationJobResult {
  @doc("Whether this job comparatively evaluates its candidates.")
  evaluation_status: AgentOptimizationCandidateEvaluationStatus;

  @doc("Candidate ID of the original baseline. Omitted until the baseline candidate is available.")
  baseline_candidate_id?: string;

  @doc("All candidate IDs produced by this job, in evaluation order. Omitted until at least one candidate is available. Use GET /candidates/{id} for the mutation payload and file manifest, or GET /candidates for a paginated summary listing.")
  candidate_ids?: string[];

  @doc("Aggregate token usage per layer × model. Always present; empty array when no calls were measured.")
  token_usage: AgentOptimizationTokenUsageEntry[];

  @doc("Aggregate latency per layer × model, from server-measured sources only. Always present; empty array when no server-measured latency signals were surfaced (e.g. an early-failure run or an all-hosted judge run whose evaluators do not report latency_ms).")
  latency_usage: AgentOptimizationLatencyUsageEntry[];
}

@doc("Partial or terminal result for quality or cost optimization.")
model EvaluatedAgentOptimizationJobResult extends AgentOptimizationJobResult {
  @doc("Result evaluation status.")
  evaluation_status: "evaluated";

  @doc("Candidate ID of the highest-scoring candidate. Omitted until a candidate has been selected.")
  best_candidate_id?: string;

  @doc("Outcome of comparative evaluation. Omitted until the evaluated job reaches a terminal state.")
  evaluation_outcome?: AgentOptimizationEvaluationOutcome;

  @doc("Reason the candidate search terminated. Omitted until the evaluated job reaches a terminal state.")
  termination_reason?: AgentOptimizationTerminationReason;
}

@doc("Partial or terminal result for a transformation job that does not comparatively evaluate candidates.")
model UnevaluatedAgentOptimizationJobResult extends AgentOptimizationJobResult {
  @doc("Result evaluation status.")
  evaluation_status: "not_evaluated";

  @doc("Candidate ID produced by the transformation. Omitted until the output candidate is available.")
  output_candidate_id?: string;
}

// ---------------------------------------------------------------------------
// Job resource — extends JobLike per Foundry job guidelines
// ---------------------------------------------------------------------------

@doc("Agent optimization job resource — a long-running job that produces candidate changes to a Foundry agent configuration.")
model AgentOptimizationJob is JobLike<
  AgentOptimizationJobResult,
  AgentOptimizationJobInputs
> {
  @doc("The timestamp when the job was created, represented in Unix time.")
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  @doc("The timestamp when the job was last updated, represented in Unix time.")
  @visibility(Lifecycle.Read)
  updated_at: FoundryTimestamp;

  @doc("Progress snapshot. Omitted before progress is available; preserved on terminal states with in_progress_candidate omitted.")
  @visibility(Lifecycle.Read)
  progress?: AgentOptimizationJobProgress;

  @doc("Non-fatal warnings emitted during optimization. Omitted when no warnings were produced.")
  @visibility(Lifecycle.Read)
  warnings?: string[];
}
