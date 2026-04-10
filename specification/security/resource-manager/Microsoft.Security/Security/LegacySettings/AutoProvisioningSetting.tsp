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

namespace Microsoft.Security;
/**
 * Auto provisioning setting
 */
@subscriptionResource
model AutoProvisioningSetting
  is Azure.ResourceManager.ProxyResource<AutoProvisioningSettingProperties> {
  ...ResourceNameParameter<
    Resource = AutoProvisioningSetting,
    KeyName = "settingName",
    SegmentName = "autoProvisioningSettings",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface AutoProvisioningSettings {
  /**
   * Details of a specific setting
   */
  get is ArmResourceRead<
    AutoProvisioningSetting,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * Details of a specific setting
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ArmResourceCreateOrReplaceSync<
    AutoProvisioningSetting,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResourceUpdatedResponse<AutoProvisioningSetting>,
    Error = CloudError
  >;

  /**
   * Exposes the auto provisioning settings of the subscriptions
   */
  list is ArmResourceListByParent<
    AutoProvisioningSetting,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<AutoProvisioningSettingList>,
    Error = CloudError
  >;
}

@@doc(AutoProvisioningSetting.name, "Auto provisioning setting key");
@@doc(AutoProvisioningSetting.properties, "Auto provisioning setting data");
@@doc(AutoProvisioningSettings.create::parameters.resource,
  "Auto provisioning setting key"
);


