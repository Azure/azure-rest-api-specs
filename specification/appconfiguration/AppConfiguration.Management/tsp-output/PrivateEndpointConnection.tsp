import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ConfigurationStore.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppConfiguration;
@doc("A private endpoint connection")
@parentResource(ConfigurationStore)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("Private endpoint connection name")
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Gets the specified private endpoint connection associated with the configuration store.")
  get is ArmResourceRead<PrivateEndpointConnection>;
  @doc("Update the state of the specified private endpoint connection associated with the configuration store.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PrivateEndpointConnection>;
  @doc("Deletes a private endpoint connection.")
  delete is ArmResourceDeleteAsync<PrivateEndpointConnection>;
  @doc("Lists all private endpoint connections for a configuration store.")
  listByConfigurationStore is ArmResourceListByParent<PrivateEndpointConnection>;
}
