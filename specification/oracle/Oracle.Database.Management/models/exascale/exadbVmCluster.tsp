import "../common.tsp";
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Oracle.Database;

@added(Versions.v20241201_preview)
@doc("ExadbVmCluster resource definition")
model ExadbVmCluster is TrackedResource<ExadbVmClusterProperties> {
  ...ResourceNameParameter<ExadbVmCluster>;
  ...AvailabilityZonesProperty;
}

@added(Versions.v20241201_preview)
@doc("ExadbVmCluster resource model")
model ExadbVmClusterProperties {
  @doc("ExadbVmCluster ocid")
  @visibility("read")
  ocid?: Ocid;

  @doc("The cluster name for Exadata VM cluster on Exascale Infrastructure. The cluster name must begin with an alphabetic character, and may contain hyphens (-). Underscores (_) are not permitted. The cluster name can be no longer than 11 characters and is not case sensitive.")
  @visibility("create", "read")
  @minLength(1)
  @maxLength(11)
  clusterName?: string;

  @doc("Client OCI backup subnet CIDR, default is 192.168.252.0/22")
  @visibility("create", "read")
  @minLength(1)
  @maxLength(32)
  backupSubnetCidr?: string;

  @doc("HTTPS link to OCI Network Security Group exposed to Azure Customer via the Azure Interface.")
  @visibility("read")
  nsgUrl?: url;

  @doc("Exadata VM cluster on Exascale Infrastructure provisioning state")
  @visibility("read")
  provisioningState?: AzureResourceProvisioningState;

  @doc("CloudVmCluster lifecycle state")
  @visibility("read")
  lifecycleState?: ExadbVmClusterLifecycleState;

  @doc("VNET for network connectivity")
  @visibility("create", "read")
  vnetId: VnetId;

  @doc("Client subnet")
  @visibility("create", "read")
  subnetId: SubnetId;

  @doc("Indicates user preferences for the various diagnostic collection options for the VM cluster/Cloud VM cluster/VMBM DBCS.")
  @visibility("create", "read")
  dataCollectionOptions?: DataCollectionOptions;

  @doc("Display Name")
  @minLength(1)
  @maxLength(255)
  @visibility("create", "read")
  displayName: string;

  @doc("A domain name used for the Exadata VM cluster on Exascale Infrastructure")
  @visibility("create", "read")
  domain?: string;

  @doc("The number of ECPUs to enable for an Exadata VM cluster on Exascale Infrastructure.")
  @minValue(0)
  @visibility("create", "read")
  enabledEcpuCount: int32;

  @doc("The Azure Resource ID of the Exadata Database Storage Vault.")
  @visibility("create", "read")
  exascaleDbStorageVaultId: ExascaleDbStorageVaultResourceId;

  @doc("Grid Setup will be done using this Grid Image OCID. Can be obtained using giMinorVersions API")
  @minLength(1)
  @maxLength(255)
  @visibility("create", "read")
  gridImageOcid?: Ocid;

  @doc("The type of Grid Image")
  @visibility("read")
  gridImageType?: GridImageType;

  @doc("Oracle Grid Infrastructure (GI) software version")
  @visibility("read")
  @minLength(1)
  @maxLength(255)
  giVersion?: string;

  @doc("The hostname for the  Exadata VM cluster on Exascale Infrastructure.")
  @visibility("create", "read")
  @minLength(1)
  @maxLength(12)
  hostname: string;

  @doc("The Oracle license model that applies to the Exadata VM cluster on Exascale Infrastructure. The default is LICENSE_INCLUDED. ")
  @visibility("create", "read")
  licenseModel?: LicenseModel;

  @doc("The memory that you want to be allocated in GBs. Memory is calculated based on 11 GB per VM core reserved.")
  @visibility("read")
  memorySizeInGbs?: int32;

  @doc("The number of nodes in the Exadata VM cluster on Exascale Infrastructure.")
  @visibility("create", "read", "update")
  nodeCount: int32;

  @doc("CIDR blocks for additional NSG ingress rules. The VNET CIDRs used to provision the VM Cluster will be added by default.")
  @visibility("create", "read")
  @extension("x-ms-identifiers", [])
  nsgCidrs?: NsgCidr[];

  @doc("The OCID of the zone the Exadata VM cluster on Exascale Infrastructure is associated with.")
  @visibility("read")
  zoneOcid?: Ocid;

  @doc("The OCID of the zone the Exadata VM cluster on Exascale Infrastructure is associated with.")
  @visibility("create", "read")
  privateZoneOcid?: Ocid;

  @doc("The TCP Single Client Access Name (SCAN) port. The default port is 1521.")
  @visibility("create", "read")
  scanListenerPortTcp?: int32;

  @doc("The TCPS Single Client Access Name (SCAN) port. The default port is 2484.")
  @visibility("create", "read")
  scanListenerPortTcpSsl?: int32;

  @doc("The port number configured for the listener on the Exadata VM cluster on Exascale Infrastructure.")
  @visibility("read")
  listenerPort?: int32;

  @doc("The shape of the Exadata VM cluster on Exascale Infrastructure resource")
  @visibility("create", "read")
  shape: string;

  @doc("The public key portion of one or more key pairs used for SSH access to the Exadata VM cluster on Exascale Infrastructure.")
  @visibility("create", "read")
  sshPublicKeys: string[];

  @doc("Operating system version of the image.")
  @visibility("create", "read")
  @minLength(1)
  @maxLength(255)
  systemVersion?: string;

  @doc("The time zone of the Exadata VM cluster on Exascale Infrastructure. For details, see [Exadata Infrastructure Time Zones](/Content/Database/References/timezones.htm).")
  @visibility("create", "read")
  @minLength(1)
  @maxLength(255)
  timeZone?: string;

  @doc("The number of Total ECPUs for an Exadata VM cluster on Exascale Infrastructure.")
  @visibility("create", "read")
  @minValue(2)
  totalEcpuCount: int32;

  @doc("Filesystem storage details.")
  @visibility("create", "read")
  vmFileSystemStorage: ExadbVmClusterStorageDetails;

  @doc("Additional information about the current lifecycle state.")
  @visibility("read")
  lifecycleDetails?: string;

  @doc("The FQDN of the DNS record for the SCAN IP addresses that are associated with the Exadata VM cluster on Exascale Infrastructure. ")
  @visibility("read")
  @minLength(1)
  @maxLength(72)
  scanDnsName?: string;

  @doc("The Single Client Access Name (SCAN) IP addresses associated with the Exadata VM cluster on Exascale Infrastructure. SCAN IP addresses are typically used for load balancing and are not assigned to any interface. Oracle Clusterware directs the requests to the appropriate nodes in the cluster. **Note:** For a single-node DB system, this list is empty.")
  @visibility("read")
  scanIpIds?: string[];

  @doc("The OCID of the DNS record for the SCAN IP addresses that are associated with the Exadata VM cluster on Exascale Infrastructure.")
  @visibility("read")
  scanDnsRecordId?: Ocid;

  @doc("Snapshot filesystem storage details.")
  @visibility("read")
  snapshotFileSystemStorage?: ExadbVmClusterStorageDetails;

  @doc("Total file system storage details.")
  @visibility("read")
  totalFileSystemStorage?: ExadbVmClusterStorageDetails;

  @doc("The virtual IP (VIP) addresses associated with the Exadata VM cluster on Exascale Infrastructure. The Cluster Ready Services (CRS) creates and maintains one VIP address for each node in the Exadata Cloud Service instance to enable failover. If one node fails, the VIP is reassigned to another active node in the cluster. **Note:** For a single-node DB system, this list is empty.")
  @visibility("read")
  vipIds?: string[];

  @doc("HTTPS link to OCI resources exposed to Azure Customer via Azure Interface.")
  @visibility("read")
  ociUrl?: url;

  @doc("iormConfigCache details for Exadata VM cluster on Exascale Infrastructure.")
  @visibility("read")
  iormConfigCache?: ExadataIormConfig;

  @doc("Cluster backup subnet ocid")
  @visibility("read")
  backupSubnetOcid?: Ocid;

  @doc("Cluster subnet ocid")
  @visibility("read")
  subnetOcid?: Ocid;
}

