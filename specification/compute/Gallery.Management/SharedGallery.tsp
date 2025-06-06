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
 * Specifies information about the Shared Gallery that you want to create or update.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model SharedGallery is ProxyResourceShared<SharedGalleryProperties> {
  ...Azure.ResourceManager.Legacy.ResourceNameParameter<
    Resource = SharedGallery,
    KeyName = "galleryUniqueName",
    SegmentName = "sharedGalleries",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SharedGalleries {
  /**
   * Get a shared gallery by subscription id or tenant id.
   */
  get is ComputeResourceRead<
    SharedGallery,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * List shared galleries by subscription id or tenant id.
   */
  list is Azure.ResourceManager.Legacy.ComputeLegacyOperations.ArmResourceListByParent<
    SharedGallery,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * The query parameter to decide what shared galleries to fetch when doing listing operations.
       */
      @query("sharedTo")
      sharedTo?: SharedToValues;
    },
    Response = SharedGalleryList
  >;
}

@@doc(SharedGallery.name, "The unique name of the Shared Gallery.");
@@doc(SharedGallery.properties, "Specifies the properties of a shared gallery");
