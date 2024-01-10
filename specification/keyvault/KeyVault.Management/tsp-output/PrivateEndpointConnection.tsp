import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Vault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.KeyVault;
@doc("Private endpoint connection resource.")
@parentResource(Vault)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("Name of the private endpoint connection associated with the key vault.")
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;

  @doc("Modified whenever there is a change in the state of private endpoint connection.")
  etag?: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Gets the specified private endpoint connection associated with the key vault.")
  get is ArmResourceRead<PrivateEndpointConnection>;

  @doc("Updates the specified private endpoint connection associated with the key vault.")
  put is ArmResourceCreateOrReplaceSync<PrivateEndpointConnection>;

  @doc("Deletes the specified private endpoint connection associated with the key vault.")
  delete is ArmResourceDeleteAsync<PrivateEndpointConnection>;

  @doc("The List operation gets information about the private endpoint connections associated with the vault.")
  listByResource is ArmResourceListByParent<PrivateEndpointConnection>;
}
