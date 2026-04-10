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
  isEnabled?: boolean;
}

