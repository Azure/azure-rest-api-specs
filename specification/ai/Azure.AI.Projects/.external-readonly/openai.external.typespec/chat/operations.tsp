import "@typespec/http";
import "@typespec/openapi";

import "../common";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace OpenAI;

@route("chat/completions")
@tag("Chat")
interface Chat {
  @get
  @operationId("listChatCompletions")
  @summary("Returns a list of chat completions.")
  listChatCompletions(
    ...PageAfterQueryParameter,
    ...PageLimitQueryParameter,
    ...PageOrderQueryParameter,
    @query metadata?: Record<string>,
    @query `model`?: string,
  ): ChatCompletionList | ErrorResponse;

  @post
  @operationId("createChatCompletion")
  @summary("Creates a model response for the given chat conversation.")
  createChatCompletion(
    @header accept: "application/json",
    @body requestBody: CreateChatCompletionRequest,
  ): CreateChatCompletionResponse | SseResponseOf<CreateChatCompletionStreamResponse> | ErrorResponse;

  @get
  @route("{completion_id}")
  @operationId("getChatCompletion")
  @summary("""
    Get a stored chat completion. Only Chat Completions that have been created with the `store` parameter set to `true` will be returned.
    """)
  getChatCompletion(
    /** The ID of the stored chat completion to retrieve. */
    @path completion_id: string,
  ): CreateChatCompletionResponse | ErrorResponse;

  @post
  @route("{completion_id}")
  @operationId("updateChatCompletion")
  @summary("""
    Modify a stored chat completion. Only Chat Completions that have been created with the `store` parameter set to `true` can be modified. Currently, the only supported modification is to update the `metadata` field.")
    """)
  updateChatCompletion(
    /** The ID of the stored chat completion to update. */
    @path completion_id: string,

    ...MetadataPropertyForRequest,
  ): CreateChatCompletionResponse | ErrorResponse;

  @delete
  @route("{completion_id}")
  @operationId("deleteChatCompletion")
  @summary("Delete a stored chat completion. Only Chat Completions that have been created with the `store` parameter set to `true` can be deleted.")
  deleteChatCompletion(
    /** The ID of the stored chat completion to delete. */
    @path completion_id: string,
  ): ChatCompletionDeleted | ErrorResponse;

  @get
  @route("{completion_id}/messages")
  @operationId("getChatCompletionMessages")
  @summary("Get the messages of a stored chat completion. Only Chat Completions that have been created with the `store` parameter set to `true` will be returned.")
  getChatCompletionMessages(
    /** The ID of the stored chat completion to retrieve messages for. */
    @path completion_id: string,

    ...PageAfterQueryParameter,
    ...PageLimitQueryParameter,
    ...PageOrderQueryParameter,
  ): ChatCompletionMessageList | ErrorResponse;
}
