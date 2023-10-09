import "@typespec/http";

import "@azure-tools/typespec-azure-core";

import "./models/blocking.tsp";
import "./models/streaming.tsp";

namespace Azure.AI.Chat;

using TypeSpec.Http;
using Azure.Core.Foundations;

@route("/chat")
interface Chat<StateModel, ArgumentsModel> {
  /* Using the Foundations.Operation template so the API version parameter is added */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Defining the operation in an Azure independent fashion"
  @doc("placeholder")
  @sharedRoute
  create is Operation<
    ChatCompletionOptions<StateModel, ArgumentsModel>,
    ChatCompletion<StateModel, ArgumentsModel>
  >;

  /* Using the Foundations.Operation template so the API version parameter is added */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Defining the operation in an Azure independent fashion"
  @doc("placeholder")
  @sharedRoute
  createStreaming is Operation<
    StreamingChatCompletionOptions<StateModel, ArgumentsModel>,
    ChatCompletionChunk<StateModel, ArgumentsModel>
  >;
}

@route("/chat")
interface GenericChatClient extends Chat<unknown, Record<unknown>> {}
