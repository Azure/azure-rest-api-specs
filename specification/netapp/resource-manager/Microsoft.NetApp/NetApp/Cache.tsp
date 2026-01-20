import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Volume.tsp";

using Rest;
using Azure.Core;
using Azure.ResourceManager;
using Http;
using Versioning;

namespace Microsoft.NetApp;
/**
 * Cache resource
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
@parentResource(CapacityPool)
model Cache is Azure.ResourceManager.TrackedResource<CacheProperties, false> {
  ...ResourceNameParameter<
    Resource = Cache,
    KeyName = "cacheName",
    SegmentName = "caches",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$"
  >;
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy EntityTagProperty for back compatibility"
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...Azure.ResourceManager.AvailabilityZonesProperty;
}

/**
 * List of Cache resources
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
model CacheList is Azure.Core.Page<Cache>;

/**
 * Cache resource properties
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
model CacheProperties {
  /**
   * The file path of the Cache.
   */
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-]{0,79}$")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  filepath: string;

  /**
   * Maximum storage quota allowed for a file system in bytes. Valid values are in the range 50GiB to 1PiB. Values expressed in bytes as multiples of 1GiB.
   */
  @minValue(53687091200)
  @maxValue(1125899906842624)
  size: int64;

  /**
   * Set of export policy rules
   */
  exportPolicy?: CachePropertiesExportPolicy;

  /**
   * Set of supported protocol types, which include NFSv3, NFSv4 and SMB protocol
   */
  protocolTypes?: ProtocolTypes[];

  /**
   * Azure lifecycle management
   */
  @visibility(Lifecycle.Read)
  provisioningState?: CacheProvisioningState;

  /**
   * Azure NetApp Files Cache lifecycle management
   */
  @visibility(Lifecycle.Read)
  cacheState?: CacheLifeCycleState;

  /**
   * The Azure Resource URI for a delegated cache subnet that will be used to allocate data IPs.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  cacheSubnetResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * The Azure Resource URI for a delegated subnet that will be used for ANF Intercluster Interface IP addresses.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  peeringSubnetResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * List of mount targets that can be used to mount this cache
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["mountTargetId"])
  mountTargets?: CacheMountTargetProperties[];

  /**
   * Describe if a cache is Kerberos enabled.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kerberos?: KerberosState;

  /**
   * SMB information for the cache
   */
  smbSettings?: SmbSettings;

  /**
   * Maximum throughput in MiB/s that can be achieved by this cache volume and this will be accepted as input only for manual qosType cache
   */
  throughputMibps?: float32;

  /**
   * Actual throughput in MiB/s for auto qosType volumes calculated based on size and serviceLevel
   */
  @visibility(Lifecycle.Read)
  actualThroughputMibps?: float32;

  /**
   * Source of key used to encrypt data in the cache. Applicable if NetApp account has encryption.keySource = 'Microsoft.KeyVault'. Possible values (case-insensitive) are: 'Microsoft.NetApp, Microsoft.KeyVault'
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  encryptionKeySource: EncryptionKeySource;

  /**
   * The resource ID of private endpoint for KeyVault. It must reside in the same VNET as the volume. Only applicable if encryptionKeySource = 'Microsoft.KeyVault'.
   */
  keyVaultPrivateEndpointResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/privateEndpoints";
    }
  ]>;

  /**
   * Maximum number of files allowed.
   */
  @visibility(Lifecycle.Read)
  maximumNumberOfFiles?: int64;

  /**
   * Specifies if the cache is encryption or not.
   */
  @visibility(Lifecycle.Read)
  encryption?: EncryptionState;

  /**
   * Language supported for volume.
   */
  @visibility(Lifecycle.Read)
  language?: VolumeLanguage;

  /**
   * Specifies whether LDAP is enabled or not for flexcache volume.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ldap?: LdapState;

  /**
   * Specifies the type of LDAP server for flexcache volume.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ldapServerType?: LdapServerType;

  /**
   * Origin cluster information
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  originClusterInformation: OriginClusterInformation;

  /**
   * Flag indicating whether a CIFS change notification is enabled for the cache.
   */
  cifsChangeNotifications?: CifsChangeNotifyState;

  /**
   * Flag indicating whether the global file lock is enabled for the cache.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  globalFileLocking?: GlobalFileLockingState;

  /**
   * Flag indicating whether writeback is enabled for the cache.
   */
  writeBack?: EnableWriteBackState;

  /**
   * Flag indicating whether file access logs are enabled for the cache, based on active diagnostic settings present on the cache.
   */
  @added(Versions.v2025_12_15_preview)
  @visibility(Lifecycle.Read)
  fileAccessLogs?: FileAccessLogs = FileAccessLogs.Disabled;
}

