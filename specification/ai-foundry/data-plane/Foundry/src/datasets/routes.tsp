import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";
import "../task-sets/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ListDatasetVersionsParameters = {};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@tag("Datasets")
interface Datasets
  extends VersionedOperations<
      DatasetVersion,
      InputParameters<DatasetVersion, "datasetVersion">,
      ListDatasetVersionsParameters,
      ListDatasetVersionsParameters
    > {
  /** Starts validation of the current Task manifest on a taskset Dataset version. */
  @summary("Validate evaluation Task content")
  @post
  @route("/datasets/{name}/versions/{version}:validate")
  @removed(Versions.v1)
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  validate is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** Dataset name. */
      @path name: string;

      /** Dataset version to validate. */
      @path version: string;
    },
    Response<202> &
      DatasetVersion & {
        /** URL of the Dataset version to poll for validation status. */
        @header("Location") location: string;

        /** Recommended delay before polling, in seconds. */
        @header("Retry-After") retry_after?: int32;
      }
  >;

  /** Initiates a new pending upload or retrieves an existing one for the specified dataset version. */
  @summary("Start a pending upload")
  @Rest.action("startPendingUpload")
  startPendingUploadVersion is FoundryResourceOperation<
    DatasetVersion,
    {
      @doc("The pending upload request parameters")
      @Http.bodyRoot
      @clientName("configuration", "csharp")
      pendingUploadRequest: PendingUploadRequest;

      @doc("The specific version id of the DatasetVersion to operate on.")
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    PendingUploadResponse
  >;

  /** Retrieves the SAS credential to access the storage account associated with a dataset version. */
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Get dataset credentials")
  @post
  @Rest.action("credentials")
  @Rest.actionSeparator("/")
  getCredentials is FoundryResourceOperation<
    DatasetVersion,
    {
      @doc("The specific version id of the DatasetVersion to operate on.")
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    AssetCredentialResponse
  >;
}
