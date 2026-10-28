// Candidate models for the AgentsOptimization data-plane surface (v1 GA).

import "./inputs.tsp";
import "./insights.tsp";
import "../common/servicepatterns.tsp";
import "@azure-tools/openai-typespec/models/chat";

using TypeSpec.Rest;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Candidate models
// ---------------------------------------------------------------------------

@doc("The candidate's lifecycle state.")
union AgentOptimizationCandidateStatus {
  string,

  @doc("The optimizer is proposing and screening mutations for this candidate.")
  generating: "generating",

  @doc("The accepted candidate is undergoing full evaluation.")
  evaluating: "evaluating",

  @doc("The candidate completed full evaluation.")
  completed: "completed",

  @doc("The optimizer stopped before this candidate completed.")
  failed: "failed",
}

@doc("Base candidate output. Job types define derived output models with their own fields.")
@discriminator("type")
model AgentOptimizationCandidateOutput {
  @doc("Identifies the output shape. Agent optimization uses agent_optimization; prompt optimization uses prompt_optimization. Additional types may be added in future API versions.")
  type: AgentOptimizationConfigurationType;
}

@doc("Candidate output produced by an agent-optimization job.")
model AgentOptimizationAgentCandidateOutput
  extends AgentOptimizationCandidateOutput {
  type: AgentOptimizationConfigurationType.agent_optimization;

  @doc("Typed configuration mutations applied to the baseline. Omitted for the baseline candidate. LIST without `expand=mutations` returns mutation items with only `type`; expanded LIST and candidate GET populate each mutation's `value`.")
  mutations?: AgentOptimizationMutation[];
}

@doc("Candidate output produced by a prompt-optimization job.")
model AgentOptimizationPromptCandidateOutput
  extends AgentOptimizationCandidateOutput {
  type: AgentOptimizationConfigurationType.prompt_optimization;

  @doc("Typed configuration mutations applied to the baseline. Omitted for the baseline candidate. LIST without `expand=mutations` returns mutation items with only `type`; expanded LIST and candidate GET populate each mutation's `value`.")
  mutations?: AgentOptimizationMutation[];
}

@doc("Base candidate mutation.")
@discriminator("type")
model AgentOptimizationMutation {
  @doc("Attribute changed by this mutation.")
  type: TargetAttribute;
}

@doc("Instructions mutation.")
model AgentOptimizationInstructionsMutation extends AgentOptimizationMutation {
  type: TargetAttribute.instructions;

  @doc("Optimized agent instructions. Omitted on LIST unless `expand=mutations` is specified.")
  value?: string;
}

@doc("Model mutation.")
model AgentOptimizationModelMutation extends AgentOptimizationMutation {
  type: TargetAttribute.`model`;

  @doc("Selected model name or deployment name. Omitted on LIST unless `expand=mutations` is specified.")
  value?: AgentOptimizationModelName;
}

@doc("Skill mutations.")
model AgentOptimizationSkillsMutation extends AgentOptimizationMutation {
  type: TargetAttribute.skills;

  @doc("Added or changed skills. Omitted on LIST unless `expand=mutations` is specified.")
  value?: AgentOptimizationSkill[];
}

@doc("Tool mutations.")
model AgentOptimizationToolsMutation extends AgentOptimizationMutation {
  type: TargetAttribute.tools;

  @doc("Added or changed function tools. Omitted on LIST unless `expand=mutations` is specified.")
  value?: OpenAI.ChatCompletionTool[];
}

@doc("Evaluation-serving usage and estimated cost for one candidate, separate from the optimizer's candidate-generation costs.")
model AgentOptimizationCandidateCost {
  @doc("Measured token usage and estimated cost grouped by the actual serving model, including unpriced models. Empty when no model measurements are available.")
  model_costs: AgentOptimizationCandidateModelCost[];

  @doc("Estimated serving cost across priced validation tasks, in the specified currency. Omitted when measurement coverage is insufficient.")
  @minValue(0)
  estimated_cost?: float64;

  @doc("Estimated serving cost per priced validation task, in the specified currency. Omitted when unavailable.")
  @minValue(0)
  estimated_cost_per_task?: float64;

  @doc("Fraction of validation tasks with complete token measurements and a known model price, between 0 and 1.")
  @minValue(0)
  @maxValue(1)
  measurement_coverage: float64;

  @doc("ISO 4217 currency code for all costs in this summary. Currently USD.")
  currency: string;
}

@doc("Measured evaluation-serving usage and estimated cost for one actual routed model.")
model AgentOptimizationCandidateModelCost {
  @doc("Actual model that served the measured validation tasks.")
  `model`: string;

  @doc("Aggregate token measurements for this model.")
  token_usage: AgentOptimizationCandidateTokenUsage;

  @doc("Estimated serving cost for this model, in the summary's currency. Omitted when the model is unpriced.")
  @minValue(0)
  estimated_cost?: float64;
}

