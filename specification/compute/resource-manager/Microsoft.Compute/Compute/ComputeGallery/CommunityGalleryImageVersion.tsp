import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./CommunityGalleryImage.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;

namespace ComputeGallery;
/**
 * Specifies information about the gallery image version that you want to create or update.
 */
model CommunityGalleryImageVersion
  is ProxyResourceCommunity<CommunityGalleryImageVersionProperties> {
  ...Azure.ResourceManager.Legacy.ResourceNameParameter<
    Resource = CommunityGalleryImageVersion,
    KeyName = "galleryImageVersionName",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Not an ARM resource - deprecated custom resource"
interface CommunityGalleryImageVersions {
  /**
   * Get a community gallery image version.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/communityGalleries/{publicGalleryName}/images/{galleryImageName}/versions/{galleryImageVersionName}")
  @get
  @tag("CommunityGalleryImageVersions")
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

    /** The name of the community gallery image version. Needs to follow semantic version name pattern: The allowed characters are digit and period. Digits must be within the range of a 32-bit integer. Format: <MajorVersion>.<MinorVersion>.<Patch> */
    @path
    galleryImageVersionName: string,
  ): ArmResponse<CommunityGalleryImageVersion> | Common.CloudError;

  /**
   * List community gallery image versions inside an image.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/communityGalleries/{publicGalleryName}/images/{galleryImageName}/versions")
  @get
  @list
  @tag("CommunityGalleryImageVersions")
  list(
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
  ): ArmResponse<CommunityGalleryImageVersionList> | Common.CloudError;
}

@@doc(CommunityGalleryImageVersion.name,
  "The name of the community gallery image version. Needs to follow semantic version name pattern: The allowed characters are digit and period. Digits must be within the range of a 32-bit integer. Format: <MajorVersion>.<MinorVersion>.<Patch>"
);
@@doc(CommunityGalleryImageVersion.properties,
  "Describes the properties of a gallery image version."
);
