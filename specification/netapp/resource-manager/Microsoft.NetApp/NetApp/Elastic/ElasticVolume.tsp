import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./../models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Rest;
using Azure.Core;
using Azure.ResourceManager;
using Http;
using Versioning;
using Azure.ClientGenerator.Core;

namespace Microsoft.NetApp;

/**
 * NetApp Elastic Volume resource
 */
@added(Versions.v2025_09_01_preview)
@parentResource(ElasticCapacityPool)
model ElasticVolume is TrackedResource<ElasticVolumeProperties> {
  ...ResourceNameParameter<
    Resource = ElasticVolume,
    KeyName = "volumeName",
    SegmentName = "elasticVolumes",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
  ...Azure.ResourceManager.AvailabilityZonesProperty;
}

/**
 * Elastic Volume properties
 */
@added(Versions.v2025_09_01_preview)
model ElasticVolumeProperties {
  /** A unique file path for the volume. Used when creating mount targets. This needs to be unique within the elastic capacity pool. */
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-]{0,79}$")
  @minLength(1)
  @maxLength(80)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  filePath: string;

  /** Maximum size allowed for a volume in bytes. Valid values are in the range 1GiB to 16TiB. Values expressed in bytes as multiples of 1 GiB. */
  @minValue(1073741824)
  @maxValue(17592186044416)
  size: int64;

  /** Set of export policy rules */
  exportPolicy?: ElasticExportPolicy;

  /** Set of support protocol types for the elastic volume */
  protocolTypes: ElasticProtocolType[];

  /**
   * Azure lifecycle management.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetAppProvisioningState;

  /** Current availability status of the resource. */
  @visibility(Lifecycle.Read)
  availabilityStatus?: ElasticResourceAvailabilityStatus;

  /** Resource identifier used to identify the Elastic Snapshot. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  snapshotResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/elasticAccounts/elasticCapacityPools/elasticVolumes/elasticSnapshots";
    }
  ]>;

  /** List of mount targets that can be used to mount this volume */
  @identifiers(#["ipAddress"])
  @visibility(Lifecycle.Read)
  mountTargets?: ElasticMountTargetProperties[];

  /** Data protection configuration option for the volume, including snapshot policies and backup. */
  dataProtection?: ElasticVolumeDataProtectionProperties;

  /** Controls the visibility of the volume's read-only snapshot directory, which provides access to each of the volume's snapshots. */
  snapshotDirectoryVisibility?: SnapshotDirectoryVisibility;

  /** SMB Properties */
  smbProperties?: ElasticSmbProperties;

  /** Resource identifier used to identify the Elastic Backup. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  backupResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/elasticAccounts/elasticBackupVaults/elasticBackups";
    }
  ]>;

  /** The current state of the restoration process. */
  @visibility(Lifecycle.Read)
  restorationState?: ElasticVolumeRestorationState;
}

/** Data protection configuration option for the volume, including snapshot policies and backup. */
@added(Versions.v2025_09_01_preview)
model ElasticVolumeDataProtectionProperties {
  /** Used to apply a snapshot policy to a volume. */
  snapshot?: ElasticVolumeSnapshotProperties;

  /** Used to configure backups on an elastic volume. */
  backup?: ElasticVolumeBackupProperties;
}

/** Data protection configuration option for updating the volume, including snapshot policies and backup. */
@added(Versions.v2025_09_01_preview)
model ElasticVolumeDataProtectionPatchProperties {
  /** Used to apply a snapshot policy to a volume. */
  snapshot?: ElasticVolumeSnapshotProperties;

  /** Used to configure backups on an elastic volume. */
  backup?: ElasticVolumeBackupProperties;
}

/** Contains all the information needed to mount an elastic volume */
@added(Versions.v2025_09_01_preview)
model ElasticMountTargetProperties {
  /** The mount target's IPv4 address, used to mount the volume */
  @visibility(Lifecycle.Read)
  ipAddress?: ipV4Address;

  /** The SMB server's Fully Qualified Domain Name, FQDN */
  @visibility(Lifecycle.Read)
  smbServerFqdn?: string;
}

/**
 * Elastic Volume Patch properties
 */
