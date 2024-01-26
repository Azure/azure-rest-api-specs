import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.KubernetesRuntime;

@doc("A BgpPeer resource")
model BgpPeer is ExtensionResource<BgpPeerProperties> {
  @doc("The name of the BgpPeer")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("bgpPeerName")
  @segment("bgpPeers")
  @path
  name: string;
}

@doc("Details of the BgpPeer.")
model BgpPeerProperties {
  @doc("My ASN")
  myAsn: int32;

  @doc("Peer ASN")
  peerAsn: int32;

  @doc("Peer Address")
  peerAddress: string;

  @visibility("read")
  @doc("Resource provision state")
  provisioningState?: ProvisioningState;
}

@armResourceOperations(BgpPeer)
interface BgpPeers {
  get is ArmResourceRead<BgpPeer>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BgpPeer>;
  delete is ArmResourceDeleteWithoutOkAsync<BgpPeer>;
  listByParent is ArmResourceListByParent<BgpPeer>;
}
