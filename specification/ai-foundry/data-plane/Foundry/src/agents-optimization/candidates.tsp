// Candidate models for the AgentsOptimization data-plane surface (v1 GA).

import "./inputs.tsp";
import "./skill-results.tsp";
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

  @doc("Candidate processing completed, including evaluation when applicable.")
  completed: "completed",

  @doc("The optimizer stopped before this candidate completed.")
  failed: "failed",

  @doc("Required input was unavailable, so skill optimization did not run.")
  skipped: "skipped",
}

@doc("Base candidate output. Job types define derived output models with their own fields.")
@discriminator("type")
model AgentOptimizationCandidateOutput {
  @doc("Output type matching the parent job's optimization type. Additional types may be added in future API versions.")
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

@doc("Output of the single generated candidate produced by trace-driven skill optimization. It can contain zero or more independent skill outcomes. Optional reporting-only evaluation reuses a baseline candidate and each candidate's evaluation summary; the baseline is not a generated alternative.")
model AgentOptimizationSkillCandidateOutput
  extends AgentOptimizationCandidateOutput {
  @doc("Skill optimization output discriminator.")
  type: AgentOptimizationConfigurationType.skill_optimization;

  @doc("Independent proposed skill outcomes. A completed empty array means no changes were proposed, for example because there were no new learnings; no new versions are published in that case. Discovered but untouched skills do not require outcomes. Populated on candidate GET when available and omitted from LIST summaries.")
  skill_results?: AgentOptimizationSkillResult[];
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

@doc("Comparative evaluation summary for a candidate.")
model AgentOptimizationCandidateEvaluation {
  @doc("Average composite score across evaluated tasks. Omitted until scoring produces an aggregate score.")
  score?: float64;

  @doc("Average total tokens consumed per task. Omitted when token usage was not measured.")
  avg_tokens?: float64;

  @doc("Average end-to-end latency per task, rounded to milliseconds.")
  avg_latency_ms?: FoundryDurationMilliseconds;

  @doc("Foundry evaluation identifier used to score this candidate. Omitted when unavailable.")
  eval_id?: string;

  @doc("Foundry evaluation run identifier used to score this candidate. Omitted when unavailable.")
  eval_run_id?: string;

  @doc("Timestamp when full candidate evaluation completed, represented in Unix time. Omitted when unavailable.")
  completed_at?: FoundryTimestamp;
}

/** Metadata for an artifact generated for an optimization candidate. */
model AgentOptimizationCandidateFile {
  @doc("Candidate-relative artifact path, not a local filesystem path or a download URL.")
  @minLength(1)
  path: string;

  @doc("Artifact category, for example trace_analysis. Additional categories may be returned.")
  @minLength(1)
  type: string;

  @doc("Artifact size in bytes.")
  @minValue(0)
  size_in_bytes: int64;
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

  @doc("Primary failure or skip reason. Omitted for other candidate statuses.")
  error?: ApiError;

  @doc("Timestamp when work on this candidate slot began, represented in Unix time.")
  started_at: FoundryTimestamp;

  @doc("Typed output generated for this candidate. The output type matches the parent job's optimization type. Omitted until output is available.")
  output?: AgentOptimizationCandidateOutput;

  @doc("Persisted skill execution snapshot, including partial outcomes. Populated on candidate GET when available and omitted from LIST.")
  execution_summary?: AgentOptimizationSkillExecutionSummary;

  @doc("Frozen trace cohort and discovered agent skills for skill optimization. Populated on candidate GET when available and omitted from LIST.")
  resolved_context?: AgentOptimizationSkillResolvedContext;

  @doc("Human-readable explanation of why the optimizer produced this candidate. Populated on candidate GET when available and omitted from LIST.")
  rationale?: string;

  @doc("Metadata for files generated for this candidate, such as trace analysis. Populated on candidate GET when available and omitted from LIST. An empty list means no files were generated; omission means the inventory is not available. Metadata does not provide file content or a download URL.")
  files?: AgentOptimizationCandidateFile[];

  @doc("Foundry agent version associated with this candidate. Omitted when no temporary or evaluated agent version was created.")
  agent_version?: string;

  @doc("Evaluation summary, including reporting-only measurements for skill baseline and generated candidates. Omitted when no measurements are available. Missing scores do not imply success or zero.")
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
