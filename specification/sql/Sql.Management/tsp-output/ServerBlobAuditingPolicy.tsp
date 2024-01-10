import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Sql;
@doc("A server blob auditing policy.")
@parentResource(Server)
model ServerBlobAuditingPolicy
  is ProxyResource<ServerBlobAuditingPolicyProperties> {
  @doc("The name of the blob auditing policy.")
  @key("blobAuditingPolicyName")
  @segment("auditingSettings")
  name: BlobAuditingPolicyName;
}

@armResourceOperations
interface ServerBlobAuditingPolicies {
  @doc("Gets a server's blob auditing policy.")
  get is ArmResourceRead<ServerBlobAuditingPolicy>;

  @doc("Creates or updates a server's blob auditing policy.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServerBlobAuditingPolicy>;

  @doc("Lists auditing settings of a server.")
  listByServer is ArmResourceListByParent<ServerBlobAuditingPolicy>;
}
