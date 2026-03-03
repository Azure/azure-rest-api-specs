import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * An Azure SQL job agent.
 */
@parentResource(Server)
model JobAgent is Azure.ResourceManager.TrackedResource<JobAgentProperties> {
  ...ResourceNameParameter<
    Resource = JobAgent,
    KeyName = "jobAgentName",
    SegmentName = "jobAgents",
    NamePattern = ""
  >;

  /**
   * The name and tier of the SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;

  /**
   * The identity of the job agent.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: JobAgentIdentity;
}

@armResourceOperations
interface JobAgents {
  /**
   * Gets a job agent.
   */
  get is ArmResourceRead<JobAgent>;

  /**
   * Creates or updates a job agent.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    JobAgent,
    Response = ArmResourceUpdatedResponse<JobAgent> | ArmResourceCreatedResponse<
      JobAgent,
      ArmLroLocationHeader<FinalResult = JobAgent> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Updates a job agent.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<JobAgent, PatchModel = JobAgentUpdate>;

  /**
   * Deletes a job agent.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    JobAgent,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of job agents in a server.
   */
  listByServer is ArmResourceListByParent<JobAgent>;

  /**
   * Lists all executions in a job agent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("JobExecutions_ListByAgent")
  @list
  @get
  @action("executions")
  listByAgent is ArmResourceActionSync<
    JobAgent,
    void,
    ArmResponse<ResourceListResult<JobExecution>>,
    Parameters = {
      /**
       * If specified, only job executions created at or after the specified time are included.
       */
      @query("createTimeMin")
      createTimeMin?: utcDateTime;

      /**
       * If specified, only job executions created before the specified time are included.
       */
      @query("createTimeMax")
      createTimeMax?: utcDateTime;

      /**
       * If specified, only job executions completed at or after the specified time are included.
       */
      @query("endTimeMin")
      endTimeMin?: utcDateTime;

      /**
       * If specified, only job executions completed before the specified time are included.
       */
      @query("endTimeMax")
      endTimeMax?: utcDateTime;

      /**
       * If specified, only active or only completed job executions are included.
       */
      @query("isActive")
      isActive?: boolean;

      /**
       * The number of elements in the collection to skip.
       */
      @query("$skip")
      $skip?: int64;

      /**
       * The number of elements to return from the collection.
       */
      @query("$top")
      $top?: int64;
    }
  >;
}

@@doc(JobAgent.name, "The name of the job agent to be retrieved.");
@@doc(JobAgent.properties, "Resource properties.");
@@doc(JobAgents.createOrUpdate::parameters.resource,
  "The requested job agent resource state."
);
@@doc(JobAgents.update::parameters.properties, "The update to the job agent.");
