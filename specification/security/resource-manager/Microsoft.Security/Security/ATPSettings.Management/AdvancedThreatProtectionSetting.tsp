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
/**
 * The Advanced Threat Protection resource.
 */
@singleton("default")
@extensionResource
model AdvancedThreatProtectionSetting
  is Azure.ResourceManager.ExtensionResource<AdvancedThreatProtectionProperties> {
  ...ResourceNameParameter<
    Resource = AdvancedThreatProtectionSetting,
    KeyName = "advancedThreatProtectionSetting",
    SegmentName = "advancedThreatProtectionSettings",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AdvancedThreatProtectionSettings {
  /**
   * Gets the Advanced Threat Protection settings for the specified resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AdvancedThreatProtection_Get")
  get is Extension.Read<
    Extension.ScopeParameter,
    AdvancedThreatProtectionSetting
  >;

  /**
   * Creates or updates the Advanced Threat Protection settings on a specified resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("AdvancedThreatProtection_Create")
  create is Extension.CreateOrReplaceSync<
    Extension.ScopeParameter,
    AdvancedThreatProtectionSetting,
    Response = ArmResourceUpdatedResponse<AdvancedThreatProtectionSetting>
  >;
}

@@doc(AdvancedThreatProtectionSetting.name, "");
@@doc(AdvancedThreatProtectionSetting.properties,
  "The Advanced Threat Protection settings."
);
@@doc(AdvancedThreatProtectionSettings.create::parameters.resource,
  "Advanced Threat Protection Settings"
);
