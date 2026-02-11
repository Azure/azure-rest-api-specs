import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./CapacityPool.tsp";

using Rest;
using Azure.ResourceManager;
using Http;
using Versioning;
using Azure.ClientGenerator.Core;

namespace Microsoft.NetApp;
/**
 * Volume resource
 */
@parentResource(CapacityPool)
model Volume is Azure.ResourceManager.TrackedResource<VolumeProperties, false> {
  ...ResourceNameParameter<
    Resource = Volume,
    KeyName = "volumeName",
    SegmentName = "volumes",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$"
  >;
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy EntityTagProperty for back compatibility"
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...Azure.ResourceManager.AvailabilityZonesProperty;
}

@maxLength(4)
@minLength(4)
scalar UnixPermissions extends string;

/**
 * List of volume resources
 */
model VolumeList is Azure.Core.Page<Volume>;

/**
 * Volume properties
 */
model VolumeProperties {
  /**
   * Unique FileSystem Identifier.
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  fileSystemId?: string;

  /**
   * A unique file path for the volume. Used when creating mount targets
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Mark with @secret if this value should be kept private"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-]{0,79}$")
  creationToken: string;

  /**
   * The service level of the file system
   */
  serviceLevel?: ServiceLevel = ServiceLevel.Premium;

  /**
   * Maximum storage quota allowed for a file system in bytes. This is a soft quota used for alerting only. For regular volumes, valid values are in the range 50GiB to 100TiB. For large volumes, valid values are in the range 100TiB to 500TiB, and on an exceptional basis, from to 2400GiB to 2400TiB. Values expressed in bytes as multiples of 1 GiB.
   */
  @removed(Versions.v2025_09_01_preview)
  @renamedFrom(Versions.v2025_09_01_preview, "usageThreshold")
  @maxValue(2638827906662400)
  @minValue(53687091200)
  usageThresholdOld: int64 = 107374182400;

  /**
   * Maximum storage quota allowed for a file system in bytes. This is a soft quota used for alerting only. For regular volumes, valid values are in the range 50GiB to 100TiB.
   * For large volumes, valid values are in the range 100TiB to 500TiB, and on an exceptional basis, from to 2400GiB to 2400TiB.
   * For extra large volumes, valid values are in the range 2400GiB to 7200TiB. Values expressed in bytes as multiples of 1 GiB.
   */
  @added(Versions.v2025_09_01_preview)
  @maxValue(7916483719987200)
  @minValue(53687091200)
  usageThreshold: int64 = 107374182400;

  /**
   * Set of export policy rules
   */
  exportPolicy?: VolumePropertiesExportPolicy;

  /**
   * Set of protocol types, default NFSv3, CIFS for SMB protocol
   */
  protocolTypes?: string[];

  /**
   * Azure lifecycle management
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Resource identifier used to identify the Snapshot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  snapshotId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes/snapshots";
    }
  ]> | null;

  /**
   * If enabled (true) the snapshot the volume was created from will be automatically deleted after the volume create operation has finished.  Defaults to false
   */
  deleteBaseSnapshot?: boolean;

  /**
   * Resource identifier used to identify the Backup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  backupId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/backupVaults/backups";
    }
  ]> | null;

  /**
   * Unique Baremetal Tenant Identifier.
   */
  @visibility(Lifecycle.Read)
  baremetalTenantId?: string;

  /**
   * The Azure Resource URI for a delegated subnet. Must have the delegation Microsoft.NetApp/volumes
   */
  subnetId: string;

  /**
   * The original value of the network features type available to the volume at the time it was created.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkFeatures?: NetworkFeatures = NetworkFeatures.Basic;

  /**
   * The effective value of the network features type available to the volume, or current effective state of update.
   */
  @visibility(Lifecycle.Read)
  effectiveNetworkFeatures?: NetworkFeatures = NetworkFeatures.Basic;

  /**
   * Network Sibling Set ID for the the group of volumes sharing networking resources.
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  networkSiblingSetId?: string;

  /**
   * Provides storage to network proximity information for the volume.
   */
  @visibility(Lifecycle.Read)
  storageToNetworkProximity?: VolumeStorageToNetworkProximity;

  /**
   * List of mount targets
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["fileSystemId"])
  mountTargets?: MountTargetProperties[];

  /**
   * What type of volume is this. For destination volumes in Cross Region Replication, set type to DataProtection. For creating clone volume, set type to ShortTermClone
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  volumeType?: string;

  /**
   * DataProtection type volumes include an object containing details of the replication
   */
  dataProtection?: VolumePropertiesDataProtection;

  /**
   * While auto splitting the short term clone volume, if the parent pool does not have enough space to accommodate the volume after split, it will be automatically resized, which will lead to increased billing. To accept capacity pool size auto grow and create a short term clone volume, set the property as accepted.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  acceptGrowCapacityPoolForShortTermCloneSplit?: AcceptGrowCapacityPoolForShortTermCloneSplit;

  /**
   * Restoring
   */
  @visibility(Lifecycle.Read)
  isRestoring?: boolean;

  /**
   * If enabled (true) the volume will contain a read-only snapshot directory which provides access to each of the volume's snapshots (defaults to true).
   */
  snapshotDirectoryVisible?: boolean = true;

  /**
   * Describe if a volume is KerberosEnabled. To be use with swagger version 2020-05-01 or later
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kerberosEnabled?: boolean = false;

  /**
   * The security style of volume, default unix, defaults to ntfs for dual protocol or CIFS protocol
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  securityStyle?: SecurityStyle = SecurityStyle.unix;

  /**
   * Enables encryption for in-flight smb3 data. Only applicable for SMB/DualProtocol volume. To be used with swagger version 2020-08-01 or later
   */
  smbEncryption?: boolean = false;

  /**
   * Enables access-based enumeration share property for SMB Shares. Only applicable for SMB/DualProtocol volume
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  smbAccessBasedEnumeration?: SmbAccessBasedEnumeration | null;

  /**
   * Enables non-browsable property for SMB Shares. Only applicable for SMB/DualProtocol volume
   */
  smbNonBrowsable?: SmbNonBrowsable;

  /**
   * Enables continuously available share property for smb volume. Only applicable for SMB volume
   */
  smbContinuouslyAvailable?: boolean = false;

  /**
   * Maximum throughput in MiB/s that can be achieved by this volume and this will be accepted as input only for manual qosType volume
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  throughputMibps?: float32 | null;

  /**
   * Actual throughput in MiB/s for auto qosType volumes calculated based on size and serviceLevel
   */
  @visibility(Lifecycle.Read)
  actualThroughputMibps?: float32;

  /**
   * Source of key used to encrypt data in volume. Applicable if NetApp account has encryption.keySource = 'Microsoft.KeyVault'. Possible values (case-insensitive) are: 'Microsoft.NetApp, Microsoft.KeyVault'
   */
  encryptionKeySource?: EncryptionKeySource = EncryptionKeySource.`Microsoft.NetApp`;

  /**
   * The resource ID of private endpoint for KeyVault. It must reside in the same VNET as the volume. Only applicable if encryptionKeySource = 'Microsoft.KeyVault'.
   */
  keyVaultPrivateEndpointResourceId?: string;

  /**
   * Specifies whether LDAP is enabled or not for a given NFS volume.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ldapEnabled?: boolean = false;

  /**
   * Specifies the type of LDAP server for a given NFS volume.
   */
  @added(Versions.v2025_07_01_preview)
  @removed(Versions.v2025_08_01)
  @added(Versions.v2025_08_01_preview)
  @removed(Versions.v2025_08_01)
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_09_01)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ldapServerType?: LdapServerType;

  /**
   * Specifies whether Cool Access(tiering) is enabled for the volume.
   */
  coolAccess?: boolean = false;

  /**
   * Specifies the number of days after which data that is not accessed by clients will be tiered.
   */
  @maxValue(183)
  @minValue(2)
  coolnessPeriod?: int32;

  /**
   * coolAccessRetrievalPolicy determines the data retrieval behavior from the cool tier to standard storage based on the read pattern for cool access enabled volumes. The possible values for this field are:
   *  Default - Data will be pulled from cool tier to standard storage on random reads. This policy is the default.
   *  OnRead - All client-driven data read is pulled from cool tier to standard storage on both sequential and random reads.
   *  Never - No client-driven data is pulled from cool tier to standard storage.
   */
  coolAccessRetrievalPolicy?: CoolAccessRetrievalPolicy;

  /**
   * coolAccessTieringPolicy determines which cold data blocks are moved to cool tier. The possible values for this field are: Auto - Moves cold user data blocks in both the Snapshot copies and the active file system to the cool tier tier. This policy is the default. SnapshotOnly - Moves user data blocks of the Volume Snapshot copies that are not associated with the active file system to the cool tier.
   */
  coolAccessTieringPolicy?: CoolAccessTieringPolicy;

  /**
   * UNIX permissions for NFS volume accepted in octal 4 digit format. First digit selects the set user ID(4), set group ID (2) and sticky (1) attributes. Second digit selects permission for the owner of the file: read (4), write (2) and execute (1). Third selects permissions for other users in the same group. the fourth for other users not in the group. 0755 - gives read/write/execute permissions to owner and read/execute to group and other users.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  unixPermissions?: UnixPermissions | null;

  /**
   * When a volume is being restored from another volume's snapshot, will show the percentage completion of this cloning process. When this value is empty/null there is no cloning process currently happening on this volume. This value will update every 5 minutes during cloning.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  @visibility(Lifecycle.Read)
  cloneProgress?: int32 | null;

  /**
   * Flag indicating whether file access logs are enabled for the volume, based on active diagnostic settings present on the volume.
   */
  @visibility(Lifecycle.Read)
  fileAccessLogs?: FileAccessLogs = FileAccessLogs.Disabled;

  /**
   * Specifies whether the volume is enabled for Azure VMware Solution (AVS) datastore purpose
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  avsDataStore?: AvsDataStore = AvsDataStore.Disabled;

  /**
   * Data store resource unique identifier
   */
  @visibility(Lifecycle.Read)
  dataStoreResourceId?: string[];

  /**
   * Specifies if default quota is enabled for the volume.
   */
  isDefaultQuotaEnabled?: boolean = false;

  /**
   * Default user quota for volume in KiBs. If isDefaultQuotaEnabled is set, the minimum value of 4 KiBs applies .
   */
  defaultUserQuotaInKiBs?: int64 = 0;

  /**
   * Default group quota for volume in KiBs. If isDefaultQuotaEnabled is set, the minimum value of 4 KiBs applies.
   */
  defaultGroupQuotaInKiBs?: int64 = 0;

  /**
   * Maximum number of files allowed. Needs a service request in order to be changed. Only allowed to be changed if volume quota is more than 4TiB.
   */
  @visibility(Lifecycle.Read)
  maximumNumberOfFiles?: int64;

  /**
   * Volume Group Name
   */
  @visibility(Lifecycle.Read)
  volumeGroupName?: string;

  /**
   * Pool Resource Id used in case of creating a volume through volume group
   */
  capacityPoolResourceId?: string;

  /**
   * Proximity placement group associated with the volume
   */
  proximityPlacementGroup?: string;

  /**
   * T2 network information
   */
  @visibility(Lifecycle.Read)
  t2Network?: string;

  /**
   * Volume spec name is the application specific designation or identifier for the particular volume in a volume group for e.g. data, log
   */
  volumeSpecName?: string;

  /**
   * Specifies if the volume is encrypted or not. Only available on volumes created or updated after 2022-01-01.
   */
  @visibility(Lifecycle.Read)
  encrypted?: boolean;

  /**
   * Application specific placement rules for the particular volume
   */
  @identifiers(#["key"])
  placementRules?: PlacementKeyValuePairs[];

  /**
   * Flag indicating whether subvolume operations are enabled on the volume
   */
  enableSubvolumes?: EnableSubvolumes = EnableSubvolumes.Disabled;

  /**
   * The availability zone where the volume is provisioned. This refers to the logical availability zone where the volume resides.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisionedAvailabilityZone?: string | null;

  /**
   * Specifies whether volume is a Large Volume or Regular Volume.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  isLargeVolume?: boolean = false;

  /**
   * Specifies the type of the Large Volume. When set to 'LargeVolume', the large volume is created with standard configuration.
   * If it is set to 'ExtraLargeVolume7Dot2PiB', the extra large volume is created with higher capacity limit 7.2PiB with cool access enabled,
   * delivering higher capacity limit with lower costs.
   */
  @added(Versions.v2025_09_01_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  largeVolumeType?: LargeVolumeType;

  /**
   * Id of the snapshot or backup that the volume is restored from.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  @visibility(Lifecycle.Read)
  originatingResourceId?: string | null;

  /**
   * Space shared by short term clone volume with parent volume in bytes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  @visibility(Lifecycle.Read)
  inheritedSizeInBytes?: int64 | null;

  /**
   * Language supported for volume.
   */
  @added(Versions.v2025_07_01_preview)
  @removed(Versions.v2025_08_01)
  @added(Versions.v2025_08_01_preview)
  @removed(Versions.v2025_08_01)
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_09_01)
  language?: VolumeLanguage;

  /**
   * Specifies whether the volume operates in Breakthrough Mode.
   */
  @added(Versions.v2025_09_01_preview)
  breakthroughMode?: BreakthroughMode;
}

