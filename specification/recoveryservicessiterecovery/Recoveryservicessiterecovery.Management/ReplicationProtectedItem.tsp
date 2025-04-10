import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProtectionContainer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Replication protected item.
 */
@parentResource(ProtectionContainer)
model ReplicationProtectedItem
  is Azure.ResourceManager.ProxyResource<ReplicationProtectedItemProperties> {
  ...ResourceNameParameter<
    Resource = ReplicationProtectedItem,
    KeyName = "replicatedProtectedItemName",
    SegmentName = "replicationProtectedItems",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ReplicationProtectedItems {
  /**
   * Gets the details of an ASR replication protected item.
   */
  get is ArmResourceRead<ReplicationProtectedItem>;

  /**
   * The operation to create an ASR replication protected item (Enable replication).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ArmResourceCreateOrReplaceAsync<
    ReplicationProtectedItem,
    Response = ArmResourceUpdatedResponse<ReplicationProtectedItem> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to update the recovery settings of an ASR replication protected item.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ReplicationProtectedItem,
    PatchModel = UpdateReplicationProtectedItemInput
  >;

  /**
   * The operation to delete or purge a replication protected item. This operation will force delete the replication protected item. Use the remove operation on replication protected item to perform a clean disable replication for the item.
   */
  purge is ArmResourceDeleteWithoutOkAsync<ReplicationProtectedItem>;

  /**
   * Gets the list of ASR replication protected items in the protection container.
   */
  listByReplicationProtectionContainers is ArmResourceListByParent<
    ReplicationProtectedItem,
    Response = ArmResponse<ReplicationProtectedItemCollection>
  >;

  /**
   * Operation to add disks(s) to the replication protected item.
   */
  addDisks is ArmResourceActionAsync<
    ReplicationProtectedItem,
    AddDisksInput,
    ArmResponse<ReplicationProtectedItem>
  >;

  /**
   * The operation to change the recovery point of a failed over replication protected item.
   */
  applyRecoveryPoint is ArmResourceActionAsync<
    ReplicationProtectedItem,
    ApplyRecoveryPointInput,
    ArmResponse<ReplicationProtectedItem>
  >;

  /**
   * Operation to cancel the failover of the replication protected item.
   */
  failoverCancel is ArmResourceActionAsync<
    ReplicationProtectedItem,
    void,
    ArmResponse<ReplicationProtectedItem>
  >;

  /**
   * Operation to commit the failover of the replication protected item.
   */
  failoverCommit is ArmResourceActionAsync<
    ReplicationProtectedItem,
    void,
    ArmResponse<ReplicationProtectedItem>
  >;

  /**
   * Operation to initiate a planned failover of the replication protected item.
   */
  plannedFailover is ArmResourceActionAsync<
    ReplicationProtectedItem,
    PlannedFailoverInput,
    ArmResponse<ReplicationProtectedItem>
  >;

  /**
   * The operation to disable replication on a replication protected item. This will also remove the item.
   */
  @action("remove")
  delete is ArmResourceActionAsync<
    ReplicationProtectedItem,
    DisableProtectionInput,
    NoContentResponse
  >;

  /**
   * Operation to remove disk(s) from the replication protected item.
   */
  removeDisks is ArmResourceActionAsync<
    ReplicationProtectedItem,
    RemoveDisksInput,
    ArmResponse<ReplicationProtectedItem>
  >;

  /**
   * The operation to start resynchronize/repair replication for a replication protected item requiring resynchronization.
   */
  repairReplication is ArmResourceActionAsync<
    ReplicationProtectedItem,
    void,
    ArmResponse<ReplicationProtectedItem>
  >;

  /**
   * Operation to reprotect or reverse replicate a failed over replication protected item.
   */
  @action("reProtect")
  reprotect is ArmResourceActionAsync<
    ReplicationProtectedItem,
    ReverseReplicationInput,
    ArmResponse<ReplicationProtectedItem>
  >;

  /**
   * Operation to resolve health issues of the replication protected item.
   */
  resolveHealthErrors is ArmResourceActionAsync<
    ReplicationProtectedItem,
    ResolveHealthInput,
    ArmResponse<ReplicationProtectedItem>
  >;

  /**
   * Operation to initiate a switch provider of the replication protected item.
   */
  switchProvider is ArmResourceActionAsync<
    ReplicationProtectedItem,
    SwitchProviderInput,
    ArmResponse<ReplicationProtectedItem>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Operation to perform a test failover of the replication protected item.
   */
  testFailover is ArmResourceActionAsync<
    ReplicationProtectedItem,
    TestFailoverInput,
    ArmResponse<ReplicationProtectedItem>
  >;

  /**
   * Operation to clean up the test failover of a replication protected item.
   */
  testFailoverCleanup is ArmResourceActionAsync<
    ReplicationProtectedItem,
    TestFailoverCleanupInput,
    ArmResponse<ReplicationProtectedItem>
  >;

  /**
   * Operation to initiate a failover of the replication protected item.
   */
  unplannedFailover is ArmResourceActionAsync<
    ReplicationProtectedItem,
    UnplannedFailoverInput,
    ArmResponse<ReplicationProtectedItem>
  >;

  /**
   * The operation to update appliance of an ASR replication protected item.
   */
  updateAppliance is ArmResourceActionAsync<
    ReplicationProtectedItem,
    UpdateApplianceForReplicationProtectedItemInput,
    ArmResponse<ReplicationProtectedItem>
  >;

  /**
   * The operation to update(push update) the installed mobility service software on a replication protected item to the latest available version.
   */
  updateMobilityService is ArmResourceActionAsync<
    ReplicationProtectedItem,
    UpdateMobilityServiceRequest,
    ArmResponse<ReplicationProtectedItem>
  >;

  /**
   * Lists the available target compute sizes for a replication protected item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("targetComputeSizes")
  @operationId("TargetComputeSizes_ListByReplicationProtectedItems")
  listByReplicationProtectedItems is ArmResourceActionSync<
    ReplicationProtectedItem,
    void,
    ArmResponse<TargetComputeSizeCollection>
  >;
}

@@doc(ReplicationProtectedItem.name, "Replication protected item name.");
@@doc(ReplicationProtectedItem.properties, "The custom data.");
@@doc(ReplicationProtectedItems.create::parameters.resource,
  "Enable Protection Input."
);
@@doc(ReplicationProtectedItems.update::parameters.properties,
  "Update protection input."
);
@@doc(ReplicationProtectedItems.addDisks::parameters.body, "Add disks input.");
@@doc(ReplicationProtectedItems.applyRecoveryPoint::parameters.body,
  "The ApplyRecoveryPointInput."
);
@@doc(ReplicationProtectedItems.plannedFailover::parameters.body,
  "Planned failover input."
);
@@doc(ReplicationProtectedItems.delete::parameters.body,
  "Disable protection input."
);
@@doc(ReplicationProtectedItems.removeDisks::parameters.body,
  "Remove disks input."
);
@@doc(ReplicationProtectedItems.reprotect::parameters.body,
  "Reverse replication input."
);
@@doc(ReplicationProtectedItems.resolveHealthErrors::parameters.body,
  "Health issue input object."
);
@@doc(ReplicationProtectedItems.switchProvider::parameters.body,
  "Switch provider input."
);
@@doc(ReplicationProtectedItems.testFailover::parameters.body,
  "Test failover input."
);
@@doc(ReplicationProtectedItems.testFailoverCleanup::parameters.body,
  "Test failover cleanup input."
);
@@doc(ReplicationProtectedItems.unplannedFailover::parameters.body,
  "Failover input."
);
@@doc(ReplicationProtectedItems.updateAppliance::parameters.body,
  "Appliance update protection input."
);
@@doc(ReplicationProtectedItems.updateMobilityService::parameters.body,
  "Request to update the mobility service on the protected item."
);
