import "@azure-tools/typespec-azure-core";
using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Http;
namespace AzureHealthInsights;

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "This is a template"
@doc("Long running RPC operation template")
op LongRunningRpcOperation<
  TParams,
  TResponse
> is Azure.Core.Foundations.Operation<
  TParams & RepeatabilityRequestHeaders,
  (Foundations.AcceptedResponse<Foundations.LongRunningStatusLocation &
    Foundations.RetryAfterHeader> &
    RepeatabilityResponseHeaders) | TResponse,
  RepeatabilityRequestHeaders & RepeatabilityResponseHeaders,
  Azure.Core.Foundations.ErrorResponse
>;

interface StandardOperations extends Azure.Core.ResourceOperations<NoClientRequestId & NoConditionalRequests & NoRepeatableRequests> {}
