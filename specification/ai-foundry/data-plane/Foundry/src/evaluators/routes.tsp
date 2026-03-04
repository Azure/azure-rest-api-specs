import "../common/models.tsp";
import "../servicepatterns.tsp";
import "../datasets/models.tsp";
import "./models.tsp";

namespace Azure.AI.Projects;

alias EvaluatorsPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.evaluations_v1_preview>;

alias ListEvaluatorVersionsParameters = {
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  @doc("Filter evaluators by type. Possible values: 'all', 'custom', 'builtin'.")
  @Http.query
  type?: EvaluatorType | "all";

  @doc("A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20.")
  @Http.query
  limit?: int32 = 20;
};

@tag("Evaluators")
interface Evaluators {
  // GET /evaluators/{name}/versions
  #suppress "@azure-tools/typespec-azure-core/verb-conflict" "Resource action used as a building block."
  @doc("List all versions of the given evaluator")
  @Rest.action("versions")
  @Rest.actionSeparator("/")
  @Http.get
  @list
  listVersions is Azure.Core.StandardResourceOperations.ResourceAction<
    EvaluatorVersion,
    ListEvaluatorVersionsParameters & EvaluatorsPreviewHeader,
    Azure.Core.Page<EvaluatorVersion>
  >;

  // GET /evaluators
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("List the latest version of each evaluator")
  @Rest.listsResource(EvaluatorVersion)
  listLatestVersions is Azure.Core.Foundations.ResourceList<
    EvaluatorVersion,
    ListEvaluatorVersionsParameters & EvaluatorsPreviewHeader,
    Azure.Core.Page<EvaluatorVersion>
  >;

  // GET /evaluators/{name}/versions/{version}
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc(
    "Get the specific version of the {name}. The service returns 404 Not Found error if the {name} does not exist.",
    EvaluatorVersion
  )
  getVersion is Azure.Core.Foundations.ResourceOperation<
    EvaluatorVersion,
    {
      ...EvaluatorsPreviewHeader;

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
  deleteVersion is Azure.Core.Foundations.ResourceOperation<
    EvaluatorVersion,
    {
      ...EvaluatorsPreviewHeader;

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
  createVersion is Azure.Core.Foundations.ResourceOperation<
    EvaluatorVersion,
    {
      ...EvaluatorsPreviewHeader;

      @Http.bodyRoot
      evaluatorVersion: EvaluatorVersion;
    },
    Azure.Core.Foundations.ResourceCreatedResponse<EvaluatorVersion>
  >;

  // PATCH /evaluators/{evaluatorName}/versions/{version}
  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Update an existing {name} with the given version id", EvaluatorVersion)
  @Http.patch(#{ implicitOptionality: true })
  updateVersion is Azure.Core.Foundations.ResourceOperation<
    EvaluatorVersion,
    {
      ...EvaluatorsPreviewHeader;

      @doc("The version of the {name} to update.", EvaluatorVersion)
      @Rest.segment("versions")
      @Http.path
      version: string;

      @doc("Evaluator resource")
      @Http.bodyRoot
      evaluatorVersion: EvaluatorVersion;
    },
    Azure.Core.Foundations.ResourceOkResponse<EvaluatorVersion>
  >;

  // POST /evaluators/{evaluatorName}/versions/{version}/startPendingUpload
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Start a new or get an existing pending upload of an evaluator for a specific version.")
  @Rest.action("startPendingUpload")
  startPendingUpload is Azure.Core.Foundations.ResourceOperation<
    EvaluatorVersion,
    {
      ...EvaluatorsPreviewHeader;

      @doc("The pending upload request parameters")
      @Http.bodyRoot
      pendingUploadRequest: PendingUploadRequest;

      @doc("The specific version id of the EvaluatorVersion to operate on.")
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    PendingUploadResponse
  >;

  // POST /evaluators/{evaluatorName}/versions/{version}/credentials
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get the SAS credential to access the storage account associated with an Evaluator version.")
  @Http.post
  @Rest.action("credentials")
  @Rest.actionSeparator("/")
  getCredentials is Azure.Core.Foundations.ResourceOperation<
    EvaluatorVersion,
    {
      ...EvaluatorsPreviewHeader;

      @doc("The credential request parameters")
      @Http.bodyRoot
      credentialRequest: EvaluatorCredentialRequest;

      @doc("The specific version id of the EvaluatorVersion to operate on.")
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    AssetCredentialResponse
  >;
}
