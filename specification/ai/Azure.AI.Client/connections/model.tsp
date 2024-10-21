import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@typespec/versioning";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Client;

@doc("Response from the listSecrets operation")
model ConnectionsListSecretsResponse {

  @doc("A unique identifier for the connection")
  id: string;

  @doc("The name of the resource")
  name: string;

  @doc("The properties of the resource")
  properties: ConnectionProperties;
}

@doc("Response from the list operation")
model ConnectionsListResponse {
  @doc("A list of connection list secrets")
  value: ConnectionsListSecretsResponse[];
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator"
@doc("Connection properties")
@discriminator("authType")
model ConnectionProperties {
  @doc("Authentication type of the connection target")
  authType: AuthenticationType;
}

#suppress "@azure-tools/typespec-azure-core/no-enum"
@doc("Authentication type used by Azure AI service to connect to another service")
enum AuthenticationType {
  @doc("API Key authentication")
  apiKey: "ApiKey",

  @doc("Entra ID authentication")
  AAD: "AAD",

  @doc("Shared Access Signature (SAS) authentication")
  SAS: "SAS",
}

@doc("Connection properties for connections with API key authentication")
model ConnectionPropertiesApiKeyAuth extends ConnectionProperties {
  @doc("Authentication type of the connection target")
  authType: AuthenticationType.apiKey;

  @doc("Category of the connection")
  category: ConnectionType;

  @doc("Credentials will only be present for authType=ApiKey")
  credentials: CredentialsApiKeyAuth;

  @doc("The connection URL to be used for this service")
  target: string;

  //@doc("to do")
  //metadata: PropertiesMetadata;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Connection properties for connections with AAD authentication (aka `Entra ID passthrough`)")
model ConnectionPropertiesAADAuth extends ConnectionProperties {
  @doc("Authentication type of the connection target")
  authType: AuthenticationType.AAD;

  @doc("Category of the connection")
  category: ConnectionType;

  @doc("The connection URL to be used for this service")
  target: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Connection properties for connections with SAS authentication")
model ConnectionPropertiesSASAuth extends ConnectionProperties {
  @doc("Authentication type of the connection target")
  authType: AuthenticationType.SAS;

  @doc("Category of the connection")
  category: ConnectionType;

  @doc("Credentials will only be present for authType=ApiKey")
  credentials: CredentialsSASAuth;

  @doc("The connection URL to be used for this service")
  target: string;
}

@doc("The credentials needed for API key authentication")
model CredentialsApiKeyAuth {
  @doc("The API key")
  key: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("The credentials needed for Shared Access Signatures (SAS) authentication")
model CredentialsSASAuth {
  @doc("The Shared Access Signatures (SAS) token")
  SAS: string;
}

// https://learn.microsoft.com/rest/api/azureml/workspace-connections/list-secrets?view=rest-azureml-2024-04-01&tabs=HTTP#ConnectionType
#suppress "@azure-tools/typespec-azure-core/no-enum"
@doc("The Type (or category) of the connection")
enum ConnectionType {
  @doc("Azure OpenAI service")
  AzureOpenAI: "AzureOpenAI", //TODO: In Python this results in .AZURE_OPEN_AI. How do I make it .AZURE_OPENAI?

  @doc("Serverless API service")
  Serverless: "Serverless",

  @doc("Azure Blob Storage")
  AzureBlobStorage: "AzureBlob",

  @doc("Azure AI Services")
  AIServices: "AIServices",
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
