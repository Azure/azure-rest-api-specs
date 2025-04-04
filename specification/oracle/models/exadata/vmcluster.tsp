import "../common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Oracle.Database;

scalar CloudExadataInfrastructureId
  extends armResourceIdentifier<[
    {
      type: "Oracle.Database/cloudExadataInfrastructures",
    }
  ]>;

@doc("DataCollectionOptions resource properties")
model DataCollectionOptions {
  @doc("Indicates whether diagnostic collection is enabled for the VM cluster/Cloud VM cluster/VMBM DBCS.")
  isDiagnosticsEventsEnabled?: boolean = false;

  @doc("Indicates whether health monitoring is enabled for the VM cluster / Cloud VM cluster / VMBM DBCS.")
  isHealthMonitoringEnabled?: boolean = false;

  @doc("Indicates whether incident logs and trace collection are enabled for the VM cluster / Cloud VM cluster / VMBM DBCS.")
  isIncidentLogsEnabled?: boolean = false;
}

@doc("Update action enum")
union UpdateAction {
  @doc("Rolling apply action")
  RollingApply: "RollingApply",

  @doc("Non rolling apply action")
  NonRollingApply: "NonRollingApply",

  @doc("Pre-check action")
  PreCheck: "PreCheck",

  @doc("Rollback action")
  RollBack: "RollBack",

  string,
}

