// Input models for the AgentsOptimization data-plane surface (v1 GA).

import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "../skills/models.tsp";
// Only shared evaluation types are needed; the full models import also pulls in Data Generation Jobs.
import "../openai/evaluations/common.tsp";
import "../openai/evaluations/user_conversation_simulation.tsp";
import "@azure-tools/openai-typespec/models/chat";

using TypeSpec.Rest;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Input enums / unions
// ---------------------------------------------------------------------------

/** Agent attribute that can be optimized. */
union TargetAttribute {
  string,

  @doc("Rewrites agent instructions.")
  instructions: "instructions",

  @doc("Model selection from optimization_configuration.agent_optimization_space.model_search_space.")
  `model`: "model",

  @doc("Generates or modifies agent skill descriptions and bodies.")
  skills: "skills",

  @doc("Optimizes function tool descriptions and parameter descriptions.")
  tools: "tools",
}

/** Goal for an agent-optimization job. */
union AgentOptimizationGoal {
  string,

  @doc("Search for agent configurations that improve measured evaluation quality.")
  improve_quality: "improve_quality",
}

// ---------------------------------------------------------------------------
// Evaluation set input — row semantics and source are discriminated independently
// ---------------------------------------------------------------------------

/** Logical row formats supported by optimization evaluation sets. */
union AgentOptimizationEvaluationSetType {
  string,

  @doc("Independent single-turn queries evaluated against each candidate.")
  target_completion: "target_completion",

  @doc("Scenarios used to simulate conversations against each candidate.")
  user_conversation_simulation: "user_conversation_simulation",
}

/** Base discriminated model for an optimization evaluation set. */
@discriminator("type")
model AgentOptimizationEvaluationSet {
  @doc("Logical format of the evaluation set rows.")
  type: AgentOptimizationEvaluationSetType;
}

/** Evaluation set containing independent single-turn inputs. */
model AgentOptimizationTargetCompletionEvaluationSet
  extends AgentOptimizationEvaluationSet {
  @doc("Target-completion set discriminator.")
  type: AgentOptimizationEvaluationSetType.target_completion;

  @doc("Inline test cases or an explicitly versioned registered Foundry dataset.")
  source: AgentOptimizationTargetCompletionDataSource;
}

/** Evaluation set containing scenarios for simulated conversations. */
model AgentOptimizationUserConversationSimulationEvaluationSet
  extends AgentOptimizationEvaluationSet {
  @doc("User-conversation-simulation set discriminator.")
  type: AgentOptimizationEvaluationSetType.user_conversation_simulation;

  @doc("Inline test cases or an explicitly versioned registered Foundry dataset.")
  source: AgentOptimizationUserConversationSimulationDataSource;

  @doc("Defaults applied to every scenario. A test case's simulation_configuration overrides corresponding properties.")
  default_simulation_configuration?: UserConversationSimulationConfiguration;
}

/** Source types supported by optimization evaluation sets. */
union AgentOptimizationDataSourceType {
  string,

  @doc("Test cases supplied directly in the optimization request.")
  inline: "inline",

  @doc("An explicitly versioned registered Foundry dataset.")
  dataset_reference: "dataset_reference",
}

/** Base source for a target-completion optimization evaluation set. */
@discriminator("type")
model AgentOptimizationTargetCompletionDataSource {
  @doc("Target-completion source type. Additional types may be added in future API versions.")
  type: AgentOptimizationDataSourceType;
}

/** Base source for a user-conversation-simulation optimization evaluation set. */
@discriminator("type")
model AgentOptimizationUserConversationSimulationDataSource {
  @doc("User-conversation-simulation source type. Additional types may be added in future API versions.")
  type: AgentOptimizationDataSourceType;
}

/** Supplies single-turn rows directly in the optimization request. */
model AgentOptimizationTargetCompletionInlineDataSource
  extends AgentOptimizationTargetCompletionDataSource {
  @doc("Inline source discriminator.")
  type: AgentOptimizationDataSourceType.inline;

  @doc("Target-completion test cases.")
  @minItems(1)
  @maxItems(2000)
  test_cases: AgentOptimizationTargetCompletionTestCase[];
}

