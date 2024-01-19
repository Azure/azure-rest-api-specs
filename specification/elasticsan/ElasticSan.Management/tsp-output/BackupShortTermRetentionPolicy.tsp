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
  update is ArmCustomPatchAsync<
    BackupShortTermRetentionPolicy,
    BackupShortTermRetentionPolicy
  >;

  @doc("Gets a database's short term retention policy.")
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
