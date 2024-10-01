import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureStackHCI;

@doc("Datasource for the gallery image when provisioning with cloud-init [NoCloud, Azure]")
union CloudInitDataSource {
  @doc("NoCloud is used as the datasource")
  NoCloud: "NoCloud",

  @doc("Azure is used as the datasource")
  Azure: "Azure",

  string,
}

@doc("The hypervisor generation of the Virtual Machine [V1, V2]")
union HyperVGeneration {
  @doc("Generation 1 (V1) hypervisor")
  V1: "V1",

  @doc("Generation 2 (V2) hypervisor")
  V2: "V2",

  string,
}

@doc("Provisioning state of the resource.")
union ProvisioningStateEnum {
  @doc("Provisioning has succeeded")
  Succeeded: "Succeeded",

  @doc("Provisioning has failed")
  Failed: "Failed",

  @doc("Provisioning is in progress")
  InProgress: "InProgress",

  @doc("Provisioning has been accepted")
  Accepted: "Accepted",

  @doc("Deletion of the resource is in progress")
  Deleting: "Deleting",

  @doc("Provisioning has been canceled")
  Canceled: "Canceled",

  string,
}

@doc("The status of the operation performed on the resource [Succeeded, Failed, InProgress]")
union Status {
  @doc("Operation succeeded")
  Succeeded: "Succeeded",

  @doc("Operation failed")
  Failed: "Failed",

  @doc("Operation is in progress")
  InProgress: "InProgress",

  string,
}

@doc("The type of extendedLocation.")
union ExtendedLocationTypes {
  @doc("Custom extended location type")
  CustomLocation: "CustomLocation",

  string,
}

@doc("IPAllocationMethod - The IP address allocation method. Possible values include: 'Static', 'Dynamic'")
union IpAllocationMethodEnum {
  @doc("Dynamic IP allocation method")
  Dynamic: "Dynamic",

  @doc("Static IP allocation method")
  Static: "Static",

  string,
}

@doc("Network protocol this rule applies to.")
union SecurityRuleProtocol {
  @doc("Transmission Control Protocol")
  Tcp: "Tcp",

  @doc("User Datagram Protocol")
  Udp: "Udp",

  @doc("Internet Control Message Protocol")
  Icmp: "Icmp",

  @doc("Wildcard rule for all protocols")
  Asterisk: "*",

  string,
}

@doc("Whether network traffic is allowed or denied.")
union SecurityRuleAccess {
  @doc("Network traffic is allowed")
  Allow: "Allow",

  @doc("Network traffic is denied")
  Deny: "Deny",

  string,
}

@doc("The direction of the rule. The direction specifies if rule will be evaluated on incoming or outgoing traffic.")
union SecurityRuleDirection {
  @doc("Rule is evaluated on incoming traffic")
  Inbound: "Inbound",

  @doc("Rule is evaluated on outgoing traffic")
  Outbound: "Outbound",

  string,
}

@doc("The format of the actual VHD file [vhd, vhdx]")
union DiskFileFormat {
  @doc("VHDX file format")
  vhdx: "vhdx",

  @doc("VHD file format")
  vhd: "vhd",

  string,
}

@doc("VM Sizes")
union VmSizeEnum {
  @doc("Default virtual machine size")
  Default: "Default",

  @doc("Standard A2 v2 virtual machine size")
  Standard_A2_v2: "Standard_A2_v2",

  @doc("Standard A4 v2 virtual machine size")
  Standard_A4_v2: "Standard_A4_v2",

  @doc("Standard D2s v3 virtual machine size")
  Standard_D2s_v3: "Standard_D2s_v3",

  @doc("Standard D4s v3 virtual machine size")
  Standard_D4s_v3: "Standard_D4s_v3",

  @doc("Standard D8s v3 virtual machine size")
  Standard_D8s_v3: "Standard_D8s_v3",

  @doc("Standard D16s v3 virtual machine size")
  Standard_D16s_v3: "Standard_D16s_v3",

  @doc("Standard D32s v3 virtual machine size")
  Standard_D32s_v3: "Standard_D32s_v3",

  @doc("Standard DS2 v2 virtual machine size")
  Standard_DS2_v2: "Standard_DS2_v2",

  @doc("Standard DS3 v2 virtual machine size")
  Standard_DS3_v2: "Standard_DS3_v2",

  @doc("Standard DS4 v2 virtual machine size")
  Standard_DS4_v2: "Standard_DS4_v2",

  @doc("Standard DS5 v2 virtual machine size")
  Standard_DS5_v2: "Standard_DS5_v2",

  @doc("Standard DS13 v2 virtual machine size")
  Standard_DS13_v2: "Standard_DS13_v2",

  @doc("Standard K8S v1 virtual machine size")
  Standard_K8S_v1: "Standard_K8S_v1",

  @doc("Standard K8S2 v1 virtual machine size")
  Standard_K8S2_v1: "Standard_K8S2_v1",

  @doc("Standard K8S3 v1 virtual machine size")
  Standard_K8S3_v1: "Standard_K8S3_v1",

  @doc("Standard K8S4 v1 virtual machine size")
  Standard_K8S4_v1: "Standard_K8S4_v1",

