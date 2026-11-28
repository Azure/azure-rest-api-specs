import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./shared.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

using TypeSpec.Versioning;

using Azure.Core;

namespace Microsoft.DBforPostgreSQL;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ThreatProtectionName {
  string,

  /** Default advanced threat protection settings. */
  Default: "Default",
}

/**
 * Specifies the state of the advanced threat protection, whether it is enabled, disabled, or a state has not been applied yet on the server.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ThreatProtectionState {
  Enabled,
  Disabled,
}

/**
 * List of advanced threat protection settings for a server.
 */
model AdvancedThreatProtectionSettingsList
  is Azure.Core.Page<AdvancedThreatProtectionSettingsModel>;

/**
 * Properties of advanced threat protection state for a server.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AdvancedThreatProtectionSettingsProperties {
  /**
   * Specifies the state of the advanced threat protection, whether it is enabled, disabled, or a state has not been applied yet on the server.
   */
  state: ThreatProtectionState;

  /**
   * Specifies the creation time (UTC) of the policy.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;
}

@@visibility(AdvancedThreatProtectionSettingsList.value, Lifecycle.Read);

/**
 * Advanced threat protection settings of the server.
 */
@parentResource(Server)
model AdvancedThreatProtectionSettingsModel
  is Azure.ResourceManager.ProxyResource<AdvancedThreatProtectionSettingsProperties> {
  ...ResourceNameParameter<
    Resource = AdvancedThreatProtectionSettingsModel,
    KeyName = "threatProtectionName",
    SegmentName = "advancedThreatProtectionSettings",
    NamePattern = "",
    Type = ThreatProtectionName
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface AdvancedThreatProtectionSettingsModels {
  /**
   * Gets state of advanced threat protection settings for a server.
   */
  get is ArmResourceRead<AdvancedThreatProtectionSettingsModel>;

  /**
   * Creates or updates a server's Advanced Threat Protection settings.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AdvancedThreatProtectionSettingsModel,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = AdvancedThreatProtectionSettingsModel> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Lists state of advanced threat protection settings for a server.
   */
  listByServer is ArmResourceListByParent<
    AdvancedThreatProtectionSettingsModel,
    Response = ArmResponse<AdvancedThreatProtectionSettingsList>
  >;
}

@@doc(
  AdvancedThreatProtectionSettingsModel.name,
  "Name of the advanced threat protection settings."
);
@@doc(
  AdvancedThreatProtectionSettingsModel.properties,
  "Advanced threat protection properties."
);
@@doc(
  AdvancedThreatProtectionSettingsModels.createOrUpdate::parameters.resource,
  "The Advanced Threat Protection state for the server."
);
