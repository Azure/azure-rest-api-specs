import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AzureStackHCI;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Datasource for the gallery image when provisioning with cloud-init [NoCloud, Azure]")
enum CloudInitDataSource {
  NoCloud,
  Azure,
}

@doc("The hypervisor generation of the Virtual Machine [V1, V2]")
enum HyperVGeneration {
  V1,
  V2,
}

@doc("Provisioning state of the gallery image.")
enum ProvisioningStateEnum {
  Succeeded,
  Failed,
  InProgress,
  Accepted,
  Deleting,
  Canceled,
}

@doc("Status of the cluster agent.")
enum Status {
  NotYetRegistered,
  ConnectedRecently,
  NotConnectedRecently,
  Disconnected,
  Error,
  NotSpecified,
  Succeeded,
  Failed,
  InProgress,
}

@doc("The type of extendedLocation.")
enum ExtendedLocationTypes {
  CustomLocation,
}

@doc("IPAllocationMethod - The IP address allocation method. Possible values include: 'Static', 'Dynamic'")
enum IpAllocationMethodEnum {
  Dynamic,
  Static,
}

@doc("The format of the actual VHD file [vhd, vhdx]")
enum DiskFileFormat {
  vhdx,
  vhd,
}

enum VmSizeEnum {
  Default,
  Standard_A2_v2,
  Standard_A4_v2,
  Standard_D2s_v3,
  Standard_D4s_v3,
  Standard_D8s_v3,
  Standard_D16s_v3,
  Standard_D32s_v3,
  Standard_DS2_v2,
  Standard_DS3_v2,
  Standard_DS4_v2,
  Standard_DS5_v2,
  Standard_DS13_v2,
  Standard_K8S_v1,
  Standard_K8S2_v1,
  Standard_K8S3_v1,
  Standard_K8S4_v1,
  Standard_NK6,
  Standard_NK12,
  Standard_NV6,
  Standard_NV12,
  Standard_K8S5_v1,
  Custom,
}

@doc("Specifies the SecurityType of the virtual machine. EnableTPM and SecureBootEnabled must be set to true for SecurityType to function.")
enum SecurityTypes {
  TrustedLaunch,
  ConfidentialVM,
}

@doc("The level code.")
enum StatusLevelTypes {
  Info,
  Warning,
  Error,
}

@doc("The power state of the virtual machine instance")
enum PowerStateEnum {
  Deallocated,
  Deallocating,
  Running,
  Starting,
  Stopped,
  Stopping,
  Unknown,
}

@doc("The installation status of the hybrid machine agent installation.")
enum StatusTypes {
  Succeeded,
  InProgress,
  Failed,
}

@doc("Defines the different types of operations for guest agent.")
enum ProvisioningAction {
  install,
  uninstall,
  repair,
}

@doc("Provisioning state of the ArcSetting proxy resource.")
enum ProvisioningState {
  NotSpecified,
  Error,
  Succeeded,
  Failed,
  Canceled,
  Connected,
  Disconnected,
  Deleted,
  Creating,
  Updating,
  Deleting,
  Moving,
  PartiallySucceeded,
  PartiallyConnected,
  InProgress,
  Accepted,
  Provisioning,
  DisableInProgress,
}

@doc("Aggregate state of Arc agent across the nodes in this HCI cluster.")
enum ArcSettingAggregateState {
  NotSpecified,
  Error,
  Succeeded,
  Canceled,
  Failed,
  Connected,
  Disconnected,
  Deleted,
  Creating,
  Updating,
  Deleting,
  Moving,
  PartiallySucceeded,
  PartiallyConnected,
  InProgress,
  Accepted,
  Provisioning,
  DisableInProgress,
}

@doc("State of Arc agent in this node.")
enum NodeArcState {
  NotSpecified,
  Error,
  Succeeded,
  Canceled,
  Failed,
  Connected,
  Disconnected,
  Deleted,
  Creating,
  Updating,
  Deleting,
  Moving,
  PartiallySucceeded,
  PartiallyConnected,
  InProgress,
  Accepted,
  Provisioning,
  DisableInProgress,
}

@doc("Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).")
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
}

@doc("Status of the Software Assurance for the cluster.")
enum SoftwareAssuranceStatus {
  Enabled,
  Disabled,
}

@doc("Customer Intent for Software Assurance Benefit.")
enum SoftwareAssuranceIntent {
  Enable,
  Disable,
}

@doc("Desired state of Windows Server Subscription.")
enum WindowsServerSubscription {
  Disabled,
  Enabled,
}

@doc("Desired level of diagnostic data emitted by the cluster.")
enum DiagnosticLevel {
  Off,
  Basic,
  Enhanced,
}

@doc("Type of the cluster node hardware.")
enum ClusterNodeType {
  FirstParty,
  ThirdParty,
}

@doc("IMDS attestation status of the cluster.")
enum ImdsAttestation {
  Disabled,
  Enabled,
}

@doc("Aggregate state of Arc Extensions across the nodes in this HCI cluster.")
enum ExtensionAggregateState {
  NotSpecified,
  Error,
  Succeeded,
  Canceled,
  Failed,
  Connected,
  Disconnected,
  Deleted,
  Creating,
  Updating,
  Deleting,
  Moving,
  PartiallySucceeded,
  PartiallyConnected,
  InProgress,
  Accepted,
  Provisioning,
  UpgradeFailedRollbackSucceeded,
}

@doc("State of Arc Extension in this node.")
enum NodeExtensionState {
  NotSpecified,
  Error,
  Succeeded,
  Canceled,
  Failed,
  Connected,
  Disconnected,
  Deleted,
  Creating,
  Updating,
  Deleting,
  Moving,
  PartiallySucceeded,
  PartiallyConnected,
  InProgress,
  Accepted,
  Provisioning,
}

@doc("State of the update run.")
enum UpdateRunPropertiesState {
  Unknown,
  Succeeded,
  InProgress,
  Failed,
}

enum HealthState {
  Unknown,
  Success,
  Failure,
  Warning,
  Error,
  InProgress,
}

@doc("Severity of the result (Critical, Warning, Informational, Hidden). This answers how important the result is. Critical is the only update-blocking severity.")
enum Severity {
  Critical,
  Warning,
  Informational,
  Hidden,
}

@doc("Overall update state of the stamp.")
enum UpdateSummariesPropertiesState {
  Unknown,
  AppliedSuccessfully,
  UpdateAvailable,
  UpdateInProgress,
  UpdateFailed,
  NeedsAttention,
  PreparationInProgress,
  PreparationFailed,
}

@doc("State of the update as it relates to this stamp.")
enum State {
  HasPrerequisite,
  Obsolete,
  Ready,
  NotApplicableBecauseAnotherUpdateIsInProgress,
  Preparing,
  Installing,
  Installed,
  PreparationFailed,
  InstallationFailed,
  Invalid,
  Recalled,
  Downloading,
  DownloadFailed,
  HealthChecking,
  HealthCheckFailed,
  ReadyToInstall,
  ScanInProgress,
  ScanFailed,
}

enum RebootRequirement {
  Unknown,
  True,
  False,
}

@doc("Indicates the way the update content can be downloaded.")
enum AvailabilityType {
  Local,
  Online,
  Notify,
}

