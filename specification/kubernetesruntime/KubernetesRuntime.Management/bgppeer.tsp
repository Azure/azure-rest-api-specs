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

@doc("State for BGP Multi Hop")
@added(Versions.v2024_08_01)
union BgpMultiHopState {
  string,

  @doc("BGP multi hop is enabled")
  Enabled: "Enabled",

  @doc("BGP multi hop is disabled")
  Disabled: "Disabled",
}

@doc("Kubernetes Label Definition")
@added(Versions.v2024_08_01)
model Label {
  @doc("Label name")
  name: string;

  @doc("Label value")
  value: string;
}

@doc("Details of the BgpPeer.")
model BgpPeerProperties {
  @doc("My ASN")
  myAsn: int32;

  @doc("Peer ASN")
  peerAsn: int32;

  @doc("Peer Address")
  peerAddress: string;

  @doc("BFD Profile")
  @added(Versions.v2024_08_01)
  bfdProfile?: string;

  @doc("Peer BGP port")
  @added(Versions.v2024_08_01)
  peerPort?: int32;

  @doc("eBGP multiple hop")
  @added(Versions.v2024_08_01)
  bgpMultiHop?: BgpMultiHopState;

  @doc("Hold time, per RFC4271")
  @added(Versions.v2024_08_01)
  holdTime?: string;

  @doc("Keepalive time, per RFC4271")
  @added(Versions.v2024_08_01)
  keepAliveTime?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "The type of the field is a record because it is a mapping of labels in the customer cluster"
  @doc("A dynamic label mapping to select related nodes to peer with. For instance, if you want to create a BGP peer only for nodes with label \"a=b\", then please specify {\"a\": \"b\"} in the field.")
  @added(Versions.v2024_08_01)
  @identifiers(#["name"])
  nodeSelector?: Label[];

  @visibility(Lifecycle.Read)
  @doc("Resource provision state")
  provisioningState?: ProvisioningState;
}

@armResourceOperations(BgpPeer)
interface BgpPeers {
  get is ArmResourceRead<BgpPeer>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BgpPeer>;
  @sharedRoute
  @added(Versions.v2024_03_01)
  delete is ArmResourceDeleteSync<BgpPeer>;
  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "The intended way to change the delete operation from async to sync. Ref: https://github.com/Azure/typespec-azure/issues/312"
  @sharedRoute
  @renamedFrom(Versions.v2024_03_01, "delete")
  @removed(Versions.v2024_03_01)
  oldDelete is ArmResourceDeleteWithoutOkAsync<BgpPeer>;
  listByParent is ArmResourceListByParent<BgpPeer>;
}
