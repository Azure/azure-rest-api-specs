import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A short term retention policy.
 */
@parentResource(ManagedDatabase)
model ManagedBackupShortTermRetentionPolicy
  is ProxyResource<ManagedBackupShortTermRetentionPolicyProperties> {
  /**
   * The policy name.
   */
  @path
  @key("policyName")
  @segment("backupShortTermRetentionPolicies")
  name: ManagedShortTermRetentionPolicyName;
}

@armResourceOperations
interface ManagedBackupShortTermRetentionPolicies {
  /**
   * Gets a managed database's short term retention policy.
   */
  get is ArmResourceRead<ManagedBackupShortTermRetentionPolicy>;

  /**
   * Updates a managed database's short term retention policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedBackupShortTermRetentionPolicy>;

  /**
   * Updates a managed database's short term retention policy.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    ManagedBackupShortTermRetentionPolicy,
    ManagedBackupShortTermRetentionPolicy
  >;

  /**
   * Gets a managed database's short term retention policy list.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedBackupShortTermRetentionPolicies_ListByDatabase")
  listByDatabase is ArmResourceListByParent<ManagedBackupShortTermRetentionPolicy>;
}

@@projectedName(ManagedBackupShortTermRetentionPolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedBackupShortTermRetentionPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedBackupShortTermRetentionPolicies.createOrUpdate::parameters.resource,
  "The short term retention policy info."
);
@@projectedName(ManagedBackupShortTermRetentionPolicies.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ManagedBackupShortTermRetentionPolicies.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedBackupShortTermRetentionPolicies.update::parameters.properties,
  "The short term retention policy info."
);
