import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

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
@route("v1/chat/completions")
op getChatCompletions is Azure.Core.RpcOperation<
  {
    @doc("The JSON payload containing chat completion options.")
    @body
    chatCompletionsOptions: ChatCompletionsOptions;
  },
  ChatCompletions
>;

@doc("Return the embeddings for a given prompt.")
@actionSeparator("/")
@route("v1/embeddings")
op getEmbeddings is Azure.Core.RpcOperation<
  {
    @doc("The JSON payload containing embedding options.")
    @body
    embeddingOptions: EmbeddingsOptions;
  },
  Embeddings
>;
