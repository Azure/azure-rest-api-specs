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

@doc("The category of the evaluator")
union EvaluatorCategory {
  string,

  @doc("Quality evaluator")
  quality: "Quality",

  @doc("Safety evaluator")
  safety: "Safety",
}

@doc("The type of the evaluator")
union EvaluatorType {
  string,

  @doc("Custom Evaluator")
  custom: "Custom",

  @doc("Built-in evaluator provided by the platform")
  builtin: "Built-In",
}

@doc("The sub-type of the evaluator")
union EvaluatorSubType {
  string,

  @doc("LLM-based evaluator")
  llm: "LLM_Based",

  @doc("Code-based evaluator")
  code: "Code_Based",
}

@doc("The type of evaluator configuration")
union EvaluatorConfigType {
  string,

  @doc("Prompt-based configuration")
  prompt: "Prompt",

  @doc("Prompty-based configuration")
  prompty: "Prompty",

  @doc("Code-based configuration")
  code: "Code",
}

@doc("Scale rule types for container deployment")
union ScaleRuleType {
  string,

  @doc("HTTP-based scaling rules")
  http: "http",
}

@doc("Base evaluator configuration with discriminator")
@discriminator("type")
model EvaluatorConfig {
  @doc("The type of evaluator configuration")
  type: EvaluatorConfigType;
}

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

  @doc("Name of the model deployment to use for evaluation")
  model_deployment_name: string;
}

@doc("Prompty-based evaluator configuration using prompty files")
model PromptyBasedEvaluatorConfig extends EvaluatorConfig {
  type: EvaluatorConfigType.prompty;

  @doc("Path to the prompty file")
  file_path: string;

  @doc("Name of the model deployment to use for evaluation")
  model_deployment_name: string;

  @doc("Connection name")
  connection_name?: string;
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

  @doc("The evaluator subtype")
  sub_type: EvaluatorSubType;

  @doc("Configuration specific to the evaluator type")
  evaluator_config: EvaluatorConfig;

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
