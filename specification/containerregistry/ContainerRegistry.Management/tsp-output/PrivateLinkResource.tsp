import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Registry.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ContainerRegistry;
@doc("A resource that supports private link capabilities.")
@parentResource(Registry)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  @doc("The name of the private link resource.")
  @key("groupName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
@projectedName("client", "Registries")
interface PrivateLinkResources_Registries {
  @doc("Gets a private link resource by a specified group name for a container registry.")
  getPrivateLinkResource is ArmResourceRead<PrivateLinkResource>;

  @doc("Lists the private link resources for a container registry.")
  listPrivateLinkResources is ArmResourceListByParent<PrivateLinkResource>;
}