/**
 * The type of the LDAP server
 */
union LdapServerType {
  string,

  /**
   * The volume should use Active Directory for LDAP connections.
   */
  ActiveDirectory: "ActiveDirectory",

  /**
   * The volume should use OpenLDAP for LDAP connections.
   */
  OpenLDAP: "OpenLDAP",
}

/**
 * Language supported for volume.
 */
@added(Versions.v2025_07_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_08_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_09_01)
union VolumeLanguage {
  string,

  /**
   * Posix with UTF-8
   */
  `c.utf-8`: "c.utf-8",

  /**
   * UTF-8 with 4 byte character support
   */
  utf8mb4: "utf8mb4",

  /**
   * Arabic - Deprecated
   */
  ar: "ar",

  /**
   * Arabic with UTF-8
   */
  `ar.utf-8`: "ar.utf-8",

  /**
   * Croatian - Deprecated
   */
  hr: "hr",

  /**
   * Croatian with UTF-8
   */
  `hr.utf-8`: "hr.utf-8",

  /**
   * Czech - Deprecated
   */
  cs: "cs",

  /**
   * Czech with UTF-8
   */
  `cs.utf-8`: "cs.utf-8",

  /**
   * Danish - Deprecated
   */
  da: "da",

  /**
   * Danish with UTF-8
   */
  `da.utf-8`: "da.utf-8",

  /**
   * Dutch - Deprecated
   */
  nl: "nl",

  /**
   * Dutch with UTF-8
   */
  `nl.utf-8`: "nl.utf-8",

  /**
   * English - Deprecated
   */
  en: "en",

  /**
   * English with UTF-8
   */
  `en.utf-8`: "en.utf-8",

  /**
   * Finnish - Deprecated
   */
  fi: "fi",

  /**
   * Finnish with UTF-8
   */
  `fi.utf-8`: "fi.utf-8",

  /**
   * French - Deprecated
   */
  fr: "fr",

  /**
   * French with UTF-8
   */
  `fr.utf-8`: "fr.utf-8",

  /**
   * German - Deprecated
   */
  de: "de",

