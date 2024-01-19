import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
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
interface BackupItems {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets a backup of an app by its ID.")
  @operationId("WebApps_GetBackupStatus")
  getBackupStatus is ArmResourceRead<BackupItem>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Deletes a backup of an app by its ID.")
  @operationId("WebApps_DeleteBackup")
  deleteBackup is ArmResourceDeleteSync<BackupItem>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets existing backups of an app.")
  @operationId("WebApps_ListBackups")
  listBackups is ArmResourceListByParent<BackupItem>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets status of a web app backup that may be in progress, including secrets associated with the backup, such as the Azure Storage SAS URL. Also can be used to update the SAS URL for the backup if a new URL is passed in the request body.")
  @operationId("WebApps_ListBackupStatusSecrets")
  listBackupStatusSecrets is ArmResourceActionSync<
    BackupItem,
    BackupRequest,
    BackupItem
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Restores a specific backup to another app (or deployment slot, if specified).")
  @operationId("WebApps_Restore")
  restore is ArmResourceActionAsync<BackupItem, RestoreRequest, void>;
}

@@projectedName(BackupItems.listBackupStatusSecrets::parameters.body,
  "json",
  "request"
);
@@extension(BackupItems.listBackupStatusSecrets::parameters.body,
  "x-ms-client-name",
  "request"
);
@@doc(BackupItems.listBackupStatusSecrets::parameters.body,
  "Information on backup request."
);
@@projectedName(BackupItems.restore::parameters.body, "json", "request");
@@extension(BackupItems.restore::parameters.body,
  "x-ms-client-name",
  "request"
);
@@doc(BackupItems.restore::parameters.body, "Information on restore request .");
