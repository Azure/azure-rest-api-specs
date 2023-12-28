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
@doc("A long term retention policy.")
@parentResource(ManagedDatabase)
model ManagedInstanceLongTermRetentionPolicy
  is ProxyResource<BaseLongTermRetentionPolicyProperties> {
  @doc("The policy name. Should always be Default.")
  @key("policyName")
  @segment("backupLongTermRetentionPolicies")
  name: ManagedInstanceLongTermRetentionPolicyName;
}

@armResourceOperations
interface ManagedInstanceLongTermRetentionPolicies {
  @doc("Gets a managed database's long term retention policy.")
  get is ArmResourceRead<ManagedInstanceLongTermRetentionPolicy>;
  @doc("Sets a managed database's long term retention policy.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ManagedInstanceLongTermRetentionPolicy>;
  @doc("Gets a database's long term retention policy.")
  listByDatabase is ArmResourceListByParent<ManagedInstanceLongTermRetentionPolicy>;
}
