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
@doc("Definition of the connection type.")
@parentResource(AutomationAccount)
model ConnectionType is ProxyResource<ConnectionTypeProperties> {
  @doc("The name of connection type.")
  @key("connectionTypeName")
  @segment("connectionTypes")
  name: string;
}

@armResourceOperations
interface ConnectionType {
  @doc("Retrieve the connection type identified by connection type name.")
  get is ArmResourceRead<ConnectionType>;
  @doc("Create a connection type.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConnectionType>;
  @doc("Delete the connection type.")
  delete is ArmResourceDeleteSync<ConnectionType>;
  @doc("Retrieve a list of connection types.")
  listByAutomationAccount is ArmResourceListByParent<ConnectionType>;
}
