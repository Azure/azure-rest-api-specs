import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.NetworkCloud;

interface Operations extends Azure.ResourceManager.Operations {}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

enum BareMetalMachineCordonStatus {
  Cordoned,
  Uncordoned,
}

enum BareMetalMachineDetailedStatus {
  Preparing,
  Error,
  Available,
  Provisioning,
  Provisioned,
  Deprovisioning,
}

enum BareMetalMachineHardwareValidationResult {
  Pass,
  Fail,
}

enum BareMetalMachinePowerState {
  On,
  Off,
}

enum BareMetalMachineProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Provisioning,
  Accepted,
}

enum BareMetalMachineReadyState {
  True,
  False,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum CloudServicesNetworkDetailedStatus {
  Error,
  Available,
  Provisioning,
}

enum CloudServicesNetworkEnableDefaultEgressEndpoints {
  True,
  False,
}

enum CloudServicesNetworkProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Provisioning,
  Accepted,
}

enum ClusterManagerDetailedStatus {
  Error,
  Available,
  Provisioning,
  ProvisioningFailed,
  Updating,
  UpdateFailed,
}

enum ClusterManagerProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Provisioning,
  Accepted,
  Updating,
}

enum ControlImpact {
  True,
  False,
}

enum WorkloadImpact {
  True,
  False,
}

enum ClusterConnectionStatus {
  Connected,
  Timeout,
  Undefined,
}

enum ClusterManagerConnectionStatus {
  Connected,
  Unreachable,
}

enum ClusterType {
  SingleRack,
  MultiRack,
}

enum ValidationThresholdGrouping {
  PerCluster,
  PerRack,
}

enum ValidationThresholdType {
  CountSuccess,
  PercentSuccess,
}

enum ClusterDetailedStatus {
  PendingDeployment,
  Deploying,
  Running,
  Updating,
  Degraded,
  Deleting,
  Disconnected,
  Failed,
}

enum ClusterProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Accepted,
  Validating,
  Updating,
}

enum AvailabilityLifecycle {
  Preview,
  GenerallyAvailable,
}

enum KubernetesClusterDetailedStatus {
  Available,
  Error,
  Provisioning,
}

enum FeatureDetailedStatus {
  Running,
  Failed,
  Unknown,
}

enum HugepagesSize {
  `2M`,
  `1G`,
}

enum KubernetesPluginType {
  DPDK,
  SRIOV,
  OSDevice,
  MACVLAN,
  IPVLAN,
}

enum L3NetworkConfigurationIpamEnabled {
  True,
  False,
}

enum AgentPoolMode {
  System,
  User,
  NotApplicable,
}

enum AdvertiseToFabric {
  True,
  False,
}

enum BfdEnabled {
  True,
  False,
}

enum BgpMultiHop {
  True,
  False,
}

enum FabricPeeringEnabled {
  True,
  False,
}

enum KubernetesClusterNodeDetailedStatus {
  Available,
  Error,
  Provisioning,
  Running,
  Scheduling,
  Stopped,
  Terminating,
  Unknown,
}

enum DefaultGateway {
  True,
  False,
}

enum VirtualMachineIPAllocationMethod {
  Dynamic,
  Static,
  Disabled,
}

enum KubernetesNodePowerState {
  On,
  Off,
  Unknown,
}

enum KubernetesNodeRole {
  ControlPlane,
  Worker,
}

enum KubernetesClusterProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Accepted,
  InProgress,
  Created,
  Updating,
  Deleting,
}

enum L2NetworkDetailedStatus {
  Error,
  Available,
  Provisioning,
}

enum HybridAksPluginType {
  DPDK,
  SRIOV,
  OSDevice,
}

enum L2NetworkProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Provisioning,
  Accepted,
}

enum L3NetworkDetailedStatus {
  Error,
  Available,
  Provisioning,
}

enum HybridAksIpamEnabled {
  True,
  False,
}

enum IpAllocationType {
  IPV4,
  IPV6,
  DualStack,
}

enum L3NetworkProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Provisioning,
  Accepted,
}

enum BootstrapProtocol {
  PXE,
}

enum MachineSkuDiskConnectionType {
  PCIE,
  SATA,
  RAID,
  SAS,
}

enum DiskType {
  HDD,
  SSD,
}

enum DeviceConnectionType {
  PCI,
}

enum RackSkuProvisioningState {
  Succeeded,
}

enum RackSkuType {
  Aggregator,
  Compute,
  Single,
}

enum RackDetailedStatus {
  Error,
  Available,
  Provisioning,
}

enum RackProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Provisioning,
  Accepted,
}

enum StorageApplianceDetailedStatus {
  Error,
  Available,
  Provisioning,
}

enum StorageApplianceProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Provisioning,
  Accepted,
}

enum RemoteVendorManagementFeature {
  Supported,
  Unsupported,
}

enum RemoteVendorManagementStatus {
  Enabled,
  Disabled,
  Unsupported,
}

enum TrunkedNetworkDetailedStatus {
  Error,
  Available,
  Provisioning,
}

enum TrunkedNetworkProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Provisioning,
  Accepted,
}

enum VirtualMachineBootMethod {
  UEFI,
  BIOS,
}

enum VirtualMachineDetailedStatus {
  Available,
  Error,
  Provisioning,
  Running,
  Scheduling,
  Stopped,
  Terminating,
  Unknown,
}

enum VirtualMachineIsolateEmulatorThread {
  True,
  False,
}

enum VirtualMachinePlacementHintType {
  Affinity,
  AntiAffinity,
}

enum VirtualMachineSchedulingExecution {
  Hard,
  Soft,
}

enum VirtualMachinePlacementHintPodAffinityScope {
  Rack,
  Machine,
}

enum VirtualMachinePowerState {
  On,
  Off,
  Unknown,
}

enum VirtualMachineProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Provisioning,
  Accepted,
}

enum OsDiskCreateOption {
  Ephemeral,
}

enum OsDiskDeleteOption {
  Delete,
}

enum VirtualMachineVirtioInterfaceType {
  Modern,
  Transitional,
}

enum VirtualMachineDeviceModelType {
  T1,
  T2,
}

enum VolumeDetailedStatus {
  Error,
  Active,
  Provisioning,
}

enum VolumeProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Provisioning,
  Accepted,
}

enum BareMetalMachineEvacuate {
  True,
  False,
}

enum BareMetalMachineSkipShutdown {
  True,
  False,
}

enum BareMetalMachineKeySetDetailedStatus {
  AllActive,
  SomeInvalid,
  AllInvalid,
  Validating,
}

enum BareMetalMachineKeySetPrivilegeLevel {
  Standard,
  Superuser,
}

enum BareMetalMachineKeySetProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Accepted,
  Provisioning,
}

enum BareMetalMachineKeySetUserSetupStatus {
  Active,
  Invalid,
}

enum BmcKeySetDetailedStatus {
  AllActive,
  SomeInvalid,
  AllInvalid,
  Validating,
}

enum BmcKeySetPrivilegeLevel {
  ReadOnly,
  Administrator,
}

enum BmcKeySetProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Accepted,
  Provisioning,
}

enum ClusterMetricsConfigurationDetailedStatus {
  Processing,
  Applied,
  Error,
}

enum ClusterMetricsConfigurationProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Accepted,
  Provisioning,
}

enum AgentPoolDetailedStatus {
  Available,
  Error,
  Provisioning,
}

enum AgentPoolProvisioningState {
  Accepted,
  Canceled,
  Deleting,
  Failed,
  InProgress,
  Succeeded,
  Updating,
}

enum ConsoleDetailedStatus {
  Ready,
  Error,
}

enum ConsoleEnabled {
  True,
  False,
}

enum ConsoleProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Provisioning,
  Accepted,
}

enum SkipShutdown {
  True,
  False,
}

@doc("ExtendedLocation represents the Azure custom location where the resource will be created.")
model ExtendedLocation {
  @doc("The resource ID of the extended location on which the resource will be created.")
  @visibility("read", "create")
  name: string;

  @doc("The extended location type, for example, CustomLocation.")
  @visibility("read", "create")
  type: string;
}

@doc("BareMetalMachineProperties represents the properties of a bare metal machine.")
model BareMetalMachineProperties {
  @doc("The list of resource IDs for the other Microsoft.NetworkCloud resources that have attached this network.")
  @visibility("read")
  associatedResourceIds?: string[];

  @doc("The connection string for the baseboard management controller including IP address and protocol.")
  bmcConnectionString: string;

  @doc("The credentials of the baseboard management controller on this bare metal machine.")
  bmcCredentials: AdministrativeCredentials;

  @doc("The MAC address of the BMC device.")
  @pattern("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$")
  bmcMacAddress: string;

  @doc("The MAC address of a NIC connected to the PXE network.")
  @pattern("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$")
  bootMacAddress: string;

  @doc("The resource ID of the cluster this bare metal machine is associated with.")
  @visibility("read")
  clusterId?: string;

  @doc("The cordon status of the bare metal machine.")
  @visibility("read")
  cordonStatus?: BareMetalMachineCordonStatus;

  @doc("The more detailed status of the bare metal machine.")
  @visibility("read")
  detailedStatus?: BareMetalMachineDetailedStatus;

  @doc("The descriptive message about the current detailed status.")
  @visibility("read")
  detailedStatusMessage?: string;

  @doc("The hardware inventory, including information acquired from the model/sku information and from the ironic inspector.")
  @visibility("read")
  hardwareInventory?: HardwareInventory;

  @doc("The details of the latest hardware validation performed for this bare metal machine.")
  @visibility("read")
  hardwareValidationStatus?: HardwareValidationStatus;

  @doc("Field Deprecated. These fields will be empty/omitted. The list of the resource IDs for the HybridAksClusters that have nodes hosted on this bare metal machine.")
  @visibility("read")
  hybridAksClustersAssociatedIds?: string[];

  @doc("The name of this machine represented by the host object in the Cluster's Kubernetes control plane.")
  @visibility("read")
  kubernetesNodeName?: string;

  @doc("The version of Kubernetes running on this machine.")
  @visibility("read")
  kubernetesVersion?: string;

  @doc("The custom details provided by the customer.")
  @maxLength(256)
  machineDetails: string;

  @doc("The OS-level hostname assigned to this machine.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9]{0,62}[a-zA-Z0-9])$")
  machineName: string;

  @doc("The unique internal identifier of the bare metal machine SKU.")
  machineSkuId: string;

  @doc("The IPv4 address that is assigned to the bare metal machine during the cluster deployment.")
  @visibility("read")
  oamIpv4Address?: string;

  @doc("The IPv6 address that is assigned to the bare metal machine during the cluster deployment.")
  @visibility("read")
  oamIpv6Address?: string;

  @doc("The image that is currently provisioned to the OS disk.")
  @visibility("read")
  osImage?: string;

  @doc("The power state derived from the baseboard management controller.")
  @visibility("read")
  powerState?: BareMetalMachinePowerState;

  @doc("The provisioning state of the bare metal machine.")
  @visibility("read")
  provisioningState?: BareMetalMachineProvisioningState;

  @doc("The resource ID of the rack where this bare metal machine resides.")
  rackId: string;

  @doc("The rack slot in which this bare metal machine is located, ordered from the bottom up i.e. the lowest slot is 1.")
  rackSlot: int32;

  @doc("The indicator of whether the bare metal machine is ready to receive workloads.")
  @visibility("read")
  readyState?: BareMetalMachineReadyState;

  @doc("The serial number of the bare metal machine.")
  @maxLength(64)
  @minLength(1)
  serialNumber: string;

  @doc("The discovered value of the machine's service tag.")
  @visibility("read")
  serviceTag?: string;

  @doc("Field Deprecated. These fields will be empty/omitted. The list of the resource IDs for the VirtualMachines that are hosted on this bare metal machine.")
  @visibility("read")
  virtualMachinesAssociatedIds?: string[];
}

