import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ModelClient;

alias ImageEmbeddingsOptions = {
  @doc("""
  Input image to embed. To embed multiple inputs in a single request, pass an array.
  The input must not exceed the max input tokens for the model.
  """)
  input: EmbeddingInput[];

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
};

@doc("Represents an image with optional text.")
model EmbeddingInput {
  @doc("""
  The input image, in PNG format.
  """)
  image: string;

  @doc("""
  Optional. The text input to feed into the model (like DINO, CLIP).
  Returns a 422 error if the model doesn't support the value or parameter.
  """)
  text?: string;
}
