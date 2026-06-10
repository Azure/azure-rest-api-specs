import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(Workspace)
model JobBaseData
  is Azure.ResourceManager.ProxyResource<JobBaseDetails, false> {
  ...ResourceNameParameter<
    Resource = JobBaseData,
    KeyName = "id",
    SegmentName = "jobs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Jobs {
  /**
   * Gets a Job by name/id.
   */
  get is ArmResourceRead<JobBaseData>;

  /**
   * Creates and executes a Job.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<JobBaseData>;

  /**
   * Deletes a Job (asynchronous).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    JobBaseData,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * Lists Jobs in the workspace.
   */
  list is ArmResourceListByParent<
    JobBaseData,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;

      /**
       * Type of job to be returned.
       */
      @query("jobType")
      jobType?: string;

      /**
       * Jobs returned will have this tag key.
       */
      @query("tag")
      tag?: string;

      /**
       * View type for including/excluding (for example) archived entities.
       */
      @query("listViewType")
      listViewType?: ListViewType;

      /**
       * Indicator whether the job is scheduled job.
       */
      @query("scheduled")
      scheduled?: boolean;

      /**
       * The scheduled id for listing the job triggered from
       */
      @query("scheduleId")
      scheduleId?: string;
    },
    Response = ArmResponse<JobBaseResourceArmPaginatedResult>
  >;

  /**
   * Cancels a Job.
   */
  cancel is ArmResourceActionSync<JobBaseData, void, OkResponse>;
}

@@doc(
  JobBaseData.name,
  "The name and identifier for the Job. This is case-sensitive."
);
@@doc(
  JobBaseData.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(Jobs.createOrUpdate::parameters.resource, "Job definition object.");
