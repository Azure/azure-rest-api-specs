import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Sql;
@doc("Workload group operations for a data warehouse")
@parentResource(Database)
model WorkloadGroup is ProxyResource<WorkloadGroupProperties> {
  @doc("The name of the workload group.")
  @key("workloadGroupName")
  @segment("workloadGroups")
  name: string;
}

@armResourceOperations
interface WorkloadGroups {
  @doc("Gets a workload group")
  get is ArmResourceRead<WorkloadGroup>;

  @doc("Creates or updates a workload group.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<WorkloadGroup>;

  @doc("Deletes a workload group.")
  delete is ArmResourceDeleteAsync<WorkloadGroup>;

  @doc("Gets the list of workload groups")
  listByDatabase is ArmResourceListByParent<WorkloadGroup>;
}
