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
@doc("Definition of the connection.")
@parentResource(AutomationAccount)
model Connection is ProxyResource<ConnectionProperties> {
  @doc("The name of connection.")
  @path
  @key("connectionName")
  @segment("connections")
  name: string;
}

@armResourceOperations
interface Connections {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve the connection identified by connection name.")
  @operationId("Connection_Get")
  get is ArmResourceRead<Connection>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a connection.")
  @operationId("Connection_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Connection>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a connection.")
  @operationId("Connection_Update")
  update is ArmCustomPatchSync<Connection, ConnectionUpdateParameters>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the connection.")
  @operationId("Connection_Delete")
  delete is ArmResourceDeleteSync<Connection>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve a list of connections.")
  @operationId("Connection_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<Connection>;
}

@@projectedName(Connections.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Connections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Connections.createOrUpdate::parameters.resource,
  "The parameters supplied to the create or update connection operation."
);
@@projectedName(Connections.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(Connections.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Connections.update::parameters.properties,
  "The parameters supplied to the update a connection operation."
);
