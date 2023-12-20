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
@doc("A hub setting")
@parentResource(WebPubSub)
model WebPubSubHub is ProxyResource<WebPubSubHubProperties> {
  @doc("The hub name.")
  @path
  @key("hubName")
  @segment("hubs")
  name: string;
}

@armResourceOperations
interface WebPubSubHubs {
  @doc("Get a hub setting.")
  get is ArmResourceRead<WebPubSubHub>;
  @doc("Create or update a hub setting.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<WebPubSubHub>;
  @doc("Delete a hub setting.")
  delete is ArmResourceDeleteAsync<WebPubSubHub>;
  @doc("List hub settings.")
  list is ArmResourceListByParent<WebPubSubHub>;
}
