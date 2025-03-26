import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@typespec/versioning";
import "../credentials/models.tsp";

using TypeSpec.Rest;

namespace Azure.AI.Projects;

@doc("Response from the listSecrets operation")
@resource("connections")
model Connection {
  @doc("The name of the resource")
  @visibility(Lifecycle.Read)
  @key("connectionName")
  name: string;

  @doc("Category of the connection")
  @visibility(Lifecycle.Read)
  type: ConnectionType;

  @doc("The connection URL to be used for this service")
  @visibility(Lifecycle.Read)
  target: string;

  @doc("Metadata of the connection")
  metadata: Record<string>;
}

// https://learn.microsoft.com/rest/api/azureml/workspace-connections/list-secrets?view=rest-azureml-2024-04-01&tabs=HTTP#ConnectionType
@doc("The Type (or category) of the connection")
union ConnectionType {
  string,

  @doc("Azure OpenAI Service")
  AzureOpenAI: "AzureOpenAI", //TODO: In Python this results in .AZURE_OPEN_AI. How do I make it .AZURE_OPENAI?

  @doc("Azure Blob Storage")
  AzureBlobStorage: "AzureBlob",

  @doc("Azure AI Search")
  AzureAISearch: "CognitiveSearch",

  @doc("CosmosDB")
  CosmosDB: "CosmosDB",

  @doc("Generic connection that uses API Key authentication")
  APIKey: "ApiKey",

  @doc("Application Insights")
  ApplicationInsights: "AppInsights",

  @doc("Custom Keys")
  Custom: "CustomKeys",
}
