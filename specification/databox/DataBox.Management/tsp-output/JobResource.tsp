import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBox;
@doc("Job Resource.")
model JobResource is TrackedResource<JobProperties> {
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
interface JobResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets information about the specified job.")
  @operationId("Jobs_Get")
  get is ArmResourceRead<
    JobResource,
    {
      ...BaseParameters<JobResource>;

      @doc("$expand is supported on details parameter for job, which provides details on the job stages.")
      @query("$expand")
      $expand?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a new job with the specified parameters. Existing job cannot be updated with this API and should instead be updated with the Update job API.")
  @operationId("Jobs_Create")
  create is ArmResourceCreateOrUpdateAsync<JobResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the properties of an existing job.")
  @operationId("Jobs_Update")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a job.")
  @operationId("Jobs_Delete")
  delete is ArmResourceDeleteAsync<JobResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all the jobs available under the given resource group.")
  @operationId("Jobs_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    JobResource,
    {
      ...BaseParameters<JobResource>;

      @doc("$skipToken is supported on Get list of jobs, which provides the next page in the list of jobs.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all the jobs available under the subscription.")
  @operationId("Jobs_List")
  list is ArmListBySubscription<JobResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Request to mark devices for a given job as shipped")
  @operationId("Jobs_MarkDevicesShipped")
  markDevicesShipped is ArmResourceActionNoContentSync<
    JobResource,
    MarkDevicesShippedRequest
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Book shipment pick up.")
  @operationId("Jobs_BookShipmentPickUp")
  bookShipmentPickUp is ArmResourceActionSync<
    JobResource,
    ShipmentPickUpRequest,
    ShipmentPickUpResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("CancelJob.")
  @operationId("Jobs_Cancel")
  cancel is ArmResourceActionNoContentSync<JobResource, CancellationReason>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("This method gets the unencrypted secrets related to the job.")
  @operationId("Jobs_ListCredentials")
  listCredentials is ArmResourceActionSync<
    JobResource,
    void,
    UnencryptedCredentialsList
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Request to mitigate for a given job")
  @operationId("Mitigate")
  mitigate is ArmResourceActionNoContentSync<JobResource, MitigateJobRequest>;
}

@@projectedName(JobResources.create::parameters.resource,
  "json",
  "jobResource"
);
@@extension(JobResources.create::parameters.resource,
  "x-ms-client-name",
  "jobResource"
);
@@doc(JobResources.create::parameters.resource,
  "Job details from request body."
);
@@projectedName(JobResources.update::parameters.properties,
  "json",
  "jobResourceUpdateParameter"
);
@@extension(JobResources.update::parameters.properties,
  "x-ms-client-name",
  "jobResourceUpdateParameter"
);
@@doc(JobResources.update::parameters.properties,
  "Job update parameters from request body."
);
@@projectedName(JobResources.markDevicesShipped::parameters.body,
  "json",
  "markDevicesShippedRequest"
);
@@extension(JobResources.markDevicesShipped::parameters.body,
  "x-ms-client-name",
  "markDevicesShippedRequest"
);
@@doc(JobResources.markDevicesShipped::parameters.body,
  "Mark Devices Shipped Request"
);
@@projectedName(JobResources.bookShipmentPickUp::parameters.body,
  "json",
  "shipmentPickUpRequest"
);
@@extension(JobResources.bookShipmentPickUp::parameters.body,
  "x-ms-client-name",
  "shipmentPickUpRequest"
);
@@doc(JobResources.bookShipmentPickUp::parameters.body,
  "Details of shipment pick up request."
);
@@projectedName(JobResources.cancel::parameters.body,
  "json",
  "cancellationReason"
);
@@extension(JobResources.cancel::parameters.body,
  "x-ms-client-name",
  "cancellationReason"
);
@@doc(JobResources.cancel::parameters.body, "Reason for cancellation.");
@@projectedName(JobResources.mitigate::parameters.body,
  "json",
  "mitigateJobRequest"
);
@@extension(JobResources.mitigate::parameters.body,
  "x-ms-client-name",
  "mitigateJobRequest"
);
@@doc(JobResources.mitigate::parameters.body, "Mitigation Request");
