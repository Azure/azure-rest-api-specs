import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Backup description.
 */
@parentResource(Site)
model BackupItem is Azure.ResourceManager.ProxyResource<BackupItemProperties> {
  ...ResourceNameParameter<
    Resource = BackupItem,
    KeyName = "backupId",
    SegmentName = "backups",
    NamePattern = ""
  >;
}

@armResourceOperations
interface BackupItemOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = BackupItem,
        KeyName = "backupId",
        SegmentName = "backups",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface BackupItems {
  /**
   * Description for Gets a backup of an app by its ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetBackupStatus")
  getBackupStatus is BackupItemOps.Read<BackupItem>;

  /**
   * Description for Deletes a backup of an app by its ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteBackup")
  deleteBackup is BackupItemOps.DeleteSync<
    BackupItem,
    Response = ArmDeletedResponse
  >;

  /**
   * Description for Gets existing backups of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListBackups")
  listBackups is BackupItemOps.List<
    BackupItem,
    Response = ArmResponse<BackupItemCollection>
  >;

  /**
   * Description for Gets status of a web app backup that may be in progress, including secrets associated with the backup, such as the Azure Storage SAS URL. Also can be used to update the SAS URL for the backup if a new URL is passed in the request body.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("list")
  @operationId("WebApps_ListBackupStatusSecrets")
  listBackupStatusSecrets is BackupItemOps.ActionSync<
    BackupItem,
    BackupRequest,
    ArmResponse<BackupItem>
  >;

  /**
   * Description for Restores a specific backup to another app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_Restore")
  restore is BackupItemOps.ActionAsync<BackupItem, RestoreRequest, OkResponse>;
}
@armResourceOperations
interface BackupItemOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "slot",
          SegmentName = "slots",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = BackupItem,
        KeyName = "backupId",
        SegmentName = "backups",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface BackupItemOperationGroup {
  /**
   * Description for Gets a backup of an app by its ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetBackupStatusSlot")
  getBackupStatusSlot is BackupItemOperationGroupOps.Read<BackupItem>;

  /**
   * Description for Deletes a backup of an app by its ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteBackupSlot")
  deleteBackupSlot is BackupItemOperationGroupOps.DeleteSync<
    BackupItem,
    Response = ArmDeletedResponse
  >;

  /**
   * Description for Gets existing backups of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListBackupsSlot")
  listBackupsSlot is BackupItemOperationGroupOps.List<
    BackupItem,
    Response = ArmResponse<BackupItemCollection>
  >;

  /**
   * Description for Gets status of a web app backup that may be in progress, including secrets associated with the backup, such as the Azure Storage SAS URL. Also can be used to update the SAS URL for the backup if a new URL is passed in the request body.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("list")
  @operationId("WebApps_ListBackupStatusSecretsSlot")
  listBackupStatusSecretsSlot is BackupItemOperationGroupOps.ActionSync<
    BackupItem,
    BackupRequest,
    ArmResponse<BackupItem>
  >;

  /**
   * Description for Restores a specific backup to another app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("restore")
  @operationId("WebApps_RestoreSlot")
  restoreSlot is BackupItemOperationGroupOps.ActionAsync<
    BackupItem,
    RestoreRequest,
    OkResponse
  >;
}

@@doc(BackupItem.name, "ID of the backup.");
@@doc(BackupItem.properties, "BackupItem resource specific properties");
@@doc(BackupItems.listBackupStatusSecrets::parameters.body,
  "Information on backup request."
);
@@doc(BackupItems.restore::parameters.body, "Information on restore request .");
@@doc(BackupItemOperationGroup.listBackupStatusSecretsSlot::parameters.body,
  "Information on backup request."
);
@@doc(BackupItemOperationGroup.restoreSlot::parameters.body,
  "Information on restore request ."
);
