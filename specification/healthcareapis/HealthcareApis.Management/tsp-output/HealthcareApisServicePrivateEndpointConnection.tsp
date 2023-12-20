import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./HealthcareApisService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HealthcareApis;
// FIXME: HealthcareApisServicePrivateEndpointConnection has no properties property
@doc("The Private Endpoint Connection resource.")
@parentResource(HealthcareApisService)
model HealthcareApisServicePrivateEndpointConnection is ProxyResource<{}> {
  @doc("The name of the private endpoint connection associated with the Azure resource")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface HealthcareApisServicePrivateEndpointConnections {
  @doc("Gets the specified private endpoint connection associated with the service.")
  get is ArmResourceRead<HealthcareApisServicePrivateEndpointConnection>;
  @doc("Update the state of the specified private endpoint connection associated with the service.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<HealthcareApisServicePrivateEndpointConnection>;
  @doc("Deletes a private endpoint connection.")
  delete is ArmResourceDeleteAsync<HealthcareApisServicePrivateEndpointConnection>;
  @doc("Lists all private endpoint connections for a service.")
  listByService is ArmResourceListByParent<HealthcareApisServicePrivateEndpointConnection>;
}
