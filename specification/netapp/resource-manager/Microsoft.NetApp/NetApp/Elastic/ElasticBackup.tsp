import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./../models.tsp";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Microsoft.NetApp;

/**
 * NetApp Elastic Backup under an elastic Backup Vault
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
@parentResource(ElasticBackupVault)
model ElasticBackup is ProxyResource<ElasticBackupProperties> {
  ...ResourceNameParameter<
    Resource = ElasticBackup,
    KeyName = "backupName",
    SegmentName = "elasticBackups",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,63}$"
  >;
}

/**
 * Elastic Backup properties
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
model ElasticBackupProperties {
  /** The creation date of the backup */
  @visibility(Lifecycle.Read)
  creationDate?: utcDateTime;

  /** The snapshot creation date of the backup */
  @visibility(Lifecycle.Read)
  snapshotCreationDate?: utcDateTime;

  /** The completion date of the backup */
  @visibility(Lifecycle.Read)
  completionDate?: utcDateTime;

  /** Azure lifecycle management. */
  @visibility(Lifecycle.Read)
  provisioningState?: NetAppProvisioningState;

  /** Size of backup in bytes */
  @visibility(Lifecycle.Read)
  size?: int64;

  /** Label for backup */
  label?: string;

  /** Type of backup Manual or Scheduled */
  @visibility(Lifecycle.Read)
  backupType?: ElasticBackupType;

  /** Failure reason */
  @visibility(Lifecycle.Read)
  failureReason?: string;

  /** ResourceId used to identify the Elastic Volume */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  elasticVolumeResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/elasticAccounts/elasticCapacityPools/elasticVolumes";
    }
  ]>;

  /** Manual backup using an already existing snapshot. This will always be CreateNewSnapshot for scheduled backups and UseExistingSnapshot/CreateNewSnapshot for manual backups */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  snapshotUsage?: SnapshotUsage = SnapshotUsage.CreateNewSnapshot;

  /** ResourceId used to identify the elastic snapshot resource. This is required when an existing snapshot needs to be used for creating a manual backup */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  elasticSnapshotResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/elasticAccounts/elasticCapacityPools/elasticVolumes/elasticSnapshots";
    }
  ]>;

  /** ResourceId used to identify the elastic backup policy */
  @visibility(Lifecycle.Read)
  elasticBackupPolicyResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/elasticAccounts/elasticBackupPolicies";
    }
  ]>;

  /** Specifies if the backup is for a large volume. */
  @visibility(Lifecycle.Read)
  volumeSize?: VolumeSize;
}

/**
 * Type of backup
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
union ElasticBackupType {
  string,

  /** Manual backup type */
  Manual: "Manual",

  /** Scheduled backup type */
  Scheduled: "Scheduled",
}

/**
 * Snapshot usage for backup
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
union SnapshotUsage {
  string,

  /** Value indicating an existing snapshot is used */
  UseExistingSnapshot: "UseExistingSnapshot",

  /** Value indicating a new snapshot is created */
  CreateNewSnapshot: "CreateNewSnapshot",
}

/**
 * Volume size for backup
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
union VolumeSize {
  string,

  /** Value indicating backup is for a large volume */
  Large: "Large",

  /** Value indicating backup is not for a large volume */
  Regular: "Regular",
}

@armResourceOperations
interface ElasticBackups {
  /** Get the specified Elastic Backup under Elastic Backup Vault. */
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_12_01)
  @added(Versions.v2025_12_15_preview)
  get is ArmResourceRead<ElasticBackup>;

  /** Create an elastic backup under the elastic Backup Vault */
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_12_01)
  @added(Versions.v2025_12_15_preview)
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ElasticBackup>;

  /** Patch an elastic Backup under the Elastic Backup Vault */
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_12_01)
  @added(Versions.v2025_12_15_preview)
  update is ArmResourcePatchAsync<
    ElasticBackup,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ElasticBackup,
      ElasticBackupProperties
    >,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ElasticBackup> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_12_01)
  @added(Versions.v2025_12_15_preview)
  delete is ArmResourceDeleteWithoutOkAsync<ElasticBackup>;

  /**
   * List all elastic backups Under an elastic Backup Vault
   */
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_12_01)
  @added(Versions.v2025_12_15_preview)
  listByVault is ArmResourceListByParent<ElasticBackup>;
}

@@clientName(ElasticBackups.createOrUpdate::parameters.resource, "body");
@@clientName(ElasticBackups.update::parameters.properties, "body");

@@maxLength(ElasticBackup.name, 256);
@@minLength(ElasticBackup.name, 1);
