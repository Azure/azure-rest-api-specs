import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BuildService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * The build service agent pool resource
 */
@parentResource(BuildService)
model BuildServiceAgentPoolResource
  is ProxyResource<BuildServiceAgentPoolProperties> {
  /**
   * The name of the build service agent pool resource.
   */
  @path
  @key("agentPoolName")
  @segment("agentPools")
  name: string;
}

@armResourceOperations
interface BuildServiceAgentPoolResources {
  /**
   * Get build service agent pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildServiceAgentPool_Get")
  get is ArmResourceRead<BuildServiceAgentPoolResource>;

  /**
   * Create or update build service agent pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildServiceAgentPool_UpdatePut")
  updatePut is ArmResourceCreateOrReplaceAsync<BuildServiceAgentPoolResource>;

  /**
   * List build service agent pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildServiceAgentPool_List")
  list is ArmResourceListByParent<BuildServiceAgentPoolResource>;
}

@@projectedName(BuildServiceAgentPoolResources.updatePut::parameters.resource,
  "json",
  "agentPoolResource"
);
@@extension(BuildServiceAgentPoolResources.updatePut::parameters.resource,
  "x-ms-client-name",
  "agentPoolResource"
);
@@doc(BuildServiceAgentPoolResources.updatePut::parameters.resource,
  "Parameters for the update operation"
);
