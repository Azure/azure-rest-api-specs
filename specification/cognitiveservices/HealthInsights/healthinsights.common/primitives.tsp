import "@azure-tools/typespec-azure-core";

using Azure.Core;
using TypeSpec.Http;

namespace AzureHealthInsights;

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "This is a template"
@doc("Long running RPC operation template")
@post
op TLongRunningRpcOperation<
  TParams,
  TResponse
> is Azure.Core.Foundations.Operation<
  TParams & RepeatabilityRequestHeaders,
  (Foundations.AcceptedResponse<Foundations.LongRunningStatusLocation<TResponse> &
    Foundations.RetryAfterHeader> &
    RepeatabilityResponseHeaders),
  RepeatabilityRequestHeaders & RepeatabilityResponseHeaders,
  Azure.Core.Foundations.ErrorResponse
>;