  /**
   * German with UTF-8
   */
  `de.utf-8`: "de.utf-8",

  /**
   * Hebrew - Deprecated
   */
  he: "he",

  /**
   * Hebrew with UTF-8
   */
  `he.utf-8`: "he.utf-8",

  /**
   * Hungarian - Deprecated
   */
  hu: "hu",

  /**
   * Hungarian with UTF-8
   */
  `hu.utf-8`: "hu.utf-8",

  /**
   * Italian - Deprecated
   */
  it: "it",

  /**
   * Italian with UTF-8
   */
  `it.utf-8`: "it.utf-8",

  /**
   * Japanese euc-j - Deprecated
   */
  ja: "ja",

  /**
   * Japanese euc-j with UTF-8
   */
  `ja.utf-8`: "ja.utf-8",

  /**
   * Japanese euc-j - Deprecated
   */
  `ja-v1`: "ja-v1",

  /**
   * Japanese euc-j with UTF-8
   */
  `ja-v1.utf-8`: "ja-v1.utf-8",

  /**
   * Japanese pck
   */
  `ja-jp.pck`: "ja-jp.pck",

  /**
   * Japanese pck with UTF-8 - Deprecated
   */
  `ja-jp.pck.utf-8`: "ja-jp.pck.utf-8",

  /**
   * Japanese cp932
   */
  `ja-jp.932`: "ja-jp.932",

  /**
   * Japanese cp932 with UTF-8 - Deprecated
   */
  `ja-jp.932.utf-8`: "ja-jp.932.utf-8",

  /**
   * Japanese pck - sjis
   */
  `ja-jp.pck-v2`: "ja-jp.pck-v2",

  /**
   * Japanese pck - sjis with UTF-8 - Deprecated
   */
  `ja-jp.pck-v2.utf-8`: "ja-jp.pck-v2.utf-8",

  /**
   * Korean - Deprecated
   */
  ko: "ko",

  /**
   * Korean with UTF-8
   */
  `ko.utf-8`: "ko.utf-8",

  /**
   * Norwegian - Deprecated
   */
  no: "no",

  /**
   * Norwegian with UTF-8
   */
  `no.utf-8`: "no.utf-8",

  /**
   * Polish - Deprecated
   */
  pl: "pl",

  /**
   * Polish with UTF-8
   */
  `pl.utf-8`: "pl.utf-8",

  /**
   * Portuguese - Deprecated
   */
  pt: "pt",

  /**
   * Portuguese with UTF-8
   */
  `pt.utf-8`: "pt.utf-8",

  /**
   * Posix - Deprecated
   */
  c: "c",

  /**
   * Romanian - Deprecated
   */
  ro: "ro",

  /**
   * Romanian with UTF-8
   */
  `ro.utf-8`: "ro.utf-8",

  /**
   * Russian - Deprecated
   */
  ru: "ru",

  /**
   * Russian with UTF-8
   */
  `ru.utf-8`: "ru.utf-8",

  /**
   * Simplified Chinese - Deprecated
   */
  zh: "zh",

  /**
   * Simplified Chinese with UTF-8
   */
  `zh.utf-8`: "zh.utf-8",

  /**
   * Simplified gbk Chinese
   */
  `zh.gbk`: "zh.gbk",

  /**
   * Simplified gbk Chinese with UTF-8 - Deprecated
   */
  `zh.gbk.utf-8`: "zh.gbk.utf-8",

  /**
   * Traditional Chinese BIG 5
   */
  `zh-tw.big5`: "zh-tw.big5",

  /**
   * Traditional Chinese BIG 5 with UTF-8 - Deprecated
   */
  `zh-tw.big5.utf-8`: "zh-tw.big5.utf-8",

  /**
   * Traditional Chinese EUC-TW
   */
  `zh-tw`: "zh-tw",

  /**
   * Traditional Chinese EUC-TW with UTF-8 - Deprecated
   */
  `zh-tw.utf-8`: "zh-tw.utf-8",

  /**
   * Slovak - Deprecated
   */
  sk: "sk",

  /**
   * Slovak with UTF-8
   */
  `sk.utf-8`: "sk.utf-8",

  /**
   * Slovenian - Deprecated
   */
  sl: "sl",

  /**
   * Slovenian with UTF-8
   */
  `sl.utf-8`: "sl.utf-8",

  /**
   * Spanish - Deprecated
   */
  es: "es",

  /**
   * Spanish with UTF-8
   */
  `es.utf-8`: "es.utf-8",

  /**
   * Swedish - Deprecated
   */
  sv: "sv",

  /**
   * Swedish with UTF-8
   */
  `sv.utf-8`: "sv.utf-8",

  /**
   * Turkish - Deprecated
   */
  tr: "tr",

  /**
   * Turkish with UTF-8
   */
  `tr.utf-8`: "tr.utf-8",

  /**
   * US English - Deprecated
   */
  `en-us`: "en-us",

  /**
   * US English with UTF-8
   */
  `en-us.utf-8`: "en-us.utf-8",
}

/**
 * Set of export policy rules
 */
@clientName("NetAppVolumeExportPolicyRule", "csharp")
model VolumePropertiesExportPolicy {
  /**
   * Export policy rule
   */
  @identifiers(#["ruleIndex"])
  rules?: ExportPolicyRule[];
}

/**
 * Volume Export Policy Rule
 */
model ExportPolicyRule {
  /**
   * Order index
   */
  ruleIndex?: int32;

  /**
   * Read only access
   */
  unixReadOnly?: boolean;

  /**
   * Read and write access
   */
  unixReadWrite?: boolean;

  /**
   * Kerberos5 Read only access. To be use with swagger version 2020-05-01 or later
   */
  kerberos5ReadOnly?: boolean = false;

  /**
   * Kerberos5 Read and write access. To be use with swagger version 2020-05-01 or later
   */
  kerberos5ReadWrite?: boolean = false;

  /**
   * Kerberos5i Read only access. To be use with swagger version 2020-05-01 or later
   */
  kerberos5iReadOnly?: boolean = false;

  /**
   * Kerberos5i Read and write access. To be use with swagger version 2020-05-01 or later
   */
  kerberos5iReadWrite?: boolean = false;

  /**
   * Kerberos5p Read only access. To be use with swagger version 2020-05-01 or later
   */
  kerberos5pReadOnly?: boolean = false;

  /**
   * Kerberos5p Read and write access. To be use with swagger version 2020-05-01 or later
   */
  kerberos5pReadWrite?: boolean = false;

  /**
   * Allows CIFS protocol
   */
  cifs?: boolean;

  /**
   * Allows NFSv3 protocol. Enable only for NFSv3 type volumes
   */
  nfsv3?: boolean;

  /**
   * Allows NFSv4.1 protocol. Enable only for NFSv4.1 type volumes
   */
  nfsv41?: boolean;

  /**
   * Client ingress specification as comma separated string with IPv4 CIDRs, IPv4 host addresses and host names
   */
  allowedClients?: string;

  /**
   * Has root access to volume
   */
  hasRootAccess?: boolean = true;

  /**
   * This parameter specifies who is authorized to change the ownership of a file. restricted - Only root user can change the ownership of the file. unrestricted - Non-root users can change ownership of files that they own.
   */
  chownMode?: ChownMode = ChownMode.Restricted;
}

/**
 * Mount target properties
 */
model MountTargetProperties {
  /**
   * UUID v4 used to identify the MountTarget
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  mountTargetId?: string;

  /**
   * UUID v4 used to identify the MountTarget
   */
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  fileSystemId: string;

  /**
   * The mount target's IPv4 address
   */
  @visibility(Lifecycle.Read)
  ipAddress?: string;

  /**
   * The SMB server's Fully Qualified Domain Name, FQDN
   */
  smbServerFqdn?: string;
}

/**
 * DataProtection type volumes include an object containing details of the replication
 */
model VolumePropertiesDataProtection {
  /**
   * Backup Properties
   */
  backup?: VolumeBackupProperties;

  /**
   * Replication properties
   */
  replication?: ReplicationObject;

  /**
   * Snapshot properties.
   */
  snapshot?: VolumeSnapshotProperties;

  /**
   * VolumeRelocation properties
   */
  volumeRelocation?: VolumeRelocationProperties;

  /**
   * Advanced Ransomware Protection settings
   */
  @added(Versions.v2025_09_01_preview)
  ransomwareProtection?: RansomwareProtectionSettings;
}

/**
 * Volume Backup Properties
 */
model VolumeBackupProperties {
  /**
   * Backup Policy Resource ID
   */
  backupPolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/backupPolicies";
    }
  ]>;

  /**
   * Policy Enforced
   */
  policyEnforced?: boolean;

  /**
   * Backup Vault Resource ID
   */
  backupVaultId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/backupVaults";
    }
  ]>;
}

