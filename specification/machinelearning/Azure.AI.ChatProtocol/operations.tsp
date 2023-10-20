import "@typespec/http";

import "./models/blocking.tsp";
import "./models/streaming.tsp";

namespace Azure.AI.ChatProtocol;

using TypeSpec.Http;

interface Chat<TState, TContext> {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Defining the operation in an Azure independent fashion"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "API version is not supported by the back end"
  @doc("Creates a new streaming chat completion.")
  @sharedRoute
  op createStreaming(...StreamingChatCompletionOptions<TState, TContext>): ChatCompletionChunk<TState, TContext>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Defining the operation in an Azure independent fashion"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "API version is not supported by the back end"
  @doc("Creates a new chat completion.")
  @sharedRoute
  op create(...ChatCompletionOptions<TState, TContext>): ChatCompletion<TState, TContext>;
}

@route("/chat")
interface GenericChatClient extends Chat<unknown, Record<unknown>> {}
