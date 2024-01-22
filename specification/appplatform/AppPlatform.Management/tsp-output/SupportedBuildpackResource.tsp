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
 * Supported buildpack resource payload
 */
@parentResource(BuildService)
model SupportedBuildpackResource
  is ProxyResource<SupportedBuildpackResourceProperties> {
  /**
   * The name of the buildpack resource.
   */
  @path
  @key("buildpackName")
  @segment("supportedBuildpacks")
  name: string;
}

@armResourceOperations
interface SupportedBuildpackResources {
  /**
   * Get the supported buildpack resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildService_GetSupportedBuildpack")
  getSupportedBuildpack is ArmResourceRead<SupportedBuildpackResource>;

  /**
   * Get all supported buildpacks.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildService_ListSupportedBuildpacks")
  listSupportedBuildpacks is ArmResourceListByParent<SupportedBuildpackResource>;
}
