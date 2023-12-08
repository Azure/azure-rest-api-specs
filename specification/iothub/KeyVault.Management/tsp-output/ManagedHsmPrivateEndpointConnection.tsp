import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedHsm.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.KeyVault;
@doc("Private endpoint connection resource.")
@parentResource(ManagedHsm)
model ManagedHsmPrivateEndpointConnection
  is TrackedResource<MhsmPrivateEndpointConnectionProperties> {
  @doc("Name of the private endpoint connection associated with the managed hsm pool.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface ManagedHsmPrivateEndpointConnections {
  @doc("Gets the specified private endpoint connection associated with the managed HSM Pool.")
  get is ArmResourceRead<ManagedHsmPrivateEndpointConnection>;
  @doc("Updates the specified private endpoint connection associated with the managed hsm pool.")
  put is ArmResourceCreateOrReplaceSync<ManagedHsmPrivateEndpointConnection>;
  @doc("Deletes the specified private endpoint connection associated with the managed hsm pool.")
  delete is ArmResourceDeleteAsync<ManagedHsmPrivateEndpointConnection>;
  @doc("The List operation gets information about the private endpoint connections associated with the managed HSM Pool.")
  listByResource is ArmResourceListByParent<ManagedHsmPrivateEndpointConnection>;
}
