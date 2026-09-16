import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Marketplace;

@@clientLocation(
  RatingAndReviewsOperations.checkUserHasReview,
  "RatingAndReviews"
);
