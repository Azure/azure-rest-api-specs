import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@doc("The language service conversations API is a suite of natural language processing (NLP) skills that can be used to analyze structured conversations (textual or spoken). The synchronous API in this suite accepts a request and mediates among multiple language projects, such as LUIS Generally Available, Question Answering, Conversational Language Understanding, and then calls the best candidate service to handle the request. At last, it returns a response with the candidate service's response as a payload.\n\n In some cases, this API needs to forward requests and responses between the caller and an upstream service. The asynchronous APIs in this suite enable tasks like Conversation Summarization and Conversational PII detection.")
@service({
  title: "Microsoft Cognitive Language Service - Analyze Conversations",
  version: "2022-05-01",
})
@useAuth(ApiKey)
@server(
  "{Endpoint}/language",
  "Single server endpoint",
  {
    @doc("Supported Cognitive Services endpoint (e.g., https://<resource-name>.api.cognitiveservices.azure.com).")
    Endpoint: string,
  }
)
namespace AnalyzeConversation;

@doc("A subscription key for a Language service resource")
model ApiKey
  is ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key">;

@doc("Enumeration of supported Conversation tasks.")
enum AnalyzeConversationTaskKind {
  "Conversation",
}

@doc("Enumeration of supported conversational task results.")
enum AnalyzeConversationTaskResultsKind {
  "ConversationResult",
}

@discriminator("kind")
@doc("The base class of a conversation input task.")
model AnalyzeConversationTask {
  @doc("discriminator kind")
  kind: AnalyzeConversationTaskKind;
}

@doc("The base class of a conversation input task result.")
@discriminator("kind")
model AnalyzeConversationTaskResult {
  @doc("discriminator kind")
  kind: AnalyzeConversationTaskResultsKind;
}

