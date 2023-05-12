using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Traits.Private;
using TypeSpec.Http;
namespace AzureHealthInsights;

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "This is a template"
@doc("Long running RPC operation template")
op LongRunningRpcOperation<
  TParams,
  TResponse,
  Traits extends object = {}
> is Azure.Core.Foundations.Operation<
  TParams & RepeatabilityRequestHeaders,
  (Foundations.AcceptedResponse<Foundations.LongRunningStatusLocation &
    Foundations.RetryAfterHeader> &
    RepeatabilityResponseHeaders) | TResponse,
  Traits,
  Azure.Core.Foundations.ErrorResponse
>;
