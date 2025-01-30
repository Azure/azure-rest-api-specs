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

namespace Azure.AI.Unified;

@doc("Response from the listSecrets operation")
@discriminator("authType")
model Connection {
  @doc("A unique identifier for the connection")
  id: string;

  @doc("The name of the resource")
  name: string;

  @doc("Authentication type of the connection target")
  authType: AuthenticationType;

  @doc("Category of the connection")
  category: ConnectionType;

  @doc("The connection URL to be used for this service")
  target: string;
}

@doc("Paged collection of ModelVersion items.")
@pagedResult
model PagedConnection {
  @doc("The list of connections.")
  @extension("x-ms-identifiers", [])
  @items
  value: Connection[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: ResourceLocation<Connection>;
}

#suppress "@azure-tools/typespec-azure-core/no-enum"
@doc("Authentication type used by Azure AI service to connect to another service")
enum AuthenticationType {
  @doc("API Key authentication")
  apiKey: "ApiKey",

  @doc("Entra ID authentication (formerly known as AAD)")
  entraId: "AAD",

  @doc("Shared Access Signature (SAS) authentication")
  SAS: "SAS",
}

@doc("Connection properties for connections with API key authentication")
model ApiKeyConnection extends Connection {
  @doc("Authentication type of the connection target")
  authType: AuthenticationType.apiKey;

  @doc("Credentials will only be present for authType=ApiKey")
  credentials: CredentialsApiKeyAuth;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Connection properties for connections with AAD authentication (aka `Entra ID passthrough`)")
model EntraIDConnection extends Connection {
  @doc("Authentication type of the connection target")
  authType: AuthenticationType.entraId;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Connection properties for connections with SAS authentication")
model SASConnection extends Connection {
  @doc("Authentication type of the connection target")
  authType: AuthenticationType.SAS;

  @doc("Credentials will only be present for authType=ApiKey")
  credentials: CredentialsSASAuth;
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
  @doc("Azure OpenAI Service")
  AzureOpenAI: "AzureOpenAI", //TODO: In Python this results in .AZURE_OPEN_AI. How do I make it .AZURE_OPENAI?

  @doc("Serverless API Service")
  Serverless: "Serverless",

  @doc("Azure Blob Storage")
  AzureBlobStorage: "AzureBlob",

  @doc("Azure AI Services")
  AzureAIServices: "AIServices",

  @doc("Azure AI Search")
  AzureAISearch: "CognitiveSearch",
}
