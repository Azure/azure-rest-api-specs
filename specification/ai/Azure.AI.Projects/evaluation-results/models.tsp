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
@discriminator("EvaluationResultType")
model EvaluationResult {
  @doc("Type of Evaluation result")
  EvaluationResultType: EvaluationResultType;

  @doc("Model Name")
  ModelName: string;

  @doc("Model Version")
  ModelVersion: string;

  @doc("Model Asset ID")
  ModelAssetId: string;

  @doc("Dataset Family")
  DatasetFamily: string;

  @doc("Dataset Name")
  DatasetName: string;

  @doc("Metrics")
  Metrics: Record<string, float64>;

  @doc("Blob URI")
  @extension("x-ms-blob-reference", true)
  BlobUri: string;

  // todo where is this class defined?
  ...AssetBase;
}

@doc("Paged collection of Evaluation Result items.")
@pagedResult
model PagedEvaluationResult {
  @doc("The list of Evaluation Results.")
  @extension("x-ms-identifiers", [])
  @items
  value: EvaluationResult[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: ResourceLocation<EvaluationResult>;
}

union EvaluationResultType {
  string,

  @doc("Cloud Evaluation Result")
  CloudEvaluationResult: "CloudEvaluationResult",

  @doc("Red Team Result")
  RedTeamResult: "RedTeamResult",

  @doc("Benchmark result: legacy")
  BenchmarkResult: "BenchmarkResult",
}
