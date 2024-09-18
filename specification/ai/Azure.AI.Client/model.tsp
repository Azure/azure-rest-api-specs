import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "@typespec/openapi";
import "@typespec/versioning";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Client;

@doc("to do")
model ListSecretsResponse {
  @doc("to do")
  properties: ListSecretsProperties;
}

@doc("to do")
model ListSecretsProperties {
  @doc("to do")
  authType: ConnectionAuthType;

  @doc("Credentials will only be present for authType=ApiKey")
  credentials?: ListSecretsPropertiesCredentials;

  @doc("to do")
  target: string;

  @doc("to do")
  metadata: PropertiesMetadata;
}

@doc("to do")
model ListSecretsPropertiesCredentials {
  @doc("to do")
  key: string;
}

#suppress "@azure-tools/typespec-azure-core/no-enum" "Azure services should not use the enum keyword. Extensible enums should be defined as unions with `string` as an accepted variant"
@doc("to do")
enum ConnectionAuthType {
  @doc("to do")
  apiKey: "ApiKey",

  @doc("to do")
  aad: "AAD",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Property types must use camelCase"
@doc("Metadata on the properties")
model PropertiesMetadata {
  @doc("The name of the AI model. For example: `Phi21`")
  model_name?: string;

  @doc("The type of the AI model. A Unique identifier for the profile.")
  model_type?: ModelType;

  @doc("The model provider name. For example: `Microsoft Research`")
  model_provider_name?: string;
}

@doc("The type of AI model")
union ModelType {
  string,

  @doc("A model capable of generating embeddings from a text")
  embeddings: "embeddings",

  @doc("A model capable of generating images from an image and text description")
  image_generation: "image_generation",

  @doc("A text generation model")
  text_generation: "text_generation",

  @doc("A model capable of generating embeddings from an image")
  image_embeddings: "image_embeddings",

  @doc("A text-to-audio generative model")
  audio_generation: "audio_generation",

  @doc("A model capable of taking chat-formatted messages and generate responses")
  chat_completion: "chat_completion",
}
