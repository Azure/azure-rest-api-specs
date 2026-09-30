import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.ComputeLimit;

/**
 * A host subscription that a guest subscription trusts for sharing compute limits.
 * A guest subscription can trust multiple host subscriptions; establishing trust does
 * not by itself associate the guest with a host. Guest-to-host association happens at
 * check-in time, where a subscription can be a guest of at most one host per region.
 */
@parentResource(SubscriptionLocationResource)
@added(Versions.v2026_07_31)
model TrustedHostSubscription is ProxyResource<never> {
  ...ResourceNameParameter<
    Resource = TrustedHostSubscription,
    KeyName = "hostSubscriptionId",
    SegmentName = "trustedHostSubscriptions",
    NamePattern = "^[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}$"
  >;
}

/** Location-scoped operations for trusted host subscriptions. */
@armResourceOperations
@added(Versions.v2026_07_31)
interface TrustedHostSubscriptions {
  /**
   * Adds a host subscription to the guest subscription's list of trusted hosts. A guest
   * subscription can trust multiple host subscriptions; this only establishes trust and
   * does not check the guest in to the host. Guest-to-host association is determined at
   * check-in time, where a subscription can be a guest of at most one host per region.
   */
  create is ArmResourceCreateOrReplaceSync<TrustedHostSubscription>;

  /**
   * Gets a host subscription that the guest subscription trusts.
   */
  get is ArmResourceRead<TrustedHostSubscription>;

  /**
   * Removes a host subscription from the guest subscription's list of trusted hosts.
   */
  delete is ArmResourceDeleteSync<TrustedHostSubscription>;

  /**
   * Lists all host subscriptions that the guest subscription trusts in a location.
   */
  list is ArmResourceListAtScope<TrustedHostSubscription>;
}
