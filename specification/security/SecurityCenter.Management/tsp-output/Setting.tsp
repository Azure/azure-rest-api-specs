import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
// FIXME: Setting has no properties property
@doc("The kind of the security setting")
@subscriptionResource
model Setting is ProxyResource<{}> {
  @doc("The name of the setting")
  @key("settingName")
  @segment("settings")
  name: SettingName;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface Settings {
  @doc("Settings of different configurations in Microsoft Defender for Cloud")
  get is ArmResourceRead<Setting>;
  @doc("updating settings about different configurations in Microsoft Defender for Cloud")
  update is ArmResourceCreateOrReplaceSync<Setting>;
  @doc("Settings about different configurations in Microsoft Defender for Cloud")
  list is ArmResourceListByParent<Setting>;
}
