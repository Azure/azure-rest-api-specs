import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;
/**
 * The agentpool that has the ARM resource and properties.
 * The agentpool will have all information to create an agent pool.
 */
@parentResource(Registry)
model AgentPool is Azure.ResourceManager.TrackedResource<AgentPoolProperties> {
  ...ResourceNameParameter<
    Resource = AgentPool,
    KeyName = "agentPoolName",
    SegmentName = "agentPools",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AgentPool,
    PatchModel = AgentPoolUpdateParameters,
    Response = AgentPool | ArmResourceCreatedResponse<
      AgentPool,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = AgentPool> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Deletes a specified agent pool resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<AgentPool>;

  /**
   * Lists all the agent pools for a specified container registry.
   */
  @list
  list is ArmResourceListByParent<
    AgentPool,
    Response = ArmResponse<AgentPoolListResult>
  >;

  /**
   * Gets the count of queued runs for a given agent pool.
   */
  @action("listQueueStatus")
  getQueueStatus is ArmResourceActionSync<
    AgentPool,
    void,
    ArmResponse<AgentPoolQueueStatus>
  >;
}

@@maxLength(AgentPool.name, 20);
@@minLength(AgentPool.name, 3);
@@doc(AgentPool.name, "The name of the agent pool.");
@@doc(AgentPool.properties, "The properties associated with the agent pool");
@@doc(AgentPools.create::parameters.resource,
  "The parameters of an agent pool that needs to scheduled."
);
@@doc(AgentPools.update::parameters.properties,
  "The parameters for updating an agent pool."
);
