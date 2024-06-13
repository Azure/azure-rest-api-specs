import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace AI.Model;

@doc("Represents some basic information about the AI model.")
model ModelInfo {
  @doc("The name of the AI model. For example: `Phi21`")
  model_name: string;

  @doc("The type of the AI model. A Unique identifier for the profile.")
  model_type: ModelType;

  @doc("The model provider name. For example: `Microsoft Research`")
  model_provider_name: string;
}

@doc("The type of AI model")
union ModelType {
  string,

  @doc("Embeddings.")
  embeddings: "embeddings",

  @doc("Image generation")
  image_generation: "image_generation",

  @doc("Text generation")
  text_generation: "text_generation",

  @doc("Image embeddings")
  image_embeddings: "image_embeddings",

  @doc("Audio generation")
  audio_generation: "audio_generation",

  @doc("Chat completions")
  chat: "chat",
}

alias AdditionalRequestHeaders = {
  @doc("""
  Controls what happens if unknown parameters are passed in the JSON request payload.
  This sets the HTTP request header `unknown-parameters`.
  """)
  @header("unknown-parameters")
  unknown_params?: UnknownParams;
};

@doc("Controls what happens if unknown parameters are passed in the JSON request payload.")
union UnknownParams {
  string,

  @doc("The service will error if it detected unknown parameters in the request payload. This is the service default.")
  error: "error",

  @doc("The service will ignore (drop) unknown parameters in the request payload. It will only pass the known parameters to the back-end AI model.")
  drop: "drop",

  @doc("The service will pass unknown parameters to the back-end AI model.")
  pass_through: "pass_through",
}
