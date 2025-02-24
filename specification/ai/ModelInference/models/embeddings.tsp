import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ModelInference;

@doc("Represents the input types used for embedding search.")
union EmbeddingInputType {
  string,

  @doc("Indicates the input is a general text input.")
  text: "text",

  @doc("Indicates the input represents a search query to find the most relevant documents in your vector database.")
  query: "query",

  @doc("Indicates the input represents a document that is stored in a vector database.")
  document: "document",
}

@doc("""
  Specifies the types of embeddings to generate. Compressed embeddings types like `uint8`, `int8`, `ubinary` and 
  `binary`, may reduce storage costs without sacrificing the integrity of the data. Returns a 422 error if the
  model doesn't support the value or parameter. Read the model's documentation to know the values supported by
  the your model.
  """)
union EmbeddingEncodingFormat {
  string,

  @doc("""
    Get back binary representation of the embeddings encoded as Base64 string. OpenAI Python library retrieves 
    embeddings from the API as encoded binary data, rather than using intermediate decimal representations as is 
    usually done.
    """)
  base64: "base64",

  @doc("Get back signed binary embeddings")
  binary: "binary",

  @doc("Get back full precision embeddings")
  float: "float",

  @doc("Get back signed int8 embeddings")
  int8: "int8",

  @doc("Get back unsigned binary embeddings")
  ubinary: "ubinary",

  @doc("Get back unsigned int8 embeddings")
  uint8: "uint8",
}

@doc("""
  Representation of the response data from an embeddings request.
  Embeddings measure the relatedness of text strings and are commonly used for search, clustering,
  recommendations, and other similar scenarios.
  """)
model EmbeddingsResult {
  @doc("Unique identifier for the embeddings result.")
  id: string;

  @doc("Embedding values for the prompts submitted in the request.")
  data: EmbeddingItem[];

  @doc("Usage counts for tokens input using the embeddings API.")
  usage: EmbeddingsUsage;

  @doc("The object type of the embeddings result. Will always be `list`.")
  object: "list";

  @doc("The model ID used to generate this result.")
  `model`: string;
}

@doc("Representation of a single embeddings relatedness comparison.")
model EmbeddingItem {
  @doc("""
    List of embedding values for the input prompt. These represent a measurement of the
    vector-based relatedness of the provided input. Or a base64 encoded string of the embedding vector.
    """)
  embedding: float32[];

  @doc("Index of the prompt to which the EmbeddingItem corresponds.")
  index: int32;

  @doc("The object type of this embeddings item. Will always be `embedding`.")
  object: "embedding";
}

@doc("Measurement of the amount of tokens used in this request and response.")
model EmbeddingsUsage {
  @doc("Number of tokens in the request.")
  prompt_tokens: int32;

  @doc("""
    Total number of tokens transacted in this request/response. Should equal the
    number of tokens in the request.
    """)
  total_tokens: int32;
}

@doc("""
  The configuration information for an embeddings request.
  """)
model EmbeddingsOptions {
  @doc("""
    Input text to embed, encoded as a string or array of tokens.
    To embed multiple inputs in a single request, pass an array
    of strings or array of token arrays.
    """)
  input: string[];

  @doc("""
    Optional. The number of dimensions the resulting output embeddings should have.
    Passing null causes the model to use its default value.
    Returns a 422 error if the model doesn't support the value or parameter.
    """)
  dimensions?: int32;

  @doc("""
    Optional. The desired format for the returned embeddings.
    """)
  encoding_format?: EmbeddingEncodingFormat;

  @doc("""
    Optional. The type of the input.
    Returns a 422 error if the model doesn't support the value or parameter.
    """)
  input_type?: EmbeddingInputType;

  @doc("""
    ID of the specific AI model to use, if more than one model is available on the endpoint.
    """)
  `model`?: string;

  ...Record<unknown>;
}
