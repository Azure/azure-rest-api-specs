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

@doc("Evaluator Configuration")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model EvaluatorConfiguration {
  @doc("Identifier of the evaluator.")
  id: string;

  @doc("Initialization parameters of the evaluator.")
  initParams?: Record<unknown>;

  @doc("Data parameters of the evaluator.")
  dataMapping?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator"
@doc("Abstract data class.")
@discriminator("type")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model InputData {
  @doc("Type of the data")
  type: string;
}

@doc("Dataset as source for evaluation.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model InputDataset extends InputData {
  type: "dataset";

  @doc("Evaluation input data")
  id: string;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Needed since suggestion is not supported to generate swagger in OpenAPIv2"
@doc("Abstract class for model configuration.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
@discriminator("type")
model TargetModelConfig {
  @doc("Type of the model configuration.")
  type: string;
}

@doc("Azure OpenAI model configuration. The API version would be selected by the service for querying the model.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model AOAIModelConfig extends TargetModelConfig {
  @visibility(Lifecycle.Read)
  type: "AOAI";

  @doc("Endpoint targetURI for AOAI model.")
  azureEndpoint: string;

  @doc("API Key for AOAI model.")
  apiKey: string;

  @doc("Deployment name for AOAI model.")
  azureDeployment: string;
}

@doc("MaaS model configuration. The API version would be selected by the service for querying the model.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model MAASModelConfig extends TargetModelConfig {
  @visibility(Lifecycle.Read)
  type: "MAAS";

  @doc("Endpoint targetURI for MAAS model.")
  azureEndpoint: string;

  @doc("API Key for MAAS model.")
  apiKey: string;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Needed since suggestion is not supported to generate swagger in OpenAPIv2"
@doc("Target for the evaluation process.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model EvaluationTarget {
  @doc("System message related to the evaluation target.")
  systemMessage: string;

  @doc("Model configuration for the evaluation.")
  modelConfig: TargetModelConfig;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Needed since value type is not fixed"
  @doc("A dictionary of parameters for the model.")
  modelParams?: Record<unknown>;
}

@doc("Evaluation Definition")
@resource("runs")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model Evaluation {
  @doc("Identifier of the evaluation.")
  @key("name")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Data for evaluation.")
  data: InputData;

  @doc("Evaluation target specifying the model config and parameters")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  target?: EvaluationTarget;

  @doc("Display Name for evaluation. It helps to find the evaluation easily in AI Foundry. It does not need to be unique.")
  displayName?: string;

  @doc("Description of the evaluation. It can be used to store additional information about the evaluation and is mutable.")
  description?: string;

  @doc("Metadata containing createdBy and modifiedBy information.")
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  @doc("Status of the evaluation. It is set by service and is read-only.")
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("Evaluation's tags. Unlike properties, tags are fully mutable.")
  tags?: Record<string>;

  @doc("Evaluation's properties. Unlike tags, properties are add-only. Once added, a property cannot be removed.")
  properties?: Record<string>;

  @doc("Evaluators to be used for the evaluation.")
  evaluators: Record<EvaluatorConfiguration>;

  @doc("Read-only result outputs. Evaluation Results will have logs and results under the eval_results folder. Example: { 'evaluationResultId': 'azureai://accounts/{AccountName}/projects/{myproject}/evaluationresults/{name}/versions/{version}', 'evaluationMetrics': '{serialized-json-metrics}' }")
  @visibility(Lifecycle.Read)
  outputs: Record<string>;
}

@doc("Message content.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model Content {
  @doc("The type of content.")
  Messages: unknown[];
}

@doc("Represents the data transfer object for an annotation.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model AnnotationDTO {
  @doc("The task associated with the annotation.")
  AnnotationTask: string;

  @doc("The type of content being annotated.")
  ContentType: string;

  @doc("A list of user-provided text inputs.")
  UserTextList: string[];

  @doc("A collection of content objects related to the annotation.")
  Contents: Content[];

  @doc("A list of metrics associated with the annotation.")
  MetricList: string[];

  @doc("The version of the prompt used for the annotation.")
  PromptVersion: string;

  @doc("The user agent information.")
  UserAgent: string;

  @doc("The partner identifier.")
  PartnerId: string;

  @doc("The model identifier.")
  ModelId: string;

  @doc("The type of inference performed.")
  InferenceType: string;

  @doc("The client request identifier.")
  ClientRequestId: string;
}

@doc("Upload a local SDK evaluation run. Currently update supports status, outputs, properties, and tags updates.")
@resource("runs")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model EvaluationUpload {
  @doc("Identifier of the evaluation.")
  @key("name")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Data for evaluation.")
  data?: InputData;

  @doc("Evaluation target specifying the model config and parameters")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  target?: EvaluationTarget;

  @doc("Display Name for evaluation. It helps to find the evaluation easily in AI Foundry. It does not need to be unique.")
  displayName?: string;

  @doc("Description of the evaluation. It can be used to store additional information about the evaluation and is mutable.")
  description?: string;

  @doc("Metadata containing createdBy and modifiedBy information.")
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  @doc("Status of the evaluation. For upload: Failed or Completed.")
  status?: string;

  @doc("Evaluation's tags. Unlike properties, tags are fully mutable.")
  tags?: Record<string>;

  @doc("Evaluation's properties. Unlike tags, properties are add-only. Once added, a property cannot be removed.")
  properties?: Record<string>;

  @doc("Evaluators to be used for the evaluation.")
  evaluators?: Record<EvaluatorConfiguration>;

  @doc("Outputs of the evaluation as a dictionary of IDs. Example: { 'evaluationResultId': 'azureai://accounts/{AccountName}/projects/{myproject}/evaluationresults/{name}/versions/{version}'}")
  outputs?: Record<string>;
}

