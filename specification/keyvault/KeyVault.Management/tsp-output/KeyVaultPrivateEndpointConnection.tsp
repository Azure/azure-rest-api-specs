import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./KeyVault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.KeyVault;
@doc("Private endpoint connection resource.")
@parentResource(KeyVault)
model KeyVaultPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("Name of the private endpoint connection associated with the key vault.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface KeyVaultPrivateEndpointConnections {
  @doc("Gets the specified private endpoint connection associated with the key vault.")
  get is ArmResourceRead<KeyVaultPrivateEndpointConnection>;
  @doc("Updates the specified private endpoint connection associated with the key vault.")
  put is ArmResourceCreateOrReplaceSync<KeyVaultPrivateEndpointConnection>;
  @doc("Deletes the specified private endpoint connection associated with the key vault.")
  delete is ArmResourceDeleteAsync<KeyVaultPrivateEndpointConnection>;
  @doc("The List operation gets information about the private endpoint connections associated with the vault.")
  listByResource is ArmResourceListByParent<KeyVaultPrivateEndpointConnection>;
}
