import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Security;
@doc("Auto provisioning setting")
@subscriptionResource
model AutoProvisioningSetting
  is ProxyResource<AutoProvisioningSettingProperties> {
  @doc("Auto provisioning setting key")
  @key("settingName")
  @segment("autoProvisioningSettings")
  name: string;
}

@armResourceOperations
interface AutoProvisioningSettings {
  @doc("Details of a specific setting")
  get is ArmResourceRead<AutoProvisioningSetting>;

  @doc("Details of a specific setting")
  create is ArmResourceCreateOrReplaceSync<AutoProvisioningSetting>;

  @doc("Exposes the auto provisioning settings of the subscriptions")
  list is ArmResourceListByParent<AutoProvisioningSetting>;
}
