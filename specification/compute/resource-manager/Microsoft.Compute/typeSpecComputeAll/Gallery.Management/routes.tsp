// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Compute;

interface SharedGalleriesOperations {
  /**
   * List shared galleries by subscription id or tenant id.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/sharedGalleries")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The query parameter to decide what shared galleries to fetch when doing listing operations.
     */
    @query("sharedTo")
    sharedTo?: SharedToValues,
  ): ArmResponse<SharedGalleryList> | ErrorResponse;

  /**
   * Get a shared gallery by subscription id or tenant id.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/sharedGalleries/{galleryUniqueName}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The unique name of the Shared Gallery.
     */
    @path
    galleryUniqueName: string,
  ): ArmResponse<SharedGallery> | ErrorResponse;
}

interface SharedGalleryImagesOperations {
  /**
   * List shared gallery images by subscription id or tenant id.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/sharedGalleries/{galleryUniqueName}/images")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The unique name of the Shared Gallery.
     */
    @path
    galleryUniqueName: string,

    /**
     * The query parameter to decide what shared galleries to fetch when doing listing operations.
     */
    @query("sharedTo")
    sharedTo?: SharedToValues,
  ): ArmResponse<SharedGalleryImageList> | ErrorResponse;

  /**
   * Get a shared gallery image by subscription id or tenant id.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/sharedGalleries/{galleryUniqueName}/images/{galleryImageName}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The unique name of the Shared Gallery.
     */
    @path
    galleryUniqueName: string,

    /**
     * The name of the Shared Gallery Image Definition from which the Image Versions are to be listed.
     */
    @path
    galleryImageName: string,
  ): ArmResponse<SharedGalleryImage> | ErrorResponse;
}

interface SharedGalleryImageVersionsOperations {
  /**
   * List shared gallery image versions by subscription id or tenant id.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/sharedGalleries/{galleryUniqueName}/images/{galleryImageName}/versions")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The unique name of the Shared Gallery.
     */
    @path
    galleryUniqueName: string,

    /**
     * The name of the Shared Gallery Image Definition from which the Image Versions are to be listed.
     */
    @path
    galleryImageName: string,

    /**
     * The query parameter to decide what shared galleries to fetch when doing listing operations.
     */
    @query("sharedTo")
    sharedTo?: SharedToValues,
  ): ArmResponse<SharedGalleryImageVersionList> | ErrorResponse;

  /**
   * Get a shared gallery image version by subscription id or tenant id.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/sharedGalleries/{galleryUniqueName}/images/{galleryImageName}/versions/{galleryImageVersionName}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The unique name of the Shared Gallery.
     */
    @path
    galleryUniqueName: string,

    /**
     * The name of the Shared Gallery Image Definition from which the Image Versions are to be listed.
     */
    @path
    galleryImageName: string,

    /**
     * The name of the gallery image version to be created. Needs to follow semantic version name pattern: The allowed characters are digit and period. Digits must be within the range of a 32-bit integer. Format: <MajorVersion>.<MinorVersion>.<Patch>
     */
    @path
    galleryImageVersionName: string,
  ): ArmResponse<SharedGalleryImageVersion> | ErrorResponse;
}

interface CommunityGalleriesOperations {
  /**
   * Get a community gallery by gallery public name.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/communityGalleries/{publicGalleryName}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The public name of the community gallery.
     */
    @path
    publicGalleryName: string,
  ): ArmResponse<CommunityGallery> | ErrorResponse;
}

interface CommunityGalleryImagesOperations {
  /**
   * Get a community gallery image.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/communityGalleries/{publicGalleryName}/images/{galleryImageName}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The public name of the community gallery.
     */
    @path
    publicGalleryName: string,

    /**
     * The name of the community gallery image definition.
     */
    @path
    galleryImageName: string,
  ): ArmResponse<CommunityGalleryImage> | ErrorResponse;

  /**
   * List community gallery images inside a gallery.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/communityGalleries/{publicGalleryName}/images")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The public name of the community gallery.
     */
    @path
    publicGalleryName: string,
  ): ArmResponse<CommunityGalleryImageList> | ErrorResponse;
}

interface CommunityGalleryImageVersionsOperations {
  /**
   * Get a community gallery image version.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/communityGalleries/{publicGalleryName}/images/{galleryImageName}/versions/{galleryImageVersionName}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The public name of the community gallery.
     */
    @path
    publicGalleryName: string,

    /**
     * The name of the community gallery image definition.
     */
    @path
    galleryImageName: string,

    /**
     * The name of the community gallery image version. Needs to follow semantic version name pattern: The allowed characters are digit and period. Digits must be within the range of a 32-bit integer. Format: <MajorVersion>.<MinorVersion>.<Patch>
     */
    @path
    galleryImageVersionName: string,
  ): ArmResponse<CommunityGalleryImageVersion> | ErrorResponse;

  /**
   * List community gallery image versions inside an image.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/communityGalleries/{publicGalleryName}/images/{galleryImageName}/versions")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The public name of the community gallery.
     */
    @path
    publicGalleryName: string,

    /**
     * The name of the community gallery image definition.
     */
    @path
    galleryImageName: string,
  ): ArmResponse<CommunityGalleryImageVersionList> | ErrorResponse;
}
