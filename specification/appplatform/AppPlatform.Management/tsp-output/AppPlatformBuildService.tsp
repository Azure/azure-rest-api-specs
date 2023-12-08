import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppPlatformService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("Build service resource payload")
@parentResource(AppPlatformService)
model AppPlatformBuildService is ProxyResource<BuildServiceProperties> {
  @doc("The name of the build service resource.")
  @path
  @key("buildServiceName")
  @segment("buildServices")
  name: string;
}

@armResourceOperations
interface AppPlatformBuildServices {
  @doc("Get a build service resource.")
  getBuildService is ArmResourceRead<AppPlatformBuildService>;
  @doc("List build services resource.")
  listBuildServices is ArmResourceListByParent<AppPlatformBuildService>;
  @doc("Get an resource upload URL for build service, which may be artifacts or source archive.")
  getResourceUploadUrl is ArmResourceActionSync<
    AppPlatformBuildService,
    {},
    ResourceUploadDefinition
  >;
}
