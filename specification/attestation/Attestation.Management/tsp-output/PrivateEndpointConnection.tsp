import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AttestationProvider.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Attestation;
@doc("The Private Endpoint Connection resource.")
@parentResource(AttestationProvider)
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
  @doc("Gets the specified private endpoint connection associated with the attestation provider.")
  get is ArmResourceRead<PrivateEndpointConnection>;

  @doc("Update the state of specified private endpoint connection associated with the attestation provider.")
  create is ArmResourceCreateOrReplaceSync<PrivateEndpointConnection>;

  @doc("Deletes the specified private endpoint connection associated with the attestation provider.")
  delete is ArmResourceDeleteSync<PrivateEndpointConnection>;

  @doc("List all the private endpoint connections associated with the attestation provider.")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@projectedName(PrivateEndpointConnections.create::parameters.resource,
  "json",
  "properties"
);
@@extension(PrivateEndpointConnections.create::parameters.resource,
  "x-ms-client-name",
  "properties"
);
@@doc(PrivateEndpointConnections.create::parameters.resource,
  "The private endpoint connection properties."
);
