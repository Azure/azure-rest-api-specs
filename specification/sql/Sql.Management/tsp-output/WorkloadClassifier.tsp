import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./WorkloadGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Sql;
@doc("Workload classifier operations for a data warehouse")
@parentResource(WorkloadGroup)
model WorkloadClassifier is ProxyResource<WorkloadClassifierProperties> {
  @doc("The name of the workload classifier.")
  @key("workloadClassifierName")
  @segment("workloadClassifiers")
  name: string;
}

@armResourceOperations
interface WorkloadClassifiers {
  @doc("Gets a workload classifier")
  get is ArmResourceRead<WorkloadClassifier>;

  @doc("Creates or updates a workload classifier.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<WorkloadClassifier>;

  @doc("Deletes a workload classifier.")
  delete is ArmResourceDeleteAsync<WorkloadClassifier>;

  @doc("Gets the list of workload classifiers for a workload group")
  listByWorkloadGroup is ArmResourceListByParent<WorkloadClassifier>;
}
