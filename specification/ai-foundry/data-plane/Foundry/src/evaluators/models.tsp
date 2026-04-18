import "@typespec/openapi";

import "../common/models.tsp";
import "../servicepatterns.tsp";

using TypeSpec.Rest;
using OpenAPI;

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

  @doc("Rubric-based evaluator definition. Stores rubric criteria for both quality and safety evaluators. Can be created via the generate API or manually via createVersion.")
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
  code_text?: string;

  @extension(
    "x-ms-foundry-meta",
    #{ required_previews: #[FoundryFeaturesOptInKeys.evaluations_v1_preview] }
  )
  @doc("The entry point Python file name for the uploaded evaluator code (e.g. 'answer_length_evaluator.py')")
  entry_point?: string;

  @extension(
    "x-ms-foundry-meta",
    #{ required_previews: #[FoundryFeaturesOptInKeys.evaluations_v1_preview] }
  )
  @doc("The container image tag to use for evaluator code execution")
  image_tag?: string;

  @extension(
    "x-ms-foundry-meta",
    #{ required_previews: #[FoundryFeaturesOptInKeys.evaluations_v1_preview] }
  )
  @doc("The blob URI for the evaluator storage")
  blob_uri?: url;
}

@doc("Prompt-based evaluator")
model PromptBasedEvaluatorDefinition extends EvaluatorDefinition {
  type: EvaluatorDefinitionType.prompt;

  @doc("The prompt text used for evaluation")
  prompt_text: string;
}

// ============================================================================
// Rubric Criteria + Rubric-based Evaluator Definition
// ============================================================================

@doc("A single rubric criterion — one measurable quality dimension in an evaluator's scoring blueprint.")
model RubricCriterion {
  @doc("Short name / slug for this rubric criterion. For generated evaluators, the service assigns a default slug derived from the description. For manually created rubric evaluators, users set this directly. Users can edit this field when saving new versions.")
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
  rubric_criteria: RubricCriterion[];
}

// ============================================================================
// Evaluator Generation Job (LRO — follows DataGenerationJob pattern)
// ============================================================================

@doc("Caller-supplied inputs for an evaluator generation job.")
model EvaluatorGenerationInputs {
  @doc("Display name for this generation job.")
  name: string;

  @doc("Source materials for generation — agent descriptions, prompts, traces, or datasets.")
  sources: JobSource[];

  @doc("Category determines the rubric generation focus: 'quality' (default) produces quality-focused rubric criteria, 'safety' produces policy-derived safety rubric criteria. Both use the same rubric structure. Singular because quality and safety generation are mutually exclusive pipelines — the output EvaluatorVersion.categories is an array (e.g., ['agents', 'quality']).")
  category?: EvaluatorCategory = EvaluatorCategory.quality;

  @doc("The LLM model to use for rubric generation (e.g., 'gpt-4o'). Required — users must provide their own model rather than relying on service-owned capacity.")
  `model`: string;

  @doc("The evaluator name to create or update. If an evaluator with this name already exists, the service retrieves the latest version's criteria as context for improvement.")
  evaluator_name: string;
}

@doc("Evaluator Generation Job resource — a long-running job that generates rubric-based evaluator definitions from source materials. On success, the result is the persisted EvaluatorVersion.")
model EvaluatorGenerationJob
  is JobLike<EvaluatorVersion, EvaluatorGenerationInputs> {
  @doc("The timestamp when the job was created, represented in Unix time (seconds since January 1, 1970).")
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  @doc("The timestamp when the job finished, represented in Unix time (seconds since January 1, 1970).")
  @visibility(Lifecycle.Read)
  finished_at?: FoundryTimestamp;
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

@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[FoundryFeaturesOptInKeys.evaluations_v1_preview] }
)
@doc("Request body for getting evaluator credentials")
model EvaluatorCredentialRequest {
  @doc("The blob URI for the evaluator storage. Example: `https://account.blob.core.windows.net:443/container`")
  blob_uri: url;
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

  @doc("Default pass/fail threshold for this metric.")
  threshold?: float32;

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
