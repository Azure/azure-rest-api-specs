import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Peering;
@doc("The essential information related to the peer's ASN.")
@subscriptionResource
model PeerAsn is ProxyResource<PeerAsnProperties> {
  @doc("The peer ASN name.")
  @path
  @key("peerAsnName")
  @segment("peerAsns")
  name: string;
}

@armResourceOperations
interface PeerAsns {
  @doc("Gets the peer ASN with the specified name under the given subscription.")
  get is ArmResourceRead<PeerAsn>;
  @doc("Creates a new peer ASN or updates an existing peer ASN with the specified name under the given subscription.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<PeerAsn>;
  @doc("Deletes an existing peer ASN with the specified name under the given subscription.")
  delete is ArmResourceDeleteSync<PeerAsn>;
  @doc("Lists all of the peer ASNs under the given subscription.")
  listBySubscription is ArmResourceListByParent<PeerAsn>;
}
