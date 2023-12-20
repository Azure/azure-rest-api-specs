import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataProtectionBackupVault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataProtectionBackup;
@doc("Deleted Backup Instance")
@parentResource(DataProtectionBackupVault)
model DeletedDataProtectionBackupInstance
  is ProxyResource<DeletedBackupInstance> {
  @doc("The name of the deleted backup instance")
  @path
  @key("backupInstanceName")
  @segment("deletedBackupInstances")
  name: string;
}

@armResourceOperations
interface DeletedDataProtectionBackupInstances {
  @doc("Gets a deleted backup instance with name in a backup vault")
  get is ArmResourceRead<DeletedDataProtectionBackupInstance>;
  @doc("Gets deleted backup instances belonging to a backup vault")
  list is ArmResourceListByParent<DeletedDataProtectionBackupInstance>;

  undelete is ArmResourceActionAsync<
    DeletedDataProtectionBackupInstance,
    void,
    void
  >;
}
