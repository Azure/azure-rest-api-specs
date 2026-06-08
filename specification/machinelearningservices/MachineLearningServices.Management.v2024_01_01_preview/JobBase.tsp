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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Jobs_Get")
  get is ArmResourceRead<JobBase>;

  /**
   * Creates and executes a Job.
   * For update case, the Tags in the definition passed in will replace Tags in the existing job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Jobs_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<JobBase>;

  /**
   * Updates a Job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Jobs_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    JobBase,
    PatchModel = PartialJobBasePartialResource
  >;

  /**
   * Deletes a Job (asynchronous).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Jobs_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    JobBase,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * Lists Jobs in the workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Jobs_List")
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
      listViewType?: ListViewType;

      /**
       * Comma-separated list of property names (and optionally values). Example: prop1,prop2=value2
       */
      @query("properties")
      properties?: string;

      /**
       * Asset name the job's named output is registered with
       */
      @query("assetName")
      assetName?: string;

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
   * Cancels a Job (asynchronous).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Jobs_Cancel")
  cancel is ArmResourceActionAsync<JobBase, void, OkResponse>;
}

@@doc(
  JobBase.name,
  "The name and identifier for the Job. This is case-sensitive."
);
@@doc(JobBase.properties, "[Required] Additional attributes of the entity.");
@@doc(JobBases.createOrUpdate::parameters.resource, "Job definition object.");
@@doc(
  JobBases.update::parameters.properties,
  "Job definition to apply during the operation."
);
