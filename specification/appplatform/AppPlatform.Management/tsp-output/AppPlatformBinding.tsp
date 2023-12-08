import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppPlatformApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("Binding resource payload")
@parentResource(AppPlatformApp)
model AppPlatformBinding is ProxyResource<BindingResourceProperties> {
  @doc("The name of the Binding resource.")
  @path
  @key("bindingName")
  @segment("bindings")
  name: string;
}

@armResourceOperations
interface AppPlatformBindings {
  @doc("Get a Binding and its properties.")
  get is ArmResourceRead<AppPlatformBinding>;
  @doc("Create a new Binding or update an exiting Binding.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AppPlatformBinding>;
  @doc("Operation to update an exiting Binding.")
  update is ArmResourcePatchAsync<
    AppPlatformBinding,
    BindingResourceProperties
  >;
  @doc("Operation to delete a Binding.")
  delete is ArmResourceDeleteAsync<AppPlatformBinding>;
  @doc("Handles requests to list all resources in an App.")
  list is ArmResourceListByParent<AppPlatformBinding>;
}
