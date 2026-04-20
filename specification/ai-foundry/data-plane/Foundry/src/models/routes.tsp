import "./models.tsp";
import "../servicepatterns.tsp";
import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ListModelVersionsParameters = {};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@tag("Models")
interface Models
  extends VersionedOperations<
      ModelVersion,
      InputParameters<ModelVersion>,
      ListModelVersionsParameters,
      ListModelVersionsParameters
    > {
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
      body: ModelPendingUploadRequest;
    },
    ModelTemporaryDataReference
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom credential fetch action"
  @doc("Fetch credentials for a model version asset.")
  @route("/models/{name}/versions/{version}/credentials")
  @post
  fetchCredentials is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the model.")
      @path
      name: string;

      @doc("Version of the model.")
      @path
      version: string;

      @bodyRoot
      body: ModelAssetCredentialRequest;
    },
    AssetCredentialResponse
  >;
}
