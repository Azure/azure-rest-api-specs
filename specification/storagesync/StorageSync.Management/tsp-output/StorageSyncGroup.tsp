import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./StorageSyncService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.StorageSync;
@doc("Sync Group object.")
@parentResource(StorageSyncService)
model StorageSyncGroup is ProxyResource<SyncGroupProperties> {
  @doc("Name of Sync Group resource.")
  @path
  @key("syncGroupName")
  @segment("syncGroups")
  name: string;
}

@armResourceOperations
interface StorageSyncGroups {
  @doc("Get a given SyncGroup.")
  get is ArmResourceRead<StorageSyncGroup>;
  @doc("Create a new SyncGroup.")
  create is ArmResourceCreateOrReplaceSync<StorageSyncGroup>;
  @doc("Delete a given SyncGroup.")
  delete is ArmResourceDeleteSync<StorageSyncGroup>;
  @doc("Get a SyncGroup List.")
  listByStorageSyncService is ArmResourceListByParent<StorageSyncGroup>;
}
