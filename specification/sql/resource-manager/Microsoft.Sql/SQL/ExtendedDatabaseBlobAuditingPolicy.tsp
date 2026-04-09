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
@parentResource(Database)
model ExtendedDatabaseBlobAuditingPolicy
  is Azure.ResourceManager.ProxyResource<ExtendedDatabaseBlobAuditingPolicyProperties> {
  ...ResourceNameParameter<
    Resource = ExtendedDatabaseBlobAuditingPolicy,
    KeyName = "blobAuditingPolicyName",
    SegmentName = "extendedAuditingSettings",
    NamePattern = ""
  >;
}

alias ExtendedDatabaseBlobAuditingPoliciesOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
  ExtendedDatabaseBlobAuditingPolicyNameAlias
>;

@armResourceOperations(#{ omitTags: true })
interface ExtendedDatabaseBlobAuditingPolicies {
  /**
   * Gets an extended database's blob auditing policy.
   */
  @tag("BlobAuditing")
  get is ExtendedDatabaseBlobAuditingPoliciesOps.Read<ExtendedDatabaseBlobAuditingPolicy>;

  /**
   * Creates or updates an extended database's blob auditing policy.
   */
  @tag("BlobAuditing")
  createOrUpdate is ExtendedDatabaseBlobAuditingPoliciesOps.CreateOrUpdateSync<ExtendedDatabaseBlobAuditingPolicy>;

  /**
   * Lists extended auditing settings of a database.
   */
  @tag("BlobAuditing")
  listByDatabase is ExtendedDatabaseBlobAuditingPoliciesOps.List<ExtendedDatabaseBlobAuditingPolicy>;
}

@@doc(ExtendedDatabaseBlobAuditingPolicy.name, "");
@@doc(ExtendedDatabaseBlobAuditingPolicy.properties, "Resource properties.");
@@doc(ExtendedDatabaseBlobAuditingPolicies.createOrUpdate::parameters.resource,
  "The extended database blob auditing policy."
);

alias ExtendedDatabaseBlobAuditingPolicyNameAlias = {
  /** The name of the blob auditing policy. */
  @path
  @segment("extendedAuditingSettings")
  @key
  blobAuditingPolicyName: BlobAuditingPolicyName;
};
