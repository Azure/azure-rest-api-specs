// Models for the AgentsOptimization data-plane surface (V3Preview).
//
// Uses shared Foundry job infrastructure from servicepatterns.tsp:
//   JobLike<TResult, TInputs> — base job shape (id, status, inputs, result, error)
//   JobStatus — shared lifecycle union (queued/in_progress/succeeded/failed/cancelled)
//   FoundryTimestamp — Unix epoch int32
//   ApiError — standard error shape

import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "../openai/evaluations/models.tsp";

using TypeSpec.Rest;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

const AgentOptimizationRequiredPreviews = #{
  conditional_previews: #[
    FoundryFeaturesOptInKeys.agents_optimization_v3_preview
  ],
};

// ---------------------------------------------------------------------------
// Enums / unions
// ---------------------------------------------------------------------------

/** Agent attribute that can be optimized. */
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
union TargetAttribute {
  string,

  @doc("Instruction-tuning — rewrites agent system prompts.")
  instruction: "instruction",

  @doc("Model-selection — evaluates alternative LLM deployments (uses options.model_search_space).")
  `model`: "model",

  @doc("Skill-tuning — generates or modifies agent skill descriptions.")
  skill: "skill",

  @doc("Tool-tuning — optimizes function tool descriptions and parameter descriptions.")
  tool: "tool",
}

/** Terminal completion classification for a successful optimization job. */
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
union AgentOptimizationCompletionStatus {
  string,

  @doc("Best candidate exceeded the baseline score.")
  improved: "improved",

  @doc("Optimization completed but no candidate outperformed the baseline.")
  no_improvement: "no_improvement",

  @doc("Optimization halted early because max_stalls was reached.")
  stopped_early: "stopped_early",
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
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
union AgentOptimizationLayer {
  string,

  @doc("Agent inference calls (the agent being optimized). Populated on latency_usage from Foundry-reported sample.latency_ms.")
  agent: "agent",

  @doc("Judge / evaluator model calls. Populated on latency_usage when the evaluator surfaces sample.latency_ms.")
  judge: "judge",

  @doc("Reflection / optimization strategy model calls. Populated on token_usage; NOT yet populated on latency_usage — reserved until a server-measured latency source is wired.")
  reflection: "reflection",
}

/** Optimization strategy identifier. Open string so the SDK stays usable when new strategies ship server-side; known values are enumerated as members. */
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
union AgentOptimizationStrategy {
  string,

  @doc("Genetic Evolutionary Prompt Architecture — reflective mutation with Pareto-optimal candidate selection.")
  gepa: "gepa",
}

// ---------------------------------------------------------------------------
// Dataset input — discriminated union (inline items or registered reference)
// ---------------------------------------------------------------------------

/** Discriminator values for the dataset input union. */
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
union AgentOptimizationDatasetInputType {
  string,

  @doc("Inline dataset — items are provided directly in the request body.")
  inline: "inline",

