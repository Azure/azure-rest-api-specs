import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Security;
@doc("The Advanced Threat Protection resource.")
@singleton("current")
model AdvancedThreatProtectionSetting
  is ExtensionResource<AdvancedThreatProtectionProperties> {
  @key("advancedThreatProtectionSetting")
  @segment("advancedThreatProtectionSettings")
  name: string;
}

@armResourceOperations
@projectedName("client", "AdvancedThreatProtection")
interface AdvancedThreatProtectionSettings_AdvancedThreatProtection {
  @doc("Gets the Advanced Threat Protection settings for the specified resource.")
  get is ArmResourceRead<AdvancedThreatProtectionSetting>;

  @doc("Creates or updates the Advanced Threat Protection settings on a specified resource.")
  create is ArmResourceCreateOrReplaceSync<AdvancedThreatProtectionSetting>;
}
