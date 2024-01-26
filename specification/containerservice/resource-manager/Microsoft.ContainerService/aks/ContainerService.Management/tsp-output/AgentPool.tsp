import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;
/**
 * Agent Pool.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ManagedCluster)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  ManagedClusterAgentPoolProfileProperties
)
model AgentPool extends ProxyResourceBase {
  /**
   * The name of the agent pool.
   */
  @maxLength(12)
  @minLength(1)
  @pattern("^[a-z][a-z0-9]{0,11}$")
  @path
  @key("agentPoolName")
  @segment("agentPools")
  @visibility("read")
  name: string;

  /**
   * Properties of an agent pool.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ManagedClusterAgentPoolProfileProperties;
}

@armResourceOperations
interface AgentPools {
  /**
   * Gets the specified managed cluster agent pool.
   */
  get is ArmResourceRead<AgentPool>;

  /**
   * Creates or updates an agent pool in the specified managed cluster.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AgentPool>;

  /**
   * Deletes an agent pool in the specified managed cluster.
   */
  delete is ArmResourceDeleteWithoutOkAsync<AgentPool>;

  /**
   * Gets a list of agent pools in the specified managed cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AgentPools_List")
  list is ArmResourceListByParent<AgentPool>;

  /**
   * Aborts the currently running operation on the agent pool. The Agent Pool will be moved to a Canceling state and eventually to a Canceled state when cancellation finishes. If the operation completes before cancellation can take place, a 409 error code is returned.
   */
  abortLatestOperation is ArmResourceActionNoResponseContentAsync<
    AgentPool,
    void,
    BaseParameters<AgentPool>,
    ArmLroLocationHeader
  >;

  /**
   * Upgrading the node image version of an agent pool applies the newest OS and runtime updates to the nodes. AKS provides one new image per week with the latest updates. For more details on node image versions, see: https://docs.microsoft.com/azure/aks/node-image-upgrade
   */
  upgradeNodeImageVersion is ArmResourceActionAsync<
    AgentPool,
    void,
    void,
    BaseParameters<AgentPool>,
    ArmLroLocationHeader
  >;
}

@@projectedName(AgentPools.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(AgentPools.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(AgentPools.createOrUpdate::parameters.resource,
  "The agent pool to create or update."
);