/**
 * SMB settings for the cache
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
model SmbSettings {
  /**
   * Enables encryption for in-flight smb3 data. Only applicable for SMB/DualProtocol cache.
   */
  smbEncryption?: SmbEncryptionState;

  /**
   * Enables access-based enumeration share property for SMB Shares. Only applicable for SMB/DualProtocol volume
   */
  smbAccessBasedEnumeration?: SmbAccessBasedEnumeration;

  /**
   * Enables non-browsable property for SMB Shares. Only applicable for SMB/DualProtocol volume
   */
  smbNonBrowsable?: SmbNonBrowsable;
}

/**
 * Stores the origin cluster information associated to a cache.
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
model OriginClusterInformation {
  /**
   * ONTAP cluster name of external cluster hosting the origin volume
   */
  peerClusterName: string;

  /**
   * ONTAP Intercluster LIF IP addresses. One IP address per cluster node is required
   */
  @minItems(1)
  peerAddresses: string[];

  /**
   * Actual ONTAP Intercluster LIF IP addresses. The modifyClusterPeer operation can be used to update these addresses.
   */
  @added(Versions.v2025_12_15_preview)
  @visibility(Lifecycle.Read)
  actualPeerAddresses?: string[];

  /**
   * External Vserver (SVM) name  name of the SVM hosting the origin volume
   */
  peerVserverName: string;

  /**
   * External origin volume name associated to this cache
   */
  peerVolumeName: string;
}

/**
 * The response containing peering passphrases and commands for cluster and vserver peering.
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
model PeeringPassphrases {
  /**
   * The cluster peering command.
   */
  clusterPeeringCommand: string;

  /**
   * The cluster peering passphrase.
   */
  clusterPeeringPassphrase: string;

  /**
   * The vserver peering command.
   */
  vserverPeeringCommand: string;

  /**
   * Warnings that are critical for the cluster peering and vserver peering processes.
   */
  @added(Versions.v2025_12_15_preview)
  @visibility(Lifecycle.Read)
  criticalWarning?: string;
}

/**
 * Contains all the information needed to mount a cache
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
model CacheMountTargetProperties {
  /**
   * UUID v4 used to identify the MountTarget
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  mountTargetId?: string;

  /**
   * The mount target's IPv4 address, used to mount the cache.
   */
  @visibility(Lifecycle.Read)
  ipAddress?: ipV4Address;

  /**
   * The SMB server's Fully Qualified Domain Name, FQDN
   */
  @visibility(Lifecycle.Read)
  smbServerFqdn?: string;
}

/**
 * Flag indicating whether writeback is enabled for the cache.
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
union EnableWriteBackState {
  string,

  /**
   * Writeback cache is disabled
   */
  Disabled: "Disabled",

  /**
   * Writeback cache is enabled
   */
  Enabled: "Enabled",
}

/**
 * Specifies whether LDAP is enabled or not.
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
union LdapState {
  string,

  /**
   * ldap is disabled.
   */
  Disabled: "Disabled",

  /**
   * ldap is enabled
   */
  Enabled: "Enabled",
}

/**
 * Set of export policy rules
 */
model CachePropertiesExportPolicy {
  /**
   * Export policy rule
   */
  @identifiers(#["ruleIndex"])
  rules?: ExportPolicyRule[];
}

/**
 * Flag indicating whether the global file lock is enabled for the cache.
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
union GlobalFileLockingState {
  string,

  /**
   * Global file locking is disabled
   */
  Disabled: "Disabled",

  /**
   * Global file locking is enabled
   */
  Enabled: "Enabled",
}

/**
 * Flag indicating whether a CIFS change notification is enabled for the cache.
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
union CifsChangeNotifyState {
  string,

  /**
   * CIFS change notification is disabled
   */
  Disabled: "Disabled",

  /**
   * CIFS change notification is enabled
   */
  Enabled: "Enabled",
}

/**
 * Specifies if the cache is encryption or not.
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
union EncryptionState {
  string,

  /**
   * Encryption is disabled
   */
  Disabled: "Disabled",

  /**
   * Encryption is enabled
   */
  Enabled: "Enabled",
}

/**
 * Describe if a cache is Kerberos enabled.
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
union KerberosState {
  string,

  /**
   * Kerberos is disabled
   */
  Disabled: "Disabled",

  /**
   * Kerberos is enabled
   */
  Enabled: "Enabled",
}

/**
 * Azure NetApp Files Cache lifecycle management
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
union CacheLifeCycleState {
  string,

  /**
   * Cluster peering offer has been sent.
   */
  ClusterPeeringOfferSent: "ClusterPeeringOfferSent",

  /**
   * VServer peering offer has been sent.
   */
  VserverPeeringOfferSent: "VserverPeeringOfferSent",

  /**
   * Cache creation in progress.
   */
  Creating: "Creating",

  /**
   * Cache creation succeeded and is available for use.
   */
  Succeeded: "Succeeded",

  /**
   * Cache is in a failed state
   */
  Failed: "Failed",
}

