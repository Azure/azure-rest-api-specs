import "@typespec/rest";
import "@typespec/http";

import "./embeddings.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ModelInference;

@doc("""
  The configuration information for an image embeddings request.
  """)
model ImageEmbeddingsOptions {
  @doc("""
    Input image to embed. To embed multiple inputs in a single request, pass an array.
    The input must not exceed the max input tokens for the model.
    """)
  input: ImageEmbeddingInput[];

  @doc("""
    Optional. The number of dimensions the resulting output embeddings should have.
    Passing null causes the model to use its default value.
    Returns a 422 error if the model doesn't support the value or parameter.
    """)
  dimensions?: int32;

  @doc("""
    Optional. The number of dimensions the resulting output embeddings should have.
    Passing null causes the model to use its default value.
    Returns a 422 error if the model doesn't support the value or parameter.
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

@doc("Represents an image with optional text.")
model ImageEmbeddingInput {
  @doc("""
    The input image encoded in base64 string as a data URL. Example: `data:image/{format};base64,{data}`.
    """)
  image: string;

  @doc("""
    Optional. The text input to feed into the model (like DINO, CLIP).
    Returns a 422 error if the model doesn't support the value or parameter.
    """)
  text?: string;
}
