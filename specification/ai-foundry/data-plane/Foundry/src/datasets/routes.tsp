import "../common/models.tsp";
import "../servicepatterns.tsp";
import "./models.tsp";
import "../jobs/data_generation_models.tsp";
import "../jobs/routes.tsp";

using TypeSpec.Http;
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
  @doc("Start a new or get an existing pending upload of a dataset for a specific version.")
  @Rest.action("startPendingUpload")
  startPendingUploadVersion is Azure.Core.Foundations.ResourceOperation<
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

  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get the SAS credential to access the storage account associated with a Dataset version.")
  @post
  @Rest.action("credentials")
  @Rest.actionSeparator("/")
  getCredentials is Azure.Core.Foundations.ResourceOperation<
    DatasetVersion,
    {
      @doc("The specific version id of the DatasetVersion to operate on.")
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    AssetCredentialResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Start a data generation job.")
  @post
  @Rest.action("datasets:generate")
  generate is Azure.Core.Foundations.ResourceCollectionOperation<
    DatasetVersion,
    {
      @doc("The data generation job request.")
      @body
      body: DataGenerationJob;
    },
    TypeSpec.Http.Response<202> &
      DataGenerationJob & {
        @doc("The location for checking the status of the job created.")
        @header("Location")
        location: string;
      }
  >;
}
