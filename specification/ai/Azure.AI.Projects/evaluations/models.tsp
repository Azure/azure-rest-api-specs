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

  @doc("Display Name for evaluation. It helps to find the evaluation easily in AI Foundry. It does not need to be unique.")
  displayName?: string;

  @doc("Description of the evaluation. It can be used to store additional information about the evaluation and is mutable.")
  description?: string;

  @doc("Status of the evaluation. It is set by service and is read-only.")
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("Evaluation's tags. Unlike properties, tags are fully mutable.")
  tags?: Record<string>;

  @doc("Evaluation's properties. Unlike tags, properties are add-only. Once added, a property cannot be removed.")
  properties?: Record<string>;

  @doc("Evaluators to be used for the evaluation.")
  evaluators: Record<EvaluatorConfiguration>;
}

@doc("Definition for sampling strategy.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model SamplingConfiguration {
  @doc("Name of the sampling strategy.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Percentage of sampling per hour.")
  @visibility(Lifecycle.Read)
  samplingPercent: float;

  @doc("Maximum request rate per hour.")
  @visibility(Lifecycle.Read)
  maxRequestRate: float;
}

@doc("Evaluation request for agent run.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model AgentEvaluationRequest {
  @doc("Identifier of the agent thread. This field is mandatory for agent API v1, but will be ignored by agent API v2.")
  @visibility(Lifecycle.Read)
  threadId?: string;

  @doc("Identifier of the agent run.")
  @visibility(Lifecycle.Read)
  runId: string;

  @doc("Evaluators to be used for the evaluation.")
  @visibility(Lifecycle.Read)
  evaluators: Record<EvaluatorConfiguration>;

  @doc("Sampling configuration for the evaluation.")
  @visibility(Lifecycle.Read)
  samplingConfiguration?: SamplingConfiguration;

  @doc("Optional and temporary way to pass the app insights connection string to the evaluator.")
  @visibility(Lifecycle.Read)
  appInsightsConnectionString?: string;
}

@doc("Long running operation response for agent evaluation.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model AgentLongRunningOperationResponse {
  @doc("URI for the long running operation.")
  @visibility(Lifecycle.Read)
  location: string;

  @doc("Result of the long running operation.")
  @visibility(Lifecycle.Read)
  operationResult?: unknown;
}
