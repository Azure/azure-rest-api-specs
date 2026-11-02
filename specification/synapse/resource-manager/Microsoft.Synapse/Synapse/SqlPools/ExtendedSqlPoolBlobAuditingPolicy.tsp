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

namespace SqlPools;
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

alias ExtendedSqlPoolBlobAuditingPolicyOps = Azure.ResourceManager.Legacy.LegacyOperations<
  SqlPoolParentParameters,
  {
    /** The name of the blob auditing policy. */
    @segment("extendedAuditingSettings")
    @key
    @path
    blobAuditingPolicyName: SqlPoolLevel.BlobAuditingPolicyName;
  }
>;

@armResourceOperations
interface ExtendedSqlPoolBlobAuditingPolicies {
  /**
   * Gets an extended Sql pool's blob auditing policy.
   */
  get is ExtendedSqlPoolBlobAuditingPolicyOps.Read<ExtendedSqlPoolBlobAuditingPolicy>;

  /**
   * Creates or updates an extended Sql pool's blob auditing policy.
   */
  createOrUpdate is ExtendedSqlPoolBlobAuditingPolicyOps.CreateOrUpdateSync<ExtendedSqlPoolBlobAuditingPolicy>;

  /**
   * Lists extended auditing settings of a Sql pool.
   */
  listBySqlPool is ExtendedSqlPoolBlobAuditingPolicyOps.List<ExtendedSqlPoolBlobAuditingPolicy>;
}

@@doc(ExtendedSqlPoolBlobAuditingPolicy.name, "");
@@doc(ExtendedSqlPoolBlobAuditingPolicy.properties, "Resource properties.");
@@doc(
  ExtendedSqlPoolBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "The extended Sql pool blob auditing policy."
);
