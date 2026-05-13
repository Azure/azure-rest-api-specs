// Models for the AgentsOptimization data-plane surface.
// Aligned with in-tree C# DTOs (Contracts/V1/Models/).
//
// Uses shared Foundry job infrastructure from servicepatterns.tsp:
//   JobLike<TResult, TInputs> — base job shape (id, status, inputs, result, error)
//   JobStatus — shared lifecycle union (queued/in_progress/succeeded/failed/cancelled)
//   FoundryTimestamp — Unix epoch int32
//   ApiError — standard error shape
//
// C# code changes required for Foundry alignment:
//   - Status vocabulary: Pending/Running/Completed → queued/in_progress/succeeded
//   - Timestamps: DateTimeOffset → unix epoch int32
//   - ID field: OperationId → id
//   - Route: /optimize → /agent_optimization_jobs
//   - Response shape: multiple response types → single JobLike model

import "../common/models.tsp";
import "../openai-evaluations/models.tsp";
import "../servicepatterns.tsp";

using TypeSpec.Rest;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Enums / unions
// ---------------------------------------------------------------------------

/** Optimization strategy dimension. */
union OptimizationStrategy {
  string,

  @doc("Instruction-tuning strategy — rewrites agent system prompts.")
  instruction: "instruction",

  @doc("Model-selection strategy — evaluates alternative LLM deployments.")
  `model`: "model",

  @doc("Skill-tuning strategy — generates or modifies agent tool descriptions.")
  skill: "skill",
}

/** Run mode for an optimization job. */
union OptimizationMode {
  string,

  @doc("Full optimization: baseline + mutation strategies.")
  optimize: "optimize",
}

// ---------------------------------------------------------------------------
// Input models
// ---------------------------------------------------------------------------

@doc("The agent definition being optimized. Identifies the Foundry agent and optional configuration overrides.")
model OptimizationAgentDefinition {
  @doc("Registered Foundry agent name. Required — bare-model mode is not supported.")
  agent_name: string;

  @doc("Pinned agent version. Defaults to latest if omitted.")
  agent_version?: string;

  @doc("Model deployment name (e.g., 'gpt-4o'). Optional when agent_name is set — the agent definition provides the model.")
  `model`?: string;

  @doc("System prompt / instructions override. When set, used as the baseline instructions for the agent.")
  system_prompt?: string;

  @doc("Optional named skills the optimizer may tune. Tool descriptions and parameters.")
  skills?: OptimizationAgentSkill[];
}

@doc("A named skill on the agent that the optimizer may tune.")
model OptimizationAgentSkill {
  @doc("Skill name (matches the tool name on the agent).")
  name: string;

  @doc("Free-form description used as the seed when tuning skill descriptions.")
  description?: string;
}

@doc("A single evaluation task with input query, expected output, and evaluation criteria.")
model DatasetItem {
  @doc("Unique-within-the-dataset identifier for this task.")
  name: string;

  @doc("The user query / input for the task.")
  query: string;

  @doc("Optional ground truth used by reference-based evaluators.")
  ground_truth?: string;

  @doc("Per-task evaluation criteria. Defaults to the job-level evaluators if unset.")
  criteria?: EvaluationCriterion[];

  @doc("Pre-computed evaluation results in AOAI-compatible format. When provided together with `response_items`, the baseline run-and-evaluate phase is skipped.")
  eval_results?: EvalRunOutputItemResult[];

  @doc("Pre-computed agent response output items. Captures the full trajectory (function calls, tool outputs, messages) from a prior agent run.")
  response_items?: OpenAI.OutputItem[];
}

@doc("LLM-as-judge evaluation criterion applied to a single task.")
model EvaluationCriterion {
  @doc("Criterion name (referenced in evaluation result rows).")
  name: string;

  @doc("Natural-language instruction passed to the judge LLM.")
  instruction: string;
}

@doc("Reference to a registered dataset in the Foundry Dataset Service.")
model DatasetRef {
  @doc("Dataset name.")
  name: string;

  @doc("Dataset version.")
  version: string;
}

@doc("Tuning knobs and run-mode for an optimization job.")
model OptimizationOptions {
  @doc("Strategies to apply this run. Default: ['instruction'].")
  strategies?: OptimizationStrategy[] = #[OptimizationStrategy.instruction];

  @doc("Total candidate generation budget (number of candidates explored). Default: 10.")
  budget?: int32 = 10;

  @doc("Maximum optimization iterations per strategy. Default: 5.")
  max_iterations?: int32 = 5;

  @doc("Tasks sampled per iteration (mutation step input). Default: service-decided (auto-computed).")
  tasks_per_iteration?: int32;

  @doc("Maximum tasks fed into the reflective-mutation LLM per iteration. Default: 5.")
  max_reflection_tasks?: int32 = 5;

  @doc("Minimum score improvement between iterations to continue (plateau detection). Default: 0.005.")
  min_improvement?: float64 = 0.005;

  @doc("Composite score threshold for a task to be considered passing. Default: 0.5.")
  pass_threshold?: float64 = 0.5;

  @doc("Target average score at which optimization stops early (quality ceiling). Default: 0.95.")
  improvement_threshold?: float64 = 0.95;

  @doc("Run mode.")
  mode?: OptimizationMode;

  @doc("Foundry deployment name to use as the LLM-as-judge evaluation model. Required.")
  eval_model?: string;

  @doc("Optional model deployment for strategy reflection (instruction rewriting, skill generation). Falls back to `eval_model` if unset.")
  reflection_model?: string;

  @doc("Per-task timeout for agent execution. Default: 300 seconds (5 minutes).")
  @encode(DurationKnownEncoding.seconds, int32)
  task_timeout_seconds?: duration = duration.fromISO("PT5M");

  @doc("If true, retain temporary candidate-evaluation agent versions for inspection. Default: false.")
  keep_versions?: boolean = false;
}