/** Supplies Evals user-conversation simulation test cases directly in the optimization request. */
model AgentOptimizationUserConversationSimulationInlineDataSource
  extends AgentOptimizationUserConversationSimulationDataSource {
  @doc("Inline source discriminator.")
  type: AgentOptimizationDataSourceType.inline;

  @doc("Conversation test scenarios.")
  @minItems(1)
  @maxItems(2000)
  test_cases: UserConversationSimulationTestCase[];
}

/** References an explicitly versioned registered Foundry dataset for target-completion evaluation. */
model AgentOptimizationTargetCompletionDatasetReferenceDataSource
  extends AgentOptimizationTargetCompletionDataSource {
  @doc("Registered dataset source discriminator.")
  type: AgentOptimizationDataSourceType.dataset_reference;

  @doc("Registered dataset name.")
  @minLength(1)
  name: string;

  @doc("Registered dataset version.")
  @minLength(1)
  version: string;
}

/** References an explicitly versioned registered Foundry dataset for user-conversation-simulation evaluation. */
model AgentOptimizationUserConversationSimulationDatasetReferenceDataSource
  extends AgentOptimizationUserConversationSimulationDataSource {
  @doc("Registered dataset source discriminator.")
  type: AgentOptimizationDataSourceType.dataset_reference;

  @doc("Registered dataset name.")
  @minLength(1)
  name: string;

  @doc("Registered dataset version.")
  @minLength(1)
  version: string;
}

/** A single item in an inline evaluation set. */
model AgentOptimizationTargetCompletionTestCase {
  @doc("The user query / prompt.")
  @minLength(1)
  query: string;

  @doc("Expected ground truth answer. Omitted when no ground truth is supplied.")
  ground_truth?: string;
}

// ---------------------------------------------------------------------------
// Evaluator reference
// ---------------------------------------------------------------------------

/** Reference to a named evaluator, optionally pinned to a version. */
model AgentOptimizationEvaluator {
  @doc("Evaluator name.")
  @minLength(1)
  name: string;

  @doc("Evaluator version. Omitted to use the latest version.")
  @minLength(1)
  version?: string;

  @doc("Parameters passed to the evaluator at initialization. Omitted when the evaluator requires no initialization parameters.")
  initialization_parameters?: Record<unknown>;
}

// ---------------------------------------------------------------------------
// Input models
// ---------------------------------------------------------------------------

@doc("A non-empty Foundry model name or existing deployment name.")
@minLength(1)
scalar AgentOptimizationModelName extends string;

/** Target configuration types supported by optimization jobs. */
union AgentOptimizationTargetConfigurationType {
  string,

  @doc("A registered Foundry agent.")
  foundry_agent: "foundry_agent",
}

@doc("Base target configuration for an optimization job.")
@discriminator("type")
model AgentOptimizationTargetConfiguration {
  @doc("Target configuration type. Additional types may be added in future API versions.")
  type: AgentOptimizationTargetConfigurationType;
}

@doc("Identifies the Foundry agent that owns the configuration being optimized.")
model AgentOptimizationFoundryAgentTargetConfiguration
  extends AgentOptimizationTargetConfiguration {
  @doc("Foundry-agent target discriminator.")
  type: AgentOptimizationTargetConfigurationType.foundry_agent;

  @doc("Registered Foundry agent name.")
  @minLength(1)
  @maxLength(256)
  name: string;

  @doc("Pinned agent version. Omitted to resolve and pin the latest version.")
  @minLength(1)
  version?: string;
}

@doc("Identifies a model used by an optimization or evaluation step.")
model AgentOptimizationModelConfiguration {
  @doc("Model name or existing deployment name in the Foundry project.")
  `model`: AgentOptimizationModelName;
}

@doc("A skill in the manually supplied agent optimization surface.")
model AgentOptimizationSkill {
  @doc("Stable skill name.")
  @minLength(1)
  name: string;

  @doc("Short description used for skill discovery and progressive disclosure.")
  @minLength(1)
  description: string;

  @doc("Skill instructions or content that may be optimized. Omitted when the skill has no body.")
  body?: string;
}

