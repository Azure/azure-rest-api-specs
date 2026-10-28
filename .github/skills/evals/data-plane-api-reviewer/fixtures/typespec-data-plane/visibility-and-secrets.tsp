import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service(#{ title: "Connector Registry" })
@versioned(Versions)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://connectorregistry.azure.com/.default"],
    }
  ]>
)
@server("https://{endpoint}", "Connector Registry service", { endpoint: string })
namespace ConnectorRegistry;

enum Versions {
  v2026_01_01: "2026-01-01",
}

@doc("A registered connector.")
@resource("connectors")
model Connector {
  @doc("The unique name of the connector.")
  @key
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Endpoint the connector targets.")
  targetEndpoint: url;

  @doc("API key used to authenticate to the target endpoint.")
  apiKey: string;

  @doc("Connection string used to reach the target data store.")
  connectionString: string;

  @doc("Display name shown for this connector in the portal.")
  @visibility(Lifecycle.Create, Lifecycle.Update)
  friendlyName: string;

  @doc("When the connector was registered.")
  createdAt: utcDateTime;

  @doc("Entity tag for optimistic concurrency.")
  etag: string;

  @doc("Optional description of the connector.")
  description?: string | null;
}

interface Connectors {
  @doc("Gets a connector.")
  get is StandardResourceOperations.ResourceRead<Connector>;

  @doc("Creates or updates a connector.")
  createOrUpdate is StandardResourceOperations.ResourceCreateOrUpdate<Connector>;

  @doc("Deletes a connector and revokes its stored credentials.")
  delete is StandardResourceOperations.ResourceDelete<Connector>;

  @doc("Lists connectors.")
  list is StandardResourceOperations.ResourceList<Connector>;
}
