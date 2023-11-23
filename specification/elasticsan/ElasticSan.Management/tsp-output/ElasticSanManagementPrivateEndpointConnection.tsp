import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ElasticSan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ElasticSan;
@doc(" Response for PrivateEndpoint Connection object")
@parentResource(ElasticSan)
model ElasticSanManagementPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the Private Endpoint connection.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface ElasticSanManagementPrivateEndpointConnections {
  @doc("Gets the specified private endpoint connection associated with the Elastic San")
  get is ArmResourceRead<ElasticSanManagementPrivateEndpointConnection>;
  @doc("Update the state of specified private endpoint connection associated with the Elastic San")
  create is ArmResourceCreateOrUpdateAsync<ElasticSanManagementPrivateEndpointConnection>;
  @doc("Deletes the specified private endpoint connection associated with the Elastic San")
  delete is ArmResourceDeleteAsync<ElasticSanManagementPrivateEndpointConnection>;
  @doc("List all Private Endpoint Connections associated with the Elastic San.")
  list is ArmResourceListByParent<ElasticSanManagementPrivateEndpointConnection>;
}
