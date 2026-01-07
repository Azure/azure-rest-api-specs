import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
// FIXME: Settings has no properties property
/**
 * The Setting.
 */
model Settings is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = Settings,
    KeyName = "settingsName",
    SegmentName = "settings",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9]*$"
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;

  /**
   * The kind of the setting
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: SettingKind;
}

alias workspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface ProductSettings {
  /**
   * Gets a setting.
   */
  get is ArmResourceRead<Settings>;

  /**
   * Updates setting.
   */
  update is ArmResourceCreateOrReplaceSync<Settings>;

  /**
   * Delete setting of the product.
   */
  delete is ArmResourceDeleteSync<Settings>;

  /**
   * List of all the settings
   */
  list is ArmResourceListByParent<
    Settings,
    Response = ArmResponse<SettingList>
  >;
}

@@doc(Settings.name,
  "The setting name. Supports - Anomalies, EyesOn, EntityAnalytics, Ueba"
);
@@doc(ProductSettings.update::parameters.resource, "The setting");
