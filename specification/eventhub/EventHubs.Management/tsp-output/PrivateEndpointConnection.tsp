import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EventHubsNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventHub;
@doc("Properties of the PrivateEndpointConnection.")
@parentResource(EventHubsNamespace)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The PrivateEndpointConnection name")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Gets a description for the specified Private Endpoint Connection name.")
  get is ArmResourceRead<PrivateEndpointConnection>;

  @doc("Creates or updates PrivateEndpointConnections of service namespace.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<PrivateEndpointConnection>;

  @doc("Deletes an existing namespace. This operation also removes all associated resources under the namespace.")
  delete is ArmResourceDeleteAsync<PrivateEndpointConnection>;

  @doc("Gets the available PrivateEndpointConnections within a namespace.")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@projectedName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "Parameters supplied to update Status of PrivateEndPoint Connection to namespace resource."
);