@doc("AdministrativeCredentials represents the admin credentials for the device requiring password-based authentication.")
model AdministrativeCredentials {
  @doc("The password of the administrator of the device used during initialization.")
  @minLength(1)
  password?: string;

  @doc("The username of the administrator of the device used during initialization.")
  @minLength(1)
  username: string;
}

@doc("HardwareInventory represents the hardware configuration of this machine as exposed to the customer, including information acquired from the model/sku information and from the ironic inspector.")
model HardwareInventory {
  @doc("Freeform data extracted from the environment about this machine. This information varies depending on the specific hardware and configuration.")
  @visibility("read")
  additionalHostInformation?: string;

  @doc("The list of network interfaces and associated details for the bare metal machine.")
  @visibility("read")
  interfaces?: HardwareInventoryNetworkInterface[];

  @doc("Field Deprecated. Will be removed in an upcoming version. The list of network interface cards and associated details for the bare metal machine.")
  @visibility("read")
  nics?: Nic[];
}

@doc("HardwareInventoryNetworkInterface represents the network interface details as part of a hardware inventory.")
model HardwareInventoryNetworkInterface {
  @doc("The current status of the link.")
  @visibility("read")
  linkStatus?: string;

  @doc("The MAC address associated with this interface.")
  @visibility("read")
  macAddress?: string;

  @doc("The name of the interface.")
  @visibility("read")
  name?: string;

  @doc("The resource ID of the network interface for the port on the switch that this machine's interface is connected to.")
  @visibility("read")
  networkInterfaceId?: string;
}

@doc("Type Deprecated. Will be removed in an upcoming version. Nic represents the network interface card details.")
model Nic {
  @doc("The information about the device connected to this NIC.")
  @visibility("read")
  lldpNeighbor?: LldpNeighbor;

  @doc("The MAC address associated with this NIC.")
  @visibility("read")
  macAddress?: string;

  @doc("The name of the NIC/interface.")
  @visibility("read")
  name?: string;
}

@doc("Type Deprecated. Will be removed in an upcoming version. LldpNeighbor represents the details about the device connected to the NIC.")
model LldpNeighbor {
  @doc("The descriptive information about the port on the connected device.")
  @visibility("read")
  portDescription?: string;

  @doc("The system-assigned name of the port on the connected device.")
  @visibility("read")
  portName?: string;

  @doc("The descriptive information about the connected device.")
  @visibility("read")
  systemDescription?: string;

  @doc("The system-assigned name of the connected device.")
  @visibility("read")
  systemName?: string;
}

