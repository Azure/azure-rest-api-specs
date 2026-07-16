import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WorkloadGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * Workload classifier operations for a data warehouse
 */
@parentResource(WorkloadGroup)
model WorkloadClassifier
  is Azure.ResourceManager.ProxyResource<WorkloadClassifierProperties> {
  ...ResourceNameParameter<
    Resource = WorkloadClassifier,
    KeyName = "workloadClassifierName",
    SegmentName = "workloadClassifiers",
    NamePattern = ""
  >;
}

@armResourceOperations
interface WorkloadClassifiers {
  /**
   * Get a workload classifier of Sql pool's workload group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolWorkloadClassifier_Get")
  get is ArmResourceRead<WorkloadClassifier>;

  /**
   * Create Or Update workload classifier for a Sql pool's workload group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("SqlPoolWorkloadClassifier_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    WorkloadClassifier,
    Response =
      | ArmResourceUpdatedResponse<WorkloadClassifier>
      | ArmResourceCreatedResponse<
          WorkloadClassifier,
          ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
        >
      | ArmAcceptedLroResponse
  >;

  /**
   * Remove workload classifier of a Sql pool's workload group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("SqlPoolWorkloadClassifier_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    WorkloadClassifier,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * Get list of  Sql pool's workload classifier for workload groups.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolWorkloadClassifier_List")
  list is ArmResourceListByParent<WorkloadClassifier>;
}

@@doc(WorkloadClassifier.name, "The name of the workload classifier.");
@@doc(WorkloadClassifier.properties, "Resource properties.");
@@doc(
  WorkloadClassifiers.createOrUpdate::parameters.resource,
  "The properties of the workload classifier."
);
