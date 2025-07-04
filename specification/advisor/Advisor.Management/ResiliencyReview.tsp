import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Advisor;
/**
 * The Advisor resiliency review data structure.
 */
@subscriptionResource
model ResiliencyReview
  is Azure.ResourceManager.ProxyResource<ResiliencyReviewProperties> {
  ...ResourceNameParameter<
    Resource = ResiliencyReview,
    KeyName = "reviewId",
    SegmentName = "resiliencyReviews",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ResiliencyReviews {
  /**
   * Get existing Azure Advisor resiliency review by id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("resiliencyReviews_Get")
  get is ArmResourceRead<
    ResiliencyReview,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Get list of Azure Advisor resiliency reviews.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("resiliencyReviews_List")
  list is ArmResourceListByParent<
    ResiliencyReview,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * The number of items to be included in the result.
       */
      @query("$top")
      $top?: int32;

      /**
       * The number of items to skip before starting to collect the result set.
       */
      @query("$skip")
      $skip?: int32;

      /**
       * The filter to apply.<br>Filter can be applied to properties ['reviewStatus', 'reviewId'] with operators ['eq', 'and', 'or'].<br>Example:<br>- $filter=reviewStatus eq 'New'
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<ResiliencyReviewCollection>
  >;
}

@@doc(ResiliencyReview.name,
  "Existing review id. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000)."
);
@@doc(ResiliencyReview.properties, "Advisor resiliency review properties.");
