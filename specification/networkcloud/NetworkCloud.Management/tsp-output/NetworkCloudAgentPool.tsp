import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkCloudKubernetesCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetworkCloud;
@doc("AgentPool represents the agent pool of Kubernetes cluster.")
@parentResource(NetworkCloudKubernetesCluster)
model NetworkCloudAgentPool is TrackedResource<AgentPoolProperties> {
  @doc("The name of the Kubernetes cluster agent pool.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("agentPoolName")
  @segment("agentPools")
  name: string;

  @doc("The extended location of the cluster associated with the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface NetworkCloudAgentPools {
  @doc("Get properties of the provided Kubernetes cluster agent pool.")
  get is ArmResourceRead<NetworkCloudAgentPool>;
  @doc("Create a new Kubernetes cluster agent pool or update the properties of the existing one.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NetworkCloudAgentPool>;
  @doc("Patch the properties of the provided Kubernetes cluster agent pool, or update the tags associated with the Kubernetes cluster agent pool. Properties and tag updates can be done independently.")
  update is ArmResourcePatchAsync<NetworkCloudAgentPool, AgentPoolProperties>;
  @doc("Delete the provided Kubernetes cluster agent pool.")
  delete is ArmResourceDeleteAsync<NetworkCloudAgentPool>;
  @doc("Get a list of agent pools for the provided Kubernetes cluster.")
  listByKubernetesCluster is ArmResourceListByParent<NetworkCloudAgentPool>;
}
