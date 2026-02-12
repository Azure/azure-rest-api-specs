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
@singleton("default")
@parentResource(Server)
model ExtendedServerBlobAuditingPolicy
  is Azure.ResourceManager.ProxyResource<ExtendedServerBlobAuditingPolicyProperties> {
  ...ResourceNameParameter<
    Resource = ExtendedServerBlobAuditingPolicy,
    KeyName = "extendedAuditingSetting",
    SegmentName = "extendedAuditingSettings",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ExtendedServerBlobAuditingPolicies {
  /**
   * Gets an extended server's blob auditing policy.
   */
  get is ArmResourceRead<ExtendedServerBlobAuditingPolicy>;

  /**
   * Creates or updates an extended server's blob auditing policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ExtendedServerBlobAuditingPolicy,
    Response = ArmResourceUpdatedResponse<ExtendedServerBlobAuditingPolicy> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = ExtendedServerBlobAuditingPolicy> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists extended auditing settings of a server.
   */
  listByServer is ArmResourceListByParent<ExtendedServerBlobAuditingPolicy>;
}

@@doc(ExtendedServerBlobAuditingPolicy.name, "");
@@doc(ExtendedServerBlobAuditingPolicy.properties, "Resource properties.");
@@doc(ExtendedServerBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "Properties of extended blob auditing policy"
);