  @doc("Standard NK6 virtual machine size")
  Standard_NK6: "Standard_NK6",

  @doc("Standard NK12 virtual machine size")
  Standard_NK12: "Standard_NK12",

  @doc("Standard NV6 virtual machine size")
  Standard_NV6: "Standard_NV6",

  @doc("Standard NV12 virtual machine size")
  Standard_NV12: "Standard_NV12",

  @doc("Standard K8S5 v1 virtual machine size")
  Standard_K8S5_v1: "Standard_K8S5_v1",

  @doc("Custom virtual machine size")
  Custom: "Custom",

  string,
}

@added(Versions.v2024_05_01_preview)
@doc("Gpu Assignment types")
union GpuAssignmentTypeEnum {
  @doc("Attach Graphics Processing Unit (GPU) using Discrete Device Assignment (DDA)")
  GpuDDA: "GpuDDA",

  @doc("Attach Graphics Processing Unit (GPU) using GPU Partitioning")
  GpuP: "GpuP",

  string,
}

@doc("Specifies the SecurityType of the virtual machine. EnableTPM and SecureBootEnabled must be set to true for SecurityType to function.")
union SecurityTypes {
  @doc("Trusted Launch security type")
  TrustedLaunch: "TrustedLaunch",

  @doc("Confidential VM security type")
  ConfidentialVM: "ConfidentialVM",

  string,
}

@doc("The level code.")
union StatusLevelTypes {
  @doc("Informational status level")
  Info: "Info",

  @doc("Warning status level")
  Warning: "Warning",

  @doc("Error status level")
  Error: "Error",

  string,
}

@doc("The power state of the virtual machine instance")
union PowerStateEnum {
  @doc("Virtual machine deallocated")
  Deallocated: "Deallocated",

  @doc("Virtual machine deallocating")
  Deallocating: "Deallocating",

  @doc("Virtual machine running")
  Running: "Running",

  @doc("Virtual machine starting")
  Starting: "Starting",

  @doc("Virtual machine stopped")
  Stopped: "Stopped",

  @doc("Virtual machine stopping")
  Stopping: "Stopping",

  @doc("Virtual machine paused")
  Paused: "Paused",

  @doc("Virtual machine Saved,")
  Saved: "Saved",

  @doc("Power state of the virtual machine is unknown")
  Unknown: "Unknown",

  string,
}

@doc("The installation status of the hybrid machine agent installation.")
union StatusTypes {
  @doc("Installation succeeded")
  Succeeded: "Succeeded",

  @doc("Installation in progress")
  InProgress: "InProgress",

  @doc("Installation failed")
  Failed: "Failed",

  string,
}

@doc("The status of whether secure boot is enabled.")
union AttestSecureBootPropertyEnum {
  @doc("Secure boot enabled")
  Enabled: "Enabled",

  @doc("Secure boot disabled")
  Disabled: "Disabled",

  @doc("Secure boot status is unknown")
  Unknown: "Unknown",

  string,
}

@doc("The status of whether attestation certificate is validated.")
union AttestCertPropertyEnum {
  @doc("Attestation certificate is valid")
  Valid: "Valid",

  @doc("Attestation certificate is invalid")
  Invalid: "Invalid",

  @doc("Attestation certificate status is unknown")
  Unknown: "Unknown",

  string,
}

@doc("The status of whether the list of boot integrity properties is validated.")
union AttestBootIntegrityPropertyEnum {
  @doc("Boot integrity properties are valid")
  Valid: "Valid",

  @doc("Boot integrity properties are invalid")
  Invalid: "Invalid",

  @doc("Boot integrity properties status is unknown")
  Unknown: "Unknown",

  string,
}

@doc("The health status of attestation validation and parsing")
union AttestHealthStatusEnum {
  @doc("Attestation validation and parsing pending")
  Pending: "Pending",

  @doc("Attestation validation and parsing healthy")
  Healthy: "Healthy",

  @doc("Attestation validation and parsing unhealthy")
  Unhealthy: "Unhealthy",

  @doc("Attestation validation and parsing status is unknown")
  Unknown: "Unknown",

  string,
}

@doc("Defines the different types of operations for guest agent.")
union ProvisioningAction {
  @doc("Install guest agent")
  install: "install",

  @doc("Uninstall guest agent")
  uninstall: "uninstall",

  @doc("Repair guest agent")
  repair: "repair",

  string,
}

@doc("Operating system type that the gallery image uses [Windows, Linux]")
union OperatingSystemTypes {
  @doc("Windows operating system")
  Windows: "Windows",

  @doc("Linux operating system")
  Linux: "Linux",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a short form. The casing is correct."
@doc("Type of the IP Pool [vm, vippool]")
union IPPoolTypeEnum {
  @doc("Virtual Machine IP Pool")
  vm: "vm",

  @doc("VIP Pool")
  vippool: "vippool",

  string,
}

@doc("The ARM ID for a Network Interface.")
model NetworkInterfaceArmReference {
  @doc("The ARM ID for a Network Interface.")
  id?: armResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/networkInterfaces";
    }
  ]>;
}
@doc("The ARM ID for a Network Interface.")
model SubnetIpConfigurationReference {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "ID is already shipped. Changing the casing is a breaking change."
  @doc("The ARM ID for a Network Interface.")
  ID?: armResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/networkInterfaces";
    }
  ]>;
}

