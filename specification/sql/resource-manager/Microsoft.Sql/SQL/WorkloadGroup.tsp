import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Workload group operations for a data warehouse
 */
@parentResource(Database)
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
   * Gets a workload group
   */
  get is ArmResourceRead<WorkloadGroup>;

  /**
   * Creates or updates a workload group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    WorkloadGroup,
    Response = ArmResourceUpdatedResponse<WorkloadGroup> | ArmResourceCreatedResponse<
      WorkloadGroup,
      ArmLroLocationHeader<FinalResult = WorkloadGroup> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes a workload group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    WorkloadGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets the list of workload groups
   */
  listByDatabase is ArmResourceListByParent<WorkloadGroup>;
}

@@doc(WorkloadGroup.name, "The name of the workload group.");
@@doc(WorkloadGroup.properties, "Resource properties.");
@@doc(WorkloadGroups.createOrUpdate::parameters.resource,
  "The requested workload group state."
);
