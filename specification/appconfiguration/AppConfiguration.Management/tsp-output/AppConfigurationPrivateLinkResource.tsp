import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppConfigurationStore.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppConfiguration;
@doc("A resource that supports private link capabilities.")
@parentResource(AppConfigurationStore)
model AppConfigurationPrivateLinkResource
  is ProxyResource<PrivateLinkResourceProperties> {
  @doc("The name of the private link resource group.")
  @path
  @key("groupName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface AppConfigurationPrivateLinkResources {
  @doc("Gets a private link resource that need to be created for a configuration store.")
  get is ArmResourceRead<AppConfigurationPrivateLinkResource>;
  @doc("Gets the private link resources that need to be created for a configuration store.")
  listByConfigurationStore is ArmResourceListByParent<AppConfigurationPrivateLinkResource>;
}
