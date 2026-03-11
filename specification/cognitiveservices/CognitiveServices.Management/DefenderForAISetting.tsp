import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;
/**
 * The Defender for AI resource.
 */
@parentResource(Account)
model DefenderForAISetting
  is Azure.ResourceManager.ProxyResource<DefenderForAISettingProperties> {
  ...ResourceNameParameter<
    Resource = DefenderForAISetting,
    KeyName = "defenderForAISettingName",
    SegmentName = "defenderForAISettings",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface DefenderForAISettings {
  /**
   * Gets the specified Defender for AI setting by name.
   */
  get is ArmResourceRead<DefenderForAISetting>;

  /**
   * Creates or Updates the specified Defender for AI setting.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<DefenderForAISetting>;

  /**
   * Updates the specified Defender for AI setting.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    DefenderForAISetting,
    PatchModel = DefenderForAISetting
  >;

  /**
   * Lists the Defender for AI settings.
   */
  list is ArmResourceListByParent<
    DefenderForAISetting,
    Response = ArmResponse<DefenderForAISettingResult>
  >;
}

@@doc(DefenderForAISetting.name, "The name of the defender for AI setting.");
@@encodedName(DefenderForAISetting.etag, "application/json", "etag");
@@doc(DefenderForAISetting.properties,
  "The Defender for AI resource properties."
);
@@doc(DefenderForAISettings.createOrUpdate::parameters.resource,
  "Properties describing the Defender for AI setting."
);
@@doc(DefenderForAISettings.update::parameters.properties,
  "Properties describing the Defender for AI setting."
);
