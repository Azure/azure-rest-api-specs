import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AppPlatform;
@doc("Storage resource payload.")
@parentResource(ServiceResource)
model StorageResource is ProxyResource<StorageProperties> {
  @doc("The name of the storage resource.")
  @key("storageName")
  @segment("storages")
  name: string;
}

@armResourceOperations
@projectedName("client", "Storages")
interface StorageResources_Storages {
  @doc("Get the storage resource.")
  get is ArmResourceRead<StorageResource>;

  @doc("Create or update storage resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<StorageResource>;

  @doc("Delete the storage resource.")
  delete is ArmResourceDeleteAsync<StorageResource>;

  @doc("List all the storages of one Azure Spring Apps resource.")
  list is ArmResourceListByParent<StorageResource>;
}
