import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AppPlatform;
@doc("Binding resource payload")
@parentResource(AppResource)
model BindingResource is ProxyResource<BindingResourceProperties> {
  @doc("The name of the Binding resource.")
  @key("bindingName")
  @segment("bindings")
  name: string;
}

@armResourceOperations
@projectedName("client", "Bindings")
interface BindingResources_Bindings {
  @doc("Get a Binding and its properties.")
  get is ArmResourceRead<BindingResource>;

  @doc("Create a new Binding or update an exiting Binding.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BindingResource>;

  @doc("Operation to update an exiting Binding.")
  update is ArmCustomPatchAsync<BindingResource, BindingResource>;

  @doc("Operation to delete a Binding.")
  delete is ArmResourceDeleteAsync<BindingResource>;

  @doc("Handles requests to list all resources in an App.")
  list is ArmResourceListByParent<BindingResource>;
}
