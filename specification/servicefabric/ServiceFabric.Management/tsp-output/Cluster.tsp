import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ServiceFabric;
@doc("""
The cluster resource

""")
model Cluster is TrackedResource<ClusterProperties> {
  @doc("The name of the cluster resource.")
  @path
  @key("clusterName")
  @segment("clusters")
  name: string;
}

@armResourceOperations
interface Clusters {
  @doc("Get a Service Fabric cluster resource created or in the process of being created in the specified resource group.")
  get is ArmResourceRead<Cluster>;
  @doc("Create or update a Service Fabric cluster resource with the specified name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Cluster>;
  @doc("Update the configuration of a Service Fabric cluster resource with the specified name.")
  update is ArmResourcePatchAsync<Cluster, ClusterProperties>;
  @doc("Delete a Service Fabric cluster resource with the specified name.")
  delete is ArmResourceDeleteSync<Cluster>;
  @doc("Gets all Service Fabric cluster resources created or in the process of being created in the resource group.")
  listByResourceGroup is ArmResourceListByParent<Cluster>;
  @doc("Gets all Service Fabric cluster resources created or in the process of being created in the subscription.")
  list is ArmListBySubscription<Cluster>;
  @doc("If a target is not provided, it will get the minimum and maximum versions available from the current cluster version. If a target is given, it will provide the required path to get from the current cluster version to the target version.")
  listUpgradableVersions is ArmResourceActionSync<
    Cluster,
    UpgradableVersionsDescription,
    UpgradableVersionPathResult
  >;
}