@doc("Caller-supplied baseline agent values that cannot be resolved from the target agent.")
model AgentOptimizationBaselineAgentConfiguration {
  @doc("Caller-supplied baseline system prompt. Omitted to resolve the baseline from the target; a prompt agent's stored definition is authoritative.")
  system_prompt?: string;

  @doc("Current model name. An existing deployment name is also accepted. Omitted to resolve the model from the target.")
  current_model?: AgentOptimizationModelName;

  @doc("Skills available for optimization. Omitted when no manual skill surface is supplied.")
  skills?: AgentOptimizationSkill[];

  @doc("Function tools available for optimization. Omitted when no manual tool surface is supplied. The optimizer may change function and argument descriptions while preserving names and parameter JSON Schema.")
  tools?: OpenAI.ChatCompletionTool[];
}

@doc("The agent attributes and alternative values available to an agent-optimization search.")
model AgentOptimizationSpace {
  @doc("Agent attributes the optimizer may change. If omitted, the service defaults to instructions.")
  @minItems(1)
  target_attributes?: TargetAttribute[] = #[TargetAttribute.instructions];

  @doc("Alternative model names or existing deployment names available when model is an optimization target.")
  @minItems(1)
  model_search_space?: AgentOptimizationModelName[];
}

/** Candidate search settings. */
model AgentOptimizationCandidateSearchConfiguration {
  @doc("Maximum number of non-baseline candidates to fully evaluate. If omitted, the service defaults to 1.")
  @minValue(1)
  @maxValue(200)
  max_candidates?: int32 = 1;
}

/** Shared evaluation inputs for agent and skill optimization. All fields are optional in the schema; the service validates required combinations for the selected optimization type and rejects invalid requests. */
model AgentOptimizationEvaluationConfiguration {
  @doc("Required by the service for agent optimization to guide the search. Not accepted for skill optimization, where evaluation is reporting-only. Inline data supports up to 2,000 test cases when a separate validation set is supplied; otherwise it is also used for validation and is limited to 500.")
  training_set?: AgentOptimizationEvaluationSet;

  @doc("Held-out evaluation set used for full candidate evaluation, limited to 500 inline test cases. Agent optimization reuses training_set when omitted. Skill evaluation requires a caller-supplied validation_set, reused unchanged for the baseline and learned candidate; the service rejects omission rather than generating a dataset from traces.")
  validation_set?: AgentOptimizationEvaluationSet;

  @doc("Existing evaluator references. Required by the service for agent optimization. Skill evaluation requires these references, evaluator_generation_configuration, or both; when both are supplied, use their combined evaluator set. After skill evaluation preparation, contains the resolved exact versions used unchanged for baseline and learned-candidate evaluation.")
  @minItems(1)
  @maxItems(20)
  evaluators?: AgentOptimizationEvaluator[];

  @doc("Model configuration used by model-based evaluators and conversation simulation. Required by the service for agent optimization and when skill evaluation is requested.")
  evaluation_model?: EvaluationModelConfiguration;

  @doc("Maximum number of target-agent runs executed concurrently during each single-turn evaluation. If omitted, the service defaults to 1. Conversation evaluation supports only 1.")
  @minValue(1)
  @maxValue(10)
  max_concurrent_agent_runs?: int32 = 1;

  @doc("Opt-in creation of evaluators for skill optimization using the job's optimization_model_configuration, not evaluation_model. No separate generation model is accepted. Resolved exact versions are returned in evaluators after preparation. Not accepted for agent optimization; use existing evaluator references there.")
  evaluator_generation_configuration?: AgentOptimizationEvaluatorGenerationConfiguration;
}

/** Optimization job configuration types. */
union AgentOptimizationConfigurationType {
  string,

  @doc("Comparative agent optimization that can generate multiple candidates within configured search limits.")
  agent_optimization: "agent_optimization",

  @doc("One-shot prompt optimization that generates a single candidate.")
  prompt_optimization: "prompt_optimization",

  @doc("Generates a single candidate containing zero or more skill outcomes from trace evidence, with optional reporting-only evaluation recorded on baseline and learned candidates.")
  skill_optimization: "skill_optimization",
}

/** Base model for type-specific optimization configuration. */
@discriminator("type")
model AgentOptimizationConfigurationBase {
  @doc("Optimization type discriminator.")
  type: AgentOptimizationConfigurationType;
}

