import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlServer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("An Azure SQL job agent.")
@parentResource(SqlServer)
model SqlServerJobAgent is TrackedResource<JobAgentProperties> {
  @doc("The name of the job agent to be retrieved.")
  @path
  @key("jobAgentName")
  @segment("jobAgents")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface SqlServerJobAgents {
  @doc("Gets a job agent.")
  get is ArmResourceRead<SqlServerJobAgent>;
  @doc("Creates or updates a job agent.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SqlServerJobAgent>;
  @doc("Updates a job agent.")
  update is ArmTagsPatchAsync<SqlServerJobAgent>;
  @doc("Deletes a job agent.")
  delete is ArmResourceDeleteAsync<SqlServerJobAgent>;
  @doc("Gets a list of job agents in a server.")
  listByServer is ArmResourceListByParent<SqlServerJobAgent>;
  @doc("Lists all executions in a job agent.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/jobAgents/{jobAgentName}/executions")
  @get
  ListByAgent is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the job agent.")
      @path
      jobAgentName: string;

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

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    JobExecutionListResult
  >;
}
