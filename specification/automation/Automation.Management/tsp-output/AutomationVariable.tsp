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
model AutomationVariable is ProxyResource<VariableProperties> {
  @doc("The name of variable.")
  @path
  @key("variableName")
  @segment("variables")
  name: string;
}

@armResourceOperations
interface AutomationVariables {
  @doc("Retrieve the variable identified by variable name.")
  get is ArmResourceRead<AutomationVariable>;
  @doc("Create a variable.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AutomationVariable>;
  @doc("Update a variable.")
  update is ArmResourcePatchSync<AutomationVariable, VariableProperties>;
  @doc("Delete the variable.")
  delete is ArmResourceDeleteSync<AutomationVariable>;
  @doc("Retrieve a list of variables.")
  listByAutomationAccount is ArmResourceListByParent<AutomationVariable>;
}
