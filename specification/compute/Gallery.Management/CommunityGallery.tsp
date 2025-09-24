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
 * Specifies information about the Community Gallery that you want to create or update.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model CommunityGallery is ProxyResourceCommunity<CommunityGalleryProperties> {
  ...Azure.ResourceManager.Legacy.ResourceNameParameter<
    Resource = CommunityGallery,
    KeyName = "publicGalleryName",
    SegmentName = "communityGalleries",
    NamePattern = ""
  >;
}

@armResourceOperations
interface CommunityGalleries {
  /**
   * Get a community gallery by gallery public name.
   */
  get is ComputeResourceRead<
    CommunityGallery,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(CommunityGallery.name, "The public name of the community gallery.");
@@doc(CommunityGallery.properties,
  "Describes the properties of a community gallery."
);
