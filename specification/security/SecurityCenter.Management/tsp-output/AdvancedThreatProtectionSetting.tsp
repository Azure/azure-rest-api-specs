import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("The Advanced Threat Protection resource.")
@singleton("current")
model AdvancedThreatProtectionSetting
  is ExtensionResource<AdvancedThreatProtectionProperties> {
  @key("settingName")
  @segment("advancedThreatProtectionSettings")
  name: string;
}

@armResourceOperations
interface AdvancedThreatProtection {
  @doc("Gets the Advanced Threat Protection settings for the specified resource.")
  get is ArmResourceRead<
    AdvancedThreatProtectionSetting,
    {
      ...BaseParameters<AdvancedThreatProtectionSetting>;

      @doc("Advanced Threat Protection setting name.")
      @path
      settingName: "current";
    }
  >;
  @doc("Creates or updates the Advanced Threat Protection settings on a specified resource.")
  create is ArmResourceCreateOrReplaceSync<
    AdvancedThreatProtectionSetting,
    {
      ...BaseParameters<AdvancedThreatProtectionSetting>;

      @doc("Advanced Threat Protection setting name.")
      @path
      settingName: "current";
    }
  >;
}
