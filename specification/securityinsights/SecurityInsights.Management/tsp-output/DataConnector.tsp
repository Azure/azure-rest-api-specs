import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;
// FIXME: DataConnector has no properties property
@doc("Data connector")
model DataConnector is ProxyResource<{}> {
  @doc("Connector ID")
  @path
  @key("dataConnectorId")
  @segment("dataConnectors")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DataConnectors {
  @doc("Gets a data connector.")
  get is ArmResourceRead<DataConnector>;
  @doc("Creates or updates the data connector.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DataConnector>;
  @doc("Delete the data connector.")
  delete is ArmResourceDeleteSync<DataConnector>;
  @doc("Gets all data connectors.")
  list is ArmResourceListByParent<DataConnector>;
  @doc("Connects a data connector.")
  connect is ArmResourceActionSync<DataConnector, DataConnectorConnectBody, {}>;
  @doc("Disconnect a data connector.")
  disconnect is ArmResourceActionSync<DataConnector, {}, {}>;
}
