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
 * A short term retention policy.
 */
@parentResource(Database)
model BackupShortTermRetentionPolicy
  is ProxyResource<BackupShortTermRetentionPolicyProperties> {
  /**
   * The policy name. Should always be "default".
   */
  @path
  @key("policyName")
  @segment("backupShortTermRetentionPolicies")
  name: ShortTermRetentionPolicyName;
}

@armResourceOperations
interface BackupShortTermRetentionPolicies {
  /**
   * Gets a database's short term retention policy.
   */
  get is ArmResourceRead<BackupShortTermRetentionPolicy>;

  /**
   * Updates a database's short term retention policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BackupShortTermRetentionPolicy>;

  /**
   * Updates a database's short term retention policy.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    BackupShortTermRetentionPolicy,
    BackupShortTermRetentionPolicy
  >;

  /**
   * Gets a database's short term retention policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupShortTermRetentionPolicies_ListByDatabase")
  listByDatabase is ArmResourceListByParent<BackupShortTermRetentionPolicy>;
}

@@projectedName(BackupShortTermRetentionPolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(BackupShortTermRetentionPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(BackupShortTermRetentionPolicies.createOrUpdate::parameters.resource,
  "The short term retention policy info."
);
@@projectedName(BackupShortTermRetentionPolicies.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(BackupShortTermRetentionPolicies.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(BackupShortTermRetentionPolicies.update::parameters.properties,
  "The short term retention policy info."
);
