import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A short term retention policy.")
@parentResource(ManagedDatabase)
model ManagedBackupShortTermRetentionPolicy
  is ProxyResource<ManagedBackupShortTermRetentionPolicyProperties> {
  @doc("The policy name.")
  @path
  @key("policyName")
  @segment("backupShortTermRetentionPolicies")
  name: ManagedShortTermRetentionPolicyName;
}

@armResourceOperations
interface ManagedBackupShortTermRetentionPolicies {
  @doc("Gets a managed database's short term retention policy.")
  get is ArmResourceRead<ManagedBackupShortTermRetentionPolicy>;
  @doc("Updates a managed database's short term retention policy.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ManagedBackupShortTermRetentionPolicy>;
  @doc("Updates a managed database's short term retention policy.")
  update is ArmResourcePatchAsync<
    ManagedBackupShortTermRetentionPolicy,
    ManagedBackupShortTermRetentionPolicyProperties
  >;
  @doc("Gets a managed database's short term retention policy list.")
  listByDatabase is ArmResourceListByParent<ManagedBackupShortTermRetentionPolicy>;
}
