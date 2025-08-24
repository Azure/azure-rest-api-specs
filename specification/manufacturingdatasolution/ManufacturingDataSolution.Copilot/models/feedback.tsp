import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;

namespace MdsSolution.CopilotService.Feedback.Models;

@doc("feedbackRequest")
@resource("feedback")
model FeedbackRequest {
  @doc("The query id")
  operationId: string;

  @doc("conversation id")
  conversationId: string;

  @key
  @doc("The feedback")
  @visibility(Lifecycle.Update)
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

  string,
}
