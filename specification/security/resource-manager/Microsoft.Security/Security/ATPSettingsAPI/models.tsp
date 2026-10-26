import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Common;

namespace ATPSettingsAPI;

/**
 * The Advanced Threat Protection settings.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AdvancedThreatProtectionProperties {
  /**
   * Indicates whether Advanced Threat Protection is enabled.
   */
  #suppress "@azure-tools/typespec-azure-core/no-boolean" "Back compat: Existing AdvancedThreatProtectionProperties.isEnabled has a boolean wire value; preserve the published property contract."
  isEnabled?: boolean;
}
