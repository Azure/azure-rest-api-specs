import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DeviceUpdate;
@doc("The Private Endpoint Connection resource.")
@parentResource(Account)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection associated with the Azure resource")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Get the specified private endpoint connection associated with the device update account.")
  get is ArmResourceRead<PrivateEndpointConnection>;

  @doc("Update the state of specified private endpoint connection associated with the device update account.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    PrivateEndpointConnection,
    BaseParameters<PrivateEndpointConnection>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes the specified private endpoint connection associated with the device update account.")
  delete is ArmResourceDeleteAsync<
    PrivateEndpointConnection,
    BaseParameters<PrivateEndpointConnection>,
    ArmLroLocationHeader
  >;

  @doc("List all private endpoint connections in a device update account.")
  listByAccount is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@projectedName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "json",
  "privateEndpointConnection"
);
@@extension(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "privateEndpointConnection"
);
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "The parameters for creating a private endpoint connection."
);