  @doc("Reference to a registered Foundry dataset by name and version.")
  reference: "reference",
}

/** Base discriminated model for dataset input. Either inline items or a registered reference. */
@discriminator("type")
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model AgentOptimizationDatasetInput {
  @doc("Dataset input type discriminator.")
  type: AgentOptimizationDatasetInputType;
}

/** Inline dataset — items supplied directly in the request body. */
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model AgentOptimizationInlineDatasetInput
  extends AgentOptimizationDatasetInput {
  @doc("Dataset input type discriminator.")
  type: AgentOptimizationDatasetInputType.inline;

  @doc("Dataset items.")
  items: AgentOptimizationDatasetItem[];
}

/** Reference to a registered Foundry dataset. */
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model AgentOptimizationReferenceDatasetInput
  extends AgentOptimizationDatasetInput {
  @doc("Dataset input type discriminator.")
  type: AgentOptimizationDatasetInputType.reference;

  @doc("Registered dataset name.")
  name: string;

  @doc("Dataset version. If not specified, the latest version is used.")
  version?: string;
}

/** A single item in an inline dataset. */
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model AgentOptimizationDatasetItem {
  @doc("The user query / prompt.")
  query?: string;

  @doc("Expected ground truth answer.")
  ground_truth?: string;

  @doc("Desired number of conversation turns for simulation mode (1-20).")
  @minValue(1)
  @maxValue(20)
  desired_num_turns?: int32;

  @doc("Per-item evaluation criteria.")
  criteria?: AgentOptimizationDatasetCriterion[];
}

/** Evaluation criterion: a name + instruction pair used for per-item scoring. */
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model AgentOptimizationDatasetCriterion {
  @doc("Criterion name.")
  name: string;

  @doc("Criterion instruction / description.")
  instruction: string;
}

// ---------------------------------------------------------------------------
// Evaluator reference
// ---------------------------------------------------------------------------

/** Reference to a named evaluator, optionally pinned to a version. */
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model AgentOptimizationEvaluatorRef {
  @doc("Evaluator name.")
  name: string;

  @doc("Evaluator version. If not specified, the latest version is used.")
  version?: string;

  @doc("Optional parameters passed to the evaluator at initialization. Shape is evaluator-specific.")
  initialization_parameters?: Record<unknown>;
}

// ---------------------------------------------------------------------------
// Input models
// ---------------------------------------------------------------------------

@doc("Identifies the registered Foundry agent to optimize. Baseline configuration is resolved automatically, or overridden with skills, tools, or system prompt specified in options.optimization_config.")
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model OptimizedAgentIdentifier {
  @doc("Registered Foundry agent name (required).")
  agent_name: string;

  @doc("Pinned agent version. Defaults to latest if omitted.")
  agent_version?: string;
}

@doc("Structured baseline configuration for the agent being optimized.")
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model AgentOptimizationConfig {
  @doc("System prompt / instructions.")
  system_prompt?: string;

  @doc("Model deployment name.")
  `model`?: string;

  @doc("Agent skills.")
  skills?: Record<unknown>[];

  @doc("Agent tools.")
  tools?: Record<unknown>[];
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Tuning knobs for an optimization job.")
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model AgentOptimizationOptions {
  @doc("Maximum number of improved (non-baseline) candidates to generate. The baseline evaluation is run in addition to these. Must be >= 1. Default: 2.")
  @minValue(1)
  @maxValue(20)
  max_candidates?: int32 = 2;

  @doc("Model deployment used for evaluation. Defaults to server config (typically 'gpt-4o').")
  eval_model?: string;

  @doc("Model deployment for optimization reasoning (must be gpt-5 family). Falls back to the default eval model when not set.")
  optimization_model?: string;

  @doc("Evaluation granularity. Null/omitted means per-item single-turn. Set to 'conversation' for per-conversation multi-turn simulation scoring.")
  evaluation_level?: EvaluationLevel;

  @doc("Maximum number of consecutive reflective minibatch rejections before stopping early. A 'stall' occurs when the optimizer proposes a change, evaluates it on a small subset, and the score does not improve. The counter resets when a minibatch passes and its full-validation score beats the current best. Default: 5.")
  @minValue(1)
  @maxValue(50)
  max_stalls?: int32 = 5;

  @doc("Number of items sampled per reflective minibatch. Default: 3.")
  @minValue(1)
  @maxValue(100)
  reflection_minibatch_size?: int32 = 3;

  @doc("Maximum number of concurrent agent runs during evaluation. Range 1-10 (server caps to match the eval service's concurrency limit). Default: 1 (sequential).")
  @minValue(1)
  @maxValue(10)
  max_concurrent_agent_runs?: int32 = 1;

  @doc("Which agent attributes to optimize. Omit or leave empty to auto-select based on baseline configuration.")
  target_attributes?: TargetAttribute[];

  @doc("Candidate model deployment names to evaluate. Used only when target_attributes contains 'model'. Ignored otherwise.")
  model_search_space?: string[];

  @doc("Optimization strategy identifier.")
  strategy?: AgentOptimizationStrategy = AgentOptimizationStrategy.gepa;

  @doc("Structured baseline configuration for the agent being optimized. When omitted, the server resolves baseline from the agent identifier.")
  optimization_config?: AgentOptimizationConfig;
}

@doc("Caller-supplied inputs for an optimization job.")
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model AgentOptimizationJobInputs {
  @doc("The agent (and pinned version) being optimized.")
  agent: OptimizedAgentIdentifier;

  @doc("Training dataset — either inline items or a reference to a registered dataset. Required.")
  train_dataset: AgentOptimizationDatasetInput;

  @doc("Optional held-out validation dataset for measuring generalization of the final candidate.")
  validation_dataset?: AgentOptimizationDatasetInput;

  @doc("Job-level evaluators referenced by name and optional version. Required; at least one must be provided.")
  @minItems(1)
  evaluators: AgentOptimizationEvaluatorRef[];

  @doc("Tuning knobs.")
  options?: AgentOptimizationOptions;
}

// ---------------------------------------------------------------------------
// Estimate models
// ---------------------------------------------------------------------------

@doc("Options for :estimate. Extends AgentOptimizationOptions with estimate-only fields.")
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model AgentOptimizationEstimateOptions {
  ...AgentOptimizationOptions;

  @doc("Validation dataset size hint. Used to project call counts when validation_dataset is a registered reference (row count is unknown at estimate time). If not provided, server infers from an inline validation_dataset when present.")
  @minValue(1)
  validation_dataset_row_count?: int32;
}

@doc("Inputs for :estimate. Same shape as AgentOptimizationJobInputs but the options field is AgentOptimizationEstimateOptions.")
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model AgentOptimizationEstimateJobInputs {
  @doc("The agent (and pinned version) being optimized.")
  agent: OptimizedAgentIdentifier;

  @doc("Training dataset.")
  train_dataset: AgentOptimizationDatasetInput;

  @doc("Optional held-out validation dataset.")
  validation_dataset?: AgentOptimizationDatasetInput;

  @doc("Evaluators.")
  @minItems(1)
  evaluators: AgentOptimizationEvaluatorRef[];

  @doc("Estimate-specific tuning knobs.")
  options?: AgentOptimizationEstimateOptions;
}

@doc("A low/typical/ceiling range for an estimated quantity.")
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model AgentOptimizationEstimateBand {
  @doc("Lower bound.")
  low: float64;

  @doc("Central estimate.")
  typical: float64;

  @doc("Upper bound.")
  ceiling: float64;
}

@doc("Estimated cost breakdown. Present only when at least one contributing model has pricing data available.")
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model AgentOptimizationEstimateDollars {
  @doc("Whether the dollar figures are modeled (projected from call counts + per-model prices) vs. measured. Currently always true; may become false when measured billing data is available. Do not branch exhaustively on this value.")
  modeled: boolean;

  @doc("ISO 4217 currency code (e.g., 'USD'). Read as data — do not assume USD; the price source stamps the currency and this may change without a contract change.")
  currency: string;

  @doc("Total dollar estimate across all priced layers. Null when no layer could be priced.")
  total?: AgentOptimizationEstimateBand;

  @doc("Per-layer dollar bands keyed by layer name (e.g. 'agent', 'judge', 'reflection'). Only priced layers are present.")
  per_layer?: Record<AgentOptimizationEstimateBand>;

  @doc("Cost layers excluded from total because no pricing data was available for their model.")
  unpriced_layers?: string[];
}

@doc("Response body for :estimate.")
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model AgentOptimizationEstimateResponse {
  @doc("Validation-set size (in rows) the estimate was computed against. This is the server-resolved input used by the estimator; useful for clients that did not supply or know the row count when validation_dataset was passed as a registered reference.")
  dataset_rows: int32;

  @doc("Exact per-layer model call bands, keyed by layer name (e.g. 'agent', 'judge', 'reflection'). Only layers that will run are present.")
  call_counts?: Record<AgentOptimizationEstimateBand>;

  @doc("Modeled dollar estimate. Present only when pricing data is available for at least one contributing model.")
  dollars?: AgentOptimizationEstimateDollars;

  @doc("The pricing snapshot date used for cost estimation.")
  prices_as_of?: plainDate;
}

// ---------------------------------------------------------------------------
// Progress / result models
// ---------------------------------------------------------------------------

@doc("Metadata for the candidate currently under evaluation. Present only during in_progress with progressive-update visibility.")
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model AgentOptimizationInProgressCandidateInfo {
  @doc("Timestamp when the current candidate began evaluation, represented in Unix time.")
  created_at?: FoundryTimestamp;

  @doc("Whether the candidate configuration has been fully generated (vs. still being reflected on).")
  candidate_generated: boolean;
}

@doc("In-flight progress. Preserved on terminal states (with in_progress_candidate omitted).")
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model AgentOptimizationJobProgress {
  @doc("Number of candidates whose evaluation has completed so far.")
  candidates_completed: int32;

  @doc("Score of the baseline (un-optimized) evaluation. Null until the baseline eval completes.")
  baseline_score?: float64;

  @doc("Best score observed so far across all candidates.")
  best_score?: float64;

  @doc("Wall-clock time elapsed in seconds since the job began executing.")
  elapsed_seconds: float64;

  @doc("Metadata for the candidate currently under evaluation. Dropped on terminal states.")
  in_progress_candidate?: AgentOptimizationInProgressCandidateInfo;

  @doc("Populated once any candidate from this job has been promoted to an agent version.")
  promotion?: PromotionInfo;
}

@doc("A single candidate produced by an optimization job. Represents both LIST and detail views: the LIST context populates aggregate scoring fields and the mutation keys (with values null), and a client can request the full mutation payload via the `expand=mutations` query parameter or a `GET /candidates/{id}` call.")
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model AgentOptimizationCandidate {
  @doc("Server-assigned candidate identifier. Use with GET /candidates/{id} sub-endpoints.")
  candidate_id: string;

  @doc("Identifier of the parent optimization job.")
  job_id: string;

  @doc("Display name of the candidate (e.g., 'baseline', 'instruction-v2').")
  name: string;

  @doc("The mutation payload applied to the baseline to produce this candidate. The dictionary keys identify which agent attributes were mutated (for example `system_prompt`, `model`) and serve as the source of truth for which target attributes changed — no separate `optimizations` field is emitted. On LIST (and any GET without `expand=mutations`), keys are populated and values are `null`; the customer-supplied mutation values are only returned when the caller passes `expand=mutations` or on GET candidate detail. Omitted entirely for the baseline candidate, which has no mutations to describe.")
  mutations?: Record<unknown | null>;

  @doc("Foundry agent version evaluated for this candidate. This is the draft version created during the optimization run and scored by the evaluator, before any promotion.")
  agent_version?: string;

  @doc("Timestamp when the candidate was created, represented in Unix time.")
  created_at?: FoundryTimestamp;

  @doc("Average composite score across all evaluated tasks.")
  avg_score?: float64;

  @doc("Average total tokens consumed per task.")
  avg_tokens?: float64;

  @doc("Average end-to-end latency per task in milliseconds.")
  avg_latency_ms?: float64;

  @doc("Foundry evaluation identifier used to score this candidate.")
  eval_id?: string;

  @doc("Foundry evaluation run identifier for this candidate's scoring run.")
  eval_run_id?: string;

  @doc("Promotion metadata. Null if this candidate has not been promoted.")
  promotion?: PromotionInfo;

  @doc("Manifest of artifact files stored for this candidate (config, results, diagnostics).")
  files?: AgentOptimizationCandidateFileInfo[];
}

@doc("A single candidate file artifact stored in the job's output blob.")
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model AgentOptimizationCandidateFileInfo {
  @doc("Relative path of the file within the candidate's output folder.")
  path: string;

  @doc("File type / role (e.g., 'config', 'results', 'diagnostics').")
  type: string;

  @doc("File size in bytes.")
  size_in_bytes: int64;
}

/** Vocabulary for the `expand` query parameter on candidate LIST/GET endpoints. Open string so the SDK stays usable when new expand keys ship server-side; known values are enumerated as members. Multiple expand keys may be combined in a comma-separated string. */
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
union AgentOptimizationCandidateExpand {
  string,

  @doc("Include the customer-supplied mutation payload values (the values on `AgentOptimizationCandidate.mutations`). Without this key the mutation keys are populated but the values are null.")
  mutations: "mutations",
}

@doc("Aggregated token usage attributable to a single layer of the optimization loop.")
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model AgentOptimizationTokenUsageEntry {
  @doc("Which layer of the optimization loop generated these calls.")
  layer: AgentOptimizationLayer;

  @doc("Model deployment name that served the calls. Null when unattributed.")
  `model`?: string;

  @doc("Total input tokens. Null when unmeasured.")
  input_tokens?: int64;

  @doc("Total output tokens. Null when unmeasured.")
  output_tokens?: int64;

  @doc("Sum of input_tokens + output_tokens. Null when unmeasured.")
  total_tokens?: int64;

  @doc("Input tokens served from the model's cache. Included in input_tokens (not additive). Null when the model did not report this metric.")
  cached_tokens?: int64;

  @doc("Reasoning tokens counted separately by reasoning models. Included in output_tokens (not additive). Null when the model did not report this metric.")
  reasoning_tokens?: int64;
}

@doc("Aggregated wall-clock latency attributable to a single layer of the optimization loop. Sourced from server-measured signals (Foundry's `sample.latency_ms` on the target rollout and evaluator responses). Layers without a server-measured source are omitted from the array rather than populated with client-observed timings that would conflate real model latency with local retry/network overhead.")
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model AgentOptimizationLatencyUsageEntry {
  @doc("Which layer of the optimization loop generated these calls. See `AgentOptimizationLayer` for per-layer population status.")
  layer: AgentOptimizationLayer;

  @doc("Model deployment name that served the calls.")
  `model`: string;

  @doc("Average per-call latency in milliseconds.")
  avg_latency_ms: float64;

  @doc("p50 (median) per-call latency in milliseconds. Omitted when the sample was too small to compute.")
  p50_latency_ms?: float64;

  @doc("p95 per-call latency in milliseconds. Omitted when the sample was too small to compute.")
  p95_latency_ms?: float64;

  @doc("Total number of calls contributing to this entry.")
  call_count: int64;
}

@doc("Terminal-state or partial in-flight result body. On success/failure it holds the final scored candidate set; while in_progress it may hold a partial snapshot (baseline + any candidates whose evaluation has completed).")
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model AgentOptimizationJobResult {
  @doc("Candidate ID of the original (un-optimized) baseline evaluation.")
  baseline?: string;

  @doc("Candidate ID of the highest-scoring candidate found during optimization.")
  best?: string;

  @doc("All candidate IDs produced by this job, in evaluation order. Use GET /candidates/{id} for the mutation payload and file manifest, or GET /candidates for a paginated summary listing.")
  candidate_ids?: string[];

  @doc("Aggregate token usage per layer × model. Always present; empty array when no calls were measured.")
  token_usage: AgentOptimizationTokenUsageEntry[];

  @doc("Aggregate latency per layer × model, from server-measured sources only. Always present; empty array when no server-measured latency signals were surfaced (e.g. an early-failure run or an all-hosted judge run whose evaluators do not report latency_ms).")
  latency_usage: AgentOptimizationLatencyUsageEntry[];
}

// ---------------------------------------------------------------------------
// Job resource — extends JobLike per Foundry job guidelines
// ---------------------------------------------------------------------------

@doc("Agent optimization job resource — a long-running job that optimizes an agent's configuration (instructions, model, skills, tools) to maximize evaluation scores. On success, the result contains scored candidates.")
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
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

  @doc("Progress snapshot. Preserved on terminal states (with in_progress_candidate omitted).")
  @visibility(Lifecycle.Read)
  progress?: AgentOptimizationJobProgress;

  @doc("Terminal completion classification. Present only on succeeded.")
  @visibility(Lifecycle.Read)
  completion_status?: AgentOptimizationCompletionStatus;

  @doc("Non-fatal warnings emitted at any point during optimization.")
  @visibility(Lifecycle.Read)
  warnings?: string[];
}

// ---------------------------------------------------------------------------
// Promotion models
// ---------------------------------------------------------------------------

@doc("Promotion metadata recorded when a candidate is deployed to a Foundry agent version.")
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model PromotionInfo {
  @doc("Server-assigned candidate identifier that was promoted.")
  candidate_id: string;

  @doc("Timestamp when promotion occurred, represented in Unix time.")
  promoted_at: FoundryTimestamp;

  @doc("Name of the Foundry agent this candidate was promoted to.")
  agent_name: string;

  @doc("Version of the Foundry agent this candidate was promoted to.")
  agent_version: string;
}

@doc("Request body for POST /candidates/{id}:promote. For prompt agents these fields are ignored; the target agent is resolved from the job's stored baseline configuration.")
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model PromoteAgentOptimizationCandidateRequest {
  @doc("Target Foundry agent name to promote onto. For prompt agents this is ignored.")
  agent_name?: string;

  @doc("Target agent version. When omitted, a new version is created.")
  agent_version?: string;
}

@doc("Response body for POST /candidates/{id}:promote.")
@extension("x-ms-foundry-meta", AgentOptimizationRequiredPreviews)
model PromoteAgentOptimizationCandidateResponse {
  @doc("Server-assigned candidate identifier that was promoted.")
  candidate_id: string;

  @doc("Timestamp when promotion occurred, represented in Unix time.")
  promoted_at: FoundryTimestamp;

  @doc("Name of the Foundry agent this candidate was promoted to.")
  agent_name: string;

  @doc("Version of the Foundry agent this candidate was promoted to. May be null when a caller omitted a target version and no server default resolved.")
  agent_version?: string;

  @doc("Whether a new agent version was created during promotion.")
  created_new_version: boolean;
}
