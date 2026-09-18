// Input models for the AgentsOptimization data-plane surface (v1 GA).

import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "../openai/evaluations/models.tsp";
import "@azure-tools/openai-typespec/models/chat";

using TypeSpec.Rest;
using TypeSpec.OpenAPI;

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
union AgentOptimizationSetInputType {
  string,

  @doc("Independent single-turn queries evaluated against each candidate.")
  target_completion: "target_completion",

  @doc("Scenarios used to simulate conversations against each candidate.")
  user_conversation_simulation: "user_conversation_simulation",
}

/** Base discriminated model for an optimization evaluation set. */
@discriminator("type")
model AgentOptimizationSetInput {
  @doc("Logical format of the evaluation set rows.")
  type: AgentOptimizationSetInputType;
}

/** Evaluation set containing independent single-turn inputs. */
model AgentOptimizationTargetCompletionSetInput
  extends AgentOptimizationSetInput {
  @doc("Target-completion set discriminator.")
  type: AgentOptimizationSetInputType.target_completion;

  @doc("Inline test cases or an explicitly versioned registered Foundry dataset.")
  source: AgentOptimizationTargetCompletionSetSource;
}

/** Evaluation set containing scenarios for simulated conversations. */
model AgentOptimizationUserConversationSimulationSetInput
  extends AgentOptimizationSetInput {
  @doc("User-conversation-simulation set discriminator.")
  type: AgentOptimizationSetInputType.user_conversation_simulation;

  @doc("Inline test cases or an explicitly versioned registered Foundry dataset.")
  source: AgentOptimizationUserConversationSimulationSetSource;

  @doc("Defaults applied to every scenario. A test case's simulation_configuration overrides corresponding properties.")
  default_simulation_configuration?: UserConversationSimulationConfiguration;
}

/** Supplies single-turn rows directly in the optimization request. */
model AgentOptimizationTargetCompletionInlineSetSource {
  @doc("Inline source discriminator.")
  type: "inline";

  @doc("Target-completion test cases.")
  @minItems(1)
  @maxItems(2000)
  test_cases: AgentOptimizationTargetCompletionTestCase[];
}

/** Supplies Evals user-conversation simulation test cases directly in the optimization request. */
model AgentOptimizationUserConversationSimulationInlineSetSource {
  @doc("Inline source discriminator.")
  type: "inline";

  @doc("Conversation test scenarios.")
  @minItems(1)
  @maxItems(2000)
  test_cases: UserConversationSimulationTestCase[];
}

/** References an explicitly versioned registered Foundry dataset. */
model AgentOptimizationReferenceDatasetSource {
  @doc("Registered dataset source discriminator.")
  type: "reference";

  @doc("Registered dataset name.")
  @minLength(1)
  name: string;

  @doc("Registered dataset version.")
  @minLength(1)
  version: string;
}

/** Source for a target-completion optimization evaluation set. */
union AgentOptimizationTargetCompletionSetSource {
  inline: AgentOptimizationTargetCompletionInlineSetSource,
  reference: AgentOptimizationReferenceDatasetSource,
}

