import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;

namespace MdsSolution.CopilotService.QueryService.QueryModels;

@doc("query request")
@resource("query")
model QueryRequest {
  @key
  @doc("User query in natural language")
  @visibility(Lifecycle.Read, Lifecycle.Update)
  ask: string;
}

@doc("Query Response Result")
model QueryResponse {
  @doc("Resultant Query Query or Query query execution response (JArray string)")
  result?: string;

  @doc("Summary of the Resultant Query Query or Query query execution response (JArray string)")
  summary?: string;
}

@doc("feedbackRequest")
@resource("query")
model FeedbackRequest {
  @doc("operation Id")
  @key
  @visibility(Lifecycle.Update)
  operationId: string;

  @doc("conversation id")
  conversationId?: string;

  @doc("The feedback")
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
