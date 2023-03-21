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

@doc("Return the embeddings for a given prompt.")
@TypeSpec.Rest.actionSeparator("/")
@action("embeddings")
@convenientAPI(true)
op getEmbeddings is Azure.Core.ResourceAction<Deployment, Embeddings.EmbeddingsOptions, Embeddings.Embeddings>;

@doc("Return the completions for a given prompt.")
@TypeSpec.Rest.actionSeparator("/")
@action("completions")
@convenientAPI(true)
op getCompletions is Azure.Core.ResourceAction<Deployment, Completions.CompletionsOptions, Completions.Completions>;

@doc("Get chat completions for the provided chat context messages.")
@TypeSpec.Rest.actionSeparator("/")
@convenientAPI(true)
op getChatCompletions is Azure.Core.ResourceAction<Deployment, ChatCompletions.ChatCompletionsOptions, ChatCompletions.ChatCompletions>;