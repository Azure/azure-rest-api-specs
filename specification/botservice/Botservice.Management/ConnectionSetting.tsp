import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Bot.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.BotService;
/**
 * Bot channel resource definition
 */
@parentResource(Bot)
model ConnectionSetting
  is Azure.ResourceManager.TrackedResource<ConnectionSettingProperties> {
  ...ResourceNameParameter<
    Resource = ConnectionSetting,
    KeyName = "connectionName",
    SegmentName = "connections",
    NamePattern = "^[a-zA-Z0-9][\\sa-zA-Z0-9_.-]*$"
  >;
}

@armResourceOperations
interface ConnectionSettings {
  /**
   * Get a Connection Setting registration for a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BotConnection_Get")
  get is ArmResourceRead<ConnectionSetting>;

  /**
   * Register a new Auth Connection for a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BotConnection_Create")
  create is ArmResourceCreateOrReplaceSync<ConnectionSetting>;

  /**
   * Updates a Connection Setting registration for a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("BotConnection_Update")
  update is ArmCustomPatchSync<
    ConnectionSetting,
    PatchModel = ConnectionSetting,
    Response = ArmResponse<ConnectionSetting> | ArmResourceCreatedSyncResponse<ConnectionSetting>
  >;

  /**
   * Deletes a Connection Setting registration for a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BotConnection_Delete")
  delete is ArmResourceDeleteSync<ConnectionSetting>;

  /**
   * Returns all the Connection Settings registered to a particular BotService resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BotConnection_ListByBotService")
  listByBotService is ArmResourceListByParent<
    ConnectionSetting,
    Response = ArmResponse<ConnectionSettingResponseList>
  >;

  /**
   * Get a Connection Setting registration for a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BotConnection_ListWithSecrets")
  listWithSecrets is ArmResourceActionSync<
    ConnectionSetting,
    void,
    ArmResponse<ConnectionSetting>
  >;
}

@@maxLength(ConnectionSetting.name, 64);
@@minLength(ConnectionSetting.name, 2);
@@doc(ConnectionSetting.name,
  "The name of the Bot Service Connection Setting resource."
);
@@doc(ConnectionSetting.properties,
  "The set of properties specific to bot channel resource"
);
@@doc(ConnectionSettings.create::parameters.resource,
  "The parameters to provide for creating the Connection Setting."
);
@@doc(ConnectionSettings.update::parameters.properties,
  "The parameters to provide for updating the Connection Setting."
);
