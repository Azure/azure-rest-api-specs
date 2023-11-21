import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace HybridContainerService;

interface ProvisionedClustersOperations {
  @summary("Gets the provisioned cluster")
  @doc("Gets the Hybrid AKS provisioned cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/provisionedClusters/{resourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the provisioned cluster")
      @path
      resourceName: string;
    },
    ProvisionedClustersResponse
  >;

  @summary("Creates the provisioned cluster")
  @doc("Creates the Hybrid AKS provisioned cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/provisionedClusters/{resourceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the provisioned cluster")
      @path
      resourceName: string;

      @body provisionedClusters: ProvisionedClusters;
    },
    ProvisionedClustersResponse
  >;

  @summary("Deletes the provisioned cluster")
  @doc("Deletes the Hybrid AKS provisioned cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/provisionedClusters/{resourceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the provisioned cluster")
      @path
      resourceName: string;
    },
    void
  >;

  @summary("Updates the provisioned cluster")
  @doc("Updates the Hybrid AKS provisioned cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/provisionedClusters/{resourceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the provisioned cluster")
      @path
      resourceName: string;

      @body provisionedClusters: ProvisionedClustersPatch;
    },
    ProvisionedClustersResponse
  >;

  @summary("Gets the provisioned clusters in a resource group")
  @doc("Gets the Hybrid AKS provisioned cluster in a resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/provisionedClusters")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;
    },
    ProvisionedClustersResponseListResult
  >;

  @summary("Gets the provisioned clusters in a subscription")
  @doc("Gets the Hybrid AKS provisioned cluster in a subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HybridContainerService/provisionedClusters")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    ProvisionedClustersResponseListResult
  >;

  @summary("Gets the upgrade profile of a provisioned cluster.")
  @doc("Gets the upgrade profile of a provisioned cluster.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/provisionedClusters/{resourceName}/upgradeProfiles/default")
  @get
  GetUpgradeProfile is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the provisioned cluster")
      @path
      resourceName: string;
    },
    ProvisionedClusterUpgradeProfile
  >;

  @summary("""
Upgrades the node image version of the cluster control plane and all agent
pools to the latest.
""")
  @doc("""
Upgrading the node image version of a cluster applies the newest OS and runtime
updates to the nodes.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/provisionedClusters/{resourceName}/upgradeNodeImageVersionForEntireCluster")
  @post
  UpgradeNodeImageVersionForEntireCluster is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the provisioned cluster")
      @path
      resourceName: string;
    },
    void
  >;
}

interface HybridIdentityMetadataOperations {
  @summary("Creates the hybrid identity metadata resource")
  @doc("""
Creates the hybrid identity metadata proxy resource that facilitates the
managed identity provisioning.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/provisionedClusters/{resourceName}/hybridIdentityMetadata/{hybridIdentityMetadataResourceName}")
  @put
  Put is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the provisioned cluster")
      @path
      resourceName: string;

      @doc("Parameter for the name of the hybrid identity metadata resource.")
      @path
      hybridIdentityMetadataResourceName: string;

      @body body: HybridIdentityMetadata;
    },
    HybridIdentityMetadata
  >;

  @summary("Get the hybrid identity metadata resource")
  @doc("Get the hybrid identity metadata proxy resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/provisionedClusters/{resourceName}/hybridIdentityMetadata/{hybridIdentityMetadataResourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the provisioned cluster")
      @path
      resourceName: string;

      @doc("Parameter for the name of the hybrid identity metadata resource.")
      @path
      hybridIdentityMetadataResourceName: string;
    },
    HybridIdentityMetadata
  >;

  @summary("Deletes the hybrid identity metadata resource")
  @doc("Deletes the hybrid identity metadata proxy resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/provisionedClusters/{resourceName}/hybridIdentityMetadata/{hybridIdentityMetadataResourceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the provisioned cluster")
      @path
      resourceName: string;

      @doc("Parameter for the name of the hybrid identity metadata resource.")
      @path
      hybridIdentityMetadataResourceName: string;
    },
    void
  >;

  @summary("Lists the hybrid identity metadata resources in a cluster")
  @doc("Lists the hybrid identity metadata proxy resource in a cluster.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/provisionedClusters/{resourceName}/hybridIdentityMetadata")
  @get
  ListByCluster is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the provisioned cluster")
      @path
      resourceName: string;
    },
    HybridIdentityMetadataList
  >;
}

interface agentPoolOperations {
  @summary("Gets the agent pool in the provisioned cluster")
  @doc("Gets the agent pool in the Hybrid AKS provisioned cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/provisionedClusters/{resourceName}/agentPools/{agentPoolName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the provisioned cluster")
      @path
      resourceName: string;

