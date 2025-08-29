import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CostManagement;
// FIXME: Setting has no properties property
/**
 * Setting definition.
 */
@extensionResource
model Setting is Azure.ResourceManager.ExtensionResource<{}> {
  ...ResourceNameParameter<
    Resource = Setting,
    KeyName = "type",
    SegmentName = "settings",
    NamePattern = "",
    Type = SettingType
  >;

  /**
   * Specifies the kind of settings.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: SettingsKind;
}

@armResourceOperations
interface Settings {
  /**
   * Get the setting from the given scope by name.
   */
  getByScope is Extension.Read<Extension.ScopeParameter, Setting>;

  /**
   * Create or update a setting within the given scope.
   */
  createOrUpdateByScope is Extension.CreateOrReplaceSync<
    Extension.ScopeParameter,
    Setting
  >;

  /**
   * Delete a setting within the given scope.
   */
  deleteByScope is Extension.DeleteSync<Extension.ScopeParameter, Setting>;

  /**
   * List all cost management settings in the requested scope.
   */
  list is Extension.ListByTarget<
    Extension.ScopeParameter,
    Setting,
    Response = ArmResponse<SettingsListResult>
  >;
}

@@doc(Setting.name, "Setting type.");
@@doc(Settings.createOrUpdateByScope::parameters.resource,
  "Setting to be created or updated."
);
