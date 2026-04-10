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

namespace ATPSettingsAPI;
/**
 * The Advanced Threat Protection resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

alias AdvancedThreatProtectionSettingOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** The fully qualified Azure Resource manager identifier of the resource. */
    @path(#{ allowReserved: true })
    @key
    resourceId: string;

    /** The provider namespace. */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";
  },
  {},
  {
    /** Advanced Threat Protection setting name. */
    @path
    @segment("advancedThreatProtectionSettings")
    @key
    settingName: AdvancedThreatProtectionSettingName;
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AdvancedThreatProtectionSettingName {
  current,
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface AdvancedThreatProtectionSettings {
  /**
   * Gets the Advanced Threat Protection settings for the specified resource.
   */
  @tag("AdvancedThreatProtection")
  get is AdvancedThreatProtectionSettingOps.Read<
    AdvancedThreatProtectionSetting,
    ErrorType = CloudError
  >;

  /**
   * Creates or updates the Advanced Threat Protection settings on a specified resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("AdvancedThreatProtection")
  create is AdvancedThreatProtectionSettingOps.CreateOrUpdateSync<
    AdvancedThreatProtectionSetting,
    Response = ArmResponse<AdvancedThreatProtectionSetting>,
    ErrorType = CloudError
  >;
}

@@doc(AdvancedThreatProtectionSetting.name, "");
@@doc(AdvancedThreatProtectionSetting.properties,
  "The Advanced Threat Protection settings."
);
@@doc(AdvancedThreatProtectionSettings.create::parameters.resource,
  "Advanced Threat Protection Settings"
);



