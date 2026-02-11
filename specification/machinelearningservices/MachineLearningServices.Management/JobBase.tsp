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
model JobBase is Azure.ResourceManager.ProxyResource<JobBaseProperties, false> {
  ...ResourceNameParameter<
    Resource = JobBase,
    KeyName = "id",
    SegmentName = "jobs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface JobBases {
  /**
   * Gets a Job by name/id.
   */
  @summary("Gets a Job by name/id.")
  get is ArmResourceRead<JobBase>;

  /**
   * Creates and executes a Job.
   * For update case, the Tags in the definition passed in will replace Tags in the existing job.
   */
  @summary("Creates and executes a Job.\r\nFor update case, the Tags in the definition passed in will replace Tags in the existing job.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<JobBase>;

  /**
   * Deletes a Job (asynchronous).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Existing API returns additional response codes for LRO delete"
  @summary("Deletes a Job (asynchronous).")
  delete is ArmResourceDeleteWithoutOkAsync<
    JobBase,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * Lists Jobs in the workspace.
   */
  @summary("Lists Jobs in the workspace.")
  list is ArmResourceListByParent<
    JobBase,
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
      listViewType?: ListViewType = ListViewType.ActiveOnly;

      /**
       * Comma-separated list of user property names (and optionally values). Example: prop1,prop2=value2
       */
      @query("properties")
      properties?: string;
    },
    Response = ArmResponse<JobBaseResourceArmPaginatedResult>
  >;

  /**
   * Cancels a Job (asynchronous).
   */
  @summary("Cancels a Job (asynchronous).")
  cancel is ArmResourceActionAsync<
    JobBase,
    void,
    Response = {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;
}

@@doc(JobBase.name,
  "The name and identifier for the Job. This is case-sensitive."
);
@@doc(JobBase.properties, "[Required] Additional attributes of the entity.");
@@doc(JobBases.createOrUpdate::parameters.resource, "Job definition object.");
