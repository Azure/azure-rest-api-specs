import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace SettingsAPI;
// FIXME: Setting has no properties property
/**
 * The kind of the security setting
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
@Http.Private.includeInapplicableMetadataInPayload(false)
@subscriptionResource
@discriminator("kind")
model Setting extends Foundations.ProxyResource {
  @visibility(Lifecycle.Read)
  @path
  @key("settingName")
  @segment("settings")
  name: SettingName;

  /**
   * the kind of the settings string
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind: SettingKind;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface Settings {
  /**
   * Settings of different configurations in Microsoft Defender for Cloud
   */
  get is ArmResourceRead<
    Setting,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * updating settings about different configurations in Microsoft Defender for Cloud
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  update is ArmResourceCreateOrReplaceSync<
    Setting,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResourceUpdatedResponse<Setting>,
    Error = CloudError
  >;

  /**
   * Settings about different configurations in Microsoft Defender for Cloud
   */
  list is ArmResourceListByParent<
    Setting,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<SettingsList>,
    Error = CloudError
  >;
}

@@doc(Setting.name, "The name of the setting");
@@doc(Settings.update::parameters.resource, "Setting object");
