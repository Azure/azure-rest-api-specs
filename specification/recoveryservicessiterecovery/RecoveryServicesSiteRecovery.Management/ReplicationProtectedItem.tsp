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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

alias ReplicationProtectedItemsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the recovery services vault. */
    @path
    @segment("vaults")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    resourceName: string;

    /** Fabric name. */
    @path
    @segment("replicationFabrics")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    fabricName: string;

    /** Protection container name. */
    @path
    @segment("replicationProtectionContainers")
    @key
    @pattern(".*")
    protectionContainerName: string;
  },
  {
    /** The name of the protected item on which the agent is to be updated. */
    @path
    @segment("replicationProtectedItems")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    replicatedProtectedItemName: string;
  }
>;

model ReplicationProtectedItemAcceptedLroResponse<FinalResult extends TypeSpec.Reflection.Model | unknown | void = ReplicationProtectedItem>
  is ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = FinalResult> &
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Enables protection.")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    ReplicationProtectedItem,
    Request = EnableProtectionInput,
    Response = ArmResourceUpdatedResponse<ReplicationProtectedItem> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ReplicationProtectedItem> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = never
  >;

  /**
   * The operation to update the recovery settings of an ASR replication protected item.
   */
  @patch(#{ implicitOptionality: false })
  @summary("Updates the replication protected item settings.")
  update is ArmCustomPatchAsync<
    ReplicationProtectedItem,
    PatchModel = UpdateReplicationProtectedItemInput,
    Error = never
  >;

  /**
   * The operation to delete or purge a replication protected item. This operation will force delete the replication protected item. Use the remove operation on replication protected item to perform a clean disable replication for the item.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Add disk(s) for protection.")
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("remove")
  @summary("Disables protection.")
  delete is ArmResourceActionAsyncBase<
    ReplicationProtectedItem,
    DisableProtectionInput,
    NoContentResponse | ReplicationProtectedItemAcceptedLroResponse<void>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ReplicationProtectedItem>,
    Error = never
  >;

  /**
   * Operation to remove disk(s) from the replication protected item.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Reinstall the mobility service on a protected item.")
  reinstallMobilityService is ReplicationProtectedItemsOps.ActionAsync<
    ReplicationProtectedItem,
    ReinstallMobilityServiceRequest,
    ReplicationProtectedItem
  >;

  /**
   * Lists the available target compute sizes for a replication protected item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @list
  @get
  @action("targetComputeSizes")
  @summary("Gets the list of target compute sizes for the replication protected item.")
  listByReplicationProtectedItems is ArmResourceActionAsyncBase<
    ReplicationProtectedItem,
    void,
    ArmResponse<TargetComputeSizeCollection>,
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
