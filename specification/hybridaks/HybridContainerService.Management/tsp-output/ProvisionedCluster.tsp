import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HybridContainerService;
@doc("The provisionedClusters resource definition.")
model ProvisionedCluster
  is TrackedResource<ProvisionedClustersResponseProperties> {
  @doc("Parameter for the name of the provisioned cluster")
  @maxLength(63)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
  @path
  @key("resourceName")
  @segment("provisionedClusters")
  name: string;

  extendedLocation?: ProvisionedClustersResponseExtendedLocation;
  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface ProvisionedClusters {
  @doc("Gets the Hybrid AKS provisioned cluster")
  get is ArmResourceRead<ProvisionedCluster>;
  @doc("Creates the Hybrid AKS provisioned cluster")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ProvisionedCluster>;
  @doc("Updates the Hybrid AKS provisioned cluster")
  update is ArmTagsPatchAsync<ProvisionedCluster>;
  @doc("Deletes the Hybrid AKS provisioned cluster")
  delete is ArmResourceDeleteSync<ProvisionedCluster>;
  @doc("Gets the Hybrid AKS provisioned cluster in a resource group")
  listByResourceGroup is ArmResourceListByParent<ProvisionedCluster>;
  @doc("Gets the Hybrid AKS provisioned cluster in a subscription")
  listBySubscription is ArmListBySubscription<ProvisionedCluster>;
  @doc("Upgrading the node image version of a cluster applies the newest OS and runtime updates to the nodes.")
  upgradeNodeImageVersionForEntireCluster is ArmResourceActionAsync<
    ProvisionedCluster,
    void,
    void
  >;
}
