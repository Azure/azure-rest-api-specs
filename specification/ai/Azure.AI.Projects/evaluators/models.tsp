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
  safety: "Risk and Safety", // TODO: Spaces in enum value is inconsistent with other multiword enum values
}

@doc("The type of the evaluator")
union EvaluatorType {
  string,

  @doc("LLM-based evaluator")
  llm: "LLM_Based",

  @doc("Code-based evaluator")
  code: "Code_Based",

  @doc("Service-based evaluator")
  service: "Service_Based",

  @doc("Container-based evaluator")
  Container: "Container_Based",
}

@doc("The type of evaluator configuration")
union EvaluatorConfigType {
  string,

  @doc("Prompt-based configuration")
  prompt: "prompt",

  @doc("Prompty-based configuration")
  prompty: "prompty",

  @doc("Code-based configuration")
  code: "code",

  @doc("Container-based configuration")
  container: "container",
}

@doc("The type of evaluator configuration")
union EvaluatorScopeType {
  string,

  @doc("Prompt-based configuration")
  registry: "registry",
}

@doc("Base evaluator configuration with discriminator")
@discriminator("config_type")
model EvaluatorConfig {
  @doc("The type of evaluator configuration")
  config_type: EvaluatorConfigType;
}

/* Allowed parameter types */
alias ScalarParamType = string | "number" | "string"; // TODO: need to confirm allowed values

/* The evaluator's initialization parameters */
alias InitializationParameters = Record<ScalarParamType>; // TODO: Is this correct?

@doc("Code-based evaluator configuration using container images")
model CodeEvaluatorConfig extends EvaluatorConfig {
  config_type: EvaluatorConfigType.code;

  @doc("URI of the container image")
  inline_code: string;

  @doc("The evaluator's initialization parameters")
  init_params: InitializationParameters;
}

@doc("Code-based evaluator configuration using container images")
model ContainerEvaluatorConfig extends EvaluatorConfig {
  config_type: EvaluatorConfigType.container;

  @doc("URI of the container image")
  container_image_uri: string;

  @doc("Environment variables to pass to the container")
  env_variables: Record<string>;
}

@doc("Prompt-based evaluator")
model PromptBasedEvaluatorConfig extends EvaluatorConfig {
  config_type: EvaluatorConfigType.prompt;

  @doc("The prompt text used for evaluation")
  prompt_text: string;

  @doc("The evaluator's initialization parameters")
  init_params: InitializationParameters;
}

@doc("Prompty-based evaluator configuration using prompty files")
model PromptyBasedEvaluatorConfig extends EvaluatorConfig {
  config_type: EvaluatorConfigType.prompty;

  @doc("The prompt text used for evaluation")
  prompt_text: string;

  @doc("The evaluator's initialization parameters")
  init_params: InitializationParameters;
}

@doc("The scope of an evaluator (registry, project, etc...)")
model EvaluatorScope {
  @doc("The Evaluator Scope type")
  type: EvaluatorScopeType;
}

@doc("Registry scope")
model RegistryEvaluatorScope {
  type: EvaluatorScopeType.registry;

  @doc("The registry the evaluator is scoped to")
  registry: string;
}

@doc("Evaluator Definition")
@resource("evaluators")
@added(Versions.v2025_05_15_preview)
model EvaluatorVersion {
  @doc("Display Name for evaluator. It helps to find the evaluator easily in AI Foundry. It does not need to be unique.")
  displayName?: string;

  @doc("evaluator's properties. Unlike tags, properties are add-only. Once added, a property cannot be removed.")
  properties?: Record<string>;

  @doc("The category of this evaluator")
  category: EvaluatorCategory;

  @doc("The evaluator type")
  type: EvaluatorType;

  @doc("Configuration specific to the evaluator type")
  evaluator_config: EvaluatorConfig;

  @doc("The Evaluator's provider")
  provider: string;

  @doc("The scope of the evaluator")
  @visibility(Lifecycle.Read)
  scope?: EvaluatorScope:

  ...AssetBase;
}

@doc("The success result of createEvaluatorVersion")
model EvaluatorCreateResult {
  @doc("The Evaluator's id")
  id: string;
}
