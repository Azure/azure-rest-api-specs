import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Volume.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetApp;
/**
 * Quota Rule of a Volume
 */
@parentResource(Volume)
#suppress "@azure-tools/typespec-azure-resource-manager/beyond-nesting-levels" "For backward compatibility"
model VolumeQuotaRule
  is Azure.ResourceManager.TrackedResource<VolumeQuotaRulesProperties> {
  ...ResourceNameParameter<
    Resource = VolumeQuotaRule,
    KeyName = "volumeQuotaRuleName",
    SegmentName = "volumeQuotaRules",
    NamePattern = ""
  >;
}

@armResourceOperations
interface VolumeQuotaRules {
  /**
   * Get details of the specified quota rule
   */
  get is ArmResourceRead<VolumeQuotaRule>;

  /**
   * Create the specified quota rule within the given volume
   */
  create is ArmResourceCreateOrReplaceAsync<
    VolumeQuotaRule,
    LroHeaders = ArmLroLocationHeader<FinalResult = VolumeQuotaRule> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Patch a quota rule
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    VolumeQuotaRule,
    PatchModel = VolumeQuotaRulePatch
  >;

  /**
   * Delete quota rule
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    VolumeQuotaRule,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all quota rules associated with the volume
   */
  listByVolume is ArmResourceListByParent<
    VolumeQuotaRule,
    Response = ArmResponse<VolumeQuotaRulesList>
  >;
}

@@doc(VolumeQuotaRule.name, "The name of volume quota rule");
@@doc(VolumeQuotaRule.properties, "Volume Quota Rule Properties");
@@doc(VolumeQuotaRules.create::parameters.resource,
  "Quota rule object supplied in the body of the operation."
);
@@doc(VolumeQuotaRules.update::parameters.properties,
  "Quota rule object supplied in the body of the operation."
);
