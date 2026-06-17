// Models for the AgentsOptimization data-plane surface.
// Aligned with in-tree C# DTOs (Contracts/V2Preview/Models/).
//
// Uses shared Foundry job infrastructure from servicepatterns.tsp:
//   JobLike<TResult, TInputs> — base job shape (id, status, inputs, result, error)
//   JobStatus — shared lifecycle union (queued/in_progress/succeeded/failed/cancelled)
//   FoundryTimestamp — Unix epoch int32
//   ApiError — standard error shape

import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "../openai-evaluations/models.tsp";

using TypeSpec.Rest;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Enums / unions
// ---------------------------------------------------------------------------

/** Agent attribute that can be optimized. */
union TargetAttribute {
  string,

  @doc("Instruction-tuning — rewrites agent system prompts.")
  instruction: "instruction",

  @doc("Model-selection — evaluates alternative LLM deployments.")
  `model`: "model",

  @doc("Skill-tuning — generates or modifies agent skill descriptions.")
  skill: "skill",

  @doc("Tool-tuning — optimizes function tool descriptions and parameter descriptions.")
  tool: "tool",
}

/** Run mode for an optimization job. */
union OptimizationMode {
  string,

  @doc("Full optimization: baseline + mutation target attributes.")
  optimize: "optimize",
}

// ---------------------------------------------------------------------------
// Dataset input — discriminated union (inline items or registered reference)
// ---------------------------------------------------------------------------

/** Discriminator values for the dataset input union. */
union OptimizationDatasetInputType {
  string,

  @doc("Inline dataset — items are provided directly in the request body.")
  inline: "inline",

  @doc("Reference to a registered Foundry dataset by name and version.")
  reference: "reference",
}

/** Base discriminated model for dataset input. Either inline items or a registered reference. */
@discriminator("type")
model OptimizationDatasetInput {
  @doc("Dataset input type discriminator.")
  type: OptimizationDatasetInputType;
}

/** Inline dataset — items supplied directly in the request body. */
model OptimizationInlineDatasetInput extends OptimizationDatasetInput {
  @doc("Dataset input type discriminator.")
  type: OptimizationDatasetInputType.inline;

  @doc("Dataset items.")
  items: OptimizationDatasetItem[];
}

/** Reference to a registered Foundry dataset. */
model OptimizationReferenceDatasetInput extends OptimizationDatasetInput {
  @doc("Dataset input type discriminator.")
  type: OptimizationDatasetInputType.reference;

  @doc("Registered dataset name.")
  name: string;

  @doc("Dataset version. If not specified, the latest version is used.")
  version?: string;
}

/** A single item in an inline dataset. */
model OptimizationDatasetItem {
  @doc("The user query / prompt.")
  query?: string;

  @doc("Expected ground truth answer.")
  ground_truth?: string;

  @doc("Desired number of conversation turns for simulation mode (1-20).")
  @minValue(1)
  @maxValue(20)
  desired_num_turns?: int32;

  @doc("Per-item evaluation criteria.")
  criteria?: OptimizationDatasetCriterion[];
}

/** Evaluation criterion: a name + instruction pair used for per-item scoring. */
model OptimizationDatasetCriterion {
  @doc("Criterion name.")
  name: string;

  @doc("Criterion instruction / description.")
  instruction: string;
}

// ---------------------------------------------------------------------------
// Evaluator reference
// ---------------------------------------------------------------------------

/** Reference to a named evaluator, optionally pinned to a version. */
model OptimizationEvaluatorRef {
  @doc("Evaluator name.")
  name: string;

  @doc("Evaluator version. If not specified, the latest version is used.")
  version?: string;
}

// ---------------------------------------------------------------------------
// Input models
// ---------------------------------------------------------------------------

@doc("Identifies the registered Foundry agent to optimize (request-only). Skills, tools, and system_prompt are specified in options.optimization_config.")
model OptimizationAgentIdentifier {
  @doc("Registered Foundry agent name (required).")
  agent_name: string;

  @doc("Pinned agent version. Defaults to latest if omitted.")
  agent_version?: string;
}

@doc("Agent definition returned in response payloads (includes resolved config).")
model OptimizationAgentDefinition {
  @doc("Agent name.")
  agent_name?: string;

  @doc("Agent version.")
  agent_version?: string;

  @doc("Model deployment name.")
  `model`?: string;

  @doc("System prompt / instructions.")
  system_prompt?: string;

  @doc("Agent skills.")
  skills?: Record<unknown>[];

  @doc("Agent tools.")
  tools?: Record<unknown>[];
}

@doc("Tuning knobs and run-mode for an optimization job.")
model OptimizationOptions {
  @doc("Maximum number of optimization candidates to generate. Must be >= 1. Default: 5.")
  @minValue(1)
  max_candidates?: int32 = 5;

  @doc("Per-target-attribute configuration overrides. Contains skills, tools, system_prompt for the agent, plus model space for model optimization.")
  optimization_config?: Record<unknown>;

  @doc("Model deployment used for evaluation. Defaults to server config (typically 'gpt-4o').")
  eval_model?: string;

  @doc("Model deployment for optimization reasoning (must be gpt-5 family). Falls back to the default eval model when not set.")
  optimization_model?: string;

  @doc("Evaluation granularity. Null/omitted means per-item single-turn. Set to 'conversation' for per-conversation multi-turn simulation scoring.")
  evaluation_level?: EvaluationLevel;
}

