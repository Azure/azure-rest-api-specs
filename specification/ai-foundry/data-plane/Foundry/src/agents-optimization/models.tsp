// Models for the AgentsOptimization data-plane surface (v1 GA).
//
// Uses shared Foundry job infrastructure from servicepatterns.tsp:
//   JobLike<TResult, TInputs> — base job shape (id, status, inputs, result, error)
//   JobStatus — shared lifecycle union (queued/in_progress/succeeded/failed/cancelled)
//   FoundryTimestamp — Unix epoch int32
//   ApiError — standard error shape

import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "../openai/evaluations/models.tsp";
import "@azure-tools/openai-typespec/models/chat";

using TypeSpec.Rest;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Enums / unions
// ---------------------------------------------------------------------------

/** Agent attribute that can be optimized. */
union TargetAttribute {
  string,

  @doc("Instruction-tuning — rewrites agent system prompts.")
  instruction: "instruction",

  @doc("Model-selection — evaluates deployments from optimization_configuration.agent_optimization_space.model_search_space.")
  `model`: "model",

  @doc("Skill-tuning — generates or modifies agent skill descriptions.")
  skill: "skill",

  @doc("Tool-tuning — optimizes function tool descriptions and parameter descriptions.")
  tool: "tool",
}

/** Outcome of an optimization job that evaluated candidates against a baseline. */
union AgentOptimizationEvaluationOutcome {
  string,

  @doc("Best candidate exceeded the baseline score.")
  improved: "improved",

  @doc("Optimization completed but no candidate outperformed the baseline.")
  no_improvement: "no_improvement",

  @doc("Optimization halted early because the maximum consecutive failed candidate screens was reached.")
  stopped_early: "stopped_early",
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

/** Evaluation mode for an optimization job. */
union AgentOptimizationEvaluationMode {
  string,

  @doc("Evaluate each dataset item as a single-turn interaction.")
  single_turn: "single_turn",

  @doc("Evaluate each dataset item as a multi-turn simulated conversation.")
  conversation: "conversation",
}

// ---------------------------------------------------------------------------
// Dataset input — discriminated union (inline items or registered reference)
// ---------------------------------------------------------------------------

/** Discriminator values for the dataset input union. */
union AgentOptimizationDatasetInputType {
  string,

  @doc("Inline dataset — items are provided directly in the request body.")
  inline: "inline",

  @doc("Reference to a registered Foundry dataset by name and version.")
  reference: "reference",