/**
 * Enables encryption for in-flight smb3 data. Only applicable for SMB/DualProtocol cache
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
union SmbEncryptionState {
  string,

  /**
   * SMB encryption is disabled
   */
  Disabled: "Disabled",

  /**
   * SMB encryption is enabled
   */
  Enabled: "Enabled",
}

/**
 * Set of supported protocol types, which include NFSv3, NFSv4 and SMB protocol
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
union ProtocolTypes {
  string,

  /**
   * NFSv3 protocol type
   */
  NFSv3: "NFSv3",

  /**
   * NFSv4 protocol type
   */
  NFSv4: "NFSv4",

  /**
   * SMB protocol type
   */
  SMB: "SMB",
}

/**
 * Azure lifecycle management
 */
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
union CacheProvisioningState {
  string,

  /**
   * The resource is being created.
   */
  Creating: "Creating",

  /**
   * The resource is being updated.
   */
  Updating: "Updating",

  /**
   * The resource is being deleted.
   */
  Deleting: "Deleting",

  /**
   * The resource is in a failed state.
   */
  Failed: "Failed",

  /**
   * The resource is succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * Resource creation was canceled.
   */
  Canceled: "Canceled",
}

/**
 * Break file locks request
 */
@added(Versions.v2025_12_15_preview)
model CacheBreakFileLocksRequest {
  /**
   * The IP address of the client whose file locks should be broken
   */
  clientIp?: Azure.Core.ipV4Address;
}

/**
 * Modify cluster peer request
 */
@added(Versions.v2025_12_15_preview)
model ModifyClusterPeerRequest {
  /**
   * The complete set of peer addresses for the cluster.
   * This array replaces the existing peer addresses. Include all addresses you want to keep, plus any new addresses.
   * Any existing addresses not included in this array will be removed from the cluster peer configuration.
   */
  @minItems(1)
  newPeerAddresses: string[];
}

@armResourceOperations
@added(Versions.v2025_09_01_preview)
@removed(Versions.v2025_12_01)
@added(Versions.v2025_12_15_preview)
interface Caches {
  /**
   * Get the details of the specified Cache
   */
  get is ArmResourceRead<Cache>;

  /**
   * Create or update the specified Cache within the Capacity Pool
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Cache>;

  /**
   * Patch the specified Cache
   */
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    Cache,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Cache,
      CacheProperties
    >,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = Cache> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete the specified cache
   */
  delete is ArmResourceDeleteWithoutOkAsync<Cache>;

  /**
   * List all Caches within the Capacity Pool
   */
  listByCapacityPools is ArmResourceListByParent<
    Cache,
    Response = ArmResponse<CacheList>
  >;

  /**
   * This operation will list the cluster peering command, cluster peering passphrase and the vserver peering command
   */
  listPeeringPassphrases is ArmResourceActionSync<
    Cache,
    void,
    ArmResponse<PeeringPassphrases>
  >;

  /**
   * Moves Cache  to another Capacity Pool
   */
  poolChange is ArmResourceActionAsync<
    Cache,
    PoolChangeRequest,
    Cache,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Resets the SMB password for the cache
   */
  @added(Versions.v2025_12_15_preview)
  resetSmbPassword is ArmResourceActionAsync<
    Resource = Cache,
    Request = void,
    Response = Cache,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Break all the file locks on a cache for a given client IP and if no client IP is provided, break all file locks on the cache.
   */
  @added(Versions.v2025_12_15_preview)
  breakFileLocks is ArmResourceActionAsync<
    Resource = Cache,
    Request = CacheBreakFileLocksRequest,
    OptionalRequestBody = true,
    Response = Cache,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Modify the cluster peer addresses for the cache's origin cluster.
   */
  @added(Versions.v2025_12_15_preview)
  modifyClusterPeer is ArmResourceActionAsync<
    Resource = Cache,
    Request = ModifyClusterPeerRequest,
    Response = Cache,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(Caches.poolChange::parameters.body,
  "Move cache to the pool supplied in the body of the operation."
);
@@doc(Caches.breakFileLocks::parameters.body,
  "Request to break file locks on a cache. Note: NFSv3 byte-range locks are held at the origin volume and must be broken there. SMB and NFSv4 locks (share locks and byte-range locks) are held at the cache and can be broken using this operation."
);

@@maxLength(Cache.name, 64);
@@minLength(Cache.name, 3);
@@doc(Cache.name, "The name of the cache resource.");
@@doc(Cache.properties, "Cache properties");
