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

namespace Microsoft.Sql;
/**
 * A server DevOps auditing settings.
 */
@parentResource(Server)
model ServerDevOpsAuditingSettings
  is Azure.ResourceManager.ProxyResource<ServerDevOpsAuditSettingsProperties> {
  ...ResourceNameParameter<
    Resource = ServerDevOpsAuditingSettings,
    KeyName = "devOpsAuditingSettingsName",
    SegmentName = "devOpsAuditingSettings",
    NamePattern = "",
    Type = DevOpsAuditingSettingsName
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface ServerDevOpsAuditSettings {
  /**
   * Gets a server's DevOps audit settings.
   */
  @tag("ServerDevOpsAudit")
  get is ArmResourceRead<ServerDevOpsAuditingSettings>;

  /**
   * Creates or updates a server's DevOps audit settings.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @tag("ServerDevOpsAudit")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServerDevOpsAuditingSettings,
    Response = ArmResourceUpdatedResponse<ServerDevOpsAuditingSettings> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ServerDevOpsAuditingSettings>>
  >;

  /**
   * Lists DevOps audit settings of a server.
   */
  @tag("ServerDevOpsAudit")
  listByServer is ArmResourceListByParent<
    ServerDevOpsAuditingSettings,
    Response = ServerDevOpsAuditSettingsListResult
  >;
}

@@doc(ServerDevOpsAuditingSettings.name, "");
@@doc(ServerDevOpsAuditingSettings.properties, "Resource properties.");
@@doc(ServerDevOpsAuditSettings.createOrUpdate::parameters.resource,
  "Properties of DevOps audit settings"
);
