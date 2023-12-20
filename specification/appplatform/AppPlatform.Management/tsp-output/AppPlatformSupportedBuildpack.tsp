import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppPlatformBuildService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("Supported buildpack resource payload")
@parentResource(AppPlatformBuildService)
model AppPlatformSupportedBuildpack
  is ProxyResource<SupportedBuildpackResourceProperties> {
  @doc("The name of the buildpack resource.")
  @path
  @key("buildpackName")
  @segment("supportedBuildpacks")
  name: string;
}

@armResourceOperations
interface AppPlatformSupportedBuildpacks {
  @doc("Get the supported buildpack resource.")
  getSupportedBuildpack is ArmResourceRead<AppPlatformSupportedBuildpack>;
  @doc("Get all supported buildpacks.")
  listSupportedBuildpacks is ArmResourceListByParent<AppPlatformSupportedBuildpack>;
}
