import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/copilotmodels.tsp";
import "./../models/common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Versioning;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService.FeedbackService;

alias ServiceTraits = SupportsRepeatableRequests &
  SupportsConditionalRequests &
  SupportsClientRequestId;

alias apiOperations = Azure.Core.ResourceOperations<ServiceTraits>;

@doc("feedbackRequest")
@resource("feedback")
model FeedbackRequest {
  @doc("The query id")
  operationId: string;

  @doc("conversation id")
  conversationId: string;

  @key
  @doc("The feedback")
  @visibility("create")
  feedback: FeedbackCategory;

  @doc("QueryEndpoint")
  queryEndpoint: QueryEndpoint;
}

@doc("Feedback category")
union FeedbackCategory {
  @doc("Neutral feedback.")
  Neutral: "Neutral",

  @doc("Positive feedback.")
  ThumbUp: "ThumbUp",

  @doc("Negative feedback.")
  ThumbDown: "ThumbDown",

  string,
}

@doc("Query endpoint")
union QueryEndpoint {
  @doc("V3 endpoint")
  V3: "V3",

  @doc("Assistant endpoint")
  Assistant: "Assistant",

  string
}

interface Feedback {
  @doc("Send feedback for a query")
  submitFeedback is apiOperations.ResourceCreateWithServiceProvidedName<FeedbackRequest>;
}
