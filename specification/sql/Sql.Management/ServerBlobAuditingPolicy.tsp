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
 * A server blob auditing policy.
 */
@singleton("default")
@parentResource(Server)
model ServerBlobAuditingPolicy
  is Azure.ResourceManager.ProxyResource<ServerBlobAuditingPolicyProperties> {
  ...ResourceNameParameter<
    Resource = ServerBlobAuditingPolicy,
    KeyName = "auditingSetting",
    SegmentName = "auditingSettings",
    NamePattern = ""
  >;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServerBlobAuditingPolicy,
    Response = ArmResourceUpdatedResponse<ServerBlobAuditingPolicy> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = ServerBlobAuditingPolicy> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists auditing settings of a server.
   */
  listByServer is ArmResourceListByParent<ServerBlobAuditingPolicy>;
}

@@doc(ServerBlobAuditingPolicy.name, "");
@@doc(ServerBlobAuditingPolicy.properties, "Resource properties.");
@@doc(ServerBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "Properties of blob auditing policy"
);
