import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlServerJob.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("An execution of a job")
@parentResource(SqlServerJob)
model SqlServerJobExecution is ProxyResource<JobExecutionProperties> {
  @doc("The id of the job execution")
  @path
  @key("jobExecutionId")
  @segment("executions")
  name: string;
}

@armResourceOperations
interface SqlServerJobExecutions {
  @doc("Gets a job execution.")
  get is ArmResourceRead<SqlServerJobExecution>;
  @doc("Creates or updates a job execution.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SqlServerJobExecution>;
  @doc("Lists a job's executions.")
  listByJob is ArmResourceListByParent<
    SqlServerJobExecution,
    {
      ...BaseParameters<SqlServerJobExecution>;

      @doc("If specified, only job executions created at or after the specified time are included.")
      @query("createTimeMin")
      createTimeMin?: utcDateTime;

      @doc("If specified, only job executions created before the specified time are included.")
      @query("createTimeMax")
      createTimeMax?: utcDateTime;

      @doc("If specified, only job executions completed at or after the specified time are included.")
      @query("endTimeMin")
      endTimeMin?: utcDateTime;

      @doc("If specified, only job executions completed before the specified time are included.")
      @query("endTimeMax")
      endTimeMax?: utcDateTime;

      @doc("If specified, only active or only completed job executions are included.")
      @query("isActive")
      isActive?: boolean;

      @doc("The number of elements in the collection to skip.")
      @query("$skip")
      $skip?: int32;

      @doc("The number of elements to return from the collection.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("Requests cancellation of a job execution.")
  cancel is ArmResourceActionSync<SqlServerJobExecution, void, void>;
}
