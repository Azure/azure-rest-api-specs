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
 * Server's Advanced Threat Protection settings.
 */
@parentResource(Server)
model ServerThreatProtectionSettingsModel
  is Azure.ResourceManager.ProxyResource<ServerThreatProtectionProperties> {
  ...ResourceNameParameter<
    Resource = ServerThreatProtectionSettingsModel,
    KeyName = "threatProtectionName",
    SegmentName = "advancedThreatProtectionSettings",
    NamePattern = "",
    Type = ThreatProtectionName
  >;
}

@armResourceOperations
interface ServerThreatProtectionSettingsModels {
  /**
   * Get a server's Advanced Threat Protection settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServerThreatProtectionSettings_Get")
  get is ArmResourceRead<ServerThreatProtectionSettingsModel>;

  /**
   * Creates or updates a server's Advanced Threat Protection settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ServerThreatProtectionSettings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServerThreatProtectionSettingsModel,
    Response = ArmResourceUpdatedResponse<ServerThreatProtectionSettingsModel> | ArmResourceCreatedResponse<ServerThreatProtectionSettingsModel> | ArmAcceptedLroResponse
  >;

  /**
   * Get a list of server's Threat Protection state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServerThreatProtectionSettings_ListByServer")
  listByServer is ArmResourceListByParent<ServerThreatProtectionSettingsModel>;
}

@@doc(ServerThreatProtectionSettingsModel.name,
  "The name of the Threat Protection state."
);
@@doc(ServerThreatProtectionSettingsModel.properties,
  "Advanced Threat Protection properties."
);
@@doc(ServerThreatProtectionSettingsModels.createOrUpdate::parameters.resource,
  "The Advanced Threat Protection state for the flexible server."
);
