import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Rest;

namespace Microsoft.ComputeLimit;

/** Guest subscription that consumes shared compute limits. */
@parentResource(SubscriptionLocationResource)
model GuestSubscription is ProxyResource<GuestSubscriptionProperties> {
  ...ResourceNameParameter<
    Resource = GuestSubscription,
    KeyName = "guestSubscriptionId",
    SegmentName = "guestSubscriptions",
    NamePattern = "^[0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12}$"
  >;
}

/** Properties for guest subscription. */
model GuestSubscriptionProperties {
  ...DefaultProvisioningStateProperty;
}

/** Location-scoped operations for guest subscriptions. */
@armResourceOperations
interface GuestSubscriptions {
  /**
   * Gets the properties of a guest subscription.
   */
  get is ArmResourceRead<GuestSubscription>;

  /**
   * Adds a subscription as a guest to consume the compute limits shared by the host subscription.
   */
  create is ArmResourceCreateOrReplaceSync<GuestSubscription>;

  /**
   * Deletes a subscription as a guest to stop consuming the compute limits shared by the host subscription.
   */
  delete is ArmResourceDeleteSync<GuestSubscription>;

  /**
   * Lists all guest subscriptions in a location.
   */
  list is ArmResourceListAtScope<GuestSubscription>;
}
