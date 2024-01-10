import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Volume.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.NetApp;
@doc("Snapshot of a Volume")
@parentResource(Volume)
model Snapshot is ProxyResource<SnapshotProperties> {
  @doc("The name of the snapshot")
  @key("snapshotName")
  @segment("snapshots")
  name: string;
}

@armResourceOperations
interface Snapshots {
  @doc("Get details of the specified snapshot")
  get is ArmResourceRead<Snapshot>;

  @doc("Create the specified snapshot within the given volume")
  create is ArmResourceCreateOrUpdateAsync<Snapshot>;

  @doc("Delete snapshot")
  delete is ArmResourceDeleteAsync<Snapshot>;

  @doc("List all snapshots associated with the volume")
  list is ArmResourceListByParent<Snapshot>;

  @doc("Restore the specified files from the specified snapshot to the active filesystem")
  restoreFiles is ArmResourceActionAsync<Snapshot, SnapshotRestoreFiles, void>;
}