@added(Versions.v2025_09_01_preview)
model ElasticVolumePatchProperties {
  /** Maximum size allowed for a volume in bytes. Valid values are in the range 1GiB to 16TiB. Values expressed in bytes as multiples of 1 GiB. */
  @minValue(1073741824)
  @maxValue(17592186044416)
  size?: int64;

  /** Set of export policy rules */
  exportPolicy?: ElasticExportPolicy;

  /** Data protection configuration option for the volume, including snapshot policies and backup. */
  dataProtection?: ElasticVolumeDataProtectionPatchProperties;

  /** Controls the visibility of the volume's read-only snapshot directory, which provides access to each of the volume's snapshots. */
  snapshotDirectoryVisibility?: SnapshotDirectoryVisibility;

  /** SMB Properties */
  smbProperties?: ElasticSmbPatchProperties;
}

/** Elastic Volume Snapshot Properties */
@added(Versions.v2025_09_01_preview)
model ElasticVolumeSnapshotProperties {
  /** Snapshot Policy ResourceId */
  snapshotPolicyResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/elasticAccounts/elasticSnapshotPolicies";
    }
  ]>;
}

/** Elastic Volume Backup Properties */
@added(Versions.v2025_09_01_preview)
model ElasticVolumeBackupProperties {
  /** ResourceId used to identify Elastic Backup Policy */
  elasticBackupPolicyResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/elasticAccounts/elasticBackupPolicies";
    }
  ]>;

  /** The property to decide policy is enforced or not on the volume */
  policyEnforcement?: ElasticVolumePolicyEnforcement;

  /** ResourceId used to identify Elastic Backup Vault */
  elasticBackupVaultResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/elasticAccounts/elasticBackupVaults";
    }
  ]>;
}

/** Policy enforcement */
@added(Versions.v2025_09_01_preview)
union ElasticVolumePolicyEnforcement {
  string,

  /** Value indicating the policy is enforced on the volume. */
  Enforced: "Enforced",

  /** Value indicating the policy is not enforced on the volume. */
  NotEnforced: "NotEnforced",
}

/** SMB Properties */
@added(Versions.v2025_09_01_preview)
model ElasticSmbProperties {
  /** Used to enable or disable encryption for in-flight SMB data volume. This flag can be modified during Elastic volume update operation as well. Only applicable for SMB protocol Elastic volumes. */
  smbEncryption?: ElasticSmbEncryption = ElasticSmbEncryption.Disabled;
}

/** SMB Patch Properties */
@added(Versions.v2025_09_01_preview)
model ElasticSmbPatchProperties {
  /** Used to enable or disable encryption for in-flight SMB data volume. This flag can be modified during Elastic volume update operation as well. Only applicable for SMB protocol Elastic volumes. */
  smbEncryption?: ElasticSmbEncryption;
}

/** SMB encryption */
@added(Versions.v2025_09_01_preview)
union ElasticSmbEncryption {
  string,

  /** Value indicating the SMB encryption is enabled */
  Enabled: "Enabled",

  /** Value indicating the SMB encryption is disabled */
  Disabled: "Disabled",
}

/** The current state of the restoration process. */
@added(Versions.v2025_09_01_preview)
union ElasticVolumeRestorationState {
  string,

  /** Value indicating that the volume is currently restoring. */
  Restoring: "Restoring",

  /** Value indicating that the volume is restored. */
  Restored: "Restored",

  /** Value indicating that the volume restore has failed. */
  Failed: "Failed",
}

/**
 * Set of export policy rules
 */
