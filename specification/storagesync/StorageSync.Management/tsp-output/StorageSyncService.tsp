import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.StorageSync;
@doc("Storage Sync Service object.")
model StorageSyncService is TrackedResource<StorageSyncServiceProperties> {
  @doc("Name of Storage Sync Service resource.")
  @path
  @key("storageSyncServiceName")
  @segment("storageSyncServices")
  name: string;
}

@armResourceOperations
interface StorageSyncServices {
  @doc("Get a given StorageSyncService.")
  get is ArmResourceRead<StorageSyncService>;
  @doc("Create a new StorageSyncService.")
  create is ArmResourceCreateOrUpdateAsync<StorageSyncService>;
  @doc("Patch a given StorageSyncService.")
  update is ArmResourcePatchAsync<
    StorageSyncService,
    StorageSyncServiceProperties
  >;
  @doc("Delete a given StorageSyncService.")
  delete is ArmResourceDeleteAsync<StorageSyncService>;
  @doc("Get a StorageSyncService list by Resource group name.")
  listByResourceGroup is ArmResourceListByParent<StorageSyncService>;
  @doc("Get a StorageSyncService list by subscription.")
  listBySubscription is ArmListBySubscription<StorageSyncService>;
  @doc("Gets the private link resources that need to be created for a storage sync service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/privateLinkResources")
  @get
  ListByStorageSyncService is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the storage sync service name within the specified resource group.")
      @path
      storageSyncServiceName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    PrivateLinkResourceListResult
  >;
}
