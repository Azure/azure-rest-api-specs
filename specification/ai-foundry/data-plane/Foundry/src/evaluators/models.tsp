import "../common/models.tsp";

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

  @doc("Generated evaluator definition produced by the generate API. Stores rubric catalog (quality) or taxonomy reference (safety).")
  generated: "generated",
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

@doc("Type of source material for evaluator generation")
union SourceType {
  string,

  @doc("Agent description — the agent's purpose, behavior, and capabilities")
  description: "description",

  @doc("Policy document — business rules, compliance requirements, or safety policies")
  policy: "policy",

  @doc("Conversation traces — real or synthetic conversation logs")
  traces: "traces",

  @doc("Supplementary context — any additional information relevant to evaluation")
  supplementary: "supplementary",
}

@doc("Source material for evaluator generation")
model Source {
  @doc("Type of source material")
  type: SourceType;

  @doc("Inline text content")
  content?: string;

  @doc("File ID reference (for trace files or large documents)")
  file_id?: string;
}

@doc("A single rubric criterion — one measurable quality dimension in an evaluator's scoring blueprint")
model RubricCriterion {
  @doc("Stable identifier for this criterion (service-generated, derived from description hash)")
  @visibility(Lifecycle.Read)
  rubric_id?: string;

  @doc("What this criterion measures (e.g., 'Correctly identifies the user's reservation intent and pursues the appropriate workflow')")
  description: string;

  @doc("Relative weight of this criterion (1-10). Exactly one criterion should have weight 8-10; all others should use 1-6.")
  weight: int32;

  @doc("Fixed applicability override. When set (e.g., 3 for the sink criterion), the judge must use this applicability value instead of assessing relevance. Only used for the sink criterion.")
  fixed_applicability?: int32;
}

@doc("Generated evaluator definition — stores artifacts produced by the generate API. Call the generate action first, review the output, then save via createVersion.")
model GeneratedEvaluatorDefinition extends EvaluatorDefinition {
  type: EvaluatorDefinitionType.generated;

  @doc("Generated rubric criteria — the scoring blueprint used by the LLM judge (populated when category is 'quality')")
  rubric_criteria?: RubricCriterion[];

  @doc("ID of the generated or linked taxonomy (populated when category is 'safety')")
  taxonomy_id?: string;

  @doc("Version of the linked taxonomy")
  taxonomy_version?: string;
}

@doc("Request body for evaluator generation. If an evaluator with this name already exists, the service automatically retrieves the latest version's criteria and uses them as context for improvement.")
model GenerateEvaluatorRequest {
  @doc("Source materials for generation (agent description, policies, traces, supplementary context)")
  sources: Source[];

  @doc("Category determines generation pipeline: 'quality' (default) produces rubric criteria, 'safety' produces a taxonomy")
  category?: EvaluatorCategory = EvaluatorCategory.quality;

  @doc("Optional: model deployment to use for generation (defaults to service default)")
  model_deployment_name?: string;
}

@doc("Response from evaluator generation — contains generated artifacts for review before saving as an evaluator version via createVersion")
model GenerateEvaluatorResponse {
  @doc("The evaluator name this generation is for")
  name: string;

  @doc("Human-readable evaluation summary describing what this evaluator measures — the agent's purpose, expected behaviors, and quality dimensions. Generated by Stage 1 of the pipeline. Informational; stored as read-only metadata on the evaluator version.")
  evaluation_summary?: string;

  @doc("Generated rubric criteria for review (populated when category is 'quality'). Pass these to GeneratedEvaluatorDefinition.rubric_criteria when saving.")
  rubric_criteria?: RubricCriterion[];

  @doc("Model used for generation")
  source_model?: string;

  @doc("ID of the generated taxonomy (populated when category is 'safety')")
  taxonomy_id?: string;

  @doc("Taxonomy version")
  taxonomy_version?: string;

  @doc("The category that was used for generation")
  category: EvaluatorCategory;
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
