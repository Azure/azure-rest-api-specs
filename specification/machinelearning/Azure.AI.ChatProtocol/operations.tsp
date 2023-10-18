import "@typespec/http";

import "@azure-tools/typespec-azure-core";

import "./models/blocking.tsp";
import "./models/streaming.tsp";

namespace Azure.AI.ChatProtocol;

using TypeSpec.Http;
using Azure.Core;

interface Chat<StateModel, ContextModel> {
  /* Using the Foundations.Operation template so the API version parameter is added */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Defining the operation in an Azure independent fashion"
  @doc("Creates a new streaming chat completion.")
  @sharedRoute
  @route("/chat")
  createStreaming is RpcOperation<
  StreamingChatCompletionOptions<StateModel, ContextModel>,
    ChatCompletionChunk<StateModel, ContextModel>
    >;

  /* Using the Foundations.Operation template so the API version parameter is added */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Defining the operation in an Azure independent fashion"
  @doc("Creates a new chat completion.")
  @sharedRoute
  @route("/chat")
  create is RpcOperation<
    ChatCompletionOptions<StateModel, ContextModel>,
    ChatCompletion<StateModel, ContextModel>
  >;
}

interface GenericChatClient extends Chat<unknown, Record<unknown>> {}