@doc("Operating system type that the gallery image uses [Windows, Linux]")
@fixed
enum OperatingSystemTypes {
  Windows,
  Linux,
}

@doc("Type of the IP Pool [vm, vippool]")
@fixed
enum IPPoolTypeEnum {
  vm,
  vippool,
}

@doc("Properties under the gallery image resource")
model GalleryImageProperties {
  @doc("Storage ContainerID of the storage container to be used for gallery image")
  containerId?: ResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/storageContainers";
    }
  ]>;

  @doc("location of the image the gallery image should be created from")
  imagePath?: string;

  @doc("Operating system type that the gallery image uses [Windows, Linux]")
  osType: OperatingSystemTypes;

  @doc("Datasource for the gallery image when provisioning with cloud-init [NoCloud, Azure]")
  cloudInitDataSource?: CloudInitDataSource;

  @doc("The hypervisor generation of the Virtual Machine [V1, V2]")
  hyperVGeneration?: HyperVGeneration;

  @doc("This is the gallery image definition identifier.")
  identifier?: GalleryImageIdentifier;

  @doc("Specifies information about the gallery image version that you want to create or update.")
  version?: GalleryImageVersion;

  @doc("Provisioning state of the gallery image.")
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;

  @doc("The observed state of gallery images")
  @visibility("read")
  status?: GalleryImageStatus;
}

@doc("This is the gallery image definition identifier.")
model GalleryImageIdentifier {
  @doc("The name of the gallery image definition publisher.")
  publisher: string;

  @doc("The name of the gallery image definition offer.")
  offer: string;

  @doc("The name of the gallery image definition SKU.")
  sku: string;
}

@doc("Specifies information about the gallery image version that you want to create or update.")
model GalleryImageVersion {
  @doc("This is the version of the gallery image.")
  name?: string;

  @doc("Describes the properties of a gallery image version.")
  properties?: GalleryImageVersionProperties;
}

@doc("Describes the properties of a gallery image version.")
model GalleryImageVersionProperties {
  @doc("This is the storage profile of a Gallery Image Version.")
  storageProfile: GalleryImageVersionStorageProfile;
}

@doc("This is the storage profile of a Gallery Image Version.")
model GalleryImageVersionStorageProfile {
  @doc("This is the OS disk image.")
  osDiskImage?: GalleryOSDiskImage;
}

@doc("This is the OS disk image.")
model GalleryOSDiskImage extends GalleryDiskImage {}

@doc("This is the disk image base class.")
model GalleryDiskImage {
  @doc("This property indicates the size of the VHD to be created.")
  @visibility("read")
  sizeInMB?: int32;
}

@doc("The observed state of gallery images")
model GalleryImageStatus {
  @doc("GalleryImage provisioning error code")
  errorCode?: string;

  @doc("Descriptive error message")
  errorMessage?: string;

  provisioningStatus?: GalleryImageStatusProvisioningStatus;

  @doc("The download status of the gallery image")
  downloadStatus?: GalleryImageStatusDownloadStatus;

  @doc("The progress of the operation in percentage")
  progressPercentage?: int32;
}

model GalleryImageStatusProvisioningStatus {
  @doc("The ID of the operation performed on the gallery image")
  operationId?: string;

  @doc("The status of the operation performed on the gallery image [Succeeded, Failed, InProgress]")
  status?: Status;
}

@doc("The download status of the gallery image")
model GalleryImageStatusDownloadStatus {
  @doc("The downloaded sized of the image in MB")
  downloadSizeInMB?: int32;
}

