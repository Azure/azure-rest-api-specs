import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Versioning;

namespace Microsoft.Compute;
/**
 * Specifies information about the Invite for a Shared Gallery shared at subscription level.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
@subscriptionResource
@parentResource(SubscriptionLocationResource)
@added(Versions.v2025_12_03)
model SharedGallerySubscription
  is ProxyResourceShared<SharedGallerySubscriptionProperties> {
  ...Azure.ResourceManager.Legacy.ResourceNameParameter<
    Resource = SharedGallerySubscription,
    KeyName = "sharedGallerySubscriptionId",
    SegmentName = "sharedGallerySubscriptions",
    NamePattern = "^[^_\\W][\\w-._]{0,79}(?<![-.])$"
  >;
}

@armResourceOperations
interface SharedGallerySubscriptions {
  /**
   * No operation supported at this level.
   * This is only needed to form the route with the expected segments
   */
}
