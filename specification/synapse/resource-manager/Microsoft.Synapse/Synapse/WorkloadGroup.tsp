import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * Workload group operations for a sql pool
 */
@parentResource(SqlPool)
model WorkloadGroup
  is Azure.ResourceManager.ProxyResource<WorkloadGroupProperties> {
  ...ResourceNameParameter<
    Resource = WorkloadGroup,
    KeyName = "workloadGroupName",
    SegmentName = "workloadGroups",
    NamePattern = ""
  >;
}

@armResourceOperations
interface WorkloadGroups {
  /**
   * Get a Sql pool's workload group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolWorkloadGroup_Get")
  get is ArmResourceRead<WorkloadGroup>;

  /**
   * Create Or Update a Sql pool's workload group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("SqlPoolWorkloadGroup_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    WorkloadGroup,
    Response =
      | ArmResourceUpdatedResponse<WorkloadGroup>
      | ArmResourceCreatedResponse<
          WorkloadGroup,
          ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
        >
      | ArmAcceptedLroResponse
  >;

  /**
   * Remove Sql pool's workload group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("SqlPoolWorkloadGroup_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    WorkloadGroup,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * Get list of  Sql pool's workload groups.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolWorkloadGroup_List")
  list is ArmResourceListByParent<WorkloadGroup>;
}

@@doc(WorkloadGroup.name, "The name of the workload group.");
@@doc(WorkloadGroup.properties, "Resource properties.");
@@doc(
  WorkloadGroups.createOrUpdate::parameters.resource,
  "The requested workload group state."
);
