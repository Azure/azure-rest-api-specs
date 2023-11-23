import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.HybridContainerService;
@doc("The storageSpaces resource definition.")
model StorageSpace is TrackedResource<StorageSpacesProperties> {
  @doc("Parameter for the name of the storage object")
  @maxLength(64)
  @minLength(3)
  @path
  @key("storageSpacesName")
  @segment("storageSpaces")
  name: string;

  extendedLocation?: StorageSpacesExtendedLocation;
}

@armResourceOperations
interface StorageSpaces {
  @doc("Gets the Hybrid AKS storage space object")
  retrieve is ArmResourceRead<StorageSpace>;
  @doc("Puts the Hybrid AKS storage object")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<StorageSpace>;
  @doc("Patches the Hybrid AKS storage object")
  update is ArmTagsPatchAsync<StorageSpace>;
  @doc("Deletes the Hybrid AKS storage object")
  delete is ArmResourceDeleteSync<StorageSpace>;
  @doc("List the Hybrid AKS storage object by resource group")
  listByResourceGroup is ArmResourceListByParent<StorageSpace>;
  @doc("List the Hybrid AKS storage object by subscription")
  listBySubscription is ArmListBySubscription<StorageSpace>;
}
