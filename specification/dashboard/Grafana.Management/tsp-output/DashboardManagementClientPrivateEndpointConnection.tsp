import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedGrafana.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Dashboard;
@doc("The Private Endpoint Connection resource.")
@parentResource(ManagedGrafana)
model DashboardManagementClientPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The private endpoint connection name of Azure Managed Grafana.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface DashboardManagementClientPrivateEndpointConnections {
  @doc("Get private endpoint connections.")
  get is ArmResourceRead<DashboardManagementClientPrivateEndpointConnection>;
  @doc("Manual approve private endpoint connection")
  approve is ArmResourceCreateOrUpdateAsync<DashboardManagementClientPrivateEndpointConnection>;
  @doc("Delete private endpoint connection")
  delete is ArmResourceDeleteWithoutOkAsync<DashboardManagementClientPrivateEndpointConnection>;
  @doc("Get private endpoint connection")
  list is ArmResourceListByParent<DashboardManagementClientPrivateEndpointConnection>;
}
