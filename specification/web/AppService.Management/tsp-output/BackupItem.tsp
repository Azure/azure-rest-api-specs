import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Backup description.")
@parentResource(Site)
model BackupItem is ProxyResource<BackupItemProperties> {
  @doc("ID of the backup.")
  @path
  @key("backupId")
  @segment("backups")
  name: string;
}

@armResourceOperations
interface WebApps {
  @doc("Description for Gets a backup of an app by its ID.")
  getBackupStatus is ArmResourceRead<BackupItem>;
  @doc("Description for Deletes a backup of an app by its ID.")
  deleteBackup is ArmResourceDeleteSync<BackupItem>;
  @doc("Description for Gets existing backups of an app.")
  listBackups is ArmResourceListByParent<BackupItem>;
  @doc("Description for Gets status of a web app backup that may be in progress, including secrets associated with the backup, such as the Azure Storage SAS URL. Also can be used to update the SAS URL for the backup if a new URL is passed in the request body.")
  listBackupStatusSecrets is ArmResourceActionSync<
    BackupItem,
    BackupRequest,
    BackupItem
  >;
  @doc("Description for Restores a specific backup to another app (or deployment slot, if specified).")
  restore is ArmResourceActionAsync<BackupItem, RestoreRequest, void>;
}
