import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AzureStackHCI;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Datasource for the gallery image when provisioning with cloud-init [NoCloud, Azure]
 */
enum CloudInitDataSource {
  NoCloud,
  Azure,
}

/**
 * The hypervisor generation of the Virtual Machine [V1, V2]
 */
enum HyperVGeneration {
  V1,
  V2,
}

/**
 * Provisioning state of the gallery image.
 */
enum ProvisioningStateEnum {
  Succeeded,
  Failed,
  InProgress,
  Accepted,
  Deleting,
  Canceled,
}

/**
 * Status of the cluster agent.
 */
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

/**
 * The type of extendedLocation.
 */
enum ExtendedLocationTypes {
  CustomLocation,
}

/**
 * IPAllocationMethod - The IP address allocation method. Possible values include: 'Static', 'Dynamic'
 */
enum IpAllocationMethodEnum {
  Dynamic,
  Static,
}

/**
 * The format of the actual VHD file [vhd, vhdx]
 */
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

/**
 * Specifies the SecurityType of the virtual machine. EnableTPM and SecureBootEnabled must be set to true for SecurityType to function.
 */
enum SecurityTypes {
  TrustedLaunch,
  ConfidentialVM,
}

/**
 * The level code.
 */
enum StatusLevelTypes {
  Info,
  Warning,
  Error,
}

/**
 * The power state of the virtual machine instance
 */
enum PowerStateEnum {
  Deallocated,
  Deallocating,
  Running,
  Starting,
  Stopped,
  Stopping,
  Unknown,
}

/**
 * The installation status of the hybrid machine agent installation.
 */
enum StatusTypes {
  Succeeded,
  InProgress,
  Failed,
}

/**
 * Defines the different types of operations for guest agent.
 */
enum ProvisioningAction {
  install,
  uninstall,
  repair,
}

/**
 * Provisioning state of the ArcSetting proxy resource.
 */
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

/**
 * Aggregate state of Arc agent across the nodes in this HCI cluster.
 */
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

/**
 * State of Arc agent in this node.
 */
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

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
}

/**
 * Status of the Software Assurance for the cluster.
 */
enum SoftwareAssuranceStatus {
  Enabled,
  Disabled,
}

/**
 * Customer Intent for Software Assurance Benefit.
 */
enum SoftwareAssuranceIntent {
  Enable,
  Disable,
}

/**
 * Desired state of Windows Server Subscription.
 */
enum WindowsServerSubscription {
  Disabled,
  Enabled,
}

/**
 * Desired level of diagnostic data emitted by the cluster.
 */
enum DiagnosticLevel {
  Off,
  Basic,
  Enhanced,
}

/**
 * Type of the cluster node hardware.
 */
enum ClusterNodeType {
  FirstParty,
  ThirdParty,
}

/**
 * IMDS attestation status of the cluster.
 */
enum ImdsAttestation {
  Disabled,
  Enabled,
}

/**
 * Aggregate state of Arc Extensions across the nodes in this HCI cluster.
 */
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

/**
 * State of Arc Extension in this node.
 */
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

/**
 * State of the update run.
 */
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

/**
 * Severity of the result (Critical, Warning, Informational, Hidden). This answers how important the result is. Critical is the only update-blocking severity.
 */
enum Severity {
  Critical,
  Warning,
  Informational,
  Hidden,
}

/**
 * Overall update state of the stamp.
 */
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

/**
 * State of the update as it relates to this stamp.
 */
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

/**
 * Indicates the way the update content can be downloaded.
 */
enum AvailabilityType {
  Local,
  Online,
  Notify,
}

/**
 * Operating system type that the gallery image uses [Windows, Linux]
 */
@fixed
enum OperatingSystemTypes {
  Windows,
  Linux,
}

/**
 * Type of the IP Pool [vm, vippool]
 */
@fixed
enum IPPoolTypeEnum {
  vm,
  vippool,
}

/**
 * Properties under the gallery image resource
 */
model GalleryImageProperties {
  /**
   * Storage ContainerID of the storage container to be used for gallery image
   */
  containerId?: ResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/storageContainers";
    }
  ]>;

  /**
   * location of the image the gallery image should be created from
   */
  imagePath?: string;

  /**
   * Operating system type that the gallery image uses [Windows, Linux]
   */
  osType: OperatingSystemTypes;

  /**
   * Datasource for the gallery image when provisioning with cloud-init [NoCloud, Azure]
   */
  cloudInitDataSource?: CloudInitDataSource;

  /**
   * The hypervisor generation of the Virtual Machine [V1, V2]
   */
  hyperVGeneration?: HyperVGeneration;

  /**
   * This is the gallery image definition identifier.
   */
  identifier?: GalleryImageIdentifier;

  /**
   * Specifies information about the gallery image version that you want to create or update.
   */
  version?: GalleryImageVersion;

  /**
   * Provisioning state of the gallery image.
   */
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;

  /**
   * The observed state of gallery images
   */
  @visibility("read")
  status?: GalleryImageStatus;
}

/**
 * This is the gallery image definition identifier.
 */
model GalleryImageIdentifier {
  /**
   * The name of the gallery image definition publisher.
   */
  publisher: string;

  /**
   * The name of the gallery image definition offer.
   */
  offer: string;

  /**
   * The name of the gallery image definition SKU.
   */
  sku: string;
}

/**
 * Specifies information about the gallery image version that you want to create or update.
 */
model GalleryImageVersion {
  /**
   * This is the version of the gallery image.
   */
  name?: string;

  /**
   * Describes the properties of a gallery image version.
   */
  @extension("x-ms-client-flatten", true)
  properties?: GalleryImageVersionProperties;
}

/**
 * Describes the properties of a gallery image version.
 */
model GalleryImageVersionProperties {
  /**
   * This is the storage profile of a Gallery Image Version.
   */
  storageProfile: GalleryImageVersionStorageProfile;
}

/**
 * This is the storage profile of a Gallery Image Version.
 */
model GalleryImageVersionStorageProfile {
  /**
   * This is the OS disk image.
   */
  osDiskImage?: GalleryOSDiskImage;
}

/**
 * This is the OS disk image.
 */
model GalleryOSDiskImage extends GalleryDiskImage {}

/**
 * This is the disk image base class.
 */
model GalleryDiskImage {
  /**
   * This property indicates the size of the VHD to be created.
   */
  @visibility("read")
  sizeInMB?: int64;
}

/**
 * The observed state of gallery images
 */
model GalleryImageStatus {
  /**
   * GalleryImage provisioning error code
   */
  errorCode?: string;

  /**
   * Descriptive error message
   */
  errorMessage?: string;

  provisioningStatus?: GalleryImageStatusProvisioningStatus;

  /**
   * The download status of the gallery image
   */
  downloadStatus?: GalleryImageStatusDownloadStatus;

  /**
   * The progress of the operation in percentage
   */
  progressPercentage?: int64;
}

model GalleryImageStatusProvisioningStatus {
  /**
   * The ID of the operation performed on the gallery image
   */
  operationId?: string;

  /**
   * The status of the operation performed on the gallery image [Succeeded, Failed, InProgress]
   */
  status?: Status;
}

