import "@azure-tools/openai-typespec";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@route("openai/v1")
@tag("Chat")
interface Chat {
  /**
   * Returns stored chat completions that were created with the `store` parameter enabled.
   */
  @summary("List chat completions")
  listChatCompletions is OpenAI.listChatCompletions;
  /**
   * Creates a model response for the provided chat conversation.
   */
  @summary("Create a chat completion")
  createChatCompletion is OpenAI.createChatCompletion;
  /**
   * Deletes a stored chat completion that was created with the `store` parameter enabled.
   */
  @summary("Delete a chat completion")
  deleteChatCompletion is OpenAI.deleteChatCompletion;
  /**
   * Retrieves a stored chat completion by its identifier.
   */
  @summary("Get a chat completion")
  getChatCompletion is OpenAI.getChatCompletion;
  /**
   * Updates a stored chat completion by modifying its metadata.
   */
  @summary("Update a chat completion")
  updateChatCompletion is OpenAI.updateChatCompletion;
  /**
   * Returns the messages for a stored chat completion.
   */
  @summary("List messages for a chat completion")
  getChatCompletionMessages is OpenAI.getChatCompletionMessages;
}
