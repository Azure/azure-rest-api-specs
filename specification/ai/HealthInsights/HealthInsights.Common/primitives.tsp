using Azure.Core;
using TypeSpec.Http;
using Azure.Core.Traits;

namespace AzureHealthInsights;

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "This is a template"
@doc("Long running RPC operation template")
op HealthInsightsLongRunningRpcOperation<
  TParams extends TypeSpec.Reflection.Model,
  TResponse extends TypeSpec.Reflection.Model,
  Traits extends object = {}
> is Azure.Core.RpcOperation<
  TParams & RepeatabilityRequestHeaders,
  Foundations.AcceptedResponse<HealthInsightsLongRunningStatusLocation<TResponse> &
    Foundations.RetryAfterHeader> &
    RepeatabilityResponseHeaders &
    HealthInsightsOperationStatus,
  Traits
>;

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "This is a template"
@doc("Long running Pool operation template")
op HealthInsightsLongRunningPollOperation<TResult extends TypeSpec.Reflection.Model> is Azure.Core.RpcOperation<
  {
    @doc("A processing job identifier.")
    @path("id")
    id: Azure.Core.uuid;
  },
  TResult,
  HealthInsightsRetryAfterTrait
>;

/**
 * Metadata for long running operation status monitor locations.
 * @template TStatusResult The type of the operation status result.
 */
@doc("Metadata for long running operation status monitor locations")
model HealthInsightsLongRunningStatusLocation<TStatusResult = never> {
  @pollingLocation
  @doc("The location for monitoring the operation state.")
  @TypeSpec.Http.header("Operation-Location")
  operationLocation: HealthInsightsResourceLocation<HealthInsightsOperationStatus<TStatusResult>>;
}

/**
 * A URL that points to a resource.
 * @template TResource The type of resource that the URL points to.
 */
@doc("The location of an instance of {name}", TResource)
scalar HealthInsightsResourceLocation<TResource extends {}> extends url;

@trait("HealthInsightsRetryAfterTrait")
@doc("Health Insights retry after trait")
model HealthInsightsRetryAfterTrait {
  @doc("The retry-after header.")
  retryAfter: {
    @traitLocation(TraitLocation.Response)
    response: Foundations.RetryAfterHeader;
  };
}
