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

@doc("The agent definition being optimized. Identifies the Foundry agent and optional configuration overrides.")
model OptimizationAgentDefinition {
  @doc("Registered Foundry agent name. Required — bare-model mode is not supported.")
  agentName: string;

  @doc("Pinned agent version. Defaults to latest if omitted.")
  agentVersion?: string;

  @doc("Model deployment name (e.g., 'gpt-4o'). Optional when agentName is set — the agent definition provides the model.")
  `model`?: string;

  @doc("System prompt / instructions override. When set, used as the baseline instructions for the agent.")
  systemPrompt?: string;

  @doc("Optional named skills the optimizer may tune.")
  skills?: OptimizationAgentSkill[];

  @doc("Optional function tools available to the agent. When the 'tool' target attribute is active, tool descriptions are optimized. Schema fields (name, types, required) are immutable.")
  tools?: AgentToolDefinition[];
}

@doc("A named skill on the agent that the optimizer may tune.")
model OptimizationAgentSkill {
  @doc("Skill name (matches the tool name on the agent).")
  name: string;

  @doc("Short description of what the skill does — used for discovery.")
  description?: string;

  @doc("Full skill body — detailed instructions, rules, examples that the optimizer uses as the seed text to improve.")
  body?: string;
}

@doc("An OpenAI-format function tool definition. The optimizer mutates the function's description and per-parameter descriptions; schema fields (name, types, required) are immutable.")
model AgentToolDefinition {
  @doc("Tool type discriminator. Only 'function' is supported.")
  type: string = "function";

  @doc("The function definition (name, description, parameters schema).")
  function: AgentToolFunction;
}

@doc("The inner function definition of an AgentToolDefinition.")
model AgentToolFunction {
  @doc("Function name — immutable, must match the executable function identifier.")
  name: string;

  @doc("Natural-language description shown to the model. Mutable during optimization.")
  description?: string;

  @doc("JSON Schema describing the function's arguments.")
  parameters?: Record<unknown>;

  @doc("Whether the provider should enforce strict JSON Schema validation.")
  strict?: boolean;
}

@doc("A single evaluation task with input, expected output, and evaluation criteria.")
model DatasetItem {
  @doc("Unique-within-the-dataset identifier for this task.")
  name: string;

  @doc("The user input for the task (primary field name).")
  prompt?: string;

  @doc("The user query / input for the task (alias for prompt).")
  query?: string;

  @doc("Optional ground truth used by reference-based evaluators.")
  groundTruth?: string;

  @doc("Per-task evaluation criteria. Defaults to the job-level evaluators if unset.")
  criteria?: EvaluationCriterion[];

  @doc("Pre-computed evaluation results in AOAI-compatible format. When provided together with responseItems, the baseline run-and-evaluate phase is skipped.")
  evalResults?: EvalResultItem[];

  @doc("Pre-computed agent response output items. Captures the full trajectory (function calls, tool outputs, messages) from a prior agent run.")
  responseItems?: ResponseOutputItem[];
}

@doc("A single evaluator result item — AOAI-compatible contract.")
model EvalResultItem {
  @doc("Evaluator type (e.g. 'azure_ai_evaluator', 'label_model').")
  type: string;

  @doc("Display name (e.g. 'Relevance', 'LabelModel').")
  name?: string;

  @doc("Metric key used for scoring (e.g. 'relevance').")
  metric?: string;

  @doc("Numeric score.")
  score: float64;

  @doc("Evaluator-assigned label (e.g. 'pass', 'fail').")
  label?: string;

  @doc("Evaluator-provided reason/explanation for the score.")
  reason?: string;

  @doc("Pass/fail threshold.")
  threshold?: float64;

  @doc("Whether the evaluator considered this a pass (score >= threshold).")
  passed: boolean;
}

@doc("A single output item from the Responses API. Captures function calls, outputs, and messages in the agent trajectory.")
model ResponseOutputItem {
  @doc("Item type (e.g. 'function_call', 'function_call_output', 'message').")
  type: string;

  @doc("Message role (e.g. 'assistant').")
  role?: string;

  @doc("Text content of the item.")
  text?: string;

  @doc("Function name for function_call items.")
  name?: string;

  @doc("Serialized function arguments for function_call items.")
  arguments?: string;

  @doc("Call ID linking function_call to function_call_output.")
  callId?: string;

  @doc("Function output for function_call_output items.")
  output?: string;
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

  @doc("Dataset version. If not specified, the latest version is used.")
  version?: string;
}