/**
 * Replication properties
 */
model ReplicationObject {
  /**
   * Id
   */
  @visibility(Lifecycle.Read)
  replicationId?: string;

  /**
   * Indicates whether the local volume is the source or destination for the Volume Replication
   */
  @visibility(Lifecycle.Read)
  endpointType?: EndpointType;

  /**
   * Schedule
   */
  replicationSchedule?: ReplicationSchedule;

  /**
   * The resource ID of the remote volume. Required for cross region and cross zone replication
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  remoteVolumeResourceId?: string;

  /**
   * The full path to a volume that is to be migrated into ANF. Required for Migration volumes
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  remotePath?: RemotePath;

  /**
   * The remote region for the other end of the Volume Replication.
   */
  remoteVolumeRegion?: string;

  /**
   * A list of destination replications
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["resourceId"])
  destinationReplications?: DestinationReplication[];

  /**
   * Property that only applies to external replications. Provides a machine-readable value for the status of the external replication setup.
   */
  @added(Versions.v2025_07_01_preview)
  @removed(Versions.v2025_08_01)
  @added(Versions.v2025_08_01_preview)
  @removed(Versions.v2025_08_01)
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_09_01)
  @visibility(Lifecycle.Read)
  externalReplicationSetupStatus?: ExternalReplicationSetupStatus;

  /**
   * Contains human-readable instructions on what the next step is to finish the external replication setup.
   */
  @added(Versions.v2025_07_01_preview)
  @removed(Versions.v2025_08_01)
  @added(Versions.v2025_08_01_preview)
  @removed(Versions.v2025_08_01)
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_09_01)
  @visibility(Lifecycle.Read)
  externalReplicationSetupInfo?: string;

  /**
   * The mirror state property describes the current status of data replication for a replication. It provides insight into whether the data is actively being mirrored, if the replication process has been paused, or if it has yet to be initialized.
   */
  @added(Versions.v2025_07_01_preview)
  @removed(Versions.v2025_08_01)
  @added(Versions.v2025_08_01_preview)
  @removed(Versions.v2025_08_01)
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_09_01)
  @visibility(Lifecycle.Read)
  mirrorState?: MirrorState;

  /**
   * The status of the Volume Replication
   */
  @added(Versions.v2025_07_01_preview)
  @removed(Versions.v2025_08_01)
  @added(Versions.v2025_08_01_preview)
  @removed(Versions.v2025_08_01)
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_09_01)
  @visibility(Lifecycle.Read)
  relationshipStatus?: VolumeReplicationRelationshipStatus;
}

/**
 * Property that only applies to external replications. Provides a machine-readable value for the status of the external replication setup.
 */
@added(Versions.v2025_07_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_08_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_09_01)
union ExternalReplicationSetupStatus {
  string,

  /**
   * Your cluster needs to be peered by using the 'peerExternalCluster' action
   */
  ClusterPeerRequired: "ClusterPeerRequired",

  /**
   * The peering needs to be accepted on your cluster before the setup can proceed
   */
  ClusterPeerPending: "ClusterPeerPending",

  /**
   * Need to call 'authorizeExternalReplication' and accept the returned 'vserver peer accept' command on your cluster to finish setting up the external replication
   */
  VServerPeerRequired: "VServerPeerRequired",

  /**
   * Need to call 'authorizeExternalReplication' to finish setting up the external replication
   */
  ReplicationCreateRequired: "ReplicationCreateRequired",

  /**
   * External Replication setup is complete, you can now monitor the 'mirrorState' in the replication status for the health of the replication
   */
  NoActionRequired: "NoActionRequired",
}

/**
 * The full path to a volume that is to be migrated into ANF. Required for Migration volumes
 */
model RemotePath {
  /**
   * The Path to a ONTAP Host
   */
  externalHostName: string;

  /**
   * The name of a server on the ONTAP Host
   */
  serverName: string;

  /**
   * The name of a volume on the server
   */
  volumeName: string;
}

/**
 * Destination replication properties
 */
model DestinationReplication {
  /**
   * The resource ID of the remote volume
   */
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes";
    }
  ]>;

  /**
   * Indicates whether the replication is cross zone or cross region.
   */
  replicationType?: ReplicationType;

  /**
   * The remote region for the destination volume.
   */
  region?: string;

  /**
   * The remote zone for the destination volume.
   */
  zone?: string;
}

/**
 * Volume Snapshot Properties
 */
model VolumeSnapshotProperties {
  /**
   * Snapshot Policy ResourceId
   */
  snapshotPolicyId?: string;
}

/**
 * Volume relocation properties
 */
model VolumeRelocationProperties {
  /**
   * Has relocation been requested for this volume
   */
  relocationRequested?: boolean;

  /**
   * Has relocation finished and is ready to be cleaned up
   */
  @visibility(Lifecycle.Read)
  readyToBeFinalized?: boolean;
}

/**
 * Application specific parameters for the placement of volumes in the volume group
 */
@clientName("NetAppVolumePlacementRule", "csharp")
model PlacementKeyValuePairs {
  /**
   * Key for an application specific parameter for the placement of volumes in the volume group
   */
  key: string;

  /**
   * Value for an application specific parameter for the placement of volumes in the volume group
   */
  value: string;
}

/**
 * Volume patch resource
 */
model VolumePatch {
  /**
   * Resource location
   */
  location?: string;

  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Patchable volume properties
   */
  properties?: VolumePatchProperties;
}

/**
 * Patchable volume properties
 */
