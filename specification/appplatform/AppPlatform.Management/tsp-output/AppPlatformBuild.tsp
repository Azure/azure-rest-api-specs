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
@doc("Build resource payload")
@parentResource(AppPlatformBuildService)
model AppPlatformBuild is ProxyResource<BuildProperties> {
  @doc("The name of the build resource.")
  @path
  @key("buildName")
  @segment("builds")
  name: string;
}

@armResourceOperations
interface AppPlatformBuilds {
  @doc("Get a KPack build.")
  getBuild is ArmResourceRead<AppPlatformBuild>;
  @doc("Create or update a KPack build.")
  createOrUpdateBuild is ArmResourceCreateOrReplaceSync<AppPlatformBuild>;
  @doc("List KPack builds.")
  listBuilds is ArmResourceListByParent<AppPlatformBuild>;
}