@doc("HardwareValidationStatus represents the latest hardware validation details performed for this bare metal machine.")
model HardwareValidationStatus {
  @doc("The timestamp of the hardware validation execution.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastValidationTime?: utcDateTime;

  @doc("The outcome of the hardware validation.")
  @visibility("read")
  result?: BareMetalMachineHardwareValidationResult;
}

@doc("CloudServicesNetworkProperties represents properties of the cloud services network.")
model CloudServicesNetworkProperties {
  @doc("The list of egress endpoints. This allows for connection from a Hybrid AKS cluster to the specified endpoint.")
  additionalEgressEndpoints?: EgressEndpoint[];

  @doc("The list of resource IDs for the other Microsoft.NetworkCloud resources that have attached this network.")
  @visibility("read")
  associatedResourceIds?: string[];

  @doc("The resource ID of the Network Cloud cluster this cloud services network is associated with.")
  @visibility("read")
  clusterId?: string;

  @doc("The more detailed status of the cloud services network.")
  @visibility("read")
  detailedStatus?: CloudServicesNetworkDetailedStatus;

  @doc("The descriptive message about the current detailed status.")
  @visibility("read")
  detailedStatusMessage?: string;

  @doc("The indicator of whether the platform default endpoints are allowed for the egress traffic.")
  enableDefaultEgressEndpoints?: CloudServicesNetworkEnableDefaultEgressEndpoints;

  @doc("The full list of additional and default egress endpoints that are currently enabled.")
  @visibility("read")
  enabledEgressEndpoints?: EgressEndpoint[];

  @doc("Field Deprecated. These fields will be empty/omitted. The list of Hybrid AKS cluster resource IDs that are associated with this cloud services network.")
  @visibility("read")
  hybridAksClustersAssociatedIds?: string[];

  @doc("The name of the interface that will be present in the virtual machine to represent this network.")
  @visibility("read")
  interfaceName?: string;

  @doc("The provisioning state of the cloud services network.")
  @visibility("read")
  provisioningState?: CloudServicesNetworkProvisioningState;

  @doc("Field Deprecated. These fields will be empty/omitted. The list of virtual machine resource IDs, excluding any Hybrid AKS virtual machines, that are currently using this cloud services network.")
  @visibility("read")
  virtualMachinesAssociatedIds?: string[];
}

@doc("EgressEndpoint represents the connection from a cloud services network to the specified endpoint for a common purpose.")
model EgressEndpoint {
  @doc("The descriptive category name of endpoints accessible by the AKS agent node. For example, azure-resource-management, API server, etc. The platform egress endpoints provided by default will use the category 'default'.")
  category: string;

  @doc("The list of endpoint dependencies.")
  endpoints: EndpointDependency[];
}

@doc("EndpointDependency represents the definition of an endpoint, including the domain and details.")
model EndpointDependency {
  @doc("The domain name of the dependency.")
  domainName: string;

  @doc("The port of this endpoint.")
  port?: int32;
}

@doc("ClusterManagerProperties represents the properties of a cluster manager.")
model ClusterManagerProperties {
  @doc("The resource ID of the Log Analytics workspace that is used for the logs collection.")
  @visibility("read", "create")
  analyticsWorkspaceId?: string;

  @doc("Field deprecated, this value will no longer influence the cluster manager allocation process and will be removed in a future version. The Azure availability zones within the region that will be used to support the cluster manager resource.")
  @visibility("read", "create")
  availabilityZones?: string[];

  @doc("The list of the cluster versions the manager supports. It is used as input in clusterVersion property of a cluster resource.")
  @visibility("read")
  clusterVersions?: ClusterAvailableVersion[];

  @doc("The detailed status that provides additional information about the cluster manager.")
  @visibility("read")
  detailedStatus?: ClusterManagerDetailedStatus;

  @doc("The descriptive message about the current detailed status.")
  @visibility("read")
  detailedStatusMessage?: string;

  @doc("The resource ID of the fabric controller that has one to one mapping with the cluster manager.")
  @visibility("read", "create")
  fabricControllerId: string;

  @doc("The configuration of the managed resource group associated with the resource.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  @doc("The extended location (custom location) that represents the cluster manager's control plane location. This extended location is used when creating cluster and rack manifest resources.")
  @visibility("read")
  managerExtendedLocation?: ExtendedLocation;

  @doc("The provisioning state of the cluster manager.")
  @visibility("read")
  provisioningState?: ClusterManagerProvisioningState;

  @doc("Field deprecated, this value will no longer influence the cluster manager allocation process and will be removed in a future version. The size of the Azure virtual machines to use for hosting the cluster manager resource.")
  @visibility("read", "create")
  vmSize?: string;
}

@doc("ClusterAvailableVersion represents the cluster version that the cluster manager can be asked to create and manage.")
model ClusterAvailableVersion {
  @doc("The last date the version of the platform is supported.")
  @visibility("read")
  supportExpiryDate?: string;

  @doc("The version of the cluster to be deployed.")
  @visibility("read")
  targetClusterVersion?: string;
}

@doc("ManagedResourceGroupConfiguration represents the configuration of the resource group managed by Azure.")
model ManagedResourceGroupConfiguration {
  @doc("The location of the managed resource group. If not specified, the location of the parent resource is chosen.")
  @visibility("read", "create")
  location?: string;

  @doc("The name for the managed resource group. If not specified, the unique name is automatically generated.")
  @visibility("read", "create")
  @maxLength(75)
  name?: string;
}

@doc("ClusterProperties represents the properties of a cluster.")
model ClusterProperties {
  @doc("The rack definition that is intended to reflect only a single rack in a single rack cluster, or an aggregator rack in a multi-rack cluster.")
  aggregatorOrSingleRackDefinition: RackDefinition;

  @doc("The resource ID of the Log Analytics Workspace that will be used for storing relevant logs.")
  @visibility("read", "create")
  analyticsWorkspaceId?: string;

  @doc("The list of cluster runtime version upgrades available for this cluster.")
  @visibility("read")
  availableUpgradeVersions?: ClusterAvailableUpgradeVersion[];

  @doc("The capacity supported by this cluster.")
  @visibility("read")
  clusterCapacity?: ClusterCapacity;

  @doc("The latest heartbeat status between the cluster manager and the cluster.")
  @visibility("read")
  clusterConnectionStatus?: ClusterConnectionStatus;

  @doc("The extended location (custom location) that represents the cluster's control plane location. This extended location is used to route the requests of child objects of the cluster that are handled by the platform operator.")
  @visibility("read")
  clusterExtendedLocation?: ExtendedLocation;

  @doc("The customer-provided location information to identify where the cluster resides.")
  @maxLength(256)
  clusterLocation?: string;

  @doc("The latest connectivity status between cluster manager and the cluster.")
  @visibility("read")
  clusterManagerConnectionStatus?: ClusterManagerConnectionStatus;

  @doc("The resource ID of the cluster manager that manages this cluster. This is set by the Cluster Manager when the cluster is created.")
  @visibility("read")
  clusterManagerId?: string;

  @doc("The service principal to be used by the cluster during Arc Appliance installation.")
  clusterServicePrincipal?: ServicePrincipalInformation;

  @doc("The type of rack configuration for the cluster.")
  @visibility("read", "create")
  clusterType: ClusterType;

  @doc("The current runtime version of the cluster.")
  @visibility("read", "create")
  clusterVersion: string;

  @doc("The validation threshold indicating the allowable failures of compute machines during environment validation and deployment.")
  computeDeploymentThreshold?: ValidationThreshold;

  @doc("""
The list of rack definitions for the compute racks in a multi-rack
cluster, or an empty list in a single-rack cluster.
""")
  computeRackDefinitions?: RackDefinition[];

  @doc("The current detailed status of the cluster.")
  @visibility("read")
  detailedStatus?: ClusterDetailedStatus;

  @doc("The descriptive message about the detailed status.")
  @visibility("read")
  detailedStatusMessage?: string;

  @doc("Field Deprecated. This field will not be populated in an upcoming version. The extended location (custom location) that represents the Hybrid AKS control plane location. This extended location is used when creating provisioned clusters (Hybrid AKS clusters).")
  @visibility("read")
  hybridAksExtendedLocation?: ExtendedLocation;

  @doc("The configuration of the managed resource group associated with the resource.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  @doc("The count of Manual Action Taken (MAT) events that have not been validated.")
  @visibility("read")
  manualActionCount?: int32;

  @doc("The resource ID of the Network Fabric associated with the cluster.")
  @visibility("read", "create")
  networkFabricId: string;

  @doc("The provisioning state of the cluster.")
  @visibility("read")
  provisioningState?: ClusterProvisioningState;

  @doc("The support end date of the runtime version of the cluster.")
  @visibility("read")
  supportExpiryDate?: string;

  @doc("The list of workload resource IDs that are hosted within this cluster.")
  @visibility("read")
  workloadResourceIds?: string[];
}

@doc("RackDefinition represents details regarding the rack.")
model RackDefinition {
  @doc("The zone name used for this rack when created. Availability zones are used for workload placement.")
  @pattern("^[a-zA-Z0-9]{1,10}$")
  availabilityZone?: string;

  @doc("The unordered list of bare metal machine configuration.")
  bareMetalMachineConfigurationData?: BareMetalMachineConfigurationData[];

  @doc("The resource ID of the network rack that matches this rack definition.")
  networkRackId: string;

  @doc("The free-form description of the rack's location.")
  @maxLength(256)
  rackLocation?: string;

  @doc("The unique identifier for the rack within Network Cloud cluster. An alternate unique alphanumeric value other than a serial number may be provided if desired.")
  @maxLength(64)
  @minLength(1)
  rackSerialNumber: string;

  @doc("The resource ID of the sku for the rack being added.")
  rackSkuId: string;

  @doc("The list of storage appliance configuration data for this rack.")
  storageApplianceConfigurationData?: StorageApplianceConfigurationData[];
}

@doc("BareMetalMachineConfigurationData represents configuration for the bare metal machine.")
model BareMetalMachineConfigurationData {
  @doc("The connection string for the baseboard management controller including IP address and protocol.")
  @visibility("read")
  bmcConnectionString?: string;

  @doc("The credentials of the baseboard management controller on this bare metal machine.")
  bmcCredentials: AdministrativeCredentials;

  @doc("The MAC address of the BMC for this machine.")
  @pattern("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$")
  bmcMacAddress: string;

  @doc("The MAC address associated with the PXE NIC card.")
  @pattern("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$")
  bootMacAddress: string;

  @doc("The free-form additional information about the machine, e.g. an asset tag.")
  @maxLength(256)
  machineDetails?: string;

  @doc("""
The user-provided name for the bare metal machine created from this specification.
If not provided, the machine name will be generated programmatically.
""")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9]{0,62}[a-zA-Z0-9])$")
  machineName?: string;

  @doc("The slot the physical machine is in the rack based on the BOM configuration.")
  rackSlot: int32;

  @doc("The serial number of the machine. Hardware suppliers may use an alternate value. For example, service tag.")
  @maxLength(64)
  serialNumber: string;
}

@doc("StorageApplianceConfigurationData represents configuration for the storage application.")
model StorageApplianceConfigurationData {
  @doc("The credentials of the administrative interface on this storage appliance.")
  adminCredentials: AdministrativeCredentials;

  @doc("The slot that storage appliance is in the rack based on the BOM configuration.")
  rackSlot: int32;

  @doc("The serial number of the appliance.")
  serialNumber: string;

  @doc("The user-provided name for the storage appliance that will be created from this specification.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  storageApplianceName?: string;
}

@doc("ClusterAvailableUpgradeVersion represents the various cluster upgrade parameters.")
model ClusterAvailableUpgradeVersion {
  @doc("The indicator of whether the control plane will be impacted during the upgrade.")
  @visibility("read")
  controlImpact?: ControlImpact;

  @doc("The expected duration needed for this upgrade.")
  @visibility("read")
  expectedDuration?: string;

  @doc("The impact description including the specific details and release notes.")
  @visibility("read")
  impactDescription?: string;

  @doc("The last date the version of the platform is supported.")
  @visibility("read")
  supportExpiryDate?: string;

  @doc("The target version this cluster will be upgraded to.")
  @visibility("read")
  targetClusterVersion?: string;

  @doc("The indicator of whether the workload will be impacted during the upgrade.")
  @visibility("read")
  workloadImpact?: WorkloadImpact;
}

@doc("ClusterCapacity represents various details regarding compute capacity.")
model ClusterCapacity {
  @doc("The remaining appliance-based storage in GB available for workload use.")
  availableApplianceStorageGB?: int32;

  @doc("The remaining number of cores that are available in this cluster for workload use.")
  availableCoreCount?: int32;

  @doc("The remaining machine or host-based storage in GB available for workload use.")
  availableHostStorageGB?: int32;

  @doc("The remaining memory in GB that are available in this cluster for workload use.")
  availableMemoryGB?: int32;

  @doc("The total appliance-based storage in GB supported by this cluster for workload use.")
  totalApplianceStorageGB?: int32;

  @doc("The total number of cores that are supported by this cluster for workload use.")
  totalCoreCount?: int32;

  @doc("The total machine or host-based storage in GB supported by this cluster for workload use.")
  totalHostStorageGB?: int32;

  @doc("The total memory supported by this cluster for workload use.")
  totalMemoryGB?: int32;
}

@doc("ServicePrincipalInformation represents the details of the service principal to be used by the cluster during Arc Appliance installation.")
model ServicePrincipalInformation {
  @doc("The application ID, also known as client ID, of the service principal.")
  applicationId: string;

  @doc("The password of the service principal.")
  password?: string;

  @doc("The principal ID, also known as the object ID, of the service principal.")
  principalId: string;

  @doc("The tenant ID, also known as the directory ID, of the tenant in which the service principal is created.")
  tenantId: string;
}

@doc("ValidationThreshold indicates allowed machine and node hardware and deployment failures.")
model ValidationThreshold {
  @doc("Selection of how the type evaluation is applied to the cluster calculation.")
  grouping: ValidationThresholdGrouping;

  @doc("Selection of how the threshold should be evaluated.")
  type: ValidationThresholdType;

  @doc("The numeric threshold value.")
  value: int32;
}

@doc("KubernetesClusterProperties represents the properties of Kubernetes cluster resource.")
model KubernetesClusterProperties {
  @doc("The Azure Active Directory Integration properties.")
  @visibility("read", "create")
  aadConfiguration?: AadConfiguration;

  @doc("The administrative credentials that will be applied to the control plane and agent pool nodes that do not specify their own values.")
  @visibility("read", "create")
  administratorConfiguration?: AdministratorConfiguration;

  @doc("The full list of network resource IDs that are attached to this cluster, including those attached only to specific agent pools.")
  @visibility("read")
  attachedNetworkIds?: string[];

  @doc("The list of versions that this Kubernetes cluster can be upgraded to.")
  @visibility("read")
  availableUpgrades?: AvailableUpgrade[];

  @doc("The resource ID of the Network Cloud cluster.")
  @visibility("read")
  clusterId?: string;

  @doc("The resource ID of the connected cluster set up when this Kubernetes cluster is created.")
  @visibility("read")
  connectedClusterId?: string;

  @doc("The current running version of Kubernetes on the control plane.")
  @visibility("read")
  controlPlaneKubernetesVersion?: string;

  @doc("The defining characteristics of the control plane for this Kubernetes Cluster.")
  @visibility("read", "create")
  controlPlaneNodeConfiguration: ControlPlaneNodeConfiguration;

  @doc("The current status of the Kubernetes cluster.")
  @visibility("read")
  detailedStatus?: KubernetesClusterDetailedStatus;

  @doc("The descriptive message about the current detailed status.")
  @visibility("read")
  detailedStatusMessage?: string;

  @doc("The current feature settings.")
  @visibility("read")
  featureStatuses?: FeatureStatus[];

  @doc("The agent pools that are created with this Kubernetes cluster for running critical system services and workloads. This data in this field is only used during creation, and the field will be empty following the creation of the Kubernetes Cluster. After creation, the management of agent pools is done using the agentPools sub-resource.")
  @visibility("read", "create")
  initialAgentPoolConfigurations: InitialAgentPoolConfiguration[];

  @doc("The Kubernetes version for this cluster. Accepts n.n, n.n.n, and n.n.n-n format. The interpreted version used will be resolved into this field after creation or update.")
  kubernetesVersion: string;

  @doc("The configuration of the managed resource group associated with the resource.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  @doc("The configuration of the Kubernetes cluster networking, including the attachment of networks that span the cluster.")
  @visibility("read", "create")
  networkConfiguration: NetworkConfiguration;

  @doc("The details of the nodes in this cluster.")
  @visibility("read")
  nodes?: KubernetesClusterNode[];

  @doc("The provisioning state of the Kubernetes cluster resource.")
  @visibility("read")
  provisioningState?: KubernetesClusterProvisioningState;
}

@doc("AadConfiguration represents the Azure Active Directory Integration properties.")
model AadConfiguration {
  @doc("The list of Azure Active Directory group object IDs that will have an administrative role on the Kubernetes cluster.")
  @visibility("read", "create")
  adminGroupObjectIds: string[];
}

@doc("AdministratorConfiguration represents the administrative credentials that will be applied to the control plane and agent pool nodes in Kubernetes clusters.")
model AdministratorConfiguration {
  @doc("The user name for the administrator that will be applied to the operating systems that run Kubernetes nodes. If not supplied, a user name will be chosen by the service.")
  @visibility("read", "create")
  adminUsername?: string;

  @doc("The SSH configuration for the operating systems that run the nodes in the Kubernetes cluster. In some cases, specification of public keys may be required to produce a working environment.")
  @visibility("read", "create")
  sshPublicKeys?: SshPublicKey[];
}

@doc("SshPublicKey represents the public key used to authenticate with a resource through SSH.")
model SshPublicKey {
  @doc("The SSH public key data.")
  @minLength(1)
  keyData: string;
}

@doc("AvailableUpgrade represents an upgrade available for a Kubernetes cluster.")
model AvailableUpgrade {
  @doc("The version lifecycle indicator.")
  @visibility("read")
  availabilityLifecycle?: AvailabilityLifecycle;

  @doc("The version available for upgrading.")
  @visibility("read")
  version?: string;
}

@doc("ControlPlaneNodeConfiguration represents the selection of virtual machines and size of the control plane for a Kubernetes cluster.")
model ControlPlaneNodeConfiguration {
  @doc("The administrator credentials to be used for the nodes in the control plane.")
  @visibility("read", "create")
  administratorConfiguration?: AdministratorConfiguration;

  @doc("The list of availability zones of the Network Cloud cluster to be used for the provisioning of nodes in the control plane. If not specified, all availability zones will be used.")
  @visibility("read", "create")
  availabilityZones?: string[];

  @doc("The number of virtual machines that use this configuration.")
  count: int32;

  @doc("The name of the VM SKU supplied during creation.")
  @visibility("read", "create")
  vmSkuName: string;
}

@doc("FeatureStatus contains information regarding a Kubernetes cluster feature.")
model FeatureStatus {
  @doc("The status representing the state of this feature.")
  @visibility("read")
  detailedStatus?: FeatureDetailedStatus;

  @doc("The descriptive message about the current detailed status.")
  @visibility("read")
  detailedStatusMessage?: string;

  @doc("The name of the feature.")
  @visibility("read")
  name?: string;

  @doc("The version of the feature.")
  @visibility("read")
  version?: string;
}

@doc("InitialAgentPoolConfiguration specifies the configuration of a pool of virtual machines that are initially defined with a Kubernetes cluster.")
model InitialAgentPoolConfiguration {
  @doc("The administrator credentials to be used for the nodes in this agent pool.")
  @visibility("read", "create")
  administratorConfiguration?: AdministratorConfiguration;

  @doc("The configurations that will be applied to each agent in this agent pool.")
  @visibility("read", "create")
  agentOptions?: AgentOptions;

  @doc("The configuration of networks being attached to the agent pool for use by the workloads that run on this Kubernetes cluster.")
  @visibility("read", "create")
  attachedNetworkConfiguration?: AttachedNetworkConfiguration;

  @doc("The list of availability zones of the Network Cloud cluster used for the provisioning of nodes in this agent pool. If not specified, all availability zones will be used.")
  @visibility("read", "create")
  availabilityZones?: string[];

  @doc("The number of virtual machines that use this configuration.")
  @visibility("read", "create")
  count: int32;

  @doc("The labels applied to the nodes in this agent pool.")
  @visibility("read", "create")
  labels?: KubernetesLabel[];

  @doc("The selection of how this agent pool is utilized, either as a system pool or a user pool. System pools run the features and critical services for the Kubernetes Cluster, while user pools are dedicated to user workloads. Every Kubernetes cluster must contain at least one system node pool with at least one node.")
  @visibility("read", "create")
  mode: AgentPoolMode;

  @doc("The name that will be used for the agent pool resource representing this agent pool.")
  @visibility("read", "create")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  name: string;

  @doc("The taints applied to the nodes in this agent pool.")
  @visibility("read", "create")
  taints?: KubernetesLabel[];

  @doc("The configuration of the agent pool.")
  upgradeSettings?: AgentPoolUpgradeSettings;

  @doc("The name of the VM SKU that determines the size of resources allocated for node VMs.")
  @visibility("read", "create")
  vmSkuName: string;
}

@doc("AgentOptions are configurations that will be applied to each agent in an agent pool.")
model AgentOptions {
  @doc("The number of hugepages to allocate.")
  hugepagesCount: int32;

  @doc("The size of the hugepages to allocate.")
  @visibility("read", "create")
  hugepagesSize?: HugepagesSize;
}

@doc("AttachedNetworkConfiguration represents the set of workload networks to attach to a resource.")
model AttachedNetworkConfiguration {
  @doc("The list of Layer 2 Networks and related configuration for attachment.")
  @visibility("read", "create")
  l2Networks?: L2NetworkAttachmentConfiguration[];

  @doc("The list of Layer 3 Networks and related configuration for attachment.")
  @visibility("read", "create")
  l3Networks?: L3NetworkAttachmentConfiguration[];

  @doc("The list of Trunked Networks and related configuration for attachment.")
  @visibility("read", "create")
  trunkedNetworks?: TrunkedNetworkAttachmentConfiguration[];
}

@doc("L2NetworkAttachmentConfiguration represents the configuration of the attachment of a Layer 2 network.")
model L2NetworkAttachmentConfiguration {
  @doc("The resource ID of the network that is being configured for attachment.")
  @visibility("read", "create")
  networkId: string;

  @doc("The indicator of how this network will be utilized by the Kubernetes cluster.")
  @visibility("read", "create")
  pluginType?: KubernetesPluginType;
}

@doc("L3NetworkAttachmentConfiguration represents the configuration of the attachment of a Layer 3 network.")
model L3NetworkAttachmentConfiguration {
  @doc("The indication of whether this network will or will not perform IP address management and allocate IP addresses when attached.")
  @visibility("read", "create")
  ipamEnabled?: L3NetworkConfigurationIpamEnabled;

  @doc("The resource ID of the network that is being configured for attachment.")
  @visibility("read", "create")
  networkId: string;

  @doc("The indicator of how this network will be utilized by the Kubernetes cluster.")
  @visibility("read", "create")
  pluginType?: KubernetesPluginType;
}

@doc("TrunkedNetworkAttachmentConfiguration represents the configuration of the attachment of a trunked network.")
model TrunkedNetworkAttachmentConfiguration {
  @doc("The resource ID of the network that is being configured for attachment.")
  @visibility("read", "create")
  networkId: string;

  @doc("The indicator of how this network will be utilized by the Kubernetes cluster.")
  @visibility("read", "create")
  pluginType?: KubernetesPluginType;
}

@doc("KubernetesLabel represents a single entry for a Kubernetes label or taint such as those used on a node or pod.")
model KubernetesLabel {
  @doc("The name of the label or taint.")
  @visibility("read", "create")
  key: string;

  @doc("The value of the label or taint.")
  @visibility("read", "create")
  value: string;
}

@doc("AgentPoolUpgradeSettings specifies the upgrade settings for an agent pool.")
model AgentPoolUpgradeSettings {
  @doc("The maximum number or percentage of nodes that are surged during upgrade. This can either be set to an integer (e.g. '5') or a percentage (e.g. '50%'). If a percentage is specified, it is the percentage of the total agent pool size at the time of the upgrade. For percentages, fractional nodes are rounded up. If not specified, the default is 1.")
  maxSurge?: string;
}

@doc("NetworkConfiguration specifies the Kubernetes cluster network related configuration.")
model NetworkConfiguration {
  @doc("The configuration of networks being attached to the cluster for use by the workloads that run on this Kubernetes cluster.")
  @visibility("read", "create")
  attachedNetworkConfiguration?: AttachedNetworkConfiguration;

  @doc("The configuration of the BGP service load balancer for this Kubernetes cluster.")
  @visibility("read", "create")
  bgpServiceLoadBalancerConfiguration?: BgpServiceLoadBalancerConfiguration;

  @doc("The resource ID of the associated Cloud Services network.")
  @visibility("read", "create")
  cloudServicesNetworkId: string;

  @doc("The resource ID of the Layer 3 network that is used for creation of the Container Networking Interface network.")
  @visibility("read", "create")
  cniNetworkId: string;

  @doc("The IP address assigned to the Kubernetes DNS service. It must be within the Kubernetes service address range specified in service CIDR.")
  @visibility("read", "create")
  dnsServiceIp?: string;

  @doc("The CIDR notation IP ranges from which to assign pod IPs. One IPv4 CIDR is expected for single-stack networking. Two CIDRs, one for each IP family (IPv4/IPv6), is expected for dual-stack networking.")
  @visibility("read", "create")
  podCidrs?: string[];

  @doc("The CIDR notation IP ranges from which to assign service IPs. One IPv4 CIDR is expected for single-stack networking. Two CIDRs, one for each IP family (IPv4/IPv6), is expected for dual-stack networking.")
  @visibility("read", "create")
  serviceCidrs?: string[];
}

@doc("BgpServiceLoadBalancerConfiguration represents the configuration of a BGP service load balancer.")
model BgpServiceLoadBalancerConfiguration {
  @doc("The association of IP address pools to the communities and peers, allowing for announcement of IPs.")
  @visibility("read", "create")
  bgpAdvertisements?: BgpAdvertisement[];

  @doc("The list of additional BgpPeer entities that the Kubernetes cluster will peer with. All peering must be explicitly defined.")
  @visibility("read", "create")
  bgpPeers?: ServiceLoadBalancerBgpPeer[];

  @doc("The indicator to specify if the load balancer peers with the network fabric.")
  @visibility("read", "create")
  fabricPeeringEnabled?: FabricPeeringEnabled;

  @doc("The list of pools of IP addresses that can be allocated to Load Balancer services.")
  @visibility("read", "create")
  ipAddressPools?: IpAddressPool[];
}

@doc("BgpAdvertisement represents the association of IP address pools to the communities and peers.")
model BgpAdvertisement {
  @doc("The indicator of if this advertisement is also made to the network fabric associated with the Network Cloud Cluster. This field is ignored if fabricPeeringEnabled is set to False.")
  @visibility("read", "create")
  advertiseToFabric?: AdvertiseToFabric;

  @doc("The names of the BGP communities to be associated with the announcement, utilizing a BGP community string in 1234:1234 format.")
  @visibility("read", "create")
  communities?: string[];

  @doc("The names of the IP address pools associated with this announcement.")
  @visibility("read", "create")
  ipAddressPools: string[];

  @doc("The names of the BGP peers to limit this advertisement to. If no values are specified, all BGP peers will receive this advertisement.")
  @visibility("read", "create")
  peers?: string[];
}

@doc("ServiceLoadBalancerBgpPeer represents the configuration of the BGP service load balancer for the Kubernetes cluster.")
model ServiceLoadBalancerBgpPeer {
  @doc("The indicator of BFD enablement for this BgpPeer.")
  @visibility("read", "create")
  bfdEnabled?: BfdEnabled;

  @doc("The indicator to enable multi-hop peering support.")
  @visibility("read", "create")
  bgpMultiHop?: BgpMultiHop;

  @doc("The requested BGP hold time value. This field uses ISO 8601 duration format, for example P1H.")
  @visibility("read", "create")
  holdTime?: string;

  @doc("The requested BGP keepalive time value. This field uses ISO 8601 duration format, for example P1H.")
  @visibility("read", "create")
  keepAliveTime?: string;

  @doc("The autonomous system number used for the local end of the BGP session.")
  @visibility("read", "create")
  myAsn?: int32;

  @doc("The name used to identify this BGP peer for association with a BGP advertisement.")
  @visibility("read", "create")
  @pattern("^[a-z0-9]([a-z0-9.-]{0,61}[a-z0-9]){0,1}$")
  name: string;

  @doc("The authentication password for routers enforcing TCP MD5 authenticated sessions.")
  @visibility("create")
  @maxLength(80)
  @pattern("^[a-zA-Z0-9]{0,80}$")
  password?: string;

  @doc("The IPv4 or IPv6 address used to connect this BGP session.")
  @visibility("read", "create")
  peerAddress: string;

  @doc("The autonomous system number expected from the remote end of the BGP session.")
  @visibility("read", "create")
  peerAsn: int32;

  @doc("The port used to connect this BGP session.")
  @visibility("read", "create")
  peerPort?: int32;
}

@doc("IpAddressPool represents a pool of IP addresses that can be allocated to a service.")
model IpAddressPool {
  @doc("The list of IP address ranges. Each range can be a either a subnet in CIDR format or an explicit start-end range of IP addresses.")
  @visibility("read", "create")
  addresses: string[];

  @doc("The indicator to determine if automatic allocation from the pool should occur.")
  @visibility("read", "create")
  autoAssign?: BfdEnabled;

  @doc("The name used to identify this IP address pool for association with a BGP advertisement.")
  @visibility("read", "create")
  @pattern("^[a-z0-9]([a-z0-9.-]{0,61}[a-z0-9]){0,1}$")
  name: string;

  @doc("The indicator to prevent the use of IP addresses ending with .0 and .255 for this pool. Enabling this option will only use IP addresses between .1 and .254 inclusive.")
  @visibility("read", "create")
  onlyUseHostIps?: BfdEnabled;
}

@doc("KubernetesClusterNode represents the details of a node in a Kubernetes cluster.")
model KubernetesClusterNode {
  @doc("The resource ID of the agent pool that this node belongs to. This value is not represented on control plane nodes.")
  @visibility("read")
  agentPoolId?: string;

  @doc("The availability zone this node is running within.")
  @visibility("read")
  availabilityZone?: string;

  @doc("The resource ID of the bare metal machine that hosts this node.")
  @visibility("read")
  bareMetalMachineId?: string;

  @doc("The number of CPU cores configured for this node, derived from the VM SKU specified.")
  @visibility("read")
  cpuCores?: int32;

  @doc("The detailed state of this node.")
  @visibility("read")
  detailedStatus?: KubernetesClusterNodeDetailedStatus;

  @doc("The descriptive message about the current detailed status.")
  @visibility("read")
  detailedStatusMessage?: string;

  @doc("The size of the disk configured for this node.")
  @visibility("read")
  diskSizeGB?: int32;

  @doc("The machine image used to deploy this node.")
  @visibility("read")
  image?: string;

  @doc("The currently running version of Kubernetes and bundled features running on this node.")
  @visibility("read")
  kubernetesVersion?: string;

  @doc("The list of labels on this node that have been assigned to the agent pool containing this node.")
  @visibility("read")
  labels?: KubernetesLabel[];

  @doc("The amount of memory configured for this node, derived from the vm SKU specified.")
  @visibility("read")
  memorySizeGB?: int32;

  @doc("The mode of the agent pool containing this node. Not applicable for control plane nodes.")
  @visibility("read")
  mode?: AgentPoolMode;

  @doc("The name of this node, as realized in the Kubernetes cluster.")
  @visibility("read")
  name?: string;

  @doc("The NetworkAttachments made to this node.")
  @visibility("read")
  networkAttachments?: NetworkAttachment[];

  @doc("The power state of this node.")
  @visibility("read")
  powerState?: KubernetesNodePowerState;

  @doc("The role of this node in the cluster.")
  @visibility("read")
  role?: KubernetesNodeRole;

  @doc("The list of taints that have been assigned to the agent pool containing this node.")
  @visibility("read")
  taints?: KubernetesLabel[];

  @doc("The VM SKU name that was used to create this cluster node.")
  @visibility("read")
  vmSkuName?: string;
}

@doc("NetworkAttachment represents the single network attachment.")
model NetworkAttachment {
  @doc("""
The resource ID of the associated network attached to the virtual machine.
It can be one of cloudServicesNetwork, l3Network, l2Network or trunkedNetwork resources.
""")
  @visibility("read", "create")
  attachedNetworkId: string;

  @doc("""
The indicator of whether this is the default gateway.
Only one of the attached networks (including the CloudServicesNetwork attachment) for a single machine may be specified as True.
""")
  defaultGateway?: DefaultGateway;

  @doc("""
The IP allocation mechanism for the virtual machine.
Dynamic and Static are only valid for l3Network which may also specify Disabled.
Otherwise, Disabled is the only permitted value.
""")
  @visibility("read", "create")
  ipAllocationMethod: VirtualMachineIPAllocationMethod;

  @doc("""
The IPv4 address of the virtual machine.

This field is used only if the attached network has IPAllocationType of IPV4 or DualStack.

If IPAllocationMethod is:
Static - this field must contain a user specified IPv4 address from within the subnet specified in the attached network.
Dynamic - this field is read-only, but will be populated with an address from within the subnet specified in the attached network.
Disabled - this field will be empty.
""")
  @visibility("read", "create")
  ipv4Address?: string;

  @doc("""
The IPv6 address of the virtual machine.

This field is used only if the attached network has IPAllocationType of IPV6 or DualStack.

If IPAllocationMethod is:
Static - this field must contain an IPv6 address range from within the range specified in the attached network.
Dynamic - this field is read-only, but will be populated with an range from within the subnet specified in the attached network.
Disabled - this field will be empty.
""")
  @visibility("read", "create")
  ipv6Address?: string;

  @doc("The MAC address of the interface for the virtual machine that corresponds to this network attachment.")
  @visibility("read")
  macAddress?: string;

  @doc("""
The associated network's interface name.
If specified, the network attachment name has a maximum length of 15 characters and must be unique to this virtual machine.
If the user doesn’t specify this value, the default interface name of the network resource will be used.
For a CloudServicesNetwork resource, this name will be ignored.
""")
  @visibility("read", "create")
  @maxLength(15)
  networkAttachmentName?: string;
}

@doc("L2NetworkProperties represents properties of the L2 network.")
model L2NetworkProperties {
  @doc("The list of resource IDs for the other Microsoft.NetworkCloud resources that have attached this network.")
  @visibility("read")
  associatedResourceIds?: string[];

  @doc("The resource ID of the Network Cloud cluster this L2 network is associated with.")
  @visibility("read")
  clusterId?: string;

  @doc("The more detailed status of the L2 network.")
  @visibility("read")
  detailedStatus?: L2NetworkDetailedStatus;

  @doc("The descriptive message about the current detailed status.")
  @visibility("read")
  detailedStatusMessage?: string;

  @doc("Field Deprecated. These fields will be empty/omitted. The list of Hybrid AKS cluster resource ID(s) that are associated with this L2 network.")
  @visibility("read")
  hybridAksClustersAssociatedIds?: string[];

  @doc("Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The network plugin type for Hybrid AKS.")
  @visibility("read", "create")
  hybridAksPluginType?: HybridAksPluginType;

  @doc("The default interface name for this L2 network in the virtual machine. This name can be overridden by the name supplied in the network attachment configuration of that virtual machine.")
  @visibility("read", "create")
  @maxLength(12)
  @pattern("^[a-zA-Z0-9@._-]*$")
  interfaceName?: string;

  @doc("The resource ID of the Network Fabric l2IsolationDomain.")
  @visibility("read", "create")
  l2IsolationDomainId: string;

  @doc("The provisioning state of the L2 network.")
  @visibility("read")
  provisioningState?: L2NetworkProvisioningState;

  @doc("Field Deprecated. These fields will be empty/omitted. The list of virtual machine resource ID(s), excluding any Hybrid AKS virtual machines, that are currently using this L2 network.")
  @visibility("read")
  virtualMachinesAssociatedIds?: string[];
}

@doc("L3NetworkProperties represents properties of the L3 network.")
model L3NetworkProperties {
  @doc("The list of resource IDs for the other Microsoft.NetworkCloud resources that have attached this network.")
  @visibility("read")
  associatedResourceIds?: string[];

  @doc("The resource ID of the Network Cloud cluster this L3 network is associated with.")
  @visibility("read")
  clusterId?: string;

  @doc("The more detailed status of the L3 network.")
  @visibility("read")
  detailedStatus?: L3NetworkDetailedStatus;

  @doc("The descriptive message about the current detailed status.")
  @visibility("read")
  detailedStatusMessage?: string;

  @doc("Field Deprecated. These fields will be empty/omitted. The list of Hybrid AKS cluster resource IDs that are associated with this L3 network.")
  @visibility("read")
  hybridAksClustersAssociatedIds?: string[];

  @doc("Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The indicator of whether or not to disable IPAM allocation on the network attachment definition injected into the Hybrid AKS Cluster.")
  @visibility("read", "create")
  hybridAksIpamEnabled?: HybridAksIpamEnabled;

  @doc("Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The network plugin type for Hybrid AKS.")
  @visibility("read", "create")
  hybridAksPluginType?: HybridAksPluginType;

  @doc("The default interface name for this L3 network in the virtual machine. This name can be overridden by the name supplied in the network attachment configuration of that virtual machine.")
  @visibility("read", "create")
  @maxLength(12)
  @pattern("^[a-zA-Z0-9@._-]*$")
  interfaceName?: string;

  @doc("The type of the IP address allocation, defaulted to \"DualStack\".")
  ipAllocationType?: IpAllocationType;

  @doc("""
The IPV4 prefix (CIDR) assigned to this L3 network. Required when the IP allocation type
is IPV4 or DualStack.
""")
  @visibility("read", "create")
  ipv4ConnectedPrefix?: string;

  @doc("""
The IPV6 prefix (CIDR) assigned to this L3 network. Required when the IP allocation type
is IPV6 or DualStack.
""")
  @visibility("read", "create")
  ipv6ConnectedPrefix?: string;

  @doc("The resource ID of the Network Fabric l3IsolationDomain.")
  @visibility("read", "create")
  l3IsolationDomainId: string;

  @doc("The provisioning state of the L3 network.")
  @visibility("read")
  provisioningState?: L3NetworkProvisioningState;

  @doc("Field Deprecated. These fields will be empty/omitted. The list of virtual machine resource IDs, excluding any Hybrid AKS virtual machines, that are currently using this L3 network.")
  @visibility("read")
  virtualMachinesAssociatedIds?: string[];

  @doc("The VLAN from the l3IsolationDomain that is used for this network.")
  @visibility("read", "create")
  vlan: int32;
}

@doc("RackSkuProperties represents the properties of compute-related hardware for a rack. This supports both aggregator and compute racks.")
model RackSkuProperties {
  @doc("The list of machine SKUs and associated rack slot for the compute-dedicated machines in this rack model.")
  @visibility("read")
  computeMachines?: MachineSkuSlot[];

  @doc("The list of machine SKUs and associated rack slot for the control-plane dedicated machines in this rack model.")
  @visibility("read")
  controllerMachines?: MachineSkuSlot[];

  @doc("The free-form text describing the rack.")
  @visibility("read")
  description?: string;

  @doc("The maximum number of compute racks supported by an aggregator rack. 0 if this is a compute rack or a rack for a single rack cluster(rackType=\"Single\").")
  @visibility("read")
  maxClusterSlots?: int32;

  @doc("The provisioning state of the rack SKU resource.")
  @visibility("read")
  provisioningState?: RackSkuProvisioningState;

  @doc("The type of the rack.")
  @visibility("read")
  rackType?: RackSkuType;

  @doc("The list of appliance SKUs and associated rack slot for the storage appliance(s) in this rack model.")
  @visibility("read")
  storageAppliances?: StorageApplianceSkuSlot[];

  @doc("The list of supported SKUs if the rack is an aggregator.")
  @visibility("read")
  supportedRackSkuIds?: string[];
}

@doc("MachineSkuSlot represents a single SKU and rack slot associated with the machine.")
model MachineSkuSlot {
  @doc("The list of the resource properties.")
  properties?: MachineSkuProperties;

  @doc("The position in the rack for the machine.")
  @visibility("read")
  rackSlot?: int32;
}

@doc("MachineSkuProperties represents the properties of the machine SKU.")
model MachineSkuProperties {
  @doc("The type of bootstrap protocol used.")
  @visibility("read")
  bootstrapProtocol?: BootstrapProtocol;

  @doc("The count of CPU cores for this machine.")
  @visibility("read")
  cpuCores?: int32;

  @doc("The count of CPU sockets for this machine.")
  @visibility("read")
  cpuSockets?: int32;

  @doc("The list of disks.")
  @visibility("read")
  disks?: MachineDisk[];

  @doc("The generation of the architecture.")
  @visibility("read")
  generation?: string;

  @doc("The hardware version of the machine.")
  @visibility("read")
  hardwareVersion?: string;

  @doc("The maximum amount of memory in GB.")
  @visibility("read")
  memoryCapacityGB?: int32;

  @doc("The model of the machine.")
  @visibility("read")
  `model`?: string;

  @doc("The list of network interfaces.")
  @visibility("read")
  networkInterfaces?: NetworkInterface[];

  @doc("The count of SMT and physical core threads for this machine.")
  @visibility("read")
  totalThreads?: int32;

  @doc("The make of the machine.")
  @visibility("read")
  vendor?: string;
}

@doc("Disk represents the properties of the disk.")
model MachineDisk {
  @doc("The maximum amount of storage in GB.")
  @visibility("read")
  capacityGB?: int32;

  @doc("The connection type of the rack SKU resource.")
  @visibility("read")
  connection?: MachineSkuDiskConnectionType;

  @doc("The disk type of rack SKU resource.")
  @visibility("read")
  type?: DiskType;
}

@doc("NetworkInterface represents properties of the network interface.")
model NetworkInterface {
  @doc("The partial address of Peripheral Component Interconnect (PCI).")
  @visibility("read")
  address?: string;

  @doc("The connection type of the device.")
  @visibility("read")
  deviceConnectionType?: DeviceConnectionType;

  @doc("The model name of the device.")
  @visibility("read")
  `model`?: string;

  @doc("The physical slot for this device.")
  @visibility("read")
  physicalSlot?: int32;

  @doc("The number of ports on the device.")
  @visibility("read")
  portCount?: int32;

  @doc("The maximum amount of data in GB that the line card transmits through a port at any given second.")
  @visibility("read")
  portSpeed?: int32;

  @doc("The vendor name of the device.")
  @visibility("read")
  vendor?: string;
}

@doc("StorageApplianceSkuSlot represents the single SKU and rack slot associated with the storage appliance.")
model StorageApplianceSkuSlot {
  @doc("The list of the resource properties.")
  properties?: StorageApplianceSkuProperties;

  @doc("The position in the rack for the storage appliance.")
  @visibility("read")
  rackSlot?: int32;
}

@doc("StorageApplianceSkuProperties represents the properties of the storage appliance SKU.")
model StorageApplianceSkuProperties {
  @doc("The maximum capacity of the storage appliance.")
  @visibility("read")
  capacityGB?: int32;

  @doc("The model of the storage appliance.")
  @visibility("read")
  `model`?: string;
}

@doc("RackProperties represents the properties of the rack.")
model RackProperties {
  @doc("The value that will be used for machines in this rack to represent the availability zones that can be referenced by Hybrid AKS Clusters for node arrangement.")
  @pattern("^[a-zA-Z0-9]{1,10}$")
  availabilityZone: string;

  @doc("The resource ID of the cluster the rack is created for. This value is set when the rack is created by the cluster.")
  @visibility("read")
  clusterId?: string;

  @doc("The more detailed status of the rack.")
  @visibility("read")
  detailedStatus?: RackDetailedStatus;

  @doc("The descriptive message about the current detailed status.")
  @visibility("read")
  detailedStatusMessage?: string;

  @doc("The provisioning state of the rack resource.")
  @visibility("read")
  provisioningState?: RackProvisioningState;

  @doc("The free-form description of the rack location. (e.g. “DTN Datacenter, Floor 3, Isle 9, Rack 2B”)")
  @maxLength(256)
  rackLocation: string;

  @doc("The unique identifier for the rack within Network Cloud cluster. An alternate unique alphanumeric value other than a serial number may be provided if desired.")
  @maxLength(64)
  @minLength(1)
  rackSerialNumber: string;

  @doc("The SKU for the rack.")
  rackSkuId: string;
}

@doc("StorageApplianceProperties represents the properties of the storage appliance.")
model StorageApplianceProperties {
  @doc("The credentials of the administrative interface on this storage appliance.")
  @visibility("read", "create")
  administratorCredentials: AdministrativeCredentials;

  @doc("The total capacity of the storage appliance.")
  @visibility("read")
  capacity?: int32;

  @doc("The amount of storage consumed.")
  @visibility("read")
  capacityUsed?: int32;

  @doc("The resource ID of the cluster this storage appliance is associated with.")
  @visibility("read")
  clusterId?: string;

  @doc("The detailed status of the storage appliance.")
  @visibility("read")
  detailedStatus?: StorageApplianceDetailedStatus;

  @doc("The descriptive message about the current detailed status.")
  @visibility("read")
  detailedStatusMessage?: string;

  @doc("The endpoint for the management interface of the storage appliance.")
  @visibility("read")
  managementIpv4Address?: string;

  @doc("The provisioning state of the storage appliance.")
  @visibility("read")
  provisioningState?: StorageApplianceProvisioningState;

  @doc("The resource ID of the rack where this storage appliance resides.")
  @visibility("read", "create")
  rackId: string;

  @doc("The slot the storage appliance is in the rack based on the BOM configuration.")
  @visibility("read", "create")
  rackSlot: int32;

  @doc("The indicator of whether the storage appliance supports remote vendor management.")
  @visibility("read")
  remoteVendorManagementFeature?: RemoteVendorManagementFeature;

  @doc("The indicator of whether the remote vendor management feature is enabled or disabled, or unsupported if it is an unsupported feature.")
  @visibility("read")
  remoteVendorManagementStatus?: RemoteVendorManagementStatus;

  @doc("The serial number for the storage appliance.")
  serialNumber: string;

  @doc("The SKU for the storage appliance.")
  @visibility("read", "create")
  storageApplianceSkuId: string;
}

@doc("TrunkedNetworkProperties represents properties of the trunked network.")
model TrunkedNetworkProperties {
  @doc("The list of resource IDs for the other Microsoft.NetworkCloud resources that have attached this network.")
  @visibility("read")
  associatedResourceIds?: string[];

  @doc("The resource ID of the Network Cloud cluster this trunked network is associated with.")
  @visibility("read")
  clusterId?: string;

  @doc("The more detailed status of the trunked network.")
  @visibility("read")
  detailedStatus?: TrunkedNetworkDetailedStatus;

  @doc("The descriptive message about the current detailed status.")
  @visibility("read")
  detailedStatusMessage?: string;

  @doc("Field Deprecated. These fields will be empty/omitted. The list of Hybrid AKS cluster resource IDs that are associated with this trunked network.")
  @visibility("read")
  hybridAksClustersAssociatedIds?: string[];

  @doc("Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The network plugin type for Hybrid AKS.")
  @visibility("read", "create")
  hybridAksPluginType?: HybridAksPluginType;

  @doc("The default interface name for this trunked network in the virtual machine. This name can be overridden by the name supplied in the network attachment configuration of that virtual machine.")
  @visibility("read", "create")
  @maxLength(12)
  @pattern("^[a-zA-Z0-9@._-]*$")
  interfaceName?: string;

  @doc("The list of resource IDs representing the Network Fabric isolation domains. It can be any combination of l2IsolationDomain and l3IsolationDomain resources.")
  @visibility("read", "create")
  isolationDomainIds: string[];

  @doc("The provisioning state of the trunked network.")
  @visibility("read")
  provisioningState?: TrunkedNetworkProvisioningState;

  @doc("Field Deprecated. These fields will be empty/omitted. The list of virtual machine resource IDs, excluding any Hybrid AKS virtual machines, that are currently using this trunked network.")
  @visibility("read")
  virtualMachinesAssociatedIds?: string[];

  @doc("The list of vlans that are selected from the isolation domains for trunking.")
  @visibility("read", "create")
  vlans: int32[];
}

@doc("VirtualMachineProperties represents the properties of the virtual machine.")
model VirtualMachineProperties {
  @doc("The name of the administrator to which the ssh public keys will be added into the authorized keys.")
  @visibility("read", "create")
  @maxLength(32)
  @minLength(1)
  @pattern("^[a-z_][a-z0-9_]{0,31}$")
  adminUsername: string;

  @doc("The cluster availability zone containing this virtual machine.")
  @visibility("read")
  availabilityZone?: string;

  @doc("The resource ID of the bare metal machine the virtual machine has landed to.")
  @visibility("read")
  bareMetalMachineId?: string;

  @doc("Selects the boot method for the virtual machine.")
  @visibility("read", "create")
  bootMethod?: VirtualMachineBootMethod;

  @doc("The cloud service network that provides platform-level services for the virtual machine.")
  @visibility("read", "create")
  cloudServicesNetworkAttachment: NetworkAttachment;

  @doc("The resource ID of the cluster the virtual machine is created for.")
  @visibility("read")
  clusterId?: string;

  @doc("The number of CPU cores in the virtual machine.")
  @visibility("read", "create")
  cpuCores: int32;

  @doc("The more detailed status of the virtual machine.")
  @visibility("read")
  detailedStatus?: VirtualMachineDetailedStatus;

  @doc("The descriptive message about the current detailed status.")
  @visibility("read")
  detailedStatusMessage?: string;

  @doc("Field Deprecated, the value will be ignored if provided. The indicator of whether one of the specified CPU cores is isolated to run the emulator thread for this virtual machine.")
  @visibility("read", "create")
  isolateEmulatorThread?: VirtualMachineIsolateEmulatorThread;

  @doc("The memory size of the virtual machine in GB.")
  @visibility("read", "create")
  memorySizeGB: int32;

  @doc("The list of network attachments to the virtual machine.")
  @visibility("read", "create")
  networkAttachments?: NetworkAttachment[];

  @doc("The Base64 encoded cloud-init network data.")
  @visibility("read", "create")
  networkData?: string;

  @doc("The scheduling hints for the virtual machine.")
  @visibility("read", "create")
  placementHints?: VirtualMachinePlacementHint[];

  @doc("The power state of the virtual machine.")
  @visibility("read")
  powerState?: VirtualMachinePowerState;

  @doc("The provisioning state of the virtual machine.")
  @visibility("read")
  provisioningState?: VirtualMachineProvisioningState;

  @doc("The list of ssh public keys. Each key will be added to the virtual machine using the cloud-init ssh_authorized_keys mechanism for the adminUsername.")
  @visibility("read", "create")
  sshPublicKeys?: SshPublicKey[];

  @doc("The storage profile that specifies size and other parameters about the disks related to the virtual machine.")
  @visibility("read", "create")
  storageProfile: StorageProfile;

  @doc("The Base64 encoded cloud-init user data.")
  @visibility("read", "create")
  userData?: string;

  @doc("Field Deprecated, use virtualizationModel instead. The type of the virtio interface.")
  @visibility("read", "create")
  virtioInterface?: VirtualMachineVirtioInterfaceType;

  @doc("The type of the device model to use.")
  @visibility("read", "create")
  vmDeviceModel?: VirtualMachineDeviceModelType;

  @doc("The virtual machine image that is currently provisioned to the OS disk, using the full url and tag notation used to pull the image.")
  @visibility("read", "create")
  vmImage: string;

  @doc("The credentials used to login to the image repository that has access to the specified image.")
  vmImageRepositoryCredentials?: ImageRepositoryCredentials;

  @doc("The resource IDs of volumes that are attached to the virtual machine.")
  @visibility("read")
  volumes?: string[];
}

@doc("VirtualMachinePlacementHint represents a single scheduling hint of the virtual machine.")
model VirtualMachinePlacementHint {
  @doc("The specification of whether this hint supports affinity or anti-affinity with the referenced resources.")
  @visibility("read", "create")
  hintType: VirtualMachinePlacementHintType;

  @doc("The resource ID of the target object that the placement hints will be checked against, e.g., the bare metal node to host the virtual machine.")
  @visibility("read", "create")
  @minLength(1)
  resourceId: string;

  @doc("The indicator of whether the hint is a hard or soft requirement during scheduling.")
  @visibility("read", "create")
  schedulingExecution: VirtualMachineSchedulingExecution;

  @doc("The scope for the virtual machine affinity or anti-affinity placement hint. It should always be \"Machine\" in the case of node affinity.")
  @visibility("read", "create")
  scope: VirtualMachinePlacementHintPodAffinityScope;
}

@doc("StorageProfile represents information about a disk.")
model StorageProfile {
  @doc("The disk to use with this virtual machine.")
  osDisk: OsDisk;

  @doc("The resource IDs of volumes that are requested to be attached to the virtual machine.")
  volumeAttachments?: string[];
}

@doc("OsDisk represents configuration of the boot disk.")
model OsDisk {
  @doc("The strategy for creating the OS disk.")
  createOption?: OsDiskCreateOption;

  @doc("The strategy for deleting the OS disk.")
  deleteOption?: OsDiskDeleteOption;

  @doc("The size of the disk in gigabytes. Required if the createOption is Ephemeral.")
  diskSizeGB: int32;
}

@doc("ImageRepositoryCredentials represents the credentials used to login to the image repository.")
model ImageRepositoryCredentials {
  @doc("The password or token used to access an image in the target repository.")
  @minLength(1)
  password?: string;

  @doc("The URL of the authentication server used to validate the repository credentials.")
  registryUrl: string;

  @doc("The username used to access an image in the target repository.")
  @minLength(1)
  username: string;
}

@doc("VolumeProperties represents properties of the volume resource.")
model VolumeProperties {
  @doc("The list of resource IDs that attach the volume. It may include virtual machines and Hybrid AKS clusters.")
  @visibility("read")
  attachedTo?: string[];

  @doc("The more detailed status of the volume.")
  @visibility("read")
  detailedStatus?: VolumeDetailedStatus;

  @doc("The descriptive message about the current detailed status.")
  @visibility("read")
  detailedStatusMessage?: string;

  @doc("The provisioning state of the volume.")
  @visibility("read")
  provisioningState?: VolumeProvisioningState;

  @doc("The unique identifier of the volume.")
  @visibility("read")
  serialNumber?: string;

  @doc("The size of the allocation for this volume in Mebibytes.")
  @visibility("read", "create")
  sizeMiB: int32;
}

@doc("BareMetalMachineCordonParameters represents the body of the request to evacuate workloads from node on a bare metal machine.")
model BareMetalMachineCordonParameters {
  @doc("The indicator of whether to evacuate the node workload when the bare metal machine is cordoned.")
  evacuate?: BareMetalMachineEvacuate;
}

@doc("BareMetalMachinePowerOffParameters represents the body of the request to power off bare metal machine.")
model BareMetalMachinePowerOffParameters {
  @doc("The indicator of whether to skip the graceful OS shutdown and power off the bare metal machine immediately.")
  skipShutdown?: BareMetalMachineSkipShutdown;
}

@doc("BareMetalMachineReplaceParameters represents the body of the request to physically swap a bare metal machine for another.")
model BareMetalMachineReplaceParameters {
  @doc("The credentials of the baseboard management controller on this bare metal machine.")
  bmcCredentials?: AdministrativeCredentials;

  @doc("The MAC address of the BMC device.")
  @pattern("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$")
  bmcMacAddress?: string;

  @doc("The MAC address of a NIC connected to the PXE network.")
  @pattern("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$")
  bootMacAddress?: string;

  @doc("The OS-level hostname assigned to this machine.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9]{0,62}[a-zA-Z0-9])$")
  machineName?: string;

  @doc("The serial number of the bare metal machine.")
  @maxLength(64)
  @minLength(1)
  serialNumber?: string;
}

@doc("BareMetalMachineRunCommandParameters represents the body of the request to execute a script on the bare metal machine.")
model BareMetalMachineRunCommandParameters {
  @doc("The list of string arguments that will be passed to the script in order as separate arguments.")
  arguments?: string[];

  @doc("""
The maximum time the script is allowed to run.
If the execution time exceeds the maximum, the script will be stopped, any output produced until then will be captured, and the exit code matching a timeout will be returned (252).
""")
  limitTimeSeconds: int32;

  @doc("The base64 encoded script to execute on the bare metal machine.")
  script: string;
}

@doc("BareMetalMachineRunDataExtractsParameters represents the body of request containing list of curated data extraction commands to run on the bare metal machine.")
model BareMetalMachineRunDataExtractsParameters {
  @doc("The list of curated data extraction commands to be executed directly against the target machine.")
  commands: BareMetalMachineCommandSpecification[];

  @doc("""
The maximum time the commands are allowed to run.
If the execution time exceeds the maximum, the script will be stopped, any output produced until then will be captured, and the exit code matching a timeout will be returned (252).
""")
  limitTimeSeconds: int32;
}

@doc("BareMetalMachineCommandSpecification represents the command and optional arguments to exercise against the bare metal machine.")
model BareMetalMachineCommandSpecification {
  @doc("The list of string arguments that will be passed to the script in order as separate arguments.")
  arguments?: string[];

  @doc("The command to execute against the bare metal machine.")
  command: string;
}

@doc("BareMetalMachineRunReadCommandsParameters represents the body of request containing list of read-only commands to run on the bare metal machine.")
model BareMetalMachineRunReadCommandsParameters {
  @doc("The list of read-only commands to be executed directly against the target machine.")
  commands: BareMetalMachineCommandSpecification[];

  @doc("""
The maximum time the commands are allowed to run.
If the execution time exceeds the maximum, the script will be stopped, any output produced until then will be captured, and the exit code matching a timeout will be returned (252).
""")
  limitTimeSeconds: int32;
}

@doc("BareMetalMachineKeySetProperties represents the properties of bare metal machine key set.")
model BareMetalMachineKeySetProperties {
  @doc("The object ID of Azure Active Directory group that all users in the list must be in for access to be granted. Users that are not in the group will not have access.")
  @visibility("read", "create")
  azureGroupId: string;

  @doc("The more detailed status of the key set.")
  @visibility("read")
  detailedStatus?: BareMetalMachineKeySetDetailedStatus;

  @doc("The descriptive message about the current detailed status.")
  @visibility("read")
  detailedStatusMessage?: string;

  @doc("The date and time after which the users in this key set will be removed from the bare metal machines.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiration: utcDateTime;

  @doc("The list of IP addresses of jump hosts with management network access from which a login will be allowed for the users.")
  jumpHostsAllowed: string[];

  @doc("The last time this key set was validated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastValidation?: utcDateTime;

  @doc("The name of the group that users will be assigned to on the operating system of the machines.")
  @visibility("read", "create")
  @maxLength(32)
  @pattern("^([A-Za-z]([A-Za-z0-9]*))$")
  osGroupName?: string;

  @doc("The access level allowed for the users in this key set.")
  @visibility("read", "create")
  privilegeLevel: BareMetalMachineKeySetPrivilegeLevel;

  @doc("The provisioning state of the bare metal machine key set.")
  @visibility("read")
  provisioningState?: BareMetalMachineKeySetProvisioningState;

  @doc("The unique list of permitted users.")
  userList: KeySetUser[];

  @doc("The status evaluation of each user.")
  @visibility("read")
  userListStatus?: KeySetUserStatus[];
}

@doc("KeySetUser represents the properties of the user in the key set.")
model KeySetUser {
  @doc("The user name that will be used for access.")
  azureUserName: string;

  @doc("The free-form description for this user.")
  @maxLength(256)
  description?: string;

  @doc("The SSH public key that will be provisioned for user access. The user is expected to have the corresponding SSH private key for logging in.")
  sshPublicKey: SshPublicKey;
}

@doc("KeySetUserStatus represents the status of the key set user.")
model KeySetUserStatus {
  @doc("The user name that will be used for access.")
  @visibility("read")
  azureUserName?: string;

  @doc("The indicator of whether the user is currently deployed for access.")
  @visibility("read")
  status?: BareMetalMachineKeySetUserSetupStatus;

  @doc("The additional information describing the current status of this user, if any available.")
  @visibility("read")
  @maxLength(256)
  statusMessage?: string;
}

@doc("BmcKeySetProperties represents the properties of baseboard management controller key set.")
model BmcKeySetProperties {
  @doc("The object ID of Azure Active Directory group that all users in the list must be in for access to be granted. Users that are not in the group will not have access.")
  @visibility("read", "create")
  azureGroupId: string;

  @doc("The more detailed status of the key set.")
  @visibility("read")
  detailedStatus?: BmcKeySetDetailedStatus;

  @doc("The descriptive message about the current detailed status.")
  @visibility("read")
  detailedStatusMessage?: string;

  @doc("The date and time after which the users in this key set will be removed from the baseboard management controllers.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiration: utcDateTime;

  @doc("The last time this key set was validated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastValidation?: utcDateTime;

  @doc("The access level allowed for the users in this key set.")
  @visibility("read", "create")
  privilegeLevel: BmcKeySetPrivilegeLevel;

  @doc("The provisioning state of the baseboard management controller key set.")
  @visibility("read")
  provisioningState?: BmcKeySetProvisioningState;

  @doc("The unique list of permitted users.")
  userList: KeySetUser[];

  @doc("The status evaluation of each user.")
  @visibility("read")
  userListStatus?: KeySetUserStatus[];
}

@doc("ClusterDeployParameters represents the body of the request to deploy cluster.")
model ClusterDeployParameters {
  @doc("The names of bare metal machines in the cluster that should be skipped during environment validation.")
  skipValidationsForMachines?: string[];
}

@doc("ClusterMetricsConfigurationProperties represents the properties of metrics configuration for the cluster.")
model ClusterMetricsConfigurationProperties {
  @doc("The interval in minutes by which metrics will be collected.")
  collectionInterval: int32;

  @doc("The more detailed status of the metrics configuration.")
  @visibility("read")
  detailedStatus?: ClusterMetricsConfigurationDetailedStatus;

  @doc("The descriptive message about the current detailed status.")
  @visibility("read")
  detailedStatusMessage?: string;

  @doc("The list of metrics that are available for the cluster but disabled at the moment.")
  @visibility("read")
  disabledMetrics?: string[];

  @doc("The list of metric names that have been chosen to be enabled in addition to the core set of enabled metrics.")
  enabledMetrics?: string[];

  @doc("The provisioning state of the metrics configuration.")
  @visibility("read")
  provisioningState?: ClusterMetricsConfigurationProvisioningState;
}

@doc("ClusterUpdateVersionParameters represents the body of the request to update cluster version.")
model ClusterUpdateVersionParameters {
  @doc("The version to be applied to the cluster during update.")
  targetClusterVersion: string;
}

@doc("ControlPlaneNodePatchConfiguration represents the properties of the control plane that can be patched for this Kubernetes cluster.")
model ControlPlaneNodePatchConfiguration {
  @doc("The number of virtual machines that use this configuration.")
  count?: int32;
}

@doc("AgentPoolProperties represents the properties of the Kubernetes cluster agent pool.")
model AgentPoolProperties {
  @doc("The administrator credentials to be used for the nodes in this agent pool.")
  @visibility("read", "create")
  administratorConfiguration?: AdministratorConfiguration;

  @doc("The configurations that will be applied to each agent in this agent pool.")
  @visibility("read", "create")
  agentOptions?: AgentOptions;

  @doc("The configuration of networks being attached to the agent pool for use by the workloads that run on this Kubernetes cluster.")
  @visibility("read", "create")
  attachedNetworkConfiguration?: AttachedNetworkConfiguration;

  @doc("The list of availability zones of the Network Cloud cluster used for the provisioning of nodes in this agent pool. If not specified, all availability zones will be used.")
  @visibility("read", "create")
  availabilityZones?: string[];

  @doc("The number of virtual machines that use this configuration.")
  count: int32;

  @doc("The current status of the agent pool.")
  @visibility("read")
  detailedStatus?: AgentPoolDetailedStatus;

  @doc("The descriptive message about the current detailed status.")
  @visibility("read")
  detailedStatusMessage?: string;

  @doc("The Kubernetes version running in this agent pool.")
  @visibility("read")
  kubernetesVersion?: string;

  @doc("The labels applied to the nodes in this agent pool.")
  @visibility("read", "create")
  labels?: KubernetesLabel[];

  @doc("The selection of how this agent pool is utilized, either as a system pool or a user pool. System pools run the features and critical services for the Kubernetes Cluster, while user pools are dedicated to user workloads. Every Kubernetes cluster must contain at least one system node pool with at least one node.")
  @visibility("read", "create")
  mode: AgentPoolMode;

  @doc("The provisioning state of the agent pool.")
  @visibility("read")
  provisioningState?: AgentPoolProvisioningState;

  @doc("The taints applied to the nodes in this agent pool.")
  @visibility("read", "create")
  taints?: KubernetesLabel[];

  @doc("The configuration of the agent pool.")
  upgradeSettings?: AgentPoolUpgradeSettings;

  @doc("The name of the VM SKU that determines the size of resources allocated for node VMs.")
  @visibility("read", "create")
  vmSkuName: string;
}

@doc("KubernetesClusterRestartNodeParameters represents the body of the request to restart the node of a Kubernetes cluster.")
model KubernetesClusterRestartNodeParameters {
  @doc("The name of the node to restart.")
  nodeName: string;
}

@doc("StorageApplianceEnableRemoteVendorManagementParameters represents the body of the request to enable remote vendor management of a storage appliance.")
model StorageApplianceEnableRemoteVendorManagementParameters {
  @doc("Field Deprecated. This field is not used and will be rejected if provided. The list of IPv4 subnets (in CIDR format), IPv6 subnets (in CIDR format), or hostnames that the storage appliance needs accessible in order to turn on the remote vendor management.")
  supportEndpoints?: string[];
}

@doc("ConsoleProperties represents the properties of the virtual machine console.")
model ConsoleProperties {
  @doc("The more detailed status of the console.")
  @visibility("read")
  detailedStatus?: ConsoleDetailedStatus;

  @doc("The descriptive message about the current detailed status.")
  @visibility("read")
  detailedStatusMessage?: string;

  @doc("The indicator of whether the console access is enabled.")
  enabled: ConsoleEnabled;

  @doc("The date and time after which the key will be disallowed access.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiration?: utcDateTime;

  @doc("The resource ID of the private link service that is used to provide virtual machine console access.")
  @visibility("read")
  privateLinkServiceId?: string;

  @doc("The provisioning state of the virtual machine console.")
  @visibility("read")
  provisioningState?: ConsoleProvisioningState;

  @doc("The SSH public key that will be provisioned for user access. The user is expected to have the corresponding SSH private key for logging in.")
  sshPublicKey: SshPublicKey;

  @doc("The unique identifier for the virtual machine that is used to access the console.")
  @visibility("read")
  virtualMachineAccessId?: string;
}

@doc("VirtualMachinePowerOffParameters represents the body of the request to power off virtual machine.")
model VirtualMachinePowerOffParameters {
  @doc("The indicator of whether to skip the graceful OS shutdown and power off the virtual machine immediately.")
  skipShutdown?: SkipShutdown;
}

@doc("AgentPoolConfiguration specifies the configuration of a pool of nodes.")
model AgentPoolConfiguration {
  @doc("The administrator credentials to be used for the nodes in this agent pool.")
  @visibility("read", "create")
  administratorConfiguration?: AdministratorConfiguration;

  @doc("The configurations that will be applied to each agent in this agent pool.")
  @visibility("read", "create")
  agentOptions?: AgentOptions;

  @doc("The configuration of networks being attached to the agent pool for use by the workloads that run on this Kubernetes cluster.")
  @visibility("read", "create")
  attachedNetworkConfiguration?: AttachedNetworkConfiguration;

  @doc("The list of availability zones of the Network Cloud cluster used for the provisioning of nodes in this agent pool. If not specified, all availability zones will be used.")
  @visibility("read", "create")
  availabilityZones?: string[];

  @doc("The number of virtual machines that use this configuration.")
  count: int32;

  @doc("The labels applied to the nodes in this agent pool.")
  @visibility("read", "create")
  labels?: KubernetesLabel[];

  @doc("The selection of how this agent pool is utilized, either as a system pool or a user pool. System pools run the features and critical services for the Kubernetes Cluster, while user pools are dedicated to user workloads. Every Kubernetes cluster must contain at least one system node pool with at least one node.")
  @visibility("read", "create")
  mode: AgentPoolMode;

  @doc("The taints applied to the nodes in this agent pool.")
  @visibility("read", "create")
  taints?: KubernetesLabel[];

  @doc("The configuration of the agent pool.")
  upgradeSettings?: AgentPoolUpgradeSettings;

  @doc("The name of the VM SKU that determines the size of resources allocated for node VMs.")
  @visibility("read", "create")
  vmSkuName: string;
}

@doc("TagsParameter represents the resource tags.")
model TagsParameter {
  @doc("The Azure resource tags that will replace the existing ones.")
  tags?: Record<string>;
}

@doc("The current status of an async operation.")
model OperationStatusResult {
  @doc("Fully qualified ID for the async operation.")
  id?: ResourceIdentifier;

  @doc("Fully qualified ID of the resource against which the original async operation was started.")
  @visibility("read")
  resourceId?: ResourceIdentifier;

  @doc("Name of the async operation.")
  name?: string;

  @doc("Operation status.")
  status: string;

  @doc("Percent of the operation that is complete.")
  percentComplete?: float32;

  @doc("The start time of the operation.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The end time of the operation.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The operations list.")
  operations?: OperationStatusResult[];

  @doc("If present, details of the operation error.")
  error?: ErrorDetail;
}
