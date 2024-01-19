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
@doc("Definition of the connection type.")
@parentResource(AutomationAccount)
model ConnectionType is ProxyResource<ConnectionTypeProperties> {
  @doc("The name of connection type.")
  @path
  @key("connectionTypeName")
  @segment("connectionTypes")
  name: string;
}

@armResourceOperations
interface ConnectionTypes {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve the connection type identified by connection type name.")
  @operationId("ConnectionType_Get")
  get is ArmResourceRead<ConnectionType>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a connection type.")
  @operationId("ConnectionType_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConnectionType>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the connection type.")
  @operationId("ConnectionType_Delete")
  delete is ArmResourceDeleteSync<ConnectionType>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve a list of connection types.")
  @operationId("ConnectionType_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<ConnectionType>;
}

@@projectedName(ConnectionTypes.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ConnectionTypes.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ConnectionTypes.createOrUpdate::parameters.resource,
  "The parameters supplied to the create or update connection type operation."
);
