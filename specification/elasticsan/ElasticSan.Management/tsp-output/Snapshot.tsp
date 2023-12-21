import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./VolumeGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ElasticSan;
@doc("Response for Volume Snapshot request.")
@parentResource(VolumeGroup)
model Snapshot is ProxyResource<SnapshotProperties> {
  @doc("The name of the volume snapshot within the given volume group.")
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-z0-9]+(?:[._-][a-z0-9]+)*$")
  @path
  @key("snapshotName")
  @segment("snapshots")
  name: string;
}

@armResourceOperations
interface VolumeSnapshots {
  @doc("Get a Volume Snapshot.")
  get is ArmResourceRead<Snapshot>;
  @doc("Create a Volume Snapshot.")
  create is ArmResourceCreateOrUpdateAsync<Snapshot>;
  @doc("Delete a Volume Snapshot.")
  delete is ArmResourceDeleteAsync<Snapshot>;
  @doc("List Snapshots in a VolumeGroup or List Snapshots by Volume (name) in a VolumeGroup using filter")
  listByVolumeGroup is ArmResourceListByParent<
    Snapshot,
    {
      ...BaseParameters<Snapshot>;

      @doc("Specify $filter='volumeName eq <volume name>' to filter on volume.")
      @query("$filter")
      $filter?: string;
    }
  >;
}
