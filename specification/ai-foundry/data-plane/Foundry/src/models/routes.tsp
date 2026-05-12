import "./models.tsp";
import "../servicepatterns.tsp";
import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ListModelVersionsParameters = {};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@tag("Models")
interface Models
  extends VersionedOperations<
      ModelVersion,
      InputParameters<UpdateModelVersionRequest>,
      ListModelVersionsParameters,
      ListModelVersionsParameters
    > {
  // The method name `createOrUpdateVersion` is required by the `VersionedOperations` interface
  // template this interface extends. However, for Models the PATCH endpoint only performs updates —
  // new model versions are created via the `createAsync` endpoint (which handles blob content
  // validation). The `@operationId` override to "Models_updateVersion" reflects the true semantics.
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Suppress `Operation should be defined using a signature from the Azure.Core namespace.`"
  @doc("Update an existing ModelVersion with the given version id", ModelVersion)
  @operationId("Models_updateVersion")
  @patch
  createOrUpdateVersion is Azure.Core.Foundations.ResourceOperation<
    ModelVersion,
    InputParameters<UpdateModelVersionRequest>,
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<ModelVersion>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom async creation action"
  @doc("Creates a model version asynchronously with blob content validation. Returns 202 Accepted with a Location header for polling.")
  @route("/models/{name}/versions/{version}/createAsync")
  @post
  createAsync is Azure.Core.Foundations.Operation<
    {
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
  startPendingUpload is Azure.Core.Foundations.Operation<
    {
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
  getCredentials is Azure.Core.Foundations.Operation<
    {
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