@doc("ExadataIormConfig for cloud vm cluster")
model ExadataIormConfig {
  @doc("An array of IORM settings for all the database in the Exadata DB system.")
  @extension("x-ms-identifiers", #[])
  dbPlans?: DbIormConfig[];

  @doc("Additional information about the current lifecycleState.")
  lifecycleDetails?: string;

  @doc("The current state of IORM configuration for the Exadata DB system.")
  lifecycleState?: IormLifecycleState;

  @doc("The current value for the IORM objective. The default is AUTO.")
  objective?: Objective;
}

@doc("DbIormConfig for cloud vm cluster")
model DbIormConfig {
  @doc("The database name. For the default DbPlan, the dbName is default.")
  dbName?: string;

  @doc("The flash cache limit for this database. This value is internally configured based on the share value assigned to the database.")
  flashCacheLimit?: string;

  @doc("The relative priority of this database.")
  @minValue(1)
  @maxValue(32)
  share?: int32;
}

@doc("Objective enum")
union Objective {
  @doc("Low latency objective")
  LowLatency: "LowLatency",

  @doc("High throughput objective")
  HighThroughput: "HighThroughput",

  @doc("Balanced objective")
  Balanced: "Balanced",

  @doc("Auto objective")
  Auto: "Auto",

  @doc("Basic objective")
  Basic: "Basic",

  string,
}

@doc("ORM lifecycle state enum")
union IormLifecycleState {
  @doc("Indicates that resource in Provisioning state")
  BootStrapping: "BootStrapping",

  @doc("Indicates that resource in Enabled state")
  Enabled: "Enabled",

  @doc("Indicates that resource in Disabled state")
  Disabled: "Disabled",

  @doc("Indicates that resource in Updating state")
  Updating: "Updating",

  @doc("Indicates that resource in Failed state")
  Failed: "Failed",

  string,
}

@doc("Disk redundancy enum")
union DiskRedundancy {
  @doc("High redundancy")
  High: "High",

  @doc("Normal redundancy")
  Normal: "Normal",

  string,
}

@doc("Cloud VM Cluster lifecycle state enum")
union CloudVmClusterLifecycleState {
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

@doc("CloudVmCluster resource definition")
model CloudVmCluster is TrackedResource<CloudVmClusterProperties> {
  @doc("CloudVmCluster name")
  @key("cloudvmclustername")
  @path
  @segment("cloudVmClusters")
  @pattern(".*")
  name: string;
}

@doc("Port Range to specify particular destination ports for TCP rules.")
model PortRange {
  @doc("The minimum port number, which must not be greater than the maximum port number.")
  @minValue(1)
  @maxValue(65535)
  min: int32;

  @doc("The maximum port number, which must not be less than the minimum port number. To specify a single port number, set both the min and max to the same value.")
  @minValue(1)
  @maxValue(65535)
  max: int32;
}

@doc("A rule for allowing inbound (INGRESS) IP packets")
model NsgCidr {
  @doc("Conceptually, this is the range of IP addresses that a packet coming into the instance can come from.")
  @minLength(1)
  @maxLength(128)
  source: string;

  @doc("Destination port range to specify particular destination ports for TCP rules.")
  destinationPortRange?: PortRange;
}

@doc("CloudVmCluster resource model")
model CloudVmClusterProperties {
  @doc("Cloud VM Cluster ocid")
  @visibility(Lifecycle.Read)
  ocid?: Ocid;

  @doc("The port number configured for the listener on the cloud VM cluster.")
  @visibility(Lifecycle.Read)
  listenerPort?: int64;

  @doc("The number of nodes in the cloud VM cluster. ")
  @visibility(Lifecycle.Read)
  nodeCount?: int32;

  @doc("The data disk group size to be allocated in GBs per VM.")
  @visibility(Lifecycle.Read, Lifecycle.Update)
  storageSizeInGbs?: int32;

  @doc("The data disk group size to be allocated in TBs.")
  dataStorageSizeInTbs?: float64;

  @doc("The local node storage to be allocated in GBs.")
  dbNodeStorageSizeInGbs?: int32;

  @doc("The memory to be allocated in GBs.")
  memorySizeInGbs?: int32;

  @doc("The date and time that the cloud VM cluster was created.")
  @visibility(Lifecycle.Read)
  timeCreated?: utcDateTime;

  @doc("Additional information about the current lifecycle state.")
  @visibility(Lifecycle.Read)
  lifecycleDetails?: string;

  @doc("The time zone of the cloud VM cluster. For details, see [Exadata Infrastructure Time Zones](/Content/Database/References/timezones.htm).")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minLength(1)
  @maxLength(255)
  timeZone?: string;

  @doc("The OCID of the zone the cloud VM cluster is associated with.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  zoneId?: Ocid;

  @doc("The hostname for the cloud VM cluster.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minLength(1)
  @maxLength(23)
  hostname: string;

  @doc("The domain name for the cloud VM cluster.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  domain?: string;

  @doc("The number of CPU cores enabled on the cloud VM cluster.")
  cpuCoreCount: int32;

  @doc("The number of OCPU cores to enable on the cloud VM cluster. Only 1 decimal place is allowed for the fractional part.")
  ocpuCount?: float32;

  @doc("The cluster name for cloud VM cluster. The cluster name must begin with an alphabetic character, and may contain hyphens (-). Underscores (_) are not permitted. The cluster name can be no longer than 11 characters and is not case sensitive. ")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minLength(1)
  @maxLength(11)
  clusterName?: string;

  @doc("The percentage assigned to DATA storage (user data and database files). The remaining percentage is assigned to RECO storage (database redo logs, archive logs, and recovery manager backups). Accepted values are 35, 40, 60 and 80. The default is 80 percent assigned to DATA storage. See [Storage Configuration](/Content/Database/Concepts/exaoverview.htm#Exadata) in the Exadata documentation for details on the impact of the configuration settings on storage. ")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  dataStoragePercentage?: int32;

  @doc("If true, database backup on local Exadata storage is configured for the cloud VM cluster. If false, database backup on local Exadata storage is not available in the cloud VM cluster. ")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  isLocalBackupEnabled?: boolean = false;

  @doc("Cloud Exadata Infrastructure ID")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  cloudExadataInfrastructureId: CloudExadataInfrastructureId;

  @doc("If true, sparse disk group is configured for the cloud VM cluster. If false, sparse disk group is not created. ")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  isSparseDiskgroupEnabled?: boolean = false;

  @doc("Operating system version of the image.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minLength(1)
  @maxLength(255)
  systemVersion?: string;

  @doc("The public key portion of one or more key pairs used for SSH access to the cloud VM cluster.")
  sshPublicKeys: string[];

  @doc("The Oracle license model that applies to the cloud VM cluster. The default is LICENSE_INCLUDED. ")
  licenseModel?: LicenseModel;

  @doc("The type of redundancy configured for the cloud Vm cluster. NORMAL is 2-way redundancy. HIGH is 3-way redundancy. ")
  @visibility(Lifecycle.Read)
  diskRedundancy?: DiskRedundancy;

  @doc("The Single Client Access Name (SCAN) IP addresses associated with the cloud VM cluster. SCAN IP addresses are typically used for load balancing and are not assigned to any interface. Oracle Clusterware directs the requests to the appropriate nodes in the cluster. **Note:** For a single-node DB system, this list is empty.")
  @visibility(Lifecycle.Read)
  scanIpIds?: string[];

  @doc("The virtual IP (VIP) addresses associated with the cloud VM cluster. The Cluster Ready Services (CRS) creates and maintains one VIP address for each node in the Exadata Cloud Service instance to enable failover. If one node fails, the VIP is reassigned to another active node in the cluster. **Note:** For a single-node DB system, this list is empty.")
  @visibility(Lifecycle.Read)
  vipIds?: string[];

  @doc("The FQDN of the DNS record for the SCAN IP addresses that are associated with the cloud VM cluster. ")
  @visibility(Lifecycle.Read)
  @minLength(1)
  @maxLength(72)
  scanDnsName?: string;

  @doc("The TCP Single Client Access Name (SCAN) port. The default port is 1521.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  scanListenerPortTcp?: int32;

  @doc("The TCPS Single Client Access Name (SCAN) port. The default port is 2484.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  scanListenerPortTcpSsl?: int32;

  @doc("The OCID of the DNS record for the SCAN IP addresses that are associated with the cloud VM cluster.")
  @visibility(Lifecycle.Read)
  scanDnsRecordId?: Ocid;

  @doc("The model name of the Exadata hardware running the cloud VM cluster.")
  @visibility(Lifecycle.Read)
  @minLength(1)
  @maxLength(255)
  shape?: string;

  @doc("CloudVmCluster provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: AzureResourceProvisioningState;

  @doc("CloudVmCluster lifecycle state")
  @visibility(Lifecycle.Read)
  lifecycleState?: CloudVmClusterLifecycleState;

  @doc("VNET for network connectivity")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  vnetId: VnetId;

  @doc("Oracle Grid Infrastructure (GI) software version")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  giVersion: string;

  @doc("HTTPS link to OCI resources exposed to Azure Customer via Azure Interface.")
  @visibility(Lifecycle.Read)
  ociUrl?: url;

  @doc("HTTPS link to OCI Network Security Group exposed to Azure Customer via the Azure Interface.")
  @visibility(Lifecycle.Read)
  nsgUrl?: url;

  @doc("Client subnet")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  subnetId: SubnetId;

  @doc("Client OCI backup subnet CIDR, default is 192.168.252.0/22")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minLength(1)
  @maxLength(32)
  backupSubnetCidr?: string;

  @doc("CIDR blocks for additional NSG ingress rules. The VNET CIDRs used to provision the VM Cluster will be added by default.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  nsgCidrs?: NsgCidr[];

  @doc("Indicates user preferences for the various diagnostic collection options for the VM cluster/Cloud VM cluster/VMBM DBCS.")
  dataCollectionOptions?: DataCollectionOptions;

  @doc("Display Name")
  @minLength(1)
  @maxLength(255)
  displayName: string;

  @doc("The list of compute servers to be added to the cloud VM cluster.")
  @visibility(Lifecycle.Update)
  computeNodes?: Ocid[];

  @doc("iormConfigCache details for cloud VM cluster.")
  @visibility(Lifecycle.Read)
  iormConfigCache?: ExadataIormConfig;

  @doc("The OCID of the last maintenance update history entry.")
  @visibility(Lifecycle.Read)
  lastUpdateHistoryEntryId?: Ocid;

  @doc("The list of DB servers.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  dbServers?: Ocid[];

  @doc("Cluster compartmentId")
  @visibility(Lifecycle.Read)
  compartmentId?: Ocid;

  @doc("Cluster subnet ocid")
  @visibility(Lifecycle.Read)
  subnetOcid?: Ocid;
}

@doc("Add/Remove (Virtual Machine) DbNode model")
model AddRemoveDbNode {
  @doc("Db servers ocids")
  dbServers: Array<Ocid>;
}