@added(Versions.v20241201_preview)
@doc("Storage Details on the Exadata VM cluster.")
model ExadbVmClusterStorageDetails {
  @doc("Total Capacity")
  totalSizeInGbs: int32;
}

@added(Versions.v20241201_preview)
@doc("Details of removing Virtual Machines from the Exadata VM cluster on Exascale Infrastructure. Applies to Exadata Database Service on Exascale Infrastructure only.")
model RemoveVirtualMachineFromExadbVmClusterDetails {
  @doc("The list of ExaCS DB nodes for the Exadata VM cluster on Exascale Infrastructure to be removed.")
  @extension("x-ms-identifiers", [])
  dbNodes: Array<DbNodeDetails>;
}

@added(Versions.v20241201_preview)
@doc("Details of the ExaCS Db node. Applies to Exadata Database Service on Exascale Infrastructure only.")
model DbNodeDetails {
  @doc("Exascale DbNode Azure Resource ID")
  dbNodeId: ExascaleDbNodeResourceId;
}

@added(Versions.v20241201_preview)
@doc("Exadata VM cluster on Exascale Infrastructure lifecycle state enum")
union ExadbVmClusterLifecycleState {
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

  @doc("Indicates that resource Maintenance in progress state")
  MaintenanceInProgress: "MaintenanceInProgress",

  @doc("Indicates that resource in Failed state")
  Failed: "Failed",

  string,
}

@added(Versions.v20241201_preview)
@doc("GridImageType enum")
union GridImageType {
  @doc("Release update")
  ReleaseUpdate: "ReleaseUpdate",

  @doc("Custom image")
  CustomImage: "CustomImage",

  string,
}
