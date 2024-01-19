import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
interface AdvancedThreatProtectionSettings {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the Advanced Threat Protection settings for the specified resource.")
  @operationId("AdvancedThreatProtection_Get")
  get is ArmResourceRead<AdvancedThreatProtectionSetting>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates the Advanced Threat Protection settings on a specified resource.")
  @operationId("AdvancedThreatProtection_Create")
  create is ArmResourceCreateOrReplaceSync<AdvancedThreatProtectionSetting>;
}

@@projectedName(AdvancedThreatProtectionSettings.create::parameters.resource,
  "json",
  "advancedThreatProtectionSetting"
);
@@extension(AdvancedThreatProtectionSettings.create::parameters.resource,
  "x-ms-client-name",
  "advancedThreatProtectionSetting"
);
@@doc(AdvancedThreatProtectionSettings.create::parameters.resource,
  "Advanced Threat Protection Settings"
);
