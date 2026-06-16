import "./models.tsp";
import "../common/servicepatterns.tsp";
import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ModelsPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.models_v1_preview>;

alias ListModelVersionsParameters = {};

const ModelsRequiredPreviews = #{
  required_previews: #[FoundryFeaturesOptInKeys.models_v1_preview],
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
  /** Retrieves the specified model version, returning 404 if it does not exist. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Suppress `Operation should be defined using a signature from the Azure.Core namespace.`"
  @summary("Get a model version")
  @extension("x-ms-foundry-meta", ModelsRequiredPreviews)
  getVersion is FoundryResourceOperation<
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

  /** Removes the specified model version. Returns 200 whether the version existed or not. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Suppress `Operation should be defined using a signature from the Azure.Core namespace.`"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Delete returns 200 with no body by service design"
  @summary("Delete a model version")
  @doc("Delete the specific version of the ModelVersion. The service returns 200 OK if the ModelVersion was deleted successfully or if the ModelVersion does not exist.")
  @delete
  @extension("x-ms-foundry-meta", ModelsRequiredPreviews)
  deleteVersion is FoundryResourceOperation<
    ModelVersion,
    {
      ...ModelsPreviewHeader;

      @doc("The version of the ModelVersion to delete.")
      @Rest.segment("versions")
      @path
      version: string;
    },
    OkResponse
  >;

  // The method name `createOrUpdateVersion` is required by the `VersionedOperations` interface
  // template this interface extends. However, for Models the PATCH endpoint only performs updates —
  // new model versions are created via the `createAsync` endpoint (which handles blob content
  // validation). The `@operationId` override to "Models_updateVersion" reflects the true semantics.
  /** Updates an existing model version identified by its version ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Suppress `Operation should be defined using a signature from the Azure.Core namespace.`"
  @summary("Update a model version")
  @doc(
    "Update an existing ModelVersion with the given version id",
    ModelVersion
  )
  @operationId("Models_updateVersion")
  @patch
  @extension("x-ms-foundry-meta", ModelsRequiredPreviews)
  createOrUpdateVersion is FoundryResourceOperation<
    ModelVersion,
    InputParameters<UpdateModelVersionRequest, "model_version_update"> &
      ModelsPreviewHeader,
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<ModelVersion>
  >;

  /** Creates a model version asynchronously with blob content validation. Returns 202 Accepted with a location header for polling the operation status. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom async creation action"
  @summary("Create a model version async")
  @route("/models/{name}/versions/{version}/createAsync")
  @post
  @extension("x-ms-foundry-meta", ModelsRequiredPreviews)
  createAsync is FoundryOperation<
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
      model_version: ModelVersion;
    },
    CreateModelVersionAsyncResponse
  >;

  /** Initiates a new pending upload or retrieves an existing one for the specified model version. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom pending upload action"
  @summary("Start a pending upload")
  @route("/models/{name}/versions/{version}/startPendingUpload")
  @post
  @extension("x-ms-foundry-meta", ModelsRequiredPreviews)
  startPendingUpload is FoundryOperation<
    {
      ...ModelsPreviewHeader;

      @doc("Name of the model.")
      @path
      name: string;

      @doc("Version of the model.")
      @path
      version: string;

      @bodyRoot
      pending_upload_request: ModelPendingUploadRequest;
    },
    ModelPendingUploadResponse
  >;

  /** Retrieves temporary credentials for accessing the storage backing the specified model version. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom credential action"
  @summary("Get model asset credentials")
  @route("/models/{name}/versions/{version}/credentials")
  @post
  @extension("x-ms-foundry-meta", ModelsRequiredPreviews)
  getCredentials is FoundryOperation<
    {
      ...ModelsPreviewHeader;

      @doc("Name of the model.")
      @path
      name: string;

      @doc("Version of the model.")
      @path
      version: string;

      @bodyRoot
      credential_request: ModelCredentialRequest;
    },
    AssetCredentialResponse
  >;
}
