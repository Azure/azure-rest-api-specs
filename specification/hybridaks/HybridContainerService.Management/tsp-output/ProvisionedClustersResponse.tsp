import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.HybridContainerService;
@doc("The provisionedClusters resource definition.")
model ProvisionedClustersResponse
  is TrackedResource<ProvisionedClustersResponseProperties> {
  @doc("Parameter for the name of the provisioned cluster")
  @maxLength(63)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
  @key("resourceName")
  @segment("provisionedClusters")
  name: string;

  extendedLocation?: ProvisionedClustersResponseExtendedLocation;
  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
@projectedName("client", "ProvisionedClusters")
interface ProvisionedClustersResponses_ProvisionedClusters {
  @doc("Gets the Hybrid AKS provisioned cluster")
  get is ArmResourceRead<ProvisionedClustersResponse>;

  @doc("Creates the Hybrid AKS provisioned cluster")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ProvisionedClustersResponse>;

  @doc("Updates the Hybrid AKS provisioned cluster")
  update is ArmCustomPatchAsync<
    ProvisionedClustersResponse,
    ProvisionedClustersPatch
  >;

  @doc("Deletes the Hybrid AKS provisioned cluster")
  delete is ArmResourceDeleteSync<ProvisionedClustersResponse>;

  @doc("Gets the Hybrid AKS provisioned cluster in a resource group")
  listByResourceGroup is ArmResourceListByParent<ProvisionedClustersResponse>;

  @doc("Gets the Hybrid AKS provisioned cluster in a subscription")
  listBySubscription is ArmListBySubscription<ProvisionedClustersResponse>;

  @doc("Upgrading the node image version of a cluster applies the newest OS and runtime updates to the nodes.")
  upgradeNodeImageVersionForEntireCluster is ArmResourceActionAsync<
    ProvisionedClustersResponse,
    void,
    void
  >;
}
