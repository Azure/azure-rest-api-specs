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
using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects;

alias ListEvaluatorVersionsParameters = {};
alias EvaluatorInputParameters = InputParameters<EvaluatorVersion, "evaluatorVersion">;

@added(Versions.v2025_05_15_preview)
interface Evaluators {
  // GET /evaluators/{evaluatorName}/versions
  #suppress "@azure-tools/typespec-azure-core/verb-conflict" "Resource action used as a building block."
  @doc("List all versions of the given {name}", EvaluatorVersion)
  @Rest.action("versions")
  @Rest.actionSeparator("/")
  @Http.get
  @list
  listEvaluatorVersions is Azure.Core.StandardResourceOperations.ResourceAction<
    EvaluatorVersion,
    ListEvaluatorVersionsParameters,
    Azure.Core.Page<EvaluatorVersion>
  >;

  // GET /evaluators/{evaluatorName}/versions
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("List the latest version of each {name}", EvaluatorVersion)
  @Rest.listsResource(EvaluatorVersion)
  listVersions is Azure.Core.Foundations.ResourceList<
    EvaluatorVersion,
    ListEvaluatorVersionsParameters,
    Azure.Core.Page<EvaluatorVersion>
  >;

  // GET /evaluators/{evaluatorName}/versions/{version}
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

  // DELETE /evaluators/{evaluatorName}/versions/{version}
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
  @doc("Create an existing {name} with the given version id", EvaluatorVersion)
  @Http.post
  createEvaluatorVersion is Azure.Core.Foundations.ResourceOperation<
    EvaluatorVersion,
    ListEvaluatorVersionsParameters,
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<EvaluatorCreateResult>
  >;

  // PATCH /evaluators/{evaluatorName}/versions/{version}
  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Update an existing {name} with the given version id", EvaluatorVersion)
  @Http.patch
  updateEvaluatorVersion is Azure.Core.Foundations.ResourceOperation<
    EvaluatorVersion,
    {
      @doc("The version of the {name} to delete.", EvaluatorVersion)
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<EvaluatorVersion>
  >;
}
