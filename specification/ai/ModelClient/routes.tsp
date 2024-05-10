import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "./models/common.tsp";
import "./models/chat_completions.tsp";
import "./models/image_generation.tsp";
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
    ...ChatCompletionsOptions;
    ...AdditionalRequestHeaders;
  },
  ChatCompletions
>;

@doc("Return the embeddings for a given prompt.")
@actionSeparator("/")
@route("v1/embeddings")
op getEmbeddings is Azure.Core.RpcOperation<
  {
    ...EmbeddingsOptions;
    ...AdditionalRequestHeaders;
  },
  EmbeddingsResult
>;

@doc("Creates images given a prompt.")
@actionSeparator("/")
@route("images/generations")
op generateImages is Azure.Core.RpcOperation<
  {
    ...ImageGenerationOptions;
    ...AdditionalRequestHeaders;
  },
  ImageGenerations
>;

@doc("Returns information about the AI model.")
@actionSeparator("/")
@route("info")
@get
op getModelInfo is Azure.Core.RpcOperation<{}, ModelInfo>;
