import "../common.tsp";
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Oracle.Database;

@added(Versions.v20241201_preview)
@doc("ExadbVmCluster resource definition")
model ExadbVmCluster is TrackedResource<ExadbVmClusterProperties> {
  ...ResourceNameParameter<ExadbVmCluster, NamePattern = ".*">;
  ...AvailabilityZonesProperty;
}

@added(Versions.v20241201_preview)
@doc("ExadbVmCluster resource model")
model ExadbVmClusterProperties {
  @doc("ExadbVmCluster ocid")
  @visibility(Lifecycle.Read)
  ocid?: Ocid;

  @doc("The cluster name for Exadata VM cluster on Exascale Infrastructure. The cluster name must begin with an alphabetic character, and may contain hyphens (-). Underscores (_) are not permitted. The cluster name can be no longer than 11 characters and is not case sensitive.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minLength(1)
  @maxLength(11)
  clusterName?: string;

  @doc("Client OCI backup subnet CIDR, default is 192.168.252.0/22")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minLength(1)
  @maxLength(32)
  backupSubnetCidr?: string;

  @doc("HTTPS link to OCI Network Security Group exposed to Azure Customer via the Azure Interface.")
  @visibility(Lifecycle.Read)
  nsgUrl?: url;

  @doc("Exadata VM cluster on Exascale Infrastructure provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: AzureResourceProvisioningState;

  @doc("CloudVmCluster lifecycle state")
  @visibility(Lifecycle.Read)
  lifecycleState?: ExadbVmClusterLifecycleState;

  @doc("VNET for network connectivity")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  vnetId: VnetId;

  @doc("Client subnet")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  subnetId: SubnetId;

  @doc("Indicates user preferences for the various diagnostic collection options for the VM cluster/Cloud VM cluster/VMBM DBCS.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  dataCollectionOptions?: DataCollectionOptions;

  @doc("Display Name")
  @minLength(1)
  @maxLength(255)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  displayName: string;

  @doc("A domain name used for the Exadata VM cluster on Exascale Infrastructure")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  domain?: string;

  @doc("The number of ECPUs to enable for an Exadata VM cluster on Exascale Infrastructure.")
  @minValue(0)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  enabledEcpuCount: int32;

  @doc("The Azure Resource ID of the Exadata Database Storage Vault.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  exascaleDbStorageVaultId: ExascaleDbStorageVaultResourceId;

  @doc("Grid Setup will be done using this Grid Image OCID. Can be obtained using giMinorVersions API")
  @minLength(1)
  @maxLength(255)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  gridImageOcid?: Ocid;

  @doc("The type of Grid Image")
  @visibility(Lifecycle.Read)
  gridImageType?: GridImageType;

  @doc("Oracle Grid Infrastructure (GI) software version")
  @visibility(Lifecycle.Read)
  @minLength(1)
  @maxLength(255)
  giVersion?: string;

  @doc("The hostname for the  Exadata VM cluster on Exascale Infrastructure.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minLength(1)
  @maxLength(12)
  hostname: string;

  @doc("The Oracle license model that applies to the Exadata VM cluster on Exascale Infrastructure. The default is LICENSE_INCLUDED. ")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  licenseModel?: LicenseModel;

  @doc("The memory that you want to be allocated in GBs. Memory is calculated based on 11 GB per VM core reserved.")
  @visibility(Lifecycle.Read)
  memorySizeInGbs?: int32;

  @doc("The number of nodes in the Exadata VM cluster on Exascale Infrastructure.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  nodeCount: int32;

  @doc("CIDR blocks for additional NSG ingress rules. The VNET CIDRs used to provision the VM Cluster will be added by default.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  nsgCidrs?: NsgCidr[];

  @doc("The OCID of the zone the Exadata VM cluster on Exascale Infrastructure is associated with.")
  @visibility(Lifecycle.Read)
  zoneOcid?: Ocid;

  @doc("The OCID of the zone the Exadata VM cluster on Exascale Infrastructure is associated with.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  privateZoneOcid?: Ocid;

  @doc("The TCP Single Client Access Name (SCAN) port. The default port is 1521.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  scanListenerPortTcp?: int32;

  @doc("The TCPS Single Client Access Name (SCAN) port. The default port is 2484.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  scanListenerPortTcpSsl?: int32;

  @doc("The port number configured for the listener on the Exadata VM cluster on Exascale Infrastructure.")
  @visibility(Lifecycle.Read)
  listenerPort?: int32;

  @doc("The shape of the Exadata VM cluster on Exascale Infrastructure resource")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  shape: string;

  @doc("The public key portion of one or more key pairs used for SSH access to the Exadata VM cluster on Exascale Infrastructure.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  sshPublicKeys: string[];

  @doc("Operating system version of the image.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minLength(1)
  @maxLength(255)
  systemVersion?: string;

  @doc("The time zone of the Exadata VM cluster on Exascale Infrastructure. For details, see [Exadata Infrastructure Time Zones](/Content/Database/References/timezones.htm).")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minLength(1)
  @maxLength(255)
  timeZone?: string;

  @doc("The number of Total ECPUs for an Exadata VM cluster on Exascale Infrastructure.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minValue(2)
  totalEcpuCount: int32;

  @doc("Filesystem storage details.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  vmFileSystemStorage: ExadbVmClusterStorageDetails;

  @doc("Additional information about the current lifecycle state.")
  @visibility(Lifecycle.Read)
  lifecycleDetails?: string;

  @doc("The FQDN of the DNS record for the SCAN IP addresses that are associated with the Exadata VM cluster on Exascale Infrastructure. ")
  @visibility(Lifecycle.Read)
  @minLength(1)
  @maxLength(72)
  scanDnsName?: string;

  @doc("The Single Client Access Name (SCAN) IP addresses associated with the Exadata VM cluster on Exascale Infrastructure. SCAN IP addresses are typically used for load balancing and are not assigned to any interface. Oracle Clusterware directs the requests to the appropriate nodes in the cluster. **Note:** For a single-node DB system, this list is empty.")
  @visibility(Lifecycle.Read)
  scanIpIds?: string[];

  @doc("The OCID of the DNS record for the SCAN IP addresses that are associated with the Exadata VM cluster on Exascale Infrastructure.")
  @visibility(Lifecycle.Read)
  scanDnsRecordId?: Ocid;

  @doc("Snapshot filesystem storage details.")
  @visibility(Lifecycle.Read)
  snapshotFileSystemStorage?: ExadbVmClusterStorageDetails;

  @doc("Total file system storage details.")
  @visibility(Lifecycle.Read)
  totalFileSystemStorage?: ExadbVmClusterStorageDetails;

  @doc("The virtual IP (VIP) addresses associated with the Exadata VM cluster on Exascale Infrastructure. The Cluster Ready Services (CRS) creates and maintains one VIP address for each node in the Exadata Cloud Service instance to enable failover. If one node fails, the VIP is reassigned to another active node in the cluster. **Note:** For a single-node DB system, this list is empty.")
  @visibility(Lifecycle.Read)
  vipIds?: string[];

  @doc("HTTPS link to OCI resources exposed to Azure Customer via Azure Interface.")
  @visibility(Lifecycle.Read)
  ociUrl?: url;

  @doc("iormConfigCache details for Exadata VM cluster on Exascale Infrastructure.")
  @visibility(Lifecycle.Read)
  iormConfigCache?: ExadataIormConfig;

  @doc("Cluster backup subnet ocid")
  @visibility(Lifecycle.Read)
  backupSubnetOcid?: Ocid;

  @doc("Cluster subnet ocid")
  @visibility(Lifecycle.Read)
  subnetOcid?: Ocid;

  @added(Versions.v20250801_preview)
  @doc("The type of Exascale storage used for Exadata VM cluster.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  shapeAttribute?: ShapeAttribute;
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
  @Azure.ResourceManager.identifiers(#[])
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
