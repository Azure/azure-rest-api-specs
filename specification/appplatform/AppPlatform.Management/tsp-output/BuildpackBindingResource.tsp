import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./BuilderResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AppPlatform;
@doc("Buildpack Binding Resource object")
@parentResource(BuilderResource)
model BuildpackBindingResource is ProxyResource<BuildpackBindingProperties> {
  @doc("The name of the Buildpack Binding Name")
  @key("buildpackBindingName")
  @segment("buildpackBindings")
  name: string;
}

@armResourceOperations
@projectedName("client", "BuildpackBinding")
interface BuildpackBindingResources_BuildpackBinding {
  @doc("Get a buildpack binding by name.")
  get is ArmResourceRead<BuildpackBindingResource>;

  @doc("Create or update a buildpack binding.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BuildpackBindingResource>;

  @doc("Operation to delete a Buildpack Binding")
  delete is ArmResourceDeleteAsync<BuildpackBindingResource>;

  @doc("Handles requests to list all buildpack bindings in a builder.")
  list is ArmResourceListByParent<BuildpackBindingResource>;
}
