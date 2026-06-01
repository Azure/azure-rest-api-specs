import "@azure-tools/openai-typespec";

using TypeSpec.Http;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@route("openai/v1")
@tag("Chat")
interface Chat {
  listChatCompletions is OpenAI.listChatCompletions;
  @summary("Create a chat completion. Only Chat Completions that have been stored with the `store` parameter set to `true` will be returned.")
  createChatCompletion is OpenAI.createChatCompletion;
  deleteChatCompletion is OpenAI.deleteChatCompletion;
  getChatCompletion is OpenAI.getChatCompletion;
  updateChatCompletion is OpenAI.updateChatCompletion;
  getChatCompletionMessages is OpenAI.getChatCompletionMessages;
}
