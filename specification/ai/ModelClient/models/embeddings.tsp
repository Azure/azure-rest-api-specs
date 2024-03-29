import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace ModelClient;

@doc("""
The configuration information for an embeddings request.
Embeddings measure the relatedness of text strings and are commonly used for search, clustering,
recommendations, and other similar scenarios.
""")
model EmbeddingsOptions {
  @doc("""
    Input texts to get embeddings for, encoded as a an array of strings.
    Each input must not exceed 2048 tokens in length.

    Unless you are embedding code, we suggest replacing newlines (\\n) in your input with a single space,
    as we have observed inferior results when newlines are present.
    """)
  input: string[];

  @encodedName("application/json", "encoding_format")
  @doc("The response encoding format to use for embedding data.")
  encodingFormat?: EmbeddingEncodingFormat = EmbeddingEncodingFormat.float;

  @doc("Specifies the input type to use for embedding search.")
  @encodedName("application/json", "input_type")
  inputType?: EmbeddingInputType = EmbeddingInputType.text;
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

@doc("Represents the available formats for embeddings data on responses.")
enum EmbeddingEncodingFormat {
  @doc("Specifies that responses should provide arrays of floats for each embedding.")
  float: "float",

  @doc("Specifies that responses should provide a base64-encoded string for each embedding.")
  base64: "base64",
}

@doc("Represents the input types used for embedding search.")
enum EmbeddingInputType {
  @doc("fill me.")
  text: "text",

  @doc("fill me.")
  query: "query",

  @doc("fill me.")
  document: "document",
}

@doc("Representation of a single embeddings relatedness comparison.")
model EmbeddingItem {
  @doc("""
    List of embeddings value for the input prompt. These represent a measurement of the
    vector-based relatedness of the provided input.
    """)
  embedding: float32[];

  @doc("Index of the prompt to which the EmbeddingItem corresponds.")
  index: int32;
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
