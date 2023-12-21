import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./BackupVaultResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataProtectionBackup;
@doc("BaseBackupPolicy resource")
@parentResource(BackupVaultResource)
model BaseBackupPolicyResource is ProxyResource<BaseBackupPolicy> {
  @path
  @key("backupPolicyName")
  @segment("backupPolicies")
  name: string;
}

@armResourceOperations
interface BackupPolicies {
  @doc("Gets a backup policy belonging to a backup vault")
  get is ArmResourceRead<BaseBackupPolicyResource>;
  @doc("Creates or Updates a backup policy belonging to a backup vault")
  createOrUpdate is ArmResourceCreateOrReplaceSync<BaseBackupPolicyResource>;
  @doc("Deletes a backup policy belonging to a backup vault")
  delete is ArmResourceDeleteSync<BaseBackupPolicyResource>;
  @doc("Returns list of backup policies belonging to a backup vault")
  list is ArmResourceListByParent<BaseBackupPolicyResource>;
}
