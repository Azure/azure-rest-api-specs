import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Job.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * An execution of a job
 */
@parentResource(Job)
model JobExecution is ProxyResource<JobExecutionProperties> {
  /**
   * The id of the job execution
   */
  @path
  @key("jobExecutionId")
  @segment("executions")
  name: string;
}

@armResourceOperations
interface JobExecutions {
  /**
   * Gets a job execution.
   */
  get is ArmResourceRead<JobExecution>;

  /**
   * Creates or updates a job execution.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<JobExecution>;

  /**
   * Lists a job's executions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("JobExecutions_ListByJob")
  listByJob is ArmResourceListByParent<
    JobExecution,
    {
      ...BaseParameters<JobExecution>;

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
    }
  >;

  /**
   * Requests cancellation of a job execution.
   */
  cancel is ArmResourceActionSync<JobExecution, void, void>;
}
