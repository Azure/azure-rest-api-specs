import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ModelClient;

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

@doc("""
The format of the embeddings result.
Returns a 422 error if the model doesn't support the value or parameter.
""")
union EmbeddingEncodingFormat {
  string,

  @doc("Base64")
  base64: "base64",

  @doc("Binary")
  binary: "binary",

  @doc("Floating point")
  float: "float",

  @doc("Signed 8-bit integer")
  int8: "int8",

  @doc("ubinary")
  ubinary: "ubinary",

  @doc("Unsigned 8-bit integer")
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

  //@doc("The object type of the embeddings result. Will always be `list`.")
  //object: string;

  @doc("The model ID used to generate this result.")
  `model`: string;
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

  //@doc("The object type of this embeddings item. Will always be `embedding`.")
  //object: string;
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
  Name of the deployment to which you would like to route the request. Relevant only to Model-as-a-Platform (MaaP) deployments.
  Typically used when you want to target a test environment instead of production environment.
  This sets the HTTP request header `azureml-model-deployment`.
  """)
  @header("azureml-model-deployment")
  model_deployment?: string;

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

  @doc("The service will error if it detected unknown parameters in the request payload. This is the default.")
  error: "error",

  @doc("The service will ignore (drop) unknown parameters in the request payload. It will only pass the known parameters to the back-end AI model.")
  ignore: "ignore",

  @doc("The service will pass unknown parameters to the back-end AI model.")
  allow: "allow",
}

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
