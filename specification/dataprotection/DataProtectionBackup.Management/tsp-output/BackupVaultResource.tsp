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
model BackupVaultResource is TrackedResource<BackupVault> {
  @doc("The name of the backup vault.")
  @path
  @key("vaultName")
  @segment("backupVaults")
  name: string;
}

@armResourceOperations
interface BackupVaults {
  @doc("Returns a resource belonging to a resource group.")
  get is ArmResourceRead<BackupVaultResource>;
  @doc("Creates or updates a BackupVault resource belonging to a resource group.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BackupVaultResource>;
  @doc("Updates a BackupVault resource belonging to a resource group. For example, updating tags for a resource.")
  update is ArmResourcePatchAsync<BackupVaultResource, BackupVault>;
  @doc("Deletes a BackupVault resource from the resource group.")
  delete is ArmResourceDeleteAsync<BackupVaultResource>;
  @doc("Returns resource collection belonging to a resource group.")
  getInResourceGroup is ArmResourceListByParent<BackupVaultResource>;
  @doc("Returns resource collection belonging to a subscription.")
  getInSubscription is ArmListBySubscription<BackupVaultResource>;
}

@armResourceOperations
interface BackupInstances {
  @doc("Validate whether adhoc backup will be successful or not")
  validateForBackup is ArmResourceActionAsync<
    BackupVaultResource,
    ValidateForBackupRequest,
    OperationJobExtendedInfo
  >;
}

@armResourceOperations
interface ExportJobs {
  @doc("Triggers export of jobs and returns an OperationID to track.")
  trigger is ArmResourceActionNoResponseContentAsync<BackupVaultResource, void>;
}
