import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@armProviderNamespace("Microsoft.OrionDB")
namespace Microsoft.OrionDB;

/**
 * The PG engine majorversion for OrionDb cluster.
 */
union OrionDbVersion {
  string,
  /** PG engine majorversion 17 */
  Seventeen: "17",
  /** PG engine majorversion 16 */
  Sixteen: "16",
  /** PG engine majorversion 15 */
  Fifteen: "15",
  /** PG engine majorversion 14 */
  Fourteen: "14",
  /** PG engine majorversion 13 */
  Thirteen: "13",
}

/**
 * A state of a Orion Db cluster that is visible to user.
 */
union ClusterState {
  string,
  /** Represents it is created and ready to use. */
  Ready: "Ready",
  /** Represents it is being dropped. */
  Dropping: "Dropping",
  /** Represents it is disabled. */
  Disabled: "Disabled",
  /** Represents it is starting. */
  Starting: "Starting",
  /** Represents it is stopping. */
  Stopping: "Stopping",
  /** Represents it is stopped. */
  Stopped: "Stopped",
  /** Represents it is being updated. */
  Updating: "Updating",
}

/**
 * The mode to create a new Orion Db cluster
 */
union CreateMode {
  string,
  /** Create or Update a new Orion Db cluster */
  Default: "Default",
  /** Create a new Orion Db cluster */
  Create: "Create",
  /** Update an existing Orion Db cluster. */
  Update: "Update",
  /** Restore an existing Orion Db cluster to a point in time. */
  PointInTimeRestore: "PointInTimeRestore",
  /** Restore an existing Orion Db cluster to a geo location. */
  GeoRestore: "GeoRestore",
  /** Revive a dropped Orion Db cluster. */
  ReviveDropped: "ReviveDropped",
}

/**
 * Flag to enable / disable Storage Auto grow for an Orion Db cluster.
 */
union StorageAutoGrow {
  string,
  /** Enable Storage Auto grow for an Orion Db cluster. */
  Enabled: "Enabled",
  /** Disable Storage Auto grow for an Orion Db cluster. */
  Disabled: "Disabled",
}

/**
 * Name of storage tier for IOPS.
 */
union AzureManagedDiskPerformanceTiers {
  string,
  /** Performance tier P1 */
  P1: "P1",
  /** Performance tier P2 */  
  P2: "P2",
  /** Performance tier P3 */
  P3: "P3",
  /** Performance tier P4 */
  P4: "P4",
  /** Performance tier P6 */
  P6: "P6",
  /** Performance tier P10 */
  P10: "P10",
  /** Performance tier P15 */
  P15: "P15",
  /** Performance tier P20 */
  P20: "P20",
  /** Performance tier P30 */
  P30: "P30",
  /** Performance tier P40 */
  P40: "P40",
  /** Performance tier P50 */
  P50: "P50",
  /** Performance tier P60 */
  P60: "P60",
  /** Performance tier P70 */
  P70: "P70",
  /** Performance tier P80 */
  P80: "P80",
}

/**
 * Storage type for the cluster. Allowed values are Premium_LRS, PremiumV2_LRS, and UltraSSD_LRS. Default is Premium_LRS if not specified
 */
union StorageType {
  string,
  /** Premium SSD */
  Premium_LRS: "Premium_LRS",
  /** Premium SSD V2 */
  PremiumV2_LRS: "PremiumV2_LRS",
  /** Ultra SSD */
  UltraSSD_LRS: "UltraSSD_LRS",
}

/**
 * Represents if Entra authentication is enabled or disabled.
 */
union activeDirectoryAuthEnum {
  string,
  /** Entra authentication is enabled */
  Enabled: "Enabled",
  /** Entra authentication is disabled */
  Disabled: "Disabled",
}

/**
 * Represents if Password authentication is enabled or disabled.
 */
union PasswordAuthEnum {
  string,
  /** Password authentication is enabled */
  Enabled: "Enabled",
  /** Password authentication is disabled */
  Disabled: "Disabled",
}

/**
 * Data encryption type to depict if it is System Managed vs Azure Key vault.
 */
union DataEncryptionKeyType {
  string,
  /** System Managed data encryption */
  SystemManaged: "SystemManaged",
  /** Azure Key Vault data encryption */
  AzureKeyVault: "AzureKeyVault",
}

/**
 * Primary encryption key status for Data encryption enabled cluster.
 */
union KeyStatusEnum {
  string,
  /** Key is valid */
  Valid: "Valid",
  /** Key is invalid */
  Invalid: "Invalid",
}