@doc("The complex type of the extended location.")
model ExtendedLocation {
  @doc("The name of the extended location.")
  name?: string;

  @doc("The type of the extended location.")
  type?: ExtendedLocationTypes;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The gallery images resource patch definition.")
model GalleryImagesUpdateRequest {
  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("Properties under the logical network resource")
model LogicalNetworkProperties {
  @doc("DhcpOptions contains an array of DNS servers available to VMs deployed in the logical network. Standard DHCP option for a subnet overrides logical network DHCP options.")
  dhcpOptions?: LogicalNetworkPropertiesDhcpOptions;

  @doc("Subnet - list of subnets under the logical network")
  subnets?: Subnet[];

  @doc("Provisioning state of the logical network.")
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;

  @doc("name of the network switch to be used for VMs")
  vmSwitchName?: string;

  @doc("The observed state of logical networks")
  @visibility("read")
  status?: LogicalNetworkStatus;
}

@doc("DhcpOptions contains an array of DNS servers available to VMs deployed in the logical network. Standard DHCP option for a subnet overrides logical network DHCP options.")
model LogicalNetworkPropertiesDhcpOptions {
  @doc("The list of DNS servers IP addresses.")
  dnsServers?: string[];
}

model Subnet {
  @doc("Properties of the subnet.")
  properties?: SubnetPropertiesFormat;

  @doc("Name - The name of the resource that is unique within a resource group. This name can be used to access the resource.")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[_a-zA-Z0-9]$")
  name?: string;
}

@doc("Properties of the subnet.")
model SubnetPropertiesFormat {
  @doc("The address prefix for the subnet: Cidr for this subnet - IPv4, IPv6.")
  addressPrefix?: string;

  @doc("List of address prefixes for the subnet.")
  addressPrefixes?: string[];

  @doc("IPAllocationMethod - The IP address allocation method. Possible values include: 'Static', 'Dynamic'")
  ipAllocationMethod?: IpAllocationMethodEnum;

  @doc("IPConfigurationReferences - list of IPConfigurationReferences")
  ipConfigurationReferences?: SubnetPropertiesFormatIpConfigurationReferencesItem[];

  @doc("Route table resource.")
  routeTable?: RouteTable;

  @doc("network associated pool of IP Addresses")
  ipPools?: IPPool[];

  @doc("Vlan to use for the subnet")
  vlan?: int32;
}

@doc("IPConfigurationReference - Describes a IPConfiguration under the virtual network")
model SubnetPropertiesFormatIpConfigurationReferencesItem {
  @doc("IPConfigurationID")
  ID?: string;
}

@doc("Route table resource.")
model RouteTable {
  @doc("A unique read-only string that changes whenever the resource is updated.")
  @visibility("read")
  etag?: string;

  @doc("Resource name.")
  @visibility("read")
  name?: string;

  @doc("Resource type.")
  @visibility("read")
  type?: string;

  @doc("Properties of the route table.")
  properties?: RouteTablePropertiesFormat;
}

@doc("RouteTablePropertiesFormat - Route Table resource.")
model RouteTablePropertiesFormat {
  @doc("Collection of routes contained within a route table.")
  routes?: Route[];
}

@doc("Route - Route resource.")
model Route {
  @doc("Properties of the route.")
  properties?: RoutePropertiesFormat;

  @doc("Name - name of the subnet")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[_a-zA-Z0-9]$")
  name?: string;
}

@doc("RoutePropertiesFormat - Route resource.")
model RoutePropertiesFormat {
  @doc("The destination CIDR to which the route applies.")
  addressPrefix?: string;

  @doc("The IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance.")
  nextHopIpAddress?: string;
}

model IPPool {
  @doc("Name of the IP-Pool")
  name?: string;

  @doc("Type of the IP Pool [vm, vippool]")
  ipPoolType?: IPPoolTypeEnum;

  @doc("Start of the IP address pool")
  start?: string;

  @doc("End of the IP address pool")
  end?: string;

  info?: IPPoolInfo;
}

model IPPoolInfo {
  @doc("Number of IP addresses allocated from the IP Pool")
  @visibility("read")
  used?: string;

  @doc("Number of IP addresses available in the IP Pool")
  @visibility("read")
  available?: string;
}

@doc("The observed state of logical networks")
model LogicalNetworkStatus {
  @doc("LogicalNetwork provisioning error code")
  errorCode?: string;

  @doc("Descriptive error message")
  errorMessage?: string;

  provisioningStatus?: LogicalNetworkStatusProvisioningStatus;
}

model LogicalNetworkStatusProvisioningStatus {
  @doc("The ID of the operation performed on the logical network")
  operationId?: string;

  @doc("The status of the operation performed on the logical network [Succeeded, Failed, InProgress]")
  status?: Status;
}

@doc("The logical network resource patch definition.")
model LogicalNetworksUpdateRequest {
  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("Properties under the marketplace gallery image resource")
model MarketplaceGalleryImageProperties {
  @doc("Storage ContainerID of the storage container to be used for marketplace gallery image")
  containerId?: ResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/storageContainers";
    }
  ]>;

  @doc("Operating system type that the gallery image uses [Windows, Linux]")
  osType: OperatingSystemTypes;

  @doc("Datasource for the gallery image when provisioning with cloud-init [NoCloud, Azure]")
  cloudInitDataSource?: CloudInitDataSource;

  @doc("The hypervisor generation of the Virtual Machine [V1, V2]")
  hyperVGeneration?: HyperVGeneration;

  @doc("This is the gallery image definition identifier.")
  identifier?: GalleryImageIdentifier;

  @doc("Specifies information about the gallery image version that you want to create or update.")
  version?: GalleryImageVersion;

  @doc("Provisioning state of the marketplace gallery image.")
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;

  @doc("The observed state of marketplace gallery images")
  @visibility("read")
  status?: MarketplaceGalleryImageStatus;
}

@doc("The observed state of marketplace gallery images")
model MarketplaceGalleryImageStatus {
  @doc("MarketplaceGalleryImage provisioning error code")
  errorCode?: string;

  @doc("Descriptive error message")
  errorMessage?: string;

  provisioningStatus?: MarketplaceGalleryImageStatusProvisioningStatus;

  @doc("The download status of the gallery image")
  downloadStatus?: MarketplaceGalleryImageStatusDownloadStatus;

  @doc("The progress of the operation in percentage")
  progressPercentage?: int32;
}

model MarketplaceGalleryImageStatusProvisioningStatus {
  @doc("The ID of the operation performed on the gallery image")
  operationId?: string;

  @doc("The status of the operation performed on the gallery image [Succeeded, Failed, InProgress]")
  status?: Status;
}

@doc("The download status of the gallery image")
model MarketplaceGalleryImageStatusDownloadStatus {
  @doc("The downloaded sized of the image in MB")
  downloadSizeInMB?: int32;
}

@doc("The marketplace gallery image resource patch definition.")
model MarketplaceGalleryImagesUpdateRequest {
  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("Properties under the network interface resource")
model NetworkInterfaceProperties {
  @doc("IPConfigurations - A list of IPConfigurations of the network interface.")
  ipConfigurations?: IPConfiguration[];

  @doc("MacAddress - The MAC address of the network interface.")
  macAddress?: string;

  @doc("DNS Settings for the interface")
  dnsSettings?: InterfaceDNSSettings;

  @doc("Provisioning state of the network interface.")
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;

  @doc("The observed state of network interfaces")
  @visibility("read")
  status?: NetworkInterfaceStatus;
}

@doc("InterfaceIPConfiguration iPConfiguration in a network interface.")
model IPConfiguration {
  @doc("Name - The name of the resource that is unique within a resource group. This name can be used to access the resource.")
  @visibility("read", "create")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[_a-zA-Z0-9]$")
  name?: string;

  @doc("InterfaceIPConfigurationPropertiesFormat properties of IP configuration.")
  properties?: IPConfigurationProperties;
}

@doc("InterfaceIPConfigurationPropertiesFormat properties of IP configuration.")
model IPConfigurationProperties {
  @doc("Gateway for network interface")
  @visibility("read")
  gateway?: string;

  @doc("prefixLength for network interface")
  @visibility("read")
  prefixLength?: string;

  @doc("PrivateIPAddress - Private IP address of the IP configuration.")
  privateIPAddress?: string;

  @doc("Subnet - Name of Subnet bound to the IP configuration.")
  subnet?: IPConfigurationPropertiesSubnet;
}

@doc("Subnet - Name of Subnet bound to the IP configuration.")
model IPConfigurationPropertiesSubnet {
  @doc("ID - The ARM resource id in the form of /subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/...")
  id?: string;
}

model InterfaceDNSSettings {
  @doc("List of DNS server IP Addresses for the interface")
  dnsServers?: string[];
}

@doc("The observed state of network interfaces")
model NetworkInterfaceStatus {
  @doc("NetworkInterface provisioning error code")
  errorCode?: string;

  @doc("Descriptive error message")
  errorMessage?: string;

  provisioningStatus?: NetworkInterfaceStatusProvisioningStatus;
}

model NetworkInterfaceStatusProvisioningStatus {
  @doc("The ID of the operation performed on the network interface")
  operationId?: string;

  @doc("The status of the operation performed on the network interface [Succeeded, Failed, InProgress]")
  status?: Status;
}

@doc("The network interface resource patch definition.")
model NetworkInterfacesUpdateRequest {
  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("Properties under the storage container resource")
model StorageContainerProperties {
  @doc("Path of the storage container on the disk")
  path: string;

  @doc("Provisioning state of the storage container.")
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;

  @doc("The observed state of storage containers")
  @visibility("read")
  status?: StorageContainerStatus;
}

@doc("The observed state of storage containers")
model StorageContainerStatus {
  @doc("StorageContainer provisioning error code")
  errorCode?: string;

  @doc("Descriptive error message")
  errorMessage?: string;

  @doc("Amount of space available on the disk in MB")
  availableSizeMB?: int32;

  @doc("Total size of the disk in MB")
  containerSizeMB?: int32;

  provisioningStatus?: StorageContainerStatusProvisioningStatus;
}

model StorageContainerStatusProvisioningStatus {
  @doc("The ID of the operation performed on the storage container")
  operationId?: string;

  @doc("The status of the operation performed on the storage container [Succeeded, Failed, InProgress]")
  status?: Status;
}

@doc("The storage container resource patch definition.")
model StorageContainersUpdateRequest {
  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("Properties under the virtual hard disk resource")
model VirtualHardDiskProperties {
  blockSizeBytes?: int32;

  @doc("Size of the disk in GB")
  diskSizeGB?: int32;

  @doc("Boolean for enabling dynamic sizing on the virtual hard disk")
  dynamic?: boolean;

  logicalSectorBytes?: int32;
  physicalSectorBytes?: int32;

  @doc("The hypervisor generation of the Virtual Machine [V1, V2]")
  hyperVGeneration?: HyperVGeneration;

  @doc("The format of the actual VHD file [vhd, vhdx]")
  diskFileFormat?: DiskFileFormat;

  @doc("Provisioning state of the virtual hard disk.")
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;

  @doc("Storage ContainerID of the storage container to be used for VHD")
  containerId?: ResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/storageContainers";
    }
  ]>;

  @doc("The observed state of virtual hard disks")
  @visibility("read")
  status?: VirtualHardDiskStatus;
}

@doc("The observed state of virtual hard disks")
model VirtualHardDiskStatus {
  @doc("VirtualHardDisk provisioning error code")
  errorCode?: string;

  @doc("Descriptive error message")
  errorMessage?: string;

  provisioningStatus?: VirtualHardDiskStatusProvisioningStatus;
}

model VirtualHardDiskStatusProvisioningStatus {
  @doc("The ID of the operation performed on the virtual hard disk")
  operationId?: string;

  @doc("The status of the operation performed on the virtual hard disk [Succeeded, Failed, InProgress]")
  status?: Status;
}

@doc("The virtual hard disk resource patch definition.")
model VirtualHardDisksUpdateRequest {
  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("Properties under the virtual machine instance resource")
model VirtualMachineInstanceProperties {
  @doc("HardwareProfile - Specifies the hardware settings for the virtual machine instance.")
  hardwareProfile?: VirtualMachineInstancePropertiesHardwareProfile;

  @doc("NetworkProfile - describes the network configuration the virtual machine instance")
  networkProfile?: VirtualMachineInstancePropertiesNetworkProfile;

  @doc("OsProfile - describes the configuration of the operating system and sets login data")
  osProfile?: VirtualMachineInstancePropertiesOsProfile;

  @doc("SecurityProfile - Specifies the security settings for the virtual machine instance.")
  securityProfile?: VirtualMachineInstancePropertiesSecurityProfile;

  @doc("StorageProfile - contains information about the disks and storage information for the virtual machine instance")
  storageProfile?: VirtualMachineInstancePropertiesStorageProfile;

  @doc("HTTP Proxy configuration for the VM.")
  httpProxyConfig?: HttpProxyConfiguration;

  @doc("Provisioning state of the virtual machine instance.")
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;

  @doc("The virtual machine instance view.")
  @visibility("read")
  instanceView?: VirtualMachineInstanceView;

  @doc("The observed state of virtual machine instances")
  @visibility("read")
  status?: VirtualMachineInstanceStatus;

  @doc("Guest agent install status.")
  guestAgentInstallStatus?: GuestAgentInstallStatus;

  @doc("Unique identifier for the vm resource.")
  @visibility("read")
  vmId?: string;

  @doc("Unique identifier defined by ARC to identify the guest of the VM.")
  resourceUid?: string;
}

@doc("HardwareProfile - Specifies the hardware settings for the virtual machine instance.")
model VirtualMachineInstancePropertiesHardwareProfile {
  vmSize?: VmSizeEnum;

  @doc("number of processors for the virtual machine instance")
  processors?: int32;

  @doc("RAM in MB for the virtual machine instance")
  memoryMB?: int32;

  dynamicMemoryConfig?: VirtualMachineInstancePropertiesHardwareProfileDynamicMemoryConfig;
}

model VirtualMachineInstancePropertiesHardwareProfileDynamicMemoryConfig {
  maximumMemoryMB?: int32;
  minimumMemoryMB?: int32;

  @doc("Defines the amount of extra memory that should be reserved for a virtual machine instance at runtime, as a percentage of the total memory that the virtual machine instance is thought to need. This only applies to virtual systems with dynamic memory enabled. This property can be in the range of 5 to 2000.")
  targetMemoryBuffer?: int32;
}

@doc("NetworkProfile - describes the network configuration the virtual machine instance")
model VirtualMachineInstancePropertiesNetworkProfile {
  @doc("NetworkInterfaces - list of network interfaces to be attached to the virtual machine instance")
  networkInterfaces?: VirtualMachineInstancePropertiesNetworkProfileNetworkInterfacesItem[];
}

model VirtualMachineInstancePropertiesNetworkProfileNetworkInterfacesItem {
  @doc("ID - Resource Id of the network interface")
  id?: string;
}

@doc("OsProfile - describes the configuration of the operating system and sets login data")
model VirtualMachineInstancePropertiesOsProfile {
  @doc("AdminPassword - admin password")
  @visibility("create")
  adminPassword?: string;

  @doc("AdminUsername - admin username")
  adminUsername?: string;

  @doc("ComputerName - name of the compute")
  computerName?: string;

  @doc("LinuxConfiguration - linux specific configuration values for the virtual machine instance")
  linuxConfiguration?: VirtualMachineInstancePropertiesOsProfileLinuxConfiguration;

  @doc("Windows Configuration for the virtual machine instance ")
  windowsConfiguration?: VirtualMachineInstancePropertiesOsProfileWindowsConfiguration;
}

@doc("LinuxConfiguration - linux specific configuration values for the virtual machine instance")
model VirtualMachineInstancePropertiesOsProfileLinuxConfiguration {
  @doc("DisablePasswordAuthentication - whether password authentication should be disabled")
  disablePasswordAuthentication?: boolean;

  @doc("Specifies the ssh key configuration for a Linux OS.")
  ssh?: SshConfiguration;

  @doc("Used to indicate whether Arc for Servers agent onboarding should be triggered during the virtual machine instance creation process.")
  provisionVMAgent?: boolean;

  @doc("Used to indicate whether the VM Config Agent should be installed during the virtual machine creation process.")
  provisionVMConfigAgent?: boolean;
}

@doc("SSH configuration for Linux based VMs running on Azure")
model SshConfiguration {
  @doc("The list of SSH public keys used to authenticate with linux based VMs.")
  publicKeys?: SshPublicKey[];
}

@doc("Contains information about SSH certificate public key and the path on the Linux VM where the public key is placed.")
model SshPublicKey {
  @doc("Specifies the full path on the created VM where ssh public key is stored. If the file already exists, the specified key is appended to the file. Example: /home/user/.ssh/authorized_keys")
  path?: string;

  @doc("SSH public key certificate used to authenticate with the VM through ssh. The key needs to be at least 2048-bit and in ssh-rsa format. <br><br> For creating ssh keys, see [Create SSH keys on Linux and Mac for Linux VMs in Azure]https://docs.microsoft.com/azure/virtual-machines/linux/create-ssh-keys-detailed).")
  keyData?: string;
}

@doc("Windows Configuration for the virtual machine instance ")
model VirtualMachineInstancePropertiesOsProfileWindowsConfiguration {
  @doc("Whether to EnableAutomaticUpdates on the machine")
  enableAutomaticUpdates?: boolean;

  @doc("Specifies the ssh key configuration for Windows OS.")
  ssh?: SshConfiguration;

  @doc("TimeZone for the virtual machine instance")
  timeZone?: string;

  @doc("Used to indicate whether Arc for Servers agent onboarding should be triggered during the virtual machine instance creation process.")
  provisionVMAgent?: boolean;

  @doc("Used to indicate whether the VM Config Agent should be installed during the virtual machine creation process.")
  provisionVMConfigAgent?: boolean;
}

@doc("SecurityProfile - Specifies the security settings for the virtual machine instance.")
model VirtualMachineInstancePropertiesSecurityProfile {
  enableTPM?: boolean;
  uefiSettings?: VirtualMachineInstancePropertiesSecurityProfileUefiSettings;

  @doc("Specifies the SecurityType of the virtual machine. EnableTPM and SecureBootEnabled must be set to true for SecurityType to function.")
  securityType?: SecurityTypes;
}

model VirtualMachineInstancePropertiesSecurityProfileUefiSettings {
  @doc("Specifies whether secure boot should be enabled on the virtual machine instance.")
  secureBootEnabled?: boolean;
}

@doc("StorageProfile - contains information about the disks and storage information for the virtual machine instance")
model VirtualMachineInstancePropertiesStorageProfile {
  @doc("adds data disks to the virtual machine instance")
  dataDisks?: VirtualMachineInstancePropertiesStorageProfileDataDisksItem[];

  @doc("Which Image to use for the virtual machine instance")
  imageReference?: VirtualMachineInstancePropertiesStorageProfileImageReference;

  @doc("VHD to attach as OS disk")
  osDisk?: VirtualMachineInstancePropertiesStorageProfileOsDisk;

  @doc("Id of the storage container that hosts the VM configuration file")
  vmConfigStoragePathId?: ResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/storageContainers";
    }
  ]>;
}

model VirtualMachineInstancePropertiesStorageProfileDataDisksItem {
  @doc("Resource ID of the data disk")
  id?: string;
}

@doc("Which Image to use for the virtual machine instance")
model VirtualMachineInstancePropertiesStorageProfileImageReference {
  @doc("Resource ID of the image")
  @visibility("read", "create")
  id?: string;
}

@doc("VHD to attach as OS disk")
model VirtualMachineInstancePropertiesStorageProfileOsDisk {
  @doc("Resource ID of the OS disk")
  id?: string;

  @doc("This property allows you to specify the type of the OS that is included in the disk if creating a VM from user-image or a specialized VHD. Possible values are: **Windows,** **Linux.**")
  osType?: OperatingSystemTypes;
}

@doc("HTTP Proxy configuration for the VM.")
model HttpProxyConfiguration {
  @doc("The HTTP proxy server endpoint to use.")
  httpProxy?: string;

  @doc("The HTTPS proxy server endpoint to use.")
  httpsProxy?: string;

  @doc("The endpoints that should not go through proxy.")
  noProxy?: string[];

  @doc("Alternative CA cert to use for connecting to proxy servers.")
  trustedCa?: string;
}

@doc("The instance view of a virtual machine.")
model VirtualMachineInstanceView {
  @doc("The VM Config Agent running on the virtual machine.")
  vmAgent?: VirtualMachineConfigAgentInstanceView;
}

@doc("The instance view of the VM Config Agent running on the virtual machine.")
model VirtualMachineConfigAgentInstanceView {
  @doc("The VM Config Agent full version.")
  vmConfigAgentVersion?: string;

  @doc("The resource status information.")
  statuses?: InstanceViewStatus[];
}

@doc("Instance view status.")
model InstanceViewStatus {
  @doc("The status code.")
  code?: string;

  @doc("The level code.")
  level?: StatusLevelTypes;

  @doc("The short localizable label for the status.")
  displayStatus?: string;

  @doc("The detailed status message, including for alerts and error messages.")
  message?: string;

  @doc("The time of the status.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;
}

@doc("The observed state of virtual machine instances")
model VirtualMachineInstanceStatus {
  @doc("VirtualMachine provisioning error code")
  errorCode?: string;

  @doc("Descriptive error message")
  errorMessage?: string;

  @doc("The power state of the virtual machine instance")
  powerState?: PowerStateEnum;

  provisioningStatus?: VirtualMachineInstanceStatusProvisioningStatus;
}

model VirtualMachineInstanceStatusProvisioningStatus {
  @doc("The ID of the operation performed on the virtual machine instance")
  operationId?: string;

  @doc("The status of the operation performed on the virtual machine instance [Succeeded, Failed, InProgress]")
  status?: Status;
}

@doc("Defines the status of a guest agent installation.")
model GuestAgentInstallStatus {
  @doc("Specifies the VM's unique SMBIOS ID.")
  @visibility("read")
  vmUuid?: string;

  @doc("The installation status of the hybrid machine agent installation.")
  @visibility("read")
  status?: StatusTypes;

  @doc("The time of the last status change.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStatusChange?: utcDateTime;

  @doc("The hybrid machine agent full version.")
  @visibility("read")
  agentVersion?: string;

  @doc("Details about the error state.")
  @visibility("read")
  errorDetails?: ErrorDetail[];
}

@doc("Identity for the resource.")
model Identity {
  @doc("The principal ID of resource identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID of resource.")
  @visibility("read")
  tenantId?: string;

  @doc("The identity type.")
  type?: "SystemAssigned";
}

@doc("The virtual machine instance resource patch definition.")
model VirtualMachineInstanceUpdateRequest {
  @doc("Defines the resource properties for the update.")
  properties?: VirtualMachineInstanceUpdateProperties;

  @doc("Identity for the resource.")
  identity?: Identity;
}

@doc("Defines the resource properties for the update.")
model VirtualMachineInstanceUpdateProperties {
  @doc("HardwareProfile - Specifies the hardware settings for the virtual machine instance.")
  hardwareProfile?: HardwareProfileUpdate;

  storageProfile?: StorageProfileUpdate;

  @doc("NetworkProfile - describes the network update configuration the virtual machine instance")
  networkProfile?: NetworkProfileUpdate;

  @doc("OsProfile - describes the update configuration of the operating system")
  osProfile?: OsProfileUpdate;
}

@doc("HardwareProfile - Specifies the hardware settings for the virtual machine instance.")
model HardwareProfileUpdate {
  vmSize?: VmSizeEnum;

  @doc("number of processors for the virtual machine instance")
  processors?: int32;

  @doc("RAM in MB for the virtual machine instance")
  memoryMB?: int32;
}

model StorageProfileUpdate {
  @doc("adds data disks to the virtual machine instance for the update call")
  dataDisks?: StorageProfileUpdateDataDisksItem[];
}

model StorageProfileUpdateDataDisksItem {
  id?: string;
}

@doc("NetworkProfile - describes the network update configuration the virtual machine instance")
model NetworkProfileUpdate {
  @doc("NetworkInterfaces - list of network interfaces to be attached to the virtual machine instance")
  networkInterfaces?: NetworkProfileUpdateNetworkInterfacesItem[];
}

model NetworkProfileUpdateNetworkInterfacesItem {
  @doc("ID - Resource ID of the network interface")
  id?: string;
}

@doc("OsProfile - describes the update configuration of the operating system")
model OsProfileUpdate {
  @doc("ComputerName - name of the computer")
  computerName?: string;

  linuxConfiguration?: OsProfileUpdateLinuxConfiguration;
  windowsConfiguration?: OsProfileUpdateWindowsConfiguration;
}

model OsProfileUpdateLinuxConfiguration {
  @doc("Used to indicate whether Arc for Servers agent onboarding should be triggered during the virtual machine instance creation process.")
  provisionVMAgent?: boolean;

  @doc("Used to indicate whether the VM Config Agent should be installed during the virtual machine creation process.")
  provisionVMConfigAgent?: boolean;
}

model OsProfileUpdateWindowsConfiguration {
  @doc("Used to indicate whether Arc for Servers agent onboarding should be triggered during the virtual machine instance creation process.")
  provisionVMAgent?: boolean;

  @doc("Used to indicate whether the VM Config Agent should be installed during the virtual machine creation process.")
  provisionVMConfigAgent?: boolean;
}

@doc("Defines the resource properties.")
model HybridIdentityMetadataProperties {
  @doc("The unique identifier for the resource.")
  resourceUid?: string;

  @doc("The Public Key.")
  publicKey?: string;

  @doc("Identity for the resource.")
  @visibility("read")
  identity?: Identity;

  @doc("The provisioning state.")
  @visibility("read")
  provisioningState?: string;
}

@doc("Defines the resource properties.")
model GuestAgentProperties {
  @doc("Username / Password Credentials to provision guest agent.")
  credentials?: GuestCredential;

  @doc("The guest agent provisioning action.")
  provisioningAction?: ProvisioningAction;

  @doc("The guest agent status.")
  @visibility("read")
  status?: string;

  @doc("The provisioning state.")
  @visibility("read")
  provisioningState?: string;
}

@doc("Username / Password Credentials to connect to guest.")
model GuestCredential {
  @doc("The username to connect with the guest.")
  username?: string;

  @doc("The password to connect with the guest.")
  @visibility("create", "update")
  password?: string;
}

@doc("ArcSetting properties.")
model ArcSettingProperties {
  @doc("Provisioning state of the ArcSetting proxy resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The resource group that hosts the Arc agents, ie. Hybrid Compute Machine resources.")
  arcInstanceResourceGroup?: string;

  @doc("App id of arc AAD identity.")
  arcApplicationClientId?: string;

  @doc("Tenant id of arc AAD identity.")
  arcApplicationTenantId?: string;

  @doc("Object id of arc AAD service principal.")
  arcServicePrincipalObjectId?: string;

  @doc("Object id of arc AAD identity.")
  arcApplicationObjectId?: string;

  @doc("Aggregate state of Arc agent across the nodes in this HCI cluster.")
  @visibility("read")
  aggregateState?: ArcSettingAggregateState;

  @doc("State of Arc agent in each of the nodes.")
  @visibility("read")
  perNodeDetails?: PerNodeState[];

  @doc("contains connectivity related configuration for ARC resources")
  connectivityProperties?: Record<unknown>;
}

@doc("Status of Arc agent for a particular node in HCI Cluster.")
model PerNodeState {
  @doc("Name of the Node in HCI Cluster")
  @visibility("read")
  name?: string;

  @doc("Fully qualified resource ID for the Arc agent of this node.")
  @visibility("read")
  arcInstance?: string;

  @doc("State of Arc agent in this node.")
  @visibility("read")
  state?: NodeArcState;
}

@doc("ArcSetting details to update.")
model ArcSettingsPatch {
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("ArcSettings properties.")
  properties?: ArcSettingsPatchProperties;
}

@doc("ArcSettings properties.")
model ArcSettingsPatchProperties {
  @doc("contains connectivity related configuration for ARC resources")
  connectivityProperties?: Record<unknown>;
}

model PasswordCredential {
  secretText?: string;
  keyId?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTime?: utcDateTime;
}

@doc("ArcIdentity details.")
model ArcIdentityResponse {
  @doc("ArcIdentity properties.")
  @visibility("read")
  properties?: ArcIdentityResponseProperties;
}

model ArcIdentityResponseProperties {
  arcApplicationClientId?: string;
  arcApplicationTenantId?: string;
  arcServicePrincipalObjectId?: string;
  arcApplicationObjectId?: string;
}

@doc("Cluster properties.")
model ClusterProperties {
  @doc("Provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Status of the cluster agent.")
  @visibility("read")
  status?: Status;

  @doc("Unique, immutable resource id.")
  @visibility("read")
  cloudId?: string;

  @doc("Endpoint configured for management from the Azure portal.")
  cloudManagementEndpoint?: string;

  @doc("App id of cluster AAD identity.")
  aadClientId?: string;

  @doc("Tenant id of cluster AAD identity.")
  aadTenantId?: string;

  @doc("Object id of cluster AAD identity.")
  aadApplicationObjectId?: string;

  @doc("Id of cluster identity service principal.")
  aadServicePrincipalObjectId?: string;

  @doc("Software Assurance properties of the cluster.")
  softwareAssuranceProperties?: SoftwareAssuranceProperties;

  @doc("Desired properties of the cluster.")
  desiredProperties?: ClusterDesiredProperties;

  @doc("Properties reported by cluster agent.")
  @visibility("read")
  reportedProperties?: ClusterReportedProperties;

  @doc("Number of days remaining in the trial period.")
  @visibility("read")
  trialDaysRemaining?: float32;

  @doc("Type of billing applied to the resource.")
  @visibility("read")
  billingModel?: string;

  @doc("First cluster sync timestamp.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  registrationTimestamp?: utcDateTime;

  @doc("Most recent cluster sync timestamp.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncTimestamp?: utcDateTime;

  @doc("Most recent billing meter timestamp.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastBillingTimestamp?: utcDateTime;

  @doc("Region specific DataPath Endpoint of the cluster.")
  @visibility("read")
  serviceEndpoint?: string;

  @doc("Object id of RP Service Principal")
  @visibility("read")
  resourceProviderObjectId?: string;
}

@doc("Software Assurance properties of the cluster.")
model SoftwareAssuranceProperties {
  @doc("Status of the Software Assurance for the cluster.")
  softwareAssuranceStatus?: SoftwareAssuranceStatus;

  @doc("Customer Intent for Software Assurance Benefit.")
  softwareAssuranceIntent?: SoftwareAssuranceIntent;

  @doc("TimeStamp denoting the latest SA benefit applicability is validated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;
}

@doc("Desired properties of the cluster.")
model ClusterDesiredProperties {
  @doc("Desired state of Windows Server Subscription.")
  windowsServerSubscription?: WindowsServerSubscription;

  @doc("Desired level of diagnostic data emitted by the cluster.")
  diagnosticLevel?: DiagnosticLevel;
}

@doc("Properties reported by cluster agent.")
model ClusterReportedProperties {
  @doc("Name of the on-prem cluster connected to this resource.")
  @visibility("read")
  clusterName?: string;

  @doc("Unique id generated by the on-prem cluster.")
  @visibility("read")
  clusterId?: string;

  @doc("Version of the cluster software.")
  @visibility("read")
  clusterVersion?: string;

  @doc("List of nodes reported by the cluster.")
  @visibility("read")
  nodes?: ClusterNode[];

  @doc("Last time the cluster reported the data.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  @doc("IMDS attestation status of the cluster.")
  @visibility("read")
  imdsAttestation?: ImdsAttestation;

  @doc("Level of diagnostic data emitted by the cluster.")
  diagnosticLevel?: DiagnosticLevel;

  @doc("Capabilities supported by the cluster.")
  @visibility("read")
  supportedCapabilities?: string[];
}

@doc("Cluster node details.")
model ClusterNode {
  @doc("Name of the cluster node.")
  @visibility("read")
  name?: string;

  @doc("Id of the node in the cluster.")
  @visibility("read")
  id?: float32;

  @doc("State of Windows Server Subscription.")
  @visibility("read")
  windowsServerSubscription?: WindowsServerSubscription;

  @doc("Type of the cluster node hardware.")
  @visibility("read")
  nodeType?: ClusterNodeType;

  @doc("Edge Hardware Center Resource Id")
  @visibility("read")
  ehcResourceId?: string;

  @doc("Manufacturer of the cluster node hardware.")
  @visibility("read")
  manufacturer?: string;

  @doc("Model name of the cluster node hardware.")
  @visibility("read")
  `model`?: string;

  @doc("Operating system running on the cluster node.")
  @visibility("read")
  osName?: string;

  @doc("Version of the operating system running on the cluster node.")
  @visibility("read")
  osVersion?: string;

  @doc("Display version of the operating system running on the cluster node.")
  @visibility("read")
  osDisplayVersion?: string;

  @doc("Immutable id of the cluster node.")
  @visibility("read")
  serialNumber?: string;

  @doc("Number of physical cores on the cluster node.")
  @visibility("read")
  coreCount?: float32;

  @doc("Total available memory on the cluster node (in GiB).")
  @visibility("read")
  memoryInGiB?: float32;

  @doc("Most recent licensing timestamp.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastLicensingTimestamp?: utcDateTime;
}

@doc("Cluster details to update.")
model ClusterPatch {
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("Identity of Cluster resource")
  identity?: ManagedServiceIdentity;

  @doc("Cluster properties.")
  properties?: ClusterPatchProperties;
}

@doc("Cluster properties.")
model ClusterPatchProperties {
  @doc("Endpoint configured for management from the Azure portal")
  cloudManagementEndpoint?: string;

  @doc("App id of cluster AAD identity.")
  aadClientId?: string;

  @doc("Tenant id of cluster AAD identity.")
  aadTenantId?: string;

  @doc("Desired properties of the cluster.")
  desiredProperties?: ClusterDesiredProperties;
}

model UploadCertificateRequest {
  properties?: RawCertificateData;
}

model RawCertificateData {
  certificates?: string[];
}

@doc("Cluster Identity details.")
model ClusterIdentityResponse {
  @doc("Cluster identity properties.")
  @visibility("read")
  properties?: ClusterIdentityResponseProperties;
}

model ClusterIdentityResponseProperties {
  aadClientId?: string;
  aadTenantId?: string;
  aadServicePrincipalObjectId?: string;
  aadApplicationObjectId?: string;
}

model SoftwareAssuranceChangeRequest {
  properties?: SoftwareAssuranceChangeRequestProperties;
}

model SoftwareAssuranceChangeRequestProperties {
  @doc("Customer Intent for Software Assurance Benefit.")
  softwareAssuranceIntent?: SoftwareAssuranceIntent;
}

@doc("Status of Arc Extension for a particular node in HCI Cluster.")
model ExtensionProperties {
  @doc("Provisioning state of the Extension proxy resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Parameters specific to this extension type.")
  extensionParameters?: ExtensionParameters;

  @doc("Aggregate state of Arc Extensions across the nodes in this HCI cluster.")
  @visibility("read")
  aggregateState?: ExtensionAggregateState;

  @doc("State of Arc Extension in each of the nodes.")
  @visibility("read")
  perNodeExtensionDetails?: PerNodeExtensionState[];
}

@doc("Describes the properties of a Machine Extension. This object mirrors the definition in HybridCompute.")
model ExtensionParameters {
  @doc("How the extension handler should be forced to update even if the extension configuration has not changed.")
  forceUpdateTag?: string;

  @doc("The name of the extension handler publisher.")
  publisher?: string;

  @doc("Specifies the type of the extension; an example is \"CustomScriptExtension\".")
  type?: string;

  @doc("Specifies the version of the script handler. Latest version would be used if not specified.")
  typeHandlerVersion?: string;

  @doc("Indicates whether the extension should use a newer minor version if one is available at deployment time. Once deployed, however, the extension will not upgrade minor versions unless redeployed, even with this property set to true.")
  autoUpgradeMinorVersion?: boolean;

  @doc("Json formatted public settings for the extension.")
  settings?: Record<unknown>;

  @doc("Protected settings (may contain secrets).")
  protectedSettings?: Record<unknown>;

  @doc("Indicates whether the extension should be automatically upgraded by the platform if there is a newer version available.")
  enableAutomaticUpgrade?: boolean;
}

@doc("Status of Arc Extension for a particular node in HCI Cluster.")
model PerNodeExtensionState {
  @doc("Name of the node in HCI Cluster.")
  @visibility("read")
  name?: string;

  @doc("Fully qualified resource ID for the particular Arc Extension on this node.")
  @visibility("read")
  extension?: string;

  @doc("Specifies the version of the script handler.")
  @visibility("read")
  typeHandlerVersion?: string;

  @doc("State of Arc Extension in this node.")
  @visibility("read")
  state?: NodeExtensionState;

  @doc("The extension instance view.")
  @visibility("read")
  instanceView?: ExtensionInstanceView;
}

@doc("Describes the Extension Instance View.")
model ExtensionInstanceView {
  @doc("The extension name.")
  name?: string;

  @doc("Specifies the type of the extension; an example is \"MicrosoftMonitoringAgent\".")
  type?: string;

  @doc("Specifies the version of the script handler.")
  typeHandlerVersion?: string;

  @doc("Instance view status.")
  status?: ExtensionInstanceViewStatus;
}

@doc("Instance view status.")
model ExtensionInstanceViewStatus {
  @doc("The status code.")
  code?: string;

  @doc("The level code.")
  level?: StatusLevelTypes;

  @doc("The short localizable label for the status.")
  displayStatus?: string;

  @doc("The detailed status message, including for alerts and error messages.")
  message?: string;

  @doc("The time of the status.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;
}

@doc("Describes the parameters for Extension upgrade.")
model ExtensionUpgradeParameters {
  @doc("Extension Upgrade Target Version.")
  targetVersion?: string;
}

@doc("Publisher properties.")
model OfferProperties {
  @doc("Provisioning State")
  @visibility("read")
  provisioningState?: string;

  @doc("Identifier of the Publisher for the offer")
  publisherId?: string;

  @doc("JSON serialized catalog content of the offer")
  content?: string;

  @doc("The API version of the catalog service used to serve the catalog content")
  contentVersion?: string;

  @doc("Array of SKU mappings")
  skuMappings?: SkuMappings[];
}

@doc("SKU Mapping details.")
model SkuMappings {
  @doc("Identifier of the CatalogPlan for the sku")
  catalogPlanId?: string;

  @doc("Identifier for the sku")
  marketplaceSkuId?: string;

  @doc("Array of SKU versions available")
  marketplaceSkuVersions?: string[];
}

@doc("Publisher properties.")
model PublisherProperties {
  @doc("Provisioning State")
  @visibility("read")
  provisioningState?: string;
}

@doc("SKU properties.")
model SkuProperties {
  @doc("Provisioning State")
  @visibility("read")
  provisioningState?: string;

  @doc("Identifier of the Publisher for the offer")
  publisherId?: string;

  @doc("Identifier of the Offer for the sku")
  offerId?: string;

  @doc("JSON serialized catalog content of the sku offer")
  content?: string;

  @doc("The API version of the catalog service used to serve the catalog content")
  contentVersion?: string;

  @doc("Array of SKU mappings")
  skuMappings?: SkuMappings[];
}

@doc("Details of an Update run")
model UpdateRunProperties {
  @doc("Provisioning state of the UpdateRuns proxy resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Timestamp of the update run was started.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeStarted?: utcDateTime;

  @doc("Timestamp of the most recently completed step in the update run.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  @doc("Duration of the update run.")
  duration?: string;

  @doc("State of the update run.")
  state?: UpdateRunPropertiesState;

  @doc("Progress representation of the update run steps.")
  progress?: Step;
}

@doc("Progress representation of the update run steps.")
model Step {
  @doc("Name of the step.")
  name?: string;

  @doc("More detailed description of the step.")
  description?: string;

  @doc("Error message, specified if the step is in a failed state.")
  errorMessage?: string;

  @doc("Status of the step, bubbled up from the ECE action plan for installation attempts. Values are: 'Success', 'Error', 'InProgress', and 'Unknown status'.")
  status?: string;

  @doc("When the step started, or empty if it has not started executing.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  @doc("When the step reached a terminal state.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc?: utcDateTime;

  @doc("Completion time of this step or the last completed sub-step.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTimeUtc?: utcDateTime;

  @doc("Recursive model for child steps of this step.")
  steps?: Step[];
}

@doc("Properties of Update summaries")
model UpdateSummariesProperties {
  @doc("Provisioning state of the UpdateSummaries proxy resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("OEM family name.")
  oemFamily?: string;

  @doc("Name of the hardware model.")
  hardwareModel?: string;

  @doc("Current version of each updatable component.")
  packageVersions?: PackageVersionInfo[];

  @doc("Current Solution Bundle version of the stamp.")
  currentVersion?: string;

  @doc("Last time an update installation completed successfully.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  @doc("Last time the update service successfully checked for updates")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastChecked?: utcDateTime;

  @doc("Overall health state for update-specific health checks.")
  healthState?: HealthState;

  @doc("An array of pre-check result objects.")
  healthCheckResult?: PrecheckResult[];

  @doc("Last time the package-specific checks were run.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  healthCheckDate?: utcDateTime;

  @doc("Overall update state of the stamp.")
  state?: UpdateSummariesPropertiesState;
}

@doc("Current version of each updatable component.")
model PackageVersionInfo {
  @doc("Package type")
  packageType?: string;

  @doc("Package version")
  version?: string;

  @doc("Last time this component was updated.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;
}

model PrecheckResult {
  @doc("Name of the individual test/rule/alert that was executed. Unique, not exposed to the customer.")
  name?: string;

  @doc("Key-value pairs that allow grouping/filtering individual tests.")
  tags?: PrecheckResultTags;

  @doc("User-facing name; one or more sentences indicating the direct issue.")
  title?: string;

  @doc("The status of the check running (i.e. Failed, Succeeded, In Progress). This answers whether the check ran, and passed or failed.")
  status?: Status;

  @doc("Severity of the result (Critical, Warning, Informational, Hidden). This answers how important the result is. Critical is the only update-blocking severity.")
  severity?: Severity;

  @doc("Detailed overview of the issue and what impact the issue has on the stamp.")
  description?: string;

  @doc("Set of steps that can be taken to resolve the issue found.")
  remediation?: string;

  @doc("The unique identifier for the affected resource (such as a node or drive).")
  targetResourceID?: string;

  @doc("The name of the affected resource.")
  targetResourceName?: string;

  @doc("The Time in which the HealthCheck was called.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  @doc("Property bag of key value pairs for additional information.")
  additionalData?: string;

  @doc("The name of the services called for the HealthCheck (I.E. Test-AzureStack, Test-Cluster).")
  healthCheckSource?: string;
}

@doc("Key-value pairs that allow grouping/filtering individual tests.")
model PrecheckResultTags {
  @doc("Key that allow grouping/filtering individual tests.")
  key?: string;

  @doc("Value of the key that allow grouping/filtering individual tests.")
  value?: string;
}

@doc("Details of a singular Update in HCI Cluster")
model UpdateProperties {
  @doc("Provisioning state of the Updates proxy resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Date that the update was installed.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  installedDate?: utcDateTime;

  @doc("Description of the update.")
  description?: string;

  @doc("State of the update as it relates to this stamp.")
  state?: State;

  @doc("If update State is HasPrerequisite, this property contains an array of objects describing prerequisite updates before installing this update. Otherwise, it is empty.")
  prerequisites?: UpdatePrerequisite[];

  @doc("An array of component versions for a Solution Bundle update, and an empty array otherwise.  ")
  componentVersions?: PackageVersionInfo[];

  rebootRequired?: RebootRequirement;

  @doc("Overall health state for update-specific health checks.")
  healthState?: HealthState;

  @doc("An array of PrecheckResult objects.")
  healthCheckResult?: PrecheckResult[];

  @doc("Last time the package-specific checks were run.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  healthCheckDate?: utcDateTime;

  @doc("Path where the update package is available.")
  packagePath?: string;

  @doc("Size of the package. This value is a combination of the size from update metadata and size of the payload that results from the live scan operation for OS update content.")
  packageSizeInMb?: float32;

  @doc("Display name of the Update")
  displayName?: string;

  @doc("Version of the update.")
  version?: string;

  @doc("Publisher of the update package.")
  publisher?: string;

  @doc("Link to release notes for the update.")
  releaseLink?: string;

  @doc("Indicates the way the update content can be downloaded.")
  availabilityType?: AvailabilityType;

  @doc("Customer-visible type of the update.")
  packageType?: string;

  @doc("Extensible KV pairs serialized as a string. This is currently used to report the stamp OEM family and hardware model information when an update is flagged as Invalid for the stamp based on OEM type.")
  additionalProperties?: string;

  @doc("Additional information regarding the state of the update. See definition of UpdateStateProperties type below for more details on this property.")
  updateStateProperties?: UpdateStateProperties;
}

@doc("If update State is HasPrerequisite, this property contains an array of objects describing prerequisite updates before installing this update. Otherwise, it is empty.")
model UpdatePrerequisite {
  @doc("Updatable component type.")
  updateType?: string;

  @doc("Version of the prerequisite.")
  version?: string;

  @doc("Friendly name of the prerequisite.")
  packageName?: string;
}

@doc("Additional information regarding the state of the update. See definition of UpdateStateProperties type below for more details on this property.")
model UpdateStateProperties {
  @doc("Progress percentage of ongoing operation. Currently this property is only valid when the update is in the Downloading state, where it maps to how much of the update content has been downloaded.")
  progressPercentage?: float32;

  @doc("Brief message with instructions for updates of AvailabilityType Notify.")
  notifyMessage?: string;
}

@doc("Connectivity related configuration required by arc server.")
model ArcConnectivityProperties {
  @doc("True indicates ARC connectivity is enabled")
  enabled?: boolean;
}
