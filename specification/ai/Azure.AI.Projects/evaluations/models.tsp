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

  @doc("Read-only result outputs. Example: { 'evaluationResultId': 'azureai://accounts/{AccountName}/projects/{projectName}/evaluationresults/{name}/{version}', 'logId': 'azureai://accounts/{AccountName}/projects/{projectName}/datasets/{dataset-name}/{dataset-version}' }")
  @visibility(Lifecycle.Read)
  outputs: Record<string>;
}

// Any other requirements?
@doc("Evaluation Result resource Definition")
@resource("results")
@parentResource(Evaluation)
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model EvaluationResult {
  @doc("Identifier of the evaluation result.")
  @key("name")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Type of Evaluation result")
  ResultType?: ResultType;

  @doc("Metrics")
  Metrics?: Record<float64>;

  @doc("Blob URI")
  BlobUri?: string;
}

@doc("Type of Evaluation result")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
union ResultType {
  string,

  @doc("Benchmark result")
  Benchmark: "Benchmark",

  @doc("Evaluations Result")
  Evaluation: "Evaluation",

  @doc("Red Team Result")
  Redteam: "Redteam",

  @doc("Simulation Result")
  Simulation: "Simulation",
}
