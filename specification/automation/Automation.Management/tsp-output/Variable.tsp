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
@doc("Definition of the variable.")
@parentResource(AutomationAccount)
model Variable is ProxyResource<VariableProperties> {
  @doc("The name of variable.")
  @key("variableName")
  @segment("variables")
  name: string;
}

@armResourceOperations
interface Variable {
  @doc("Retrieve the variable identified by variable name.")
  get is ArmResourceRead<Variable>;
  @doc("Create a variable.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Variable>;
  @doc("Update a variable.")
  update is ArmCustomPatchSync<Variable, VariableUpdateParameters>;
  @doc("Delete the variable.")
  delete is ArmResourceDeleteSync<Variable>;
  @doc("Retrieve a list of variables.")
  listByAutomationAccount is ArmResourceListByParent<Variable>;
}