@doc("Caller-supplied inputs for an optimization job.")
model OptimizationJobInputs {
  @doc("The agent (and pinned version) being optimized.")
  agent: OptimizationAgentIdentifier;

  @doc("Training dataset — either inline items or a reference to a registered dataset. Required.")
  train_dataset: OptimizationDatasetInput;

  @doc("Optional held-out validation dataset for measuring generalization of the final candidate.")
  validation_dataset?: OptimizationDatasetInput;

  @doc("Job-level evaluators referenced by name and optional version. Required; at least one must be provided.")
  evaluators: OptimizationEvaluatorRef[];

  @doc("Tuning knobs and run-mode.")
  options?: OptimizationOptions;
}

// ---------------------------------------------------------------------------
// Progress / result models
// ---------------------------------------------------------------------------

@doc("In-flight progress; only populated while status is queued or in_progress.")
model OptimizationJobProgress {
  @doc("Number of candidates whose evaluation has completed so far.")
  candidates_completed: int32;

  @doc("Best score observed so far across all candidates.")
  best_score: float64;

  @doc("Wall-clock time elapsed in seconds since the job began executing.")
  elapsed_seconds: float64;
}

@doc("Aggregated evaluation result for a single candidate agent configuration across all tasks.")
model OptimizationCandidate {
  @doc("Server-assigned candidate identifier. Use with GET /candidates/{id} sub-endpoints.")
  candidate_id?: string;

  @doc("Display name of the candidate (e.g., 'baseline', 'instruction-v2').")
  name: string;

  @doc("What was mutated from the baseline (e.g., {system_prompt: 'new prompt'}).")
  mutations?: Record<unknown>;

  @doc("Average composite score across all tasks.")
  avg_score: float64;

  @doc("Average token usage across all tasks.")
  avg_tokens: float64;

  @doc("Foundry evaluation identifier used to score this candidate.")
  eval_id?: string;

  @doc("Foundry evaluation run identifier for this candidate's scoring run.")
  eval_run_id?: string;

  @doc("Promotion metadata. Null if the candidate has not been promoted.")
  promotion?: PromotionInfo;
}

@doc("Per-task evaluation result for a single candidate.")
model OptimizationTaskResult {
  @doc("Task name (from the dataset).")
  task_name: string;

  @doc("The user query / input for the task.")
  query?: string;

  @doc("Per-evaluator scores keyed by evaluator name.")
  scores: Record<float64>;

  @doc("Composite score combining all evaluator scores.")
  composite_score: float64;

  @doc("Total tokens consumed during the agent run for this task.")
  tokens: int64;

  @doc("Wall-clock seconds for this task's agent execution.")
  @encode(DurationKnownEncoding.seconds, float64)
  duration_seconds: duration;

  @doc("Whether the task met the pass threshold.")
  passed: boolean;

  @doc("Error message if the task failed during execution.")
  error_message?: string;

  @doc("Per-evaluator reasoning keyed by evaluator name.")
  rationales?: Record<string>;

  @doc("Raw agent response text.")
  response?: string;

  @doc("Identifier of the agent run that produced this result.")
  run_id?: string;
}

@doc("Terminal-state result body. Populated when status is succeeded or failed.")
model OptimizationJobResult {
  @doc("Candidate ID of the original (un-optimized) baseline evaluation.")
  baseline?: string;

  @doc("Candidate ID of the highest-scoring candidate found during optimization.")
  best?: string;

  @doc("All evaluated candidates including baseline.")
  candidates?: OptimizationCandidate[];
}

// ---------------------------------------------------------------------------
// Job resource — extends JobLike per Foundry job guidelines
// ---------------------------------------------------------------------------

@doc("Agent optimization job resource — a long-running job that optimizes an agent's configuration (instructions, model, skills, tools) to maximize evaluation scores. On success, the result contains scored candidates.")
model OptimizationJob is JobLike<OptimizationJobResult, OptimizationJobInputs> {
  @doc("The timestamp when the job was created, represented in Unix time.")
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  @doc("The timestamp when the job was last updated, represented in Unix time.")
  @visibility(Lifecycle.Read)
  updated_at: FoundryTimestamp;

  @doc("Progress snapshot. May be present in terminal states reflecting last-known progress.")
  @visibility(Lifecycle.Read)
  progress?: OptimizationJobProgress;

  @doc("Non-fatal warnings emitted at any point during optimization.")
  @visibility(Lifecycle.Read)
  warnings?: string[];
}

// ---------------------------------------------------------------------------
// Slim list item — returned by LIST
// ---------------------------------------------------------------------------

@doc("Slim job representation returned by the LIST endpoint.")
model OptimizationJobListItem
  is OmitProperties<OptimizationJob, "inputs" | "result" | "warnings"> {
  @doc("The agent targeted by this optimization job.")
  @visibility(Lifecycle.Read)
  agent?: OptimizationAgentIdentifier;
}

// ---------------------------------------------------------------------------
// Promotion models
// ---------------------------------------------------------------------------

@doc("Promotion metadata recorded when a candidate is deployed to a Foundry agent.")
model PromotionInfo {
  @doc("Timestamp when promotion occurred, represented in Unix time.")
  promoted_at: FoundryTimestamp;

  @doc("Name of the Foundry agent this candidate was promoted to.")
  agent_name: string;

  @doc("Version of the Foundry agent this candidate was promoted to.")
  agent_version: string;
}