model VolumePatchProperties {
  /**
   * The service level of the file system
   */
  serviceLevel?: ServiceLevel;

  /**
   * Maximum storage quota allowed for a file system in bytes. This is a soft quota used for alerting only. For regular volumes, valid values are in the range 50GiB to 100TiB. For large volumes, valid values are in the range 100TiB to 500TiB, and on an exceptional basis, from to 2400GiB to 2400TiB. Values expressed in bytes as multiples of 1 GiB.
   */
  @removed(Versions.v2025_09_01_preview)
  @renamedFrom(Versions.v2025_09_01_preview, "usageThreshold")
  @maxValue(2638827906662400)
  @minValue(53687091200)
  usageThreshold20250901?: int64;

  /**
   * Maximum storage quota allowed for a file system in bytes. This is a soft quota used for alerting only. For regular volumes, valid values are in the range 50GiB to 100TiB.
   * For large volumes, valid values are in the range 100TiB to 500TiB, and on an exceptional basis, from to 2400GiB to 2400TiB.
   * For extra large volumes, valid values are in the range 2400GiB to 7200TiB. Values expressed in bytes as multiples of 1 GiB.
   */
  @added(Versions.v2025_09_01_preview)
  @maxValue(7916483719987200)
  @minValue(53687091200)
  usageThreshold?: int64;

  /**
   * Set of export policy rules
   */
  exportPolicy?: VolumePatchPropertiesExportPolicy;

  /**
   * Set of protocol types, default NFSv3, CIFS for SMB protocol
   */
  protocolTypes?: string[];

  /**
   * Maximum throughput in MiB/s that can be achieved by this volume and this will be accepted as input only for manual qosType volume
   */
  throughputMibps?: float32;

  /**
   * DataProtection type volumes include an object containing details of the replication
   */
  dataProtection?: VolumePatchPropertiesDataProtection;

  /**
   * Specifies if default quota is enabled for the volume.
   */
  isDefaultQuotaEnabled?: boolean;

  /**
   * Default user quota for volume in KiBs. If isDefaultQuotaEnabled is set, the minimum value of 4 KiBs applies .
   */
  defaultUserQuotaInKiBs?: int64;

  /**
   * Default group quota for volume in KiBs. If isDefaultQuotaEnabled is set, the minimum value of 4 KiBs applies.
   */
  defaultGroupQuotaInKiBs?: int64;

  /**
   * UNIX permissions for NFS volume accepted in octal 4 digit format. First digit selects the set user ID(4), set group ID (2) and sticky (1) attributes. Second digit selects permission for the owner of the file: read (4), write (2) and execute (1). Third selects permissions for other users in the same group. the fourth for other users not in the group. 0755 - gives read/write/execute permissions to owner and read/execute to group and other users.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  unixPermissions?: UnixPermissions | null;

  /**
   * Specifies whether Cool Access(tiering) is enabled for the volume.
   */
  coolAccess?: boolean;

  /**
   * Specifies the number of days after which data that is not accessed by clients will be tiered.
   */
  @maxValue(183)
  @minValue(2)
  coolnessPeriod?: int32;

  /**
   * coolAccessRetrievalPolicy determines the data retrieval behavior from the cool tier to standard storage based on the read pattern for cool access enabled volumes. The possible values for this field are:
   *  Default - Data will be pulled from cool tier to standard storage on random reads. This policy is the default.
   *  OnRead - All client-driven data read is pulled from cool tier to standard storage on both sequential and random reads.
   *  Never - No client-driven data is pulled from cool tier to standard storage.
   */
  coolAccessRetrievalPolicy?: CoolAccessRetrievalPolicy;

  /**
   * coolAccessTieringPolicy determines which cold data blocks are moved to cool tier. The possible values for this field are: Auto - Moves cold user data blocks in both the Snapshot copies and the active file system to the cool tier tier. This policy is the default. SnapshotOnly - Moves user data blocks of the Volume Snapshot copies that are not associated with the active file system to the cool tier.
   */
  coolAccessTieringPolicy?: CoolAccessTieringPolicy;

  /**
   * If enabled (true) the volume will contain a read-only snapshot directory which provides access to each of the volume's snapshots.
   */
  snapshotDirectoryVisible?: boolean;

  /**
   * Enables access-based enumeration share property for SMB Shares. Only applicable for SMB/DualProtocol volume
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  smbAccessBasedEnumeration?: SmbAccessBasedEnumeration | null;

  /**
   * Enables non-browsable property for SMB Shares. Only applicable for SMB/DualProtocol volume
   */
  smbNonBrowsable?: SmbNonBrowsable;
}

/**
 * Set of export policy rules
 */
model VolumePatchPropertiesExportPolicy {
  /**
   * Export policy rule
   */
  @identifiers(#["ruleIndex"])
  rules?: ExportPolicyRule[];
}

/**
 * DataProtection type volumes include an object containing details of the replication
 */
model VolumePatchPropertiesDataProtection {
  /**
   * Backup Properties
   */
  backup?: VolumeBackupProperties;

  /**
   * Snapshot properties.
   */
  snapshot?: VolumeSnapshotProperties;

  /**
   * Advanced Ransomware Protection updatable settings
   */
  @added(Versions.v2025_09_01_preview)
  ransomwareProtection?: RansomwareProtectionPatchSettings;
}

/**
 * revert a volume to the snapshot
 */
model VolumeRevert {
  /**
   * Resource id of the snapshot
   */
  snapshotId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes/snapshots";
    }
  ]>;
}

/**
 * Break file locks request
 */
model BreakFileLocksRequest {
  /**
   * To clear file locks on a volume for a particular client
   */
  @pattern("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
  clientIp?: string;

  /**
   * Break File locks could be a disruptive operation for application as locks on the volume will be broken, if want to process, set to true.
   */
  confirmRunningDisruptiveOperation?: boolean = false;
}

/**
 * Get group Id list for LDAP User request
 */
model GetGroupIdListForLdapUserRequest {
  /**
   * username is required to fetch the group to which user is part of
   */
  @maxLength(255)
  @minLength(1)
  username: string;
}

/**
 * Group Id list for Ldap user
 */
model GetGroupIdListForLdapUserResponse {
  /**
   * Group Id list
   */
  groupIdsForLdapUser?: string[];
}

/**
 * Break replication request
 */
model BreakReplicationRequest {
  /**
   * If replication is in status transferring and you want to force break the replication, set to true
   */
  forceBreakReplication?: boolean;
}

/**
 * Re-establish request object supplied in the body of the operation.
 */
model ReestablishReplicationRequest {
  /**
   * Resource id of the source volume for the replication
   */
  sourceVolumeId?: string;
}

/**
 * Replication status
 */
model ReplicationStatus {
  /**
   * Replication health check
   */
  healthy?: boolean;

  /**
   * Status of the mirror relationship
   */
  relationshipStatus?: VolumeReplicationRelationshipStatus;

  /**
   * The status of the replication
   */
  mirrorState?: MirrorState;

  /**
   * The progress of the replication
   */
  totalProgress?: string;

  /**
   * Displays error message if the replication is in an error state
   */
  errorMessage?: string;
}

/**
 * List Replications
 */
model ListReplications is Azure.Core.Page<Replication>;

/**
 * Replication properties
 */
model Replication {
  /**
   * UUID v4 used to identify the replication.
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  replicationId?: string;

  /**
   * Indicates whether the local volume is the source or destination for the Volume Replication
   */
  endpointType?: EndpointType;

  /**
   * Schedule
   */
  replicationSchedule?: ReplicationSchedule;

  /**
   * The resource ID of the remote volume.
   */
  remoteVolumeResourceId: string;

  /**
   * The remote region for the other end of the Volume Replication.
   */
  remoteVolumeRegion?: string;

  /**
   * The status of the replication
   */
  @added(Versions.v2025_08_01)
  @visibility(Lifecycle.Read)
  mirrorState?: ReplicationMirrorState;

  /**
   * Replication creation time
   */
  @added(Versions.v2025_08_01)
  @visibility(Lifecycle.Read)
  replicationCreationTime?: utcDateTime;

  /**
   * Replication deletion time
   */
  @added(Versions.v2025_08_01)
  @visibility(Lifecycle.Read)
  replicationDeletionTime?: utcDateTime;
}

/**
 * The status of the replication
 */
union ReplicationMirrorState {
  string,

  /**
   * Destination volume has not been initialized
   */
  Uninitialized: "Uninitialized",

  /**
   * Destination volume has been initialized and is ready
   */
  Mirrored: "Mirrored",

  /**
   * 	Destination volume is RW, replication relationship has been broken off
   */
  Broken: "Broken",
}

/**
 * Authorize request
 */
model AuthorizeRequest {
  /**
   * Resource id of the remote volume
   */
  remoteVolumeResourceId?: string;
}

/**
 * Source Cluster properties for a cluster peer request
 */
model PeerClusterForVolumeMigrationRequest {
  /**
   * A list of IC-LIF IPs that can be used to connect to the On-prem cluster
   */
  @minItems(1)
  peerIpAddresses: string[];
}

/**
 * Information about cluster peering process
 */
model ClusterPeerCommandResponse {
  /**
   * A command that needs to be run on the external ONTAP to accept cluster peering.  Will only be present if <code>clusterPeeringStatus</code> is <code>pending</code>
   */
  peerAcceptCommand?: string;
}

/**
 * Information about svm peering process
 */
model SvmPeerCommandResponse {
  /**
   * A command that needs to be run on the external ONTAP to accept svm peering.  Will only be present if <code>svmPeeringStatus</code> is <code>pending</code>
   */
  svmPeeringCommand?: string;
}

/**
 * Pool change request
 */
model PoolChangeRequest {
  /**
   * Resource id of the pool to move volume to
   */
  newPoolResourceId: string;
}

/**
 * Relocate volume request
 */
model RelocateVolumeRequest {
  /**
   * New creation token for the volume that controls the mount point name
   */
  creationToken?: string;
}

/**
 * Body for the list replications endpoint. If supplied, the body will be used as a filter for example to exclude deleted replications. If omitted, the endpoint returns all replications
 */
@added(Versions.v2025_08_01)
model ListReplicationsRequest {
  /**
   * Exclude Replications filter. 'None' returns all replications, 'Deleted' excludes deleted replications. Default is 'None'
   */
  exclude?: Exclude = Exclude.None;
}

/**
 * An option to filter out replications. 'None' returns all replications, 'Deleted' excludes deleted replications. Default is 'None'
 */
union Exclude {
  string,

  /** 'None' returns all replications */
  None: "None",

  /** 'Deleted' excludes deleted replications */
  Deleted: "Deleted",
}

/**
 * Status of the volume restore relationship
 */
union VolumeRestoreRelationshipStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Idle: "Idle",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Transferring: "Transferring",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
}

