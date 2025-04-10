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
 * Supported buildpack resource payload
 */
@parentResource(BuildService)
model SupportedBuildpackResource
  is Azure.ResourceManager.ProxyResource<SupportedBuildpackResourceProperties> {
  ...ResourceNameParameter<
    Resource = SupportedBuildpackResource,
    KeyName = "buildpackName",
    SegmentName = "supportedBuildpacks",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SupportedBuildpackResources {
  /**
   * Get the supported buildpack resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildService_GetSupportedBuildpack")
  getSupportedBuildpack is ArmResourceRead<SupportedBuildpackResource>;

  /**
   * Get all supported buildpacks.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BuildService_ListSupportedBuildpacks")
  listSupportedBuildpacks is ArmResourceListByParent<
    SupportedBuildpackResource,
    Response = ArmResponse<SupportedBuildpacksCollection>
  >;
}

@@doc(SupportedBuildpackResource.name, "The name of the buildpack resource.");
@@doc(SupportedBuildpackResource.properties,
  "Supported buildpack resource properties"
);
