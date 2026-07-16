import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.ComputeLimit;

/** A host subscription trusted by a guest subscription. */
@parentResource(SubscriptionLocationResource)
@added(Versions.v2026_07_30)
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
@added(Versions.v2026_07_30)
interface TrustedHostSubscriptions {
  /**
   * Adds a host subscription to the guest subscription's trusted hosts.
   */
  create is ArmResourceCreateOrReplaceSync<TrustedHostSubscription>;

  /**
   * Removes a host subscription from the guest subscription's trusted hosts.
   */
  delete is ArmResourceDeleteSync<TrustedHostSubscription>;

  /**
   * Lists all host subscriptions trusted by the guest subscription in a location.
   */
  list is ArmResourceListAtScope<TrustedHostSubscription>;
}
