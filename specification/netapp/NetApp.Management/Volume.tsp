import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./CapacityPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetApp;
/**
 * Volume resource
 */
@parentResource(CapacityPool)
model Volume is Azure.ResourceManager.TrackedResource<VolumeProperties, false> {
  ...ResourceNameParameter<
    Resource = Volume,
    KeyName = "volumeName",
    SegmentName = "volumes",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$"
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...Azure.ResourceManager.AvailabilityZonesProperty;
}

@@visibility(Azure.ResourceManager.AvailabilityZonesProperty.zones,
  Lifecycle.Read,
  Lifecycle.Create
);

@armResourceOperations
interface Volumes {
  /**
   * Get the details of the specified volume
   */
  get is ArmResourceRead<Volume>;

  /**
   * Create or update the specified volume within the capacity pool
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Volume,
    Response = ArmResourceUpdatedResponse<Volume> | ArmResourceCreatedResponse<
      Volume,
      ArmAsyncOperationHeader<FinalResult = Volume> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Patch the specified volume
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Volume, PatchModel = VolumePatch>;

  /**
   * Delete the specified volume
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Volume,
    Parameters = {
      /**
       * An option to force delete the volume. Will cleanup resources connected to the particular volume
       */
      @query("forceDelete")
      forceDelete?: boolean;
    }
  >;

  /**
   * List all volumes within the capacity pool
   */
  list is ArmResourceListByParent<Volume, Response = ArmResponse<VolumeList>>;

  /**
   * This operation will populate availability zone information for a volume
   */
  populateAvailabilityZone is ArmResourceActionAsync<Volume, void, Volume>;

  /**
   * Revert a volume to the snapshot specified in the body
   */
  revert is ArmResourceActionAsync<
    Volume,
    VolumeRevert,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Reset cifs password from volume
   */
  resetCifsPassword is ArmResourceActionAsyncBase<
    Volume,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Volume>
  >;

  /**
   *  Split operation to convert clone volume to an independent volume.
   */
  splitCloneFromParent is ArmResourceActionAsync<Volume, void, Volume>;

  /**
   * Break all the file locks on a volume
   */
  breakFileLocks is ArmResourceActionAsync<
    Volume,
    BreakFileLocksRequest,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  /**
   * Returns the list of group Ids for a specific LDAP User
   */
  @action("getGroupIdListForLdapUser")
  listGetGroupIdListForLdapUser is ArmResourceActionAsync<
    Volume,
    GetGroupIdListForLdapUserRequest,
    GetGroupIdListForLdapUserResponse
  >;

  /**
   * Break the replication connection on the destination volume
   */
  breakReplication is ArmResourceActionAsync<
    Volume,
    BreakReplicationRequest,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  /**
   * Re-establish a previously deleted replication between 2 volumes that have a common ad-hoc or policy-based snapshots
   */
  reestablishReplication is ArmResourceActionAsyncBase<
    Volume,
    ReestablishReplicationRequest,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Volume>
  >;

  /**
   * Get the status of the replication
   */
  @get
  replicationStatus is ArmResourceActionSync<
    Volume,
    void,
    ArmResponse<ReplicationStatus>
  >;

  /**
   * List all replications for a specified volume
   */
  @list
  listReplications is ArmResourceActionSync<
    Volume,
    void,
    ArmResponse<ListReplications>
  >;

  /**
   * Resync the connection on the destination volume. If the operation is ran on the source volume it will reverse-resync the connection and sync from destination to source.
   */
  resyncReplication is ArmResourceActionAsync<
    Volume,
    void,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete the replication connection on the destination volume, and send release to the source replication
   */
  deleteReplication is ArmResourceActionAsync<
    Volume,
    void,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Authorize the replication connection on the source volume
   */
  authorizeReplication is ArmResourceActionAsync<
    Volume,
    AuthorizeRequest,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Re-Initializes the replication connection on the destination volume
   */
  @action("reinitializeReplication")
  reInitializeReplication is ArmResourceActionAsync<
    Volume,
    void,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Starts peering the external cluster for this migration volume
   */
  peerExternalCluster is ArmResourceActionAsync<
    Volume,
    PeerClusterForVolumeMigrationRequest,
    ClusterPeerCommandResponse
  >;

  /**
   * Starts SVM peering and returns a command to be run on the external ONTAP to accept it.  Once the SVM have been peered a SnapMirror will be created
   */
  authorizeExternalReplication is ArmResourceActionAsync<
    Volume,
    void,
    SvmPeerCommandResponse
  >;

  /**
   * Finalizes the migration of an external volume by releasing the replication and breaking the external cluster peering if no other migration is active.
   */
  finalizeExternalReplication is ArmResourceActionAsyncBase<
    Volume,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Volume>
  >;

  /**
   * Performs an adhoc replication transfer on a volume with volumeType Migration
   */
  performReplicationTransfer is ArmResourceActionAsyncBase<
    Volume,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Volume>
  >;

  /**
   * Moves volume to another pool
   */
  poolChange is ArmResourceActionAsync<
    Volume,
    PoolChangeRequest,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Relocates volume to a new stamp
   */
  relocate is ArmResourceActionAsync<
    Volume,
    RelocateVolumeRequest,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  /**
   * Finalizes the relocation of the volume and cleans up the old volume.
   */
  finalizeRelocation is ArmResourceActionAsync<
    Volume,
    void,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Reverts the volume relocation process, cleans up the new volume and starts using the former-existing volume.
   */
  revertRelocation is ArmResourceActionAsync<
    Volume,
    void,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Get the latest status of the backup for a volume
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Backups_GetLatestStatus")
  @get
  @action("latestBackupStatus/current")
  getLatestStatus is ArmResourceActionSync<
    Volume,
    void,
    ArmResponse<BackupStatus>
  >;

  /**
   * Get the latest status of the restore for a volume
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Backups_GetVolumeLatestRestoreStatus")
  @get
  @action("latestRestoreStatus/current")
  getVolumeLatestRestoreStatus is ArmResourceActionSync<
    Volume,
    void,
    ArmResponse<RestoreStatus>
  >;

  /**
   * Migrate the backups under volume to backup vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupsUnderVolume_MigrateBackups")
  migrateBackups is ArmResourceActionAsyncBase<
    Volume,
    BackupsMigrationRequest,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Volume>
  >;
}

@@maxLength(Volume.name, 64);
@@minLength(Volume.name, 1);
@@doc(Volume.name, "The name of the volume");
@@doc(Volume.properties, "Volume properties");
@@doc(Volumes.createOrUpdate::parameters.resource,
  "Volume object supplied in the body of the operation."
);
@@doc(Volumes.update::parameters.properties,
  "Volume object supplied in the body of the operation."
);
@@doc(Volumes.revert::parameters.body,
  "Object for snapshot to revert supplied in the body of the operation."
);
@@doc(Volumes.breakFileLocks::parameters.body,
  "Optional body to provide the ability to clear file locks with selected options"
);
@@doc(Volumes.listGetGroupIdListForLdapUser::parameters.body,
  "Returns group Id list for a specific LDAP user"
);
@@doc(Volumes.breakReplication::parameters.body,
  "Optional body to force break the replication."
);
@@doc(Volumes.reestablishReplication::parameters.body,
  "body for the id of the source volume."
);
@@doc(Volumes.authorizeReplication::parameters.body,
  "Authorize request object supplied in the body of the operation."
);
@@doc(Volumes.peerExternalCluster::parameters.body,
  "Cluster peer request object supplied in the body of the operation."
);
@@doc(Volumes.poolChange::parameters.body,
  "Move volume to the pool supplied in the body of the operation."
);
@@doc(Volumes.relocate::parameters.body, "Relocate volume request");
@@doc(Volumes.migrateBackups::parameters.body,
  "Migrate backups under volume payload supplied in the body of the operation."
);
