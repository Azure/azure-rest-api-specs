import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Bot.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.BotService;
@doc("The Private Endpoint Connection resource.")
@parentResource(Bot)
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
  @doc("Gets the specified private endpoint connection associated with the Bot.")
  get is ArmResourceRead<PrivateEndpointConnection>;

  @doc("Update the state of specified private endpoint connection associated with the Bot.")
  create is ArmResourceCreateOrReplaceSync<PrivateEndpointConnection>;

  @doc("Deletes the specified private endpoint connection associated with the Bot.")
  delete is ArmResourceDeleteSync<PrivateEndpointConnection>;

  @doc("List all the private endpoint connections associated with the Bot.")
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
