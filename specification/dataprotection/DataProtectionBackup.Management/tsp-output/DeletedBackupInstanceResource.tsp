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
@doc("Deleted Backup Instance")
@parentResource(BackupVaultResource)
model DeletedBackupInstanceResource is ProxyResource<DeletedBackupInstance> {
  @doc("The name of the deleted backup instance")
  @key("backupInstanceName")
  @segment("deletedBackupInstances")
  name: string;
}

@armResourceOperations
interface DeletedBackupInstances {
  @doc("Gets a deleted backup instance with name in a backup vault")
  get is ArmResourceRead<DeletedBackupInstanceResource>;
  @doc("Gets deleted backup instances belonging to a backup vault")
  list is ArmResourceListByParent<DeletedBackupInstanceResource>;

  undelete is ArmResourceActionAsync<DeletedBackupInstanceResource, void, void>;
}
