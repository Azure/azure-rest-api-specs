import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./WebPubSub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.WebPubSub;
@doc("Describes a Shared Private Link Resource")
@parentResource(WebPubSub)
model WebPubSubSharedPrivateLink
  is ProxyResource<SharedPrivateLinkResourceProperties> {
  @doc("The name of the shared private link resource")
  @path
  @key("sharedPrivateLinkResourceName")
  @segment("sharedPrivateLinkResources")
  name: string;
}

@armResourceOperations
interface WebPubSubSharedPrivateLinkResources {
  @doc("Get the specified shared private link resource")
  get is ArmResourceRead<WebPubSubSharedPrivateLink>;
  @doc("Create or update a shared private link resource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<WebPubSubSharedPrivateLink>;
  @doc("Delete the specified shared private link resource")
  delete is ArmResourceDeleteAsync<WebPubSubSharedPrivateLink>;
  @doc("List shared private link resources")
  list is ArmResourceListByParent<WebPubSubSharedPrivateLink>;
}
