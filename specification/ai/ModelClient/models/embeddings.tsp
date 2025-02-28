import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace AI.Model;

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
