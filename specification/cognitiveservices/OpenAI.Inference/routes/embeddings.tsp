import "@typespec/rest";

import "../models/embeddings_create.tsp";

using TypeSpec.Rest;
using Azure.Core;

namespace Azure.OpenAI;

@doc("Return the embeddings for a given prompt.")
@actionSeparator("/")
@action("embeddings") //@convenientAPI(true)
op getEmbeddings is AOAIDeploymentAction<EmbeddingsOptions, Embeddings>;
