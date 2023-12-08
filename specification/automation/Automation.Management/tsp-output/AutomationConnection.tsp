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
@doc("Definition of the connection.")
@parentResource(AutomationAccount)
model AutomationConnection is ProxyResource<ConnectionProperties> {
  @doc("The name of connection.")
  @path
  @key("connectionName")
  @segment("connections")
  name: string;
}

@armResourceOperations
interface AutomationConnections {
  @doc("Retrieve the connection identified by connection name.")
  get is ArmResourceRead<AutomationConnection>;
  @doc("Create or update a connection.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AutomationConnection>;
  @doc("Update a connection.")
  update is ArmResourcePatchSync<AutomationConnection, ConnectionProperties>;
  @doc("Delete the connection.")
  delete is ArmResourceDeleteSync<AutomationConnection>;
  @doc("Retrieve a list of connections.")
  listByAutomationAccount is ArmResourceListByParent<AutomationConnection>;
}
