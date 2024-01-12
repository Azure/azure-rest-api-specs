import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ElasticSan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ElasticSan;
@doc(" Response for PrivateEndpoint Connection object")
@parentResource(ElasticSan)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the Private Endpoint connection.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Gets the specified private endpoint connection associated with the Elastic San")
  get is ArmResourceRead<PrivateEndpointConnection>;

  @doc("Update the state of specified private endpoint connection associated with the Elastic San")
  create is ArmResourceCreateOrUpdateAsync<
    PrivateEndpointConnection,
    BaseParameters<PrivateEndpointConnection>,
    ArmLroLocationHeader
  >;

  @doc("Deletes the specified private endpoint connection associated with the Elastic San")
  delete is ArmResourceDeleteAsync<
    PrivateEndpointConnection,
    BaseParameters<PrivateEndpointConnection>,
    ArmLroLocationHeader
  >;

  @doc("List all Private Endpoint Connections associated with the Elastic San.")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@projectedName(PrivateEndpointConnections.create::parameters.resource,
  "json",
  "parameters"
);
@@extension(PrivateEndpointConnections.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(PrivateEndpointConnections.create::parameters.resource,
  "Private Endpoint Connection Approval object."
);
