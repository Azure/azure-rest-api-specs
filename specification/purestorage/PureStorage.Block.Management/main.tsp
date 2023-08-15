import "./LiftrBase.Storage/main.tsp";

import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

@armProviderNamespace
@service({
  title: "PureStorage.Block",
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
  v1_preview: "2023-06-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("StoragePool resource.")
model StoragePool is TrackedResource<BaseStorageResourceProperties> {
  @doc("Name of the storage pool.")
  @key("storagePool")
  @segment("storagePools")
  @path
  @minLength(4)
  @maxLength(20)
  name: string;
}

@armResourceOperations
interface StoragePools {
  get is ArmResourceRead<StoragePool>;
  create is ArmResourceCreateOrUpdateAsync<StoragePool>;
  update is ArmResourcePatchAsync<StoragePool, BaseStorageResourceProperties>;
  delete is ArmResourceDeleteAsync<StoragePool>;
  listByResourceGroup is ArmResourceListByParent<StoragePool>;
  listBySubscription is ArmListBySubscription<StoragePool>;
}
