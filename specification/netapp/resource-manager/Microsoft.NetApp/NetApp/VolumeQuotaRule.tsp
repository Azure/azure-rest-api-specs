import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Volume.tsp";

using Rest;
using Azure.ResourceManager;
using Http;

namespace Microsoft.NetApp;
/**
 * Quota Rule of a Volume
 */
#suppress "@azure-tools/typespec-azure-resource-manager/beyond-nesting-levels" "For backward compatibility"
@parentResource(Volume)
model VolumeQuotaRule
  is Azure.ResourceManager.TrackedResource<VolumeQuotaRulesProperties> {
  ...ResourceNameParameter<
    Resource = VolumeQuotaRule,
    KeyName = "volumeQuotaRuleName",
    SegmentName = "volumeQuotaRules",
    NamePattern = ""
  >;
}

/**
 * List of Volume Quota Rules
 */
model VolumeQuotaRulesList is Azure.Core.Page<VolumeQuotaRule>;

/**
 * Volume Quota Rule properties
 */
model VolumeQuotaRulesProperties {
  /**
   * Gets the status of the VolumeQuotaRule at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetAppProvisioningState;

  /**
   * Size of quota
   */
  quotaSizeInKiBs?: int64;

  /**
   * Type of quota
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  quotaType?: QuotaType;

  /**
   * UserID/GroupID/SID based on the quota target type. UserID and groupID can be found by running ‘id’ or ‘getent’ command for the user or group and SID can be found by running <wmic useraccount where name='user-name' get sid>
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  quotaTarget?: string;
}

/**
 * Type of quota
 */
union QuotaType {
  string,

  /**
   * Default user quota
   */
  DefaultUserQuota: "DefaultUserQuota",

  /**
   * Default group quota
   */
  DefaultGroupQuota: "DefaultGroupQuota",

  /**
   * Individual user quota
   */
  IndividualUserQuota: "IndividualUserQuota",

  /**
   * Individual group quota
   */
  IndividualGroupQuota: "IndividualGroupQuota",
}

/**
 * Patchable Quota Rule of a Volume
 */
model VolumeQuotaRulePatch {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Volume Quota Rule Properties
   */
  properties?: VolumeQuotaRulesProperties;
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
