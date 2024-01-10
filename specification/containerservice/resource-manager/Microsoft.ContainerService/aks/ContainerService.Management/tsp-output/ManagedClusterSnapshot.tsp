import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ContainerService;
@doc("A managed cluster snapshot resource.")
model ManagedClusterSnapshot
  is TrackedResource<ManagedClusterSnapshotProperties> {
  @doc("The name of the managed cluster resource.")
  @maxLength(63)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
  @key("resourceName")
  @segment("managedclustersnapshots")
  name: string;
}

@armResourceOperations
interface ManagedClusterSnapshots {
  @doc("Gets a managed cluster snapshot.")
  get is ArmResourceRead<ManagedClusterSnapshot>;

  @doc("Creates or updates a managed cluster snapshot.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ManagedClusterSnapshot>;

  @doc("Updates tags on a managed cluster snapshot.")
  updateTags is ArmCustomPatchSync<ManagedClusterSnapshot, TagsObject>;

  @doc("Deletes a managed cluster snapshot.")
  delete is ArmResourceDeleteSync<ManagedClusterSnapshot>;

  @doc("Lists managed cluster snapshots in the specified subscription and resource group.")
  listByResourceGroup is ArmResourceListByParent<ManagedClusterSnapshot>;

  @doc("Gets a list of managed cluster snapshots in the specified subscription.")
  list is ArmListBySubscription<ManagedClusterSnapshot>;
}
