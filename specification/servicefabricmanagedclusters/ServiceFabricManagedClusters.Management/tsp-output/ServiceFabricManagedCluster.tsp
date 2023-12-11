import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ServiceFabricManagedClusters;
@doc("""
The managed cluster resource

""")
model ServiceFabricManagedCluster is TrackedResource<ManagedClusterProperties> {
  @doc("The name of the cluster resource.")
  @path
  @key("clusterName")
  @segment("managedClusters")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface ServiceFabricManagedClusters {
  @doc("Get a Service Fabric managed cluster resource created or in the process of being created in the specified resource group.")
  get is ArmResourceRead<ServiceFabricManagedCluster>;
  @doc("Create or update a Service Fabric managed cluster resource with the specified name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServiceFabricManagedCluster>;
  @doc("Update the tags of of a Service Fabric managed cluster resource with the specified name.")
  update is ArmTagsPatchSync<ServiceFabricManagedCluster>;
  @doc("Delete a Service Fabric managed cluster resource with the specified name.")
  delete is ArmResourceDeleteAsync<ServiceFabricManagedCluster>;
  @doc("Gets all Service Fabric cluster resources created or in the process of being created in the resource group.")
  listByResourceGroup is ArmResourceListByParent<ServiceFabricManagedCluster>;
  @doc("Gets all Service Fabric cluster resources created or in the process of being created in the subscription.")
  listBySubscription is ArmListBySubscription<ServiceFabricManagedCluster>;
  @doc("Action to get Az Resiliency Status of all the Base resources constituting Service Fabric Managed Clusters.")
  get is ArmResourceActionSync<
    ServiceFabricManagedCluster,
    {},
    ManagedAzResiliencyStatus
  >;
}
