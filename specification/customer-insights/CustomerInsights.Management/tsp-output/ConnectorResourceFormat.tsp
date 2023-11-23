import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CustomerInsights;
@doc("The connector resource format.")
@parentResource(Hub)
model ConnectorResourceFormat is ProxyResource<Connector> {
  @doc("The name of the connector.")
  @path
  @key("connectorName")
  @segment("connectors")
  name: string;
}

@armResourceOperations
interface ConnectorResourceFormats {
  @doc("Gets a connector in the hub.")
  get is ArmResourceRead<ConnectorResourceFormat>;
  @doc("Creates a connector or updates an existing connector in the hub.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ConnectorResourceFormat>;
  @doc("Deletes a connector in the hub.")
  delete is ArmResourceDeleteAsync<ConnectorResourceFormat>;
  @doc("Gets all the connectors in the specified hub.")
  listByHub is ArmResourceListByParent<ConnectorResourceFormat>;
}
