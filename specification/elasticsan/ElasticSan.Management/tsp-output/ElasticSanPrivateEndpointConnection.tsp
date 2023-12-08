import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ElasticSan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ElasticSan;
@doc(" Response for PrivateEndpoint Connection object")
@parentResource(ElasticSan)
model ElasticSanPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the Private Endpoint connection.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface ElasticSanPrivateEndpointConnections {
  @doc("Gets the specified private endpoint connection associated with the Elastic San")
  get is ArmResourceRead<ElasticSanPrivateEndpointConnection>;
  @doc("Update the state of specified private endpoint connection associated with the Elastic San")
  create is ArmResourceCreateOrUpdateAsync<ElasticSanPrivateEndpointConnection>;
  @doc("Deletes the specified private endpoint connection associated with the Elastic San")
  delete is ArmResourceDeleteAsync<ElasticSanPrivateEndpointConnection>;
  @doc("List all Private Endpoint Connections associated with the Elastic San.")
  list is ArmResourceListByParent<ElasticSanPrivateEndpointConnection>;
}
