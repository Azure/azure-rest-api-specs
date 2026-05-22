import "@azure-tools/openai-typespec";

using TypeSpec.Http;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@route("openai/v1")
@tag("Chat")
interface Chat {
  op listChatCompletions is OpenAI.listChatCompletions;
  op createChatCompletion is OpenAI.createChatCompletion;
  op deleteChatCompletion is OpenAI.deleteChatCompletion;
  op getChatCompletion is OpenAI.getChatCompletion;
  op updateChatCompletion is OpenAI.updateChatCompletion;
  op getChatCompletionMessages is OpenAI.getChatCompletionMessages;
}
