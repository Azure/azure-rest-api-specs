import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;
/**
 * Specifies information about the Community Gallery that you want to create or update.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@locationResource
@Azure.ResourceManager.Private.armResourceInternal(CommunityGalleryProperties)
@includeInapplicableMetadataInPayload(false)
model CommunityGallery extends PirCommunityGalleryResource {
  /**
   * The public name of the community gallery.
   */
  @path
  @key("publicGalleryName")
  @segment("communityGalleries")
  name: string;

  /**
   * Describes the properties of a community gallery.
   */
  @extension("x-ms-client-flatten", true)
  properties?: CommunityGalleryProperties;
}

@armResourceOperations
interface CommunityGalleries {
  /**
   * Get a community gallery by gallery public name.
   */
  get is ArmResourceRead<CommunityGallery>;
}
