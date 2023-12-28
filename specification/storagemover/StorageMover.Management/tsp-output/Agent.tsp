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
model Agent is ProxyResource<AgentProperties> {
  @doc("The name of the Agent resource.")
  @key("agentName")
  @segment("agents")
  name: string;
}

@armResourceOperations
interface Agents {
  @doc("Gets an Agent resource.")
  get is ArmResourceRead<Agent>;
  @doc("Creates or updates an Agent resource, which references a hybrid compute machine that can run jobs.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Agent>;
  @doc("Creates or updates an Agent resource.")
  update is ArmCustomPatchSync<Agent, AgentUpdateParameters>;
  @doc("Deletes an Agent resource.")
  delete is ArmResourceDeleteAsync<Agent>;
  @doc("Lists all Agents in a Storage Mover.")
  list is ArmResourceListByParent<Agent>;
}
