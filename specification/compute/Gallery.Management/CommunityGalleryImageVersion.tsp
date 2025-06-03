import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./CommunityGalleryImage.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;
/**
 * Specifies information about the gallery image version that you want to create or update.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
@parentResource(CommunityGalleryImage)
model CommunityGalleryImageVersion
  is ProxyResourceCommunity<CommunityGalleryImageVersionProperties> {
  ...Azure.ResourceManager.Legacy.ResourceNameParameter<
    Resource = CommunityGalleryImageVersion,
    KeyName = "galleryImageVersionName",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface CommunityGalleryImageVersions {
  /**
   * Get a community gallery image version.
   */
  get is ComputeResourceRead<CommunityGalleryImageVersion>;

  /**
   * List community gallery image versions inside an image.
   */
  list is Azure.ResourceManager.Legacy.ComputeLegacyOperations.ArmResourceListByParent<
    CommunityGalleryImageVersion,
    Response = CommunityGalleryImageVersionList
  >;
}

@@doc(CommunityGalleryImageVersion.name,
  "The name of the community gallery image version. Needs to follow semantic version name pattern: The allowed characters are digit and period. Digits must be within the range of a 32-bit integer. Format: <MajorVersion>.<MinorVersion>.<Patch>"
);
@@doc(CommunityGalleryImageVersion.properties,
  "Describes the properties of a gallery image version."
);
