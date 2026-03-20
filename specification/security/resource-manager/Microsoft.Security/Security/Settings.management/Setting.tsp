import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
// FIXME: Setting has no properties property
/**
 * The kind of the security setting
 */
@subscriptionResource
model Setting is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = Setting,
    KeyName = "settingName",
    SegmentName = "settings",
    NamePattern = "",
    Type = SettingName
  >;

  /**
   * the kind of the settings string
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: SettingKind;
}

@armResourceOperations
interface Settings {
  /**
   * Settings of different configurations in Microsoft Defender for Cloud
   */
  get is ArmResourceRead<
    Setting,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * updating settings about different configurations in Microsoft Defender for Cloud
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  update is ArmResourceCreateOrReplaceSync<
    Setting,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResourceUpdatedResponse<Setting>
  >;

  /**
   * Settings about different configurations in Microsoft Defender for Cloud
   */
  list is ArmResourceListByParent<
    Setting,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<SettingsList>
  >;
}

@@doc(Setting.name, "The name of the setting");
@@doc(Settings.update::parameters.resource, "Setting object");
