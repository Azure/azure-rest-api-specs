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
 * A long term retention policy.
 */
@parentResource(ManagedDatabase)
model ManagedInstanceLongTermRetentionPolicy
  is ProxyResource<BaseLongTermRetentionPolicyProperties> {
  /**
   * The policy name. Should always be Default.
   */
  @path
  @key("policyName")
  @segment("backupLongTermRetentionPolicies")
  name: ManagedInstanceLongTermRetentionPolicyName;
}

@armResourceOperations
interface ManagedInstanceLongTermRetentionPolicies {
  /**
   * Gets a managed database's long term retention policy.
   */
  get is ArmResourceRead<ManagedInstanceLongTermRetentionPolicy>;

  /**
   * Sets a managed database's long term retention policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedInstanceLongTermRetentionPolicy>;

  /**
   * Gets a database's long term retention policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedInstanceLongTermRetentionPolicies_ListByDatabase")
  listByDatabase is ArmResourceListByParent<ManagedInstanceLongTermRetentionPolicy>;
}

@@projectedName(ManagedInstanceLongTermRetentionPolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedInstanceLongTermRetentionPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedInstanceLongTermRetentionPolicies.createOrUpdate::parameters.resource,
  "The long term retention policy info."
);
