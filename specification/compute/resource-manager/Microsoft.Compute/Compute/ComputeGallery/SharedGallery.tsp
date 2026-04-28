import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;

namespace ComputeGallery;
/**
 * Specifies information about the Shared Gallery that you want to create or update.
 */
model SharedGallery is ProxyResourceShared<SharedGalleryProperties>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Not an ARM resource - deprecated custom resource"
interface SharedGalleries {
  /**
   * Get a shared gallery by subscription id or tenant id.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/sharedGalleries/{galleryUniqueName}")
  @get
  @tag("SharedGalleries")
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /** The name of the Azure region. */
    ...Azure.ResourceManager.LocationResourceParameter,

    /** The unique name of the Shared Gallery. */
    @path
    galleryUniqueName: string,
  ): ArmResponse<SharedGallery> | Common.CloudError;

  /**
   * List shared galleries by subscription id or tenant id.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/sharedGalleries")
  @get
  @list
  @tag("SharedGalleries")
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /** The name of the Azure region. */
    ...Azure.ResourceManager.LocationResourceParameter,

    /**
     * The query parameter to decide what shared galleries to fetch when doing listing operations.
     */
    @query("sharedTo")
    sharedTo?: SharedToValues,
  ): ArmResponse<SharedGalleryList> | Common.CloudError;
}

@@doc(SharedGallery.properties, "Specifies the properties of a shared gallery");
