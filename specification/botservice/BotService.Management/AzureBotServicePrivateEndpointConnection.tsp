import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Bot.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.BotService;
@doc("The Private Endpoint Connection resource.")
@parentResource(Bot)
model AzureBotServicePrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection associated with the Azure resource")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface AzureBotServicePrivateEndpointConnections {
  @doc("Gets the specified private endpoint connection associated with the Bot.")
  get is ArmResourceRead<AzureBotServicePrivateEndpointConnection>;
  @doc("Update the state of specified private endpoint connection associated with the Bot.")
  create is ArmResourceCreateOrReplaceSync<AzureBotServicePrivateEndpointConnection>;
  @doc("Deletes the specified private endpoint connection associated with the Bot.")
  delete is ArmResourceDeleteSync<AzureBotServicePrivateEndpointConnection>;
  @doc("List all the private endpoint connections associated with the Bot.")
  list is ArmResourceListByParent<AzureBotServicePrivateEndpointConnection>;
}
