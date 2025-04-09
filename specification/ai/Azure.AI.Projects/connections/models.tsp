import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("Response from the list and get connections operations")
@resource("connections")
@discriminator("authType")
@added(Versions.v2025_05_01)
model Connection {

  @doc("The authentication type used by the connection")
  @visibility(Lifecycle.Read)
  authType: AuthenticationType;

  @doc("The name of the resource")
  @visibility(Lifecycle.Read)
  @key("name")
  name: string;

  @doc("Category of the connection")
  @visibility(Lifecycle.Read)
  type: ConnectionType;

  @doc("The connection URL to be used for this service")
  @visibility(Lifecycle.Read)
  target: string;

  @doc("Whether the connection is tagged as the default connection of its type")
  @visibility(Lifecycle.Read)
  isDefault: boolean;

  @doc("Metadata of the connection")
  @visibility(Lifecycle.Read)
  metadata: Record<string>;
}

@doc("A connection with API key authentication")
model ConnectionWithApiKeyAuth extends Connection {

  @doc("The authentication type used by the connection")
  @visibility(Lifecycle.Read)
  authType: AuthenticationType.apiKey;

  @doc("The credentials for api-key authentication")
  @visibility(Lifecycle.Read)
  credentials: CredentialsApiKeyAuth;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("A connection with EntraID authentication (aka `Entra ID passthrough`)")
model ConnectionWithEntraIDAuth extends Connection {

  @doc("The authentication type used by the connection")
  @visibility(Lifecycle.Read)
  authType: AuthenticationType.entraId;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("A connection with custom authentication")
model ConnectionWithCustomAuth extends Connection {

  @doc("The authentication type used by the connection")
  @visibility(Lifecycle.Read)
  authType: AuthenticationType.custom;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("A connection with Shared Access Signature (SAS) authentication")
model ConnectionWithSASAuth extends Connection {

  @doc("The authentication type used by the connection")
  @visibility(Lifecycle.Read)
  authType: AuthenticationType.SAS;

  @doc("The credentials for SAS authentication")
  @visibility(Lifecycle.Read)
  credentials: CredentialsSASAuth;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("A connection with no authentication")
model ConnectionWithNoAuth extends Connection {

  @doc("The authentication type used by the connection")
  @visibility(Lifecycle.Read)
  authType: AuthenticationType.None;
}

@doc("The credentials needed for API key authentication")
model CredentialsApiKeyAuth {

  @doc("The API key")
  @visibility(Lifecycle.Read)
  key: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("The credentials needed for Shared Access Signatures (SAS) authentication")
model CredentialsSASAuth {

  @doc("The Shared Access Signatures (SAS) token")
  @visibility(Lifecycle.Read)
  SAS: string;
}


// https://learn.microsoft.com/rest/api/azureml/workspace-connections/list-secrets?view=rest-azureml-2024-04-01&tabs=HTTP#ConnectionType
@doc("The Type (or category) of the connection")
union ConnectionType {
  string,

  @doc("Azure OpenAI Service")
  AzureOpenAI: "AzureOpenAI", //TODO: In Python this results in .AZURE_OPEN_AI. How do I make it .AZURE_OPENAI?

  @doc("Azure Blob Storage, with specified container")
  AzureBlobStorage: "AzureBlob",

  @doc("Azure Blob Storage, with container not specified (used by Assistants)")
  AzureStorageAccount: "AzureStorageAccount",

  @doc("Azure AI Search")
  AzureAISearch: "CognitiveSearch",

  @doc("CosmosDB")
  CosmosDB: "CosmosDB",

  @doc("Generic connection that uses API Key authentication")
  APIKey: "ApiKey",

  @doc("Application Configuration")
  ApplicationConfiguration: "AppConfig",

  @doc("Application Insights")
  ApplicationInsights: "AppInsights",

  @doc("Custom Keys")
  Custom: "CustomKeys",
}

@doc("The authentication type used by the connection")
union AuthenticationType {
  string,

  @doc("API Key authentication")
  apiKey: "ApiKey",

  @doc("Entra ID authentication (formerly known as AAD)")
  entraId: "AAD",

  @doc("Shared Access Signature (SAS) authentication")
  SAS: "SAS",

  @doc("Custom authentication")
  custom: "CustomKeys",

  @doc("No authentication")
  None: "None",
}
