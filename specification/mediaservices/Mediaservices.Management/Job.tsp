import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Transform.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
/**
 * A Job resource type. The progress and state can be obtained by polling a Job or subscribing to events using EventGrid.
 */
@parentResource(Transform)
model Job is Azure.ResourceManager.ProxyResource<JobProperties> {
  ...ResourceNameParameter<
    Resource = Job,
    KeyName = "jobName",
    SegmentName = "jobs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Jobs {
  /**
   * Gets a Job.
   */
  get is ArmResourceRead<Job>;

  /**
   * Creates a Job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ArmResourceCreateOrReplaceSync<
    Job,
    Response = ArmResourceCreatedSyncResponse<Job>
  >;

  /**
   * Update is only supported for description and priority. Updating Priority will take effect when the Job state is Queued or Scheduled and depending on the timing the priority update may be ignored.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Job, PatchModel = Job>;

  /**
   * Deletes a Job.
   */
  delete is ArmResourceDeleteSync<Job>;

  /**
   * Lists all of the Jobs for the Transform.
   */
  list is ArmResourceListByParent<
    Job,
    Parameters = {
      /**
       * Restricts the set of items returned.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Specifies the key by which the result collection should be ordered.
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<JobCollection>
  >;

  /**
   * Cancel a Job.
   */
  cancelJob is ArmResourceActionSync<Job, void, OkResponse>;
}

@@doc(Job.name, "The Job name.");
@@doc(Job.properties, "The resource properties.");
@@doc(Jobs.create::parameters.resource, "The request parameters");
@@doc(Jobs.update::parameters.properties, "The request parameters");
