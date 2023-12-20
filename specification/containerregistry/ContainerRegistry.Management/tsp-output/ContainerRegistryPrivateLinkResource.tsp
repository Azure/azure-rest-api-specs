import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerRegistry.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ContainerRegistry;
@doc("A resource that supports private link capabilities.")
@parentResource(ContainerRegistry)
model ContainerRegistryPrivateLinkResource
  is ProxyResource<PrivateLinkResourceProperties> {
  @doc("The name of the private link resource.")
  @path
  @key("groupName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface ContainerRegistryPrivateLinkResources {
  @doc("Gets a private link resource by a specified group name for a container registry.")
  getPrivateLinkResource is ArmResourceRead<ContainerRegistryPrivateLinkResource>;
  @doc("Lists the private link resources for a container registry.")
  listPrivateLinkResources is ArmResourceListByParent<ContainerRegistryPrivateLinkResource>;
}
