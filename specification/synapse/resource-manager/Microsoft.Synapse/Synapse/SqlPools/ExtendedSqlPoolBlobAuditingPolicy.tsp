import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * An extended Sql pool blob auditing policy.
 */
@singleton("default")
@parentResource(SqlPool)
model ExtendedSqlPoolBlobAuditingPolicy
  is Azure.ResourceManager.ProxyResource<ExtendedSqlPoolBlobAuditingPolicyProperties> {
  ...ResourceNameParameter<
    Resource = ExtendedSqlPoolBlobAuditingPolicy,
    KeyName = "extendedAuditingSetting",
    SegmentName = "extendedAuditingSettings",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ExtendedSqlPoolBlobAuditingPolicies {
  /**
   * Gets an extended Sql pool's blob auditing policy.
   */
  get is ArmResourceRead<ExtendedSqlPoolBlobAuditingPolicy>;

  /**
   * Creates or updates an extended Sql pool's blob auditing policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<ExtendedSqlPoolBlobAuditingPolicy>;

  /**
   * Lists extended auditing settings of a Sql pool.
   */
  listBySqlPool is ArmResourceListByParent<ExtendedSqlPoolBlobAuditingPolicy>;
}

@@doc(ExtendedSqlPoolBlobAuditingPolicy.name, "");
@@doc(ExtendedSqlPoolBlobAuditingPolicy.properties, "Resource properties.");
@@doc(
  ExtendedSqlPoolBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "The extended Sql pool blob auditing policy."
);
