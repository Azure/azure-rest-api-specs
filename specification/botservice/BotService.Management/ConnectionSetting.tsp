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
  is Azure.ResourceManager.ProxyResource<ConnectionSettingProperties> {
  ...ResourceNameParameter<
    Resource = ConnectionSetting,
    KeyName = "connectionName",
    SegmentName = "connections",
    NamePattern = "^[a-zA-Z0-9][\\sa-zA-Z0-9_.-]*$"
  >;

  /**
   * Specifies the location of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;

  /**
   * Contains resource tags defined as key/value pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Gets or sets the SKU of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: Sku;

  /**
   * Required. Gets or sets the Kind of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: Kind;

  /**
   * Entity Tag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  /**
   * Entity zones
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  zones?: string[];
}

@armResourceOperations
interface ConnectionSettings {
  /**
   * Get a Connection Setting registration for a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<ConnectionSetting, Error = Error>;

  /**
   * Register a new Auth Connection for a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ArmResourceCreateOrReplaceSync<ConnectionSetting, Error = Error>;

  /**
   * Updates a Connection Setting registration for a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ConnectionSetting,
    PatchModel = ConnectionSetting,
    Response = ArmResponse<ConnectionSetting> | ArmResourceCreatedSyncResponse<ConnectionSetting>,
    Error = Error
  >;

  /**
   * Deletes a Connection Setting registration for a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteSync<ConnectionSetting, Error = Error>;

  /**
   * Returns all the Connection Settings registered to a particular BotService resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listByBotService is ArmResourceListByParent<
    ConnectionSetting,
    Response = ArmResponse<ConnectionSettingResponseList>,
    Error = Error
  >;

  /**
   * Get a Connection Setting registration for a Bot Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listWithSecrets is ArmResourceActionSync<
    ConnectionSetting,
    void,
    ArmResponse<ConnectionSetting>,
    Error = Error
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
