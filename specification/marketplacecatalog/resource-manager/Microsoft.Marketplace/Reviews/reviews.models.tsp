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

@doc("Response to check user has already submitted a review for the product.")
model UserHasReview is ProxyResource<UserHasReviewProperties> {
  ...ResourceNameParameter<
    Resource = UserHasReview,
    KeyName = "uniqueProductId",
    SegmentName = "products"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only metadata resource."
@doc("Response of the check user has review operation.")
model UserHasReviewProperties {
  @doc("Indicates whether user has already submitted a review.")
  hasReview: boolean;

  @doc("The date and time when the review was last updated.")
  updatedAt: string;
}

@armResourceOperations
interface RatingAndReviewsOperations {
  #suppress "@azure-tools/typespec-azure-core/no-openapi"
  @doc("Check user has review.")
  @post
  @operationId("RatingAndReviews_CheckUserHasReview")
  @action("checkUserHasReview")
  checkUserHasReview is ArmProviderActionSync<
    Response = ArmResponse<UserHasReview>,
    Parameters = {
      @doc("Unique Product Id")
      @path
      @segment("products")
      uniqueProductId: string;
    }
  >;
}
