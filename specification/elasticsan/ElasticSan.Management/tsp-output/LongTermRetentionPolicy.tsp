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
@doc("A long term retention policy.")
@parentResource(Database)
model LongTermRetentionPolicy
  is ProxyResource<BaseLongTermRetentionPolicyProperties> {
  @doc("The policy name. Should always be Default.")
  @path
  @key("policyName")
  @segment("backupLongTermRetentionPolicies")
  name: LongTermRetentionPolicyName;
}

@armResourceOperations
interface LongTermRetentionPolicies {
  @doc("Gets a database's long term retention policy.")
  get is ArmResourceRead<LongTermRetentionPolicy>;

  @doc("Sets a database's long term retention policy.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LongTermRetentionPolicy>;

  @doc("Gets a database's long term retention policy.")
  listByDatabase is ArmResourceListByParent<LongTermRetentionPolicy>;
}

@@projectedName(LongTermRetentionPolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(LongTermRetentionPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(LongTermRetentionPolicies.createOrUpdate::parameters.resource,
  "The long term retention policy info."
);