@doc("The ARM ID for a Network Security Group.")
model NetworkSecurityGroupArmReference {
  @doc("The ARM ID for a Network Security Group.")
  id?: armResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/networkSecurityGroups";
    }
  ]>;
}

@doc("The ARM ID for a Logical Network.")
model LogicalNetworkArmReference {
  @doc("The ARM ID for a Logical Network.")
  id?: armResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/logicalNetworks";
    }
  ]>;
}

@doc("The ARM ID for a Virtual Machine.")
model VirtualMachineArmReference {
  @doc("The ARM ID for a Virtual Machine.")
  id?: armResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/virtualMachineInstance";
    }
  ]>;
}

@doc("The ARM ID for a Storage Container.")
model StorageContainerArmReference {
  @doc("The ARM ID for a Storage Container.")
  id?: armResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/storageContainers";
    }
  ]>;
}

@doc("The ARM ID for a Gallery Image.")
model ImageArmReference {
  @doc("The ARM ID for an image resource used by the virtual machine instance.")
  @visibility("create", "read")
  id?: armResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/galleryImages";
    },
    {
      type: "Microsoft.AzureStackHCI/marketplaceGalleryImages";
    }
  ]>;
}

@doc("The ARM ID for a Virtual Hard Disk.")
model VirtualHardDiskArmReference {
  @doc("The ARM ID for a Virtual Hard Disk.")
  id?: armResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/virtualHardDisks";
    }
  ]>;
}

@doc("Properties under the gallery image resource")
model GalleryImageProperties {
  @doc("Storage ContainerID of the storage container to be used for gallery image")
  containerId?: armResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/storageContainers";
    }
  ]>;

  @doc("location of the image the gallery image should be created from")
  @secret
  imagePath?: string;

  @doc("Operating system type that the gallery image uses [Windows, Linux]")
  osType: OperatingSystemTypes;

  @doc("Datasource for the gallery image when provisioning with cloud-init [NoCloud, Azure]")
  cloudInitDataSource?: CloudInitDataSource;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "HyperV is the correct case."
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

  @added(Versions.v2024_05_01_preview)
  @doc("Resource ID of the source virtual machine from whose OS disk the gallery image is created.")
  sourceVirtualMachineId?: armResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/virtualMachineInstance";
    }
  ]>;
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

  #suppress "deprecated" "Legacy flattening"
  @doc("Describes the properties of a gallery image version.")
  @Azure.ClientGenerator.Core.flattenProperty
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

