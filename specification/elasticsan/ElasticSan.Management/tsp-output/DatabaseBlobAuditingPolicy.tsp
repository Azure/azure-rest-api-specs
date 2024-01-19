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
@doc("A database blob auditing policy.")
@parentResource(Database)
model DatabaseBlobAuditingPolicy
  is ProxyResource<DatabaseBlobAuditingPolicyProperties> {
  @doc("The name of the blob auditing policy.")
  @path
  @key("blobAuditingPolicyName")
  @segment("auditingSettings")
  name: BlobAuditingPolicyName;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DatabaseBlobAuditingPolicies {
  @doc("Gets a database's blob auditing policy.")
  get is ArmResourceRead<DatabaseBlobAuditingPolicy>;

  @doc("Creates or updates a database's blob auditing policy.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DatabaseBlobAuditingPolicy>;

  @doc("Lists auditing settings of a database.")
  listByDatabase is ArmResourceListByParent<DatabaseBlobAuditingPolicy>;
}

@@projectedName(DatabaseBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(DatabaseBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DatabaseBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "The database blob auditing policy."
);
