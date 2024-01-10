import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ConnectorResourceFormat.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CustomerInsights;
@doc("The connector mapping resource format.")
@parentResource(ConnectorResourceFormat)
model ConnectorMappingResourceFormat is ProxyResource<ConnectorMapping> {
  @doc("The name of the connector mapping.")
  @key("mappingName")
  @segment("mappings")
  name: string;
}

@armResourceOperations
@projectedName("client", "ConnectorMappings")
interface ConnectorMappingResourceFormats_ConnectorMappings {
  @doc("Gets a connector mapping in the connector.")
  get is ArmResourceRead<ConnectorMappingResourceFormat>;

  @doc("Creates a connector mapping or updates an existing connector mapping in the connector.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConnectorMappingResourceFormat>;

  @doc("Deletes a connector mapping in the connector.")
  delete is ArmResourceDeleteSync<ConnectorMappingResourceFormat>;

  @doc("Gets all the connector mappings in the specified connector.")
  listByConnector is ArmResourceListByParent<ConnectorMappingResourceFormat>;
}
