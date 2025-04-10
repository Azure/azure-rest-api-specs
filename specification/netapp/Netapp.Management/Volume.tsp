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
  ...Azure.ResourceManager.EntityTagProperty;
  ...Azure.ResourceManager.AvailabilityZonesProperty;
}

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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Volume,
    Response = ArmResourceUpdatedResponse<Volume> | ArmResourceCreatedResponse<Volume> | ArmAcceptedLroResponse
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
  populateAvailabilityZone is ArmResourceActionAsync<
    Volume,
    void,
    ArmResponse<Volume>
  >;

  /**
   * Revert a volume to the snapshot specified in the body
   */
  revert is ArmResourceActionAsync<Volume, VolumeRevert, OkResponse>;

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
   * Break all the file locks on a volume
   */
  breakFileLocks is ArmResourceActionAsync<
    Volume,
    {
      /**
       * Optional body to provide the ability to clear file locks with selected options
       */
      @bodyRoot
      body?: BreakFileLocksRequest;
    },
    OkResponse
  >;

  /**
   * Returns the list of group Ids for a specific LDAP User
   */
  @action("getGroupIdListForLdapUser")
  listGetGroupIdListForLdapUser is ArmResourceActionAsync<
    Volume,
    GetGroupIdListForLdapUserRequest,
    ArmResponse<GetGroupIdListForLdapUserResponse>
  >;

  /**
   * Break the replication connection on the destination volume
   */
  breakReplication is ArmResourceActionAsync<
    Volume,
    {
      /**
       * Optional body to force break the replication.
       */
      @bodyRoot
      body?: BreakReplicationRequest;
    },
    OkResponse
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
  listReplications is ArmResourceActionSync<
    Volume,
    void,
    ArmResponse<ListReplications>
  >;

  /**
   * Resync the connection on the destination volume. If the operation is ran on the source volume it will reverse-resync the connection and sync from destination to source.
   */
  resyncReplication is ArmResourceActionAsync<Volume, void, OkResponse>;

  /**
   * Delete the replication connection on the destination volume, and send release to the source replication
   */
  deleteReplication is ArmResourceActionAsync<Volume, void, OkResponse>;

  /**
   * Authorize the replication connection on the source volume
   */
  authorizeReplication is ArmResourceActionAsync<
    Volume,
    AuthorizeRequest,
    OkResponse
  >;

  /**
   * Re-Initializes the replication connection on the destination volume
   */
  @action("reinitializeReplication")
  reInitializeReplication is ArmResourceActionAsync<Volume, void, OkResponse>;

  /**
   * Starts peering the external cluster for this migration volume
   */
  peerExternalCluster is ArmResourceActionAsync<
    Volume,
    PeerClusterForVolumeMigrationRequest,
    ArmResponse<ClusterPeerCommandResponse>
  >;

  /**
   * Starts SVM peering and returns a command to be run on the external ONTAP to accept it.  Once the SVM have been peered a SnapMirror will be created
   */
  authorizeExternalReplication is ArmResourceActionAsync<
    Volume,
    void,
    ArmResponse<SvmPeerCommandResponse>
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
  poolChange is ArmResourceActionAsync<Volume, PoolChangeRequest, OkResponse>;

  /**
   * Relocates volume to a new stamp
   */
  relocate is ArmResourceActionAsync<
    Volume,
    {
      /**
       * Relocate volume request
       */
      @bodyRoot
      body?: RelocateVolumeRequest;
    },
    OkResponse
  >;

  /**
   * Finalizes the relocation of the volume and cleans up the old volume.
   */
  finalizeRelocation is ArmResourceActionAsync<Volume, void, OkResponse>;

  /**
   * Reverts the volume relocation process, cleans up the new volume and starts using the former-existing volume.
   */
  revertRelocation is ArmResourceActionAsync<Volume, void, OkResponse>;

  /**
   * Get the latest status of the backup for a volume
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("current")
  @operationId("Backups_GetLatestStatus")
  getLatestStatus is ArmResourceActionSync<
    Volume,
    void,
    ArmResponse<BackupStatus>
  >;

  /**
   * Get the latest status of the restore for a volume
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("current")
  @operationId("Backups_GetVolumeLatestRestoreStatus")
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
@@encodedName(Volume.eTag, "application/json", "etag");
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
@@doc(Volumes.listGetGroupIdListForLdapUser::parameters.body,
  "Returns group Id list for a specific LDAP user"
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
@@doc(Volumes.migrateBackups::parameters.body,
  "Migrate backups under volume payload supplied in the body of the operation."
);
