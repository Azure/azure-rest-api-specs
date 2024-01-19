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
@doc("A server DevOps auditing settings.")
@parentResource(Server)
model ServerDevOpsAuditingSettings
  is ProxyResource<ServerDevOpsAuditSettingsProperties> {
  @doc("The name of the devops audit settings. This should always be Default.")
  @path
  @key("devOpsAuditingSettingsName")
  @segment("devOpsAuditingSettings")
  name: string;
}

@armResourceOperations
@projectedName("client", "ServerDevOpsAuditingSettings")
interface ServerDevOpsAuditingSettingsOperationGroup {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a server's DevOps audit settings.")
  @operationId("ServerDevOpsAuditSettings_Get")
  get is ArmResourceRead<ServerDevOpsAuditingSettings>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a server's DevOps audit settings.")
  @operationId("ServerDevOpsAuditSettings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ServerDevOpsAuditingSettings,
    BaseParameters<ServerDevOpsAuditingSettings>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists DevOps audit settings of a server.")
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
