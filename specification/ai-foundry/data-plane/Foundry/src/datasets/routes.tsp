import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

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
