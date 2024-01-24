import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A server DevOps auditing settings.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Server)
@Azure.ResourceManager.Private.armResourceInternal(
  ServerDevOpsAuditSettingsProperties
)
@includeInapplicableMetadataInPayload(false)
model ServerDevOpsAuditingSettings extends ProxyResource {
  /**
   * The name of the devops audit settings. This should always be Default.
   */
  @path
  @key("devOpsAuditingSettingsName")
  @segment("devOpsAuditingSettings")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ServerDevOpsAuditSettingsProperties;
}

@armResourceOperations
@projectedName("client", "ServerDevOpsAuditingSettings")
interface ServerDevOpsAuditingSettingsOperationGroup {
  /**
   * Gets a server's DevOps audit settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServerDevOpsAuditSettings_Get")
  get is ArmResourceRead<ServerDevOpsAuditingSettings>;

  /**
   * Creates or updates a server's DevOps audit settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServerDevOpsAuditSettings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServerDevOpsAuditingSettings,
    BaseParameters<ServerDevOpsAuditingSettings>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists DevOps audit settings of a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServerDevOpsAuditSettings_ListByServer")
  listByServer is ArmResourceListByParent<ServerDevOpsAuditingSettings>;
}

@@projectedName(ServerDevOpsAuditingSettingsOperationGroup.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServerDevOpsAuditingSettingsOperationGroup.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerDevOpsAuditingSettingsOperationGroup.createOrUpdate::parameters.resource,
  "Properties of DevOps audit settings"
);
