import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;

namespace MdsSolution.CopilotService.Models;

@doc("query request")
@resource("query")
model UserQuery {
  @doc("requestId")
  @key
  @visibility(Lifecycle.Read)
  requestId: string;
}

@doc("Query Response")
model UserQueryRequest {
  @doc("User query in natural language")
  ask: string;
}

@doc("Query Response Result")
model QueryResponse {
  @doc("Resultant Query Query or Query query execution response (JArray string). If Markdown format is requested, the result will be in Markdown format and only first 100 records will be presented here.")
  result?: string;

  @doc("Summary of the Resultant Query Query or Query query execution response (JArray string)")
  summary?: string;
}

@doc("feedbackRequest")
@resource("query")
model FeedbackRequest {
  @doc("query request Id")
  @key
  @visibility(Lifecycle.Update)
  queryResquestId: string;

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

@doc("Supported datatable format")
union DataTableFormat {
  @doc("Markdown format")
  Markdown: "Markdown",

  @doc("Json format")
  Json: "Json",

  string,
}
