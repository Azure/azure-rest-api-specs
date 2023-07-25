using Azure.Core;
using TypeSpec.Http;
namespace AzureHealthInsights;

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "This is a template"
@doc("Long running RPC operation template")
@post
op LongRunningRpcOperation<
  TParams extends TypeSpec.Reflection.Model,
  TPollResponse extends TypeSpec.Reflection.Model
> is Azure.Core.Foundations.Operation<
  TParams & RepeatabilityRequestHeaders,
  Foundations.AcceptedResponse<{
    @pollingLocation
    @doc("The location for monitoring the operation state.")
    @TypeSpec.Http.header("Operation-Location")
    operationLocation: TypeSpec.Rest.ResourceLocation<TPollResponse>;
  } & Foundations.RetryAfterHeader & RepeatabilityResponseHeaders>,
  RepeatabilityRequestHeaders & RepeatabilityResponseHeaders,
  Azure.Core.Foundations.ErrorResponse
>;
