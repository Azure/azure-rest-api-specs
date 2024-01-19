import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;
@doc("The Private Endpoint Connection resource.")
@parentResource(Account)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection associated with the Cognitive Services Account")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Gets the specified private endpoint connection associated with the Cognitive Services account.")
  get is ArmResourceRead<PrivateEndpointConnection>;

  @doc("Deletes the specified private endpoint connection associated with the Cognitive Services account.")
  delete is ArmResourceDeleteAsync<PrivateEndpointConnection>;

  @doc("Gets the private endpoint connections associated with the Cognitive Services account.")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}
