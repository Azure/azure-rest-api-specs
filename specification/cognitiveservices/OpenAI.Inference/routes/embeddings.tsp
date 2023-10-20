import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../models/embeddings_create.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

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
