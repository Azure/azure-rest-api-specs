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
 * A Sql pool blob auditing policy.
 */
@singleton("default")
@parentResource(SqlPool)
model SqlPoolBlobAuditingPolicy
  is Azure.ResourceManager.ProxyResource<SqlPoolBlobAuditingPolicyProperties> {
  ...ResourceNameParameter<
    Resource = SqlPoolBlobAuditingPolicy,
    KeyName = "auditingSetting",
    SegmentName = "auditingSettings",
    NamePattern = ""
  >;

  /**
   * Resource kind.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  kind?: string;
}

@armResourceOperations
interface SqlPoolBlobAuditingPolicies {
  /**
   * Get a SQL pool's blob auditing policy.
   */
  get is ArmResourceRead<SqlPoolBlobAuditingPolicy>;

  /**
   * Creates or updates a SQL pool's blob auditing policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<SqlPoolBlobAuditingPolicy>;

  /**
   * Lists auditing settings of a Sql pool.
   */
  listBySqlPool is ArmResourceListByParent<SqlPoolBlobAuditingPolicy>;
}

@@doc(SqlPoolBlobAuditingPolicy.name, "");
@@doc(SqlPoolBlobAuditingPolicy.properties, "Resource properties.");
@@doc(
  SqlPoolBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "The database blob auditing policy."
);
