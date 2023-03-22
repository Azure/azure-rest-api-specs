import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-client-generator-core";

import "./models/completions.create.tsp";
import "./models/chatcompletions.create.tsp";
import "./models/embeddings.create.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ClientGenerator.Core;

namespace Azure.OpenAI;

@doc("Get embeddings for a given prompt.")
@TypeSpec.Rest.actionSeparator("/")
@action("embeddings")
@convenientAPI(true)
op getEmbeddings is Azure.Core.ResourceAction<Deployment, EmbeddingsOptions, Embeddings>;

@doc("Get completions for provided textual prompts.")
@TypeSpec.Rest.actionSeparator("/")
@action("completions")
@convenientAPI(true)
op getCompletions is Azure.Core.ResourceAction<Deployment, CompletionsOptions, Completions>;

// @doc("Get streaming completions for provided textual prompts.")
// @TypeSpec.Rest.actionSeparator("/")
// @action("completions")
// @convenientAPI(true)
// op getCompletionsStreaming is Azure.Core.ResourceAction<Deployment, CompletionsOptions, Completions>;

@doc("Get chat completions for the provided chat context messages.")
@TypeSpec.Rest.actionSeparator("/")
@action("chat/completions")
@convenientAPI(true)
op getChatCompletions is Azure.Core.ResourceAction<Deployment, ChatCompletionsOptions, ChatCompletions>;

// @doc("Get streaming chat completions for the provided chat context messages.")
// @TypeSpec.Rest.actionSeparator("/")
// @action("chat/completions")
// @convenientAPI(true)
// op getChatCompletionsStreaming is Azure.Core.ResourceAction<Deployment, ChatCompletionsOptions, StreamingChatCompletions>;
