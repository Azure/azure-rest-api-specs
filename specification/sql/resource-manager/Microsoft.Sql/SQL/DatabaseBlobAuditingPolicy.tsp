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
@parentResource(Database)
model DatabaseBlobAuditingPolicy
  is Azure.ResourceManager.ProxyResource<DatabaseBlobAuditingPolicyProperties> {
  ...ResourceNameParameter<
    Resource = DatabaseBlobAuditingPolicy,
    KeyName = "blobAuditingPolicyName",
    SegmentName = "auditingSettings",
    NamePattern = ""
  >;

  /**
   * Resource kind.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  kind?: string;
}

alias DatabaseBlobAuditingPoliciesOps = Azure.ResourceManager.Legacy.LegacyOperations<
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

    /** The name of the database. */
    @path
    @segment("databases")
    @key
    databaseName: string;
  },
  {
    /** The name of the blob auditing policy. */
    @path
    @segment("auditingSettings")
    @key
    blobAuditingPolicyName: BlobAuditingPolicyName;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface DatabaseBlobAuditingPolicies {
  /**
   * Gets a database's blob auditing policy.
   */
  @tag("BlobAuditing")
  get is DatabaseBlobAuditingPoliciesOps.Read<DatabaseBlobAuditingPolicy>;

  /**
   * Creates or updates a database's blob auditing policy.
   */
  @tag("BlobAuditing")
  createOrUpdate is DatabaseBlobAuditingPoliciesOps.CreateOrUpdateSync<DatabaseBlobAuditingPolicy>;

  /**
   * Lists auditing settings of a database.
   */
  @tag("BlobAuditing")
  listByDatabase is DatabaseBlobAuditingPoliciesOps.List<DatabaseBlobAuditingPolicy>;
}

@@doc(DatabaseBlobAuditingPolicy.name, "");
@@doc(DatabaseBlobAuditingPolicy.properties, "Resource properties.");
@@doc(DatabaseBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "The database blob auditing policy."
);
