import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SharedGalleryImage.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;

namespace ComputeGallery;
/**
 * Specifies information about the gallery image version that you want to create or update.
 */
model SharedGalleryImageVersion
  is ProxyResourceShared<SharedGalleryImageVersionProperties>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Not an ARM resource - deprecated custom resource"
interface SharedGalleryImageVersions {
  /**
   * Get a shared gallery image version by subscription id or tenant id.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/sharedGalleries/{galleryUniqueName}/images/{galleryImageName}/versions/{galleryImageVersionName}")
  @get
  @tag("SharedGalleryImageVersions")
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

    /** The name of the gallery image version to be created. Needs to follow semantic version name pattern: The allowed characters are digit and period. Digits must be within the range of a 32-bit integer. Format: <MajorVersion>.<MinorVersion>.<Patch> */
    @path
    galleryImageVersionName: string,
  ): ArmResponse<SharedGalleryImageVersion> | Common.CloudError;

  /**
   * List shared gallery image versions by subscription id or tenant id.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/sharedGalleries/{galleryUniqueName}/images/{galleryImageName}/versions")
  @get
  @list
  @tag("SharedGalleryImageVersions")
  list(
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

    /**
     * The query parameter to decide what shared galleries to fetch when doing listing operations.
     */
    @query("sharedTo")
    sharedTo?: SharedToValues,
  ): ArmResponse<SharedGalleryImageVersionList> | Common.CloudError;
}

@@doc(SharedGalleryImageVersion.properties,
  "Describes the properties of a gallery image version."
);
