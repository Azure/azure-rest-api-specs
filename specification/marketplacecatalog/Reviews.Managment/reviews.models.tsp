import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Marketplace;

@tenantResource
model Product is ProxyResource<ProductProperties> {
  ...ResourceNameParameter<
    Resource = Product,
    KeyName = "uniqueProductId",
    SegmentName = "products"
  >;
}

/** Properties of the product */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
model ProductProperties {
  /** The unique product id */
  @visibility("read")
  uniqueProductId: string;
}

/**
 * Get if the user has already submitted a review for the product.
 */
model UserHasReview {
  /**
   * Indicates whether user has already submitted a review.
   */
  @visibility("read")
  hasReview: boolean;

  /**
   * The date and time when the review was last updated.
   */
  @visibility("read")
  updatedAt: string;
}

@armResourceOperations
interface RatingAndReviewsOperations {
  /**
   * Get whether the user has a review.
   */
  @get
  @action("reviews/userhasreview")
  getUserHasReview is ArmProviderActionSync<
    Response = UserHasReview,
    Parameters = {
      /**
       * Unique Product Id
       */
      @path
      @segment("products")
      uniqueProductId: string;
    }
  >;
}