      @doc("Parameter for the name of the agent pool in the provisioned cluster")
      @path
      agentPoolName: string;
    },
    AgentPool
  >;

  @summary("Creates the agent pool in the provisioned cluster")
  @doc("Creates the agent pool in the Hybrid AKS provisioned cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/provisionedClusters/{resourceName}/agentPools/{agentPoolName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the provisioned cluster")
      @path
      resourceName: string;

      @doc("Parameter for the name of the agent pool in the provisioned cluster")
      @path
      agentPoolName: string;

      @body agentPool: AgentPool;
    },
    AgentPool
  >;

  @summary("Deletes the agent pool in the provisioned cluster")
  @doc("Deletes the agent pool in the Hybrid AKS provisioned cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/provisionedClusters/{resourceName}/agentPools/{agentPoolName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the provisioned cluster")
      @path
      resourceName: string;

      @doc("Parameter for the name of the agent pool in the provisioned cluster")
      @path
      agentPoolName: string;
    },
    void
  >;

  @summary("Updates the agent pool in the provisioned cluster")
  @doc("Updates the agent pool in the Hybrid AKS provisioned cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/provisionedClusters/{resourceName}/agentPools/{agentPoolName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the provisioned cluster")
      @path
      resourceName: string;

      @doc("Parameter for the name of the agent pool in the provisioned cluster")
      @path
      agentPoolName: string;

      @body agentPool: AgentPool;
    },
    AgentPool
  >;

  @summary("Gets the agent pools in the provisioned cluster")
  @doc("Gets the agent pools in the Hybrid AKS provisioned cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/provisionedClusters/{resourceName}/agentPools")
  @get
  ListByProvisionedCluster is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the provisioned cluster")
      @path
      resourceName: string;
    },
    AgentPoolListResult
  >;
}

interface HybridContainerServiceOperations {
  @summary("Lists the available orchestrators in a custom location")
  @doc("Lists the available orchestrators in a custom location for HybridAKS")
  @route("/{customLocationResourceUri}/providers/Microsoft.HybridContainerService/orchestrators")
  @get
  ListOrchestrators is Azure.Core.Foundations.Operation<
    {
      @doc("""
The fully qualified Azure Resource manager identifier of the custom location
resource.
""")
      @path
      customLocationResourceUri: string;
    },
    OrchestratorVersionProfileListResult
  >;

  @summary("Lists the available VM SKUs in a custom location")
  @doc("Lists the available VM SKUs in a custom location for HybridAKS")
  @route("/{customLocationResourceUri}/providers/Microsoft.HybridContainerService/vmSkus")
  @get
  ListVMSkus is Azure.Core.Foundations.Operation<
    {
      @doc("""
The fully qualified Azure Resource manager identifier of the custom location
resource.
""")
      @path
      customLocationResourceUri: string;
    },
    VMSkuListResult
  >;
}

interface OperationsOperations {
  @route("/providers/Microsoft.HybridContainerService/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, ResourceProviderOperationList>;
}

interface storageSpacesOperations {
  @summary("Gets the storage space object")
  @doc("Gets the Hybrid AKS storage space object")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/storageSpaces/{storageSpacesName}")
  @get
  Retrieve is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the storage object")
      @path
      storageSpacesName: string;
    },
    StorageSpaces
  >;

  @summary("Puts the storage object")
  @doc("Puts the Hybrid AKS storage object")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/storageSpaces/{storageSpacesName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the storage object")
      @path
      storageSpacesName: string;

      @body storageSpaces: StorageSpaces;
    },
    StorageSpaces
  >;

  @summary("Deletes the storage object")
  @doc("Deletes the Hybrid AKS storage object")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/storageSpaces/{storageSpacesName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the storage object")
      @path
      storageSpacesName: string;
    },
    void
  >;

  @summary("Patches the storage object")
  @doc("Patches the Hybrid AKS storage object")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/storageSpaces/{storageSpacesName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the storage object")
      @path
      storageSpacesName: string;

      @body storageSpaces: StorageSpacesPatch;
    },
    StorageSpaces
  >;

  @summary("List the storage object by resource group")
  @doc("List the Hybrid AKS storage object by resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/storageSpaces")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;
    },
    StorageSpacesListResult
  >;

  @summary("List the storage object by subscription")
  @doc("List the Hybrid AKS storage object by subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HybridContainerService/storageSpaces")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    StorageSpacesListResult
  >;
}

interface virtualNetworksOperations {
  @summary("Gets the virtual network")
  @doc("Gets the Hybrid AKS virtual network")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/virtualNetworks/{virtualNetworksName}")
  @get
  Retrieve is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the virtual network")
      @path
      virtualNetworksName: string;
    },
    VirtualNetworks
  >;

  @summary("Puts the virtual network")
  @doc("Puts the Hybrid AKS virtual network")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/virtualNetworks/{virtualNetworksName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the virtual network")
      @path
      virtualNetworksName: string;

      @body virtualNetworks: VirtualNetworks;
    },
    VirtualNetworks
  >;

  @summary("Deletes the virtual network")
  @doc("Deletes the Hybrid AKS virtual network")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/virtualNetworks/{virtualNetworksName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the virtual network")
      @path
      virtualNetworksName: string;
    },
    void
  >;

  @summary("Patches the virtual network")
  @doc("Patches the Hybrid AKS virtual network")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/virtualNetworks/{virtualNetworksName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Parameter for the name of the virtual network")
      @path
      virtualNetworksName: string;

      @body virtualNetworks: VirtualNetworksPatch;
    },
    VirtualNetworks
  >;

  @summary("List virtual networks by resource group")
  @doc("Lists the Hybrid AKS virtual networks by resource group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/virtualNetworks")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;
    },
    VirtualNetworksListResult
  >;

  @summary("List virtual networks by subscription")
  @doc("Lists the Hybrid AKS virtual networks by subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HybridContainerService/virtualNetworks")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    VirtualNetworksListResult
  >;
}
