import "./common.tsp";

using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.ManagedNetworkFabric;

@doc("Extensible aggregate BGP state.")
@added(Versions.v2026_07_15_preview)
union BgpSessionState {
  string,

  @doc("BGP session is pending establishment.")
  Pending: "Pending",

  @doc("BGP session is established.")
  Established: "Established",

  @doc("BGP session is down.")
  Down: "Down",
}

@doc("Extensible lifecycle of the one service-endpoint attachment.")
@added(Versions.v2026_07_15_preview)
union AttachmentState {
  string,

  @doc("No consumer is attached.")
  Unattached: "Unattached",

  @doc("An attachment has been prepared.")
  Prepared: "Prepared",

  @doc("A consumer is attached.")
  Attached: "Attached",

  @doc("The attachment is being detached.")
  Detaching: "Detaching",
}

@doc("Properties of a ServicePeer - a whole-Vrf InternetDefault service edge with fail-closed attachment lifecycle.")
@added(Versions.v2026_07_15_preview)
model ServicePeerProperties {
  @doc("Remote ASN used by the service endpoint. Required and immutable after creation.")
  @minValue(1)
  @maxValue(4294967295)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  peerAsn: int64;

  @doc("Whether BFD is required on the service adjacency. Required and immutable after creation.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  bfdEnabled: BooleanEnumProperty;

  @doc("Fabric-allocated IPv4 address configured on the service endpoint.")
  @visibility(Lifecycle.Read)
  peerIpv4Address?: Azure.Core.ipV4Address;

  @doc("Fabric-side IPv4 address of the service adjacency.")
  @visibility(Lifecycle.Read)
  localIpv4Address?: Azure.Core.ipV4Address;

  @doc("Prefix length shared by peerIpv4Address and localIpv4Address.")
  @visibility(Lifecycle.Read)
  prefixLength?: int32;

  @doc("Fabric-side BGP ASN from the parent Fabric.fabricASN.")
  @visibility(Lifecycle.Read)
  localAsn?: int64;

  @doc("True when Fabric created the resource for a downstream service claim.")
  @visibility(Lifecycle.Read)
  systemManaged?: BooleanEnumProperty;

  @doc("ARM IDs of active or cleanup-pending consumers holding this peer against deletion.")
  @visibility(Lifecycle.Read)
  consumerResourceIds?: armResourceIdentifier[];

  @doc("Service-populated ARM provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Provider-neutral BGP session summary.")
  @visibility(Lifecycle.Read)
  bgpSessionState?: BgpSessionState;

  @doc("Provider-neutral service-endpoint attachment readiness.")
  @visibility(Lifecycle.Read)
  attachmentState?: AttachmentState;

  @doc("Number of workload prefixes currently exported through this service adjacency.")
  @visibility(Lifecycle.Read)
  exportedPrefixCount?: int32;
}

@doc("The ServicePeer patch resource definition.")
@added(Versions.v2026_07_15_preview)
model ServicePeerPatch {
  ...TagsUpdate;
}

@doc("Acknowledgement of an accepted operation.")
@added(Versions.v2026_07_15_preview)
model OperationAcknowledged {
  @doc("Request ID for correlating with operational logs.")
  requestId: string;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Request to prepare a single-consumer service endpoint attachment.")
@added(Versions.v2026_07_15_preview)
model PrepareServicePeerAttachmentRequest {
  @doc("ARM ID of the VM, physical device, or service resource that will own the attachment.")
  consumerResourceId: armResourceIdentifier;

  @doc("Monotonically increasing idempotency generation chosen by the consumer.")
  @minValue(1)
  requestGeneration: int64;
}

@doc("Result of preparing a service endpoint attachment.")
@added(Versions.v2026_07_15_preview)
model ServicePeerAttachment {
  @doc("Single-consumer, non-transferable token resolving to the provider transit attachment.")
  @secret
  servicePeerAttachmentToken: string;

  @doc("IPv4 address configured on the attached service endpoint.")
  peerIpv4Address: Azure.Core.ipV4Address;

  @doc("Fabric-side IPv4 address of the service adjacency.")
  localIpv4Address: Azure.Core.ipV4Address;

  @doc("Prefix length shared by peerIpv4Address and localIpv4Address.")
  prefixLength: int32;

  @doc("Fabric-side BGP ASN that the service endpoint peers with.")
  localAsn: int64;

  @doc("Opaque secret-broker handle when generated BGP password authentication is enabled.")
  @secret
  bgpAuthenticationSecretHandle?: string;

  @doc("Expiry of the unconfirmed lease and token.")
  expiresAt: utcDateTime;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Request to confirm a previously prepared service endpoint attachment.")
@added(Versions.v2026_07_15_preview)
model ConfirmServicePeerAttachmentRequest {
  @doc("Must match the consumer that prepared the attachment.")
  consumerResourceId: armResourceIdentifier;

  @doc("Must match the live prepared generation.")
  @minValue(1)
  requestGeneration: int64;

  @doc("Exact unexpired token returned by prepareAttachment.")
  @secret
  servicePeerAttachmentToken: string;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Request to revoke an attachment and withdraw service exposure before cleanup.")
@added(Versions.v2026_07_15_preview)
model RevokeServicePeerAttachmentRequest {
  @doc("Consumer whose attachment is being revoked.")
  consumerResourceId: armResourceIdentifier;

  @doc("Monotonic fence; later prepare or confirm calls must use a higher generation.")
  @minValue(1)
  requestGeneration: int64;

  @doc("Break-glass revocation without successful consumer coordination. Default value is False.")
  force?: BooleanEnumProperty;

  @doc("Audit reason for the revocation. The service rejects the request when force is True and this value is not supplied.")
  reason?: string;
}
