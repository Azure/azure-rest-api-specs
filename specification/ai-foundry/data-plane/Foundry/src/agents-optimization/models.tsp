// Models for the AgentsOptimization data-plane surface.
// Aligned with in-tree C# DTOs (Contracts/V1/Models/).
//
// Uses shared Foundry job infrastructure from servicepatterns.tsp:
//   JobLike<TResult, TInputs> — base job shape (id, status, inputs, result, error)
//   JobStatus — shared lifecycle union (queued/in_progress/succeeded/failed/cancelled)
//   FoundryTimestamp — Unix epoch int32
//   ApiError — standard error shape

import "../common/models.tsp";
import "../openai-evaluations/models.tsp";
import "../servicepatterns.tsp";

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
// Input models
// ---------------------------------------------------------------------------

@doc("Identifies the registered Foundry agent to optimize (request-only). Skills, tools, and system_prompt are specified in options.optimization_config.")
model AgentIdentifier {
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

@doc("Reference to a registered dataset in the Foundry Dataset Service.")
model DatasetRef {
  @doc("Dataset name.")
  name: string;

  @doc("Dataset version. If not specified, the latest version is used.")
  version?: string;
}

@doc("Tuning knobs and run-mode for an optimization job.")
model OptimizationOptions {
  @doc("Maximum optimization iterations per strategy. Must be >= 1. Default: 5.")
  max_iterations?: int32 = 5;

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
  agent: AgentIdentifier;

  @doc("Reference to a registered training dataset (required).")
  train_dataset_reference: DatasetRef;

  @doc("Optional held-out validation dataset for measuring generalization of the final candidate.")
  validation_dataset_reference?: DatasetRef;

  @doc("Job-level evaluators (referenced by name). Per-task criteria may override. Default: ['task_adherence'].")
  evaluators?: string[];

  @doc("Tuning knobs and run-mode.")
  options?: OptimizationOptions;
}

// ---------------------------------------------------------------------------
// Progress / result models
// ---------------------------------------------------------------------------

@doc("In-flight progress; only populated while status is queued or in_progress.")
model OptimizationJobProgress {
  @doc("1-based current iteration index.")
  current_iteration: int32;

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

  @doc("The agent configuration that produced this candidate.")
  config: OptimizationAgentDefinition;

  @doc("What was mutated from the baseline (e.g., {system_prompt: 'new prompt'}).")
  mutations: Record<unknown>;

  @doc("Average composite score across all tasks.")
  avg_score: float64;

  @doc("Average token usage across all tasks.")
  avg_tokens: float64;

  @doc("Fraction of tasks that met the pass threshold.")
  pass_rate: float64;

  @doc("Individual task-level scores.")
  task_scores: OptimizationTaskResult[];

  @doc("Whether this candidate is on the Pareto frontier (score vs cost).")
  is_pareto_optimal: boolean;

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
  @doc("Evaluation scores for the original (un-optimized) agent configuration.")
  baseline?: OptimizationCandidate;

  @doc("The highest-scoring candidate found during optimization.")
  best?: OptimizationCandidate;

  @doc("All evaluated candidates including baseline.")
  candidates?: OptimizationCandidate[];

  @doc("The options used for this optimization run.")
  options?: OptimizationOptions;

  @doc("Non-fatal warnings from the optimization run (e.g., target attribute failures that were skipped).")
  warnings?: string[];

  @doc("True when all target attributes failed — only the baseline was evaluated.")
  all_target_attributes_failed?: boolean;
}

// ---------------------------------------------------------------------------
// Job resource — flat request body (no `inputs` wrapper) to match vienna contract
// ---------------------------------------------------------------------------

@doc("Agent optimization job resource — a long-running job that optimizes an agent's configuration (instructions, model, skills, tools) to maximize evaluation scores. On success, the result contains scored candidates.")
model OptimizationJob {
  @doc("Server-assigned unique identifier.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Current lifecycle status.")
  @visibility(Lifecycle.Read)
  status: JobStatus;

  @doc("Error details — populated only on failure.")
  @visibility(Lifecycle.Read)
  error?: ApiError;

  @doc("Result produced on success.")
  @visibility(Lifecycle.Read)
  result?: OptimizationJobResult;

  // --- Inputs (nested in response, echoing caller-supplied config) ---
  @doc("Caller-supplied inputs.")
  inputs?: OptimizationJobInputs;

  @doc("The timestamp when the job was created, represented in Unix time.")
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  @doc("The timestamp when the job was last updated (status, progress, or result change), represented in Unix time.")
  @visibility(Lifecycle.Read)
  updated_at?: FoundryTimestamp;

  @doc("Progress while in flight. Absent in terminal states.")
  @visibility(Lifecycle.Read)
  progress?: OptimizationJobProgress;

  @doc("Metadata about the dataset used for this optimization job.")
  @visibility(Lifecycle.Read)
  dataset?: DatasetInfo;
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

@doc("Request body for promoting a candidate to a Foundry agent version.")
model PromoteCandidateRequest {
  @doc("Name of the Foundry agent to promote to.")
  agent_name: string;

  @doc("Version of the Foundry agent to promote to.")
  agent_version: string;
}

@doc("Response after successfully promoting a candidate.")
model PromoteCandidateResponse {
  @doc("The promoted candidate id.")
  candidate_id: string;

  @doc("Status after promotion.")
  status: string;

  @doc("Timestamp when promotion occurred, represented in Unix time.")
  promoted_at: FoundryTimestamp;

  @doc("Name of the Foundry agent promoted to.")
  agent_name: string;

  @doc("Version of the Foundry agent promoted to.")
  agent_version: string;
}

// ---------------------------------------------------------------------------
// Dataset info model
// ---------------------------------------------------------------------------

@doc("Metadata about the dataset used for optimization, surfaced in the response.")
model DatasetInfo {
  @doc("Dataset name when using a registered dataset reference. Null for inline datasets.")
  name?: string;

  @doc("Dataset version when using a registered dataset reference. Null for inline datasets.")
  version?: string;

  @doc("Number of tasks/rows in the dataset.")
  task_count: int32;

  @doc("True when the dataset was provided inline in the request body.")
  is_inline: boolean;
}

// ---------------------------------------------------------------------------
// Candidate sub-resource bodies
// ---------------------------------------------------------------------------

@doc("Deploy-config blob for a candidate. Suitable for setting OPTIMIZATION_CONFIG on a hosted-agent version.")
model CandidateDeployConfig {
  @doc("System prompt / instructions.")
  instructions?: string;

  @doc("Foundry deployment name.")
  `model`?: string;

  @doc("Optional sampling temperature.")
  @minValue(0)
  @maxValue(2)
  temperature?: float32;

  @doc("Optional skill overrides.")
  skills?: Record<unknown>[];

  @doc("Optional tool overrides.")
  tools?: Record<unknown>[];
}

@doc("Full per-task evaluation results for a candidate, returned by GET /candidates/{id}/results.")
model CandidateResults {
  @doc("Owning candidate id.")
  candidate_id: string;

  @doc("Per-task evaluation rows.")
  results: OptimizationTaskResult[];
}

@doc("Candidate metadata returned by GET /candidates/{id}.")
model CandidateMetadata {
  @doc("Server-assigned candidate identifier.")
  candidate_id: string;

  @doc("Owning optimization job id.")
  job_id: string;

  @doc("Display name of the candidate.")
  candidate_name: string;

  @doc("Candidate lifecycle status.")
  status: string;

  @doc("Candidate's aggregate score.")
  score?: float64;

  @doc("Whether detailed results are available for this candidate.")
  has_results: boolean;

  @doc("Timestamp when the candidate was created, represented in Unix time.")
  created_at: FoundryTimestamp;

  @doc("Timestamp when the candidate was last updated, represented in Unix time.")
  updated_at: FoundryTimestamp;

  @doc("Promotion metadata. Null if not promoted.")
  promotion?: PromotionInfo;

  @doc("Files in the candidate's blob directory.")
  files: CandidateFileInfo[];
}

@doc("File entry in a candidate's blob directory.")
model CandidateFileInfo {
  @doc("Relative path of the file.")
  path: string;

  @doc("File type category (e.g. 'config', 'results').")
  type: string;

  @doc("File size in bytes.")
  size_bytes: int64;
}
