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
 * The status of the operation performed on the gallery image [Succeeded, Failed, InProgress]
 */
enum Status {
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
 * Network protocol this rule applies to.
 */
enum SecurityRuleProtocol {
  Tcp,
  Udp,
  Icmp,
  Asterisk: "*",
}

/**
 * Whether network traffic is allowed or denied.
 */
enum SecurityRuleAccess {
  Allow,
  Deny,
}

/**
 * The direction of the rule. The direction specifies if rule will be evaluated on incoming or outgoing traffic.
 */
enum SecurityRuleDirection {
  Inbound,
  Outbound,
}

/**
 * The current provisioning state.
 */
enum ProvisioningState {
  Succeeded,
  Updating,
  Deleting,
  Failed,
  Canceled,
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
 * The status of whether secure boot is enabled.
 */
enum AttestSecureBootPropertyEnum {
  Enabled,
  Disabled,
  Unknown,
}

/**
 * The status of whether attestation certificate is validated.
 */
enum AttestCertPropertyEnum {
  Valid,
  Invalid,
  Unknown,
}

/**
 * The status of whether the list of boot integrity properties is validated.
 */
enum AttestBootIntegrityPropertyEnum {
  Valid,
  Invalid,
  Unknown,
}

/**
 * The health status of attestation validation and parsing
 */
enum AttestHealthStatusEnum {
  Pending,
  Healthy,
  Unhealthy,
  Unknown,
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
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility("read")
  id?: ResourceIdentifier;

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

  /**
   * The reference of the NetworkSecurityGroup resource.
   */
  networkSecurityGroup?: NetworkSecurityGroup;
}

/**
 * IPConfigurationReference - Describes a IPConfiguration under the virtual network
 */
model SubnetPropertiesFormatIpConfigurationReferencesItem {
  /**
   * IPConfigurationID
   */
  id?: string;
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
 * Network Security Group resource.
 */
model NetworkSecurityGroupPropertiesFormat {
  /**
   * A collection of security rules of the network security group.
   */
  securityRules?: SecurityRule[];

  /**
   * The default security rules of network security group.
   */
  @visibility("read")
  defaultSecurityRules?: SecurityRule[];

  /**
   * A collection of references to network interfaces that are currently using this NSG.
   */
  @visibility("read")
  networkInterfaces?: NetworkInterfaces[];

  /**
   * A collection of references to subnets that are currently using this NSG
   */
  @visibility("read")
  subnets?: Subnet[];

  /**
   * The resource GUID property of the network security group resource.
   */
  @visibility("read")
  resourceGuid?: string;

  /**
   * The provisioning state of the network security group resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Network security rule.
 */
model SecurityRule {
  /**
   * Properties of the security rule.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SecurityRulePropertiesFormat;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  name?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility("read")
  etag?: string;

  /**
   * The type of the resource.
   */
  type?: string;
}

/**
 * Security rule resource.
 */
model SecurityRulePropertiesFormat {
  /**
   * A description for this rule. Restricted to 140 chars.
   */
  description?: string;

  /**
   * Network protocol this rule applies to.
   */
  protocol: SecurityRuleProtocol;

  /**
   * The source port or range. Integer or range between 0 and 65535. Asterisk '*' can also be used to match all ports.
   */
  sourcePortRange?: string;

  /**
   * The destination port or range. Integer or range between 0 and 65535. Asterisk '*' can also be used to match all ports.
   */
  destinationPortRange?: string;

  /**
   * The CIDR or source IP range. Asterisk '*' can also be used to match all source IPs. Default tags such as 'VirtualNetwork', 'AzureLoadBalancer' and 'Internet' can also be used. If this is an ingress rule, specifies where network traffic originates from.
   */
  sourceAddressPrefix?: string;

  /**
   * The CIDR or source IP ranges.
   */
  sourceAddressPrefixes?: string[];

  /**
   * The destination address prefix. CIDR or destination IP range. Asterisk '*' can also be used to match all source IPs. Default tags such as 'VirtualNetwork', 'AzureLoadBalancer' and 'Internet' can also be used.
   */
  destinationAddressPrefix?: string;

  /**
   * The destination address prefixes. CIDR or destination IP ranges.
   */
  destinationAddressPrefixes?: string[];

  /**
   * The source port ranges.
   */
  sourcePortRanges?: string[];

  /**
   * The destination port ranges.
   */
  destinationPortRanges?: string[];

  /**
   * The network traffic is allowed or denied.
   */
  access: SecurityRuleAccess;

  /**
   * The priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
   */
  priority: int32;

  /**
   * The direction of the rule. The direction specifies if rule will be evaluated on incoming or outgoing traffic.
   */
  direction: SecurityRuleDirection;
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
   * The reference to the NetworkSecurityGroup resource.
   */
  networkSecurityGroup?: NetworkSecurityGroup;

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
 * The network interface resource patch definition.
 */
model NetworkInterfacesUpdateRequest {
  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * Tags object for patch operations.
 */
model TagsObject {
  /**
   * Resource tags.
   */
  tags?: Record<string>;
}

/**
 * Response for ListSecurityRule API service call. Retrieves all security rules that belongs to a network security group.
 */
model SecurityRuleListResult is Azure.Core.Page<SecurityRule>;

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
   * The principal ID of resource identity. The value must be an UUID.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of resource. The value must be an UUID.
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
   * Provisioning state of the virtual machine instance.
   */
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;
}

/**
 * Defines the attestation status properties
 */
model AttestationStatusProperties {
  /**
   * The status of whether secure boot is enabled.
   */
  @visibility("read")
  attestSecureBootEnabled?: AttestSecureBootPropertyEnum = AttestSecureBootPropertyEnum.Unknown;

  /**
   * The status of whether attestation certificate is validated.
   */
  @visibility("read")
  attestationCertValidated?: AttestCertPropertyEnum = AttestCertPropertyEnum.Unknown;

  /**
   * The status of whether the list of boot integrity properties is validated.
   */
  @visibility("read")
  bootIntegrityValidated?: AttestBootIntegrityPropertyEnum = AttestBootIntegrityPropertyEnum.Unknown;

  /**
   * kernel version string for Linux VM.
   */
  @visibility("read")
  linuxKernelVersion?: string;

  /**
   * The health status of attestation validation and parsing
   */
  @visibility("read")
  healthStatus?: AttestHealthStatusEnum = AttestHealthStatusEnum.Unknown;

  /**
   * The time stamp of the last time attestation token is validated by relying party service.
   */
  @visibility("read")
  timestamp?: string;

  /**
   * The error message of attestation validation and parsing
   */
  @visibility("read")
  errorMessage?: string;

  /**
   * Provisioning state of the virtual machine instance.
   */
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;
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
   * Provisioning state of the virtual machine instance.
   */
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;
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
