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
/**
 * Definition of the connection.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(AutomationAccount)
@Azure.ResourceManager.Private.armResourceInternal(ConnectionProperties)
@includeInapplicableMetadataInPayload(false)
model Connection extends ProxyResourceBase {
  /**
   * The name of connection.
   */
  @path
  @key("connectionName")
  @segment("connections")
  name: string;

  /**
   * Gets or sets the properties of the connection.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ConnectionProperties;
}

@armResourceOperations
interface Connections {
  /**
   * Retrieve the connection identified by connection name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Connection_Get")
  get is ArmResourceRead<Connection>;

  /**
   * Create or update a connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Connection_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Connection>;

  /**
   * Update a connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Connection_Update")
  update is ArmCustomPatchSync<Connection, ConnectionUpdateParameters>;

  /**
   * Delete the connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Connection_Delete")
  delete is ArmResourceDeleteSync<Connection>;

  /**
   * Retrieve a list of connections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
