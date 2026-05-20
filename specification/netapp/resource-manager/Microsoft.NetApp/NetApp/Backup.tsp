import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BackupVault.tsp";
import "@azure-tools/typespec-client-generator-core";

using Rest;
using Azure.ResourceManager;
using Http;
using Azure.ClientGenerator.Core;

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

/**
 * Restore payload for Single File Backup Restore
 */
model BackupRestoreFiles {
  /**
   * List of files to be restored
   */
  @maxItems(8)
  @minItems(1)
  fileList: FileName[];

  /**
   * Destination folder where the files will be restored. The path name should start with a forward slash. If it is omitted from request then restore is done at the root folder of the destination volume by default
   */
  @pattern("^\\/.*$")
  restoreFilePath?: string;

  /**
   * Resource Id of the destination volume on which the files need to be restored
   */
  destinationVolumeId: string;
}

/**
 * Migrate Backups Request
 */
model BackupsMigrationRequest {
  /**
   * The ResourceId of the Backup Vault
   */
  backupVaultId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/backupVaults";
    }
  ]>;
}

/**
 * List of Backups
 */
model BackupsList is Azure.Core.Page<Backup>;

/**
 * Backup properties
 */
model BackupProperties {
  /**
   * UUID v4 used to identify the Backup
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  backupId?: string;

  /**
   * The creation date of the backup
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * The snapshot creation date of the backup
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  snapshotCreationDate?: utcDateTime | null;

  /**
   * The completion date of the backup
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  completionDate?: utcDateTime | null;

  /**
   * Azure lifecycle management
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Size of backup in bytes
   */
  @visibility(Lifecycle.Read)
  size?: int64;

  /**
   * Label for backup
   */
  label?: string;

  /**
   * Type of backup Manual or Scheduled
   */
  @visibility(Lifecycle.Read)
  backupType?: BackupType;

  /**
   * Failure reason
   */
  @visibility(Lifecycle.Read)
  failureReason?: string;

  /**
   * ResourceId used to identify the Volume
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  volumeResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes";
    }
  ]>;

  /**
   * Manual backup an already existing snapshot. This will always be false for scheduled backups and true/false for manual backups
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  useExistingSnapshot?: boolean = false;

  /**
   * The name of the snapshot
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  snapshotName?: string;

  /**
   * ResourceId used to identify the backup policy
   */
  @visibility(Lifecycle.Read)
  backupPolicyResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/backupPolicies";
    }
  ]>;

  /**
   * Specifies if the backup is for a large volume.
   */
  @visibility(Lifecycle.Read)
  isLargeVolume?: boolean;
}

/**
 * Type of backup Manual or Scheduled
 */
@clientName("NetAppBackupType", "csharp")
union BackupType {
  string,

  /**
   * Manual backup
   */
  Manual: "Manual",

  /**
   * Scheduled backup
   */
  Scheduled: "Scheduled",
}

/**
 * Backup patch
 */
model BackupPatch {
  /**
   * Backup Patch Properties
   */
  properties?: BackupPatchProperties;
}

/**
 * Backup patch properties
 */
model BackupPatchProperties {
  /**
   * Label for backup
   */
  label?: string;
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
    Response = ArmResponse<Backup> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Backup> &
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
