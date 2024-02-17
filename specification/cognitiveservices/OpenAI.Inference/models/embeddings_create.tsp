import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.OpenAI;

@doc("""
The configuration information for an embeddings request.
Embeddings measure the relatedness of text strings and are commonly used for search, clustering,
recommendations, and other similar scenarios.
""")
model EmbeddingsOptions {
  @doc("""
    An identifier for the caller or end user of the operation. This may be used for tracking
    or rate-limiting purposes.
    """)
  @projectedName("json", "user")
  user?: string;

  @doc("""
    The model name to provide as part of this embeddings request.
    Not applicable to Azure OpenAI, where deployment information should be included in the Azure
    resource URI that's connected to.
    """)
  @projectedName("json", "model")
  @projectedName("csharp", "DeploymentName")
  `model`?: string;

  @doc("""
    Input texts to get embeddings for, encoded as a an array of strings.
    Each input must not exceed 2048 tokens in length.

    Unless you are embedding code, we suggest replacing newlines (\\n) in your input with a single space,
    as we have observed inferior results when newlines are present.
    """)
  input: string[];
}

@doc("""
Representation of the response data from an embeddings request.
Embeddings measure the relatedness of text strings and are commonly used for search, clustering,
recommendations, and other similar scenarios.
""")
model Embeddings {
  @doc("Embedding values for the prompts submitted in the request.")
  data: EmbeddingItem[];

  @doc("Usage counts for tokens input using the embeddings API.")
  usage: EmbeddingsUsage;
}

@doc("Representation of a single embeddings relatedness comparison.")
model EmbeddingItem {
  @doc("""
    List of embeddings value for the input prompt. These represent a measurement of the
    vector-based relatedness of the provided input.
    """)
  embedding: float32[];

  @doc("Index of the prompt to which the EmbeddingItem corresponds.")
  @projectedName("java", "promptIndex")
  index: int32;
}

@doc("Measurement of the amount of tokens used in this request and response.")
model EmbeddingsUsage {
  @doc("Number of tokens sent in the original request.")
  @projectedName("json", "prompt_tokens")
  promptTokens: int32;

  @doc("Total number of tokens transacted in this request/response.")
  @projectedName("json", "total_tokens")
  totalTokens: int32;
}
