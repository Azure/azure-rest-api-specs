using Azure.Core;
using TypeSpec.Http;
using Azure.Core.Traits;

namespace AzureHealthInsights;

@trait("HealthInsightsRetryAfterTrait")
@doc("Health Insights retry after trait")
model HealthInsightsRetryAfterTrait {
  @traitContext(TraitContext.Read)
  @doc("The retry-after header.")
  retryAfter: {
    @traitLocation(TraitLocation.Response)
    response: Foundations.RetryAfterHeader;
  };
}
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