/**
 * Status of the volume backup relationship
 */
union VolumeBackupRelationshipStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Idle: "Idle",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Transferring: "Transferring",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
}

/**
 * Status of the volume replication relationship
 */
union VolumeReplicationRelationshipStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Idle: "Idle",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Transferring: "Transferring",
}

/**
 * Restore status
 */
@clientName("NetAppRestoreStatus", "csharp")
model RestoreStatus {
  /**
   * Restore health status
   */
  @visibility(Lifecycle.Read)
  healthy?: boolean;

  /**
   * Status of the restore SnapMirror relationship
   */
  @visibility(Lifecycle.Read)
  relationshipStatus?: VolumeRestoreRelationshipStatus;

  /**
   * The status of the restore
   */
  @visibility(Lifecycle.Read)
  mirrorState?: MirrorState;

  /**
   * Reason for the unhealthy restore relationship
   */
  @visibility(Lifecycle.Read)
  unhealthyReason?: string;

  /**
   * Displays error message if the restore is in an error state
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * Displays the total bytes transferred
   */
  @visibility(Lifecycle.Read)
  totalTransferBytes?: int64;
}

/**
 * Backup status
 */
@clientName("NetAppVolumeBackupStatus", "csharp")
model BackupStatus {
  /**
   * Backup health status
   */
  @visibility(Lifecycle.Read)
  healthy?: boolean;

  /**
   * Status of the backup mirror relationship
   */
  @visibility(Lifecycle.Read)
  relationshipStatus?: VolumeBackupRelationshipStatus;

  /**
   * The status of the backup
   */
  @visibility(Lifecycle.Read)
  mirrorState?: MirrorState;

  /**
   * Reason for the unhealthy backup relationship
   */
  @visibility(Lifecycle.Read)
  unhealthyReason?: string;

  /**
   * Displays error message if the backup is in an error state
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * Displays the last transfer size
   */
  @visibility(Lifecycle.Read)
  lastTransferSize?: int64;

  /**
   * Displays the last transfer type
   */
  @visibility(Lifecycle.Read)
  lastTransferType?: string;

  /**
   * Displays the total bytes transferred
   */
  @visibility(Lifecycle.Read)
  totalTransferBytes?: int64;

  /**
   * Displays the total number of bytes transferred for the ongoing operation
   */
  @visibility(Lifecycle.Read)
  transferProgressBytes?: int64;
}

/**
 * This parameter specifies who is authorized to change the ownership of a file. restricted - Only root user can change the ownership of the file. unrestricted - Non-root users can change ownership of files that they own.
 */
union ChownMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Restricted: "Restricted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unrestricted: "Unrestricted",
}

/**
 * Provides storage to network proximity information for the volume.
 */
union VolumeStorageToNetworkProximity {
  string,

  /**
   * Basic storage to network connectivity.
   */
  Default: "Default",

  /**
   * Standard T1 storage to network connectivity.
   */
  T1: "T1",

  /**
   * Standard T2 storage to network connectivity.
   */
  T2: "T2",

  /**
   * Standard AcrossT2 storage to network connectivity.
   */
  AcrossT2: "AcrossT2",
}

/**
 * Indicates whether the local volume is the source or destination for the Volume Replication
 */
@clientName("NetAppEndpointType", "csharp")
union EndpointType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  src: "src",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  dst: "dst",
}

/**
 * Schedule
 */
union ReplicationSchedule {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @clientName("TenMinutely", "csharp")
  _10minutely: "_10minutely",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  hourly: "hourly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  daily: "daily",
}

/**
 * Indicates whether the replication is cross zone or cross region.
 */
union ReplicationType {
  string,

  /**
   * Cross region replication
   */
  CrossRegionReplication: "CrossRegionReplication",

  /**
   * Cross zone replication
   */
  CrossZoneReplication: "CrossZoneReplication",
}

/**
 * While auto splitting the short term clone volume, if the parent pool does not have enough space to accommodate the volume after split, it will be automatically resized, which will lead to increased billing. To accept capacity pool size auto grow and create a short term clone volume, set the property as accepted.
 */
union AcceptGrowCapacityPoolForShortTermCloneSplit {
  string,

  /**
   * Auto grow capacity pool for short term clone split is accepted.
   */
  Accepted: "Accepted",

  /**
   * Auto grow capacity pool for short term clone split is declined. Short term clone volume creation will not be allowed, to create short term clone volume accept auto grow capacity pool.
   */
  Declined: "Declined",
}

/**
 * The security style of volume, default unix, defaults to ntfs for dual protocol or CIFS protocol
 */
union SecurityStyle {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ntfs: "ntfs",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  unix: "unix",
}

/**
 * Enables access-based enumeration share property for SMB Shares. Only applicable for SMB/DualProtocol volume
 */
union SmbAccessBasedEnumeration {
  string,

  /**
   * smbAccessBasedEnumeration share setting is disabled
   */
  Disabled: "Disabled",

  /**
   * smbAccessBasedEnumeration share setting is enabled
   */
  Enabled: "Enabled",
}

/**
 * Enables non-browsable property for SMB Shares. Only applicable for SMB/DualProtocol volume
 */
union SmbNonBrowsable {
  string,

  /**
   * smbNonBrowsable share setting is disabled
   */
  Disabled: "Disabled",

  /**
   * smbNonBrowsable share setting is enabled
   */
  Enabled: "Enabled",
}

/**
 * Source of key used to encrypt data in volume. Applicable if NetApp account has encryption.keySource = 'Microsoft.KeyVault'. Possible values (case-insensitive) are: 'Microsoft.NetApp, Microsoft.KeyVault'
 */
union EncryptionKeySource {
  string,

  /**
   * Microsoft-managed key encryption
   */
  `Microsoft.NetApp`: "Microsoft.NetApp",

  /**
   * Customer-managed key encryption
   */
  `Microsoft.KeyVault`: "Microsoft.KeyVault",
}

