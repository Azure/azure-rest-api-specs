import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.StorageMover;
@doc("The Storage Mover resource, which is a container for a group of Agents, Projects, and Endpoints.")
model StorageMover is TrackedResource<StorageMoverProperties> {
  @doc("The name of the Storage Mover resource.")
  @key("storageMoverName")
  @segment("storageMovers")
  name: string;
}

@armResourceOperations
interface StorageMovers {
  @doc("Gets a Storage Mover resource.")
  get is ArmResourceRead<StorageMover>;

  @doc("Creates or updates a top-level Storage Mover resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<StorageMover>;

  @doc("Updates properties for a Storage Mover resource. Properties not specified in the request body will be unchanged.")
  update is ArmCustomPatchSync<StorageMover, StorageMoverUpdateParameters>;

  @doc("Deletes a Storage Mover resource.")
  delete is ArmResourceDeleteAsync<StorageMover>;

  @doc("Lists all Storage Movers in a resource group.")
  list is ArmResourceListByParent<StorageMover>;

  @doc("Lists all Storage Movers in a subscription.")
  listBySubscription is ArmListBySubscription<StorageMover>;
}
