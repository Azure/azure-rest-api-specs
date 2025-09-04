import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BackupVault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetApp;
/**
 * Backup under a Backup Vault
 */
@parentResource(BackupVault)
model Backup is Azure.ResourceManager.ProxyResource<BackupProperties, false> {
  ...ResourceNameParameter<
    Resource = Backup,
    KeyName = "backupName",
    SegmentName = "backups",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_.]{0,255}$"
  >;
}

@armResourceOperations
interface Backups {
  /**
   * Get the specified Backup under Backup Vault.
   */
  get is ArmResourceRead<Backup>;

  /**
   * Create a backup under the Backup Vault
   */
  create is ArmResourceCreateOrReplaceAsync<Backup>;

  /**
   * Patch a Backup under the Backup Vault
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    Backup,
    PatchModel = BackupPatch,
    Response = ArmResponse<Backup> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = NetAppAccount> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: Backup;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Delete a Backup under the Backup Vault
   */
  delete is ArmResourceDeleteWithoutOkAsync<Backup>;

  /**
   * List all backups Under a Backup Vault
   */
  listByVault is ArmResourceListByParent<
    Backup,
    Parameters = {
      /**
       * An option to specify the VolumeResourceId. If present, then only returns the backups under the specified volume
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<BackupsList>
  >;

  /**
   * Restore the specified files from the specified backup to the active filesystem
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupsUnderBackupVault_RestoreFiles")
  restoreFiles is ArmResourceActionAsyncBase<
    Backup,
    BackupRestoreFiles,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Backup>
  >;
}

@@doc(Backup.name, "The name of the backup");
@@doc(Backup.properties, "Backup Properties");
@@doc(Backups.create::parameters.resource,
  "Backup object supplied in the body of the operation."
);
@@doc(Backups.update::parameters.properties,
  "Backup object supplied in the body of the operation."
);
@@doc(Backups.restoreFiles::parameters.body,
  "Restore payload supplied in the body of the operation."
);
