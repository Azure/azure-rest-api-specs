import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlServer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A server DevOps auditing settings.")
@parentResource(SqlServer)
model SqlServerDevOpsAuditingSetting
  is ProxyResource<ServerDevOpsAuditSettingsProperties> {
  @doc("The name of the devops audit settings. This should always be Default.")
  @path
  @key("devOpsAuditingSettingsName")
  @segment("devOpsAuditingSettings")
  name: string;
}

@armResourceOperations
interface SqlServerDevOpsAuditingSettings {
  @doc("Gets a server's DevOps audit settings.")
  get is ArmResourceRead<SqlServerDevOpsAuditingSetting>;
  @doc("Creates or updates a server's DevOps audit settings.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SqlServerDevOpsAuditingSetting>;
  @doc("Lists DevOps audit settings of a server.")
  listByServer is ArmResourceListByParent<SqlServerDevOpsAuditingSetting>;
}
