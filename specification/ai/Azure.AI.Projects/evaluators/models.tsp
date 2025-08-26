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

  @doc("Math-based evaluator")
  math: "Math_Based",
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
}

// TODO: What are the allowed values here
@doc("Scale rule types for container deployment")
union ScaleRuleType {
  string,

  @doc("HTTP-based scaling rules")
  http: "http",

    @doc("TCP-based scaling rules")
  tcp: "tcp",
}

@doc("Base evaluator configuration with discriminator")
@discriminator("type")
model EvaluatorConfig {
  @doc("The type of evaluator configuration")
  type: EvaluatorConfigType;
}

/* Allowed parameter types */
alias ScalarParamType = string | "number" | "string"; // TODO: need to confirm allowed values

/* The evaluator's initialization parameters */
alias InitializationParameters = Record<ScalarParamType>; // TODO: Is this correct?

@doc("Resource settings for container deployment")
model ResourceSettings {
  @doc("CPU allocation")
  cpu: int32;

  @doc("Memory allocation in GB")
  memory: int32;
}

@doc("Scale settings for container deployment")
model ScaleSettings {
  @doc("Minimum number of container replicas to maintain")
  min_replicas: int32;

  @doc("Maximum number of container replicas allowed")
  max_replicas: int32;

  @doc("The type of rule used for auto-scaling decisions")
  rule_type: ScaleRuleType;
}

@doc("Container deployment configuration")
model ContainerDeploymentConfig {
  @doc("Scale settings")
  scale_settings: ScaleSettings;

  @doc("Resource settings")
  resource_settings: ResourceSettings;
}

@doc("Code-based evaluator configuration using container images")
model CodeEvaluatorConfig extends EvaluatorConfig {
  type: EvaluatorConfigType.code;

  @doc("URI of the container image")
  container_image_uri: string;

  @doc("Environment variables to pass to the container")
  env_variables: Record<string>;

  @doc("Configuration for container deployment")
  container_deployment_config: ContainerDeploymentConfig;
}

@doc("Prompt-based evaluator")
model PromptBasedEvaluatorConfig extends EvaluatorConfig {
  type: EvaluatorConfigType.prompt;

  @doc("The prompt text used for evaluation")
  prompt_text: string;

  @doc("The evaluator's initialization parameters")
  init_params: InitializationParameters;
}


@doc("Prompty-based evaluator configuration using prompty files")
model PromptyBasedEvaluatorConfig extends EvaluatorConfig {
  type: EvaluatorConfigType.prompty;

  @doc("The prompt text used for evaluation")
  prompt_text: string;

  @doc("The evaluator's initialization parameters")
  init_params: InitializationParameters;
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

  ...AssetBase;
}

@doc("The success result of createEvaluatorVersion")
model EvaluatorCreateResult {
  @doc("The Evaluator's id")
  id: string;
}
