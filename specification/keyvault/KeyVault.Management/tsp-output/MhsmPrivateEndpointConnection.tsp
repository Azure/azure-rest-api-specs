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
model MhsmPrivateEndpointConnection
  is TrackedResource<MhsmPrivateEndpointConnectionProperties> {
  @doc("Name of the private endpoint connection associated with the managed hsm pool.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;

  @doc("Modified whenever there is a change in the state of private endpoint connection.")
  etag?: string;
}

@armResourceOperations
interface MHSMPrivateEndpointConnections {
  @doc("Gets the specified private endpoint connection associated with the managed HSM Pool.")
  get is ArmResourceRead<MhsmPrivateEndpointConnection>;
  @doc("Updates the specified private endpoint connection associated with the managed hsm pool.")
  put is ArmResourceCreateOrReplaceSync<MhsmPrivateEndpointConnection>;
  @doc("Deletes the specified private endpoint connection associated with the managed hsm pool.")
  delete is ArmResourceDeleteAsync<MhsmPrivateEndpointConnection>;
  @doc("The List operation gets information about the private endpoint connections associated with the managed HSM Pool.")
  listByResource is ArmResourceListByParent<MhsmPrivateEndpointConnection>;
}
