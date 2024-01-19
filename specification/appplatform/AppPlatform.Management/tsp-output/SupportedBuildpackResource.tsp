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
@doc("Supported buildpack resource payload")
@parentResource(BuildService)
model SupportedBuildpackResource
  is ProxyResource<SupportedBuildpackResourceProperties> {
  @doc("The name of the buildpack resource.")
  @path
  @key("buildpackName")
  @segment("supportedBuildpacks")
  name: string;
}

@armResourceOperations
interface SupportedBuildpackResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the supported buildpack resource.")
  @operationId("BuildService_GetSupportedBuildpack")
  getSupportedBuildpack is ArmResourceRead<SupportedBuildpackResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get all supported buildpacks.")
  @operationId("BuildService_ListSupportedBuildpacks")
  listSupportedBuildpacks is ArmResourceListByParent<SupportedBuildpackResource>;
}