/**
 * coolAccessRetrievalPolicy determines the data retrieval behavior from the cool tier to standard storage based on the read pattern for cool access enabled volumes. The possible values for this field are:
 *  Default - Data will be pulled from cool tier to standard storage on random reads. This policy is the default.
 *  OnRead - All client-driven data read is pulled from cool tier to standard storage on both sequential and random reads.
 *  Never - No client-driven data is pulled from cool tier to standard storage.
 */
union CoolAccessRetrievalPolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OnRead: "OnRead",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Never: "Never",
}

/**
 * coolAccessTieringPolicy determines which cold data blocks are moved to cool tier. The possible values for this field are: Auto - Moves cold user data blocks in both the Snapshot copies and the active file system to the cool tier tier. This policy is the default. SnapshotOnly - Moves user data blocks of the Volume Snapshot copies that are not associated with the active file system to the cool tier.
 */
union CoolAccessTieringPolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Auto: "Auto",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SnapshotOnly: "SnapshotOnly",
}

/**
 * Flag indicating whether file access logs are enabled for the volume, based on active diagnostic settings present on the volume.
 */
union FileAccessLogs {
  string,

  /**
   * fileAccessLogs are enabled
   */
  Enabled: "Enabled",

  /**
   * fileAccessLogs are not enabled
   */
  Disabled: "Disabled",
}

/**
 * Specifies whether the volume is enabled for Azure VMware Solution (AVS) datastore purpose
 */
union AvsDataStore {
  string,

  /**
   * avsDataStore is enabled
   */
  Enabled: "Enabled",

  /**
   * avsDataStore is disabled
   */
  Disabled: "Disabled",
}

/**
 * Flag indicating whether subvolume operations are enabled on the volume
 */
union EnableSubvolumes {
  string,

  /**
   * subvolumes are enabled
   */
  Enabled: "Enabled",

  /**
   * subvolumes are not enabled
   */
  Disabled: "Disabled",
}

/**
 * The status of the replication
 */
@clientName("NetAppMirrorState", "csharp")
union MirrorState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Uninitialized: "Uninitialized",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Mirrored: "Mirrored",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Broken: "Broken",
}

/**
 * Specifies the type of the Large Volume. When set to 'LargeVolume', the large volume is created with standard configuration.
 * If it is set to 'ExtraLargeVolume7Dot2PiB', the extra large volume is created with higher capacity limit 7.2PiB with cool access enabled,
 * delivering higher capacity limit with lower costs.
 */
union LargeVolumeType {
  string,

  /**
   * The large volume is created with standard configuration that provides standard performance and throughput.
   */
  LargeVolume: "LargeVolume",

  /**
   * The extra large volume is created with higher volume capacity limit 7.2PiB with cool access enabled, delivering higher capacity limit with lower costs
   */
  ExtraLargeVolume7Dot2PiB: "PremExtraLargeVolume7Dot2PiB",
}

/**
 * Specifies whether the volume operates in Breakthrough Mode. When set to 'Enabled', the volume runs on the resources configured for this mode,
 * delivering improved performance and higher throughput. If set to 'Disabled' or omitted, the volume uses the basic configuration. This feature
 * is available only in regions where it’s been configured and first-time users must finish onboarding prior to using Breakthrough Mode.
 */
@added(Versions.v2025_09_01_preview)
union BreakthroughMode {
  string,

  /**
   * The volume runs on the resources configured for Breakthrough mode which ensures consistent high performance and a higher throughput.
   */
  Enabled: "Enabled",

  /**
   * The volume uses configuration that provides basic performance and throughput.
   */
  Disabled: "Disabled",
}

/**
 * Quota Report for volume
 */
@added(Versions.v2025_07_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_08_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_09_01)
model ListQuotaReportResponse {
  /**
   * List of quota reports
   */
  @identifiers(#[])
  value?: QuotaReport[];
}

/**
 * Quota report record properties
 */
@added(Versions.v2025_07_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_08_01_preview)
@removed(Versions.v2025_08_01)
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_09_01)
model QuotaReport {
  /**
   * Type of quota
   */
  quotaType?: Type;

  /**
   * UserID/GroupID/SID based on the quota target type. UserID and groupID can be found by running ‘id’ or ‘getent’ command for the user or group and SID can be found by running <wmic useraccount where name='user-name' get sid>
   */
  quotaTarget?: string;

  /**
   * Specifies the current usage in kibibytes for the user/group quota.
   */
  quotaLimitUsedInKiBs?: int64;

  /**
   * Specifies the total size limit in kibibytes for the user/group quota.
   */
  quotaLimitTotalInKiBs?: int64;

  /**
   * Percentage of used size compared to total size.
   */
  percentageUsed?: float32;

  /**
   * Flag to indicate whether the quota is derived from default quota.
   */
  isDerivedQuota?: boolean;
}

/**
 * Advanced Ransomware Protection reports (ARP) settings
 */
@added(Versions.v2025_09_01_preview)
model RansomwareProtectionSettings {
  /**
   * The desired value of the Advanced Ransomware Protection feature state available to the volume
   */
  desiredRansomwareProtectionState?: DesiredRansomwareProtectionState;

  /**
   * The actual state of the Advanced Ransomware Protection feature currently active on the volume
   */
  @visibility(Lifecycle.Read)
  actualRansomwareProtectionState?: ActualRansomwareProtectionState;
}

/**
 * Advanced Ransomware Protection reports (ARP) updatable settings
 */
@added(Versions.v2025_09_01_preview)
model RansomwareProtectionPatchSettings {
  /**
   * The desired value of the ARP feature state available to the volume
   */
  desiredRansomwareProtectionState?: DesiredRansomwareProtectionState;
}

/**
 * The desired state of the Advanced Ransomware Protection feature
 */
@added(Versions.v2025_09_01_preview)
union DesiredRansomwareProtectionState {
  string,

  /**
   * Advanced Ransomware Protection is disabled
   */
  Disabled: "Disabled",

  /**
   * Advanced Ransomware Protection is enabled
   */
  Enabled: "Enabled",
}

/**
 * The actual state of the Advanced Ransomware Protection feature
 */
@added(Versions.v2025_09_01_preview)
union ActualRansomwareProtectionState {
  string,

  /**
   * Advanced Ransomware Protection is disabled
   */
  Disabled: "Disabled",

  /**
   * Advanced Ransomware Protection is enabled
   */
  Enabled: "Enabled",

  /**
   * Advanced Ransomware Protection is in learning mode
   */
  Learning: "Learning",

  /**
   * Advanced Ransomware Protection is in paused state
   */
  Paused: "Paused",
}

@@visibility(Azure.ResourceManager.AvailabilityZonesProperty.zones,
  Lifecycle.Read,
  Lifecycle.Create
);

@armResourceOperations
interface Volumes {
  /**
   * Get the details of the specified volume
   */
  get is ArmResourceRead<Volume>;

