import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Automation;
@doc("Definition of the connection.")
@parentResource(AutomationAccount)
model Connection is ProxyResource<ConnectionProperties> {
  @doc("The name of connection.")
  @key("connectionName")
  @segment("connections")
  name: string;
}

@armResourceOperations
@projectedName("client", "Connection")
interface Connections_Connection {
  @doc("Retrieve the connection identified by connection name.")
  get is ArmResourceRead<Connection>;

  @doc("Create or update a connection.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Connection>;

  @doc("Update a connection.")
  update is ArmCustomPatchSync<Connection, ConnectionUpdateParameters>;

  @doc("Delete the connection.")
  delete is ArmResourceDeleteSync<Connection>;

  @doc("Retrieve a list of connections.")
  listByAutomationAccount is ArmResourceListByParent<Connection>;
}
