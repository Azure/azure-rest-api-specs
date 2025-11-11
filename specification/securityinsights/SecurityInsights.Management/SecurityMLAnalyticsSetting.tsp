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
// FIXME: SecurityMLAnalyticsSetting has no properties property
/**
 * Security ML Analytics Setting
 */
model SecurityMLAnalyticsSetting is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = SecurityMLAnalyticsSetting,
    KeyName = "settingsResourceName",
    SegmentName = "securityMLAnalyticsSettings",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;

  /**
   * The kind of security ML Analytics Settings
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: SecurityMLAnalyticsSettingsKind;
}

alias SecurityMLAnalyticsSettingWorkspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface SecurityMLAnalyticsSettings {
  /**
   * Gets the Security ML Analytics Settings.
   */
  get is ArmResourceRead<SecurityMLAnalyticsSetting>;

  /**
   * Creates or updates the Security ML Analytics Settings.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<SecurityMLAnalyticsSetting>;

  /**
   * Delete the Security ML Analytics Settings.
   */
  delete is ArmResourceDeleteSync<SecurityMLAnalyticsSetting>;

  /**
   * Gets all Security ML Analytics Settings.
   */
  list is ArmResourceListByParent<
    SecurityMLAnalyticsSetting,
    Response = ArmResponse<SecurityMLAnalyticsSettingsList>
  >;
}

@@doc(SecurityMLAnalyticsSetting.name,
  "Security ML Analytics Settings resource name"
);
@@doc(SecurityMLAnalyticsSettings.createOrUpdate::parameters.resource,
  "The security ML Analytics setting"
);
