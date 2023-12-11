import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NetAppAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetApp;
@doc("Backup policy information")
@parentResource(NetAppAccount)
model NetAppBackupPolicy is TrackedResource<BackupPolicyProperties> {
  @doc("Backup policy Name which uniquely identify backup policy.")
  @path
  @key("backupPolicyName")
  @segment("backupPolicies")
  name: string;
}

@armResourceOperations
interface NetAppBackupPolicies {
  @doc("Get a particular backup Policy")
  get is ArmResourceRead<NetAppBackupPolicy>;
  @doc("Create a backup policy for Netapp Account")
  create is ArmResourceCreateOrUpdateAsync<NetAppBackupPolicy>;
  @doc("Patch a backup policy for Netapp Account")
  update is ArmResourcePatchAsync<NetAppBackupPolicy, BackupPolicyProperties>;
  @doc("Delete backup policy")
  delete is ArmResourceDeleteAsync<NetAppBackupPolicy>;
  @doc("List backup policies for Netapp Account")
  list is ArmResourceListByParent<NetAppBackupPolicy>;
}
