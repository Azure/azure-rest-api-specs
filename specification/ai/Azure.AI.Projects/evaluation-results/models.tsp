import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

@doc("Evaluation Result resource Definition")
@Rest.resource("evaluationResults")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model EvaluationResult {
  @doc("Type of Evaluation result")
  ResultType?: ResultType;

  @doc("Blob URI")
  BlobUri?: string;

  ...AssetBase;
}

@doc("Type of Evaluation result")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
union ResultType {
  string,

  @doc("Benchmark result")
  Benchmark: "Benchmark";

  @doc("Evaluations Result")
  Evaluation: "Evaluation";

  @doc("Red Team Result")
  Redteam: "Redteam";

  @doc("Simulation Result")
  Simulation: "Simulation";
}
