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
@doc("KPack Builder resource")
@parentResource(AppPlatformBuildService)
model AppPlatformBuilder is ProxyResource<BuilderProperties> {
  @doc("The name of the builder resource.")
  @path
  @key("builderName")
  @segment("builders")
  name: string;
}

@armResourceOperations
interface AppPlatformBuilders {
  @doc("Get a KPack builder.")
  get is ArmResourceRead<AppPlatformBuilder>;
  @doc("Create or update a KPack builder.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AppPlatformBuilder>;
  @doc("Delete a KPack builder.")
  delete is ArmResourceDeleteAsync<AppPlatformBuilder>;
  @doc("List KPack builders result.")
  list is ArmResourceListByParent<AppPlatformBuilder>;
  @doc("List deployments that are using the builder.")
  listDeployments is ArmResourceActionSync<
    AppPlatformBuilder,
    void,
    DeploymentList
  >;
}
