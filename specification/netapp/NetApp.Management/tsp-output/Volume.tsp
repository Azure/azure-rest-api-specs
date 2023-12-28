import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./CapacityPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetApp;
@doc("Volume resource")
@parentResource(CapacityPool)
model Volume is TrackedResource<VolumeProperties> {
  @doc("The name of the volume")
  @maxLength(64)
  @minLength(1)
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$")
  @key("volumeName")
  @segment("volumes")
  name: string;

  @doc("A unique read-only string that changes whenever the resource is updated.")
  @visibility("read")
  etag?: string;

  @doc("Availability Zone")
  @visibility("read", "create")
  zones?: string[];
}

@armResourceOperations
interface Volumes {
  @doc("Get the details of the specified volume")
  get is ArmResourceRead<Volume>;
  @doc("Create or update the specified volume within the capacity pool")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Volume>;
  @doc("Patch the specified volume")
  update is ArmCustomPatchAsync<Volume, VolumePatch>;
  @doc("Delete the specified volume")
  delete is ArmResourceDeleteWithoutOkAsync<
    Volume,
    {
      ...BaseParameters<Volume>;

      @doc("An option to force delete the volume. Will cleanup resources connected to the particular volume")
      @query("forceDelete")
      forceDelete?: boolean;
    }
  >;
  @doc("List all volumes within the capacity pool")
  list is ArmResourceListByParent<Volume>;
  @doc("This operation will populate availability zone information for a volume")
  populateAvailabilityZone is ArmResourceActionAsync<Volume, void, Volume>;
  @doc("Revert a volume to the snapshot specified in the body")
  revert is ArmResourceActionAsync<Volume, VolumeRevert, void>;
  @doc("Reset cifs password from volume")
  resetCifsPassword is ArmResourceActionAsync<Volume, void, void>;
  @doc("Break all the file locks on a volume")
  breakFileLocks is ArmResourceActionAsync<Volume, BreakFileLocksRequest, void>;
  @doc("Returns the list of group Ids for a specific LDAP User")
  listGetGroupIdListForLdapUser is ArmResourceActionAsync<
    Volume,
    GetGroupIdListForLdapUserRequest,
    GetGroupIdListForLdapUserResponse
  >;
  @doc("Break the replication connection on the destination volume")
  breakReplication is ArmResourceActionAsync<
    Volume,
    BreakReplicationRequest,
    void
  >;
  @doc("Re-establish a previously deleted replication between 2 volumes that have a common ad-hoc or policy-based snapshots")
  reestablishReplication is ArmResourceActionNoResponseContentAsync<
    Volume,
    ReestablishReplicationRequest
  >;
  @doc("List all replications for a specified volume")
  listReplications is ArmResourceActionSync<Volume, void, ListReplications>;
  @doc("Resync the connection on the destination volume. If the operation is ran on the source volume it will reverse-resync the connection and sync from destination to source.")
  resyncReplication is ArmResourceActionAsync<Volume, void, void>;
  @doc("Delete the replication connection on the destination volume, and send release to the source replication")
  deleteReplication is ArmResourceActionAsync<Volume, void, void>;
  @doc("Authorize the replication connection on the source volume")
  authorizeReplication is ArmResourceActionAsync<
    Volume,
    AuthorizeRequest,
    void
  >;
  @doc("Re-Initializes the replication connection on the destination volume")
  reInitializeReplication is ArmResourceActionAsync<Volume, void, void>;
  @doc("Moves volume to another pool")
  poolChange is ArmResourceActionAsync<Volume, PoolChangeRequest, void>;
  @doc("Relocates volume to a new stamp")
  relocate is ArmResourceActionAsync<Volume, RelocateVolumeRequest, void>;
  @doc("Finalizes the relocation of the volume and cleans up the old volume.")
  finalizeRelocation is ArmResourceActionAsync<Volume, void, void>;
  @doc("Reverts the volume relocation process, cleans up the new volume and starts using the former-existing volume.")
  revertRelocation is ArmResourceActionAsync<Volume, void, void>;
  @summary("Get volume replication status")
  @doc("Get the status of the replication")
  // FIXME: Volumes_ReplicationStatus could not be converted to a resource operation
  // FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
  // Problematic names: [ReplicationStatus]
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetApp/netAppAccounts/{accountName}/capacityPools/{poolName}/volumes/{volumeName}/replicationStatus")
  @get
  ReplicationStatus is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the NetApp account")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,127}$")
      @path
      accountName: string;

      @doc("The name of the capacity pool")
      @maxLength(64)
      @minLength(1)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,63}$")
      @path
      poolName: string;

      @doc("The name of the volume")
      @maxLength(64)
      @minLength(1)
      @pattern("^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$")
      @path
      volumeName: string;
    },
    ReplicationStatus
  >;
}

@armResourceOperations
interface Backups {
  @summary("Get volume's restore status")
  @doc("Get the status of the restore for a volume")
  // FIXME: Backups_GetVolumeRestoreStatus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetApp/netAppAccounts/{accountName}/capacityPools/{poolName}/volumes/{volumeName}/restoreStatus")
  @get
  GetVolumeRestoreStatus is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the NetApp account")
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,127}$")
      @path
      accountName: string;

      @doc("The name of the capacity pool")
      @maxLength(64)
      @minLength(1)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,63}$")
      @path
      poolName: string;

      @doc("The name of the volume")
      @maxLength(64)
      @minLength(1)
      @pattern("^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$")
      @path
      volumeName: string;
    },
    RestoreStatus
  >;
}
