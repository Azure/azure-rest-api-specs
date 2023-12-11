import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NetAppVolume.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetApp;
@doc("Snapshot of a Volume")
@parentResource(NetAppVolume)
model NetAppVolumeSnapshot is ProxyResource<SnapshotProperties> {
  @doc("The name of the snapshot")
  @path
  @key("snapshotName")
  @segment("snapshots")
  name: string;
}

@armResourceOperations
interface NetAppVolumeSnapshots {
  @doc("Get details of the specified snapshot")
  get is ArmResourceRead<NetAppVolumeSnapshot>;
  @doc("Create the specified snapshot within the given volume")
  create is ArmResourceCreateOrUpdateAsync<NetAppVolumeSnapshot>;
  @doc("Delete snapshot")
  delete is ArmResourceDeleteAsync<NetAppVolumeSnapshot>;
  @doc("List all snapshots associated with the volume")
  list is ArmResourceListByParent<NetAppVolumeSnapshot>;
  @doc("Restore the specified files from the specified snapshot to the active filesystem")
  restoreFiles is ArmResourceActionAsync<
    NetAppVolumeSnapshot,
    SnapshotRestoreFiles,
    {}
  >;
}
