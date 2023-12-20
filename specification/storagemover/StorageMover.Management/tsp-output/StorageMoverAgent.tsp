import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./StorageMover.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.StorageMover;
@doc("The Agent resource.")
@parentResource(StorageMover)
model StorageMoverAgent is ProxyResource<AgentProperties> {
  @doc("The name of the Agent resource.")
  @path
  @key("agentName")
  @segment("agents")
  name: string;
}

@armResourceOperations
interface StorageMoverAgents {
  @doc("Gets an Agent resource.")
  get is ArmResourceRead<StorageMoverAgent>;
  @doc("Creates or updates an Agent resource, which references a hybrid compute machine that can run jobs.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<StorageMoverAgent>;
  @doc("Creates or updates an Agent resource.")
  update is ArmResourcePatchSync<StorageMoverAgent, AgentProperties>;
  @doc("Deletes an Agent resource.")
  delete is ArmResourceDeleteAsync<StorageMoverAgent>;
  @doc("Lists all Agents in a Storage Mover.")
  list is ArmResourceListByParent<StorageMoverAgent>;
}