/**
 * The download status of the gallery image
 */
model GalleryImageStatusDownloadStatus {
  /**
   * The downloaded sized of the image in MB
   */
  downloadSizeInMB?: int64;
}

/**
 * The complex type of the extended location.
 */
model ExtendedLocation {
  /**
   * The name of the extended location.
   */
  name?: string;

  /**
   * The type of the extended location.
   */
  type?: ExtendedLocationTypes;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The gallery images resource patch definition.
 */
model GalleryImagesUpdateRequest {
  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * Properties under the logical network resource
 */
model LogicalNetworkProperties {
  /**
   * DhcpOptions contains an array of DNS servers available to VMs deployed in the logical network. Standard DHCP option for a subnet overrides logical network DHCP options.
   */
  dhcpOptions?: LogicalNetworkPropertiesDhcpOptions;

  /**
   * Subnet - list of subnets under the logical network
   */
  subnets?: Subnet[];

  /**
   * Provisioning state of the logical network.
   */
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;

  /**
   * name of the network switch to be used for VMs
   */
  vmSwitchName?: string;

  /**
   * The observed state of logical networks
   */
  @visibility("read")
  status?: LogicalNetworkStatus;
}

/**
 * DhcpOptions contains an array of DNS servers available to VMs deployed in the logical network. Standard DHCP option for a subnet overrides logical network DHCP options.
 */
model LogicalNetworkPropertiesDhcpOptions {
  /**
   * The list of DNS servers IP addresses.
   */
  dnsServers?: string[];
}

model Subnet {
  /**
   * Properties of the subnet.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SubnetPropertiesFormat;

  /**
   * Name - The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[_a-zA-Z0-9]$")
  name?: string;
}

/**
 * Properties of the subnet.
 */
model SubnetPropertiesFormat {
  /**
   * The address prefix for the subnet: Cidr for this subnet - IPv4, IPv6.
   */
  addressPrefix?: string;

  /**
   * List of address prefixes for the subnet.
   */
  addressPrefixes?: string[];

  /**
   * IPAllocationMethod - The IP address allocation method. Possible values include: 'Static', 'Dynamic'
   */
  ipAllocationMethod?: IpAllocationMethodEnum;

  /**
   * IPConfigurationReferences - list of IPConfigurationReferences
   */
  ipConfigurationReferences?: SubnetPropertiesFormatIpConfigurationReferencesItem[];

  /**
   * Route table resource.
   */
  routeTable?: RouteTable;

  /**
   * network associated pool of IP Addresses
   */
  ipPools?: IPPool[];

  /**
   * Vlan to use for the subnet
   */
  vlan?: int32;
}

/**
 * IPConfigurationReference - Describes a IPConfiguration under the virtual network
 */
model SubnetPropertiesFormatIpConfigurationReferencesItem {
  /**
   * IPConfigurationID
   */
  ID?: string;
}

/**
 * Route table resource.
 */
model RouteTable {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility("read")
  etag?: string;

  /**
   * Resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * Properties of the route table.
   */
  @extension("x-ms-client-flatten", true)
  properties?: RouteTablePropertiesFormat;
}

/**
 * RouteTablePropertiesFormat - Route Table resource.
 */
model RouteTablePropertiesFormat {
  /**
   * Collection of routes contained within a route table.
   */
  routes?: Route[];
}

/**
 * Route - Route resource.
 */
model Route {
  /**
   * Properties of the route.
   */
  @extension("x-ms-client-flatten", true)
  properties?: RoutePropertiesFormat;

  /**
   * Name - name of the subnet
   */
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[_a-zA-Z0-9]$")
  name?: string;
}

/**
 * RoutePropertiesFormat - Route resource.
 */
model RoutePropertiesFormat {
  /**
   * The destination CIDR to which the route applies.
   */
  addressPrefix?: string;

  /**
   * The IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance.
   */
  nextHopIpAddress?: string;
}

model IPPool {
  /**
   * Name of the IP-Pool
   */
  name?: string;

  /**
   * Type of the IP Pool [vm, vippool]
   */
  ipPoolType?: IPPoolTypeEnum;

  /**
   * Start of the IP address pool
   */
  start?: string;

  /**
   * End of the IP address pool
   */
  end?: string;

  info?: IPPoolInfo;
}

model IPPoolInfo {
  /**
   * Number of IP addresses allocated from the IP Pool
   */
  @visibility("read")
  used?: string;

  /**
   * Number of IP addresses available in the IP Pool
   */
  @visibility("read")
  available?: string;
}

/**
 * The observed state of logical networks
 */
model LogicalNetworkStatus {
  /**
   * LogicalNetwork provisioning error code
   */
  errorCode?: string;

  /**
   * Descriptive error message
   */
  errorMessage?: string;

  provisioningStatus?: LogicalNetworkStatusProvisioningStatus;
}

model LogicalNetworkStatusProvisioningStatus {
  /**
   * The ID of the operation performed on the logical network
   */
  operationId?: string;

  /**
   * The status of the operation performed on the logical network [Succeeded, Failed, InProgress]
   */
  status?: Status;
}

/**
 * The logical network resource patch definition.
 */
model LogicalNetworksUpdateRequest {
  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * Properties under the marketplace gallery image resource
 */
model MarketplaceGalleryImageProperties {
  /**
   * Storage ContainerID of the storage container to be used for marketplace gallery image
   */
  containerId?: ResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/storageContainers";
    }
  ]>;

  /**
   * Operating system type that the gallery image uses [Windows, Linux]
   */
  osType: OperatingSystemTypes;

  /**
   * Datasource for the gallery image when provisioning with cloud-init [NoCloud, Azure]
   */
  cloudInitDataSource?: CloudInitDataSource;

  /**
   * The hypervisor generation of the Virtual Machine [V1, V2]
   */
  hyperVGeneration?: HyperVGeneration;

  /**
   * This is the gallery image definition identifier.
   */
  identifier?: GalleryImageIdentifier;

  /**
   * Specifies information about the gallery image version that you want to create or update.
   */
  version?: GalleryImageVersion;

  /**
   * Provisioning state of the marketplace gallery image.
   */
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;

  /**
   * The observed state of marketplace gallery images
   */
  @visibility("read")
  status?: MarketplaceGalleryImageStatus;
}

/**
 * The observed state of marketplace gallery images
 */
model MarketplaceGalleryImageStatus {
  /**
   * MarketplaceGalleryImage provisioning error code
   */
  errorCode?: string;

  /**
   * Descriptive error message
   */
  errorMessage?: string;

  provisioningStatus?: MarketplaceGalleryImageStatusProvisioningStatus;

  /**
   * The download status of the gallery image
   */
  downloadStatus?: MarketplaceGalleryImageStatusDownloadStatus;

  /**
   * The progress of the operation in percentage
   */
  progressPercentage?: int64;
}

model MarketplaceGalleryImageStatusProvisioningStatus {
  /**
   * The ID of the operation performed on the gallery image
   */
  operationId?: string;

  /**
   * The status of the operation performed on the gallery image [Succeeded, Failed, InProgress]
   */
  status?: Status;
}

/**
 * The download status of the gallery image
 */
model MarketplaceGalleryImageStatusDownloadStatus {
  /**
   * The downloaded sized of the image in MB
   */
  downloadSizeInMB?: int64;
}

/**
 * The marketplace gallery image resource patch definition.
 */
model MarketplaceGalleryImagesUpdateRequest {
  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * Properties under the network interface resource
 */
model NetworkInterfaceProperties {
  /**
   * IPConfigurations - A list of IPConfigurations of the network interface.
   */
  ipConfigurations?: IPConfiguration[];

  /**
   * MacAddress - The MAC address of the network interface.
   */
  macAddress?: string;

  /**
   * DNS Settings for the interface
   */
  dnsSettings?: InterfaceDNSSettings;

  /**
   * Provisioning state of the network interface.
   */
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;

  /**
   * The observed state of network interfaces
   */
  @visibility("read")
  status?: NetworkInterfaceStatus;
}

/**
 * InterfaceIPConfiguration iPConfiguration in a network interface.
 */
model IPConfiguration {
  /**
   * Name - The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility("read", "create")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[_a-zA-Z0-9]$")
  name?: string;

  /**
   * InterfaceIPConfigurationPropertiesFormat properties of IP configuration.
   */
  properties?: IPConfigurationProperties;
}

/**
 * InterfaceIPConfigurationPropertiesFormat properties of IP configuration.
 */
model IPConfigurationProperties {
  /**
   * Gateway for network interface
   */
  @visibility("read")
  gateway?: string;

  /**
   * prefixLength for network interface
   */
  @visibility("read")
  prefixLength?: string;

  /**
   * PrivateIPAddress - Private IP address of the IP configuration.
   */
  privateIPAddress?: string;

  /**
   * Subnet - Name of Subnet bound to the IP configuration.
   */
  subnet?: IPConfigurationPropertiesSubnet;
}

/**
 * Subnet - Name of Subnet bound to the IP configuration.
 */
model IPConfigurationPropertiesSubnet {
  /**
   * ID - The ARM resource id in the form of /subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/...
   */
  id?: string;
}

model InterfaceDNSSettings {
  /**
   * List of DNS server IP Addresses for the interface
   */
  dnsServers?: string[];
}

/**
 * The observed state of network interfaces
 */
model NetworkInterfaceStatus {
  /**
   * NetworkInterface provisioning error code
   */
  errorCode?: string;

  /**
   * Descriptive error message
   */
  errorMessage?: string;

  provisioningStatus?: NetworkInterfaceStatusProvisioningStatus;
}

model NetworkInterfaceStatusProvisioningStatus {
  /**
   * The ID of the operation performed on the network interface
   */
  operationId?: string;

  /**
   * The status of the operation performed on the network interface [Succeeded, Failed, InProgress]
   */
  status?: Status;
}

/**
 * The network interface resource patch definition.
 */
model NetworkInterfacesUpdateRequest {
  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * Properties under the storage container resource
 */
model StorageContainerProperties {
  /**
   * Path of the storage container on the disk
   */
  path: string;

  /**
   * Provisioning state of the storage container.
   */
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;

  /**
   * The observed state of storage containers
   */
  @visibility("read")
  status?: StorageContainerStatus;
}

/**
 * The observed state of storage containers
 */
model StorageContainerStatus {
  /**
   * StorageContainer provisioning error code
   */
  errorCode?: string;

  /**
   * Descriptive error message
   */
  errorMessage?: string;

  /**
   * Amount of space available on the disk in MB
   */
  availableSizeMB?: int64;

  /**
   * Total size of the disk in MB
   */
  containerSizeMB?: int64;

  provisioningStatus?: StorageContainerStatusProvisioningStatus;
}

model StorageContainerStatusProvisioningStatus {
  /**
   * The ID of the operation performed on the storage container
   */
  operationId?: string;

  /**
   * The status of the operation performed on the storage container [Succeeded, Failed, InProgress]
   */
  status?: Status;
}

/**
 * The storage container resource patch definition.
 */
model StorageContainersUpdateRequest {
  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * Properties under the virtual hard disk resource
 */
model VirtualHardDiskProperties {
  blockSizeBytes?: int32;

  /**
   * Size of the disk in GB
   */
  diskSizeGB?: int64;

  /**
   * Boolean for enabling dynamic sizing on the virtual hard disk
   */
  dynamic?: boolean;

  logicalSectorBytes?: int32;
  physicalSectorBytes?: int32;

  /**
   * The hypervisor generation of the Virtual Machine [V1, V2]
   */
  hyperVGeneration?: HyperVGeneration;

  /**
   * The format of the actual VHD file [vhd, vhdx]
   */
  diskFileFormat?: DiskFileFormat;

  /**
   * Provisioning state of the virtual hard disk.
   */
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;

  /**
   * Storage ContainerID of the storage container to be used for VHD
   */
  containerId?: ResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/storageContainers";
    }
  ]>;

  /**
   * The observed state of virtual hard disks
   */
  @visibility("read")
  status?: VirtualHardDiskStatus;
}

/**
 * The observed state of virtual hard disks
 */
model VirtualHardDiskStatus {
  /**
   * VirtualHardDisk provisioning error code
   */
  errorCode?: string;

  /**
   * Descriptive error message
   */
  errorMessage?: string;

  provisioningStatus?: VirtualHardDiskStatusProvisioningStatus;
}

model VirtualHardDiskStatusProvisioningStatus {
  /**
   * The ID of the operation performed on the virtual hard disk
   */
  operationId?: string;

  /**
   * The status of the operation performed on the virtual hard disk [Succeeded, Failed, InProgress]
   */
  status?: Status;
}

/**
 * The virtual hard disk resource patch definition.
 */
model VirtualHardDisksUpdateRequest {
  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * Properties under the virtual machine instance resource
 */
model VirtualMachineInstanceProperties {
  /**
   * HardwareProfile - Specifies the hardware settings for the virtual machine instance.
   */
  hardwareProfile?: VirtualMachineInstancePropertiesHardwareProfile;

  /**
   * NetworkProfile - describes the network configuration the virtual machine instance
   */
  networkProfile?: VirtualMachineInstancePropertiesNetworkProfile;

  /**
   * OsProfile - describes the configuration of the operating system and sets login data
   */
  osProfile?: VirtualMachineInstancePropertiesOsProfile;

  /**
   * SecurityProfile - Specifies the security settings for the virtual machine instance.
   */
  securityProfile?: VirtualMachineInstancePropertiesSecurityProfile;

  /**
   * StorageProfile - contains information about the disks and storage information for the virtual machine instance
   */
  storageProfile?: VirtualMachineInstancePropertiesStorageProfile;

  /**
   * HTTP Proxy configuration for the VM.
   */
  httpProxyConfig?: HttpProxyConfiguration;

  /**
   * Provisioning state of the virtual machine instance.
   */
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;

  /**
   * The virtual machine instance view.
   */
  @visibility("read")
  instanceView?: VirtualMachineInstanceView;

  /**
   * The observed state of virtual machine instances
   */
  @visibility("read")
  status?: VirtualMachineInstanceStatus;

  /**
   * Guest agent install status.
   */
  guestAgentInstallStatus?: GuestAgentInstallStatus;

  /**
   * Unique identifier for the vm resource.
   */
  @visibility("read")
  vmId?: string;

  /**
   * Unique identifier defined by ARC to identify the guest of the VM.
   */
  resourceUid?: string;
}

/**
 * HardwareProfile - Specifies the hardware settings for the virtual machine instance.
 */
model VirtualMachineInstancePropertiesHardwareProfile {
  vmSize?: VmSizeEnum;

  /**
   * number of processors for the virtual machine instance
   */
  processors?: int32;

  /**
   * RAM in MB for the virtual machine instance
   */
  memoryMB?: int64;

  dynamicMemoryConfig?: VirtualMachineInstancePropertiesHardwareProfileDynamicMemoryConfig;
}

model VirtualMachineInstancePropertiesHardwareProfileDynamicMemoryConfig {
  maximumMemoryMB?: int64;
  minimumMemoryMB?: int64;

  /**
   * Defines the amount of extra memory that should be reserved for a virtual machine instance at runtime, as a percentage of the total memory that the virtual machine instance is thought to need. This only applies to virtual systems with dynamic memory enabled. This property can be in the range of 5 to 2000.
   */
  targetMemoryBuffer?: int32;
}

/**
 * NetworkProfile - describes the network configuration the virtual machine instance
 */
model VirtualMachineInstancePropertiesNetworkProfile {
  /**
   * NetworkInterfaces - list of network interfaces to be attached to the virtual machine instance
   */
  networkInterfaces?: VirtualMachineInstancePropertiesNetworkProfileNetworkInterfacesItem[];
}

model VirtualMachineInstancePropertiesNetworkProfileNetworkInterfacesItem {
  /**
   * ID - Resource Id of the network interface
   */
  id?: string;
}

/**
 * OsProfile - describes the configuration of the operating system and sets login data
 */
model VirtualMachineInstancePropertiesOsProfile {
  /**
   * AdminPassword - admin password
   */
  @visibility("create")
  adminPassword?: string;

  /**
   * AdminUsername - admin username
   */
  adminUsername?: string;

  /**
   * ComputerName - name of the compute
   */
  computerName?: string;

  /**
   * LinuxConfiguration - linux specific configuration values for the virtual machine instance
   */
  linuxConfiguration?: VirtualMachineInstancePropertiesOsProfileLinuxConfiguration;

  /**
   * Windows Configuration for the virtual machine instance
   */
  windowsConfiguration?: VirtualMachineInstancePropertiesOsProfileWindowsConfiguration;
}

/**
 * LinuxConfiguration - linux specific configuration values for the virtual machine instance
 */
model VirtualMachineInstancePropertiesOsProfileLinuxConfiguration {
  /**
   * DisablePasswordAuthentication - whether password authentication should be disabled
   */
  disablePasswordAuthentication?: boolean;

  /**
   * Specifies the ssh key configuration for a Linux OS.
   */
  ssh?: SshConfiguration;

  /**
   * Used to indicate whether Arc for Servers agent onboarding should be triggered during the virtual machine instance creation process.
   */
  provisionVMAgent?: boolean = true;

  /**
   * Used to indicate whether the VM Config Agent should be installed during the virtual machine creation process.
   */
  provisionVMConfigAgent?: boolean = true;
}

/**
 * SSH configuration for Linux based VMs running on Azure
 */
model SshConfiguration {
  /**
   * The list of SSH public keys used to authenticate with linux based VMs.
   */
  publicKeys?: SshPublicKey[];
}

/**
 * Contains information about SSH certificate public key and the path on the Linux VM where the public key is placed.
 */
model SshPublicKey {
  /**
   * Specifies the full path on the created VM where ssh public key is stored. If the file already exists, the specified key is appended to the file. Example: /home/user/.ssh/authorized_keys
   */
  path?: string;

  /**
   * SSH public key certificate used to authenticate with the VM through ssh. The key needs to be at least 2048-bit and in ssh-rsa format. <br><br> For creating ssh keys, see [Create SSH keys on Linux and Mac for Linux VMs in Azure]https://docs.microsoft.com/azure/virtual-machines/linux/create-ssh-keys-detailed).
   */
  keyData?: string;
}

/**
 * Windows Configuration for the virtual machine instance
 */
model VirtualMachineInstancePropertiesOsProfileWindowsConfiguration {
  /**
   * Whether to EnableAutomaticUpdates on the machine
   */
  enableAutomaticUpdates?: boolean;

  /**
   * Specifies the ssh key configuration for Windows OS.
   */
  ssh?: SshConfiguration;

  /**
   * TimeZone for the virtual machine instance
   */
  timeZone?: string;

  /**
   * Used to indicate whether Arc for Servers agent onboarding should be triggered during the virtual machine instance creation process.
   */
  provisionVMAgent?: boolean = true;

  /**
   * Used to indicate whether the VM Config Agent should be installed during the virtual machine creation process.
   */
  provisionVMConfigAgent?: boolean = true;
}

/**
 * SecurityProfile - Specifies the security settings for the virtual machine instance.
 */
model VirtualMachineInstancePropertiesSecurityProfile {
  enableTPM?: boolean;
  uefiSettings?: VirtualMachineInstancePropertiesSecurityProfileUefiSettings;

  /**
   * Specifies the SecurityType of the virtual machine. EnableTPM and SecureBootEnabled must be set to true for SecurityType to function.
   */
  securityType?: SecurityTypes;
}

model VirtualMachineInstancePropertiesSecurityProfileUefiSettings {
  /**
   * Specifies whether secure boot should be enabled on the virtual machine instance.
   */
  secureBootEnabled?: boolean;
}

/**
 * StorageProfile - contains information about the disks and storage information for the virtual machine instance
 */
model VirtualMachineInstancePropertiesStorageProfile {
  /**
   * adds data disks to the virtual machine instance
   */
  dataDisks?: VirtualMachineInstancePropertiesStorageProfileDataDisksItem[];

  /**
   * Which Image to use for the virtual machine instance
   */
  imageReference?: VirtualMachineInstancePropertiesStorageProfileImageReference;

  /**
   * VHD to attach as OS disk
   */
  osDisk?: VirtualMachineInstancePropertiesStorageProfileOsDisk;

  /**
   * Id of the storage container that hosts the VM configuration file
   */
  vmConfigStoragePathId?: ResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/storageContainers";
    }
  ]>;
}

model VirtualMachineInstancePropertiesStorageProfileDataDisksItem {
  /**
   * Resource ID of the data disk
   */
  id?: string;
}

/**
 * Which Image to use for the virtual machine instance
 */
model VirtualMachineInstancePropertiesStorageProfileImageReference {
  /**
   * Resource ID of the image
   */
  @visibility("read", "create")
  id?: string;
}

/**
 * VHD to attach as OS disk
 */
model VirtualMachineInstancePropertiesStorageProfileOsDisk {
  /**
   * Resource ID of the OS disk
   */
  id?: string;

  /**
   * This property allows you to specify the type of the OS that is included in the disk if creating a VM from user-image or a specialized VHD. Possible values are: **Windows,** **Linux.**
   */
  osType?: OperatingSystemTypes;
}

/**
 * HTTP Proxy configuration for the VM.
 */
model HttpProxyConfiguration {
  /**
   * The HTTP proxy server endpoint to use.
   */
  httpProxy?: string;

  /**
   * The HTTPS proxy server endpoint to use.
   */
  httpsProxy?: string;

  /**
   * The endpoints that should not go through proxy.
   */
  noProxy?: string[];

  /**
   * Alternative CA cert to use for connecting to proxy servers.
   */
  trustedCa?: string;
}

/**
 * The instance view of a virtual machine.
 */
model VirtualMachineInstanceView {
  /**
   * The VM Config Agent running on the virtual machine.
   */
  vmAgent?: VirtualMachineConfigAgentInstanceView;
}

/**
 * The instance view of the VM Config Agent running on the virtual machine.
 */
model VirtualMachineConfigAgentInstanceView {
  /**
   * The VM Config Agent full version.
   */
  vmConfigAgentVersion?: string;

  /**
   * The resource status information.
   */
  statuses?: InstanceViewStatus[];
}

/**
 * Instance view status.
 */
model InstanceViewStatus {
  /**
   * The status code.
   */
  code?: string;

  /**
   * The level code.
   */
  level?: StatusLevelTypes;

  /**
   * The short localizable label for the status.
   */
  displayStatus?: string;

  /**
   * The detailed status message, including for alerts and error messages.
   */
  message?: string;

  /**
   * The time of the status.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;
}

/**
 * The observed state of virtual machine instances
 */
model VirtualMachineInstanceStatus {
  /**
   * VirtualMachine provisioning error code
   */
  errorCode?: string;

  /**
   * Descriptive error message
   */
  errorMessage?: string;

  /**
   * The power state of the virtual machine instance
   */
  powerState?: PowerStateEnum;

  provisioningStatus?: VirtualMachineInstanceStatusProvisioningStatus;
}

model VirtualMachineInstanceStatusProvisioningStatus {
  /**
   * The ID of the operation performed on the virtual machine instance
   */
  operationId?: string;

  /**
   * The status of the operation performed on the virtual machine instance [Succeeded, Failed, InProgress]
   */
  status?: Status;
}

/**
 * Defines the status of a guest agent installation.
 */
model GuestAgentInstallStatus {
  /**
   * Specifies the VM's unique SMBIOS ID.
   */
  @visibility("read")
  vmUuid?: string;

  /**
   * The installation status of the hybrid machine agent installation.
   */
  @visibility("read")
  status?: StatusTypes;

  /**
   * The time of the last status change.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStatusChange?: utcDateTime;

  /**
   * The hybrid machine agent full version.
   */
  @visibility("read")
  agentVersion?: string;

  /**
   * Details about the error state.
   */
  @visibility("read")
  errorDetails?: ErrorDetail[];
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: "SystemAssigned";
}

/**
 * The virtual machine instance resource patch definition.
 */
model VirtualMachineInstanceUpdateRequest {
  /**
   * Defines the resource properties for the update.
   */
  properties?: VirtualMachineInstanceUpdateProperties;

  /**
   * Identity for the resource.
   */
  identity?: Identity;
}

/**
 * Defines the resource properties for the update.
 */
model VirtualMachineInstanceUpdateProperties {
  /**
   * HardwareProfile - Specifies the hardware settings for the virtual machine instance.
   */
  hardwareProfile?: HardwareProfileUpdate;

  storageProfile?: StorageProfileUpdate;

  /**
   * NetworkProfile - describes the network update configuration the virtual machine instance
   */
  networkProfile?: NetworkProfileUpdate;

  /**
   * OsProfile - describes the update configuration of the operating system
   */
  osProfile?: OsProfileUpdate;
}

/**
 * HardwareProfile - Specifies the hardware settings for the virtual machine instance.
 */
model HardwareProfileUpdate {
  vmSize?: VmSizeEnum;

  /**
   * number of processors for the virtual machine instance
   */
  processors?: int32;

  /**
   * RAM in MB for the virtual machine instance
   */
  memoryMB?: int64;
}

model StorageProfileUpdate {
  /**
   * adds data disks to the virtual machine instance for the update call
   */
  dataDisks?: StorageProfileUpdateDataDisksItem[];
}

model StorageProfileUpdateDataDisksItem {
  id?: string;
}

/**
 * NetworkProfile - describes the network update configuration the virtual machine instance
 */
model NetworkProfileUpdate {
  /**
   * NetworkInterfaces - list of network interfaces to be attached to the virtual machine instance
   */
  networkInterfaces?: NetworkProfileUpdateNetworkInterfacesItem[];
}

model NetworkProfileUpdateNetworkInterfacesItem {
  /**
   * ID - Resource ID of the network interface
   */
  id?: string;
}

/**
 * OsProfile - describes the update configuration of the operating system
 */
model OsProfileUpdate {
  /**
   * ComputerName - name of the computer
   */
  computerName?: string;

  linuxConfiguration?: OsProfileUpdateLinuxConfiguration;
  windowsConfiguration?: OsProfileUpdateWindowsConfiguration;
}

model OsProfileUpdateLinuxConfiguration {
  /**
   * Used to indicate whether Arc for Servers agent onboarding should be triggered during the virtual machine instance creation process.
   */
  provisionVMAgent?: boolean;

  /**
   * Used to indicate whether the VM Config Agent should be installed during the virtual machine creation process.
   */
  provisionVMConfigAgent?: boolean;
}

model OsProfileUpdateWindowsConfiguration {
  /**
   * Used to indicate whether Arc for Servers agent onboarding should be triggered during the virtual machine instance creation process.
   */
  provisionVMAgent?: boolean;

  /**
   * Used to indicate whether the VM Config Agent should be installed during the virtual machine creation process.
   */
  provisionVMConfigAgent?: boolean;
}

/**
 * Defines the resource properties.
 */
model HybridIdentityMetadataProperties {
  /**
   * The unique identifier for the resource.
   */
  resourceUid?: string;

  /**
   * The Public Key.
   */
  publicKey?: string;

  /**
   * Identity for the resource.
   */
  @visibility("read")
  identity?: Identity;

  /**
   * The provisioning state.
   */
  @visibility("read")
  provisioningState?: string;
}

/**
 * Defines the resource properties.
 */
model GuestAgentProperties {
  /**
   * Username / Password Credentials to provision guest agent.
   */
  credentials?: GuestCredential;

  /**
   * The guest agent provisioning action.
   */
  provisioningAction?: ProvisioningAction;

  /**
   * The guest agent status.
   */
  @visibility("read")
  status?: string;

  /**
   * The provisioning state.
   */
  @visibility("read")
  provisioningState?: string;
}

/**
 * Username / Password Credentials to connect to guest.
 */
model GuestCredential {
  /**
   * The username to connect with the guest.
   */
  username?: string;

  /**
   * The password to connect with the guest.
   */
  @visibility("create", "update")
  password?: string;
}

/**
 * ArcSetting properties.
 */
model ArcSettingProperties {
  /**
   * Provisioning state of the ArcSetting proxy resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The resource group that hosts the Arc agents, ie. Hybrid Compute Machine resources.
   */
  arcInstanceResourceGroup?: string;

  /**
   * App id of arc AAD identity.
   */
  arcApplicationClientId?: string;

  /**
   * Tenant id of arc AAD identity.
   */
  arcApplicationTenantId?: string;

  /**
   * Object id of arc AAD service principal.
   */
  arcServicePrincipalObjectId?: string;

  /**
   * Object id of arc AAD identity.
   */
  arcApplicationObjectId?: string;

  /**
   * Aggregate state of Arc agent across the nodes in this HCI cluster.
   */
  @visibility("read")
  aggregateState?: ArcSettingAggregateState;

  /**
   * State of Arc agent in each of the nodes.
   */
  @visibility("read")
  perNodeDetails?: PerNodeState[];

  /**
   * contains connectivity related configuration for ARC resources
   */
  connectivityProperties?: Record<unknown>;
}

/**
 * Status of Arc agent for a particular node in HCI Cluster.
 */
model PerNodeState {
  /**
   * Name of the Node in HCI Cluster
   */
  @visibility("read")
  name?: string;

  /**
   * Fully qualified resource ID for the Arc agent of this node.
   */
  @visibility("read")
  arcInstance?: string;

  /**
   * State of Arc agent in this node.
   */
  @visibility("read")
  state?: NodeArcState;
}

/**
 * ArcSetting details to update.
 */
model ArcSettingsPatch {
  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * ArcSettings properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ArcSettingsPatchProperties;
}

/**
 * ArcSettings properties.
 */
model ArcSettingsPatchProperties {
  /**
   * contains connectivity related configuration for ARC resources
   */
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

/**
 * ArcIdentity details.
 */
model ArcIdentityResponse {
  /**
   * ArcIdentity properties.
   */
  @visibility("read")
  @extension("x-ms-client-flatten", true)
  properties?: ArcIdentityResponseProperties;
}

model ArcIdentityResponseProperties {
  arcApplicationClientId?: string;
  arcApplicationTenantId?: string;
  arcServicePrincipalObjectId?: string;
  arcApplicationObjectId?: string;
}

/**
 * Cluster properties.
 */
model ClusterProperties {
  /**
   * Provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Status of the cluster agent.
   */
  @visibility("read")
  status?: Status;

  /**
   * Unique, immutable resource id.
   */
  @visibility("read")
  cloudId?: string;

  /**
   * Endpoint configured for management from the Azure portal.
   */
  cloudManagementEndpoint?: string;

  /**
   * App id of cluster AAD identity.
   */
  aadClientId?: string;

  /**
   * Tenant id of cluster AAD identity.
   */
  aadTenantId?: string;

  /**
   * Object id of cluster AAD identity.
   */
  aadApplicationObjectId?: string;

  /**
   * Id of cluster identity service principal.
   */
  aadServicePrincipalObjectId?: string;

  /**
   * Software Assurance properties of the cluster.
   */
  softwareAssuranceProperties?: SoftwareAssuranceProperties;

  /**
   * Desired properties of the cluster.
   */
  desiredProperties?: ClusterDesiredProperties;

  /**
   * Properties reported by cluster agent.
   */
  @visibility("read")
  reportedProperties?: ClusterReportedProperties;

  /**
   * Number of days remaining in the trial period.
   */
  @visibility("read")
  trialDaysRemaining?: float32;

  /**
   * Type of billing applied to the resource.
   */
  @visibility("read")
  billingModel?: string;

  /**
   * First cluster sync timestamp.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  registrationTimestamp?: utcDateTime;

  /**
   * Most recent cluster sync timestamp.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncTimestamp?: utcDateTime;

  /**
   * Most recent billing meter timestamp.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastBillingTimestamp?: utcDateTime;

  /**
   * Region specific DataPath Endpoint of the cluster.
   */
  @visibility("read")
  serviceEndpoint?: string;

  /**
   * Object id of RP Service Principal
   */
  @visibility("read")
  resourceProviderObjectId?: string;
}

/**
 * Software Assurance properties of the cluster.
 */
model SoftwareAssuranceProperties {
  /**
   * Status of the Software Assurance for the cluster.
   */
  softwareAssuranceStatus?: SoftwareAssuranceStatus;

  /**
   * Customer Intent for Software Assurance Benefit.
   */
  softwareAssuranceIntent?: SoftwareAssuranceIntent;

  /**
   * TimeStamp denoting the latest SA benefit applicability is validated.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;
}

/**
 * Desired properties of the cluster.
 */
model ClusterDesiredProperties {
  /**
   * Desired state of Windows Server Subscription.
   */
  windowsServerSubscription?: WindowsServerSubscription;

  /**
   * Desired level of diagnostic data emitted by the cluster.
   */
  diagnosticLevel?: DiagnosticLevel;
}

/**
 * Properties reported by cluster agent.
 */
model ClusterReportedProperties {
  /**
   * Name of the on-prem cluster connected to this resource.
   */
  @visibility("read")
  clusterName?: string;

  /**
   * Unique id generated by the on-prem cluster.
   */
  @visibility("read")
  clusterId?: string;

  /**
   * Version of the cluster software.
   */
  @visibility("read")
  clusterVersion?: string;

  /**
   * List of nodes reported by the cluster.
   */
  @visibility("read")
  nodes?: ClusterNode[];

  /**
   * Last time the cluster reported the data.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  /**
   * IMDS attestation status of the cluster.
   */
  @visibility("read")
  imdsAttestation?: ImdsAttestation;

  /**
   * Level of diagnostic data emitted by the cluster.
   */
  diagnosticLevel?: DiagnosticLevel;

  /**
   * Capabilities supported by the cluster.
   */
  @visibility("read")
  supportedCapabilities?: string[];
}

/**
 * Cluster node details.
 */
model ClusterNode {
  /**
   * Name of the cluster node.
   */
  @visibility("read")
  name?: string;

  /**
   * Id of the node in the cluster.
   */
  @visibility("read")
  id?: float32;

  /**
   * State of Windows Server Subscription.
   */
  @visibility("read")
  windowsServerSubscription?: WindowsServerSubscription;

  /**
   * Type of the cluster node hardware.
   */
  @visibility("read")
  nodeType?: ClusterNodeType;

  /**
   * Edge Hardware Center Resource Id
   */
  @visibility("read")
  ehcResourceId?: string;

  /**
   * Manufacturer of the cluster node hardware.
   */
  @visibility("read")
  manufacturer?: string;

  /**
   * Model name of the cluster node hardware.
   */
  @visibility("read")
  `model`?: string;

  /**
   * Operating system running on the cluster node.
   */
  @visibility("read")
  osName?: string;

  /**
   * Version of the operating system running on the cluster node.
   */
  @visibility("read")
  osVersion?: string;

  /**
   * Display version of the operating system running on the cluster node.
   */
  @visibility("read")
  osDisplayVersion?: string;

  /**
   * Immutable id of the cluster node.
   */
  @visibility("read")
  serialNumber?: string;

  /**
   * Number of physical cores on the cluster node.
   */
  @visibility("read")
  coreCount?: float32;

  /**
   * Total available memory on the cluster node (in GiB).
   */
  @visibility("read")
  memoryInGiB?: float32;

  /**
   * Most recent licensing timestamp.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastLicensingTimestamp?: utcDateTime;
}

/**
 * Cluster details to update.
 */
model ClusterPatch {
  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * Identity of Cluster resource
   */
  @extension("x-ms-client-flatten", true)
  identity?: ManagedServiceIdentity;

  /**
   * Cluster properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ClusterPatchProperties;
}

/**
 * Cluster properties.
 */
model ClusterPatchProperties {
  /**
   * Endpoint configured for management from the Azure portal
   */
  cloudManagementEndpoint?: string;

  /**
   * App id of cluster AAD identity.
   */
  aadClientId?: string;

  /**
   * Tenant id of cluster AAD identity.
   */
  aadTenantId?: string;

  /**
   * Desired properties of the cluster.
   */
  desiredProperties?: ClusterDesiredProperties;
}

model UploadCertificateRequest {
  properties?: RawCertificateData;
}

model RawCertificateData {
  certificates?: string[];
}

/**
 * Cluster Identity details.
 */
model ClusterIdentityResponse {
  /**
   * Cluster identity properties.
   */
  @visibility("read")
  @extension("x-ms-client-flatten", true)
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
  /**
   * Customer Intent for Software Assurance Benefit.
   */
  softwareAssuranceIntent?: SoftwareAssuranceIntent;
}

/**
 * Status of Arc Extension for a particular node in HCI Cluster.
 */
model ExtensionProperties {
  /**
   * Provisioning state of the Extension proxy resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Parameters specific to this extension type.
   */
  @extension("x-ms-client-flatten", true)
  extensionParameters?: ExtensionParameters;

  /**
   * Aggregate state of Arc Extensions across the nodes in this HCI cluster.
   */
  @visibility("read")
  aggregateState?: ExtensionAggregateState;

  /**
   * State of Arc Extension in each of the nodes.
   */
  @visibility("read")
  perNodeExtensionDetails?: PerNodeExtensionState[];
}

/**
 * Describes the properties of a Machine Extension. This object mirrors the definition in HybridCompute.
 */
model ExtensionParameters {
  /**
   * How the extension handler should be forced to update even if the extension configuration has not changed.
   */
  forceUpdateTag?: string;

  /**
   * The name of the extension handler publisher.
   */
  publisher?: string;

  /**
   * Specifies the type of the extension; an example is "CustomScriptExtension".
   */
  type?: string;

  /**
   * Specifies the version of the script handler. Latest version would be used if not specified.
   */
  typeHandlerVersion?: string;

  /**
   * Indicates whether the extension should use a newer minor version if one is available at deployment time. Once deployed, however, the extension will not upgrade minor versions unless redeployed, even with this property set to true.
   */
  autoUpgradeMinorVersion?: boolean;

  /**
   * Json formatted public settings for the extension.
   */
  settings?: Record<unknown>;

  /**
   * Protected settings (may contain secrets).
   */
  protectedSettings?: Record<unknown>;

  /**
   * Indicates whether the extension should be automatically upgraded by the platform if there is a newer version available.
   */
  enableAutomaticUpgrade?: boolean;
}

/**
 * Status of Arc Extension for a particular node in HCI Cluster.
 */
model PerNodeExtensionState {
  /**
   * Name of the node in HCI Cluster.
   */
  @visibility("read")
  name?: string;

  /**
   * Fully qualified resource ID for the particular Arc Extension on this node.
   */
  @visibility("read")
  extension?: string;

  /**
   * Specifies the version of the script handler.
   */
  @visibility("read")
  typeHandlerVersion?: string;

  /**
   * State of Arc Extension in this node.
   */
  @visibility("read")
  state?: NodeExtensionState;

  /**
   * The extension instance view.
   */
  @visibility("read")
  instanceView?: ExtensionInstanceView;
}

/**
 * Describes the Extension Instance View.
 */
model ExtensionInstanceView {
  /**
   * The extension name.
   */
  name?: string;

  /**
   * Specifies the type of the extension; an example is "MicrosoftMonitoringAgent".
   */
  type?: string;

  /**
   * Specifies the version of the script handler.
   */
  typeHandlerVersion?: string;

  /**
   * Instance view status.
   */
  status?: ExtensionInstanceViewStatus;
}

/**
 * Instance view status.
 */
model ExtensionInstanceViewStatus {
  /**
   * The status code.
   */
  code?: string;

  /**
   * The level code.
   */
  level?: StatusLevelTypes;

  /**
   * The short localizable label for the status.
   */
  displayStatus?: string;

  /**
   * The detailed status message, including for alerts and error messages.
   */
  message?: string;

  /**
   * The time of the status.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;
}

/**
 * Describes the parameters for Extension upgrade.
 */
model ExtensionUpgradeParameters {
  /**
   * Extension Upgrade Target Version.
   */
  targetVersion?: string;
}

/**
 * Publisher properties.
 */
model OfferProperties {
  /**
   * Provisioning State
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Identifier of the Publisher for the offer
   */
  publisherId?: string;

  /**
   * JSON serialized catalog content of the offer
   */
  content?: string;

  /**
   * The API version of the catalog service used to serve the catalog content
   */
  contentVersion?: string;

  /**
   * Array of SKU mappings
   */
  skuMappings?: SkuMappings[];
}

/**
 * SKU Mapping details.
 */
model SkuMappings {
  /**
   * Identifier of the CatalogPlan for the sku
   */
  catalogPlanId?: string;

  /**
   * Identifier for the sku
   */
  marketplaceSkuId?: string;

  /**
   * Array of SKU versions available
   */
  marketplaceSkuVersions?: string[];
}

/**
 * Publisher properties.
 */
model PublisherProperties {
  /**
   * Provisioning State
   */
  @visibility("read")
  provisioningState?: string;
}

/**
 * SKU properties.
 */
model SkuProperties {
  /**
   * Provisioning State
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Identifier of the Publisher for the offer
   */
  publisherId?: string;

  /**
   * Identifier of the Offer for the sku
   */
  offerId?: string;

  /**
   * JSON serialized catalog content of the sku offer
   */
  content?: string;

  /**
   * The API version of the catalog service used to serve the catalog content
   */
  contentVersion?: string;

  /**
   * Array of SKU mappings
   */
  skuMappings?: SkuMappings[];
}

/**
 * Details of an Update run
 */
model UpdateRunProperties {
  /**
   * Provisioning state of the UpdateRuns proxy resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Timestamp of the update run was started.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeStarted?: utcDateTime;

  /**
   * Timestamp of the most recently completed step in the update run.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  /**
   * Duration of the update run.
   */
  duration?: string;

  /**
   * State of the update run.
   */
  state?: UpdateRunPropertiesState;

  /**
   * Progress representation of the update run steps.
   */
  @extension("x-ms-client-flatten", true)
  progress?: Step;
}

/**
 * Progress representation of the update run steps.
 */
model Step {
  /**
   * Name of the step.
   */
  name?: string;

  /**
   * More detailed description of the step.
   */
  description?: string;

  /**
   * Error message, specified if the step is in a failed state.
   */
  errorMessage?: string;

  /**
   * Status of the step, bubbled up from the ECE action plan for installation attempts. Values are: 'Success', 'Error', 'InProgress', and 'Unknown status'.
   */
  status?: string;

  /**
   * When the step started, or empty if it has not started executing.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  /**
   * When the step reached a terminal state.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc?: utcDateTime;

  /**
   * Completion time of this step or the last completed sub-step.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTimeUtc?: utcDateTime;

  /**
   * Recursive model for child steps of this step.
   */
  steps?: Step[];
}

/**
 * Properties of Update summaries
 */
model UpdateSummariesProperties {
  /**
   * Provisioning state of the UpdateSummaries proxy resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * OEM family name.
   */
  oemFamily?: string;

  /**
   * Name of the hardware model.
   */
  hardwareModel?: string;

  /**
   * Current version of each updatable component.
   */
  @extension("x-ms-client-flatten", true)
  packageVersions?: PackageVersionInfo[];

  /**
   * Current Solution Bundle version of the stamp.
   */
  currentVersion?: string;

  /**
   * Last time an update installation completed successfully.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  /**
   * Last time the update service successfully checked for updates
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastChecked?: utcDateTime;

  /**
   * Overall health state for update-specific health checks.
   */
  @extension("x-ms-client-flatten", true)
  healthState?: HealthState;

  /**
   * An array of pre-check result objects.
   */
  @extension("x-ms-client-flatten", true)
  healthCheckResult?: PrecheckResult[];

  /**
   * Last time the package-specific checks were run.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  healthCheckDate?: utcDateTime;

  /**
   * Overall update state of the stamp.
   */
  state?: UpdateSummariesPropertiesState;
}

/**
 * Current version of each updatable component.
 */
model PackageVersionInfo {
  /**
   * Package type
   */
  packageType?: string;

  /**
   * Package version
   */
  version?: string;

  /**
   * Last time this component was updated.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;
}

model PrecheckResult {
  /**
   * Name of the individual test/rule/alert that was executed. Unique, not exposed to the customer.
   */
  name?: string;

  /**
   * Key-value pairs that allow grouping/filtering individual tests.
   */
  tags?: PrecheckResultTags;

  /**
   * User-facing name; one or more sentences indicating the direct issue.
   */
  title?: string;

  /**
   * The status of the check running (i.e. Failed, Succeeded, In Progress). This answers whether the check ran, and passed or failed.
   */
  status?: Status;

  /**
   * Severity of the result (Critical, Warning, Informational, Hidden). This answers how important the result is. Critical is the only update-blocking severity.
   */
  severity?: Severity;

  /**
   * Detailed overview of the issue and what impact the issue has on the stamp.
   */
  description?: string;

  /**
   * Set of steps that can be taken to resolve the issue found.
   */
  remediation?: string;

  /**
   * The unique identifier for the affected resource (such as a node or drive).
   */
  targetResourceID?: string;

  /**
   * The name of the affected resource.
   */
  targetResourceName?: string;

  /**
   * The Time in which the HealthCheck was called.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * Property bag of key value pairs for additional information.
   */
  additionalData?: string;

  /**
   * The name of the services called for the HealthCheck (I.E. Test-AzureStack, Test-Cluster).
   */
  healthCheckSource?: string;
}

/**
 * Key-value pairs that allow grouping/filtering individual tests.
 */
model PrecheckResultTags {
  /**
   * Key that allow grouping/filtering individual tests.
   */
  key?: string;

  /**
   * Value of the key that allow grouping/filtering individual tests.
   */
  value?: string;
}

/**
 * Details of a singular Update in HCI Cluster
 */
model UpdateProperties {
  /**
   * Provisioning state of the Updates proxy resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Date that the update was installed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  installedDate?: utcDateTime;

  /**
   * Description of the update.
   */
  description?: string;

  /**
   * State of the update as it relates to this stamp.
   */
  state?: State;

  /**
   * If update State is HasPrerequisite, this property contains an array of objects describing prerequisite updates before installing this update. Otherwise, it is empty.
   */
  prerequisites?: UpdatePrerequisite[];

  /**
   * An array of component versions for a Solution Bundle update, and an empty array otherwise.
   */
  @extension("x-ms-client-flatten", true)
  componentVersions?: PackageVersionInfo[];

  @extension("x-ms-client-flatten", true)
  rebootRequired?: RebootRequirement;

  /**
   * Overall health state for update-specific health checks.
   */
  @extension("x-ms-client-flatten", true)
  healthState?: HealthState;

  /**
   * An array of PrecheckResult objects.
   */
  @extension("x-ms-client-flatten", true)
  healthCheckResult?: PrecheckResult[];

  /**
   * Last time the package-specific checks were run.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  healthCheckDate?: utcDateTime;

  /**
   * Path where the update package is available.
   */
  packagePath?: string;

  /**
   * Size of the package. This value is a combination of the size from update metadata and size of the payload that results from the live scan operation for OS update content.
   */
  packageSizeInMb?: float32;

  /**
   * Display name of the Update
   */
  displayName?: string;

  /**
   * Version of the update.
   */
  version?: string;

  /**
   * Publisher of the update package.
   */
  publisher?: string;

  /**
   * Link to release notes for the update.
   */
  releaseLink?: string;

  /**
   * Indicates the way the update content can be downloaded.
   */
  availabilityType?: AvailabilityType;

  /**
   * Customer-visible type of the update.
   */
  packageType?: string;

  /**
   * Extensible KV pairs serialized as a string. This is currently used to report the stamp OEM family and hardware model information when an update is flagged as Invalid for the stamp based on OEM type.
   */
  additionalProperties?: string;

  /**
   * Additional information regarding the state of the update. See definition of UpdateStateProperties type below for more details on this property.
   */
  @extension("x-ms-client-flatten", true)
  updateStateProperties?: UpdateStateProperties;
}

/**
 * If update State is HasPrerequisite, this property contains an array of objects describing prerequisite updates before installing this update. Otherwise, it is empty.
 */
model UpdatePrerequisite {
  /**
   * Updatable component type.
   */
  updateType?: string;

  /**
   * Version of the prerequisite.
   */
  version?: string;

  /**
   * Friendly name of the prerequisite.
   */
  packageName?: string;
}

/**
 * Additional information regarding the state of the update. See definition of UpdateStateProperties type below for more details on this property.
 */
model UpdateStateProperties {
  /**
   * Progress percentage of ongoing operation. Currently this property is only valid when the update is in the Downloading state, where it maps to how much of the update content has been downloaded.
   */
  progressPercentage?: float32;

  /**
   * Brief message with instructions for updates of AvailabilityType Notify.
   */
  notifyMessage?: string;
}

/**
 * Connectivity related configuration required by arc server.
 */
model ArcConnectivityProperties {
  /**
   * True indicates ARC connectivity is enabled
   */
  enabled?: boolean;
}
