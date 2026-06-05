import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/common";
import "@typespec/openapi";
import "@azure-tools/openai-typespec/models/chat";
using TypeSpec.Http;
using OpenAI;
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@route("openai/v1/chat")
@tag("Chat")
interface Chat {
  @list
  @route("completions")
  @get
  @summary("""
    List stored Chat Completions. Only Chat Completions that have been stored
    with the `store` parameter set to `true` will be returned.
    
    """)
  listChatCompletions is OpenAIOperation<
    {
      /** The model used to generate the Chat Completions. */
      @query(#{ explode: true })
      `model`?: string;

      /**A list of metadata keys to filter the Chat Completions by. Example:
  `metadata[key1]=value1&metadata[key2]=value2`*/
      @query(#{ explode: true })
      metadata?: OpenAI.Metadata | null;

      /** Identifier for the last chat completion from the previous pagination request. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** Number of Chat Completions to retrieve. */
      @query(#{ explode: true })
      limit?: integer = 20;

      /** Sort order for Chat Completions by timestamp. Use `asc` for ascending order or `desc` for descending order. Defaults to `asc`. */
      @query(#{ explode: true })
      order?: OpenAI.OrderEnum = OrderEnum.asc;
    },
    OpenAI.ChatCompletionList
  >;

  @route("completions")
  @post
  @summary("""
    **Starting a new project?** We recommend trying [Responses](/docs/api-reference/responses)
    to take advantage of the latest OpenAI platform features. Compare
    [Chat Completions with Responses](/docs/guides/responses-vs-chat-completions?api-mode=responses).
    
    ---
    
    Creates a model response for the given chat conversation. Learn more in the
    [text generation](/docs/guides/text-generation), [vision](/docs/guides/vision),
    and [audio](/docs/guides/audio) guides.
    
    Parameter support can differ depending on the model used to generate the
    response, particularly for newer reasoning models. Parameters that are only
    supported for reasoning models are noted below. For the current state of
    unsupported parameters in reasoning models,
    [refer to the reasoning guide](/docs/guides/reasoning).
    
    Returns a chat completion object, or a streamed sequence of chat completion
    chunk objects if the request is streamed.
    
    """)
  createChatCompletion is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateChatCompletionRequest;
    },
    OpenAI.CreateChatCompletionResponse
  >;

  @route("completions/{completion_id}")
  @delete
  @summary("""
    Delete a stored chat completion. Only Chat Completions that have been
    created with the `store` parameter set to `true` can be deleted.
    
    """)
  deleteChatCompletion is OpenAIOperation<
    {
      /** The ID of the chat completion to delete. */
      @path
      completion_id: string;
    },
    OpenAI.ChatCompletionDeleted
  >;

  @route("completions/{completion_id}")
  @get
  @summary("""
    Get a stored chat completion. Only Chat Completions that have been created
    with the `store` parameter set to `true` will be returned.
    
    """)
  getChatCompletion is OpenAIOperation<
    {
      /** The ID of the chat completion to retrieve. */
      @path
      completion_id: string;
    },
    OpenAI.CreateChatCompletionResponse
  >;

  @route("completions/{completion_id}")
  @post
  @summary("""
    Modify a stored chat completion. Only Chat Completions that have been
    created with the `store` parameter set to `true` can be modified. Currently,
    the only supported modification is to update the `metadata` field.
    
    """)
  updateChatCompletion is OpenAIOperation<
    {
      /** The ID of the chat completion to update. */
      @path
      completion_id: string;

      @body
      body: OpenAI.UpdateChatCompletionParametersBody;
    },
    OpenAI.CreateChatCompletionResponse
  >;

  @list
  @route("completions/{completion_id}/messages")
  @get
  @summary("""
    Get the messages in a stored chat completion. Only Chat Completions that
    have been created with the `store` parameter set to `true` will be
    returned.
    
    """)
  getChatCompletionMessages is OpenAIOperation<
    {
      /** The ID of the chat completion to retrieve messages from. */
      @path
      completion_id: string;

      /** Identifier for the last message from the previous pagination request. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /** Number of messages to retrieve. */
      @query(#{ explode: true })
      limit?: integer = 20;

      /** Sort order for messages by timestamp. Use `asc` for ascending order or `desc` for descending order. Defaults to `asc`. */
      @query(#{ explode: true })
      order?: OpenAI.OrderEnum = OrderEnum.asc;
    },
    OpenAI.ChatCompletionMessageList
  >;
}
