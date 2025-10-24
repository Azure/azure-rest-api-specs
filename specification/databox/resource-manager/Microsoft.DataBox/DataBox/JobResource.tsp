import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBox;
/**
 * Job Resource.
 */
model JobResource
  is Azure.ResourceManager.TrackedResource<JobProperties, false> {
  ...ResourceNameParameter<
    Resource = JobResource,
    KeyName = "jobName",
    SegmentName = "jobs",
    NamePattern = "^[-\\w\\.]+$"
  >;

  /**
   * The sku type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku: Sku;

  /**
   * Msi identity of the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ResourceIdentity;
}

@armResourceOperations
interface JobResources {
  /**
   * Gets information about the specified job.
   */
  get is ArmResourceRead<
    JobResource,
    Parameters = {
      /**
       * $expand is supported on details parameter for job, which provides details on the job stages.
       */
      @query("$expand")
      $expand?: string;
    },
    Error = ApiError
  >;

  /**
   * Creates a new job with the specified parameters. Existing job cannot be updated with this API and should instead be updated with the Update job API.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ArmResourceCreateOrReplaceAsync<
    JobResource,
    Response = ArmResourceUpdatedResponse<JobResource> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = JobResource> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = ApiError
  >;

  /**
   * Updates the properties of an existing job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    JobResource,
    PatchModel = JobResourceUpdateParameter,
    Parameters = {
      /**
       * Defines the If-Match condition. The patch will be performed only if the ETag of the job on the server matches this value.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Error = ApiError
  >;

  /**
   * Deletes a job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    JobResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = ApiError
  >;

  /**
   * Lists all the jobs available under the given resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    JobResource,
    Parameters = {
      /**
       * $skipToken is supported on Get list of jobs, which provides the next page in the list of jobs.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<JobResourceList>,
    Error = ApiError
  >;

  /**
   * Lists all the jobs available under the subscription.
   */
  list is ArmListBySubscription<
    JobResource,
    Parameters = {
      /**
       * $skipToken is supported on Get list of jobs, which provides the next page in the list of jobs.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<JobResourceList>,
    Error = ApiError
  >;

  /**
   * Book shipment pick up.
   */
  bookShipmentPickUp is ArmResourceActionSync<
    JobResource,
    ShipmentPickUpRequest,
    ArmResponse<ShipmentPickUpResponse>,
    Error = ApiError
  >;

  /**
   * CancelJob.
   */
  cancel is ArmResourceActionSync<
    JobResource,
    CancellationReason,
    NoContentResponse,
    Error = ApiError
  >;

  /**
   * This method gets the unencrypted secrets related to the job.
   */
  @list
  listCredentials is ArmResourceActionSync<
    JobResource,
    void,
    ArmResponse<UnencryptedCredentialsList>,
    Error = ApiError
  >;

  /**
   * Request to mark devices for a given job as shipped
   */
  markDevicesShipped is ArmResourceActionSync<
    JobResource,
    MarkDevicesShippedRequest,
    NoContentResponse,
    Error = ApiError
  >;
}

/**
 * Request to mitigate for a given job
 */
@action("mitigate")
@tag("JobResources")
op mitigate is ArmResourceActionSync<
  JobResource,
  MitigateJobRequest,
  NoContentResponse,
  Error = ApiError
>;

@@maxLength(JobResource.name, 24);
@@minLength(JobResource.name, 3);
@@doc(JobResource.name,
  "The name of the job Resource within the specified resource group. job names must be between 3 and 24 characters in length and use any alphanumeric and underscore only"
);
@@doc(JobResource.properties, "Properties of a job.");
@@doc(JobResources.create::parameters.resource,
  "Job details from request body."
);
@@doc(JobResources.update::parameters.properties,
  "Job update parameters from request body."
);
@@doc(JobResources.bookShipmentPickUp::parameters.body,
  "Details of shipment pick up request."
);
@@doc(JobResources.cancel::parameters.body, "Reason for cancellation.");
@@doc(JobResources.markDevicesShipped::parameters.body,
  "Mark Devices Shipped Request"
);
@@doc(mitigate::parameters.body, "Mitigation Request");
