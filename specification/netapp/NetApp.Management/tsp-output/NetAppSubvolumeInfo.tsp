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
@doc("Subvolume Information properties")
@parentResource(NetAppVolume)
model NetAppSubvolumeInfo is ProxyResource<SubvolumeProperties> {
  @doc("The name of the subvolume.")
  @maxLength(64)
  @minLength(1)
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$")
  @path
  @key("subvolumeName")
  @segment("subvolumes")
  name: string;
}

@armResourceOperations
interface NetAppSubvolumeInfos {
  @doc("Returns the path associated with the subvolumeName provided")
  get is ArmResourceRead<NetAppSubvolumeInfo>;
  @doc("Creates a subvolume in the path or clones the subvolume mentioned in the parentPath")
  create is ArmResourceCreateOrUpdateAsync<NetAppSubvolumeInfo>;
  @doc("Patch a subvolume")
  update is ArmResourcePatchAsync<NetAppSubvolumeInfo, SubvolumeProperties>;
  @doc("Delete subvolume")
  delete is ArmResourceDeleteAsync<NetAppSubvolumeInfo>;
  @doc("Returns a list of the subvolumes in the volume")
  listByVolume is ArmResourceListByParent<NetAppSubvolumeInfo>;
  @doc("Get details of the specified subvolume")
  getMetadata is ArmResourceActionAsync<
    NetAppSubvolumeInfo,
    void,
    SubvolumeModel
  >;
}
