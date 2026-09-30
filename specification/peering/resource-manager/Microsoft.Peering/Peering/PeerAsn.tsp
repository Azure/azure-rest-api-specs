import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Peering;
/**
 * The essential information related to the peer's ASN.
 */
@subscriptionResource
model PeerAsn is Azure.ResourceManager.ProxyResource<PeerAsnProperties> {
  ...ResourceNameParameter<
    Resource = PeerAsn,
    KeyName = "peerAsnName",
    SegmentName = "peerAsns",
    NamePattern = "[A-Za-z0-9_.-]{1,63}"
  >;
}

@armResourceOperations
interface PeerAsns {
  /**
   * Gets the peer ASN with the specified name under the given subscription.
   */
  get is ArmResourceRead<
    PeerAsn,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Creates a new peer ASN or updates an existing peer ASN with the specified name under the given subscription.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    PeerAsn,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Deletes an existing peer ASN with the specified name under the given subscription.
   */
  delete is ArmResourceDeleteSync<
    PeerAsn,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Lists all of the peer ASNs under the given subscription.
   */
  listBySubscription is ArmResourceListByParent<
    PeerAsn,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(PeerAsn.name, "The peer ASN name.");
@@doc(PeerAsn.properties, "The properties that define a peer's ASN.");
@@doc(PeerAsns.createOrUpdate::parameters.resource, "The peer ASN.");