  /**
   * Create or update the specified volume within the capacity pool
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Volume,
    Response = ArmResourceUpdatedResponse<Volume> | ArmResourceCreatedResponse<
      Volume,
      ArmAsyncOperationHeader<FinalResult = Volume> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Patch the specified volume
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Volume, PatchModel = VolumePatch>;

  /**
   * Delete the specified volume
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Volume,
    Parameters = {
      /**
       * An option to force delete the volume. Will cleanup resources connected to the particular volume
       */
      @query("forceDelete")
      forceDelete?: boolean;
    }
  >;

  /**
   * List all volumes within the capacity pool
   */
  list is ArmResourceListByParent<Volume, Response = ArmResponse<VolumeList>>;

  /**
   * This operation will populate availability zone information for a volume
   */
  populateAvailabilityZone is ArmResourceActionAsync<Volume, void, Volume>;

  /**
   * Revert a volume to the snapshot specified in the body
   */
  revert is ArmResourceActionAsync<
    Volume,
    VolumeRevert,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Reset cifs password from volume
   */
  resetCifsPassword is ArmResourceActionAsyncBase<
    Volume,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Volume>
  >;

  /**
   *  Split operation to convert clone volume to an independent volume.
   */
  splitCloneFromParent is ArmResourceActionAsync<Volume, void, Volume>;

  /**
   * Break all the file locks on a volume
   */
  breakFileLocks is ArmResourceActionAsync<
    Volume,
    BreakFileLocksRequest,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  /**
   * Returns the list of group Ids for a specific LDAP User
   */
  @removed(Versions.v2025_08_01)
  @sharedRoute
  @renamedFrom(Versions.v2025_08_01, "listGetGroupIdListForLdapUser")
  @action("getGroupIdListForLdapUser")
  listGetGroupIdListForLdapUser20250601 is ArmResourceActionAsync<
    Volume,
    /**
     * Returns the list of group Ids for a specific LDAP User
     */
    GetGroupIdListForLdapUserRequest,
    GetGroupIdListForLdapUserResponse
  >;

  /**
   * Returns the list of group Ids for a specific LDAP User
   */
  @added(Versions.v2025_08_01)
  @sharedRoute
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @action("getGroupIdListForLdapUser")
  listGetGroupIdListForLdapUser is ArmResourceActionAsync<
    Volume,
    GetGroupIdListForLdapUserRequest,
    GetGroupIdListForLdapUserResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = GetGroupIdListForLdapUserResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Break the replication connection on the destination volume
   */
  breakReplication is ArmResourceActionAsync<
    Volume,
    BreakReplicationRequest,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  /**
   * Re-establish a previously deleted replication between 2 volumes that have a common ad-hoc or policy-based snapshots
   */
  reestablishReplication is ArmResourceActionAsyncBase<
    Volume,
    ReestablishReplicationRequest,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Volume>
  >;

  /**
   * Get the status of the replication
   */
  @get
  replicationStatus is ArmResourceActionSync<
    Volume,
    void,
    ArmResponse<ReplicationStatus>
  >;

  /**
   * List all replications for a specified volume
   */
  @removed(Versions.v2025_08_01)
  @sharedRoute
  @renamedFrom(Versions.v2025_08_01, "listReplications")
  @list
  oldlistReplications is ArmResourceActionSync<
    Volume,
    void,
    ArmResponse<ListReplications>,
    OptionalRequestBody = true
  >;

  /**
   * List all replications for a specified volume
   */
  @added(Versions.v2025_08_01)
  @sharedRoute
  @list
  listReplications is ArmResourceActionSync<
    Volume,
    /** Body for the list replications endpoint. If supplied, the body will be used as a filter for example to exclude deleted replications. If omitted, the endpoint returns all replications */
    ListReplicationsRequest,
    ArmResponse<ListReplications>,
    OptionalRequestBody = true
  >;

  /**
   * Resync the connection on the destination volume. If the operation is ran on the source volume it will reverse-resync the connection and sync from destination to source.
   */
  resyncReplication is ArmResourceActionAsync<
    Volume,
    void,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete the replication connection on the destination volume, and send release to the source replication
   */
  deleteReplication is ArmResourceActionAsync<
    Volume,
    void,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Authorize the replication connection on the source volume
   */
  authorizeReplication is ArmResourceActionAsync<
    Volume,
    AuthorizeRequest,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Re-Initializes the replication connection on the destination volume
   */
  @action("reinitializeReplication")
  reInitializeReplication is ArmResourceActionAsync<
    Volume,
    void,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Starts peering the external cluster for this migration volume
   */
  peerExternalCluster is ArmResourceActionAsync<
    Volume,
    PeerClusterForVolumeMigrationRequest,
    ClusterPeerCommandResponse
  >;

  /**
   * Starts SVM peering and returns a command to be run on the external ONTAP to accept it.  Once the SVM have been peered a SnapMirror will be created
   */
  authorizeExternalReplication is ArmResourceActionAsync<
    Volume,
    void,
    SvmPeerCommandResponse
  >;

  /**
   * Finalizes the migration of an external volume by releasing the replication and breaking the external cluster peering if no other migration is active.
   */
  finalizeExternalReplication is ArmResourceActionAsyncBase<
    Volume,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Volume>
  >;

  /**
   * Performs an adhoc replication transfer on a volume with volumeType Migration
   */
  performReplicationTransfer is ArmResourceActionAsyncBase<
    Volume,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Volume>
  >;

  /**
   * Moves volume to another pool
   */
  poolChange is ArmResourceActionAsync<
    Volume,
    PoolChangeRequest,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Relocates volume to a new stamp
   */
  relocate is ArmResourceActionAsync<
    Volume,
    RelocateVolumeRequest,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
  >;

  /**
   * Finalizes the relocation of the volume and cleans up the old volume.
   */
  finalizeRelocation is ArmResourceActionAsync<
    Volume,
    void,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Reverts the volume relocation process, cleans up the new volume and starts using the former-existing volume.
   */
  revertRelocation is ArmResourceActionAsync<
    Volume,
    void,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Get the latest status of the backup for a volume
   */
  @get
  @action("latestBackupStatus/current")
  getLatestStatus is ArmResourceActionSync<
    Volume,
    void,
    ArmResponse<BackupStatus>
  >;

  /**
   * Get the latest status of the restore for a volume
   */
  @get
  @action("latestRestoreStatus/current")
  getVolumeLatestRestoreStatus is ArmResourceActionSync<
    Volume,
    void,
    ArmResponse<RestoreStatus>
  >;

  /**
   * Migrate the backups under volume to backup vault
   */
  migrateBackups is ArmResourceActionAsyncBase<
    Volume,
    BackupsMigrationRequest,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Volume>
  >;

  @added(Versions.v2025_07_01_preview)
  @removed(Versions.v2025_08_01)
  @added(Versions.v2025_08_01_preview)
  @removed(Versions.v2025_08_01)
  @added(Versions.v2025_09_01_preview)
  @removed(Versions.v2025_09_01)
  listQuotaReport is ArmResourceActionAsync<
    Volume,
    void,
    ArmResponse<ListQuotaReportResponse>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ListQuotaReportResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@maxLength(Volume.name, 64);
@@minLength(Volume.name, 1);
@@doc(Volume.name, "The name of the volume");
@@doc(Volume.properties, "Volume properties");
@@doc(Volumes.createOrUpdate::parameters.resource,
  "Volume object supplied in the body of the operation."
);
@@doc(Volumes.update::parameters.properties,
  "Volume object supplied in the body of the operation."
);
@@doc(Volumes.revert::parameters.body,
  "Object for snapshot to revert supplied in the body of the operation."
);
@@doc(Volumes.breakFileLocks::parameters.body,
  "Optional body to provide the ability to clear file locks with selected options"
);
@@doc(Volumes.listGetGroupIdListForLdapUser::parameters.body,
  "Returns group Id list for a specific LDAP user"
);
@@doc(Volumes.breakReplication::parameters.body,
  "Optional body to force break the replication."
);
@@doc(Volumes.reestablishReplication::parameters.body,
  "body for the id of the source volume."
);
@@doc(Volumes.authorizeReplication::parameters.body,
  "Authorize request object supplied in the body of the operation."
);
@@doc(Volumes.peerExternalCluster::parameters.body,
  "Cluster peer request object supplied in the body of the operation."
);
@@doc(Volumes.poolChange::parameters.body,
  "Move volume to the pool supplied in the body of the operation."
);
@@doc(Volumes.relocate::parameters.body, "Relocate volume request");
@@doc(Volumes.migrateBackups::parameters.body,
  "Migrate backups under volume payload supplied in the body of the operation."
);
