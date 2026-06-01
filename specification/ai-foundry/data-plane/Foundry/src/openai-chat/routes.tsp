import "@azure-tools/openai-typespec";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@route("openai/v1")
@tag("Chat")
interface Chat {
  @extension("x-ms-ignore-summary", true)
  listChatCompletions is OpenAI.listChatCompletions;
  @summary("Create a chat completion. Only Chat Completions that have been stored with the `store` parameter set to `true` will be returned.")
  @extension("x-ms-ignore-summary", true)
  createChatCompletion is OpenAI.createChatCompletion;
  @extension("x-ms-ignore-summary", true)
  deleteChatCompletion is OpenAI.deleteChatCompletion;
  @extension("x-ms-ignore-summary", true)
  getChatCompletion is OpenAI.getChatCompletion;
  @extension("x-ms-ignore-summary", true)
  updateChatCompletion is OpenAI.updateChatCompletion;
  @extension("x-ms-ignore-summary", true)
  getChatCompletionMessages is OpenAI.getChatCompletionMessages;
}
