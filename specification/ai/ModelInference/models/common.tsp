import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ModelInference;

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

  @doc("A model capable of generating embeddings from a text")
  embeddings: "embeddings",

  @doc("A model capable of taking chat-formatted messages and generate responses")
  chat_completion: "chat-completion",
}

alias AdditionalRequestHeaders = {
  @doc("""
    Controls what happens if extra parameters, undefined by the REST API,
    are passed in the JSON request payload.
    This sets the HTTP request header `extra-parameters`.
    """)
  @header("extra-parameters")
  extra_params?: ExtraParameters;
};

@doc("Controls what happens if extra parameters, undefined by the REST API, are passed in the JSON request payload.")
union ExtraParameters {
  string,

  @doc("The service will error if it detected extra parameters in the request payload. This is the service default.")
  error: "error",

  @doc("The service will ignore (drop) extra parameters in the request payload. It will only pass the known parameters to the back-end AI model.")
  drop: "drop",

  @doc("The service will pass extra parameters to the back-end AI model.")
  pass_through: "pass-through",
}
