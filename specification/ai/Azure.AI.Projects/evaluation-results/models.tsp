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

@doc("Evaluation result for agent run.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
model AgentEvaluationResult {
  @doc("Evaluator's name. This is the name of the evaluator that was used to evaluate the agent's completion.")
  evaluator: string;

  @doc("Score of the given evaluator. No restriction on range.")
  score: float32;

  @doc("Status of the evaluation result. Options: Success, Failure, NotApplicable.")
  status: string;

  @doc("Reasoning for the evaluation result.")
  reason?: string;

  @doc("Version of the evaluator that was used to evaluate the agent's completion.")
  version?: string;

  @doc("The unique identifier of the thread.")
  threadId?: string;

  @doc("The unique identifier of the run.")
  runId: string;

  @doc("A string explaining why there was an error, if applicable.")
  error?: string;

  @doc("Additional properties relevant to the evaluator. These will differ between evaluators.")
  additionalDetails?: Record<string>;
}
