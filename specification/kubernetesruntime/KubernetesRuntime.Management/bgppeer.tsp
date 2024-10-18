import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.KubernetesRuntime;

@doc("A BgpPeer resource for an Arc connected cluster (Microsoft.Kubernetes/connectedClusters)")
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
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    BgpPeer,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  @sharedRoute
  @added(Versions.v2024_03_01)
  delete is ArmResourceDeleteSync<BgpPeer>;
  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "The intended way to change the delete operation from async to sync. Ref: https://github.com/Azure/typespec-azure/issues/312"
  @sharedRoute
  @renamedFrom(Versions.v2024_03_01, "delete")
  @removed(Versions.v2024_03_01)
  oldDelete is ArmResourceDeleteWithoutOkAsync<BgpPeer>;
  list is ArmResourceListByParent<BgpPeer>;
}
