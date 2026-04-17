import "../common/models.tsp";
import "../servicepatterns.tsp";

using TypeSpec.Rest;

namespace Azure.AI.Projects;

@doc("The category of the evaluator")
union EvaluatorCategory {
  string,

  @doc("Quality")
  quality: "quality",

  @doc("Risk & Safety")
  safety: "safety",

  @doc("Agents")
  agents: "agents",
}

@doc("The type of the evaluator")
union EvaluatorType {
  string,

  @doc("Built-in evaluator (Microsoft provided)")
  built_in: "builtin",

  @doc("Custom evaluator")
  custom: "custom",
}

@doc("The type of evaluator definition")
union EvaluatorDefinitionType {
  string,

  @doc("Prompt-based definition")
  prompt: "prompt",

  @doc("Code-based definition")
  code: "code",

  @doc("Prompt & Code Based definition")
  prompt_and_code: "prompt_and_code",

  @doc("Service-based evaluator")
  service: "service",

  @doc("OpenAI graders")
  openai_graders: "openai_graders",

  @doc("Rubric-based evaluator definition produced by the generate API. Stores rubric criteria for both quality and safety evaluators.")
  rubrics: "rubrics",
}

#suppress "@azure-tools/typespec-azure-core/no-unknown"
@doc("Base evaluator configuration with discriminator")
@discriminator("type")
model EvaluatorDefinition {
  @doc("The type of evaluator definition")
  type: EvaluatorDefinitionType;

  @doc("The JSON schema (Draft 2020-12) for the evaluator's input parameters. This includes parameters like type, properties, required.")
  init_parameters?: Record<unknown>;

  @doc("The JSON schema (Draft 2020-12) for the evaluator's input data. This includes parameters like type, properties, required.")
  data_schema?: Record<unknown>;

  @doc("List of output metrics produced by this evaluator")
  metrics?: Record<EvaluatorMetric>;
}

@doc("Code-based evaluator definition using python code")
model CodeBasedEvaluatorDefinition extends EvaluatorDefinition {
  type: EvaluatorDefinitionType.code;

  @doc("Inline code text for the evaluator")
  code_text: string;
}

@doc("Prompt-based evaluator")
model PromptBasedEvaluatorDefinition extends EvaluatorDefinition {
  type: EvaluatorDefinitionType.prompt;

  @doc("The prompt text used for evaluation")
  prompt_text: string;
}

// ============================================================================
// Shared Generation Job Sources
//
// These source types are shared between evaluator generation and data generation
// jobs. The type union and base model use "GenerationJobSource" naming to
// indicate they are reusable across generation job types.
// ============================================================================

@doc("The supported source types for generation jobs (shared by evaluator generation and data generation).")
union GenerationJobSourceType {
  string,

  @doc("Prompt source — inline text or agent name to fetch instructions from.")
  Prompt: "Prompt",

  @doc("Traces source — conversation traces from Application Insights, specified by agent name and time window.")
  Traces: "Traces",

  @doc("Dataset source — reference to a dataset.")
  Dataset: "Dataset",
}

@doc("The base source model for generation jobs. Shared across evaluator generation and data generation.")
@discriminator("type")
model GenerationJobSource {
  @doc("The type of source.")
  type: GenerationJobSourceType;

  @doc("Optional description of what this source represents — helps the generation pipeline interpret its content (e.g., 'Agent system prompt describing a travel booking assistant' or 'Company policy document for refund handling').")
  purpose?: string;
}

@doc("Prompt source — inline text, agent reference, or both. At least one of prompt or agent_name must be specified. When both are provided, agent instructions are merged with the supplementary prompt text as combined input for generation.")
model PromptGenerationJobSource extends GenerationJobSource {
  @doc("The source type for this job, which is Prompt.")
  type: "Prompt";

  @doc("Inline prompt text. Can be combined with agent_name. At least one of prompt or agent_name is required.")
  prompt?: string;

  @doc("The agent name to fetch instructions from. Can be combined with prompt for additional context. At least one of prompt or agent_name is required.")
  agent_name?: string;

  @doc("The agent version. If not specified, the latest version is used.")
  agent_version?: string;
}

@doc("Traces source — conversation traces from Application Insights.")
model TracesGenerationJobSource extends GenerationJobSource {
  @doc("The source type for this job, which is Traces.")
  type: "Traces";

  @doc("The agent name to fetch traces for.")
  agent_name: string;

  @doc("The agent version. If not specified, the latest version is used.")
  agent_version?: string;

  @doc("Start of the time window (Unix timestamp in seconds) for fetching traces.")
  start_time?: FoundryTimestamp;

  @doc("End of the time window (Unix timestamp in seconds). Defaults to current time.")
  end_time?: FoundryTimestamp;

  @doc("Maximum number of traces to retrieve.")
  max_traces?: int32 = 100;
}

@doc("Dataset source — reference to a dataset containing policies, rules, or supplementary context.")
model DatasetGenerationJobSource extends GenerationJobSource {
  @doc("The source type for this job, which is Dataset.")
  type: "Dataset";

  @doc("The name of the dataset.")
  name: string;

  @doc("The version of the dataset. If not specified, the latest version is used.")
  version?: string;
}

// ============================================================================
// Rubric Criteria + Rubric-based Evaluator Definition
// ============================================================================

