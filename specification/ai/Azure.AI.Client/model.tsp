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
model ConnectionDetails {
  @doc("The name of the resource")
  name: string;

  @doc("The properties of the resouce")
  properties: ConnectionProperties;
}

@doc("to do")
model ConnectionDetailsList {
  @doc("to do")
  value: ConnectionDetails[];
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator"
@doc("to do")
@discriminator("authType")
model ConnectionProperties {
  @doc("Authentication type of the connection target")
  authType: AuthType;
}

#suppress "@azure-tools/typespec-azure-core/no-enum"
@doc("to do")
enum AuthType {
  @doc("to do")
  apiKey: "ApiKey",

  @doc("to do")
  AAD: "AAD",

  @doc("to do")
  SAS: "SAS",
}

@doc("Connection properties for connections with API key authentication")
model ConnectionPropertiesApiKeyAuth extends ConnectionProperties {
  @doc("Authentication type of the connection target")
  authType: AuthType.apiKey;

  @doc("Category of the connection")
  category: ConnectionCategory;

  @doc("Credentials will only be present for authType=ApiKey")
  credentials: CredentialsApiKeyAuth;

  @doc("to do")
  target: string;

  //@doc("to do")
  //metadata: PropertiesMetadata;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Connection properties for connections with AAD authentication (aka `Entra ID passthrough`)")
model ConnectionPropertiesAADAuth extends ConnectionProperties {
  @doc("Authentication type of the connection target")
  authType: AuthType.AAD;

  @doc("Category of the connection")
  category: ConnectionCategory;

  @doc("to do")
  target: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Connection properties for connections with SAS authentication")
model ConnectionPropertiesSASAuth extends ConnectionProperties {
  @doc("Authentication type of the connection target")
  authType: AuthType.SAS;

  @doc("Category of the connection")
  category: ConnectionCategory;

  @doc("Credentials will only be present for authType=ApiKey")
  credentials: CredentialsSASAuth;

  @doc("to do")
  target: string;
}

@doc("to do")
model CredentialsApiKeyAuth {
  @doc("to do")
  key: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("to do")
model CredentialsSASAuth {
  @doc("to do")
  SAS: string;
}

// https://learn.microsoft.com/rest/api/azureml/workspace-connections/list-secrets?view=rest-azureml-2024-04-01&tabs=HTTP#connectioncategory
#suppress "@azure-tools/typespec-azure-core/no-enum"
@doc("Category of the connection")
enum ConnectionCategory {
  @doc("Azure OpenAI")
  AzureOpenAI: "AzureOpenAI",

  @doc("Serverless API")
  Serverless: "Serverless",
}

/*
#suppress "@azure-tools/typespec-azure-core/casing-style"
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
*/
