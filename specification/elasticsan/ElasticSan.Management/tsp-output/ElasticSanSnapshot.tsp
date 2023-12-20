import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ElasticSanVolumeGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ElasticSan;
@doc("Response for Volume Snapshot request.")
@parentResource(ElasticSanVolumeGroup)
model ElasticSanSnapshot is ProxyResource<SnapshotProperties> {
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
interface ElasticSanSnapshots {
  @doc("Get a Volume Snapshot.")
  get is ArmResourceRead<ElasticSanSnapshot>;
  @doc("Create a Volume Snapshot.")
  create is ArmResourceCreateOrUpdateAsync<ElasticSanSnapshot>;
  @doc("Delete a Volume Snapshot.")
  delete is ArmResourceDeleteAsync<ElasticSanSnapshot>;
  @doc("List Snapshots in a VolumeGroup or List Snapshots by Volume (name) in a VolumeGroup using filter")
  listByVolumeGroup is ArmResourceListByParent<
    ElasticSanSnapshot,
    {
      ...BaseParameters<ElasticSanSnapshot>;

      @doc("Specify $filter='volumeName eq <volume name>' to filter on volume.")
      @query("$filter")
      $filter?: string;
    }
  >;
}
