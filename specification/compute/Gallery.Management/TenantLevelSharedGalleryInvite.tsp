import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;
/**
 * Specifies information about the Invite for a Shared Gallery shared at tenant level.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
@subscriptionResource
@parentResource(TenantLevelSharedGallerySubscription)
model TenantLevelSharedGalleryInvite
  is ProxyResourceShared<SharedGalleryInviteProperties> {
  ...Azure.ResourceManager.Legacy.ResourceNameParameter<
    Resource = SharedGallerySubscription,
    KeyName = "sharedGalleryName",
    SegmentName = "sharedGalleries",
    NamePattern = ""
  >;
}

@armResourceOperations
interface TenantLevelSharedGalleryInvites {
  /**
   * No operation supported at this level.
   * This is only needed to form the route with the expected segments
   */
}
