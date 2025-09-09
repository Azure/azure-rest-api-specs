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

namespace Microsoft.Web;
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

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** ID of the backup. */
        @path
        @segment("backups")
        @key
        backupId: string,
      }
    > {}

@armResourceOperations
interface BackupItems {
  /**
   * Description for Gets a backup of an app by its ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetBackupStatus")
  getBackupStatus is BackupItemOps.Read<
    BackupItem,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a backup of an app by its ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteBackup")
  deleteBackup is BackupItemOps.DeleteSync<
    BackupItem,
    Response = ArmDeletedResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets existing backups of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListBackups")
  listBackups is BackupItemOps.List<
    BackupItem,
    Response = ArmResponse<BackupItemCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets status of a web app backup that may be in progress, including secrets associated with the backup, such as the Azure Storage SAS URL. Also can be used to update the SAS URL for the backup if a new URL is passed in the request body.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListBackupStatusSecrets")
  @action("list")
  listBackupStatusSecrets is BackupItemOps.ActionSync<
    BackupItem,
    BackupRequest,
    ArmResponse<BackupItem>,
    OverrideErrorType = DefaultErrorResponse
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

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. If a slot is not specified, the API will get a backup of the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** ID of the backup. */
        @path
        @segment("backups")
        @key
        backupId: string,
      }
    > {}

@armResourceOperations
interface BackupItemOperationGroup {
  /**
   * Description for Gets a backup of an app by its ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetBackupStatusSlot")
  getBackupStatusSlot is BackupItemOperationGroupOps.Read<
    BackupItem,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a backup of an app by its ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteBackupSlot")
  deleteBackupSlot is BackupItemOperationGroupOps.DeleteSync<
    BackupItem,
    Response = ArmDeletedResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets existing backups of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListBackupsSlot")
  listBackupsSlot is BackupItemOperationGroupOps.List<
    BackupItem,
    Response = ArmResponse<BackupItemCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets status of a web app backup that may be in progress, including secrets associated with the backup, such as the Azure Storage SAS URL. Also can be used to update the SAS URL for the backup if a new URL is passed in the request body.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListBackupStatusSecretsSlot")
  @action("list")
  listBackupStatusSecretsSlot is BackupItemOperationGroupOps.ActionSync<
    BackupItem,
    BackupRequest,
    ArmResponse<BackupItem>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Restores a specific backup to another app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_RestoreSlot")
  @action("restore")
  restoreSlot is BackupItemOperationGroupOps.ActionAsync<
    BackupItem,
    RestoreRequest,
    OkResponse,
    OverrideErrorType = DefaultErrorResponse
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
