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

  @doc("Instruction-tuning — rewrites agent system prompts.")
  instruction: "instruction",

  @doc("Model-selection — evaluates deployments from optimization_configuration.agent_optimization_space.model_search_space.")
  `model`: "model",

  @doc("Skill-tuning — generates or modifies agent skill descriptions.")
  skill: "skill",

  @doc("Tool-tuning — optimizes function tool descriptions and parameter descriptions.")
  tool: "tool",
}

/** Goal for an agent-optimization job. */
union AgentOptimizationGoal {
  string,

  @doc("Search for agent configurations that improve measured evaluation quality.")
  improve_quality: "improve_quality",

  @doc("Search for lower-cost model configurations. A lower-cost candidate is selected only when it satisfies service-managed measurement and savings thresholds and does not regress aggregate quality, overall pass rate, or any evaluator pass rate; otherwise the baseline remains selected.")
  reduce_cost: "reduce_cost",
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

/** Base model for dataset inputs that are valid for held-out validation. */
@discriminator("type")
model AgentOptimizationValidationDatasetInput
  extends AgentOptimizationDatasetInput {}

/** Inline dataset — items supplied directly in the request body. */
model AgentOptimizationInlineDatasetInput
  extends AgentOptimizationValidationDatasetInput {
  @doc("Dataset input type discriminator.")
  type: AgentOptimizationDatasetInputType.inline;

  @doc("Dataset items.")
  @minItems(1)
  items: AgentOptimizationDatasetItem[];
}

/** Reference to a registered Foundry dataset. */
model AgentOptimizationReferenceDatasetInput
  extends AgentOptimizationValidationDatasetInput {
  @doc("Dataset input type discriminator.")
  type: AgentOptimizationDatasetInputType.reference;

  @doc("Registered dataset name.")
  @minLength(1)
  name: string;

  @doc("Dataset version. Omitted to use the latest version.")
  @minLength(1)
  version?: string;

  @doc("Originating data-generation job identifier. Omitted when the dataset was not resolved from a generation job.")
  @visibility(Lifecycle.Read)
  data_generation_job_id?: string;

  @doc("Current status of the originating data-generation job. Omitted when the dataset was not resolved from a generation job.")
  @visibility(Lifecycle.Read)
  data_generation_job_status?: JobStatus;

  @doc("Failure from the originating data-generation job. Omitted unless generation failed.")
  @visibility(Lifecycle.Read)
  error?: ApiError;
}

/** Reference to a data-generation job whose output is used as the training dataset. Once resolved, responses use the reference dataset variant and retain the generation job ID, status, and error as provenance. */
model AgentOptimizationGenerationJobReferenceDatasetInput
  extends AgentOptimizationDatasetInput {
  @doc("Dataset input type discriminator.")
  type: AgentOptimizationDatasetInputType.generation_job_reference;

  @doc("Identifier of the data-generation job to await and resolve.")
  @minLength(1)
  data_generation_job_id: string;

  @doc("Current status of the referenced data-generation job. Omitted before status is available.")
  @visibility(Lifecycle.Read)
  data_generation_job_status?: JobStatus;

  @doc("Failure from the referenced data-generation job. Omitted unless generation failed.")
  @visibility(Lifecycle.Read)
  error?: ApiError;
}

/** A single item in an inline dataset. */
model AgentOptimizationDatasetItem {
  @doc("The user query / prompt.")
  @minLength(1)
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
  @minLength(1)
  name: string;

  @doc("Criterion instruction / description.")
  @minLength(1)
  instruction: string;
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

@doc("A non-empty model deployment name in the Foundry project.")
@minLength(1)
scalar AgentOptimizationDeploymentName extends string;

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

@doc("Identifies a model deployment used by an optimization or evaluation step.")
model AgentOptimizationModelConfiguration {
  @doc("Model deployment name in the Foundry project.")
  deployment_name: AgentOptimizationDeploymentName;

  // Review consideration: sampling_parameters may belong here once the service
  // supports caller-controlled inference settings. It is intentionally not a wire
  // property in this contract.
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

  @doc("Caller-supplied baseline model deployment. Omitted to resolve the baseline from the target; a prompt agent's stored definition is authoritative.")
  current_model_deployment_name?: AgentOptimizationDeploymentName;

  @doc("Skills available for optimization. Omitted when no manual skill surface is supplied.")
  skills?: AgentOptimizationSkill[];

  @doc("Function tools available for optimization. Omitted when no manual tool surface is supplied. The optimizer may change function and argument descriptions while preserving names and parameter JSON Schema.")
  tools?: OpenAI.ChatCompletionTool[];
}

@doc("The agent attributes and alternative values available to an agent-optimization search.")
model AgentOptimizationSpace {
  @doc("Agent attributes the optimizer may change. Defaults to instruction when omitted. For reduce_cost, model selection is additionally implied.")
  @minItems(1)
  target_attributes?: TargetAttribute[] = #[TargetAttribute.instruction];

  @doc("Alternative model deployments available when model is an optimization target. Required when goal is reduce_cost or target_attributes includes model; otherwise omitted.")
  @minItems(1)
  model_search_space?: AgentOptimizationDeploymentName[];
}

/**
 * Candidate search settings.
 *
 * Review consideration: if candidate search later gains multiple wall-clock, token, cost, or
 * evaluation-call budgets, or multiple stopping rules, split those concerns into
 * dedicated budget and stopping objects. The current flat shape avoids empty nesting.
 */
model AgentOptimizationCandidateSearchConfiguration {
  @doc("Maximum number of non-baseline candidates to fully evaluate. Defaults to 2 when omitted.")
  @minValue(1)
  @maxValue(20)
  max_candidates?: int32 = 2;

  @doc("Number of training-dataset rows sampled to screen each proposed candidate before full validation. Defaults to 3 when omitted.")
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
  @doc("Dataset used to guide the optimization search.")
  training_dataset: AgentOptimizationDatasetInput;

  @doc("Held-out dataset used for full candidate evaluation. The training dataset is reused when omitted.")
  validation_dataset?: AgentOptimizationValidationDatasetInput;

  @doc("Evaluator references used to score candidate quality.")
  @minItems(1)
  @maxItems(20)
  evaluators: AgentOptimizationEvaluator[];

  @doc("Model deployment used by model-based evaluators.")
  evaluation_model: AgentOptimizationModelConfiguration;

  @doc("Level at which each dataset item is evaluated. Defaults to turn when omitted; use conversation for multi-turn simulation.")
  evaluation_level?: EvaluationLevel = EvaluationLevel.turn;
}

/** Base model for type-specific optimization configuration. */
@discriminator("type")
model AgentOptimizationConfigurationBase {
  @doc("Optimization type discriminator.")
  type: string;
}

@doc("Configuration for optimizing an agent for measured quality or serving cost.")
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

@doc("Caller-supplied inputs for an optimization job.")
model AgentOptimizationJobInputs {
  @doc("Human-readable label. Omitted when no label is needed; it has no uniqueness, routing, or idempotency semantics.")
  display_name?: string;

  @doc("Foundry agent whose configuration is optimized. Omitted when the workflow does not target a registered Foundry agent.")
  target_configuration?: AgentOptimizationTargetConfiguration;

  @doc("Model deployment used to generate candidate changes.")
  optimization_model_configuration: AgentOptimizationModelConfiguration;

  @doc("Type-specific optimization configuration.")
  optimization_configuration: AgentOptimizationConfigurationBase;
}

@doc("Inputs for estimating an agent-optimization job.")
model AgentOptimizationEstimateInputs {
  @doc("Foundry agent whose configuration would be optimized. Omitted when the workflow does not target a registered Foundry agent.")
  target_configuration?: AgentOptimizationTargetConfiguration;

  @doc("Model deployment that would generate candidate changes.")
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
  validation_dataset_rows: int32;

  @doc("Estimated per-layer model-call bands, keyed by layer name (e.g. 'agent', 'judge', 'reflection'). Typical values are calibrated expectations and may be fractional. Omitted when the selected search strategy cannot produce call-count estimates.")
  call_counts?: Record<AgentOptimizationEstimateBand>;

  @doc("Modeled dollar estimate. Omitted when no contributing model has pricing data.")
  dollars?: AgentOptimizationEstimateDollars;

  @doc("Timestamp of the pricing snapshot used for cost estimation, represented in Unix time. Omitted when no valid pricing snapshot is available.")
  prices_as_of?: FoundryTimestamp;
}
