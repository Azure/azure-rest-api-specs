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
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
  ...Azure.ResourceManager.Legacy.EntityTagProperty;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@armResourceOperations
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "For backward compatibility"
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
@@doc(DefenderForAISetting.properties,
  "The Defender for AI resource properties."
);
@@doc(DefenderForAISettings.createOrUpdate::parameters.resource,
  "Properties describing the Defender for AI setting."
);
@@doc(DefenderForAISettings.update::parameters.properties,
  "Properties describing the Defender for AI setting."
);
