import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../models/completions/chat_completions.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

using Azure.Core;

namespace Azure.AI.Inference;

@doc("""
Gets chat completions for the provided chat messages.
Completions support a wide variety of tasks and generate text that continues from or "completes"
provided prompt data.
""")
@actionSeparator("/")
@actionSeparator("/")
@route("chat/completions")
op getChatCompletions is Azure.Core.RpcOperation<
  {
    @doc("The format of the HTTP payload.")
    @header
    contentType: "application/json";

    @doc("The JSON payload containing chat completion options.")
    @body
    chatCompletionOptions: ChatCompletionsOptions;
  },
  ChatCompletions
>;
