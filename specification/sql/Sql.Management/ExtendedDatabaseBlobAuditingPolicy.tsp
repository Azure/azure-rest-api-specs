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
 * An extended database blob auditing policy.
 */
@singleton("default")
@parentResource(Database)
model ExtendedDatabaseBlobAuditingPolicy
  is Azure.ResourceManager.ProxyResource<ExtendedDatabaseBlobAuditingPolicyProperties> {
  ...ResourceNameParameter<
    Resource = ExtendedDatabaseBlobAuditingPolicy,
    KeyName = "extendedAuditingSetting",
    SegmentName = "extendedAuditingSettings",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ExtendedDatabaseBlobAuditingPolicies {
  /**
   * Gets an extended database's blob auditing policy.
   */
  get is ArmResourceRead<ExtendedDatabaseBlobAuditingPolicy>;

  /**
   * Creates or updates an extended database's blob auditing policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<ExtendedDatabaseBlobAuditingPolicy>;

  /**
   * Lists extended auditing settings of a database.
   */
  listByDatabase is ArmResourceListByParent<ExtendedDatabaseBlobAuditingPolicy>;
}

@@doc(ExtendedDatabaseBlobAuditingPolicy.name, "");
@@doc(ExtendedDatabaseBlobAuditingPolicy.properties, "Resource properties.");
@@doc(ExtendedDatabaseBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "The extended database blob auditing policy."
);
