import "@typespec/http";

import "./models/blocking.tsp";
import "./models/streaming.tsp";

namespace Azure.AI.Chat;

using TypeSpec.Http;

@route("/chat")
interface Chat {
  @sharedRoute
  create(...ChatCompletionOptions): ChatCompletion;

  @sharedRoute
  createStreaming(...StreamingChatCompletionOptions): ChatCompletionChunk;
}
