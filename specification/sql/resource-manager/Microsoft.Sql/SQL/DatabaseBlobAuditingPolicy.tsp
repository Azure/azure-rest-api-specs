import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A database blob auditing policy.
 */
@singleton("default")
@parentResource(Database)
model DatabaseBlobAuditingPolicy
  is Azure.ResourceManager.ProxyResource<DatabaseBlobAuditingPolicyProperties> {
  ...ResourceNameParameter<
    Resource = DatabaseBlobAuditingPolicy,
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
interface DatabaseBlobAuditingPolicies {
  /**
   * Gets a database's blob auditing policy.
   */
  get is ArmResourceRead<DatabaseBlobAuditingPolicy>;

  /**
   * Creates or updates a database's blob auditing policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<DatabaseBlobAuditingPolicy>;

  /**
   * Lists auditing settings of a database.
   */
  listByDatabase is ArmResourceListByParent<DatabaseBlobAuditingPolicy>;
}

@@doc(DatabaseBlobAuditingPolicy.name, "");
@@doc(DatabaseBlobAuditingPolicy.properties, "Resource properties.");
@@doc(DatabaseBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "The database blob auditing policy."
);
