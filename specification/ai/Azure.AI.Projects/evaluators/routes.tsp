import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "./models.tsp";
import "../servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ListEvaluatorVersionsParameters = {};
alias EvaluatorInputParameters = InputParameters<
  EvaluatorVersion,
  "evaluatorVersion"
>;

@added(Versions.v2025_10_15_preview)
interface Evaluators {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @get
  @doc("List all versions of the given Evaluator name", EvaluatorVersion)
  @route("/evaluators/{name}/versions")
  listEvaluatorVersions(
    @doc("Name of the evaluator")
    @path
    name: string,

    ...OpenAIListRequestOptions,
  ): OpenAIPageableListOf<EvaluatorVersion>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @get
  @doc("List the latest version of each Evaluator", EvaluatorVersion)
  @route("/evaluators")
  listVersions(
    ...OpenAIListRequestOptions,
  ): OpenAIPageableListOf<EvaluatorVersion>;

  // GET /evaluators/{name}/versions/{version}
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc(
    "Get the specific version of the {name}. The service returns 404 Not Found error if the {name} does not exist.",
    EvaluatorVersion
  )
  getEvaluatorVersion is Azure.Core.Foundations.ResourceOperation<
    EvaluatorVersion,
    {
      @doc(
        "The specific version id of the {name} to retrieve.",
        EvaluatorVersion
      )
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    Azure.Core.Foundations.ResourceOkResponse<EvaluatorVersion>
  >;

  // DELETE /evaluators/{name}/versions/{version}
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc(
    "Delete the specific version of the {name}. The service returns 204 No Content if the {name} was deleted successfully or if the {name} does not exist.",
    EvaluatorVersion
  )
  @Http.delete
  deleteEvaluatorVersion is Azure.Core.Foundations.ResourceOperation<
    EvaluatorVersion,
    {
      @doc("The version of the {name} to delete.", EvaluatorVersion)
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    Http.NoContentResponse
  >;

  // POST /evaluators/{evaluatorName}/versions
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Create a new {name} with auto incremented version id", EvaluatorVersion)
  @Rest.segment("versions")
  @Http.post
  createEvaluatorVersion is Azure.Core.Foundations.ResourceOperation<
    EvaluatorVersion,
    ListEvaluatorVersionsParameters,
    Azure.Core.Foundations.ResourceCreatedResponse<EvaluatorVersion>
  >;

  // PATCH /evaluators/{evaluatorName}/versions/{version}
  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Update an existing {name} with the given version id", EvaluatorVersion)
  @Http.patch
  updateEvaluatorVersion is Azure.Core.Foundations.ResourceOperation<
    EvaluatorVersion,
    {
      @doc("The version of the {name} to update.", EvaluatorVersion)
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    Azure.Core.Foundations.ResourceOkResponse<EvaluatorVersion>
  >;
}
