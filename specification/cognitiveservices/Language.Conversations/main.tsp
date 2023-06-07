import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

// @useAuth(
//   ApiKeyAuth<ApiKeyLocation.header, "api-key">, 
// )

@doc("The language service conversations API is a suite of natural language processing (NLP) skills that can be used to analyze structured conversations (textual or spoken). The synchronous API in this suite accepts a request and mediates among multiple language projects, such as LUIS Generally Available, Question Answering, Conversational Language Understanding, and then calls the best candidate service to handle the request. At last, it returns a response with the candidate service's response as a payload.\n\n In some cases, this API needs to forward requests and responses between the caller and an upstream service. The asynchronous APIs in this suite enable tasks like Conversation Summarization and Conversational PII detection.")
@service({
  title: "Microsoft Cognitive Language Service - Analyze Conversations",
  version: "2022-05-01",
})

// @server(
//   "{endpoint}/widget",
//   "Contoso Widget APIs",
//   {
//     @doc("""
// Supported Widget Services endpoints (protocol and hostname, for example:
// https://westus.api.widget.contoso.com).
// """)
//     endpoint: string,
//   }
// )
namespace AnalyzeConversation;

@doc("Enumeration of supported Conversation tasks.")
model AnalyzeConversationTaskKind {
  @doc("the type")
  type: string;
}

@doc("Enumeration of supported conversational task results.")
model AnalyzeConversationTaskResultsKind {
  @doc("the type")
  type: string;
}

@doc("The base class of a conversation input task.")
@discriminator("kind") 
model AnalyzeConversationTask {
  @doc("discriminator type")
  kind: string;
}

@doc("The base class of a conversation input task result.")
@discriminator("kind") 
model AnalyzeConversationTaskResult {
  @doc("discriminator type")
  kind: string;
}


// alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

// interface AnalyzeConversations{
//   @doc("Analyzes the input conversation utterance.")
//   @key(apiKey: valueof string)
//   AnalyzeConversation is Operations.ResourceCreateWithServiceProvidedName<AnalyzeConversationTaskKind>;
// }

@route("/:analyze-conversations")
interface ConversationAnalysis {
  @doc("Analyzes the input conversation utterance.") 
  @post 
  op analyzeConversation(...AnalyzeConversationTask): AnalyzeConversationTask;
}