@doc("Configuration for optimizing an agent for measured quality.")
model AgentOptimizationConfiguration
  extends AgentOptimizationConfigurationBase {
  @doc("Optimization type discriminator.")
  type: AgentOptimizationConfigurationType.agent_optimization;

  @doc("Optimization goal. If omitted, the service defaults to improve_quality.")
  goal?: AgentOptimizationGoal = AgentOptimizationGoal.improve_quality;

  @doc("Quality measurement configuration.")
  evaluation_configuration: AgentOptimizationEvaluationConfiguration;

  @doc("Configuration for candidate search and screening.")
  candidate_search_configuration: AgentOptimizationCandidateSearchConfiguration;

  @doc("Caller-supplied baseline agent configuration. Omitted when all baseline values can be resolved from the target agent.")
  baseline_agent_configuration?: AgentOptimizationBaselineAgentConfiguration;

  @doc("Agent attributes and alternatives available to the search.")
  agent_optimization_space: AgentOptimizationSpace;
}

/** Type of context supplied to an optimization workflow. */
union OptimizationContextType {
  string,

  @doc("Natural-language guidance that steers the desired optimization.")
  steering_prompt: "steering_prompt",

  @doc("Agent trace evidence selected from project-authorized telemetry.")
  agent_traces: "agent_traces",

  @doc("Exact baseline skill references for skill optimization.")
  skill_references: "skill_references",
}

/** Base model for typed optimization context. */
@discriminator("type")
model OptimizationContext {
  @doc("Optimization context type discriminator.")
  type: OptimizationContextType;
}

/** Natural-language guidance for the desired optimization. */
model SteeringPromptOptimizationContext extends OptimizationContext {
  @doc("Optimization context type discriminator.")
  type: OptimizationContextType.steering_prompt;

  @doc("Developer guidance describing the desired changes, from 1 to 102,400 characters. Maximum UTF-8 encoded size is 100 KiB (102,400 bytes), enforced by the service. The character limit is an additional bound, not a substitute for UTF-8 byte-size validation.")
  @minLength(1)
  @maxLength(102400)
  prompt: string;
}

@doc("Configuration for a one-shot prompt transformation without comparative evaluation.")
model PromptOptimizationConfiguration
  extends AgentOptimizationConfigurationBase {
  @doc("Optimization type discriminator.")
  type: AgentOptimizationConfigurationType.prompt_optimization;

  @doc("Steering context for prompt optimization. Agent trace and skill reference context are supported only by skill optimization. Omitted when no context is supplied.")
  @minItems(1)
  context?: SteeringPromptOptimizationContext[];
}

/** Exact reference to an existing skill version in the job's project. */
model AgentOptimizationFoundrySkillReference {
  @doc("Registered Foundry skill reference discriminator.")
  type: "foundry_skill";

  @doc("Registered skill name, from 1 to 64 characters, following the shared skill naming rules.")
  @minLength(1)
  name: SkillName;

  @doc("Non-empty opaque pinned version. The aliases latest and default are not accepted.")
  @minLength(1)
  version: string;
}

/** Explicit exact-version baselines for skill optimization. */
model SkillReferencesOptimizationContext extends OptimizationContext {
  @doc("Skill reference context discriminator.")
  type: OptimizationContextType.skill_references;

  @doc("Exact skill versions combined with skills discovered from Prompt or Managed targets, including toolboxes. References across context items and discovered skills are deduplicated. Without a target these are the only baselines; an empty effective inventory permits creation from selected traces. An empty list supplies no explicit baselines.")
  skill_references: AgentOptimizationFoundrySkillReference[];
}

/** Project-authorized trace providers for skill optimization. */
union AgentOptimizationTraceConnectionType {
  string,

  /** A project-linked Application Insights component. */
  appinsights: "appinsights",
}

/** Explicit project-authorized telemetry selection, not an arbitrary endpoint. */
@discriminator("type")
model AgentOptimizationTraceConnectionConfiguration {
  @doc("Trace provider discriminator.")
  type: AgentOptimizationTraceConnectionType;
}

