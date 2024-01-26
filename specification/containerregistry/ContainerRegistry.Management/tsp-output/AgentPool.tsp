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
/**
 * The agentpool that has the ARM resource and properties.
 * The agentpool will have all information to create an agent pool.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Registry)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(AgentPoolProperties)
model AgentPool extends TrackedResourceBase {
  /**
   * The name of the agent pool.
   */
  @maxLength(20)
  @minLength(3)
  @pattern("^[a-zA-Z0-9-]*$")
  @path
  @key("agentPoolName")
  @segment("agentPools")
  @visibility("read")
  name: string;

  /**
   * The properties associated with the agent pool
   */
  @extension("x-ms-client-flatten", true)
  properties?: AgentPoolProperties;
}

@armResourceOperations
interface AgentPools {
  /**
   * Gets the detailed information for a given agent pool.
   */
  get is ArmResourceRead<AgentPool>;

  /**
   * Creates an agent pool for a container registry with the specified parameters.
   */
  create is ArmResourceCreateOrReplaceAsync<AgentPool>;

  /**
   * Updates an agent pool with the specified parameters.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<AgentPool, AgentPoolUpdateParameters>;

  /**
   * Deletes a specified agent pool resource.
   */
  delete is ArmResourceDeleteAsync<AgentPool>;

  /**
   * Lists all the agent pools for a specified container registry.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AgentPools_List")
  list is ArmResourceListByParent<AgentPool>;

  /**
   * Gets the count of queued runs for a given agent pool.
   */
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
