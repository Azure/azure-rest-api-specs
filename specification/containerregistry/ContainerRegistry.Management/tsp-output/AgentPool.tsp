import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Registry.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;
@doc("""
The agentpool that has the ARM resource and properties. 
The agentpool will have all information to create an agent pool.
""")
@parentResource(Registry)
model AgentPool is TrackedResource<AgentPoolProperties> {
  @doc("The name of the agent pool.")
  @maxLength(20)
  @minLength(3)
  @pattern("^[a-zA-Z0-9-]*$")
  @path
  @key("agentPoolName")
  @segment("agentPools")
  name: string;
}

@armResourceOperations
interface AgentPools {
  @doc("Gets the detailed information for a given agent pool.")
  get is ArmResourceRead<AgentPool>;

  @doc("Creates an agent pool for a container registry with the specified parameters.")
  create is ArmResourceCreateOrUpdateAsync<AgentPool>;

  @doc("Updates an agent pool with the specified parameters.")
  update is ArmCustomPatchAsync<AgentPool, AgentPoolUpdateParameters>;

  @doc("Deletes a specified agent pool resource.")
  delete is ArmResourceDeleteAsync<AgentPool>;

  @doc("Lists all the agent pools for a specified container registry.")
  list is ArmResourceListByParent<AgentPool>;

  @doc("Gets the count of queued runs for a given agent pool.")
  getQueueStatus is ArmResourceActionSync<
    AgentPool,
    void,
    AgentPoolQueueStatus
  >;
}

@@projectedName(AgentPools.create::parameters.resource, "json", "agentPool");
@@extension(AgentPools.create::parameters.resource,
  "x-ms-client-name",
  "agentPool"
);
@@doc(AgentPools.create::parameters.resource,
  "The parameters of an agent pool that needs to scheduled."
);
@@projectedName(AgentPools.update::parameters.properties,
  "json",
  "updateParameters"
);
@@extension(AgentPools.update::parameters.properties,
  "x-ms-client-name",
  "updateParameters"
);
@@doc(AgentPools.update::parameters.properties,
  "The parameters for updating an agent pool."
);
