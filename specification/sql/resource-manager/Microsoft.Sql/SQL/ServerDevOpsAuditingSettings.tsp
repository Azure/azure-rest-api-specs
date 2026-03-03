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

@armResourceOperations
interface ServerDevOpsAuditSettings {
  /**
   * Gets a server's DevOps audit settings.
   */
  get is ArmResourceRead<ServerDevOpsAuditingSettings>;

  /**
   * Creates or updates a server's DevOps audit settings.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServerDevOpsAuditingSettings,
    Response = ArmResourceUpdatedResponse<ServerDevOpsAuditingSettings> | ArmAcceptedLroResponse
  >;

  /**
   * Lists DevOps audit settings of a server.
   */
  listByServer is ArmResourceListByParent<ServerDevOpsAuditingSettings>;
}

@@doc(ServerDevOpsAuditingSettings.name, "");
@@doc(ServerDevOpsAuditingSettings.properties, "Resource properties.");
@@doc(ServerDevOpsAuditSettings.createOrUpdate::parameters.resource,
  "Properties of DevOps audit settings"
);
