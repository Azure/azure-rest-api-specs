import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Registry.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;
@doc("A resource that supports private link capabilities.")
@parentResource(Registry)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  @doc("The name of the private link resource.")
  @path
  @key("groupName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface PrivateLinkResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a private link resource by a specified group name for a container registry.")
  @operationId("Registries_GetPrivateLinkResource")
  getPrivateLinkResource is ArmResourceRead<PrivateLinkResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the private link resources for a container registry.")
  @operationId("Registries_ListPrivateLinkResources")
  listPrivateLinkResources is ArmResourceListByParent<PrivateLinkResource>;
}
