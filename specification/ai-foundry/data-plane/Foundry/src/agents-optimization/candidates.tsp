// Candidate models for the AgentsOptimization data-plane surface (v1 GA).

import "./inputs.tsp";
import "../common/servicepatterns.tsp";
import "@azure-tools/openai-typespec/models/chat";

using TypeSpec.Rest;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Candidate models
// ---------------------------------------------------------------------------

@doc("Agent configuration changes generated for a candidate.")
model AgentOptimizationCandidateOutput {
  @doc("Output type discriminator.")
  type: "agent_configuration";

  @doc("Typed configuration mutations applied to the baseline. Omitted for the baseline candidate. LIST without `expand=mutations` returns mutation items with only `type`; expanded LIST and candidate GET populate each mutation's `value`.")
  mutations?: AgentOptimizationMutation[];
}

@doc("Candidate mutation type. Additional mutation types may be added in future API versions.")
union AgentOptimizationMutationType {
  string,
  instruction: "instruction",
  `model`: "model",
  skills: "skills",
  tools: "tools",
}

@doc("Base candidate mutation.")
@discriminator("type")
model AgentOptimizationMutation {
  @doc("Attribute changed by this mutation.")
  type: AgentOptimizationMutationType;
}

@doc("Instruction mutation.")
model AgentOptimizationInstructionMutation extends AgentOptimizationMutation {
  type: AgentOptimizationMutationType.instruction;

  @doc("Optimized agent instructions. Omitted on LIST unless `expand=mutations` is specified.")
  value?: string;
}

@doc("Model-deployment mutation.")
model AgentOptimizationModelMutation extends AgentOptimizationMutation {
  type: AgentOptimizationMutationType.`model`;

  @doc("Selected model deployment. Omitted on LIST unless `expand=mutations` is specified.")
  value?: AgentOptimizationDeploymentName;
}

@doc("Skill mutations.")
model AgentOptimizationSkillsMutation extends AgentOptimizationMutation {
  type: AgentOptimizationMutationType.skills;

  @doc("Added or changed skills. Omitted on LIST unless `expand=mutations` is specified.")
  value?: AgentOptimizationSkill[];
}

@doc("Tool mutations.")
model AgentOptimizationToolsMutation extends AgentOptimizationMutation {
  type: AgentOptimizationMutationType.tools;

  @doc("Added or changed function tools. Omitted on LIST unless `expand=mutations` is specified.")
  value?: OpenAI.ChatCompletionTool[];
}

@doc("Aggregate billable token counts for one routed model in a candidate evaluation.")
model AgentOptimizationCandidateTokenUsage {
  @doc("Input tokens that were not served from cache. Omitted when unmeasured.")
  @minValue(0)
  prompt_tokens?: int64;

  @doc("Input tokens served from cache. Defaults to zero when omitted.")
  @minValue(0)
  cached_tokens: int64 = 0;

  @doc("Output tokens. Omitted when unmeasured.")
  @minValue(0)
  completion_tokens?: int64;

  @doc("Reasoning tokens included in completion_tokens. Defaults to zero when omitted.")
  @minValue(0)
  reasoning_tokens: int64 = 0;

  @doc("Total input and output tokens. Omitted when unmeasured.")
  @minValue(0)
  total_tokens?: int64;
}

@doc("Measured usage and estimated serving cost for one routed model.")
model AgentOptimizationCandidateModelCost {
  @doc("Actual model that served the measured validation tasks.")
  `model`: string;

  @doc("Aggregate token usage attributed to this model.")
  token_usage: AgentOptimizationCandidateTokenUsage;

  @doc("Estimated serving cost for this model. Omitted when the model could not be priced.")
  @minValue(0)
  estimated_cost?: float64;
}

@doc("Validation serving-cost summary for one candidate.")
model AgentOptimizationCandidateCost {
  @doc("Usage and pricing grouped by the actual routed model.")
  model_costs: AgentOptimizationCandidateModelCost[];

  @doc("Estimated serving cost across priced validation tasks. Omitted when coverage is insufficient.")
  @minValue(0)
  estimated_cost?: float64;

  @doc("Estimated serving cost per priced validation task. Omitted when coverage is insufficient.")
  @minValue(0)
  estimated_cost_per_task?: float64;

  @doc("Fraction of validation tasks with complete usage and a known model price.")
  @minValue(0)
  @maxValue(1)
  measurement_coverage: float64;

  @doc("ISO 4217 currency code. Defaults to USD.")
  currency: string = "USD";
}

