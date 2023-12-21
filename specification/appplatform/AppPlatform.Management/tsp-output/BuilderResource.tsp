import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./BuildService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("KPack Builder resource")
@parentResource(BuildService)
model BuilderResource is ProxyResource<BuilderProperties> {
  @doc("The name of the builder resource.")
  @path
  @key("builderName")
  @segment("builders")
  name: string;
}

@armResourceOperations
interface BuildServiceBuilder {
  @doc("Get a KPack builder.")
  get is ArmResourceRead<BuilderResource>;
  @doc("Create or update a KPack builder.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BuilderResource>;
  @doc("Delete a KPack builder.")
  delete is ArmResourceDeleteAsync<BuilderResource>;
  @doc("List KPack builders result.")
  list is ArmResourceListByParent<BuilderResource>;
  @doc("List deployments that are using the builder.")
  listDeployments is ArmResourceActionSync<
    BuilderResource,
    void,
    DeploymentList
  >;
}
