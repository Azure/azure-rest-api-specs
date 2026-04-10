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

  @doc("Scenario-based definition that generates evaluation artifacts (rubric catalog or taxonomy) from context inputs. When category is 'quality', generates a rubric catalog with scored criteria. When category is 'safety', generates a taxonomy with risk sub-behaviors.")
  scenario: "scenario",
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

@doc("Type of context input for evaluator generation")
union ContextInputType {
  string,

  @doc("Agent system prompt or instructions")
  agent_prompt: "agent_prompt",

  @doc("Policy document (business rules, compliance requirements)")
  policy_document: "policy_document",

  @doc("Trace file containing conversation logs")
  trace_file: "trace_file",

  @doc("Supplementary text (additional context)")
  supplementary_text: "supplementary_text",
}

@doc("Context input for evaluator generation")
model ContextInput {
  @doc("Type of context input")
  type: ContextInputType;

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

@doc("Scenario-based evaluator definition — stores generated evaluation artifacts. Use the generate action to produce these artifacts before saving.")
model ScenarioBasedEvaluatorDefinition extends EvaluatorDefinition {
  type: EvaluatorDefinitionType.scenario;

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
  @doc("Context inputs to generate from (agent prompts, policies, traces, supplementary text)")
  context_inputs: ContextInput[];

  @doc("Category determines generation pipeline: 'quality' produces rubric catalog, 'safety' produces taxonomy")
  category: EvaluatorCategory;

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
