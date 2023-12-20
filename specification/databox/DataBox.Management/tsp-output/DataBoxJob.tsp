import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataBox;
@doc("Job Resource.")
model DataBoxJob is TrackedResource<JobProperties> {
  @doc("The name of the job Resource within the specified resource group. job names must be between 3 and 24 characters in length and use any alphanumeric and underscore only")
  @maxLength(24)
  @minLength(3)
  @pattern("^[-\\w\\.]+$")
  @path
  @key("jobName")
  @segment("jobs")
  name: string;
}

@armResourceOperations
interface DataBoxJobs {
  @doc("Gets information about the specified job.")
  get is ArmResourceRead<
    DataBoxJob,
    {
      ...BaseParameters<DataBoxJob>;

      @doc("$expand is supported on details parameter for job, which provides details on the job stages.")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Creates a new job with the specified parameters. Existing job cannot be updated with this API and should instead be updated with the Update job API.")
  create is ArmResourceCreateOrUpdateAsync<DataBoxJob>;
  @doc("Updates the properties of an existing job.")
  update is ArmResourcePatchAsync<
    DataBoxJob,
    JobProperties,
    {
      ...BaseParameters<DataBoxJob>;

      @doc("Defines the If-Match condition. The patch will be performed only if the ETag of the job on the server matches this value.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Deletes a job.")
  delete is ArmResourceDeleteAsync<DataBoxJob>;
  @doc("Lists all the jobs available under the given resource group.")
  listByResourceGroup is ArmResourceListByParent<
    DataBoxJob,
    {
      ...BaseParameters<DataBoxJob>;

      @doc("$skipToken is supported on Get list of jobs, which provides the next page in the list of jobs.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
  @doc("Lists all the jobs available under the subscription.")
  list is ArmListBySubscription<DataBoxJob>;
  @doc("Request to mark devices for a given job as shipped")
  markDevicesShipped is ArmResourceActionNoContentSync<
    DataBoxJob,
    MarkDevicesShippedRequest
  >;
  @doc("Book shipment pick up.")
  bookShipmentPickUp is ArmResourceActionSync<
    DataBoxJob,
    ShipmentPickUpRequest,
    ShipmentPickUpResponse
  >;
  @doc("CancelJob.")
  cancel is ArmResourceActionNoContentSync<DataBoxJob, CancellationReason>;
  @doc("This method gets the unencrypted secrets related to the job.")
  listCredentials is ArmResourceActionSync<
    DataBoxJob,
    void,
    UnencryptedCredentialsList
  >;
  @doc("Request to mitigate for a given job")
  mitigate is ArmResourceActionNoContentSync<DataBoxJob, MitigateJobRequest>;
}
