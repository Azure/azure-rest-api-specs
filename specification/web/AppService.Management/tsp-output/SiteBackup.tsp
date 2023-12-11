import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./WebSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Backup description.")
@parentResource(WebSite)
model SiteBackup is ProxyResource<BackupItemProperties> {
  @doc("ID of the backup.")
  @path
  @key("backupId")
  @segment("backups")
  name: string;
}

@armResourceOperations
interface SiteBackups {
  @doc("Description for Gets a backup of an app by its ID.")
  getBackupStatus is ArmResourceRead<SiteBackup>;
  @doc("Description for Deletes a backup of an app by its ID.")
  deleteBackup is ArmResourceDeleteSync<SiteBackup>;
  @doc("Description for Gets existing backups of an app.")
  listBackups is ArmResourceListByParent<SiteBackup>;
  @doc("Description for Gets status of a web app backup that may be in progress, including secrets associated with the backup, such as the Azure Storage SAS URL. Also can be used to update the SAS URL for the backup if a new URL is passed in the request body.")
  listBackupStatusSecrets is ArmResourceActionSync<
    SiteBackup,
    BackupRequest,
    SiteBackup
  >;
  @doc("Description for Restores a specific backup to another app (or deployment slot, if specified).")
  restore is ArmResourceActionAsync<SiteBackup, RestoreRequest, {}>;
}
