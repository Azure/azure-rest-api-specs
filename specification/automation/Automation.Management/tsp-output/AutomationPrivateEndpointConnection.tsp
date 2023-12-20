import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Automation;
@doc("A private endpoint connection")
@parentResource(AutomationAccount)
model AutomationPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface AutomationPrivateEndpointConnections {
  @doc("Gets a private endpoint connection.")
  get is ArmResourceRead<AutomationPrivateEndpointConnection>;
  @doc("Approve or reject a private endpoint connection with a given name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AutomationPrivateEndpointConnection>;
  @doc("Deletes a private endpoint connection with a given name.")
  delete is ArmResourceDeleteWithoutOkAsync<AutomationPrivateEndpointConnection>;
  @doc("List all private endpoint connections on a Automation account.")
  listByAutomationAccount is ArmResourceListByParent<AutomationPrivateEndpointConnection>;
}
