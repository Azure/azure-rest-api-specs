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
#suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
#suppress "@azure-tools/typespec-azure-resource-manager/resource-name" "Initial suppression to prevent breaking change"
@parentResource(provisionedCluster)
model agentPool is Azure.ResourceManager.ProxyResource<AgentPoolProperties> {
  ...ResourceNameParameter<
    Resource = agentPool,
    KeyName = "agentPoolName",
    SegmentName = "agentPools",
    NamePattern = "^[a-z][a-z0-9]{2,11}$"
  >;

  /**
   * Extended location pointing to the underlying infrastructure
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation?: ExtendedLocation;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @doc("The tags for this resource.")
  tags?: Record<string>;
}

@armResourceOperations
interface AgentPools {
  /**
   * Gets the specified agent pool in the provisioned cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("agentPool_Get")
  get is ArmResourceRead<
    agentPool,
    BaseParameters = ConnectedClusterResourceUriParameters
  >;
  /**
   * Creates or updates the agent pool in the provisioned cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("agentPool_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    agentPool,
    BaseParameters = ConnectedClusterResourceUriParameters
  >;

  /**
   * Deletes the specified agent pool in the provisioned cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @operationId("agentPool_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    agentPool,
    BaseParameters = ConnectedClusterResourceUriParameters,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets the list of agent pools in the specified provisioned cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("agentPool_ListByProvisionedCluster")
  listByProvisionedCluster is ArmResourceListByParent<
    agentPool,
    BaseParameters = ConnectedClusterResourceUriParameters,
    Response = ArmResponse<agentPoolListResult>
  >;
}

@@maxLength(agentPool.name, 12);
@@minLength(agentPool.name, 3);
@@doc(agentPool.name,
  "Parameter for the name of the agent pool in the provisioned cluster."
);
@@doc(agentPool.properties, "Properties of the agent pool resource");
@@doc(AgentPools.createOrUpdate::parameters.resource,
  "Agent Pool resource definition"
);
