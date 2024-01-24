import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Build service resource payload
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ServiceResource)
@Azure.ResourceManager.Private.armResourceInternal(BuildServiceProperties)
@includeInapplicableMetadataInPayload(false)
model BuildService extends ProxyResource {
  /**
   * The name of the build service resource.
   */
  @path
  @key("buildServiceName")
  @segment("buildServices")
  name: string;

  /**
   * Properties of the build resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: BuildServiceProperties;
}

@armResourceOperations
interface BuildServices {
  /**
   * Get a build service resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildService_GetBuildService")
  getBuildService is ArmResourceRead<BuildService>;

  /**
   * List build services resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildService_ListBuildServices")
  listBuildServices is ArmResourceListByParent<BuildService>;

  /**
   * Get an resource upload URL for build service, which may be artifacts or source archive.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildService_GetResourceUploadUrl")
  getResourceUploadUrl is ArmResourceActionSync<
    BuildService,
    void,
    ResourceUploadDefinition
  >;
}
