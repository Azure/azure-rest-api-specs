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
model Module is TrackedResource<ModuleProperties> {
  @doc("The python package name.")
  @key("packageName")
  @segment("python2Packages")
  name: string;

  @doc("Gets or sets the etag of the resource.")
  etag?: string;
}

@armResourceOperations
interface Python2Package {
  @doc("Retrieve the python 2 package identified by package name.")
  get is ArmResourceRead<Module>;
  @doc("Create or Update the python 2 package identified by package name.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Module>;
  @doc("Update the python 2 package identified by package name.")
  update is ArmCustomPatchSync<Module, PythonPackageUpdateParameters>;
  @doc("Delete the python 2 package by name.")
  delete is ArmResourceDeleteSync<Module>;
  @doc("Retrieve a list of python 2 packages.")
  listByAutomationAccount is ArmResourceListByParent<Module>;
}
