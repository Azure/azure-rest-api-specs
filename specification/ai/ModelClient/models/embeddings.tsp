import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ModelClient;

alias EmbeddingsOptions = {
  ...ExtraRequestParameters;

  @doc("Input texts to get embeddings for, encoded as a an array of strings.")
  input: string[];

  @doc("Specifies the input type to use for embedding search.")
  input_type?: EmbeddingInputType;
};

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
  object: string;

  @doc("The model ID used to generate this result.")
  `model`: string;
}

@doc("Represents the input types used for embedding search.")
union EmbeddingInputType {
  string,

  @doc("to do")
  text: "text",

  @doc("to do")
  query: "query",

  @doc("to do")
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

  @doc("The object type of this embeddings item. Will always be `embedding`.")
  object: string;
}

@doc("Measurement of the amount of tokens used in this request and response.")
model EmbeddingsUsage {
  ...CapacityAlias;

  @doc("Number of tokens in the request prompt.")
  input_tokens: int32;

  @doc("""
  Number of tokens used for the prompt sent to the AI model. Typically identical to `input_tokens`.
  However, certain AI models may add extra tokens to the input hence the number can be higher.
  (for example when input_type="query").
  """)
  prompt_tokens: int32;

  @doc("Total number of tokens transacted in this request/response.")
  total_tokens: int32;
}
