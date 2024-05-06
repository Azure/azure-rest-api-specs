using Azure.Core;
using TypeSpec.Http;
using Azure.Core.Traits;

namespace AzureHealthInsights;

alias HealthInsightsRetryAfterTrait = ResponseHeadersTrait<
  Foundations.RetryAfterHeader,
  TraitContext.Read
>;

//   Note: I cannot use the following alias because of a bug in the compiler
//   Using it return: "error intersect-duplicate-property: Intersection contains duplicate property definitions for responseHeaders"
//   I can't use it like that: ResponseHeadersTrait<RequestIdResponseHeader & Foundations.RetryAfterHeader>;
//   because then both traits will get the same context which is not the desired behavior.
// alias RequestIdResponseHeaderTrait = ResponseHeadersTrait<RequestIdResponseHeader>;
/////////////////////
@doc("Provides the 'x-ms-request-id' header to enable request correlation in responses.")
@trait("RequestIdResponseHeader")
model RequestIdResponseHeaderTrait {
  @doc("An opaque, globally-unique, server-generated string identifier for the request.")
  requestId: {
    @traitLocation(TraitLocation.Response)
    response: RequestIdResponseHeader;
  };
}

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId &
  HealthInsightsRetryAfterTrait &
  RequestIdResponseHeaderTrait &
  QueryParametersTrait<Azure.Core.ExpandQueryParameter>;

model HealthInsightsErrorResponse is Azure.Core.Foundations.ErrorResponse {
  ...RequestIdResponseHeaderTrait;
}

alias HealthInsightsOperations = ResourceOperations<
  ServiceTraits,
  HealthInsightsErrorResponse
>;
