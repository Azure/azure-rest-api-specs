import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AttestationProvider.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Attestation;
@doc("The Private Endpoint Connection resource.")
@parentResource(AttestationProvider)
model AttestationManagementClientPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection associated with the Azure resource")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface AttestationManagementClientPrivateEndpointConnections {
  @doc("Gets the specified private endpoint connection associated with the attestation provider.")
  get is ArmResourceRead<AttestationManagementClientPrivateEndpointConnection>;
  @doc("Update the state of specified private endpoint connection associated with the attestation provider.")
  create is ArmResourceCreateOrReplaceSync<AttestationManagementClientPrivateEndpointConnection>;
  @doc("Deletes the specified private endpoint connection associated with the attestation provider.")
  delete is ArmResourceDeleteSync<AttestationManagementClientPrivateEndpointConnection>;
  @doc("List all the private endpoint connections associated with the attestation provider.")
  list is ArmResourceListByParent<AttestationManagementClientPrivateEndpointConnection>;
}
