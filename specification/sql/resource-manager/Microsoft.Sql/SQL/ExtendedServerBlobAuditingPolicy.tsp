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
 * An extended server blob auditing policy.
 */
@parentResource(Server)
model ExtendedServerBlobAuditingPolicy
  is Azure.ResourceManager.ProxyResource<ExtendedServerBlobAuditingPolicyProperties> {
  ...ResourceNameParameter<
    Resource = ExtendedServerBlobAuditingPolicy,
    KeyName = "blobAuditingPolicyName",
    SegmentName = "extendedAuditingSettings",
    NamePattern = ""
  >;
}

alias ExtendedServerBlobAuditingPolicyOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
  {
    /** The name of the blob auditing policy. */
    @path
    @segment("extendedAuditingSettings")
    @key
    blobAuditingPolicyName: BlobAuditingPolicyName;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface ExtendedServerBlobAuditingPolicies {
  /**
   * Gets an extended server's blob auditing policy.
   */
  @tag("BlobAuditing")
  get is ExtendedServerBlobAuditingPolicyOps.Read<ExtendedServerBlobAuditingPolicy>;

  /**
   * Creates or updates an extended server's blob auditing policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("BlobAuditing")
  createOrUpdate is ExtendedServerBlobAuditingPolicyOps.CreateOrUpdateAsync<
    ExtendedServerBlobAuditingPolicy,
    Response = ArmResourceUpdatedResponse<ExtendedServerBlobAuditingPolicy> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ExtendedServerBlobAuditingPolicy> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Lists extended auditing settings of a server.
   */
  @tag("BlobAuditing")
  listByServer is ExtendedServerBlobAuditingPolicyOps.List<ExtendedServerBlobAuditingPolicy>;
}

@@doc(ExtendedServerBlobAuditingPolicy.name, "");
@@doc(ExtendedServerBlobAuditingPolicy.properties, "Resource properties.");
@@doc(ExtendedServerBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "Properties of extended blob auditing policy"
);
