import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "./models/common.tsp";
import "./models/chat_completions.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

namespace AI.Model;

@doc("""
Gets chat completions for the provided chat messages.
Completions support a wide variety of tasks and generate text that continues from or "completes"
provided prompt data. The method makes a REST API call to the `/chat/completions` route 
on the given endpoint.
""")
@actionSeparator("/")
@route("chat/completions")
op getChatCompletions is Azure.Core.RpcOperation<
  {
    ...ChatCompletionsOptions;
    ...AdditionalRequestHeaders;
  },
  ChatCompletions
>;

@doc("""
Returns information about the AI model.
The method makes a REST API call to the `/info` route on the given endpoint.
""")
@actionSeparator("/")
@route("info")
@get
op getModelInfo is Azure.Core.RpcOperation<{}, ModelInfo>;
