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

  /**
   * Resource Location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  location?: string;
}

alias ReplicationProtectedItemAcceptedLroResponse = ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ReplicationProtectedItem> &
  Azure.Core.Foundations.RetryAfterHeader>;

@armResourceOperations
interface ReplicationProtectedItems {
  /**
   * Gets the details of an ASR replication protected item.
   */
  @summary("Gets the details of a Replication protected item.")
  get is ArmResourceRead<ReplicationProtectedItem, Error = never>;

  /**
   * The operation to create an ASR replication protected item (Enable replication).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @summary("Enables protection.")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    ReplicationProtectedItem,
    Request = EnableProtectionInput,
    Response = ArmResourceUpdatedResponse<ReplicationProtectedItem> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = ReplicationProtectedItem> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = never
  >;

  /**
   * The operation to update the recovery settings of an ASR replication protected item.
   */
  @patch(#{ implicitOptionality: false })
  @summary("Updates the Replication protected item settings.")
  update is ArmCustomPatchAsync<
    ReplicationProtectedItem,
    PatchModel = UpdateReplicationProtectedItemInput,
    Error = never
  >;

  /**
   * The operation to delete or purge a replication protected item. This operation will force delete the replication protected item. Use the remove operation on replication protected item to perform a clean disable replication for the item.
   */
  @summary("Purges protection.")
  purge is ArmResourceDeleteWithoutOkAsync<
    ReplicationProtectedItem,
    Error = never
  >;

  /**
   * Gets the list of ASR replication protected items in the protection container.
   */
  @summary("Gets the list of Replication protected items.")
  listByReplicationProtectionContainers is ArmResourceListByParent<
    ReplicationProtectedItem,
    Response = ArmResponse<ReplicationProtectedItemCollection>,
    Error = never
  >;

  /**
   * Operation to add disks(s) to the replication protected item.
   */
  @summary("Adds disk(s) for protection.")
  addDisks is ArmResourceActionAsyncBase<
    ReplicationProtectedItem,
    AddDisksInput,
    ArmResponse<ReplicationProtectedItem> | ReplicationProtectedItemAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ReplicationProtectedItem>,
    Error = never
  >;

  /**
   * The operation to change the recovery point of a failed over replication protected item.
   */
  @summary("Change or apply recovery point.")
  applyRecoveryPoint is ArmResourceActionAsyncBase<
    ReplicationProtectedItem,
    ApplyRecoveryPointInput,
    ArmResponse<ReplicationProtectedItem> | ReplicationProtectedItemAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ReplicationProtectedItem>,
    Error = never
  >;

  /**
   * Operation to cancel the failover of the replication protected item.
   */
  @summary("Execute cancel failover.")
  failoverCancel is ArmResourceActionAsyncBase<
    ReplicationProtectedItem,
    void,
    ArmResponse<ReplicationProtectedItem> | ReplicationProtectedItemAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ReplicationProtectedItem>,
    Error = never
  >;

  /**
   * Operation to commit the failover of the replication protected item.
   */
  @summary("Execute commit failover.")
  failoverCommit is ArmResourceActionAsyncBase<
    ReplicationProtectedItem,
    void,
    ArmResponse<ReplicationProtectedItem> | ReplicationProtectedItemAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ReplicationProtectedItem>,
    Error = never
  >;

  /**
   * Operation to initiate a planned failover of the replication protected item.
   */
  @summary("Execute planned failover.")
  plannedFailover is ArmResourceActionAsyncBase<
    ReplicationProtectedItem,
    PlannedFailoverInput,
    ArmResponse<ReplicationProtectedItem> | ReplicationProtectedItemAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ReplicationProtectedItem>,
    Error = never
  >;

  /**
   * The operation to disable replication on a replication protected item. This will also remove the item.
   */
  @action("remove")
  @summary("Disables protection.")
  delete is ArmResourceActionAsyncBase<
    ReplicationProtectedItem,
    DisableProtectionInput,
    NoContentResponse | ReplicationProtectedItemAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ReplicationProtectedItem>,
    Error = never
  >;

  /**
   * Operation to remove disk(s) from the replication protected item.
   */
  @summary("Removes disk(s).")
  removeDisks is ArmResourceActionAsyncBase<
    ReplicationProtectedItem,
    RemoveDisksInput,
    ArmResponse<ReplicationProtectedItem> | ReplicationProtectedItemAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ReplicationProtectedItem>,
    Error = never
  >;

  /**
   * The operation to start resynchronize/repair replication for a replication protected item requiring resynchronization.
   */
  @summary("Resynchronize or repair replication.")
  repairReplication is ArmResourceActionAsyncBase<
    ReplicationProtectedItem,
    void,
    ArmResponse<ReplicationProtectedItem> | ReplicationProtectedItemAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ReplicationProtectedItem>,
    Error = never
  >;

  /**
   * Operation to reprotect or reverse replicate a failed over replication protected item.
   */
  @action("reProtect")
  @summary("Execute Reverse Replication\\Reprotect.")
  reprotect is ArmResourceActionAsyncBase<
    ReplicationProtectedItem,
    ReverseReplicationInput,
    ArmResponse<ReplicationProtectedItem> | ReplicationProtectedItemAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ReplicationProtectedItem>,
    Error = never
  >;

  /**
   * Operation to resolve health issues of the replication protected item.
   */
  @summary("Resolve health errors.")
  resolveHealthErrors is ArmResourceActionAsyncBase<
    ReplicationProtectedItem,
    ResolveHealthInput,
    ArmResponse<ReplicationProtectedItem> | ReplicationProtectedItemAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ReplicationProtectedItem>,
    Error = never
  >;

  /**
   * Operation to initiate a switch provider of the replication protected item.
   */
  @summary("Execute switch provider.")
  switchProvider is ArmResourceActionAsyncBase<
    ReplicationProtectedItem,
    SwitchProviderInput,
    ArmResponse<ReplicationProtectedItem> | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = ReplicationProtectedItem> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ReplicationProtectedItem>,
    Error = never
  >;

  /**
   * Operation to perform a test failover of the replication protected item.
   */
  @summary("Execute test failover.")
  testFailover is ArmResourceActionAsyncBase<
    ReplicationProtectedItem,
    TestFailoverInput,
    ArmResponse<ReplicationProtectedItem> | ReplicationProtectedItemAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ReplicationProtectedItem>,
    Error = never
  >;

  /**
   * Operation to clean up the test failover of a replication protected item.
   */
  @summary("Execute test failover cleanup.")
  testFailoverCleanup is ArmResourceActionAsyncBase<
    ReplicationProtectedItem,
    TestFailoverCleanupInput,
    ArmResponse<ReplicationProtectedItem> | ReplicationProtectedItemAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ReplicationProtectedItem>,
    Error = never
  >;

  /**
   * Operation to initiate a failover of the replication protected item.
   */
  @summary("Execute unplanned failover.")
  unplannedFailover is ArmResourceActionAsyncBase<
    ReplicationProtectedItem,
    UnplannedFailoverInput,
    ArmResponse<ReplicationProtectedItem> | ReplicationProtectedItemAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ReplicationProtectedItem>,
    Error = never
  >;

  /**
   * The operation to update appliance of an ASR replication protected item.
   */
  @summary("Updates appliance for replication protected Item.")
  updateAppliance is ArmResourceActionAsyncBase<
    ReplicationProtectedItem,
    UpdateApplianceForReplicationProtectedItemInput,
    ArmResponse<ReplicationProtectedItem> | ReplicationProtectedItemAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ReplicationProtectedItem>,
    Error = never
  >;

  /**
   * The operation to update(push update) the installed mobility service software on a replication protected item to the latest available version.
   */
  @summary("Update the mobility service on a protected item.")
  updateMobilityService is ArmResourceActionAsyncBase<
    ReplicationProtectedItem,
    UpdateMobilityServiceRequest,
    ArmResponse<ReplicationProtectedItem> | ReplicationProtectedItemAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ReplicationProtectedItem>,
    Error = never
  >;

  /**
   * The operation to reinstall the installed mobility service software on a replication protected item to the latest available version.
   */
  @summary("Reinstall the mobility service on a protected item.")
  reinstallMobilityService is ArmResourceActionAsyncBase<
    ReplicationProtectedItem,
    ReinstallMobilityServiceRequest,
    ArmResponse<ReplicationProtectedItem> | ReplicationProtectedItemAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ReplicationProtectedItem>,
    Error = never
  >;

  /**
   * Lists the available target compute sizes for a replication protected item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TargetComputeSizes_ListByReplicationProtectedItems")
  @list
  @get
  @action("targetComputeSizes")
  @summary("Gets the list of target compute sizes for the replication protected item.")
  listByReplicationProtectedItems is ArmResourceActionAsyncBase<
    ReplicationProtectedItem,
    void,
    ArmResponse<TargetComputeSizeCollection> | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = TargetComputeSizeCollection> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ReplicationProtectedItem>,
    Error = never
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
@@doc(ReplicationProtectedItems.reinstallMobilityService::parameters.body,
  "Request to update the mobility service on the protected item."
);
