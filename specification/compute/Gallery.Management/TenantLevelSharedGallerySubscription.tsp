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
 * Specifies information about the Shared Gallery Subscription that that hosts shared galleries shared at tenant level.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
@subscriptionResource
@parentResource(TenantLocationResource)
@added(Versions.v2025_12_03)
model TenantLevelSharedGallerySubscription
  is ProxyResourceShared<SharedGallerySubscriptionProperties> {
  ...Azure.ResourceManager.Legacy.ResourceNameParameter<
    Resource = SharedGallerySubscription,
    KeyName = "sharedGallerySubscriptionId",
    SegmentName = "tenantLevelSharedGallerySubscriptions",
    NamePattern = "^[^_\\W][\\w-._]{0,79}(?<![-.])$"
  >;
}

@armResourceOperations
interface TenantLevelSharedGallerySubscriptions {
  /**
   * No operation supported at this level.
   * This is only needed to form the route with the expected segments
   */
}
