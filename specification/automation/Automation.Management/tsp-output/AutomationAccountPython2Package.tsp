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
@doc("Definition of the module type.")
@parentResource(AutomationAccount)
model AutomationAccountPython2Package is TrackedResource<ModuleProperties> {
  @doc("The python package name.")
  @path
  @key("packageName")
  @segment("python2Packages")
  name: string;
}

@armResourceOperations
interface AutomationAccountPython2Packages {
  @doc("Retrieve the python 2 package identified by package name.")
  get is ArmResourceRead<AutomationAccountPython2Package>;
  @doc("Create or Update the python 2 package identified by package name.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AutomationAccountPython2Package>;
  @doc("Update the python 2 package identified by package name.")
  update is ArmTagsPatchSync<AutomationAccountPython2Package>;
  @doc("Delete the python 2 package by name.")
  delete is ArmResourceDeleteSync<AutomationAccountPython2Package>;
  @doc("Retrieve a list of python 2 packages.")
  listByAutomationAccount is ArmResourceListByParent<AutomationAccountPython2Package>;
}
