import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

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
  user?: string;

  @doc("""
    The model name to provide as part of this embeddings request.
    Not applicable to Azure OpenAI, where deployment information should be included in the Azure
    resource URI that's connected to.
    """)
  @clientName("DeploymentName", "csharp")
  `model`?: string;

  @doc("""
    Input texts to get embeddings for, encoded as a an array of strings.
    Each input must not exceed 2048 tokens in length.
    
    Unless you are embedding code, we suggest replacing newlines (\\n) in your input with a single space,
    as we have observed inferior results when newlines are present.
    """)
  input: string[];

  @encodedName("application/json", "encoding_format")
  @added(ServiceApiVersions.v2024_03_01_Preview)
  @doc("The response encoding format to use for embedding data.")
  encodingFormat?: EmbeddingEncodingFormat = EmbeddingEncodingFormat.float;

  @added(ServiceApiVersions.v2024_03_01_Preview)
  @doc("The number of dimensions the resulting output embeddings should have. Only supported in `text-embedding-3` and later models.")
  dimensions?: int32;

  @doc("When using Azure OpenAI, specifies the input type to use for embedding search.")
  @added(ServiceApiVersions.v2024_02_15_Preview)
  @encodedName("application/json", "input_type")
  inputType?: string;
}

@doc("Represents the available formats for embeddings data on responses.")
@added(ServiceApiVersions.v2024_03_01_Preview)
union EmbeddingEncodingFormat {
  string,

  @doc("Specifies that responses should provide arrays of floats for each embedding.")
  float: "float",

  @doc("Specifies that responses should provide a base64-encoded string for each embedding.")
  base64: "base64",
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
  @clientName("promptIndex", "java")
  index: int32;

  @doc("The object type which is always 'embedding'.")
  @added(ServiceApiVersions.v2024_07_01_Preview)
  object: "embedding";
}

@doc("Measurement of the amount of tokens used in this request and response.")
model EmbeddingsUsage {
  @doc("Number of tokens sent in the original request.")
  @encodedName("application/json", "prompt_tokens")
  promptTokens: int32;

  @doc("Total number of tokens transacted in this request/response.")
  @encodedName("application/json", "total_tokens")
  totalTokens: int32;
}

/**
 * Get embeddings request body.
 */
model GetEmbeddingsBody {
  /**
   * The configuration information for an embeddings request.
   * Embeddings measure the relatedness of text strings and are commonly used for search, clustering,
   * recommendations, and other similar scenarios.
   */
  @bodyRoot
  body: EmbeddingsOptions;
}