/** Selects a project-linked Application Insights component. */
model AgentOptimizationAppInsightsTraceConnectionConfiguration
  extends AgentOptimizationTraceConnectionConfiguration {
  @doc("Application Insights provider discriminator.")
  type: AgentOptimizationTraceConnectionType.appinsights;

  @doc("Non-empty ARM component resource ID of an Application Insights connection linked to this project. Invalid or unavailable explicit configuration must fail rather than fall back.")
  @minLength(1)
  resource_id: string;

  @doc("Required without target_configuration and omitted with a target agent. From 1 to 256 characters. Exact, case-sensitive AppRoleName or cloud_RoleName, including any emitted OpenTelemetry namespace prefix. This is a telemetry service identity, not a Foundry agent reference. No surrounding whitespace, wildcards, or KQL.")
  @minLength(1)
  @maxLength(256)
  agent_name?: string;
}

/** Trace selection strategies for skill optimization. */
union AgentOptimizationTraceWindowType {
  string,

  /** A completed, half-open time interval. */
  fixed: "fixed",

  /** Proposed explicit trace-ID selection; service support is TBD. */
  trace_ids: "trace_ids",
}

/** Trace selection window for a one-time skill optimization job. */
@discriminator("type")
model AgentOptimizationTraceWindow {
  @doc("Trace window discriminator.")
  type: AgentOptimizationTraceWindowType;
}

/** Selects recent trace conversations in a completed past half-open interval, preferring traces with annotations or evaluation results. */
model AgentOptimizationFixedTraceWindow extends AgentOptimizationTraceWindow {
  @doc("Fixed-window discriminator.")
  type: AgentOptimizationTraceWindowType.fixed;

  @doc("Inclusive UTC Unix timestamp in seconds. Must precede end_time and be in the past. The service validates the interval at submission.")
  start_time: FoundryTimestamp;

  @doc("Exclusive UTC Unix timestamp in seconds. Must be at or before job submission time, forming a completed past interval. The service rejects future windows rather than waiting or clamping timestamps.")
  end_time: FoundryTimestamp;

  @doc("Maximum number of trace conversations to select, from 1 to 100 inclusive. If omitted, the service defaults to 100. Select the latest matching traces, giving preference to those with human annotations, evaluation results, or both. Traces without feedback remain eligible.")
  @minValue(1)
  @maxValue(100)
  max_traces?: int32 = 100;
}

/** Proposed explicit trace-ID selection. Service support and detailed lookup behavior are TBD; this contract does not establish runtime availability. */
model AgentOptimizationTraceIdsTraceWindow
  extends AgentOptimizationTraceWindow {
  @doc("Explicit trace-ID selection discriminator. Service support is TBD.")
  type: AgentOptimizationTraceWindowType.trace_ids;

  @doc("At least one explicit trace identifier to look up within the configured telemetry source. Service support, maximum list size, duplicate handling, and missing-ID behavior are TBD.")
  @minItems(1)
  trace_ids: string[];

  @doc("Requested telemetry lookup horizon, at least 1 hour. Service support, the lookback anchor, and maximum supported horizon are TBD.")
  @minValue(1)
  lookback_hours: int32;
}

/** Trace evidence for skill optimization, selected independently of feedback availability. */
model AgentTracesOptimizationContext extends OptimizationContext {
  @doc("Agent trace context discriminator.")
  type: OptimizationContextType.agent_traces;

  @doc("Explicit telemetry selection. Required without a target agent. When omitted with a target, use its project-linked telemetry. Not accepted on steering_prompt context.")
  trace_connection_configuration?: AgentOptimizationTraceConnectionConfiguration;

  @doc("Trace selection: a fixed half-open window, or proposed explicit trace_ids selection whose service support is TBD.")
  trace_window: AgentOptimizationTraceWindow;
}

/** Evidence sources for generating skill-optimization evaluators. */
union AgentOptimizationEvaluatorGenerationSourceType {
  string,

  /** The job's selected agent trace evidence. */
  agent_traces: "agent_traces",
}

/** Base configuration for service-generated optimization evaluators. Currently supported for skill optimization only. Uses the job's optimization_model_configuration; no separate generation model is accepted. */
@discriminator("type")
model AgentOptimizationEvaluatorGenerationConfiguration {
  @doc("Evaluator generation source discriminator.")
  type: AgentOptimizationEvaluatorGenerationSourceType;

  @doc("Additional instructions or context to guide evaluator generation from the selected source.")
  prompt?: string;
}

