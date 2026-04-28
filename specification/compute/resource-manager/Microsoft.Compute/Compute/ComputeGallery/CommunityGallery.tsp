import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;

namespace ComputeGallery;
/**
 * Specifies information about the Community Gallery that you want to create or update.
 */
model CommunityGallery is ProxyResourceCommunity<CommunityGalleryProperties>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Not an ARM resource - deprecated custom resource"
interface CommunityGalleries {
  /**
   * Get a community gallery by gallery public name.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/communityGalleries/{publicGalleryName}")
  @get
  @tag("CommunityGalleries")
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /** The name of the Azure region. */
    ...Azure.ResourceManager.LocationResourceParameter,

    /** The public name of the community gallery. */
    @path
    publicGalleryName: string,
  ): ArmResponse<CommunityGallery> | Common.CloudError;
}

@@doc(CommunityGallery.properties,
  "Describes the properties of a community gallery."
);
