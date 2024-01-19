import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WorkloadGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("Workload classifier operations for a data warehouse")
@parentResource(WorkloadGroup)
model WorkloadClassifier is ProxyResource<WorkloadClassifierProperties> {
  @doc("The name of the workload classifier.")
  @path
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

@@projectedName(WorkloadClassifiers.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(WorkloadClassifiers.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(WorkloadClassifiers.createOrUpdate::parameters.resource,
  "The properties of the workload classifier."
);
