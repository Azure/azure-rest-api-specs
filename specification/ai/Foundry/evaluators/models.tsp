import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("The category of the evaluator")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
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
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
union EvaluatorType {
  string,

  @doc("Built-in evaluator (Microsoft provided)")
  built_in: "builtin",

  @doc("Custom evaluator")
  custom: "custom",
}

@doc("The type of evaluator definition")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
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
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
@discriminator("type")
model EvaluatorDefinition {
  @doc("The type of evaluator definition")
  type: EvaluatorDefinitionType;

  @doc("The JSON schema (Draft 2020-12) for the evaluator's input parameters. This includes parameters like type, properties, required.")
  init_parameters?: unknown;

  @doc("The JSON schema (Draft 2020-12) for the evaluator's input data. This includes parameters like type, properties, required.")
  data_schema?: unknown;

  @doc("List of output metrics produced by this evaluator")
  metrics?: Record<EvaluatorMetric>;
}

@doc("Code-based evaluator definition using python code")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model CodeBasedEvaluatorDefinition extends EvaluatorDefinition {
  type: EvaluatorDefinitionType.code;

  @doc("Inline code text for the evaluator")
  code_text: string;
}

@doc("Prompt-based evaluator")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model PromptBasedEvaluatorDefinition extends EvaluatorDefinition {
  type: EvaluatorDefinitionType.prompt;

  @doc("The prompt text used for evaluation")
  prompt_text: string;
}

@doc("Context input for scenario-based evaluator generation")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model ContextInput {
  @doc("Type of context input: agent_prompt, policy_document, trace_file, or supplementary_text")
  type: string;

  @doc("Content of the context input (inline text or file reference)")
  content: string;
}

@doc("A single rubric criterion with scoring descriptions")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
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

@doc("Scenario-based evaluator definition that generates evaluation artifacts from context inputs. The category field on the evaluator determines the pipeline: 'quality' generates a rubric catalog, 'safety' generates a taxonomy.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model ScenarioBasedEvaluatorDefinition extends EvaluatorDefinition {
  type: EvaluatorDefinitionType.scenario;

  @doc("Context inputs used to generate the evaluation artifacts (agent prompt, policies, traces, supplementary text)")
  context_inputs?: ContextInput[];

  @doc("Generated evaluation spec describing what to evaluate (read-only, set by service)")
  @visibility(Lifecycle.Read)
  spec?: string;

  @doc("Generated rubric catalog with scored criteria (populated when category is 'quality')")
  rubric_catalog?: RubricCriterion[];

  @doc("ID of the generated or linked taxonomy (populated when category is 'safety')")
  taxonomy_id?: string;

  @doc("Version of the linked taxonomy")
  taxonomy_version?: string;
}

@doc("Evaluator Definition")
@resource("evaluators")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
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
  created_at: int64;

  @visibility(Lifecycle.Read)
  @doc("Last modified date/time of the evaluator")
  modified_at: int64;

  ...AssetBase;
}

@doc("Evaluator Metric")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
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
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
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
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
union EvaluatorMetricDirection {
  string,

  @doc("It indicates a higher value is better for this metric")
  increase: "increase",

  @doc("It indicates a lower value is better for this metric")
  decrease: "decrease",

  @doc("It indicates no preference for this metric direction")
  neutral: "neutral",
}