/**
 * A value indicating whether Geo-Redundant backup is enabled on the cluster.
 */
union GeoRedundantBackupEnum {
  string,
  /** Geo-Redundant backup is enabled */
  Enabled: "Enabled",
  /** Geo-Redundant backup is disabled */
  Disabled: "Disabled",
}

/**
 * Public network access is enabled or not for Orion Db cluster.
 */
union ClusterPublicNetworkAccessState {
  string,
  /** Public network access is enabled */
  Enabled: "Enabled",
  /** Public network access is disabled */
  Disabled: "Disabled",
}

/**
 * The HA mode for the cluster.
 */
union HighAvailabilityMode {
  string,
  /** High availability is not enabled */
  Disabled: "Disabled",
  /** Zone redundant high availability is enabled*/
  ZoneRedundant: "ZoneRedundant",
  /** Same zone high availability is enabled*/
  SameZone: "SameZone",
}

/**
 * A state of a HA cluster that is visible to user.
 */
union ClusterHAState {
  string,
  /** High availability is not enabled */
  NotEnabled: "NotEnabled",
  /** Creating standby cluster */
  CreatingStandby: "CreatingStandby",
  /** Replicating data to standby */
  ReplicatingData: "ReplicatingData",
  /** Failing over to standby */
  FailingOver: "FailingOver",
  /** High availability is healthy */
  Healthy: "Healthy",
  /** Removing standby cluster */
  RemovingStandby: "RemovingStandby",
}

/**
 * Represents a Orion Db resource.
 */
model OrionDbResource is Azure.ResourceManager.TrackedResource<OrionDbResourceProperties> {
  ...ResourceNameParameter<OrionDbResource, "orionDbClusterName", "clusters", "^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*">;

  /**
   * The SKU (pricing tier) of the Orion DB default pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  defaultPoolSku?: Azure.ResourceManager.CommonTypes.Sku;

  /**
   * Describes the identity of the application.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: Azure.ResourceManager.CommonTypes.UserAssignedIdentity;
}

/**
 * The properties of a OrionDbResource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model OrionDbResourceProperties {
  /**
   * The mode to create a new OrionDB cluster.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  createMode?: CreateMode;

  /**
   * The administrator username for the Orion Db. Once created it cannot be changed..
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  administratorLogin?: string;

  /**
   * The administrator login password (required for Orion Db creation).
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  administratorLoginPassword?: string;

  /**
   * The version of the Orion DB.
   */
  version?: OrionDbVersion;

  /**
   * The fully qualified domain name of the Orion Db.
   */
  @visibility(Lifecycle.Read)
  fullyQualifiedDomainName?: string;

  /**
   * A state of the Orion Db that is visible to user.
   */
  @visibility(Lifecycle.Read)
  state?: ClusterState;

  /**
   * The availability zone of the Orion Db.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  availabilityZone?: string = "";

  /**
   * The SKU (pricing tier) for default pool in the Orion Db cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  defaultSku?: Azure.ResourceManager.CommonTypes.Sku;

  /**
   * Storage properties of a Orion Db.
   */
  storage?: Storage;

  /**
   * AuthConfig properties of a Orion Db.
   */
  authConfig?: AuthConfig;

  /**
   * Data encryption properties of a Orion Db.
   */
  dataEncryption?: DataEncryption;

  /**
   * Backup properties of a Orion Db.
   */
  backup?: Backup;

  /**
   * Network properties of a Orion Db. This Network property is required to be passed only in case you want the cluster to be Private access cluster.
   */
  network?: Network;

  /**
   * High availability properties of a Orion Db.
   */
  highAvailability?: HighAvailability;

  /**
   * Maintenance window properties of a Orion Db.
   */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  maintenanceWindow?: MaintenanceWindow;

  /**
   * The source Orion Db resource ID. This property is not returned in the response of GET operation. It is required when 'createMode' is 'PointInTimeRestore' or 'GeoRestore' or 'ReviveDropped'. It is not required when 'createMode' is 'Create', 'Update', 'Default'.
   */
  @visibility(Lifecycle.Create)
  sourceOrionDbResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OrionDB/clusters";
    }
  ]>;

  /**
   * Restore point creation time (ISO8601 format), specifying the time to restore from. It's required when 'createMode' is 'PointInTimeRestore' or 'GeoRestore'.
   */
  @visibility(Lifecycle.Create)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  pointInTimeUTC?: utcDateTime;
}

/**
 * Storage properties of a cluster
 */
