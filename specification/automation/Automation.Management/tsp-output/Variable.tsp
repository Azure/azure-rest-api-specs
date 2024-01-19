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
@doc("Definition of the variable.")
@parentResource(AutomationAccount)
model Variable is ProxyResource<VariableProperties> {
  @doc("The name of variable.")
  @path
  @key("variableName")
  @segment("variables")
  name: string;
}

@armResourceOperations
interface Variables {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve the variable identified by variable name.")
  @operationId("Variable_Get")
  get is ArmResourceRead<Variable>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a variable.")
  @operationId("Variable_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Variable>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a variable.")
  @operationId("Variable_Update")
  update is ArmCustomPatchSync<Variable, VariableUpdateParameters>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the variable.")
  @operationId("Variable_Delete")
  delete is ArmResourceDeleteSync<Variable>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve a list of variables.")
  @operationId("Variable_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<Variable>;
}

@@projectedName(Variables.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Variables.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Variables.createOrUpdate::parameters.resource,
  "The parameters supplied to the create or update variable operation."
);
@@projectedName(Variables.update::parameters.properties, "json", "parameters");
@@extension(Variables.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Variables.update::parameters.properties,
  "The parameters supplied to the update variable operation."
);
