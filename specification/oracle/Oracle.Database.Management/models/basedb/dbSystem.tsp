import "../common.tsp";
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Oracle.Database;

@added(Versions.v20250701_preview)
scalar ResourceAnchorResourceId
  extends armResourceIdentifier<[
    {
      type: "Oracle.Database/resourceAnchors",
    }
  ]>;

@added(Versions.v20250701_preview)
scalar NetworkAnchorResourceId
  extends armResourceIdentifier<[
    {
      type: "Oracle.Database/networkAnchors",
    }
  ]>;

//OCI Reference: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/DbSystem/
@added(Versions.v20250701_preview)
@doc("DbSystem resource definition")
model DbSystem is TrackedResource<DbSystemProperties> {
  ...ResourceNameParameter<DbSystem, NamePattern = ".*">;
  ...AvailabilityZonesProperty;
}

@added(Versions.v20250701_preview)
@doc("DbSystem resource model.")
model DbSystemProperties extends DbSystemBaseProperties {
  @doc("The source of the database for creating a new database.")
  source: DbSystemSourceType.None;

  @doc("The Oracle Database Edition that applies to all the databases on the DB system. Exadata DB systems and 2-node RAC DB systems require EnterpriseEditionExtremePerformance.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  databaseEdition: DbSystemDatabaseEditionType;

  @doc("A strong password for SYS, SYSTEM, and PDB Admin. The password must be at least nine characters and contain at least two uppercase, two lowercase, two numbers, and two special characters. The special characters must be _, #, or -.")
  @visibility(Lifecycle.Create)
  @minLength(1)
  @maxLength(255)
  adminPassword?: Password;

  @doc("A valid Oracle Database version. For a list of supported versions, use the ListDbVersions operation.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  dbVersion: string;

  @doc("The name of the pluggable database. The name must begin with an alphabetic character and can contain a maximum of thirty alphanumeric characters. Special characters are not permitted. Pluggable database should not be same as database name.")
  @visibility(Lifecycle.Create)
  pdbName?: string;
}

//OCI Reference: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/datatypes/LaunchDbSystemBase
@added(Versions.v20250701_preview)
@doc("DbSystem resource base model.")
@discriminator("source")
model DbSystemBaseProperties {
  @doc("The source of the database: Use `None` for creating a new database. The default is `None`.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  source?: DbSystemSourceType = DbSystemSourceType.None;

  @doc("dbSystem provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: AzureResourceProvisioningState;

  @doc("HTTPS link to OCI resources exposed to Azure Customer via Azure Interface.")
  @visibility(Lifecycle.Read)
  ociUrl?: url;

  @doc("Azure Resource Anchor ID")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  resourceAnchorId: ResourceAnchorResourceId;

  @doc("Azure Network Anchor ID")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  networkAnchorId: NetworkAnchorResourceId;

  @doc("The cluster name for Exadata and 2-node RAC virtual machine DB systems. The cluster name must begin with an alphabetic character, and may contain hyphens (-). Underscores (_) are not permitted. The cluster name can be no longer than 11 characters and is not case sensitive.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minLength(1)
  @maxLength(11)
  clusterName?: string;

  @removed(Versions.v20250815_preview)
  @doc("The number of CPU cores enabled on the DB system.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minValue(1)
  cpuCoreCount: int32;

  @doc("The user-friendly name for the DB system. The name does not have to be unique.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minLength(1)
  @maxLength(255)
  displayName?: string;

  @doc("Size in GB of the initial data volume that will be created and attached to a virtual machine DB system. You can scale up storage after provisioning, as needed. Note that the total storage size attached will be more than the amount you specify to allow for REDO/RECO space and software volume.")
  @visibility(Lifecycle.Create)
  @minValue(2)
  initialDataStorageSizeInGb?: int32 = 256;

  @doc("The data storage size, in gigabytes, that is currently available to the DB system. Applies only for virtual machine DB systems.")
  @visibility(Lifecycle.Read)
  @minValue(2)
  dataStorageSizeInGbs?: int32;

  @doc("The DB system options.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  dbSystemOptions?: DbSystemOptions;

  @doc("The type of redundancy configured for the DB system. NORMAL is 2-way redundancy. HIGH is 3-way redundancy.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  diskRedundancy?: DiskRedundancyType;

  @removed(Versions.v20250815_preview)
  @doc("The domain name for the DB system.")
  @visibility(Lifecycle.Read)
  domain?: string;

  @added(Versions.v20250815_preview)
  @doc("The domain name for the DB system.")
  @encodedName("application/json", "domain")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  domainV2?: string;

  @doc("The OCID of a grid infrastructure software image. This is a database software image of the type GRID_IMAGE.")
  @visibility(Lifecycle.Read)
  @minLength(1)
  @maxLength(255)
  gridImageOcid?: Ocid;

  @doc("The hostname for the DB system.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  hostname: string;

  @doc("The OCID of the DB system.")
  @visibility(Lifecycle.Read)
  ocid?: Ocid;

  @removed(Versions.v20250815_preview)
  @doc("The Oracle license model that applies to all the databases on the DB system. The default is LicenseIncluded.")
  @visibility(Lifecycle.Read)
  licenseModel?: LicenseModel = LicenseModel.LicenseIncluded;

  @added(Versions.v20250815_preview)
  @doc("The Oracle license model that applies to all the databases on the DB system. The default is LicenseIncluded.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @encodedName("application/json", "licenseModel")
  licenseModelV2?: LicenseModel = LicenseModel.LicenseIncluded;

  @doc("Additional information about the current lifecycle state.")
  @visibility(Lifecycle.Read)
  lifecycleDetails?: string;

  @doc("The current state of the DB system.")
  @visibility(Lifecycle.Read)
  lifecycleState?: DbSystemLifecycleState;

  @doc("The port number configured for the listener on the DB system.")
  @visibility(Lifecycle.Read)
  listenerPort?: int32;

  @doc("Memory allocated to the DB system, in gigabytes.")
  @visibility(Lifecycle.Read)
  memorySizeInGbs?: int32;

  @doc("The number of nodes in the DB system. For RAC DB systems, the value is greater than 1.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minValue(1)
  nodeCount?: int32 = 1;

  @doc("The FQDN of the DNS record for the SCAN IP addresses that are associated with the DB system.")
  @visibility(Lifecycle.Read)
  @minLength(1)
  @maxLength(72)
  scanDnsName?: string;

  @doc("The list of Single Client Access Name (SCAN) IP addresses associated with the DB system. SCAN IP addresses are typically used for load balancing and are not assigned to any interface. Oracle Clusterware directs the requests to the appropriate nodes in the cluster. Note: For a single-node DB system, this list is empty.")
  @visibility(Lifecycle.Read)
  scanIps?: string[];

  @doc("The shape of the DB system. The shape determines resources to allocate to the DB system. For virtual machine shapes, the number of CPU cores and memory. For bare metal and Exadata shapes, the number of CPU cores, storage, and memory.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minLength(1)
  @maxLength(255)
  shape: string;

  @doc("The public key portion of one or more key pairs used for SSH access to the DB system.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  sshPublicKeys: SshPublicKey[];

  @doc("The block storage volume performance level. Valid values are Balanced and HighPerformance. See [Block Volume Performance](/Content/Block/Concepts/blockvolumeperformance.htm) for more information.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  storageVolumePerformanceMode?: StorageVolumePerformanceMode;

  @doc("The time zone of the DB system, e.g., UTC, to set the timeZone as UTC.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minLength(1)
  @maxLength(255)
  timeZone?: string;

  @doc("The Oracle Database version of the DB system.")
  @visibility(Lifecycle.Read)
  version?: string;

  @doc("The compute model for Base Database Service. This is required if using the `computeCount` parameter. If using `cpuCoreCount` then it is an error to specify `computeModel` to a non-null value. The ECPU compute model is the recommended model, and the OCPU compute model is legacy.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  computeModel?: ComputeModel;

  @doc("The number of compute servers for the DB system.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  computeCount?: int32;
}

@added(Versions.v20250701_preview)
@doc("Database edition type enum.")
union DbSystemDatabaseEditionType {
  @doc("Standard edition")
  StandardEdition: "StandardEdition",

  @doc("Enterprise edition")
  EnterpriseEdition: "EnterpriseEdition",

  @doc("Enterprise edition high performance")
  EnterpriseEditionHighPerformance: "EnterpriseEditionHighPerformance",

  @doc("Enterprise edition extreme")
  EnterpriseEditionExtreme: "EnterpriseEditionExtreme",

  @doc("Enterprise edition developer")
  EnterpriseEditionDeveloper: "EnterpriseEditionDeveloper",

  string,
}

@added(Versions.v20250701_preview)
@doc("Disk redundancy type enum.")
union DiskRedundancyType {
  @doc("3-way redundancy.")
  High: "High",

  @doc("2-way redundancy.")
  Normal: "Normal",

  string,
}

@added(Versions.v20250701_preview)
@doc("DB System lifecycle state enum")
union DbSystemLifecycleState {
  @doc("Indicates that resource in Provisioning state")
  Provisioning: "Provisioning",

  @doc("Indicates that resource in Available state")
  Available: "Available",

  @doc("Indicates that resource in Updating state")
  Updating: "Updating",

  @doc("Indicates that resource in Terminating state")
  Terminating: "Terminating",

  @doc("Indicates that resource in Terminated state")
  Terminated: "Terminated",

  @doc("Indicates that resource in Failed state")
  Failed: "Failed",

  @doc("Indicates that resource is Migrated state")
  Migrated: "Migrated",

  @doc("Indicates that resource maintenance in progress state")
  MaintenanceInProgress: "MaintenanceInProgress",

  @doc("Indicates that resource needs attention state")
  NeedsAttention: "NeedsAttention",

  @doc("Indicates that resource in Upgrading state")
  Upgrading: "Upgrading",

  string,
}

@added(Versions.v20250701_preview)
@doc("Storage volume performance mode.")
union StorageVolumePerformanceMode {
  @doc("With this option, you are purchasing 10 VPUs per GB/month. For more information, including specific throughput and IOPS performance numbers for various volume sizes.")
  Balanced: "Balanced",

  @doc("With this option, you are purchasing 20 VPUs per GB/month. For more information, including specific throughput and IOPS performance numbers for various volume sizes.")
  HighPerformance: "HighPerformance",

  string,
}

@added(Versions.v20250701_preview)
@doc("The DbSystem source type of the database.")
union DbSystemSourceType {
  @doc("for creating a new database.")
  None: "None",

  string,
}

@added(Versions.v20250701_preview)
@doc("DbSystemOptions resource properties.")
model DbSystemOptions {
  @doc("The storage option used in DB system. ASM - Automatic storage management, LVM - Logical Volume management.")
  storageManagement?: StorageManagementType;
}