model Storage {
  /**
   * Max storage allowed for a cluster.
   */
  storageSizeGB?: int32;

  /**
   * Flag to enable / disable Storage Auto grow for an Orion Db cluster.
   */
  autoGrow?: StorageAutoGrow;

  /**
   * Name of storage tier for IOPS.
   */
  tier?: AzureManagedDiskPerformanceTiers;

  /**
   * Storage tier IOPS quantity. This property is required to be set for storage Type PremiumV2_LRS and UltraSSD_LRS.
   */
  iops?: int32;

  /**
   * Storage throughput for the cluster. This is required to be set for storage Type PremiumV2_LRS and UltraSSD_LRS.
   */
  throughput?: int32;

  /**
   * Storage type for the cluster. Allowed values are Premium_LRS, PremiumV2_LRS, and UltraSSD_LRS. Default is Premium_LRS if not specified
   */
  type?: StorageType;
}

/**
 * Authentication configuration properties of a cluster
 */
model AuthConfig {
  /**
   * If Enabled, Azure Entra authentication is enabled.
   */
  activeDirectoryAuth?: activeDirectoryAuthEnum;

  /**
   * If Enabled, Password authentication is enabled.
   */
  passwordAuth?: PasswordAuthEnum;

  /**
   * Tenant id of the cluster.
   */
  tenantId?: string = "";
}

/**
 * Data encryption properties of a cluster
 */
model DataEncryption {
  /**
   * URI for the key in keyvault for data encryption of the primary cluster.
   */
  primaryKeyURI?: string;

  /**
   * Resource Id for the User assigned identity to be used for data encryption of the primary cluster.
   */
  primaryUserAssignedIdentityId?: string;

  /**
   * URI for the key in keyvault for data encryption for geo-backup of cluster.
   */
  geoBackupKeyURI?: string;

  /**
   * Resource Id for the User assigned identity to be used for data encryption for geo-backup of cluster.
   */
  geoBackupUserAssignedIdentityId?: string;

  /**
   * Data encryption type to depict if it is System Managed vs Azure Key vault.
   */
  type?: DataEncryptionKeyType;

  /**
   * Primary encryption key status for Data encryption enabled cluster.
   */
  @visibility(Lifecycle.Read)
  primaryEncryptionKeyStatus?: KeyStatusEnum;

  /**
   * Geo-backup encryption key status for Data encryption enabled cluster.
   */
  @visibility(Lifecycle.Read)
  geoBackupEncryptionKeyStatus?: KeyStatusEnum;
}

/**
 * Backup properties of an Orion Db cluster.
 */
model Backup {
  /**
   * Backup retention days for the cluster.
   */
  backupRetentionDays?: int32 = 7;

  /**
   * A value indicating whether Geo-Redundant backup is enabled on the cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  geoRedundantBackup?: GeoRedundantBackupEnum;

  /**
   * The earliest restore point time (ISO8601 format) for a cluster.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  earliestRestoreDate?: utcDateTime;
}

/**
 * Network properties of an OrionDb cluster.
 */
model Network {
  /**
   * public network access is enabled or not
   */
  publicNetworkAccess?: ClusterPublicNetworkAccessState;

  /**
   * Delegated subnet arm resource id. This is required to be passed during create, in case we want the cluster to be VNET injected, i.e. Private access cluster. During update, pass this only if we want to update the value for Private DNS zone.
   */
  delegatedSubnetResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * Private dns zone arm resource id. This is required to be passed during create, in case we want the cluster to be VNET injected, i.e. Private access cluster. During update, pass this only if we want to update the value for Private DNS zone.
   */
  privateDnsZoneArmResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/privateDnsZones";
    }
  ]>;
}

/**
 * High availability properties of a cluster
 */
model HighAvailability {
  /**
   * The HA mode for the cluster.
   */
  mode?: HighAvailabilityMode;

  /**
   * A state of a HA cluster that is visible to user.
   */
  @visibility(Lifecycle.Read)
  state?: ClusterHAState;

  /**
   * availability zone information of the standby.
   */
  standbyAvailabilityZone?: string = "";
}

/**
 * Maintenance window properties of a cluster.
 */
model MaintenanceWindow {
  /**
   * indicates whether custom window is enabled or disabled
   */
  customWindow?: string = "Disabled";

  /**
   * start hour for maintenance window
   */
  startHour?: int32;

  /**
   * start minute for maintenance window
   */
  startMinute?: int32;

  /**
   * day of week for maintenance window
   */
  dayOfWeek?: int32;
}