  @doc("Reference to a data-generation job whose output becomes the training dataset.")
  generation_job_reference: "generation_job_reference",
}

/** Base discriminated model for dataset input. Either inline items or a registered reference. */
@discriminator("type")
model AgentOptimizationDatasetInput {
  @doc("Dataset input type discriminator.")
  type: AgentOptimizationDatasetInputType;
}

/** Inline dataset — items supplied directly in the request body. */
model AgentOptimizationInlineDatasetInput
  extends AgentOptimizationDatasetInput {
  @doc("Dataset input type discriminator.")
  type: AgentOptimizationDatasetInputType.inline;

  @doc("Dataset items.")
  items: AgentOptimizationDatasetItem[];
}

/** Reference to a registered Foundry dataset. */
model AgentOptimizationReferenceDatasetInput
  extends AgentOptimizationDatasetInput {
  @doc("Dataset input type discriminator.")
  type: AgentOptimizationDatasetInputType.reference;

  @doc("Registered dataset name.")
  name: string;

  @doc("Dataset version. Omitted to use the latest version.")
  version?: string;

  @doc("Originating data-generation job identifier. Omitted when the dataset was not resolved from a generation job.")
  @visibility(Lifecycle.Read)
  data_generation_job_id?: string;

  @doc("Current status of the originating data-generation job. Omitted when the dataset was not resolved from a generation job.")
  @visibility(Lifecycle.Read)
  data_generation_job_status?: string;

  @doc("Failure from the originating data-generation job. Omitted unless generation failed.")
  @visibility(Lifecycle.Read)
  error?: ApiError;
}

/** Reference to a data-generation job whose output is used as the training dataset. */
model AgentOptimizationGenerationJobReferenceDatasetInput
  extends AgentOptimizationDatasetInput {
  @doc("Dataset input type discriminator.")
  type: AgentOptimizationDatasetInputType.generation_job_reference;

  @doc("Identifier of the data-generation job to await and resolve.")
  data_generation_job_id: string;

  @doc("Current status of the referenced data-generation job. Omitted before status is available.")
  @visibility(Lifecycle.Read)
  data_generation_job_status?: string;

  @doc("Failure from the referenced data-generation job. Omitted unless generation failed.")
  @visibility(Lifecycle.Read)
  error?: ApiError;
}

/** Supported dataset inputs for evaluation. */
union AgentOptimizationDataset {
  AgentOptimizationInlineDatasetInput,
  AgentOptimizationReferenceDatasetInput,
  AgentOptimizationGenerationJobReferenceDatasetInput,
}

/** Dataset inputs supported for held-out validation. */
union AgentOptimizationValidationDataset {
  AgentOptimizationInlineDatasetInput,
  AgentOptimizationReferenceDatasetInput,
}

/** A single item in an inline dataset. */
model AgentOptimizationDatasetItem {
  @doc("The user query / prompt.")
  query: string;

  @doc("Expected ground truth answer. Omitted when no ground truth is supplied.")
  ground_truth?: string;

  @doc("Desired number of conversation turns for conversation evaluation. Defaults to 10 when omitted and is ignored for single-turn evaluation.")
  @minValue(1)
  @maxValue(20)
  desired_num_turns?: int32 = 10;

  @doc("Per-item evaluation criteria. Omitted when the item has no custom criteria.")
  criteria?: AgentOptimizationDatasetCriterion[];
}

/** Evaluation criterion: a name + instruction pair used for per-item scoring. */
model AgentOptimizationDatasetCriterion {
  @doc("Criterion name.")
  name: string;

  @doc("Criterion instruction / description.")
  instruction: string;
}

// ---------------------------------------------------------------------------
// Evaluator reference
// ---------------------------------------------------------------------------

/** Base model for evaluator inputs. */
@discriminator("type")
model AgentOptimizationEvaluatorInputBase {
  @doc("Evaluator input type discriminator.")
  type: string;
}

/** Reference to a named evaluator, optionally pinned to a version. */
model AgentOptimizationNamedEvaluatorInput extends AgentOptimizationEvaluatorInputBase {
  @doc("Evaluator input type discriminator.")
  type: "named";

  @doc("Evaluator name.")
  name: string;

  @doc("Evaluator version. Omitted to use the latest version.")
  version?: string;

  @doc("Parameters passed to the evaluator at initialization. Omitted when the evaluator requires no initialization parameters.")
  initialization_parameters?: Record<unknown>;
}

/** Reference to an evaluator-generation job whose output is added to the evaluator set. */
model AgentOptimizationGenerationJobReferenceEvaluatorInput
  extends AgentOptimizationEvaluatorInputBase {
  @doc("Evaluator input type discriminator.")
  type: "generation_job_reference";

  @doc("Identifier of the evaluator-generation job to await and resolve.")
  evaluator_generation_job_id: string;
}

/** Supported evaluator inputs. */
union AgentOptimizationEvaluator {
  AgentOptimizationNamedEvaluatorInput,
  AgentOptimizationGenerationJobReferenceEvaluatorInput,
}

// ---------------------------------------------------------------------------
// Input models
// ---------------------------------------------------------------------------

@doc("Identifies the Foundry agent that owns the configuration being optimized.")
model AgentOptimizationTargetConfiguration {
  @doc("Target type discriminator.")
  type: "foundry_agent";

  @doc("Registered Foundry agent name.")
  name: string;

  @doc("Pinned agent version. The latest version is resolved and pinned when omitted.")
  version?: string;
}

@doc("Identifies a model deployment used by an optimization or evaluation step.")
model AgentOptimizationModelConfiguration {
  @doc("Model deployment name in the Foundry project.")
  deployment_name: string;

  // Review consideration: sampling_parameters may belong here once the service
  // supports caller-controlled inference settings. It is intentionally not a wire
  // property in this contract.
}

@doc("A skill in the manually supplied agent optimization surface.")
model AgentOptimizationSkill {
  @doc("Stable skill name.")
  name: string;

  @doc("Short description used for skill discovery and progressive disclosure.")
  @minLength(1)
  description: string;

  @doc("Skill instructions or content that may be optimized. Omitted when the skill has no body.")
  body?: string;
}

@doc("Fields shared by quality and cost agent optimization spaces.")
model AgentOptimizationSpaceBase {
  @doc("Agent attributes the optimizer may change. When omitted, the service infers supported attributes from the baseline.")
  target_attributes?: TargetAttribute[];

  @doc("Caller-supplied baseline system prompt. Omitted to resolve the baseline from the target; a prompt agent's stored definition is authoritative.")
  system_prompt?: string;

  @doc("Caller-supplied baseline model deployment. Omitted to resolve the baseline from the target; a prompt agent's stored definition is authoritative.")
  current_model_deployment_name?: string;

  @doc("Skills available for optimization. Omitted when no manual skill surface is supplied.")
  skills?: AgentOptimizationSkill[];

  @doc("Function tools available for optimization. Omitted when no manual tool surface is supplied. The optimizer may change function and argument descriptions while preserving names and parameter JSON Schema.")
  tools?: OpenAI.ChatCompletionTool[];
}

@doc("The agent attributes and alternative values available to a quality-optimization search.")
model AgentOptimizationSpace {
  ...AgentOptimizationSpaceBase;

  @doc("Alternative model deployments available when model is an optimization target. Omitted when model is not an optimization target.")
  model_search_space?: string[];
}

@doc("Agent optimization space for cost optimization. Model selection is always enabled and requires at least one alternative deployment.")
model CostAgentOptimizationSpace {
  ...AgentOptimizationSpaceBase;

  @doc("Alternative model deployments evaluated for lower serving cost. Model is an implicit optimization target for every cost-optimization job.")
  @minItems(1)
  model_search_space: string[];
}

/**
 * GEPA search settings.
 *
 * Review consideration: if search later gains multiple wall-clock, token, cost, or
 * evaluation-call budgets, or multiple stopping rules, split those concerns into
 * dedicated budget and stopping objects. The current flat shape avoids empty nesting.
 */
@discriminator("type")
model AgentOptimizationSearchConfigurationBase {
  @doc("Search strategy discriminator.")
  type: string;
}

@doc("Genetic Evolutionary Prompt Architecture search configuration.")
model GepaSearchConfiguration extends AgentOptimizationSearchConfigurationBase {
  @doc("Search strategy discriminator.")
  type: "gepa";

  @doc("Maximum number of non-baseline candidates to fully evaluate. Defaults to 2 when omitted.")
  @minValue(1)
  @maxValue(20)
  max_candidates?: int32 = 2;

  @doc("Number of training rows used to screen each proposed candidate before full validation. Defaults to 3 when omitted.")
  @minValue(1)
  @maxValue(100)
  candidate_screening_size?: int32 = 3;

  @doc("Maximum number of consecutive proposed candidates that may fail screening before the search stops early. Defaults to 5 when omitted.")
  @minValue(1)
  @maxValue(50)
  max_consecutive_failed_candidate_screens?: int32 = 5;
}

/** Supported search configurations. Additional strategies can define independent settings. */
union AgentOptimizationSearchConfiguration {
  GepaSearchConfiguration,
}

/**
 * Reusable quality-measurement configuration.
 *
 * Review consideration: if evaluation gains more execution controls, move
 * max_concurrency into a dedicated execution configuration. It remains flat while
 * concurrency is the only execution setting.
 */
model AgentOptimizationEvaluationConfiguration {
  @doc("Dataset used to guide the optimization search.")
  training_dataset: AgentOptimizationDataset;

  @doc("Held-out dataset used for full candidate evaluation. The training dataset is reused when omitted.")
  validation_dataset?: AgentOptimizationValidationDataset;

  @doc("Evaluators used to score candidate quality. Named and generated evaluators may be combined.")
  @minItems(1)
  evaluators: AgentOptimizationEvaluator[];

  @doc("Model deployment used by model-based evaluators.")
  evaluation_model: AgentOptimizationModelConfiguration;

  @doc("Whether each dataset row is evaluated as a single turn or a simulated conversation. Defaults to single_turn when omitted.")
  evaluation_mode?: AgentOptimizationEvaluationMode = AgentOptimizationEvaluationMode.single_turn;

  @doc("Maximum number of target-agent runs executed concurrently during evaluation. Defaults to 1 when omitted.")
  @minValue(1)
  @maxValue(10)
  max_concurrency?: int32 = 1;
}

@doc("Evaluation configuration accepted by the estimate operation.")
model AgentOptimizationEstimateEvaluationConfiguration {
  ...AgentOptimizationEvaluationConfiguration;

  @doc("Validation dataset row-count hint used when a referenced dataset cannot be sized without a service lookup. Omitted to let the service resolve the row count.")
  @minValue(1)
  validation_dataset_row_count?: int32;
}

/** Base model for type-specific optimization configuration. */
@discriminator("type")
model AgentOptimizationConfigurationBase {
  @doc("Optimization type discriminator.")
  type: string;
}

@doc("Configuration for improving measured agent quality.")
model QualityOptimizationConfiguration extends AgentOptimizationConfigurationBase {
  @doc("Optimization type discriminator.")
  type: "quality_optimization";

  @doc("Quality measurement configuration.")
  evaluation_configuration: AgentOptimizationEvaluationConfiguration;

  @doc("Candidate search configuration.")
  search_configuration: AgentOptimizationSearchConfiguration;

  @doc("Agent attributes and alternatives available to the search. Omitted to derive the optimization surface from the target agent.")
  agent_optimization_space?: AgentOptimizationSpace;
}

@doc("Configuration for reducing agent serving cost while preserving acceptable quality.")
model CostOptimizationConfiguration extends AgentOptimizationConfigurationBase {
  @doc("Optimization type discriminator.")
  type: "cost_optimization";

  @doc("Quality measurement configuration used to compare model and configuration alternatives.")
  evaluation_configuration: AgentOptimizationEvaluationConfiguration;

  @doc("Candidate search configuration.")
  search_configuration: AgentOptimizationSearchConfiguration;

  @doc("Agent attributes and alternatives available to the search. Model selection is always enabled for cost optimization.")
  agent_optimization_space: CostAgentOptimizationSpace;
}

@doc("Configuration for a one-shot prompt transformation without comparative evaluation.")
model PromptOptimizationConfiguration extends AgentOptimizationConfigurationBase {
  @doc("Optimization type discriminator.")
  type: "prompt_optimization";

  @doc("Developer guidance describing the desired prompt changes. Omitted when no additional steering is needed.")
  steering_prompt?: string;
}

/**
 * Supported optimization types. New workflows should add independent variants
 * rather than adding nullable fields to existing variants.
 */
union AgentOptimizationConfiguration {
  QualityOptimizationConfiguration,
  CostOptimizationConfiguration,
  PromptOptimizationConfiguration,
}

@doc("Caller-supplied inputs for an optimization job.")
model AgentOptimizationJobInputs {
  @doc("Human-readable label. Omitted when no label is needed; it has no uniqueness, routing, or idempotency semantics.")
  display_name?: string;

  @doc("Foundry agent whose configuration is optimized.")
  target_configuration: AgentOptimizationTargetConfiguration;

  @doc("Model deployment used to generate candidate changes.")
  optimization_model_configuration: AgentOptimizationModelConfiguration;

  @doc("Type-specific optimization configuration.")
  optimization_configuration: AgentOptimizationConfiguration;
}

@doc("Request body for creating an agent optimization job.")
model CreateAgentOptimizationJobRequest {
  @doc("Caller-supplied optimization inputs.")
  inputs: AgentOptimizationJobInputs;
}

/** Base model for type-specific estimate configuration. */
@discriminator("type")
model AgentOptimizationEstimateConfigurationBase {
  @doc("Optimization type discriminator.")
  type: string;
}

@doc("Estimate configuration for a quality-optimization job.")
model QualityOptimizationEstimateConfiguration
  extends AgentOptimizationEstimateConfigurationBase {
  @doc("Optimization type discriminator.")
  type: "quality_optimization";

  @doc("Quality measurement configuration, including the optional estimate-only row-count hint.")
  evaluation_configuration: AgentOptimizationEstimateEvaluationConfiguration;

  @doc("Candidate search configuration.")
  search_configuration: AgentOptimizationSearchConfiguration;

  @doc("Agent attributes and alternatives available to the search. Omitted to derive the optimization surface from the target agent.")
  agent_optimization_space?: AgentOptimizationSpace;
}

@doc("Estimate configuration for a cost-optimization job.")
model CostOptimizationEstimateConfiguration
  extends AgentOptimizationEstimateConfigurationBase {
  @doc("Optimization type discriminator.")
  type: "cost_optimization";

  @doc("Quality measurement configuration, including the optional estimate-only row-count hint.")
  evaluation_configuration: AgentOptimizationEstimateEvaluationConfiguration;

  @doc("Candidate search configuration.")
  search_configuration: AgentOptimizationSearchConfiguration;

  @doc("Agent attributes and alternatives available to the search. Model selection is always enabled for cost optimization.")
  agent_optimization_space: CostAgentOptimizationSpace;
}

/** Optimization types supported by the estimate operation. */
union AgentOptimizationEstimateConfiguration {
  QualityOptimizationEstimateConfiguration,
  CostOptimizationEstimateConfiguration,
}

@doc("Inputs for estimating a quality- or cost-optimization job.")
model AgentOptimizationEstimateInputs {
  @doc("Foundry agent whose configuration would be optimized.")
  target_configuration: AgentOptimizationTargetConfiguration;

  @doc("Model deployment that would generate candidate changes.")
  optimization_model_configuration: AgentOptimizationModelConfiguration;

  @doc("Type-specific estimate configuration.")
  optimization_configuration: AgentOptimizationEstimateConfiguration;
}

@doc("A low/typical/ceiling range for an estimated quantity.")
model AgentOptimizationEstimateBand {
  @doc("Lower bound.")
  low: float64;

  @doc("Central estimate.")
  typical: float64;

  @doc("Upper bound.")
  ceiling: float64;
}

@doc("Estimated cost breakdown. Present only when at least one contributing model has pricing data available.")
model AgentOptimizationEstimateDollars {
  @doc("Whether the dollar figures are modeled rather than measured. Defaults to true; clients should read this value rather than assume it remains true.")
  modeled: boolean = true;

  @doc("ISO 4217 currency code. Defaults to USD when the pricing source provides no currency; an emitted source currency overrides this fallback.")
  currency: string = "USD";

  @doc("Total dollar estimate across all priced layers. Omitted when no layer could be priced.")
  total?: AgentOptimizationEstimateBand;

  @doc("Per-layer dollar bands keyed by layer name (e.g. 'agent', 'judge', 'reflection'). Omitted when no layer could be priced.")
  per_layer?: Record<AgentOptimizationEstimateBand>;

  @doc("Cost layers excluded from total because no pricing data was available for their model. Omitted when every contributing layer was priced.")
  unpriced_layers?: string[];
}

@doc("Response body for :estimate.")
model AgentOptimizationEstimateResponse {
  @doc("Validation-set size (in rows) the estimate was computed against. This is the server-resolved input used by the estimator; useful for clients that did not supply or know the row count when validation_dataset was passed as a registered reference.")
  dataset_rows: int32;

  @doc("Exact per-layer model call bands, keyed by layer name (e.g. 'agent', 'judge', 'reflection'). Omitted when the selected search strategy cannot produce call-count estimates.")
  call_counts?: Record<AgentOptimizationEstimateBand>;

  @doc("Modeled dollar estimate. Omitted when no contributing model has pricing data.")
  dollars?: AgentOptimizationEstimateDollars;

  @doc("Timestamp of the pricing snapshot used for cost estimation, represented in Unix time. Omitted when no valid pricing snapshot is available.")
  prices_as_of?: FoundryTimestamp;
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

@doc("Fields shared by evaluated and unevaluated optimization candidates.")
@discriminator("evaluation_status")
model AgentOptimizationCandidateBase {
  @doc("Server-assigned candidate identifier. Use with GET /candidates/{id} sub-endpoints.")
  candidate_id: string;

  @doc("Identifier of the parent optimization job.")
  job_id: string;

  @doc("Display name of the candidate (e.g., 'baseline', 'instruction-v2').")
  name: string;

  @doc("Whether this candidate was comparatively evaluated.")
  evaluation_status: AgentOptimizationCandidateEvaluationStatus;

  @doc("The mutation payload applied to the baseline to produce this candidate. The dictionary keys identify which agent attributes were mutated (for example `system_prompt`, `model`) and serve as the source of truth for which target attributes changed — no separate `optimizations` field is emitted. On LIST (and any GET without `expand=mutations`), keys are populated and values are `null`; the customer-supplied mutation values are only returned when the caller passes `expand=mutations` or on GET candidate detail. Omitted entirely for the baseline candidate, which has no mutations to describe.")
  mutations?: Record<unknown | null>;

  @doc("Foundry agent version associated with this candidate. Omitted when no temporary or evaluated agent version was created.")
  agent_version?: string;

  @doc("Timestamp when the candidate was created, represented in Unix time. Omitted when unavailable for legacy candidate records.")
  created_at?: FoundryTimestamp;

  @doc("Promotion metadata. Omitted if this candidate has not been promoted.")
  promotion?: PromotionInfo;

  @doc("Manifest of artifact files stored for this candidate. Omitted when the manifest is not loaded or unavailable.")
  files?: AgentOptimizationCandidateFileInfo[];
}

@doc("A candidate that was comparatively evaluated against the job's evaluation configuration.")
model EvaluatedAgentOptimizationCandidate extends AgentOptimizationCandidateBase {
  @doc("Candidate evaluation status.")
  evaluation_status: "evaluated";

  @doc("Average composite score across all evaluated tasks. Omitted until scoring produces an aggregate score.")
  score?: float64;

  @doc("Average total tokens consumed per task. Omitted when token usage was not measured.")
  avg_tokens?: float64;

  @doc("Average end-to-end latency per task. Omitted when latency was not measured. Wire representation: milliseconds as a float.")
  @encode(DurationKnownEncoding.milliseconds, float64)
  avg_latency_ms?: duration;

  @doc("Foundry evaluation identifier used to score this candidate. Omitted when no evaluation identifier is available.")
  eval_id?: string;

  @doc("Foundry evaluation run identifier for this candidate's scoring run. Omitted when no evaluation run identifier is available.")
  eval_run_id?: string;
}

@doc("A candidate generated without comparative evaluation.")
model UnevaluatedAgentOptimizationCandidate extends AgentOptimizationCandidateBase {
  @doc("Candidate evaluation status.")
  evaluation_status: "not_evaluated";
}

/** Candidates returned by candidate list and detail operations. */
union AgentOptimizationCandidate {
  EvaluatedAgentOptimizationCandidate,
  UnevaluatedAgentOptimizationCandidate,
}

@doc("A single candidate file artifact stored in the job's output blob.")
model AgentOptimizationCandidateFileInfo {
  @doc("Relative path of the file within the candidate's output folder.")
  path: string;

  @doc("File type / role (e.g., 'config', 'results', 'diagnostics').")
  type: string;

  @doc("File size in bytes.")
  size_in_bytes: int64;
}

/** Vocabulary for the `expand` query parameter on candidate LIST/GET endpoints. Open string so the SDK stays usable when new expand keys ship server-side; known values are enumerated as members. Multiple expand keys may be combined in a comma-separated string. */
union AgentOptimizationCandidateExpand {
  string,

  @doc("Include the customer-supplied mutation payload values (the values on `AgentOptimizationCandidate.mutations`). Without this key the mutation keys are populated but the values are null.")
  mutations: "mutations",
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

// ---------------------------------------------------------------------------
// Promotion models
// ---------------------------------------------------------------------------

@doc("Promotion metadata recorded for a candidate. Prompt-agent promotion creates a new version; hosted-agent promotion currently records metadata without deploying a new version.")
model PromotionInfo {
  @doc("Server-assigned candidate identifier that was promoted.")
  candidate_id: string;

  @doc("Timestamp when promotion occurred, represented in Unix time.")
  promoted_at: FoundryTimestamp;

  @doc("Name of the Foundry agent associated with the recorded promotion.")
  agent_name: string;

  @doc("Version of the Foundry agent associated with the recorded promotion.")
  agent_version: string;
}

@doc("Response body for POST /candidates/{id}:promote.")
model PromoteAgentOptimizationCandidateResponse {
  @doc("Server-assigned candidate identifier that was promoted.")
  candidate_id: string;

  @doc("Timestamp when promotion occurred, represented in Unix time.")
  promoted_at: FoundryTimestamp;

  @doc("Name of the Foundry agent associated with the recorded promotion.")
  agent_name: string;

  @doc("Version of the Foundry agent associated with the promotion.")
  agent_version: string;

  @doc("Whether a new agent version was created during promotion.")
  created_new_version: boolean;
}
