import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageMover.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageMover;
@doc("The Agent resource.")
@parentResource(StorageMover)
model Agent is ProxyResource<AgentProperties> {
  @doc("The name of the Agent resource.")
  @path
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
  delete is ArmResourceDeleteAsync<
    Agent,
    BaseParameters<Agent>,
    ArmLroLocationHeader
  >;

  @doc("Lists all Agents in a Storage Mover.")
  list is ArmResourceListByParent<Agent>;
}

@@projectedName(Agents.createOrUpdate::parameters.resource, "json", "agent");
@@extension(Agents.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "agent"
);
@@doc(Agents.createOrUpdate::parameters.resource, "");
@@projectedName(Agents.update::parameters.properties, "json", "agent");
@@extension(Agents.update::parameters.properties, "x-ms-client-name", "agent");
@@doc(Agents.update::parameters.properties, "");
