import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedGrafana.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Grafana;
@doc("The Private Endpoint Connection resource.")
@parentResource(ManagedGrafana)
model GrafanaPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The private endpoint connection name of Azure Managed Grafana.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface GrafanaPrivateEndpointConnections {
  @doc("Get private endpoint connections.")
  get is ArmResourceRead<GrafanaPrivateEndpointConnection>;
  @doc("Manual approve private endpoint connection")
  approve is ArmResourceCreateOrUpdateAsync<GrafanaPrivateEndpointConnection>;
  @doc("Delete private endpoint connection")
  delete is ArmResourceDeleteWithoutOkAsync<GrafanaPrivateEndpointConnection>;
  @doc("Get private endpoint connection")
  list is ArmResourceListByParent<GrafanaPrivateEndpointConnection>;
}
