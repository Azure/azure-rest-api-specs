import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * An extended database blob auditing policy.
 */
@parentResource(Database)
model ExtendedDatabaseBlobAuditingPolicy
  is ProxyResource<ExtendedDatabaseBlobAuditingPolicyProperties> {
  /**
   * The name of the blob auditing policy.
   */
  @path
  @key("blobAuditingPolicyName")
  @segment("extendedAuditingSettings")
  name: BlobAuditingPolicyName;
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ExtendedDatabaseBlobAuditingPolicies_ListByDatabase")
  listByDatabase is ArmResourceListByParent<ExtendedDatabaseBlobAuditingPolicy>;
}

@@projectedName(ExtendedDatabaseBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ExtendedDatabaseBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ExtendedDatabaseBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "The extended database blob auditing policy."
);
