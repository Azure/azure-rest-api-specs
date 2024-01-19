import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
@doc("Definition of the module type.")
@parentResource(AutomationAccount)
model Module is TrackedResource<ModuleProperties> {
  @doc("The python package name.")
  @path
  @key("packageName")
  @segment("python2Packages")
  name: string;

  @doc("Gets or sets the etag of the resource.")
  etag?: string;
}

@armResourceOperations
interface Modules {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve the python 2 package identified by package name.")
  @operationId("Python2Package_Get")
  get is ArmResourceRead<Module>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or Update the python 2 package identified by package name.")
  @operationId("Python2Package_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Module>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update the python 2 package identified by package name.")
  @operationId("Python2Package_Update")
  update is ArmCustomPatchSync<Module, PythonPackageUpdateParameters>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the python 2 package by name.")
  @operationId("Python2Package_Delete")
  delete is ArmResourceDeleteSync<Module>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve a list of python 2 packages.")
  @operationId("Python2Package_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<Module>;
}

@@projectedName(Modules.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Modules.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Modules.createOrUpdate::parameters.resource,
  "The create or update parameters for python package."
);
@@projectedName(Modules.update::parameters.properties, "json", "parameters");
@@extension(Modules.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Modules.update::parameters.properties,
  "The update parameters for python package."
);
