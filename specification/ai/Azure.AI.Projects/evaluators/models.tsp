import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

// TODO: Need to ask a PM for categories to support
@doc("The category of the evaluator")
union EvaluatorCategory {
  string,

  @doc("Quality evaluator")
  quality: "Quality",

  @doc("Safety evaluator")
  safety: "Risk and Safety",

  @doc("Performance evaluator")
  performance: "Performance",
}

@doc("The type of the evaluator")
union EvaluatorType {
  string,

  @doc("Built-in evaluator")
  built_in: "Built-In",

  @visibility(Lifecycle.Read)
  @doc("Custom evaluator")
  custom: "Custom",
}

@doc("The type of evaluator definition")
union EvaluatorDefinitionType {
  string,

  @doc("Prompt-based definition")
  prompt: "prompt",

  @doc("Code-based definition")
  code: "code",

  @doc("Prompty-based definition")
  prompty: "prompty",

  @visibility(Lifecycle.Read)
  @doc("Prompt & Code Based definition")
  prompt_and_code: "prompt_and_code",

  @visibility(Lifecycle.Read)
  @doc("Service-based evaluator")
  service: "service",

  @visibility(Lifecycle.Read)
  @doc("AOAI graders")
  aoai_graders: "aoai_graders",
}

@doc("Base evaluator configuration with discriminator")
@discriminator("type")
model EvaluatorDefinition {
  @doc("The type of evaluator definition")
  type: EvaluatorDefinitionType;

  @doc("The JSON schema for the evaluator's input parameters")
  init_parameters?: unknown;

  @doc("The JSON schema for the data mapping of the evaluator to the dataset")
  data_schema?: unknown;

  @doc("The JSON schema for the resulting metrics of the evaluator")
  results?: unknown;
}

@doc("Metadata about the evaluator")
@discriminator("type")
model EvaluatorMetadata {
  @doc("The key of the evaluator metadata")
  key: string;

  @doc("The value of the evaluator metadata")
  value: string;
}

/* Allowed parameter types */
alias ScalarParamType = string | "number" | "string"; // TODO: need to confirm allowed values

/* The evaluator's input parameters */
alias InputParameters = Record<ScalarParamType>;

/* The evaluator's output parameters */
alias OutputParameters = Record<ScalarParamType>;

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

@doc("Evaluator Definition")
@resource("evaluators")
@added(Versions.v2025_05_15_preview)
model EvaluatorVersion {
  @doc("Display Name for evaluator. It helps to find the evaluator easily in AI Foundry. It does not need to be unique.")
  display_name?: string;

  @doc("The metadata of the evaluator")
  metadata: Record<string>;

  @doc("The category of the evaluator")
  categories: EvaluatorCategory[];

  @doc("Definition of the evaluator")
  definition: EvaluatorDefinition;

  ...AssetBase;
}

@doc("The success result of createEvaluatorVersion")
model EvaluatorCreateResult {
  @doc("The Evaluator's id")
  id: string;

  @doc("The Evaluator's version")
  version: string;

  @doc("The Evaluator's name")
  name: string;
}
