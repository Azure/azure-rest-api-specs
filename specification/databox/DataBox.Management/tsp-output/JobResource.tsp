import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DataBox;
@doc("Job Resource.")
model JobResource is TrackedResource<JobProperties> {
  @doc("The name of the job Resource within the specified resource group. job names must be between 3 and 24 characters in length and use any alphanumeric and underscore only")
  @maxLength(24)
  @minLength(3)
  @pattern("^[-\\w\\.]+$")
  @key("jobName")
  @segment("jobs")
  name: string;
}

@armResourceOperations
@projectedName("client", "Jobs")
interface JobResources_Jobs {
  @doc("Gets information about the specified job.")
  get is ArmResourceRead<
    JobResource,
    {
      ...BaseParameters<JobResource>;

      @doc("$expand is supported on details parameter for job, which provides details on the job stages.")
      @query("$expand")
      $expand?: string;
    }
  >;

  @doc("Creates a new job with the specified parameters. Existing job cannot be updated with this API and should instead be updated with the Update job API.")
  create is ArmResourceCreateOrUpdateAsync<JobResource>;

  @doc("Updates the properties of an existing job.")
  update is ArmCustomPatchAsync<
    JobResource,
    JobResourceUpdateParameter,
    {
      ...BaseParameters<JobResource>;

      @doc("Defines the If-Match condition. The patch will be performed only if the ETag of the job on the server matches this value.")
      @header
      `If-Match`?: string;
    }
  >;

  @doc("Deletes a job.")
  delete is ArmResourceDeleteAsync<JobResource>;

  @doc("Lists all the jobs available under the given resource group.")
  listByResourceGroup is ArmResourceListByParent<
    JobResource,
    {
      ...BaseParameters<JobResource>;

      @doc("$skipToken is supported on Get list of jobs, which provides the next page in the list of jobs.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;

  @doc("Lists all the jobs available under the subscription.")
  list is ArmListBySubscription<JobResource>;

  @doc("Request to mark devices for a given job as shipped")
  markDevicesShipped is ArmResourceActionNoContentSync<
    JobResource,
    MarkDevicesShippedRequest
  >;

  @doc("Book shipment pick up.")
  bookShipmentPickUp is ArmResourceActionSync<
    JobResource,
    ShipmentPickUpRequest,
    ShipmentPickUpResponse
  >;

  @doc("CancelJob.")
  cancel is ArmResourceActionNoContentSync<JobResource, CancellationReason>;

  @doc("This method gets the unencrypted secrets related to the job.")
  listCredentials is ArmResourceActionSync<
    JobResource,
    void,
    UnencryptedCredentialsList
  >;
}

@armResourceOperations
@projectedName("client", "")
interface JobResources_ {
  @doc("Request to mitigate for a given job")
  mitigate is ArmResourceActionNoContentSync<JobResource, MitigateJobRequest>;
}
