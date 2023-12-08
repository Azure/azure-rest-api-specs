import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppPlatformService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("Storage resource payload.")
@parentResource(AppPlatformService)
model AppPlatformStorage is ProxyResource<StorageProperties> {
  @doc("The name of the storage resource.")
  @path
  @key("storageName")
  @segment("storages")
  name: string;
}

@armResourceOperations
interface AppPlatformStorages {
  @doc("Get the storage resource.")
  get is ArmResourceRead<AppPlatformStorage>;
  @doc("Create or update storage resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AppPlatformStorage>;
  @doc("Delete the storage resource.")
  delete is ArmResourceDeleteAsync<AppPlatformStorage>;
  @doc("List all the storages of one Azure Spring Apps resource.")
  list is ArmResourceListByParent<AppPlatformStorage>;
}
