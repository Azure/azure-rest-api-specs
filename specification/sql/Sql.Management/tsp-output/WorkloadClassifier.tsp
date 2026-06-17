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
/**
 * Workload classifier operations for a data warehouse
 */
@parentResource(WorkloadGroup)
model WorkloadClassifier is ProxyResource<WorkloadClassifierProperties> {
  /**
   * The name of the workload classifier.
   */
  @path
  @key("workloadClassifierName")
  @segment("workloadClassifiers")
  name: string;
}

@armResourceOperations
interface WorkloadClassifiers {
  /**
   * Gets a workload classifier
   */
  get is ArmResourceRead<WorkloadClassifier>;

  /**
   * Creates or updates a workload classifier.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<WorkloadClassifier>;

  /**
   * Deletes a workload classifier.
   */
  delete is ArmResourceDeleteAsync<WorkloadClassifier>;

  /**
   * Gets the list of workload classifiers for a workload group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadClassifiers_ListByWorkloadGroup")
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
