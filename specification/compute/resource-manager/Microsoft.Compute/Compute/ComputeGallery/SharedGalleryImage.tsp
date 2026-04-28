import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SharedGallery.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;

namespace ComputeGallery;
/**
 * Specifies information about the gallery image definition that you want to create or update.
 */
model SharedGalleryImage is ProxyResourceShared<SharedGalleryImageProperties>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Not an ARM resource - deprecated custom resource"
interface SharedGalleryImages {
  /**
   * Get a shared gallery image by subscription id or tenant id.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/sharedGalleries/{galleryUniqueName}/images/{galleryImageName}")
  @get
  @tag("SharedGalleryImages")
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /** The name of the Azure region. */
    ...Azure.ResourceManager.LocationResourceParameter,

    /** The unique name of the Shared Gallery. */
    @path
    galleryUniqueName: string,

    /** The name of the Shared Gallery Image Definition from which the Image Versions are to be listed. */
    @path
    galleryImageName: string,
  ): ArmResponse<SharedGalleryImage> | Common.CloudError;

  /**
   * List shared gallery images by subscription id or tenant id.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/sharedGalleries/{galleryUniqueName}/images")
  @get
  @list
  @tag("SharedGalleryImages")
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /** The name of the Azure region. */
    ...Azure.ResourceManager.LocationResourceParameter,

    /** The unique name of the Shared Gallery. */
    @path
    galleryUniqueName: string,

    /**
     * The query parameter to decide what shared galleries to fetch when doing listing operations.
     */
    @query("sharedTo")
    sharedTo?: SharedToValues,
  ): ArmResponse<SharedGalleryImageList> | Common.CloudError;
}

@@doc(SharedGalleryImage.properties,
  "Describes the properties of a gallery image definition."
);
