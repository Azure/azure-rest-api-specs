import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./CommunityGallery.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;

namespace ComputeGallery;
/**
 * Specifies information about the gallery image definition that you want to create or update.
 */
model CommunityGalleryImage
  is ProxyResourceCommunity<CommunityGalleryImageProperties>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Not an ARM resource - deprecated custom resource"
interface CommunityGalleryImages {
  /**
   * Get a community gallery image.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/communityGalleries/{publicGalleryName}/images/{galleryImageName}")
  @get
  @tag("CommunityGalleryImages")
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /** The name of the Azure region. */
    ...Azure.ResourceManager.LocationResourceParameter,

    /** The public name of the community gallery. */
    @path
    publicGalleryName: string,

    /** The name of the community gallery image definition. */
    @path
    galleryImageName: string,
  ): ArmResponse<CommunityGalleryImage> | Common.CloudError;

  /**
   * List community gallery images inside a gallery.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/communityGalleries/{publicGalleryName}/images")
  @get
  @list
  @tag("CommunityGalleryImages")
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /** The name of the Azure region. */
    ...Azure.ResourceManager.LocationResourceParameter,

    /** The public name of the community gallery. */
    @path
    publicGalleryName: string,
  ): ArmResponse<CommunityGalleryImageList> | Common.CloudError;
}

@@doc(CommunityGalleryImage.properties,
  "Describes the properties of a gallery image definition."
);
