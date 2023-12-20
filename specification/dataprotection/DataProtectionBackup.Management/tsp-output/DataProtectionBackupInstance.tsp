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
@doc("BackupInstance Resource")
@parentResource(DataProtectionBackupVault)
model DataProtectionBackupInstance is ProxyResource<BackupInstance> {
  @doc("The name of the backup instance.")
  @path
  @key("backupInstanceName")
  @segment("backupInstances")
  name: string;
}

@armResourceOperations
interface DataProtectionBackupInstances {
  @doc("Gets a backup instance with name in a backup vault")
  get is ArmResourceRead<DataProtectionBackupInstance>;
  @doc("Create or update a backup instance in a backup vault")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DataProtectionBackupInstance>;
  @doc("Delete a backup instance in a backup vault")
  delete is ArmResourceDeleteAsync<DataProtectionBackupInstance>;
  @doc("Gets a backup instances belonging to a backup vault")
  list is ArmResourceListByParent<DataProtectionBackupInstance>;
  @doc("Trigger adhoc backup ")
  adhocBackup is ArmResourceActionAsync<
    DataProtectionBackupInstance,
    TriggerBackupRequest,
    OperationJobExtendedInfo
  >;
  @doc("rehydrate recovery point for restore for a BackupInstance")
  triggerRehydrate is ArmResourceActionNoResponseContentAsync<
    DataProtectionBackupInstance,
    AzureBackupRehydrationRequest
  >;
  @doc("Triggers restore for a BackupInstance")
  triggerRestore is ArmResourceActionAsync<
    DataProtectionBackupInstance,
    AzureBackupRestoreRequest,
    OperationJobExtendedInfo
  >;
  @doc("This operation will resume backups for backup instance")
  resumeBackups is ArmResourceActionAsync<
    DataProtectionBackupInstance,
    void,
    void
  >;
  @doc("This operation will resume protection for a stopped backup instance")
  resumeProtection is ArmResourceActionAsync<
    DataProtectionBackupInstance,
    void,
    void
  >;
  @doc("This operation will stop protection of a backup instance and data will be held forever")
  stopProtection is ArmResourceActionAsync<
    DataProtectionBackupInstance,
    void,
    void
  >;
  @doc("This operation will stop backup for a backup instance and retains the backup data as per the policy (except latest Recovery point, which will be retained forever)")
  suspendBackups is ArmResourceActionAsync<
    DataProtectionBackupInstance,
    void,
    void
  >;
  @doc("""
Sync backup instance again in case of failure
This action will retry last failed operation and will bring backup instance to valid state
""")
  syncBackupInstance is ArmResourceActionAsync<
    DataProtectionBackupInstance,
    SyncBackupInstanceRequest,
    void
  >;
  @doc("Validates if Restore can be triggered for a DataSource")
  validateForRestore is ArmResourceActionAsync<
    DataProtectionBackupInstance,
    ValidateRestoreRequestObject,
    OperationJobExtendedInfo
  >;

  find is ArmResourceActionSync<
    DataProtectionBackupInstance,
    AzureBackupFindRestorableTimeRangesRequest,
    AzureBackupFindRestorableTimeRangesResponseResource
  >;
}
