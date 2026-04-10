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

@doc("A single rubric criterion with scoring descriptions")
model RubricCriterion {
  @doc("Name of the criterion (e.g., 'task_adherence', 'accuracy')")
  name: string;

  @doc("Description of what this criterion measures")
  description: string;

  @doc("Relative weight of this criterion in the overall score")
  weight: float32;

  @doc("Scoring rubric: maps score levels (1-5) to descriptions")
  scoring: Record<string>;

  @doc("Applicability guidance: when to apply and when not to apply this criterion")
  applicability_guidance?: string;

  @doc("Whether this criterion is always scored on every case (true for sink criteria)")
  always_on?: boolean;
}

@doc("Generated evaluator definition — stores artifacts produced by the generate API. Use the generate action to produce these artifacts, review them, then save via createVersion.")
model GeneratedEvaluatorDefinition extends EvaluatorDefinition {
  type: EvaluatorDefinitionType.generated;

  @doc("Generated evaluation spec describing what to evaluate")
  spec?: string;

  @doc("Generated rubric catalog with scored criteria (populated when category is 'quality')")
  rubric_catalog?: RubricCriterion[];

  @doc("ID of the generated or linked taxonomy (populated when category is 'safety')")
  taxonomy_id?: string;

  @doc("Version of the linked taxonomy")
  taxonomy_version?: string;
}

@doc("Generated rubric catalog — output of the quality generation pipeline")
model RubricCatalog {
  @doc("Generated evaluation spec describing what to evaluate")
  spec: string;

  @doc("Array of scored rubric criteria")
  criteria: RubricCriterion[];

  @doc("Model used for generation")
  source_model?: string;
}

@doc("Request body for evaluator generation")
model GenerateEvaluatorRequest {
  @doc("Source materials for generation (agent description, policies, traces, supplementary context)")
  sources: Source[];

  @doc("Category determines generation pipeline: 'quality' (default) produces a rubric catalog, 'safety' produces a taxonomy")
  category?: EvaluatorCategory = EvaluatorCategory.quality;

  @doc("Optional: model deployment to use for generation (defaults to service default)")
  model_deployment_name?: string;

  @doc("Optional: existing rubric criteria to retain or refine (for iterative improvement)")
  existing_criteria?: RubricCriterion[];
}

@doc("Response from evaluator generation — contains generated artifacts for review before saving as an evaluator version")
model GenerateEvaluatorResponse {
  @doc("The evaluator name this generation is for")
  name: string;

  @doc("Generated rubric catalog (populated when category is 'quality')")
  rubric_catalog?: RubricCatalog;

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
