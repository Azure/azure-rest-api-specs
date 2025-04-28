import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
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
  uniqueProductId: string;
}

model UserHasReview is ProxyResource<UserHasReviewProperties> {
  ...ResourceNameParameter<
    Resource = UserHasReview,
    KeyName = "uniqueProductId",
    SegmentName = "products"
  >;
}
/**
 * Get if the user has already submitted a review for the product.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only metadata resource."
model UserHasReviewProperties {
  /**
   * Indicates whether user has already submitted a review.
   */
  hasReview: boolean;

  /**
   * The date and time when the review was last updated.
   */
  updatedAt: string;
}

@armResourceOperations
interface RatingAndReviewsOperations {
  /**
   * Create or check user review status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi"
  @post
  @operationId("RatingAndReviews_CreateUserHasReview")
  @action("reviews/userhasreview")
  createUserHasReview is ArmProviderActionSync<
    Response = ArmResponse<UserHasReview>,
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
