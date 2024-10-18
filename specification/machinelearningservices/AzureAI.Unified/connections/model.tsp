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

namespace Microsoft.MachineLearningServices;

@doc("Connection Definition")
model Connection {
  @doc("Name of the connection")
  @visibility("read")
  name: string;

  @doc("The type of connection, such as AzureOpenAI, AIServices, AISearch, etc.")
  @visibility("read")
  type: string;

  @doc("The URL of the external resource being connected to.")
  target: string;

  @doc("The URL of the external resource being connected to.")
  credentials: Credential;

  @doc("Metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Paged collection of Connection items.")
@pagedResult
model PagedConnection {
  @doc("The list of Connections.")
  @extension("x-ms-identifiers", [])
  @items
  value: Connection[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: ResourceLocation<Connection>;
}
