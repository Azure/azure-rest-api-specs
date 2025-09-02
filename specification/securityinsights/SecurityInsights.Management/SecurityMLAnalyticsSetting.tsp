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
   * The kind of security ML Analytics Settings
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: SecurityMLAnalyticsSettingsKind;
}

@armResourceOperations
interface SecurityMLAnalyticsSettings {
  /**
   * Gets the Security ML Analytics Settings.
   */
  get is Extension.Read<
    OperationalInsights,
    SecurityMLAnalyticsSetting,
    Error = CloudError
  >;

  /**
   * Creates or updates the Security ML Analytics Settings.
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    OperationalInsights,
    SecurityMLAnalyticsSetting,
    Error = CloudError
  >;

  /**
   * Delete the Security ML Analytics Settings.
   */
  delete is Extension.DeleteSync<
    OperationalInsights,
    SecurityMLAnalyticsSetting,
    Error = CloudError
  >;

  /**
   * Gets all Security ML Analytics Settings.
   */
  list is Extension.ListByTarget<
    OperationalInsights,
    SecurityMLAnalyticsSetting,
    Response = ArmResponse<SecurityMLAnalyticsSettingsList>,
    Error = CloudError
  >;
}

@@doc(SecurityMLAnalyticsSetting.name,
  "Security ML Analytics Settings resource name"
);
@@doc(SecurityMLAnalyticsSettings.createOrUpdate::parameters.resource,
  "The security ML Analytics setting"
);
