import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A short term retention policy.")
@parentResource(Database)
model BackupShortTermRetentionPolicy
  is ProxyResource<BackupShortTermRetentionPolicyProperties> {
  @doc("The policy name. Should always be \"default\".")
  @path
  @key("policyName")
  @segment("backupShortTermRetentionPolicies")
  name: ShortTermRetentionPolicyName;
}

@armResourceOperations
interface BackupShortTermRetentionPolicies {
  @doc("Gets a database's short term retention policy.")
  get is ArmResourceRead<BackupShortTermRetentionPolicy>;
  @doc("Updates a database's short term retention policy.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BackupShortTermRetentionPolicy>;
  @doc("Updates a database's short term retention policy.")
  update is ArmResourcePatchAsync<
    BackupShortTermRetentionPolicy,
    BackupShortTermRetentionPolicyProperties
  >;
  @doc("Gets a database's short term retention policy.")
  listByDatabase is ArmResourceListByParent<BackupShortTermRetentionPolicy>;
}
