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

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
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
  @summary("Gets a backup of an app by its ID.")
  getBackupStatus is BackupItemOps.Read<
    BackupItem,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a backup of an app by its ID.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Deletes a backup of an app by its ID.")
  deleteBackup is BackupItemOps.DeleteSync<
    BackupItem,
    Response = ArmDeletedResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets existing backups of an app.
   */
  @summary("Gets existing backups of an app.")
  listBackups is BackupItemOps.List<
    BackupItem,
    Response = ArmResponse<BackupItemCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets status of a web app backup that may be in progress, including secrets associated with the backup, such as the Azure Storage SAS URL. Also can be used to update the SAS URL for the backup if a new URL is passed in the request body.
   */
  @summary("Gets status of a web app backup that may be in progress, including secrets associated with the backup, such as the Azure Storage SAS URL. Also can be used to update the SAS URL for the backup if a new URL is passed in the request body.")
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
  @summary("Restores a specific backup to another app (or deployment slot, if specified).")
  restore is BackupItemOps.ActionAsync<
    BackupItem,
    RestoreRequest,
    {
      @body body: void;
    },
    OverrideErrorType = DefaultErrorResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;
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
  @summary("Gets a backup of an app by its ID.")
  getBackupStatusSlot is BackupItemOperationGroupOps.Read<
    BackupItem,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a backup of an app by its ID.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Deletes a backup of an app by its ID.")
  deleteBackupSlot is BackupItemOperationGroupOps.DeleteSync<
    BackupItem,
    Response = ArmDeletedResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets existing backups of an app.
   */
  @summary("Gets existing backups of an app.")
  listBackupsSlot is BackupItemOperationGroupOps.List<
    BackupItem,
    Response = ArmResponse<BackupItemCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets status of a web app backup that may be in progress, including secrets associated with the backup, such as the Azure Storage SAS URL. Also can be used to update the SAS URL for the backup if a new URL is passed in the request body.
   */
  @summary("Gets status of a web app backup that may be in progress, including secrets associated with the backup, such as the Azure Storage SAS URL. Also can be used to update the SAS URL for the backup if a new URL is passed in the request body.")
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
  @summary("Restores a specific backup to another app (or deployment slot, if specified).")
  @action("restore")
  restoreSlot is BackupItemOperationGroupOps.ActionAsync<
    BackupItem,
    RestoreRequest,
    {
      @body body: void;
    },
    OverrideErrorType = DefaultErrorResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
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