@doc("Tuning knobs and run-mode for an optimization job.")
model OptimizationOptions {
  @doc("Agent attributes to optimize (e.g. 'instruction', 'skill', 'model', 'tool'). When empty, auto-detected from the baseline config.")
  targetAttributes?: TargetAttribute[];

  @doc("Maximum optimization iterations per target attribute. Default: 5.")
  maxIterations?: int32 = 5;

  @doc("Tasks sampled per iteration (mutation step input). Default: 0 means auto-compute.")
  tasksPerIteration?: int32;

  @doc("Maximum tasks fed into the reflective-mutation LLM per iteration. Default: 5.")
  maxReflectionTasks?: int32 = 5;

  @doc("Minimum score improvement between iterations to continue (plateau detection). Default: 0.005.")
  minImprovement?: float64 = 0.005;

  @doc("Composite score threshold for a task to be considered passing. Default: 0.5.")
  passThreshold?: float64 = 0.5;

  @doc("Target average score at which optimization stops early (quality ceiling). Default: 0.95.")
  improvementThreshold?: float64 = 0.95;

  @doc("Max consecutive non-improving iterations before stopping. Default: 2.")
  maxStaleIterations?: int32 = 2;

  @doc("Per-target-attribute configuration overrides (e.g. model space for model optimization).")
  targetConfig?: Record<unknown>;

  @doc("Run mode.")
  mode?: OptimizationMode;

  @doc("Foundry deployment name to use as the LLM-as-judge evaluation model. Required.")
  evalModel?: string;

  @doc("Optional model deployment for strategy reflection (instruction rewriting, skill generation). Falls back to evalModel if unset.")
  reflectionModel?: string;

  @doc("Per-task timeout for agent execution in seconds. Default: 300 (5 minutes).")
  taskTimeoutSeconds?: int32 = 300;

  @doc("If true, retain temporary candidate-evaluation agent versions for inspection. Default: false.")
  keepVersions?: boolean = false;
}

@doc("Caller-supplied inputs for an optimization job.")
model OptimizationJobInputs {
  @doc("The agent (and pinned version) being optimized.")
  agent: OptimizationAgentDefinition;

  @doc("Inline evaluation dataset. Mutually exclusive with trainDatasetReference.")
  dataset?: DatasetItem[];

  @doc("Reference to a registered training dataset. Mutually exclusive with dataset.")
  trainDatasetReference?: DatasetRef;

  @doc("Optional held-out validation dataset for measuring generalization of the final candidate.")
  validationDatasetReference?: DatasetRef;

  @doc("Job-level evaluators (referenced by name). Per-task criteria may override. Default: ['task_adherence'].")
  evaluators?: string[];

  @doc("Job-level evaluation criteria. Applied to all tasks unless overridden by per-task criteria.")
  criteria?: EvaluationCriterion[];

  @doc("Tuning knobs and run-mode.")
  options?: OptimizationOptions;
}

// ---------------------------------------------------------------------------
// Progress / result models
// ---------------------------------------------------------------------------

@doc("In-flight progress; only populated while status is queued or in_progress.")
model OptimizationJobProgress {
  @doc("Target attribute currently being explored.")
  currentTargetAttribute: TargetAttribute;

  @doc("1-based current iteration index.")
  currentIteration: int32;

  @doc("Tasks evaluated so far this iteration.")
  tasksCompleted: int32;

  @doc("Total tasks scheduled this iteration.")
  tasksTotal: int32;

  @doc("Best score observed so far across all candidates.")
  bestScore: float64;

  @doc("Wall-clock time elapsed in seconds since the job began executing.")
  elapsedSeconds: float64;
}

@doc("Aggregated evaluation result for a single candidate agent configuration across all tasks.")
model OptimizationCandidate {
  @doc("Server-assigned candidate identifier. Use with GET /candidates/{id} sub-endpoints.")
  candidateId?: string;

  @doc("Display name of the candidate (e.g., 'baseline', 'instruction-v2').")
  name: string;

  @doc("The agent configuration that produced this candidate.")
  config: OptimizationAgentDefinition;

  @doc("What was mutated from the baseline (e.g., {systemPrompt: 'new prompt'}).")
  mutations: Record<unknown>;

  @doc("Rationale — why this candidate was generated.")
  rationale: string;

  @doc("Average composite score across all tasks.")
  avgScore: float64;

  @doc("Average token usage across all tasks.")
  avgTokens: float64;

  @doc("Fraction of tasks that met the pass threshold.")
  passRate: float64;

  @doc("Individual task-level scores.")
  taskScores: OptimizationTaskResult[];

  @doc("Whether this candidate is on the Pareto frontier (score vs cost).")
  isParetoOptimal: boolean;

  @doc("Average score from sampled evaluation (null if full dataset was used).")
  sampleAvgScore?: float64;

  @doc("Number of tasks in the sample (null if full dataset was used).")
  sampleSize?: int32;

  @doc("'sample' if scored on a subset, 'full' if re-evaluated on the full dataset.")
  evaluationType?: string;

  @doc("Identifies the target attribute that produced this candidate.")
  targetAttribute?: TargetAttribute;

  @doc("Foundry evaluation identifier used to score this candidate.")
  evalId?: string;

  @doc("Foundry evaluation run identifier for this candidate's scoring run.")
  evalRunId?: string;

  @doc("Promotion metadata. Null if the candidate has not been promoted.")
  promotion?: PromotionInfo;
}