@doc("This is the disk image base class.")
model GalleryDiskImage {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB is a short form."
  @doc("This property indicates the size of the VHD to be created.")
  @visibility("read")
  sizeInMB?: int64;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "OS is a short form. GalleryOSDiskImage is the correct case."
@doc("This is the OS disk image.")
model GalleryOSDiskImage {
  ...GalleryDiskImage;
  // Add additional properties specific to GalleryOSDiskImage if needed
}

@doc("The observed state of gallery images")
model GalleryImageStatus {
  @doc("GalleryImage provisioning error code")
  errorCode?: string;

  @doc("Descriptive error message")
  errorMessage?: string;

  @doc("provisioning status of the gallery image")
  provisioningStatus?: GalleryImageStatusProvisioningStatus;

  @doc("The download status of the gallery image")
  downloadStatus?: GalleryImageStatusDownloadStatus;

  @doc("The progress of the operation in percentage")
  progressPercentage?: int64;
}

@doc("The status of the operation performed on the gallery image")
model GalleryImageStatusProvisioningStatus {
  @doc("The ID of the operation performed on the gallery image")
  operationId?: string;

  @doc("The status of the operation performed on the gallery image [Succeeded, Failed, InProgress]")
  status?: Status;
}

@doc("The download status of the gallery image")
model GalleryImageStatusDownloadStatus {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB should be referenced as MB."
  @doc("The downloaded sized of the image in MB")
  downloadSizeInMB?: int64;
}

@doc("The complex type of the extended location.")
model ExtendedLocation {
  @doc("The name of the extended location.")
  name?: string;

  @doc("The type of the extended location.")
  type?: ExtendedLocationTypes;
}

@doc("The gallery images resource patch definition.")
model GalleryImagesUpdateRequest {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("Properties under the logical network resource")
model LogicalNetworkProperties {
  @doc("DhcpOptions contains an array of DNS servers available to VMs deployed in the logical network. Standard DHCP option for a subnet overrides logical network DHCP options.")
  dhcpOptions?: LogicalNetworkPropertiesDhcpOptions;

  @doc("Subnet - list of subnets under the logical network")
  @OpenAPI.extension("x-ms-identifiers", [])
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

@doc("Properties of the subnet.")
model Subnet {
  #suppress "deprecated" "Legacy flattening"
  @doc("Properties of the subnet.")
  @Azure.ClientGenerator.Core.flattenProperty
  properties?: SubnetProperties;

  @doc("Name - The name of the resource that is unique within a resource group. This name can be used to access the resource.")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[_a-zA-Z0-9]$")
  name?: string;
}

@doc("Properties of the subnet.")
model SubnetProperties {
  @doc("The address prefix for the subnet: Cidr for this subnet - IPv4, IPv6.")
  addressPrefix?: string;

  @doc("List of address prefixes for the subnet.")
  addressPrefixes?: string[];

  @doc("IPAllocationMethod - The IP address allocation method. Possible values include: 'Static', 'Dynamic'")
  ipAllocationMethod?: IpAllocationMethodEnum;

  @doc("IPConfigurationReferences - list of IPConfigurationReferences")
  @extension("x-ms-identifiers", [])
  ipConfigurationReferences?: SubnetIpConfigurationReference[];

  @doc("NetworkSecurityGroup - Network Security Group attached to the logical network.")
  networkSecurityGroup?: NetworkSecurityGroupArmReference;

  @doc("Route table resource.")
  routeTable?: RouteTable;

  @doc("network associated pool of IP Addresses")
  @extension("x-ms-identifiers", [])
  ipPools?: IPPool[];

  @doc("Vlan to use for the subnet")
  vlan?: int32;
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

  #suppress "deprecated" "LEGACY flattening"
  @doc("Properties of the route table.")
  @Azure.ClientGenerator.Core.flattenProperty
  properties?: RouteTableProperties;
}

@doc("RouteTablePropertiesFormat - Route Table resource.")
model RouteTableProperties {
  @doc("Collection of routes contained within a route table.")
  @extension("x-ms-identifiers", [])
  routes?: Route[];
}

@doc("Route - Route resource.")
model Route {
  #suppress "deprecated" "Legacy flattend property"
  @doc("Properties of the route.")
  @Azure.ClientGenerator.Core.flattenProperty
  properties?: RouteProperties;

  @doc("Name - name of the subnet")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[_a-zA-Z0-9]$")
  name?: string;
}

@doc("RoutePropertiesFormat - Route resource.")
model RouteProperties {
  @doc("The destination CIDR to which the route applies.")
  addressPrefix?: string;

  @doc("The IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance.")
  nextHopIpAddress?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a short form. The casing is correct."
@doc("Describes IPPool")
model IPPool {
  @doc("Name of the IP-Pool")
  name?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a short form. The casing is correct."
  @doc("Type of the IP Pool [vm, vippool]")
  ipPoolType?: IPPoolTypeEnum;

  @doc("Start of the IP address pool")
  start?: string;

  @doc("End of the IP address pool")
  end?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a short form. The casing is correct."
  @doc("IPPool info")
  info?: IPPoolInfo;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a short form. The casing is correct."
@doc("IP Pool info")
model IPPoolInfo {
  @doc("Number of IP addresses allocated from the IP Pool")
  @visibility("read")
  used?: string;

  @doc("Number of IP addresses available in the IP Pool")
  @visibility("read")
  available?: string;
}

@doc("Network Security Group resource.")
model NetworkSecurityGroupProperties {
  @doc("A collection of references to network interfaces that are currently using this NSG.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  networkInterfaces?: NetworkInterfaceArmReference[];

  @doc("A collection of references to logical networks that are currently using this NSG")
  @visibility("read")
  subnets?: LogicalNetworkArmReference[];

  @doc("The provisioning state of the network security group resource.")
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;
}

@doc("Security rule resource.")
model SecurityRuleProperties {
  @doc("A description for this rule. Restricted to 140 chars.")
  description?: string;

  @doc("Network protocol this rule applies to.")
  protocol: SecurityRuleProtocol;

  @doc("The CIDR or source IP ranges.")
  sourceAddressPrefixes?: string[];

  @doc("The destination address prefixes. CIDR or destination IP ranges.")
  destinationAddressPrefixes?: string[];

  @doc("The source port ranges. Integer or range between 0 and 65535. Asterisk '*' can also be used to match all ports.")
  sourcePortRanges?: string[];

  @doc("The destination port ranges. Integer or range between 0 and 65535. Asterisk '*' can also be used to match all ports.")
  destinationPortRanges?: string[];

  @doc("The network traffic is allowed or denied.")
  access: SecurityRuleAccess;

  @doc("The priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.")
  priority: int32;

  @doc("The direction of the rule. The direction specifies if rule will be evaluated on incoming or outgoing traffic.")
  direction: SecurityRuleDirection;

  @doc("Provisioning state of the SR")
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;
}

@doc("Properties under the network interface resource")
model NetworkInterfaceProperties {
  @doc("IPConfigurations - A list of IPConfigurations of the network interface.")
  @extension("x-ms-identifiers", [])
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

  @doc("NetworkSecurityGroup - Network Security Group attached to the network interface.")
  networkSecurityGroup?: NetworkSecurityGroupArmReference;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a short form. The casing is correct."
@doc("InterfaceIPConfiguration IPConfiguration in a network interface.")
model IPConfiguration {
  @doc("Name - The name of the resource that is unique within a resource group. This name can be used to access the resource.")
  @visibility("read", "create")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,78}[_a-zA-Z0-9]$")
  name?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a short form. The casing is correct."
  @doc("InterfaceIPConfigurationPropertiesFormat properties of IP configuration.")
  properties?: IPConfigurationProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a short form. The casing is correct."
@doc("InterfaceIPConfigurationPropertiesFormat properties of IP configuration.")
model IPConfigurationProperties {
  @doc("Gateway for network interface")
  @visibility("read")
  gateway?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a short form. The casing is correct."
  @doc("prefixLength for network interface")
  @visibility("read")
  prefixLength?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a short form. The casing is correct."
  @doc("PrivateIPAddress - Private IP address of the IP configuration.")
  privateIPAddress?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a short form. The casing is correct."
  @doc("Subnet - Name of Subnet bound to the IP configuration.")
  subnet?: LogicalNetworkArmReference;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "DNS is a short form. The casing is correct."
@doc("DNS Settings of the interface")
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

  @doc("Network interface provisioning status")
  provisioningStatus?: NetworkInterfaceStatusProvisioningStatus;
}

@doc("Network interface provisioning status")
model NetworkInterfaceStatusProvisioningStatus {
  @doc("The ID of the operation performed on the network interface")
  operationId?: string;

  @doc("The status of the operation performed on the network interface [Succeeded, Failed, InProgress]")
  status?: Status;
}

@doc("The observed state of logical networks")
model LogicalNetworkStatus {
  @doc("LogicalNetwork provisioning error code")
  errorCode?: string;

  @doc("Descriptive error message")
  errorMessage?: string;

  @doc("Logical network provisioning status")
  provisioningStatus?: LogicalNetworkStatusProvisioningStatus;
}

@doc("Describes the status of the provisioning.")
model LogicalNetworkStatusProvisioningStatus {
  @doc("The ID of the operation performed on the logical network")
  operationId?: string;

  @doc("The status of the operation performed on the logical network [Succeeded, Failed, InProgress]")
  status?: Status;
}

@doc("The logical network resource patch definition.")
model LogicalNetworksUpdateRequest {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("Properties under the marketplace gallery image resource")
model MarketplaceGalleryImageProperties {
  @doc("Storage ContainerID of the storage container to be used for marketplace gallery image")
  containerId?: armResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/storageContainers";
    }
  ]>;

  @doc("Operating system type that the gallery image uses [Windows, Linux]")
  osType: OperatingSystemTypes;

  @doc("Datasource for the gallery image when provisioning with cloud-init [NoCloud, Azure]")
  cloudInitDataSource?: CloudInitDataSource;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "HyperV is the correct case."
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

  @doc("Provisioning status of marketplace gallery image")
  provisioningStatus?: MarketplaceGalleryImageStatusProvisioningStatus;

  @doc("The download status of the gallery image")
  downloadStatus?: MarketplaceGalleryImageStatusDownloadStatus;

  @doc("The progress of the operation in percentage")
  progressPercentage?: int64;
}

@doc("Marketplace GalleryImage provisioning status")
model MarketplaceGalleryImageStatusProvisioningStatus {
  @doc("The ID of the operation performed on the gallery image")
  operationId?: string;

  @doc("The status of the operation performed on the gallery image [Succeeded, Failed, InProgress]")
  status?: Status;
}

@doc("The download status of the gallery image")
model MarketplaceGalleryImageStatusDownloadStatus {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB is a short form."
  @doc("The downloaded sized of the image in MB")
  downloadSizeInMB?: int64;
}

@doc("The marketplace gallery image resource patch definition.")
model MarketplaceGalleryImagesUpdateRequest {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("The network interface resource patch definition.")
model NetworkInterfacesUpdateRequest {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("Tags object for patch operations.")
model TagsObject {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("Resource tags.")
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

  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB is a short form."
  @doc("Amount of space available on the disk in MB")
  availableSizeMB?: int64;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB is a short form."
  @doc("Total size of the disk in MB")
  containerSizeMB?: int64;

  @doc("Storage container's provisioning status")
  provisioningStatus?: StorageContainerStatusProvisioningStatus;
}

@doc("Storage container provisioning status")
model StorageContainerStatusProvisioningStatus {
  @doc("The ID of the operation performed on the storage container")
  operationId?: string;

  @doc("The status of the operation performed on the storage container [Succeeded, Failed, InProgress]")
  status?: Status;
}

@doc("The storage container resource patch definition.")
model StorageContainersUpdateRequest {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("Properties under the virtual hard disk resource")
model VirtualHardDiskProperties {
  @doc("Block size in bytes")
  blockSizeBytes?: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "GB is a short form."
  @doc("Size of the disk in GB")
  diskSizeGB?: int64;

  @doc("Boolean for enabling dynamic sizing on the virtual hard disk")
  dynamic?: boolean;

  @doc("Logical sector in bytes")
  logicalSectorBytes?: int32;

  @doc("Physical sector in bytes")
  physicalSectorBytes?: int32;

  @added(Versions.v2024_05_01_preview)
  @doc("URL for downloading or accessing the virtual hard disk. This URL points to a secure link from where the VHD can be downloaded or accessed directly.")
  @secret
  downloadUrl?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "HyperV is the correct case."
  @doc("The hypervisor generation of the Virtual Machine [V1, V2]")
  hyperVGeneration?: HyperVGeneration;

  @doc("The format of the actual VHD file [vhd, vhdx]")
  diskFileFormat?: DiskFileFormat;

  @doc("Provisioning state of the virtual hard disk.")
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;

  @doc("Storage ContainerID of the storage container to be used for VHD")
  containerId?: armResourceIdentifier<[
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

  @doc("Provisioning status of the vhd")
  provisioningStatus?: VirtualHardDiskStatusProvisioningStatus;

  @added(Versions.v2024_05_01_preview)
  @doc("The download status of the virtual hard disk")
  downloadStatus?: VirtualHardDiskDownloadStatus;

  @added(Versions.v2024_05_01_preview)
  @doc("The upload status of the virtual hard disk")
  uploadStatus?: VirtualHardDiskUploadStatus;
}

@doc("VHD Status provisioning status")
model VirtualHardDiskStatusProvisioningStatus {
  @doc("The ID of the operation performed on the virtual hard disk")
  operationId?: string;

  @doc("The status of the operation performed on the virtual hard disk [Succeeded, Failed, InProgress]")
  status?: Status;
}

@added(Versions.v2024_05_01_preview)
@doc("The download status of the virtual hard disk")
model VirtualHardDiskDownloadStatus {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB should be referenced as MB."
  @doc("The downloaded sized of the virtual hard disk in MB")
  downloadedSizeInMB?: int64;
}

@added(Versions.v2024_05_01_preview)
@doc("The upload status of the virtual hard disk")
model VirtualHardDiskUploadStatus {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB should be referenced as MB."
  @doc("The uploaded sized of the virtual hard disk in MB")
  uploadedSizeInMB?: int64;

  @doc("The status of Uploading virtual hard disk [Succeeded, Failed, InProgress]")
  status?: Status;
}

@doc("The virtual hard disk resource patch definition.")
model VirtualHardDisksUpdateRequest {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("Resource tags")
  tags?: Record<string>;
}

@added(Versions.v2024_05_01_preview)
@doc("Request for uploading virtual hard disk.")
model VirtualHardDiskUploadRequest {
  @doc("The Azure managed disk SAS URL to upload the virtual hard disk to.")
  @secret
  azureManagedDiskUploadUrl: string;
}

@added(Versions.v2024_05_01_preview)
@doc("Response for uploading virtual hard disk.")
model VirtualHardDiskUploadResponse {
  @doc("The ARM ID for a Virtual Hard Disk.")
  virtualHardDiskId?: armResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/virtualHardDisks";
    }
  ]>;

  @doc("The upload status of the virtual hard disk")
  uploadStatus?: VirtualHardDiskUploadStatus;
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
  @doc("Enum of VM Sizes")
  vmSize?: VmSizeEnum = VmSizeEnum.Default;

  @doc("number of processors for the virtual machine instance")
  processors?: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB is a short form."
  @doc("RAM in MB for the virtual machine instance")
  memoryMB?: int64;

  @doc("Dynamic memory config")
  dynamicMemoryConfig?: VirtualMachineInstancePropertiesHardwareProfileDynamicMemoryConfig;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "GPU is a short form. It is the correct case."
  @added(Versions.v2024_05_01_preview)
  @doc("virtualMachineGPUs - list of gpus to be attached to the virtual machine instance")
  @extension("x-ms-identifiers", [])
  virtualMachineGPUs?: VirtualMachineInstancePropertiesHardwareProfileVirtualMachineGPU[];
}

@doc("Dynamic memory config")
model VirtualMachineInstancePropertiesHardwareProfileDynamicMemoryConfig {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB is a short form."
  @doc("Maximum memory in MB")
  maximumMemoryMB?: int64;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB is a short form."
  @doc("Minimum memory in MB")
  minimumMemoryMB?: int64;

  @doc("Defines the amount of extra memory that should be reserved for a virtual machine instance at runtime, as a percentage of the total memory that the virtual machine instance is thought to need. This only applies to virtual systems with dynamic memory enabled. This property can be in the range of 5 to 2000.")
  targetMemoryBuffer?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "GPU is a short form. It is the correct case."
@added(Versions.v2024_05_01_preview)
@doc("GPU properties - describes the GPU configuration.")
model VirtualMachineInstancePropertiesHardwareProfileVirtualMachineGPU {
  @doc("GPU assignment type")
  assignmentType: GpuAssignmentTypeEnum;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB is a short form."
  @doc("Size of gpu partition in MB for GPU-P")
  partitionSizeMB?: int64;

  @doc("Name of the GPU")
  gpuName?: string;
}

@doc("NetworkProfile - describes the network configuration the virtual machine instance")
model VirtualMachineInstancePropertiesNetworkProfile {
  @doc("NetworkInterfaces - list of network interfaces to be attached to the virtual machine instance")
  @extension("x-ms-identifiers", [])
  networkInterfaces?: NetworkInterfaceArmReference[];
}

@doc("OsProfile - describes the configuration of the operating system and sets login data")
model VirtualMachineInstancePropertiesOsProfile {
  @doc("AdminPassword - admin password")
  @visibility("create")
  @secret
  adminPassword?: string;

  @doc("AdminUsername - admin username")
  adminUsername?: string;

  @doc("ComputerName - name of the compute")
  computerName?: string;

  @doc("LinuxConfiguration - linux specific configuration values for the virtual machine instance")
  linuxConfiguration?: VirtualMachineInstancePropertiesOsProfileLinuxConfiguration;

  @doc("Windows Configuration for the virtual machine instance")
  windowsConfiguration?: VirtualMachineInstancePropertiesOsProfileWindowsConfiguration;
}

@doc("LinuxConfiguration - linux specific configuration values for the virtual machine instance")
model VirtualMachineInstancePropertiesOsProfileLinuxConfiguration {
  @doc("DisablePasswordAuthentication - whether password authentication should be disabled")
  disablePasswordAuthentication?: boolean;

  @doc("Specifies the ssh key configuration for a Linux OS.")
  ssh?: SshConfiguration;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a short form. It is the correct case"
  @doc("Used to indicate whether Arc for Servers agent onboarding should be triggered during the virtual machine instance creation process.")
  provisionVMAgent?: boolean = true;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a short form. It is the correct case"
  @doc("Used to indicate whether the VM Config Agent should be installed during the virtual machine creation process.")
  provisionVMConfigAgent?: boolean = true;
}

@doc("SSH configuration for Linux based VMs running on Azure")
model SshConfiguration {
  @doc("The list of SSH public keys used to authenticate with linux based VMs.")
  @extension("x-ms-identifiers", ["path"])
  publicKeys?: SshPublicKey[];
}

@doc("Contains information about SSH certificate public key and the path on the Linux VM where the public key is placed.")
model SshPublicKey {
  @doc("Specifies the full path on the created VM where ssh public key is stored. If the file already exists, the specified key is appended to the file. Example: /home/user/.ssh/authorized_keys")
  path?: string;

  @doc("SSH public key certificate used to authenticate with the VM through ssh. The key needs to be at least 2048-bit and in ssh-rsa format. <br><br> For creating ssh keys, see [Create SSH keys on Linux and Mac for Linux VMs in Azure]https://docs.microsoft.com/azure/virtual-machines/linux/create-ssh-keys-detailed).")
  keyData?: string;
}

@doc("Windows Configuration for the virtual machine instance")
model VirtualMachineInstancePropertiesOsProfileWindowsConfiguration {
  @doc("Whether to EnableAutomaticUpdates on the machine")
  enableAutomaticUpdates?: boolean;

  @doc("Specifies the ssh key configuration for Windows OS.")
  ssh?: SshConfiguration;

  @doc("TimeZone for the virtual machine instance")
  timeZone?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a short form. It is the correct case"
  @doc("Used to indicate whether Arc for Servers agent onboarding should be triggered during the virtual machine instance creation process.")
  provisionVMAgent?: boolean = true;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a short form. It is the correct case"
  @doc("Used to indicate whether the VM Config Agent should be installed during the virtual machine creation process.")
  provisionVMConfigAgent?: boolean = true;
}

@doc("SecurityProfile - Specifies the security settings for the virtual machine instance.")
model VirtualMachineInstancePropertiesSecurityProfile {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "TPM is a short form. It is the correct case"
  @doc("Enable TPM flag")
  enableTPM?: boolean = false;

  @doc("Uefi settings of the virtual machine instance")
  uefiSettings?: VirtualMachineInstancePropertiesSecurityProfileUefiSettings;

  @doc("Specifies the SecurityType of the virtual machine. EnableTPM and SecureBootEnabled must be set to true for SecurityType to function.")
  securityType?: SecurityTypes;
}

@doc("Uefi settings - Specifies whether secure boot should be enabled on the virtual machine instance.")
model VirtualMachineInstancePropertiesSecurityProfileUefiSettings {
  @doc("Specifies whether secure boot should be enabled on the virtual machine instance.")
  secureBootEnabled?: boolean = false;
}

@doc("StorageProfile - contains information about the disks and storage information for the virtual machine instance")
model VirtualMachineInstancePropertiesStorageProfile {
  @doc("adds data disks to the virtual machine instance")
  dataDisks?: VirtualHardDiskArmReference[];

  @doc("Which Image to use for the virtual machine instance")
  @visibility("read", "create")
  imageReference?: ImageArmReference;

  @doc("VHD to attach as OS disk")
  osDisk?: VirtualMachineInstancePropertiesStorageProfileOsDisk;

  @doc("Id of the storage container that hosts the VM configuration file")
  vmConfigStoragePathId?: armResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/storageContainers";
    }
  ]>;
}

@doc("VHD to attach as OS disk")
model VirtualMachineInstancePropertiesStorageProfileOsDisk
  is VirtualHardDiskArmReference {
  @doc("This property allows you to specify the type of the OS that is included in the disk if creating a VM from user-image or a specialized VHD. Possible values are: Windows, Linux.")
  osType?: OperatingSystemTypes;
}

@doc("HTTP Proxy configuration for the VM.")
model HttpProxyConfiguration {
  @doc("The HTTP proxy server endpoint to use.")
  @secret
  httpProxy?: string;

  @doc("The HTTPS proxy server endpoint to use.")
  @secret
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
  @extension("x-ms-identifiers", [])
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

  @doc("Provisioning status of the virtual machine instance")
  provisioningStatus?: VirtualMachineInstanceStatusProvisioningStatus;
}

@doc("Virtual machine instance provisioning status.")
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
  errorDetails?: Azure.ResourceManager.Foundations.ErrorDetail[];
}

@doc("Identity for the resource.")
model Identity {
  @doc("The principal ID of resource identity. The value must be an UUID.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID of resource. The value must be an UUID.")
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

  @doc("StorageProfile - Specifies the storage settings for the virtual machine instance.")
  storageProfile?: StorageProfileUpdate;

  @doc("NetworkProfile - describes the network update configuration the virtual machine instance")
  networkProfile?: NetworkProfileUpdate;

  @doc("OsProfile - describes the update configuration of the operating system")
  osProfile?: OsProfileUpdate;
}

@doc("HardwareProfile - Specifies the hardware settings for the virtual machine instance.")
model HardwareProfileUpdate {
  @doc("VM Size Enum")
  vmSize?: VmSizeEnum;

  @doc("number of processors for the virtual machine instance")
  processors?: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "MB is a short form."
  @doc("RAM in MB for the virtual machine instance")
  memoryMB?: int64;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "GPU is a short form. It is the correct case."
  @added(Versions.v2024_05_01_preview)
  @doc("virtualMachineGPUs - updated list of GPUs on the virtual machine instance")
  @extension("x-ms-identifiers", [])
  virtualMachineGPUs?: VirtualMachineInstancePropertiesHardwareProfileVirtualMachineGPU[];
}

@doc("Storage profile update")
model StorageProfileUpdate {
  @doc("adds data disks to the virtual machine instance for the update call")
  dataDisks?: VirtualHardDiskArmReference[];
}

@doc("NetworkProfile - describes the network update configuration the virtual machine instance")
model NetworkProfileUpdate {
  @doc("NetworkInterfaces - list of network interfaces to be attached to the virtual machine instance")
  @extension("x-ms-identifiers", [])
  networkInterfaces?: NetworkInterfaceArmReference[];
}

@doc("OsProfile - describes the update configuration of the operating system")
model OsProfileUpdate {
  @doc("ComputerName - name of the computer")
  computerName?: string;

  @doc("Linux configuration properties")
  linuxConfiguration?: OsProfileUpdateLinuxConfiguration;

  @doc("Windows configuration properties")
  windowsConfiguration?: OsProfileUpdateWindowsConfiguration;
}

@doc("OSProfile update linux configuration")
model OsProfileUpdateLinuxConfiguration {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a short form. It is the correct case"
  @doc("Used to indicate whether Arc for Servers agent onboarding should be triggered during the virtual machine instance creation process.")
  provisionVMAgent?: boolean;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a short form. It is the correct case"
  @doc("Used to indicate whether the VM Config Agent should be installed during the virtual machine creation process.")
  provisionVMConfigAgent?: boolean;
}

@doc("OSProfile update windows configuration")
model OsProfileUpdateWindowsConfiguration {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a short form. It is the correct case"
  @doc("Used to indicate whether Arc for Servers agent onboarding should be triggered during the virtual machine instance creation process.")
  provisionVMAgent?: boolean;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a short form. It is the correct case"
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

  @doc("Provisioning state of the virtual machine instance.")
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;
}

@doc("Defines the attestation status properties")
model AttestationStatusProperties {
  @doc("The status of whether secure boot is enabled.")
  @visibility("read")
  attestSecureBootEnabled?: AttestSecureBootPropertyEnum = AttestSecureBootPropertyEnum.Unknown;

  @doc("The status of whether attestation certificate is validated.")
  @visibility("read")
  attestationCertValidated?: AttestCertPropertyEnum = AttestCertPropertyEnum.Unknown;

  @doc("The status of whether the list of boot integrity properties is validated.")
  @visibility("read")
  bootIntegrityValidated?: AttestBootIntegrityPropertyEnum = AttestBootIntegrityPropertyEnum.Unknown;

  @doc("kernel version string for Linux VM.")
  @visibility("read")
  linuxKernelVersion?: string;

  @doc("The health status of attestation validation and parsing")
  @visibility("read")
  healthStatus?: AttestHealthStatusEnum = AttestHealthStatusEnum.Unknown;

  @doc("The time stamp of the last time attestation token is validated by relying party service.")
  @visibility("read")
  timestamp?: string;

  @doc("The error message of attestation validation and parsing")
  @visibility("read")
  errorMessage?: string;

  @doc("Provisioning state of the virtual machine instance.")
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;
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

  @doc("Provisioning state of the virtual machine instance.")
  @visibility("read")
  provisioningState?: ProvisioningStateEnum;
}

@doc("Username / Password Credentials to connect to guest.")
model GuestCredential {
  @doc("The username to connect with the guest.")
  username?: string;

  @doc("The password to connect with the guest.")
  @visibility("create", "update")
  @secret
  password?: string;
}
