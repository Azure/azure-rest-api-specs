import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Bot.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.BotService;
/**
 * Bot channel resource definition
 */
@parentResource(Bot)
model ConnectionSetting is TrackedResource<ConnectionSettingProperties> {
  /**
   * The name of the Bot Service Connection Setting resource.
   */
  @maxLength(64)
  @minLength(2)
  @pattern("^[a-zA-Z0-9][\\sa-zA-Z0-9_.-]*$")
  @path
  @key("connectionName")
  @segment("connections")
  name: string;
}

@armResourceOperations
interface ConnectionSettings {
  /**
   * Get a Connection Setting registration for a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BotConnection_Get")
  get is ArmResourceRead<ConnectionSetting>;

  /**
   * Register a new Auth Connection for a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BotConnection_Create")
  create is ArmResourceCreateOrReplaceSync<ConnectionSetting>;

  /**
   * Updates a Connection Setting registration for a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("BotConnection_Update")
  update is ArmCustomPatchSync<ConnectionSetting, ConnectionSetting>;

  /**
   * Deletes a Connection Setting registration for a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BotConnection_Delete")
  delete is ArmResourceDeleteSync<ConnectionSetting>;

  /**
   * Returns all the Connection Settings registered to a particular BotService resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BotConnection_ListByBotService")
  listByBotService is ArmResourceListByParent<ConnectionSetting>;

  /**
   * Lists the available Service Providers for creating Connection Settings
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BotConnection_ListServiceProviders")
  listServiceProviders is ArmListBySubscription<ConnectionSetting>;

  /**
   * Get a Connection Setting registration for a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BotConnection_ListWithSecrets")
  listWithSecrets is ArmResourceActionSync<
    ConnectionSetting,
    void,
    ConnectionSetting
  >;
}

@@projectedName(ConnectionSettings.create::parameters.resource,
  "json",
  "parameters"
);
@@extension(ConnectionSettings.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ConnectionSettings.create::parameters.resource,
  "The parameters to provide for creating the Connection Setting."
);
@@projectedName(ConnectionSettings.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ConnectionSettings.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ConnectionSettings.update::parameters.properties,
  "The parameters to provide for updating the Connection Setting."
);
