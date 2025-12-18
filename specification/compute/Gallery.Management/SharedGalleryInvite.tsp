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
 * Specifies information about the Shared Gallery Subscription that hosts shared galleries shared at subscription level.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
@subscriptionResource
@parentResource(SharedGallerySubscription)
model SharedGalleryInvite
  is ProxyResourceShared<SharedGalleryInviteProperties> {
  ...Azure.ResourceManager.Legacy.ResourceNameParameter<
    Resource = SharedGallerySubscription,
    KeyName = "sharedGalleryName",
    SegmentName = "sharedGalleries",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SharedGalleryInvites {
  /**
   * No operation supported at this level.
   * This is only needed to form the route with the expected segments
   */
}
