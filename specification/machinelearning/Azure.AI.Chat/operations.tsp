import "@typespec/http";

import "./models/blocking.tsp";
import "./models/streaming.tsp";

namespace Azure.AI.Chat;

using TypeSpec.Http;

@route("/chat")
interface Chat<StateModel, ArgumentsModel> {
  @doc("placeholder")
  @sharedRoute
  create(...ChatCompletionOptions<StateModel, ArgumentsModel>): ChatCompletion<StateModel, ArgumentsModel>;

  @doc("placeholder")
  @sharedRoute
  createStreaming(...StreamingChatCompletionOptions<StateModel, ArgumentsModel>): ChatCompletionChunk<StateModel, ArgumentsModel>;
}

interface GenericChatClient extends Chat<unknown, unknown> {}