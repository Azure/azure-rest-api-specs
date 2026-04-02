import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";
import "../servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects;

alias ListEvaluationSuiteVersionsParameters = {};

alias EvaluationSuiteFilterQueryParams = {
  @query("agentName")
  @doc("Filter by associated agent name.")
  agentName?: string;

  @query("kind")
  @doc("Filter by evaluation suite kind (batch or continuous).")
  kind?: EvaluationSuiteKind;
};

@added(Versions.v2025_10_15_preview)
interface EvaluationSuites
  extends VersionedOperations<
      EvaluationSuiteVersion,
      InputParameters<EvaluationSuiteVersion, "evaluationSuiteVersion">,
      EvaluationSuiteFilterQueryParams,
      ListEvaluationSuiteVersionsParameters
    > {
}
