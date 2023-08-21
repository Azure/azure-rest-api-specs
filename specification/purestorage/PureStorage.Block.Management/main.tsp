import "./LiftrBase.Storage/main.tsp";

import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

@armProviderNamespace
@service({
    title: "PureStorage.Block"
})
@versioned(PureStorage.Block.Versions)
namespace PureStorage.Block;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

using LiftrBase;
using LiftrBase.Storage;

@doc("API versions of PureStorage.Block")
enum Versions {
    @doc("Version 1 preview.")
    @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
    @useDependency(LiftrBase.Versions.v1_preview)
    @useDependency(LiftrBase.Storage.Versions.v1_preview)
    v1_preview: "2023-06-01-preview"
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("VolumePool resource.")
model VolumePool is TrackedResource<BaseStorageResourceProperties> {

  @doc("Name of the volume pool.")
  @key("volumePool")
  @segment("volumePools")
  @path
  @minLength(4)
  @maxLength(20)
  name: string;
}

@armResourceOperations
interface VolumePools {
  get is ArmResourceRead<VolumePool>;
  create is ArmResourceCreateOrUpdateAsync<VolumePool>;
  update is ArmResourcePatchAsync<VolumePool, BaseStorageResourceProperties>;
  delete is ArmResourceDeleteAsync<VolumePool>;
  listByResourceGroup is ArmResourceListByParent<VolumePool>;
  listBySubscription is ArmListBySubscription<VolumePool>;
}