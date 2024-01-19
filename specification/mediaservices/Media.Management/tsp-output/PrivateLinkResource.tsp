import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MediaService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
@doc("A private link resource")
@parentResource(MediaService)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  @path
  @key("name")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface PrivateLinkResources {
  @doc("Get details of a group ID.")
  get is ArmResourceRead<PrivateLinkResource>;

  @doc("List supported group IDs.")
  list is ArmResourceListByParent<PrivateLinkResource>;
}
