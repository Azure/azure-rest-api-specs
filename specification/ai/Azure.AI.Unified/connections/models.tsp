import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@typespec/versioning";
import "../credentials/models.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Unified;

@doc("Response from the listSecrets operation")
model Connection {
  @doc("A unique identifier for the connection")
  @visibility("read")
  id: string;

  @doc("The name of the resource")
  @visibility("read")
  name: string;

  @doc("Credential used to connect to the external resource.")
  @visibility("read")
  credentials: BaseCredential;

  @doc("Category of the connection")
  @visibility("read")
  category: ConnectionType;

  @doc("The connection URL to be used for this service")
  @visibility("read")
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
