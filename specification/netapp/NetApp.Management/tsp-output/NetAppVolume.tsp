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
model NetAppVolume is TrackedResource<VolumeProperties> {
  @doc("The name of the volume")
  @maxLength(64)
  @minLength(1)
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$")
  @path
  @key("volumeName")
  @segment("volumes")
  name: string;

  @doc("Availability Zone")
  @visibility("read", "create")
  zones?: string[];
}

@armResourceOperations
interface NetAppVolumes {
  @doc("Get the details of the specified volume")
  get is ArmResourceRead<NetAppVolume>;
  @doc("Create or update the specified volume within the capacity pool")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NetAppVolume>;
  @doc("Patch the specified volume")
  update is ArmResourcePatchAsync<NetAppVolume, VolumeProperties>;
  @doc("Delete the specified volume")
  delete is ArmResourceDeleteWithoutOkAsync<
    NetAppVolume,
    {
      ...BaseParameters<NetAppVolume>;

      @doc("An option to force delete the volume. Will cleanup resources connected to the particular volume")
      @query("forceDelete")
      forceDelete?: boolean;
    }
  >;
  @doc("List all volumes within the capacity pool")
  list is ArmResourceListByParent<NetAppVolume>;
  @doc("This operation will populate availability zone information for a volume")
  populateAvailabilityZone is ArmResourceActionAsync<
    NetAppVolume,
    {},
    NetAppVolume
  >;
  @doc("Revert a volume to the snapshot specified in the body")
  revert is ArmResourceActionAsync<NetAppVolume, VolumeRevert, {}>;
  @doc("Reset cifs password from volume")
  resetCifsPassword is ArmResourceActionAsync<NetAppVolume, {}, {}>;
  @doc("Break all the file locks on a volume")
  breakFileLocks is ArmResourceActionAsync<
    NetAppVolume,
    BreakFileLocksRequest,
    {}
  >;
  @doc("Returns the list of group Ids for a specific LDAP User")
  listGetGroupIdListForLdapUser is ArmResourceActionAsync<
    NetAppVolume,
    GetGroupIdListForLdapUserRequest,
    GetGroupIdListForLdapUserResponse
  >;
  @doc("Break the replication connection on the destination volume")
  breakReplication is ArmResourceActionAsync<
    NetAppVolume,
    BreakReplicationRequest,
    {}
  >;
  @doc("Re-establish a previously deleted replication between 2 volumes that have a common ad-hoc or policy-based snapshots")
  reestablishReplication is ArmResourceActionNoResponseContentAsync<
    NetAppVolume,
    ReestablishReplicationRequest
  >;
  @doc("List all replications for a specified volume")
  listReplications is ArmResourceActionSync<NetAppVolume, {}, ListReplications>;
  @doc("Resync the connection on the destination volume. If the operation is ran on the source volume it will reverse-resync the connection and sync from destination to source.")
  resyncReplication is ArmResourceActionAsync<NetAppVolume, {}, {}>;
  @doc("Delete the replication connection on the destination volume, and send release to the source replication")
  deleteReplication is ArmResourceActionAsync<NetAppVolume, {}, {}>;
  @doc("Authorize the replication connection on the source volume")
  authorizeReplication is ArmResourceActionAsync<
    NetAppVolume,
    AuthorizeRequest,
    {}
  >;
  @doc("Re-Initializes the replication connection on the destination volume")
  reInitializeReplication is ArmResourceActionAsync<NetAppVolume, {}, {}>;
  @doc("Moves volume to another pool")
  poolChange is ArmResourceActionAsync<NetAppVolume, PoolChangeRequest, {}>;
  @doc("Relocates volume to a new stamp")
  relocate is ArmResourceActionAsync<NetAppVolume, RelocateVolumeRequest, {}>;
  @doc("Finalizes the relocation of the volume and cleans up the old volume.")
  finalizeRelocation is ArmResourceActionAsync<NetAppVolume, {}, {}>;
  @doc("Reverts the volume relocation process, cleans up the new volume and starts using the former-existing volume.")
  revertRelocation is ArmResourceActionAsync<NetAppVolume, {}, {}>;
  @summary("Get volume replication status")
  @doc("Get the status of the replication")
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

  @summary("Get volume's restore status")
  @doc("Get the status of the restore for a volume")
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
