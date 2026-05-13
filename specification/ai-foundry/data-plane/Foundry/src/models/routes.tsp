import "./models.tsp";
import "../servicepatterns.tsp";
import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ModelsPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.models_v1_preview>;

alias ListModelVersionsParameters = {};

const ModelsRequiredPreviews = #{
  required_previews: #[
    FoundryFeaturesOptInKeys.models_v1_preview
  ],
};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@tag("Models")
interface Models
  extends VersionedOperations<
      ModelVersion,
      InputParameters<UpdateModelVersionRequest>,
      ListModelVersionsParameters & ModelsPreviewHeader,
      ListModelVersionsParameters & ModelsPreviewHeader
    > {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Suppress `Operation should be defined using a signature from the Azure.Core namespace.`"
  @doc(
    "Get the specific version of the {name}. The service returns 404 Not Found error if the {name} does not exist.",
    ModelVersion
  )
  @extension("x-ms-foundry-meta", ModelsRequiredPreviews)
  getVersion is Azure.Core.Foundations.ResourceOperation<
    ModelVersion,
    {
      ...ModelsPreviewHeader;

      @doc("The specific version id of the {name} to retrieve.", ModelVersion)
      @Rest.segment("versions")
      @path
      version: string;
    },
    Azure.Core.Foundations.ResourceOkResponse<ModelVersion>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Suppress `Operation should be defined using a signature from the Azure.Core namespace.`"
  @doc(
    "Delete the specific version of the {name}. The service returns 204 No Content if the {name} was deleted successfully or if the {name} does not exist.",
    ModelVersion
  )
  @delete
  @extension("x-ms-foundry-meta", ModelsRequiredPreviews)
  deleteVersion is Azure.Core.Foundations.ResourceOperation<
    ModelVersion,
    {
      ...ModelsPreviewHeader;

      @doc("The version of the {name} to delete.", ModelVersion)
      @Rest.segment("versions")
      @path
      version: string;
    },
    NoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Suppress `Operation should be defined using a signature from the Azure.Core namespace.`"
  @doc("Update an existing ModelVersion with the given version id", ModelVersion)
  @operationId("Models_updateVersion")
  @patch
  @extension("x-ms-foundry-meta", ModelsRequiredPreviews)
  createOrUpdateVersion is Azure.Core.Foundations.ResourceOperation<
    ModelVersion,
    InputParameters<UpdateModelVersionRequest> & ModelsPreviewHeader,
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<ModelVersion>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom async creation action"
  @doc("Creates a model version asynchronously with blob content validation. Returns 202 Accepted with a Location header for polling.")
  @route("/models/{name}/versions/{version}/createAsync")
  @post
  @extension("x-ms-foundry-meta", ModelsRequiredPreviews)
  createAsync is Azure.Core.Foundations.Operation<
    {
      ...ModelsPreviewHeader;

      @doc("Name of the model.")
      @path
      name: string;

      @doc("Version of the model.")
      @path
      version: string;

      @doc("Model version to create.")
      @bodyRoot
      body: ModelVersion;
    },
    CreateModelVersionAsyncResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom pending upload action"
  @doc("Start or retrieve a pending upload for a model version.")
  @route("/models/{name}/versions/{version}/startPendingUpload")
  @post
  @extension("x-ms-foundry-meta", ModelsRequiredPreviews)
  startPendingUpload is Azure.Core.Foundations.Operation<
    {
      ...ModelsPreviewHeader;

      @doc("Name of the model.")
      @path
      name: string;

      @doc("Version of the model.")
      @path
      version: string;

      @bodyRoot
      body: PendingUploadRequest;
    },
    PendingUploadResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom credential action"
  @doc("Get credentials for a model version asset.")
  @route("/models/{name}/versions/{version}/credentials")
  @post
  @extension("x-ms-foundry-meta", ModelsRequiredPreviews)
  getCredentials is Azure.Core.Foundations.Operation<
    {
      ...ModelsPreviewHeader;

      @doc("Name of the model.")
      @path
      name: string;

      @doc("Version of the model.")
      @path
      version: string;

      @bodyRoot
      body: ModelCredentialRequest;
    },
    AssetCredentialResponse
  >;
}