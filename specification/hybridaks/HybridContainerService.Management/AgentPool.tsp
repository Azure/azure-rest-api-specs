import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProvisionedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridContainerService;
/**
 * The agentPool resource definition
 */
@parentResource(ProvisionedCluster)
model AgentPool is ProxyResource<AgentPoolProperties> {
  /**
   * Parameter for the name of the agent pool in the provisioned cluster.
   */
  @maxLength(12)
  @minLength(3)
  @pattern("^[a-z][a-z0-9]{2,11}$")
  @path
  @key("agentPoolName")
  @segment("agentPools")
  @visibility(Lifecycle.Read)
  name: string;

  /**
   * Extended location pointing to the underlying infrastructure
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Well-known envelope property"
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface AgentPools {
  /**
   * Gets the specified agent pool in the provisioned cluster
   */
  get is ArmResourceRead<
    AgentPool,
    BaseParameters = ConnectedClusterResourceUriParameters
  >;

  /**
   * Creates or updates the agent pool in the provisioned cluster
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AgentPool,
    BaseParameters = ConnectedClusterResourceUriParameters
  >;

  /**
   * Deletes the specified agent pool in the provisioned cluster
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    AgentPool,
    BaseParameters = ConnectedClusterResourceUriParameters
  >;

  /**
   * Gets the list of agent pools in the specified provisioned cluster
   */
  listByProvisionedCluster is ArmResourceListByParent<
    AgentPool,
    BaseParameters = ConnectedClusterResourceUriParameters
  >;
}

@@doc(AgentPools.createOrUpdate::parameters.resource,
  "Agent Pool resource definition"
);
