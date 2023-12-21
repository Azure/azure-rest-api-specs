import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Hci;
@doc("The storage container resource definition.")
model StorageContainers is TrackedResource<StorageContainerProperties> {
  @doc("Name of the storage container")
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[_a-zA-Z0-9]$")
  @path
  @key("storageContainerName")
  @segment("storageContainers")
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface StorageContainers {
  @doc("Gets a storage container")
  get is ArmResourceRead<StorageContainers>;
  @doc("The operation to create or update a storage container. Please note some properties can be set only during storage container creation.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<StorageContainers>;
  @doc("The operation to update a storage container.")
  update is ArmTagsPatchAsync<StorageContainers>;
  @doc("The operation to delete a storage container.")
  delete is ArmResourceDeleteWithoutOkAsync<StorageContainers>;
  @doc("Lists all of the storage containers in the specified resource group. Use the nextLink property in the response to get the next page of storage containers.")
  list is ArmResourceListByParent<StorageContainers>;
  @doc("Lists all of the storage containers in the specified subscription. Use the nextLink property in the response to get the next page of storage containers.")
  listAll is ArmListBySubscription<StorageContainers>;
}
