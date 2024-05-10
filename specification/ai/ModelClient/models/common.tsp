import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ModelClient;

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

@doc("Defines the service behavior when extra parameters are passed in the request payload.")
union ExtraParameters {
  string,

  @doc("The service should error when it sees extra parameters in the request payload. This is the default behavior if the service.")
  error: "error",

  @doc("The service should ignore extra parameters in the request payload. They will not be passed to the back-end AI model.")
  ignore: "ignore",

  @doc("The service should pass extra parameters to the back-end AI model.")
  allow: "allow",
}

alias AdditionalRequestHeaders = {
  @doc("""
  Name of the deployment to which you would like to route the request. Relevant only to Model-as-a-Platform (MaaP) deployments.
  Typically used when you want to target a test environment instead of production environment.
  """)
  @header("azureml-model-deployment")
  model_deployment?: string;
};

alias CapacityAlias = {
  @doc("Indicates whether your capacity has been affected by the usage amount (token count) reported here.")
  capacity_type: CapacityType;
};

@doc("Whether your capacity has been affected by the usage amount (token count) reported here.")
union CapacityType {
  string,

  @doc("Your capacity has been affected by the usage amount (token count) reported here.")
  usage: "usage",

  @doc("Your capacity has not been affected by the usage amount (token count) reported here.")
  fixed: "fixed",
}

alias ExtraRequestParameters = {
  @doc("""
  Extra parameters (in the form of string key-value pairs) that are not in the standard request payload.
  They will be passed to the service as-is in the root of the JSON request payload.
  How the service handles these extra parameters depends on the value of the `extra-parameters`
  HTTP request header.
  """)
  extras?: Record<string>;
};