@doc("A single rubric criterion — one measurable quality dimension in an evaluator's scoring blueprint.")
model RubricCriterion {
  @doc("Stable, human-readable slug assigned by the service on first generation. When editing criteria and saving as a new version, clients must echo the existing rubric_id to preserve identity across versions. Service-generated on first creation; client-echoed on subsequent saves.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  rubric_id?: string;

  @doc("What this criterion measures (e.g., 'Correctly identifies the user's reservation intent and pursues the appropriate workflow').")
  description: string;

  @doc("Relative weight of this criterion (1-10). The generation pipeline assigns exactly one criterion weight 8-10; all others use 1-6. User edits are not constrained by this heuristic.")
  @minValue(1)
  @maxValue(10)
  weight: int32;

  @doc("When true, the LLM judge always scores this criterion regardless of relevance (skips applicability assessment). The service-generated general quality/policy criterion has this set to true and is non-editable. Users may set this on their own custom criteria. Defaults to false.")
  always_applicable?: boolean;
}

@doc("Rubric-based evaluator definition — stores rubric criteria produced by the generate API. Used for both quality and safety evaluators.")
model RubricBasedEvaluatorDefinition extends EvaluatorDefinition {
  type: EvaluatorDefinitionType.rubrics;

  @doc("Rubric criteria — the scoring blueprint used by the LLM judge. Quality evaluators include a non-editable residual criterion with rubric_id 'general_quality' (always_applicable: true); safety evaluators include 'general_policy_compliance'. Both use the same rubric structure.")
  rubric_criteria?: RubricCriterion[];
}

// ============================================================================
// Evaluator Generation Job (LRO — follows DataGenerationJob pattern)
// ============================================================================

@doc("Caller-supplied inputs for an evaluator generation job.")
model EvaluatorGenerationInputs {
  @doc("Display name for this generation job.")
  name: string;

  @doc("Source materials for generation — agent prompts, traces, or datasets.")
  sources: GenerationJobSource[];

  @doc("Category determines the rubric generation focus: 'quality' (default) produces quality-focused rubric criteria, 'safety' produces policy-derived safety rubric criteria. Both use the same rubric structure.")
  category?: EvaluatorCategory = EvaluatorCategory.quality;

  @doc("When true (default), the generated evaluator is saved as a new version immediately on job completion. When false, result contains an unsaved preview — call createVersion to persist.")
  persist?: boolean = true;

  @doc("The LLM model to use for rubric generation (e.g., 'gpt-4o'). Required — users must provide their own model rather than relying on service-owned capacity.")
  model: string;

  @doc("The evaluator name to create or update. If an evaluator with this name already exists, the service retrieves the latest version's criteria as context for improvement.")
  evaluator_name: string;
}

@doc("Result produced by a successful evaluator generation job.")
model EvaluatorGenerationResult {
  @doc("The generated evaluator version. Present when the job completes successfully.")
  @visibility(Lifecycle.Read)
  evaluator?: EvaluatorVersion;

  @doc("Token usage information for the generation job.")
  @visibility(Lifecycle.Read)
  token_usage?: TokenUsage;
}

@doc("Evaluator Generation Job resource — a long-running job that generates rubric-based evaluator definitions from source materials.")
model EvaluatorGenerationJob
  is JobLike<EvaluatorGenerationResult, EvaluatorGenerationInputs> {
  @doc("The timestamp when the job was created, represented in Unix time (seconds since January 1, 1970).")
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  @doc("The timestamp when the job finished, represented in Unix time (seconds since January 1, 1970).")
  @visibility(Lifecycle.Read)
  finished_at?: FoundryTimestamp;
}

@doc("Token usage information for a generation job.")
model TokenUsage {
  @doc("The number of prompt tokens used.")
  @visibility(Lifecycle.Read)
  prompt_tokens?: int64;

  @doc("The number of completion tokens generated.")
  @visibility(Lifecycle.Read)
  completion_tokens?: int64;

  @doc("Total number of tokens used.")
  @visibility(Lifecycle.Read)
  total_tokens?: int64;
}

@doc("Evaluator Definition")
@resource("evaluators")
model EvaluatorVersion {
  @doc("Display Name for evaluator. It helps to find the evaluator easily in AI Foundry. It does not need to be unique.")
  display_name?: string;

  @doc("Metadata about the evaluator")
  metadata?: Record<string>;

  @doc("The type of the evaluator")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  evaluator_type: EvaluatorType;

  @doc("The categories of the evaluator")
  categories: EvaluatorCategory[];

  @doc("Definition of the evaluator")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  definition: EvaluatorDefinition;

  @visibility(Lifecycle.Read)
  @doc("Creator of the evaluator")
  created_by: string;

  @visibility(Lifecycle.Read)
  @doc("Creation date/time of the evaluator")
  created_at: string;

  @visibility(Lifecycle.Read)
  @doc("Last modified date/time of the evaluator")
  modified_at: string;

  ...AssetBase;
}

@doc("Evaluator Metric")
model EvaluatorMetric {
  @doc("Type of the metric.")
  type?: EvaluatorMetricType;

  @doc("It indicates whether a higher value is better or a lower value is better for this metric.")
  desirable_direction?: EvaluatorMetricDirection;

  @doc("Minimum value for the metric")
  min_value?: float32;

  @doc("Maximum value for the metric. If not specified, it is assumed to be unbounded.")
  max_value?: float32;

  @doc("Indicates if this metric is primary when there are multiple metrics.")
  is_primary?: boolean;
}

@doc("The type of the evaluator")
union EvaluatorMetricType {
  string,

  @doc("Ordinal metric representing categories that can be ordered or ranked.")
  ordinal: "ordinal",

  @doc("Continuous metric representing values in a continuous range.")
  continuous: "continuous",

  @doc("Boolean metric representing true/false values")
  boolean: "boolean",
}

@doc("The direction of the metric indicating whether a higher value is better, a lower value is better, or neutral")
union EvaluatorMetricDirection {
  string,

  @doc("It indicates a higher value is better for this metric")
  increase: "increase",

  @doc("It indicates a lower value is better for this metric")
  decrease: "decrease",

  @doc("It indicates no preference for this metric direction")
  neutral: "neutral",
}
