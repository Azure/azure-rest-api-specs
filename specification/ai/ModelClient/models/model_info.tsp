import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ModelClient;

@doc("Represents some basic information about the AI model.")
model ModelInformation {
  @doc("The type of the AI model.")
  model_type: ModelType;

  @doc("The model provider.")
  model_provider: string;

  @doc("The name of the AI model.")
  model_name: string;
}

@doc("The type of AI model")
union ModelType {
  string,

  @doc("Embeddings.")
  embeddings: "embeddings",

  @doc("Custom model.")
  custom: "custom",

  @doc("Chat completions")
  chat: "chat",

  @doc("Text generation")
  text_generation: "text_generation",

  @doc("Image generation")
  image_generation: "image_generation",
}
