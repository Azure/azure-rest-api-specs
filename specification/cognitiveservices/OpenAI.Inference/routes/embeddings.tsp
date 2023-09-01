import "@typespec/rest";

import "../models/embeddings.create.tsp";

using TypeSpec.Rest;
using Azure.Core;

namespace Azure.OpenAI;

@doc("Return the embeddings for a given prompt.")
@actionSeparator("/")
@action("embeddings") //@convenientAPI(true)
op getEmbeddings is Azure.Core.ResourceAction<
    Deployment,
    EmbeddingsOptions,
    Embeddings
>;
