import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-client-generator-core";

import "./models/completions.create.tsp";
import "./models/chat.completions.tsp";
import "./models/embeddings.create.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ClientGenerator.Core;

namespace Azure.OpenAI;

@doc("Return the embeddings for a given prompt.")
@TypeSpec.Rest.actionSeparator("/")
@action("embeddings")
@convenientAPI(true)
op getEmbeddings is Azure.Core.ResourceAction<Deployment, EmbeddingsOptions, Embeddings>;


@doc("""
Gets completions for the provided input prompts.
Completions support a wide variety of tasks and generate text that continues from or "completes"
provided prompt data.
""")
@TypeSpec.Rest.actionSeparator("/")
@action("completions")
@convenientAPI(true)
op getCompletions is Azure.Core.ResourceAction<Deployment, CompletionsOptions, Completions>;


@doc("""
Gets chat completions for the provided chat messages.
Completions support a wide variety of tasks and generate text that continues from or "completes"
provided prompt data.
""")
@TypeSpec.Rest.actionSeparator("/")
@action("chat/completions")
@convenientAPI(true)
op getChatCompletions is Azure.Core.ResourceAction<Deployment, ChatCompletionsOptions, ChatCompletions>;