@added(Versions.v2025_09_01_preview)
model ElasticExportPolicy {
  /** Export policy rule */
  @identifiers(#["ruleIndex"])
  rules?: ElasticExportPolicyRule[];
}

/** Elastic Volume Export Policy Rule */
@added(Versions.v2025_09_01_preview)
model ElasticExportPolicyRule {
  /** Controls the priority of the export policy rule. When connecting to the volume the rule with the lowest index that applies to the connecting client is used */
  @maxValue(5)
  ruleIndex?: int32;

  /** Specifies the Unix file access level for the volume. It encompasses both read-only and read-write permissions. Additionally, NoAccess can be set to block all access to the volume */
  unixAccessRule?: ElasticUnixAccessRule = ElasticUnixAccessRule.NoAccess;

  /** Allows clients to access the volume with the NFSv3 protocol. Enable only for NFSv3 type volumes */
  nfsv3?: ElasticNfsv3Access = ElasticNfsv3Access.Disabled;

  /** Allows clients to access the volume with at least NFSv4.1 protocol. */
  nfsv4?: ElasticNfsv4Access = ElasticNfsv4Access.Disabled;

  /** Client ingress specification for the export policy as list of IPv4 CIDRs, IPv4 host addresses and host names. */
  allowedClients?: string[];

  /** Indicates whether root access to the volume is granted to clients affected by this rule */
  rootAccess?: ElasticRootAccess = ElasticRootAccess.Disabled;
}

/** Reverts the elastic volume to the specified snapshot. */
@added(Versions.v2025_09_01_preview)
model ElasticVolumeRevert {
  /** Resource identifier used to identify the Elastic Snapshot. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  snapshotResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/elasticAccounts/elasticCapacityPools/elasticVolumes/elasticSnapshots";
    }
  ]>;
}

/** Unix access rule */
@added(Versions.v2025_09_01_preview)
union ElasticUnixAccessRule {
  string,

  /** Clients connecting with this rule will only have read access to the volume */
  ReadOnly: "ReadOnly",

  /** Clients connecting with this rule will have full read and write access to the volume */
  ReadWrite: "ReadWrite",

  /** Clients connecting with this rule will have no access to the volume */
  NoAccess: "NoAccess",
}

/** NFSv3 access */
@added(Versions.v2025_09_01_preview)
union ElasticNfsv3Access {
  string,

  /** Clients can connect to the volume using the NFSv3 protocol. */
  Enabled: "Enabled",

  /** Clients can't connect to the volume using the NFSv3 protocol. */
  Disabled: "Disabled",
}

/** NFSv4 access */
@added(Versions.v2025_09_01_preview)
union ElasticNfsv4Access {
  string,

  /** Clients can connect to the volume using the NFSv4 protocol. */
  Enabled: "Enabled",

  /** Clients can't connect to the volume using the NFSv4 protocol. */
  Disabled: "Disabled",
}

/** Root access */
@added(Versions.v2025_09_01_preview)
union ElasticRootAccess {
  string,

  /** Root user access is enabled for clients affected by this rule */
  Enabled: "Enabled",

  /** Root user access is disabled for clients affected by this rule */
  Disabled: "Disabled",
}

/** Protocol types for elastic volume */
@added(Versions.v2025_09_01_preview)
union ElasticProtocolType {
  string,

  /** NFSv3 protocol type */
  NFSv3: "NFSv3",

  /** NFSv4 protocol type */
  NFSv4: "NFSv4",

  /** SMB/CIFS protocol type */
  SMB: "SMB",
}

/** Controls the visibility of the Elastic Volume's read-only snapshot directory, which provides access to each of the volume's snapshots. */
@added(Versions.v2025_09_01_preview)
union SnapshotDirectoryVisibility {
  string,

  /** Value indicating the read-only snapshot directory is not visible */
  Hidden: "Hidden",

  /** Value indicating the read-only snapshot directory is visible */
  Visible: "Visible",
}

@armResourceOperations
interface ElasticVolumes {
  /** Get the details of the specified volume */
  @added(Versions.v2025_09_01_preview)
  get is ArmResourceRead<ElasticVolume>;

  /** Create or update the specified volume within the capacity pool */
  @added(Versions.v2025_09_01_preview)
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ElasticVolume>;

  /** Patch the specified elastic volume */
  @added(Versions.v2025_09_01_preview)
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    ElasticVolume,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ElasticVolume,
      ElasticVolumePatchProperties
    >,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ElasticVolume> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Delete the specified Elastic Volume */
  @added(Versions.v2025_09_01_preview)
  delete is ArmResourceDeleteWithoutOkAsync<ElasticVolume>;

  /** List all Elastic Volumes within the Elastic Capacity Pool */
  @added(Versions.v2025_09_01_preview)
  listByElasticPool is ArmResourceListByParent<ElasticVolume>;

  /** Revert an Elastic Volume to the snapshot specified in the body */
  @added(Versions.v2025_09_01_preview)
  revert is ArmResourceActionAsync<
    ElasticVolume,
    ElasticVolumeRevert,
    ElasticVolume
  >;
}

@@maxLength(ElasticVolume.name, 64);
@@minLength(ElasticVolume.name, 1);

@@clientName(ElasticVolumes.createOrUpdate::parameters.resource, "body");
@@clientName(ElasticVolumes.update::parameters.properties, "body");
