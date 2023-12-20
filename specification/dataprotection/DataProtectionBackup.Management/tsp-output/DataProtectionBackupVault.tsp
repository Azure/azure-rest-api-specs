import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataProtectionBackup;
@doc("Backup Vault Resource")
model DataProtectionBackupVault is TrackedResource<BackupVault> {
  @doc("The name of the backup vault.")
  @path
  @key("vaultName")
  @segment("backupVaults")
  name: string;
}

@armResourceOperations
interface DataProtectionBackupVaults {
  @doc("Returns a resource belonging to a resource group.")
  get is ArmResourceRead<DataProtectionBackupVault>;
  @doc("Creates or updates a BackupVault resource belonging to a resource group.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DataProtectionBackupVault>;
  @doc("Updates a BackupVault resource belonging to a resource group. For example, updating tags for a resource.")
  update is ArmResourcePatchAsync<DataProtectionBackupVault, BackupVault>;
  @doc("Deletes a BackupVault resource from the resource group.")
  delete is ArmResourceDeleteAsync<DataProtectionBackupVault>;
  @doc("Returns resource collection belonging to a resource group.")
  getInResourceGroup is ArmResourceListByParent<DataProtectionBackupVault>;
  @doc("Returns resource collection belonging to a subscription.")
  getInSubscription is ArmListBySubscription<DataProtectionBackupVault>;
  @doc("Validate whether adhoc backup will be successful or not")
  validateForBackup is ArmResourceActionAsync<
    DataProtectionBackupVault,
    ValidateForBackupRequest,
    OperationJobExtendedInfo
  >;
  @doc("Triggers export of jobs and returns an OperationID to track.")
  trigger is ArmResourceActionNoResponseContentAsync<
    DataProtectionBackupVault,
    void
  >;
}
