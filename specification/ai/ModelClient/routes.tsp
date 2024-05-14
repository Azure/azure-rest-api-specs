import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "./models/common.tsp";
import "./models/chat_completions.tsp";
import "./models/embeddings.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

namespace ModelClient;

@doc("""
Gets chat completions for the provided chat messages.
Completions support a wide variety of tasks and generate text that continues from or "completes"
provided prompt data.
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

@doc("Return the embeddings for a given text prompt.")
@actionSeparator("/")
@route("embeddings")
op getEmbeddings is Azure.Core.RpcOperation<
  {
    ...EmbeddingsOptions;
    ...AdditionalRequestHeaders;
  },
  EmbeddingsResult
>;

@doc("Returns information about the AI model.")
@actionSeparator("/")
@route("info")
@get
op getModelInfo is Azure.Core.RpcOperation<{}, ModelInfo>;