/** Generates evaluators from the job's selected trace evidence. */
model AgentOptimizationTraceEvaluatorGenerationConfiguration
  extends AgentOptimizationEvaluatorGenerationConfiguration {
  @doc("Generate evaluators from the agent_traces context.")
  type: AgentOptimizationEvaluatorGenerationSourceType.agent_traces;
}

/** Configuration for generating a single skill candidate from trace evidence. The candidate can contain zero or more skill outcomes; no new learnings can produce an empty skill_results array without publishing versions. Optional evaluation reuses a non-generated baseline candidate. */
model SkillOptimizationConfiguration
  extends AgentOptimizationConfigurationBase {
  @doc("Skill optimization discriminator.")
  type: AgentOptimizationConfigurationType.skill_optimization;

  @doc("At least one context item containing trace evidence, optional steering guidance, and optional exact baseline references. Supply agent_traces context; use separate steering_prompt and skill_references items for guidance and baselines.")
  @minItems(1)
  context: OptimizationContext[];

  @doc("Optional before/after evaluation using the shared evaluation configuration. The service requires target_configuration, validation_set, evaluation_model, and existing evaluators or evaluator_generation_configuration. Training sets are not accepted. Evaluate the same pinned target with baseline skills and proposed skills using the same validation set and resolved evaluator versions. Scores do not guide generation, ranking, selection, or publication. Omitted to skip performance evaluation.")
  evaluation_configuration?: AgentOptimizationEvaluationConfiguration;
}

@doc("Inputs for estimating an agent-optimization job.")
model AgentOptimizationEstimateInputs {
  @doc("Foundry agent whose configuration would be optimized. Omitted when the workflow does not target a registered Foundry agent.")
  target_configuration?: AgentOptimizationTargetConfiguration;

  @doc("Model that would generate candidate changes. An existing deployment name is also accepted.")
  optimization_model_configuration: AgentOptimizationModelConfiguration;

  @doc("Agent-optimization configuration to estimate.")
  optimization_configuration: AgentOptimizationConfiguration;
}

@doc("A low/typical/ceiling range for an estimated quantity. Cost values apply average per-call usage assumptions to each call-count scenario. Expected values may be fractional, including estimated model-call counts.")
model AgentOptimizationEstimateBand {
  @doc("Lower estimate based on model calls required for every run.")
  low: float64;

  @doc("Expected estimate based on model calls consumed by a typical run.")
  typical: float64;

  @doc("Upper bound calculated from the maximum number of model calls.")
  ceiling: float64;
}

@doc("Estimated values grouped by optimization stage.")
model AgentOptimizationStageEstimate {
  @doc("Estimated values for calls made by the agent being optimized.")
  agent?: AgentOptimizationEstimateBand;

  @doc("Estimated values for calls that evaluate candidate quality.")
  evaluation?: AgentOptimizationEstimateBand;

  @doc("Estimated values for calls that generate candidate changes.")
  optimization?: AgentOptimizationEstimateBand;
}

@doc("Estimated monetary cost. Present only when at least one contributing model has pricing data.")
model AgentOptimizationCostEstimate {
  @doc("ISO 4217 currency code for all monetary values in this estimate.")
  currency: string = "USD";

  @doc("Total estimated cost across all priced stages.")
  total?: AgentOptimizationEstimateBand;

  @doc("Estimated cost grouped by optimization stage.")
  by_stage?: AgentOptimizationStageEstimate;

  @doc("Stages excluded from the total because pricing was unavailable.")
  unpriced_stages?: AgentOptimizationStage[];
}

@doc("Result returned when estimating an agent-optimization job.")
model AgentOptimizationEstimateResult {
  @doc("Estimated model-call counts grouped by optimization stage. Typical values are calibrated expectations and may be fractional.")
  call_counts?: AgentOptimizationStageEstimate;

  @doc("Estimated monetary cost. Omitted when no contributing model has pricing data.")
  cost?: AgentOptimizationCostEstimate;

  @doc("Timestamp of the pricing snapshot used for cost estimation, represented in Unix time. Omitted when no valid pricing snapshot is available.")
  prices_as_of?: FoundryTimestamp;
}
