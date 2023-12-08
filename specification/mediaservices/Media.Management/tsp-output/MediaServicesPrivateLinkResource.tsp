import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MediaServicesAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Media;
@doc("A private link resource")
@parentResource(MediaServicesAccount)
model MediaServicesPrivateLinkResource
  is ProxyResource<PrivateLinkResourceProperties> {
  @path
  @key("name")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface MediaServicesPrivateLinkResources {
  @doc("Get details of a group ID.")
  get is ArmResourceRead<MediaServicesPrivateLinkResource>;
  @doc("List supported group IDs.")
  list is ArmResourceListByParent<MediaServicesPrivateLinkResource>;
}
