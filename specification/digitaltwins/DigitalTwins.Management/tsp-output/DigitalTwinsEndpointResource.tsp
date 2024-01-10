import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DigitalTwinsDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DigitalTwins;
@doc("DigitalTwinsInstance endpoint resource.")
@parentResource(DigitalTwinsDescription)
model DigitalTwinsEndpointResource
  is ProxyResource<DigitalTwinsEndpointResourceProperties> {
  @doc("Name of Endpoint Resource.")
  @maxLength(49)
  @minLength(2)
  @pattern("^(?![0-9]+$)(?!-)[a-zA-Z0-9-]{2,49}[a-zA-Z0-9]$")
  @key("endpointName")
  @segment("endpoints")
  name: string;
}

@armResourceOperations
@projectedName("client", "DigitalTwinsEndpoint")
interface DigitalTwinsEndpointResources_DigitalTwinsEndpoint {
  @doc("Get DigitalTwinsInstances Endpoint.")
  get is ArmResourceRead<DigitalTwinsEndpointResource>;

  @doc("Create or update DigitalTwinsInstance endpoint.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DigitalTwinsEndpointResource>;

  @doc("Delete a DigitalTwinsInstance endpoint.")
  delete is ArmResourceDeleteAsync<DigitalTwinsEndpointResource>;

  @doc("Get DigitalTwinsInstance Endpoints.")
  list is ArmResourceListByParent<DigitalTwinsEndpointResource>;
}
