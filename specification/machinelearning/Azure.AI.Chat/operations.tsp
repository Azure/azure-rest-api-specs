import "@typespec/http";

import "./models/blocking.tsp";
import "./models/streaming.tsp";

namespace Azure.AI.Chat;

using TypeSpec.Http;

@route("/chat")
interface Chat {
  @doc("placeholder")
  @sharedRoute
  create(...ChatCompletionOptions): ChatCompletion;

  @doc("placeholder")
  @sharedRoute
  createStreaming(...StreamingChatCompletionOptions): ChatCompletionChunk;
}
