import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServicesDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.HealthcareApis;
// FIXME: ServicePrivateEndpointConnection has no properties property
@doc("The Private Endpoint Connection resource.")
@parentResource(ServicesDescription)
model ServicePrivateEndpointConnection is ProxyResource<{}> {
  @doc("The name of the private endpoint connection associated with the Azure resource")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface ServicePrivateEndpointConnections {
  @doc("Gets the specified private endpoint connection associated with the service.")
  get is ArmResourceRead<ServicePrivateEndpointConnection>;
  @doc("Update the state of the specified private endpoint connection associated with the service.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServicePrivateEndpointConnection>;
  @doc("Deletes a private endpoint connection.")
  delete is ArmResourceDeleteAsync<ServicePrivateEndpointConnection>;
  @doc("Lists all private endpoint connections for a service.")
  listByService is ArmResourceListByParent<ServicePrivateEndpointConnection>;
}
