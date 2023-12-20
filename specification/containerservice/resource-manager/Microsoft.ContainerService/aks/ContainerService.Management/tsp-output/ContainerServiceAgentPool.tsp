import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerServiceManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ContainerService;
@doc("Agent Pool.")
@parentResource(ContainerServiceManagedCluster)
model ContainerServiceAgentPool
  is ProxyResource<ManagedClusterAgentPoolProfileProperties> {
  @doc("The name of the agent pool.")
  @maxLength(12)
  @minLength(1)
  @pattern("^[a-z][a-z0-9]{0,11}$")
  @path
  @key("agentPoolName")
  @segment("agentPools")
  name: string;
}

@armResourceOperations
interface ContainerServiceAgentPools {
  @doc("Gets the specified managed cluster agent pool.")
  get is ArmResourceRead<ContainerServiceAgentPool>;
  @doc("Creates or updates an agent pool in the specified managed cluster.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ContainerServiceAgentPool>;
  @doc("Deletes an agent pool in the specified managed cluster.")
  delete is ArmResourceDeleteWithoutOkAsync<
    ContainerServiceAgentPool,
    {
      ...BaseParameters<ContainerServiceAgentPool>;

      @doc("ignore-pod-disruption-budget=true to delete those pods on a node without considering Pod Disruption Budget")
      @query("ignore-pod-disruption-budget")
      `ignore-pod-disruption-budget`?: boolean;
    }
  >;
  @doc("Gets a list of agent pools in the specified managed cluster.")
  list is ArmResourceListByParent<ContainerServiceAgentPool>;
  @doc("Aborts the currently running operation on the agent pool. The Agent Pool will be moved to a Canceling state and eventually to a Canceled state when cancellation finishes. If the operation completes before cancellation can take place, an error is returned.")
  abortLatestOperation is ArmResourceActionNoResponseContentAsync<
    ContainerServiceAgentPool,
    void
  >;
  @doc("Upgrading the node image version of an agent pool applies the newest OS and runtime updates to the nodes. AKS provides one new image per week with the latest updates. For more details on node image versions, see: https://docs.microsoft.com/azure/aks/node-image-upgrade")
  upgradeNodeImageVersion is ArmResourceActionAsync<
    ContainerServiceAgentPool,
    void,
    void
  >;
}