@doc("Per-task evaluation result for a single candidate.")
model OptimizationTaskResult {
  @doc("Task name (from the dataset).")
  taskName: string;

  @doc("The user query / input for the task.")
  query?: string;

  @doc("Per-evaluator scores keyed by evaluator name.")
  scores: Record<float64>;

  @doc("Composite score combining all evaluator scores.")
  compositeScore: float64;

  @doc("Total tokens consumed during the agent run for this task.")
  tokens: int32;

  @doc("Wall-clock seconds for this task's agent execution.")
  durationSeconds: float64;

  @doc("Whether the task met the pass threshold.")
  passed: boolean;

  @doc("Error message if the task failed during execution.")
  errorMessage?: string;

  @doc("Per-evaluator reasoning keyed by evaluator name.")
  rationales?: Record<string>;

  @doc("Raw agent response text.")
  response?: string;

  @doc("Identifier of the agent run that produced this result.")
  runId?: string;
}

@doc("Terminal-state result body. Populated when status is succeeded or failed.")
model OptimizationJobResult {
  @doc("Evaluation scores for the original (un-optimized) agent configuration.")
  baseline?: OptimizationCandidate;

  @doc("The highest-scoring candidate found during optimization.")
  best?: OptimizationCandidate;

  @doc("All evaluated candidates including baseline.")
  candidates?: OptimizationCandidate[];

  @doc("Candidates on the Pareto frontier (maximize score, minimize cost).")
  paretoFrontier?: OptimizationCandidate[];

  @doc("Score of the best candidate on the held-out validation dataset. Null when no validation dataset was provided.")
  validationScore?: OptimizationCandidate;

  @doc("The options used for this optimization run.")
  options?: OptimizationOptions;

  @doc("Number of tasks sampled during optimization iterations (null if sampling was not used).")
  sampleSize?: int32;

  @doc("Non-fatal warnings from the optimization run (e.g., target attribute failures that were skipped).")
  warnings?: string[];

  @doc("True when all target attributes failed — only the baseline was evaluated.")
  allTargetAttributesFailed?: boolean;
}

// ---------------------------------------------------------------------------
// Job resource (uses shared JobLike template)
// ---------------------------------------------------------------------------

@doc("Agent optimization job resource — a long-running job that optimizes an agent's configuration (instructions, model, skills, tools) to maximize evaluation scores. On success, the result contains scored candidates.")
model OptimizationJob
  is JobLike<OptimizationJobResult, OptimizationJobInputs> {
  @doc("The timestamp when the job was created, represented in Unix time.")
  @visibility(Lifecycle.Read)
  createdAt: FoundryTimestamp;

  @doc("The timestamp when the job was last updated, represented in Unix time.")
  @visibility(Lifecycle.Read)
  updatedAt?: FoundryTimestamp;

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
  promotedAt: FoundryTimestamp;

  @doc("Name of the Foundry agent this candidate was promoted to.")
  agentName: string;

  @doc("Version of the Foundry agent this candidate was promoted to.")
  agentVersion: string;
}

@doc("Request body for promoting a candidate to a Foundry agent version.")
model PromoteCandidateRequest {
  @doc("Name of the Foundry agent to promote to.")
  agentName: string;

  @doc("Version of the Foundry agent to promote to.")
  agentVersion: string;
}

@doc("Response after successfully promoting a candidate.")
model PromoteCandidateResponse {
  @doc("The promoted candidate id.")
  candidateId: string;

  @doc("Status after promotion.")
  status: string;

  @doc("Timestamp when promotion occurred, represented in Unix time.")
  promotedAt: FoundryTimestamp;

  @doc("Name of the Foundry agent promoted to.")
  agentName: string;

  @doc("Version of the Foundry agent promoted to.")
  agentVersion: string;
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
  taskCount: int32;

  @doc("True when the dataset was provided inline in the request body.")
  isInline: boolean;
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

  @doc("Optional tool overrides.")
  tools?: AgentToolDefinition[];
}

@doc("Full per-task evaluation results for a candidate, returned by GET /candidates/{id}/results.")
model CandidateResults {
  @doc("Owning candidate id.")
  candidateId: string;

  @doc("Per-task evaluation rows.")
  results: OptimizationTaskResult[];
}

@doc("Candidate metadata returned by GET /candidates/{id}.")
model CandidateMetadata {
  @doc("Server-assigned candidate identifier.")
  candidateId: string;

  @doc("Owning optimization job id.")
  jobId: string;

  @doc("Display name of the candidate.")
  candidateName: string;

  @doc("Candidate lifecycle status.")
  status: string;

  @doc("Candidate's aggregate score.")
  score?: float64;

  @doc("Whether detailed results are available for this candidate.")
  hasResults: boolean;

  @doc("Timestamp when the candidate was created, represented in Unix time.")
  createdAt: FoundryTimestamp;

  @doc("Timestamp when the candidate was last updated, represented in Unix time.")
  updatedAt: FoundryTimestamp;

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
  sizeBytes: int64;
}
