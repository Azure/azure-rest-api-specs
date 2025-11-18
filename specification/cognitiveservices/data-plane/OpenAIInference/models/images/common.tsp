import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "@typespec/versioning";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.OpenAI;

@lroStatus
@doc("The state of a job or item.")
@removed(ServiceApiVersions.v2024_02_15_Preview)
union AzureOpenAIOperationState {
  string,

  @doc("The operation was created and is queued to be processed in the future.")
  notRunning: "notRunning",

  @doc("The operation has started to be processed.")
  running: "running",

  @lroSucceeded
  @doc("The operation has successfully be processed and is ready for consumption.")
  succeeded: "succeeded",

  @lroCanceled
  @doc("The operation has been canceled and is incomplete.")
  canceled: "canceled",

  @lroFailed
  @doc("The operation has completed processing with a failure and cannot be further consumed.")
  failed: "failed",
}

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "template"
@post
@doc("Long running operation template to match Azure OpenAI .")
@removed(ServiceApiVersions.v2024_02_15_Preview)
op OaiLongRunningRpcOperation<
  TParams extends TypeSpec.Reflection.Model,
  TResponse extends TypeSpec.Reflection.Model,
  TStatusResult extends TypeSpec.Reflection.Model,
  TStatusError = Foundations.Error,
  Traits extends TypeSpec.Reflection.Model = {},
  TErrorResponse = Azure.Core.Foundations.ErrorResponse
> is Foundations.Operation<
  TParams &
    Azure.Core.Traits.Private.TraitProperties<
      Traits,
      Azure.Core.Traits.TraitLocation.Parameters
    >,
  Azure.Core.Foundations.AcceptedResponse &
    TResponse &
    Foundations.LongRunningStatusLocation<TStatusResult> &
    Azure.Core.Traits.Private.TraitProperties<
      Traits,
      Azure.Core.Traits.TraitLocation.Response
    >,
  Traits,
  TErrorResponse
>;
