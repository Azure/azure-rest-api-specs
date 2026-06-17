import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * An Azure SQL job agent.
 */
@parentResource(Server)
model JobAgent is TrackedResource<JobAgentProperties> {
  /**
   * The name of the job agent to be retrieved.
   */
  @path
  @key("jobAgentName")
  @segment("jobAgents")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<JobAgent>;

  /**
   * Updates a job agent.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<JobAgent, JobAgentUpdate>;

  /**
   * Deletes a job agent.
   */
  delete is ArmResourceDeleteAsync<JobAgent>;

  /**
   * Gets a list of job agents in a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("JobAgents_ListByServer")
  listByServer is ArmResourceListByParent<JobAgent>;

  /**
   * Lists all executions in a job agent.
   */
  // FIXME: JobExecutions_ListByAgent could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("JobExecutions_ListByAgent")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/executions")
  @get
  listByAgent is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the job agent.
       */
      @path
      jobAgentName: string;

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
      $skip?: int32;

      /**
       * The number of elements to return from the collection.
       */
      @query("$top")
      $top?: int32;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<JobExecution>
  >;
}

@@projectedName(JobAgents.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(JobAgents.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(JobAgents.createOrUpdate::parameters.resource,
  "The requested job agent resource state."
);
@@projectedName(JobAgents.update::parameters.properties, "json", "parameters");
@@extension(JobAgents.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(JobAgents.update::parameters.properties, "The update to the job agent.");
