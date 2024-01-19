import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedGrafana.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Dashboard;
@doc("The Private Endpoint Connection resource.")
@parentResource(ManagedGrafana)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The private endpoint connection name of Azure Managed Grafana.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Get private endpoint connections.")
  get is ArmResourceRead<PrivateEndpointConnection>;

  @doc("Manual approve private endpoint connection")
  approve is ArmResourceCreateOrUpdateAsync<
    PrivateEndpointConnection,
    BaseParameters<PrivateEndpointConnection>,
    ArmAsyncOperationHeader
  >;

  @doc("Delete private endpoint connection")
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    BaseParameters<PrivateEndpointConnection>,
    ArmAsyncOperationHeader
  >;

  @doc("Get private endpoint connection")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@projectedName(PrivateEndpointConnections.approve::parameters.resource,
  "json",
  "body"
);
@@extension(PrivateEndpointConnections.approve::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(PrivateEndpointConnections.approve::parameters.resource, "");
