import "../common/models.tsp";
import "../servicepatterns.tsp";
import "./models.tsp";

namespace Azure.AI.Projects;
using Http;
using OpenAPI;
using Rest;
using TypeSpec.Versioning;

alias ListEvaluationSuiteVersionsParameters = {};

alias EvaluationSuiteFilterQueryParams = {
  @query("agentName")
  @doc("Filter by associated agent name.")
  agentName?: string;

  @query("kind")
  @doc("Filter by evaluation suite kind (dataset_backed or evaluator_only).")
  kind?: EvaluationSuiteKind;
};

interface EvaluationSuites
  extends VersionedOperations<
      EvaluationSuiteVersion,
      InputParameters<EvaluationSuiteVersion, "evaluationSuiteVersion">,
      EvaluationSuiteFilterQueryParams,
      ListEvaluationSuiteVersionsParameters
    > {

  // POST /evaluationSuites/{name}/versions
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Create a new {name} with auto incremented version id", EvaluationSuiteVersion)
  @Rest.segment("versions")
  @post
  createEvaluationSuiteVersion is Azure.Core.Foundations.ResourceOperation<
    EvaluationSuiteVersion,
    ListEvaluationSuiteVersionsParameters,
    Azure.Core.Foundations.ResourceCreatedResponse<EvaluationSuiteVersion>
  >;
}
