import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforPostgreSQL;
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

@@doc(AdvancedThreatProtectionSettingsModel.name,
  "Name of the advanced threat protection settings."
);
@@doc(AdvancedThreatProtectionSettingsModel.properties,
  "Advanced threat protection properties."
);
@@doc(AdvancedThreatProtectionSettingsModels.createOrUpdate::parameters.resource,
  "The Advanced Threat Protection state for the server."
);
