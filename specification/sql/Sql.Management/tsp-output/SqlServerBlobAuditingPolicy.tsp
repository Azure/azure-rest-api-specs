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
@doc("A server blob auditing policy.")
@parentResource(SqlServer)
model SqlServerBlobAuditingPolicy
  is ProxyResource<ServerBlobAuditingPolicyProperties> {
  @doc("The name of the blob auditing policy.")
  @path
  @key("blobAuditingPolicyName")
  @segment("auditingSettings")
  name: BlobAuditingPolicyName;
}

@armResourceOperations
interface SqlServerBlobAuditingPolicies {
  @doc("Gets a server's blob auditing policy.")
  get is ArmResourceRead<SqlServerBlobAuditingPolicy>;
  @doc("Creates or updates a server's blob auditing policy.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SqlServerBlobAuditingPolicy>;
  @doc("Lists auditing settings of a server.")
  listByServer is ArmResourceListByParent<SqlServerBlobAuditingPolicy>;
}
