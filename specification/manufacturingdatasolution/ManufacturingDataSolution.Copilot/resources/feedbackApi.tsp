import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/feedback.tsp";

using TypeSpec.Http;
using Azure.Core.Traits;
using TypeSpec.Versioning;
using MdsSolution.CopilotService.Feedback.Models;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService.FeedbackService;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias apiOperations = Azure.Core.ResourceOperations<ServiceTraits>;

interface Feedback {
  @doc("Send feedback for a query")
  submit is apiOperations.ResourceCreateWithServiceProvidedName<
    FeedbackRequest,
    ResponseHeadersTrait<{
      @doc("operation Id.")
      @header
      operationId: string;

      @doc("conversation Id.")
      @header
      conversationId: string;
    }>
  >;
}
