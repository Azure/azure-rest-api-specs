import "@typespec/http";

import "@azure-tools/typespec-azure-core";

import "./models/blocking.tsp";
import "./models/streaming.tsp";

namespace Azure.AI.ChatProtocol;

using TypeSpec.Http;
using Azure.Core.Foundations;

interface Chat<TState, TContext> {
  /* Using the Foundations.Operation template so the API version parameter is added */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Defining the operation in an Azure independent fashion"
  @doc("Creates a new streaming chat completion.")
  @sharedRoute
  createStreaming is Operation<
    StreamingChatCompletionOptions<TState, TContext>,
    ChatCompletionChunk<TState, TContext>
  >;

  /* Using the Foundations.Operation template so the API version parameter is added */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Defining the operation in an Azure independent fashion"
  @doc("Creates a new chat completion.")
  @sharedRoute
  create is Operation<
    ChatCompletionOptions<TState, TContext>,
    ChatCompletion<TState, TContext>
  >;
}

@route("/chat")
interface GenericChatClient extends Chat<unknown, Record<unknown>> {}
