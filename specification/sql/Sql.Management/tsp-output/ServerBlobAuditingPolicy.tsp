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
 * A server blob auditing policy.
 */
@parentResource(Server)
model ServerBlobAuditingPolicy
  is ProxyResource<ServerBlobAuditingPolicyProperties> {
  /**
   * The name of the blob auditing policy.
   */
  @path
  @key("blobAuditingPolicyName")
  @segment("auditingSettings")
  name: BlobAuditingPolicyName;
}

@armResourceOperations
interface ServerBlobAuditingPolicies {
  /**
   * Gets a server's blob auditing policy.
   */
  get is ArmResourceRead<ServerBlobAuditingPolicy>;

  /**
   * Creates or updates a server's blob auditing policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServerBlobAuditingPolicy>;

  /**
   * Lists auditing settings of a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServerBlobAuditingPolicies_ListByServer")
  listByServer is ArmResourceListByParent<ServerBlobAuditingPolicy>;
}

@@projectedName(ServerBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServerBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "Properties of blob auditing policy"
);
