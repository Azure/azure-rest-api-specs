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
@parentResource(Server)
model ServerBlobAuditingPolicy
  is Azure.ResourceManager.ProxyResource<ServerBlobAuditingPolicyProperties> {
  ...ResourceNameParameter<
    Resource = ServerBlobAuditingPolicy,
    KeyName = "blobAuditingPolicyName",
    SegmentName = "auditingSettings",
    NamePattern = ""
  >;
}

alias ServerBlobAuditingPoliciesOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the server. */
    @path
    @segment("servers")
    @key
    serverName: string;
  },
  ServerBlobAuditingPolicyNameAlias
>;

@armResourceOperations(#{ omitTags: true })
interface ServerBlobAuditingPolicies {
  /**
   * Gets a server's blob auditing policy.
   */
  @tag("BlobAuditing")
  get is ServerBlobAuditingPoliciesOps.Read<ServerBlobAuditingPolicy>;

  /**
   * Creates or updates a server's blob auditing policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("BlobAuditing")
  createOrUpdate is ServerBlobAuditingPoliciesOps.CreateOrUpdateAsync<
    ServerBlobAuditingPolicy,
    Response = ArmResourceUpdatedResponse<ServerBlobAuditingPolicy> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ServerBlobAuditingPolicy> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Lists auditing settings of a server.
   */
  @tag("BlobAuditing")
  listByServer is ArmResourceListByParent<ServerBlobAuditingPolicy>;
}

@@doc(ServerBlobAuditingPolicy.name, "");
@@doc(ServerBlobAuditingPolicy.properties, "Resource properties.");
@@doc(ServerBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "Properties of blob auditing policy"
);

alias ServerBlobAuditingPolicyNameAlias = {
  /** The name of the blob auditing policy. */
  @path
  @segment("auditingSettings")
  @key
  blobAuditingPolicyName: BlobAuditingPolicyName;
};