@doc("Aggregate evaluation-serving token counts for one model. Unavailable prompt, completion, and total counts are omitted, not replaced with zero.")
model AgentOptimizationCandidateTokenUsage {
  @doc("Aggregate prompt token count. Omitted when unmeasured.")
  @minValue(0)
  prompt_tokens?: int64;

  @doc("Aggregate prompt tokens served from the model's cache.")
  @minValue(0)
  cached_tokens: int64;

  @doc("Aggregate completion token count. Omitted when unmeasured.")
  @minValue(0)
  completion_tokens?: int64;

  @doc("Aggregate reasoning token count.")
  @minValue(0)
  reasoning_tokens: int64;

  @doc("Aggregate total token count. Omitted when unmeasured.")
  @minValue(0)
  total_tokens?: int64;
}

@doc("Comparative evaluation summary for a candidate.")
model AgentOptimizationCandidateEvaluation {
  @doc("Average composite score across evaluated tasks. Omitted until scoring produces an aggregate score.")
  score?: float64;

  @doc("Average score for each configured evaluator. Omitted when evaluator scores are unavailable. These raw aggregates are distinct from the Insights failure-remediation selection score.")
  evaluator_scores?: Record<float64>;

  @doc("Sampled training metrics from an existing candidate screen, not full validation. Omitted when no screen metrics were recorded.")
  sampled_training_evaluation?: AgentOptimizationSampledTrainingEvaluation;

  @doc("Failure-remediation validation, coverage, and eligibility for Insights optimization. Omitted when this assessment was not performed.")
  validation_evaluation?: AgentOptimizationCandidateValidationEvaluation;

  @doc("Report-only remediation over all prepared Insight failure cases, including training cases. Available on candidate LIST and GET without expansion when recorded, including for the baseline. Omitted when no report is available; candidate completion alone does not guarantee report availability.")
  insights_summary?: AgentOptimizationInsightsSummary;

  @doc("Average total tokens consumed per task. Omitted when token usage was not measured.")
  avg_tokens?: float64;

  @doc("Evaluation-serving cost estimates and per-model token measurements. Omitted when no cost summary was recorded. Unavailable estimates and token counts within a recorded summary are omitted rather than synthesized as zero.")
  candidate_cost?: AgentOptimizationCandidateCost;

  @doc("Average end-to-end latency per task, rounded to milliseconds.")
  avg_latency_ms?: FoundryDurationMilliseconds;

  @doc("Foundry evaluation identifier used to score this candidate. Omitted when unavailable.")
  eval_id?: string;

  @doc("Foundry evaluation run identifier used to score this candidate. Omitted when unavailable.")
  eval_run_id?: string;

  @doc("Timestamp when full candidate evaluation completed, represented in Unix time. Omitted when unavailable.")
  completed_at?: FoundryTimestamp;
}

@doc("A candidate generated by an optimization job.")
model AgentOptimizationCandidate {
  @doc("Server-assigned candidate identifier.")
  candidate_id: string;

  @doc("Identifier of the parent optimization job.")
  job_id: string;

  @doc("Display name of the candidate (e.g., 'baseline', 'instruction-v2').")
  name: string;

  @doc("The candidate's current lifecycle state.")
  status: AgentOptimizationCandidateStatus;

  @doc("Recorded reason this candidate failed or was skipped. Omitted when no candidate-local error was recorded. A candidate failure does not necessarily fail the parent job.")
  error?: ApiError;

  @doc("Timestamp when work on this candidate slot began, represented in Unix time.")
  started_at: FoundryTimestamp;

  @doc("Typed output generated for this candidate. The output type matches the parent job's optimization type. Omitted until output is available.")
  output?: AgentOptimizationCandidateOutput;

  @doc("Human-readable explanation of why the optimizer produced this candidate. Populated on candidate GET when available and omitted from LIST.")
  rationale?: string;

  @doc("Foundry agent version associated with this candidate. Omitted when no temporary or evaluated agent version was created.")
  agent_version?: string;

  @doc("Comparative evaluation summary. Omitted when this candidate was not comparatively evaluated.")
  evaluation?: AgentOptimizationCandidateEvaluation;

  @doc("Promotion metadata. Omitted if this candidate has not been promoted.")
  promotion?: AgentOptimizationCandidatePromotionInfo;
}

/** Vocabulary for the `expand` query parameter on the candidate LIST endpoint. This open union keeps SDKs usable when new expand keys ship server-side. Multiple values are serialized as one comma-separated query parameter. */
union AgentOptimizationCandidateExpand {
  string,

  @doc("Include mutation `value` fields in `AgentOptimizationCandidate.output.mutations`. Without this key each mutation item contains only its `type`.")
  mutations: "mutations",
}

// ---------------------------------------------------------------------------
// Promotion models
// ---------------------------------------------------------------------------

@doc("Promotion metadata recorded for a candidate.")
model AgentOptimizationCandidatePromotionInfo {
  @doc("Timestamp when promotion occurred, represented in Unix time.")
  promoted_at: FoundryTimestamp;

  @doc("Agent reference associated with the completed promotion.")
  promoted_agent: AgentReference;
}