@doc("Caller-supplied inputs for an optimization job.")
model OptimizationJobInputs {
  @doc("The agent (and pinned version) being optimized.")
  agent: OptimizationAgentDefinition;

  @doc("Inline evaluation dataset. Mutually exclusive with `train_dataset_reference`.")
  dataset?: DatasetItem[];

  @doc("Reference to a registered training dataset. Mutually exclusive with `dataset`.")
  train_dataset_reference?: DatasetRef;

  @doc("Optional held-out validation dataset for measuring generalization of the final candidate.")
  validation_dataset_reference?: DatasetRef;

  @doc("Job-level evaluators (referenced by `name`). Per-task `criteria` may override. Default: ['task_adherence'].")
  evaluators?: string[];

  @doc("Job-level evaluation criteria. Applied to all tasks unless overridden by per-task `criteria`.")
  criteria?: EvaluationCriterion[];

  @doc("Tuning knobs and run-mode.")
  options?: OptimizationOptions;
}

// ---------------------------------------------------------------------------
// Progress / result models
// ---------------------------------------------------------------------------

@doc("In-flight progress; only populated while status is `queued` or `in_progress`.")
model OptimizationJobProgress {
  @doc("Strategy currently being explored.")
  current_strategy: OptimizationStrategy;

  @doc("1-based current iteration index.")
  current_iteration: int32;

  @doc("Tasks evaluated so far this iteration.")
  tasks_completed: int32;

  @doc("Total tasks scheduled this iteration.")
  tasks_total: int32;

  @doc("Best score observed so far across all candidates.")
  best_score: float64;

  @doc("Wall-clock time elapsed since the job began executing.")
  @encode(DurationKnownEncoding.seconds, float64)
  elapsed_seconds: duration;
}

@doc("Aggregated evaluation result for a single candidate agent configuration across all tasks.")
model OptimizationCandidate {
  @doc("Server-assigned candidate identifier. Use with `GET /candidates/{id}` sub-endpoints.")
  candidate_id?: string;

  @doc("Display name of the candidate (e.g., 'baseline', 'instruction-v2').")
  name: string;

  @doc("The agent configuration that produced this candidate.")
  config: OptimizationAgentDefinition;

  @doc("What was mutated from the baseline (e.g., {instructions: 'new prompt'}).")
  mutations: Record<unknown>;

  @doc("Strategy rationale — why this candidate was generated.")
  rationale: string;

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

  @doc("Average score from sampled evaluation (null if full dataset was used).")
  sample_avg_score?: float64;

  @doc("Number of tasks in the sample (null if full dataset was used).")
  sample_size?: int32;

  @doc("'sample' if scored on a subset, 'full' if re-evaluated on the full dataset.")
  evaluation_type?: string;

  @doc("Identifies the strategy that produced this candidate.")
  strategy?: OptimizationStrategy;

  @doc("Foundry evaluation identifier used to score this candidate.")
  eval_id?: string;

  @doc("Foundry evaluation run identifier for this candidate's scoring run.")
  eval_run_id?: string;
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
  tokens: int32;

  @doc("Wall-clock seconds for this task's agent execution.")
  duration_seconds: float64;

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

@doc("Terminal-state result body. Populated when `status` is `succeeded` or `failed`.")
model OptimizationJobResult {
  @doc("Evaluation scores for the original (un-optimized) agent configuration.")
  baseline?: OptimizationCandidate;

  @doc("The highest-scoring candidate found during optimization.")
  best?: OptimizationCandidate;

  @doc("All evaluated candidates including baseline.")
  candidates?: OptimizationCandidate[];

  @doc("Candidates on the Pareto frontier (maximize score, minimize cost).")
  pareto_frontier?: OptimizationCandidate[];

  @doc("Score of the best candidate on the held-out validation dataset. Null when no validation dataset was provided.")
  validation_score?: OptimizationCandidate;

  @doc("The options used for this optimization run.")
  options?: OptimizationOptions;

  @doc("Number of tasks sampled during optimization iterations (null if sampling was not used).")
  sample_size?: int32;

  @doc("Non-fatal warnings from the optimization run (e.g., strategy failures that were skipped).")
  warnings?: string[];

  @doc("True when all optimization strategies failed — only the baseline was evaluated.")
  all_strategies_failed?: boolean;
}

// ---------------------------------------------------------------------------
// Job resource (uses shared JobLike template)
// ---------------------------------------------------------------------------

@doc("Agent optimization job resource — a long-running job that optimizes an agent's configuration (instructions, model, skills) to maximize evaluation scores. On success, the result contains scored candidates.")
model OptimizationJob
  is JobLike<OptimizationJobResult, OptimizationJobInputs> {
  @doc("The timestamp when the job was created, represented in Unix time.")
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  @doc("The timestamp when the job was last updated, represented in Unix time.")
  @visibility(Lifecycle.Read)
  updated_at?: FoundryTimestamp;

  @doc("Progress while in flight. Absent in terminal states.")
  @visibility(Lifecycle.Read)
  progress?: OptimizationJobProgress;
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
  skills?: OptimizationAgentSkill[];
}

@doc("Full per-task evaluation results for a candidate, returned by GET /candidates/{id}/results.")
model CandidateResults {
  @doc("Owning candidate id.")
  candidate_id: string;

  @doc("Per-task evaluation rows.")
  results: OptimizationTaskResult[];
}
