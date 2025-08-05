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

@armResourceOperations
interface AdvancedThreatProtectionSettingsModels {
  /**
   * Gets state of advanced threat protection settings for a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AdvancedThreatProtectionSettings_Get")
  get is ArmResourceRead<AdvancedThreatProtectionSettingsModel>;

  /**
   * Creates or updates a server's Advanced Threat Protection settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ServerThreatProtectionSettings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AdvancedThreatProtectionSettingsModel,
    Response = ArmAcceptedLroResponse
  >;

  /**
   * Lists state of advanced threat protection settings for a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AdvancedThreatProtectionSettings_ListByServer")
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
