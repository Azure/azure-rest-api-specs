import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ContainerService;
@doc("Agent Pool.")
@parentResource(ManagedCluster)
model AgentPool is ProxyResource<ManagedClusterAgentPoolProfileProperties> {
  @doc("The name of the agent pool.")
  @maxLength(12)
  @minLength(1)
  @pattern("^[a-z][a-z0-9]{0,11}$")
  @key("agentPoolName")
  @segment("agentPools")
  name: string;
}

@armResourceOperations
interface AgentPools {
  @doc("Gets the specified managed cluster agent pool.")
  get is ArmResourceRead<AgentPool>;

  @doc("Creates or updates an agent pool in the specified managed cluster.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AgentPool>;

  @doc("Deletes an agent pool in the specified managed cluster.")
  delete is ArmResourceDeleteWithoutOkAsync<
    AgentPool,
    {
      ...BaseParameters<AgentPool>;

      @doc("ignore-pod-disruption-budget=true to delete those pods on a node without considering Pod Disruption Budget")
      @query("ignore-pod-disruption-budget")
      `ignore-pod-disruption-budget`?: boolean;
    }
  >;

  @doc("Gets a list of agent pools in the specified managed cluster.")
  list is ArmResourceListByParent<AgentPool>;

  @doc("Aborts the currently running operation on the agent pool. The Agent Pool will be moved to a Canceling state and eventually to a Canceled state when cancellation finishes. If the operation completes before cancellation can take place, an error is returned.")
  abortLatestOperation is ArmResourceActionNoResponseContentAsync<
    AgentPool,
    void
  >;

  @doc("Upgrading the node image version of an agent pool applies the newest OS and runtime updates to the nodes. AKS provides one new image per week with the latest updates. For more details on node image versions, see: https://docs.microsoft.com/azure/aks/node-image-upgrade")
  upgradeNodeImageVersion is ArmResourceActionAsync<AgentPool, void, void>;
}
