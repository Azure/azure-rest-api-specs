import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Distributed availability group between box and Sql Managed Instance.
 */
@parentResource(ManagedInstance)
model DistributedAvailabilityGroup
  is Azure.ResourceManager.ProxyResource<DistributedAvailabilityGroupProperties> {
  ...ResourceNameParameter<
    Resource = DistributedAvailabilityGroup,
    KeyName = "distributedAvailabilityGroupName",
    SegmentName = "distributedAvailabilityGroups",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DistributedAvailabilityGroups {
  /**
   * Gets a distributed availability group info.
   */
  get is ArmResourceRead<DistributedAvailabilityGroup>;

  /**
   * Creates a distributed availability group between Sql On-Prem and Sql Managed Instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DistributedAvailabilityGroup,
    Response = ArmResourceUpdatedResponse<DistributedAvailabilityGroup> | ArmResourceCreatedResponse<
      DistributedAvailabilityGroup,
      ArmLroLocationHeader<FinalResult = DistributedAvailabilityGroup> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Updates a distributed availability group replication mode.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DistributedAvailabilityGroup,
    PatchModel = DistributedAvailabilityGroup
  >;

  /**
   * Drops a distributed availability group between Sql On-Prem and Sql Managed Instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    DistributedAvailabilityGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of a distributed availability groups in instance.
   */
  listByInstance is ArmResourceListByParent<
    DistributedAvailabilityGroup,
    Response = DistributedAvailabilityGroupsListResult
  >;

  /**
   * Performs requested failover type in this distributed availability group.
   */
  failover is ArmResourceActionAsync<
    DistributedAvailabilityGroup,
    DistributedAvailabilityGroupsFailoverRequest,
    Response = DistributedAvailabilityGroup
  >;

  /**
   * Sets the role for managed instance in a distributed availability group.
   */
  setRole is ArmResourceActionAsync<
    DistributedAvailabilityGroup,
    DistributedAvailabilityGroupSetRole,
    Response = DistributedAvailabilityGroup
  >;
}

@@doc(DistributedAvailabilityGroup.name,
  "The distributed availability group name."
);
@@doc(DistributedAvailabilityGroup.properties, "Resource properties.");
@@doc(DistributedAvailabilityGroups.createOrUpdate::parameters.resource,
  "The distributed availability group info."
);
@@doc(DistributedAvailabilityGroups.update::parameters.properties,
  "The distributed availability group info."
);
@@doc(DistributedAvailabilityGroups.failover::parameters.body,
  "The distributed availability group failover request parameters."
);
@@doc(DistributedAvailabilityGroups.setRole::parameters.body,
  "The distributed availability group set role request parameters."
);
