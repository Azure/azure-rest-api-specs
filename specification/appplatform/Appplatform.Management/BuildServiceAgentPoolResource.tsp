import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BuildService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * The build service agent pool resource
 */
@parentResource(BuildService)
model BuildServiceAgentPoolResource
  is Azure.ResourceManager.ProxyResource<BuildServiceAgentPoolProperties> {
  ...ResourceNameParameter<
    Resource = BuildServiceAgentPoolResource,
    KeyName = "agentPoolName",
    SegmentName = "agentPools",
    NamePattern = ""
  >;
}

@armResourceOperations
interface BuildServiceAgentPoolResources {
  /**
   * Get build service agent pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildServiceAgentPool_Get")
  get is ArmResourceRead<BuildServiceAgentPoolResource>;

  /**
   * Create or update build service agent pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildServiceAgentPool_UpdatePut")
  updatePut is ArmResourceCreateOrReplaceAsync<
    BuildServiceAgentPoolResource,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * List build service agent pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildServiceAgentPool_List")
  list is ArmResourceListByParent<
    BuildServiceAgentPoolResource,
    Response = ArmResponse<BuildServiceAgentPoolResourceCollection>
  >;
}

@@doc(BuildServiceAgentPoolResource.name,
  "The name of the build service agent pool resource."
);
@@doc(BuildServiceAgentPoolResource.properties,
  "build service agent pool properties"
);
@@doc(BuildServiceAgentPoolResources.updatePut::parameters.resource,
  "Parameters for the update operation"
);
