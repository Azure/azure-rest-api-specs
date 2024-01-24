import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProvisionedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridContainerService;
/**
 * The agentPool resource definition
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ProvisionedCluster)
@Azure.ResourceManager.Private.armResourceInternal(AgentPoolProperties)
@includeInapplicableMetadataInPayload(false)
model AgentPool extends ProxyResourceBase {
  /**
   * Parameter for the name of the agent pool in the provisioned cluster.
   */
  @maxLength(12)
  @minLength(3)
  @pattern("^[a-z][a-z0-9]{2,11}$")
  @path
  @key("agentPoolName")
  @segment("agentPools")
  name: string;

  /**
   * Extended location pointing to the underlying infrastructure
   */
  extendedLocation?: ExtendedLocation;

  /**
   * Properties of the agent pool resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: AgentPoolProperties;
}

@armResourceOperations
interface AgentPools {
  /**
   * Gets the specified agent pool in the provisioned cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("agentPool_Get")
  get is ArmResourceRead<AgentPool>;

  /**
   * Creates or updates the agent pool in the provisioned cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("agentPool_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AgentPool,
    BaseParameters<AgentPool>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes the specified agent pool in the provisioned cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("agentPool_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    AgentPool,
    BaseParameters<AgentPool>,
    ArmAsyncOperationHeader
  >;

  /**
   * Gets the list of agent pools in the specified provisioned cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("agentPool_ListByProvisionedCluster")
  listByProvisionedCluster is ArmResourceListByParent<AgentPool>;
}

@@projectedName(AgentPools.createOrUpdate::parameters.resource,
  "json",
  "agentPool"
);
@@extension(AgentPools.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "agentPool"
);
@@doc(AgentPools.createOrUpdate::parameters.resource,
  "Agent Pool resource definition"
);
