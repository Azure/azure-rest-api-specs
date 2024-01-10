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
// FIXME: PrivateEndpointConnectionDescription has no properties property
@doc("The Private Endpoint Connection resource.")
@parentResource(ServicesDescription)
model PrivateEndpointConnectionDescription is ProxyResource<{}> {
  @doc("The name of the private endpoint connection associated with the Azure resource")
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
@projectedName("client", "PrivateEndpointConnections")
interface PrivateEndpointConnectionDescriptions_PrivateEndpointConnections {
  @doc("Gets the specified private endpoint connection associated with the service.")
  get is ArmResourceRead<PrivateEndpointConnectionDescription>;

  @doc("Update the state of the specified private endpoint connection associated with the service.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PrivateEndpointConnectionDescription>;

  @doc("Deletes a private endpoint connection.")
  delete is ArmResourceDeleteAsync<PrivateEndpointConnectionDescription>;

  @doc("Lists all private endpoint connections for a service.")
  listByService is ArmResourceListByParent<PrivateEndpointConnectionDescription>;
}
