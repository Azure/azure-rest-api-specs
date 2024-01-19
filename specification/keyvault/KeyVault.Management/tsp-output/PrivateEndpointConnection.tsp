import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Vault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.KeyVault;
@doc("Private endpoint connection resource.")
@parentResource(Vault)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("Name of the private endpoint connection associated with the key vault.")
  @path
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

@@projectedName(PrivateEndpointConnections.put::parameters.resource,
  "json",
  "properties"
);
@@extension(PrivateEndpointConnections.put::parameters.resource,
  "x-ms-client-name",
  "properties"
);
@@doc(PrivateEndpointConnections.put::parameters.resource,
  "The intended state of private endpoint connection."
);