/** Source for a user-conversation-simulation optimization evaluation set. */
union AgentOptimizationUserConversationSimulationSetSource {
  inline: AgentOptimizationUserConversationSimulationInlineSetSource,
  reference: AgentOptimizationReferenceDatasetSource,
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

@doc("Identifies the Foundry agent that owns the configuration being optimized.")
model AgentOptimizationTargetConfiguration {
  @doc("Target type discriminator.")
  type: "foundry_agent";

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
  @doc("Agent attributes the optimizer may change. Defaults to instructions when omitted.")
  @minItems(1)
  target_attributes?: TargetAttribute[] = #[TargetAttribute.instructions];

  @doc("Alternative model names or existing deployment names available when model is an optimization target.")
  @minItems(1)
  model_search_space?: AgentOptimizationModelName[];
}

/** Candidate search settings. */
model AgentOptimizationCandidateSearchConfiguration {
  @doc("Maximum number of non-baseline candidates to fully evaluate. Defaults to 2 when omitted.")
  @minValue(1)
  @maxValue(200)
  max_candidates?: int32 = 2;

  @doc("Number of training-set rows sampled to screen each proposed candidate before full validation. Defaults to 3 when omitted.")
  @minValue(1)
  @maxValue(100)
  candidate_screening_sample_size?: int32 = 3;

  @doc("Maximum number of consecutive proposed candidates that may fail screening before the search stops early. Defaults to 5 when omitted.")
  @minValue(1)
  @maxValue(50)
  max_consecutive_failed_candidate_screens?: int32 = 5;
}

/** Reusable quality-measurement configuration. */
model AgentOptimizationEvaluationConfiguration {
  @doc("Evaluation set used to guide the optimization search. Inline data supports up to 2,000 test cases when a separate validation set is supplied; otherwise it is also used for validation and is limited to 500.")
  training_set: AgentOptimizationSetInput;

  @doc("Held-out evaluation set used for full candidate evaluation, limited to 500 inline test cases. The training set is reused and subject to the same 500-test-case validation limit when omitted.")
  validation_set?: AgentOptimizationSetInput;

  @doc("Evaluator references used to score candidate quality.")
  @minItems(1)
  @maxItems(20)
  evaluators: AgentOptimizationEvaluator[];

  @doc("Model configuration used by model-based evaluators and conversation simulation.")
  evaluation_model: EvaluationModelConfiguration;

  @doc("Maximum number of target-agent runs executed concurrently during each single-turn evaluation. Defaults to 1 when omitted. Conversation evaluation supports only 1.")
  @minValue(1)
  @maxValue(10)
  max_concurrent_agent_runs?: int32;
}

/** Base model for type-specific optimization configuration. */
@discriminator("type")
model AgentOptimizationConfigurationBase {
  @doc("Optimization type discriminator.")
  type: string;
}

@doc("Configuration for optimizing an agent for measured quality.")
model AgentOptimizationConfiguration
  extends AgentOptimizationConfigurationBase {
  @doc("Optimization type discriminator.")
  type: "agent_optimization";

  @doc("Optimization goal. Defaults to improve_quality when omitted.")
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

  @doc("Developer guidance describing the desired changes.")
  @minLength(1)
  prompt: string;
}

@doc("Configuration for a one-shot prompt transformation without comparative evaluation.")
model PromptOptimizationConfiguration
  extends AgentOptimizationConfigurationBase {
  @doc("Optimization type discriminator.")
  type: "prompt_optimization";

  @doc("Context used to steer prompt optimization. Omitted when no context is supplied.")
  @minItems(1)
  context?: OptimizationContext[];
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

@doc("A low/typical/ceiling range for an estimated quantity. Expected values may be fractional, including estimated model-call counts.")
model AgentOptimizationEstimateBand {
  @doc("Lower bound.")
  low: float64;

  @doc("Central estimate.")
  typical: float64;

  @doc("Upper bound.")
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

@doc("Response body for :estimate.")
model AgentOptimizationEstimateResponse {
  @doc("Validation-set size (in rows) the estimate was computed against. This is the server-resolved input used by the estimator; useful for clients that did not supply or know the row count when validation_set was passed as a registered dataset reference.")
  validation_set_rows: int32;

  @doc("Estimated model-call counts grouped by optimization stage. Typical values are calibrated expectations and may be fractional.")
  call_counts?: AgentOptimizationStageEstimate;

  @doc("Estimated monetary cost. Omitted when no contributing model has pricing data.")
  cost?: AgentOptimizationCostEstimate;

  @doc("Timestamp of the pricing snapshot used for cost estimation, represented in Unix time. Omitted when no valid pricing snapshot is available.")
  prices_as_of?: FoundryTimestamp;
}