@doc("Comparative evaluation summary for a candidate.")
model AgentOptimizationCandidateEvaluation {
  @doc("Average composite score across evaluated tasks. Omitted until scoring produces an aggregate score.")
  score?: float64;

  @doc("Average total tokens consumed per task. Omitted when token usage was not measured.")
  avg_tokens?: float64;

  #suppress "@azure-tools/typespec-azure-core/known-encoding" "AgentsOptimization wire uses floating-point milliseconds; preserve the existing wire contract while exposing a semantic duration type."
  @doc("Average end-to-end latency per task. Omitted when latency was not measured. Wire representation: milliseconds as a float.")
  @encode(DurationKnownEncoding.milliseconds, float64)
  avg_latency_ms?: duration;

  @doc("Per-routed-model serving-cost summary. Omitted when candidate cost was not measured.")
  candidate_cost?: AgentOptimizationCandidateCost;

  @doc("Foundry evaluation identifier used to score this candidate. Omitted when unavailable.")
  eval_id?: string;

  @doc("Foundry evaluation run identifier used to score this candidate. Omitted when unavailable.")
  eval_run_id?: string;

  @doc("Timestamp when full candidate evaluation completed, represented in Unix time. Omitted when unavailable.")
  completed_at?: FoundryTimestamp;
}

@doc("An agent configuration candidate generated by an optimization job.")
model AgentOptimizationCandidate {
  @doc("Server-assigned candidate identifier.")
  candidate_id: string;

  @doc("Identifier of the parent optimization job.")
  job_id: string;

  @doc("Display name of the candidate (e.g., 'baseline', 'instruction-v2').")
  name: string;

  @doc("Generated agent configuration changes.")
  output: AgentOptimizationCandidateOutput;

  @doc("Human-readable explanation of why the optimizer produced this candidate. Populated on candidate GET when available and omitted from LIST.")
  rationale?: string;

  @doc("Foundry agent version associated with this candidate. Omitted when no temporary or evaluated agent version was created.")
  agent_version?: string;

  @doc("Timestamp when the candidate was created, represented in Unix time. Omitted when unavailable for legacy candidate records.")
  created_at?: FoundryTimestamp;

  @doc("Comparative evaluation summary. Omitted when this candidate was not comparatively evaluated.")
  evaluation?: AgentOptimizationCandidateEvaluation;

  @doc("Promotion metadata. Omitted if this candidate has not been promoted.")
  promotion?: PromotionInfo;
}

/** Vocabulary for the `expand` query parameter on candidate LIST/GET endpoints. Open string so the SDK stays usable when new expand keys ship server-side; known values are enumerated as members. Multiple expand keys may be combined in a comma-separated string. */
union AgentOptimizationCandidateExpand {
  string,

  @doc("Include mutation `value` fields in `AgentOptimizationCandidate.output.mutations`. Without this key each mutation item contains only its `type`.")
  mutations: "mutations",
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

  @doc("Version of the Foundry agent created or associated with the recorded promotion. Omitted when no version was created or recorded.")
  agent_version?: string;

  @doc("Whether promotion created a new Foundry agent version.")
  created_new_version: boolean;
}

@doc("Response body for POST /candidates/{id}:promote.")
model PromoteAgentOptimizationCandidateResponse {
  @doc("Server-assigned candidate identifier that was promoted.")
  candidate_id: string;

  @doc("Timestamp when promotion occurred, represented in Unix time.")
  promoted_at: FoundryTimestamp;

  @doc("Name of the Foundry agent associated with the recorded promotion.")
  agent_name: string;

  @doc("Version of the Foundry agent created or associated with the promotion. Omitted when no version was created or recorded.")
  agent_version?: string;

  @doc("Whether a new agent version was created during promotion.")
  created_new_version: boolean;
}
