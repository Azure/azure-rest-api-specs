import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.OperationalInsights;
@doc("The top level Log Analytics cluster resource container.")
model Cluster is TrackedResource<ClusterProperties> {
  @doc("Name of the Log Analytics Cluster.")
  @path
  @key("clusterName")
  @segment("clusters")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface Clusters {
  @doc("Gets a Log Analytics cluster instance.")
  get is ArmResourceRead<Cluster>;
  @doc("Create or update a Log Analytics cluster.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Cluster>;
  @doc("Updates a Log Analytics cluster.")
  update is ArmResourcePatchAsync<Cluster, ClusterProperties>;
  @doc("Deletes a cluster instance.")
  delete is ArmResourceDeleteAsync<Cluster>;
  @doc("Gets Log Analytics clusters in a resource group.")
  listByResourceGroup is ArmResourceListByParent<Cluster>;
  @doc("Gets the Log Analytics clusters in a subscription.")
  list is ArmListBySubscription<Cluster>;
}
