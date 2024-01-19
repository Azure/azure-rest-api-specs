import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.MobileNetwork;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The current provisioning state.")
enum ProvisioningState {
  Unknown,
  Succeeded,
  Accepted,
  Deleting,
  Failed,
  Canceled,
  Deleted,
}

@doc("Whether network address and port translation is enabled.")
enum NaptEnabled {
  @doc("NAPT is enabled") Enabled,
  @doc("NAPT is disabled") Disabled,
}

@doc("The status of the diagnostics package collection.")
enum DiagnosticsPackageStatus {
  NotStarted,
  Collecting,
  Collected,
  Error,
}

@doc("The status of the packet capture session.")
enum PacketCaptureStatus {
  NotStarted,
  Running,
  Stopped,
  Error,
}

@doc("The desired installation state of the packet core.")
enum DesiredInstallationState {
  @doc("Don't install the packet core.") Uninstalled,
  @doc("Install the packet core.") Installed,
}

@doc("The installation state of the packet core.")
enum InstallationState {
  @doc("The packet core is uninstalled.") Uninstalled,
  @doc("The packet core is installing.") Installing,
  @doc("The packet core is installed.") Installed,
  @doc("The packet core is updating its configuration.") Updating,
  @doc("The packet core is upgrading to a different software version.")
  Upgrading,
  @doc("The packet core is uninstalling.") Uninstalling,
  @doc("The packet core is reinstalling.") Reinstalling,
  @doc("The packet core is rolling back to its previous version.") RollingBack,
  @doc("The packet core is in failed state.") Failed,
}

@doc("Whether a reinstall of the packet core is required to pick up the latest configuration changes.")
enum ReinstallRequired {
  @doc("A reinstall of the packet core is required.") Required,
  @doc("A reinstall of the packet core is not required.") NotRequired,
}

@doc("The reason or list of reasons why a packet core has not been installed or requires a reinstall.")
enum InstallationReason {
  @doc("The packet core has not been installed as the mobile network does not have any applicable configured slices.")
  NoSlices,
  @doc("The packet core has not been installed as there is no configured data plane for this packet core.")
  NoPacketCoreDataPlane,
  @doc("The packet core has not been installed as the packet core has no attached data networks.")
  NoAttachedDataNetworks,
  @doc("A reinstall is required as the packet core is running with out-of-date PLMN ID.")
  PublicLandMobileNetworkIdentifierHasChanged,
  @doc("A reinstall is required as the packet core is running with out-of-date control plane access interface information.")
  ControlPlaneAccessInterfaceHasChanged,
  @doc("A reinstall is required as the packet core is running with out-of-date user plane core interface.")
  UserPlaneAccessInterfaceHasChanged,
  @doc("A reinstall is required as the packet core is running with out-of-date user plane access interface.")
  UserPlaneDataInterfaceHasChanged,
  @doc("A reinstall is required as the packet core is running with out-of-date control plane access network virtual IP address.")
  ControlPlaneAccessVirtualIpv4AddressesHasChanged,
  @doc("A reinstall is required as the packet core is running with out-of-date user plane access network virtual IP address.")
  UserPlaneAccessVirtualIpv4AddressesHasChanged,
}

@doc("The platform type where packet core is deployed. The contents of this enum can change.")
enum PlatformType {
  @doc("If this option is chosen, you must set one of \"azureStackEdgeDevice\", \"connectedCluster\" or \"customLocation\". If multiple are set, they must be consistent with each other.")
  `AKS-HCI`,
  @doc("If this option is chosen, you must set one of \"azureStackHciCluster\", \"connectedCluster\" or \"customLocation\". If multiple are set, they must be consistent with each other.")
  `3P-AZURE-STACK-HCI`,
}

@doc("The SKU of the packet core control plane resource. The SKU list may change over time when a new SKU gets added or an exiting SKU gets removed.")
enum BillingSku {
  @doc("100 Mbps, 20 active SIMs plan, 2 RANs") G0,
  @doc("1 Gbps, 100 active SIMs plan, 5 RANs") G1,
  @doc("2 Gbps, 200 active SIMs plan, 10 RANs") G2,
  @doc("5 Gbps, 500 active SIMs plan") G5,
  @doc("10 Gbps, 1000 active SIMs plan") G10,
}

@doc("How to authenticate users who access local diagnostics APIs.")
enum AuthenticationType {
  @doc("Use AAD SSO to authenticate the user (this requires internet access).")
  AAD,
  @doc("Use locally stored passwords to authenticate the user.") Password,
}

@doc("The certificate's provisioning state")
enum CertificateProvisioningState {
  @doc("The certificate has not been provisioned.") NotProvisioned,
  @doc("The certificate has been provisioned.") Provisioned,
  @doc("The certificate failed to be provisioned. The \"reason\" property explains why.")
  Failed,
}

@doc("Type of managed service identity (currently only UserAssigned allowed).")
enum ManagedServiceIdentityType {
  None,
  UserAssigned,
}

@doc("The state of this packet core control plane version.")
enum VersionState {
  @doc("The state of this version is unknown.") Unknown,
  @doc("This version is a preview and is not suitable for production use.")
  Preview,
  @doc("This version is currently being validated.") Validating,
  @doc("This version failed validation.") ValidationFailed,
  @doc("This version is active and suitable for production use.") Active,
  @doc("This version is deprecated and is no longer supported.") Deprecated,
}

@doc("Indicates whether this is the recommended version to use for new packet core control plane deployments.")
enum RecommendedVersion {
  @doc("This is the recommended version to use for new packet core control plane deployments.")
  Recommended,
  @doc("This is not the recommended version to use for new packet core control plane deployments.")
  NotRecommended,
}

@doc("Indicates whether this version is obsolete.")
enum ObsoleteVersion {
  @doc("This version is obsolete for use in new packet core control plane deployments.")
  Obsolete,
  @doc("This version is not obsolete for use in new packet core control plane deployments.")
  NotObsolete,
}

@doc("Preemption capability.")
enum PreemptionCapability {
  @doc("Cannot preempt") NotPreempt,
  @doc("May preempt") MayPreempt,
}

@doc("Preemption vulnerability.")
enum PreemptionVulnerability {
  @doc("Cannot be preempted") NotPreemptable,
  @doc("May be preempted") Preemptable,
}

@doc("Traffic control permission.")
enum TrafficControlPermission {
  @doc("Traffic matching this rule is allowed to flow.") Enabled,
  @doc("Traffic matching this rule is not allowed to flow.") Blocked,
}

@doc("Service data flow direction.")
enum SdfDirection {
  @doc("Traffic flowing from the UE to the data network.") Uplink,
  @doc("Traffic flowing from the data network to the UE.") Downlink,
  @doc("Traffic flowing both to and from the UE.") Bidirectional,
}

@doc("The state of the SIM resource.")
enum SimState {
  @doc("The SIM is disabled because not all configuration required for enabling is present.")
  Disabled,
  @doc("The SIM is enabled.") Enabled,
  @doc("The SIM cannot be enabled because some of the associated configuration is invalid.")
  Invalid,
}

@doc("The provisioning state of a resource e.g. SIM/SIM policy on a site.")
enum SiteProvisioningState {
  @doc("The resource should not be provisioned on this site.") NotApplicable,
  @doc("The resource is being added to this site.") Adding,
  @doc("The resource is being updated on this site.") Updating,
  @doc("The resource is being deleted from this site.") Deleting,
  @doc("The resource is provisioned on this site.") Provisioned,
  @doc("The resource failed to be provisioned on this site.") Failed,
}

@doc("PDU session type (IPv4/IPv6).")
enum PduSessionType {
  IPv4,
  IPv6,
}

@doc("The core network technology generation (5G core, EPC / 4G core or EPC / 4G + 5G core).")
@fixed
enum CoreNetworkType {
  @doc("5G core") `5GC`,
  @doc("EPC / 4G core") EPC,
  @doc("Combined EPC / 4G and 5G core") `EPC + 5GC`,
}

@doc("Data network properties.")
model AttachedDataNetworkPropertiesFormat {
  @doc("The provisioning state of the attached data network resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The user plane interface on the data network. For 5G networks, this is the N6 interface. For 4G networks, this is the SGi interface.")
  userPlaneDataInterface: InterfaceProperties;

  @doc("The DNS servers to signal to UEs to use for this attached data network. This configuration is mandatory - if you don't want DNS servers, you must provide an empty array.")
  dnsAddresses: string[];

  @doc("""
The network address and port translation (NAPT) configuration.
If this is not specified, the attached data network will use a default NAPT configuration with NAPT enabled.
""")
  naptConfiguration?: NaptConfiguration;

  @doc("""
The user equipment (UE) address pool prefixes for the attached data network from which the packet core instance will dynamically assign IP addresses to UEs.
The packet core instance assigns an IP address to a UE when the UE sets up a PDU session.
 You must define at least one of userEquipmentAddressPoolPrefix and userEquipmentStaticAddressPoolPrefix. If you define both, they must be of the same size.
""")
  userEquipmentAddressPoolPrefix?: string[];

  @doc("""
The user equipment (UE) address pool prefixes for the attached data network from which the packet core instance will assign static IP addresses to UEs.
The packet core instance assigns an IP address to a UE when the UE sets up a PDU session. The static IP address for a specific UE is set in StaticIPConfiguration on the corresponding SIM resource.
At least one of userEquipmentAddressPoolPrefix and userEquipmentStaticAddressPoolPrefix must be defined. If both are defined, they must be of the same size.
""")
  userEquipmentStaticAddressPoolPrefix?: string[];
}

@doc("Interface properties")
model InterfaceProperties {
  @doc("The logical name for this interface. This should match one of the interfaces configured on your Azure Stack Edge device.")
  name?: string;

  @doc("The IPv4 address.")
  @pattern("^(([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])$")
  ipv4Address?: string;

  @doc("The IPv4 subnet.")
  @pattern("^(([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\\/([0-9]|[1-2][0-9]|3[0-2]))$")
  ipv4Subnet?: string;

  @doc("The default IPv4 gateway (router).")
  @pattern("^(([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])$")
  ipv4Gateway?: string;
}

@doc("The network address and port translation settings to use for the attached data network.")
model NaptConfiguration {
  @doc("Whether NAPT is enabled for connections to this attached data network.")
  enabled?: NaptEnabled;

  @doc("""
Range of port numbers to use as translated ports on each translated address.
If not specified and NAPT is enabled, this range defaults to 1,024 - 49,999.
(Ports under 1,024 should not be used because these are special purpose ports reserved by IANA. Ports 50,000 and above are reserved for non-NAPT use.)
""")
  portRange?: PortRange;

  @doc("The minimum time (in seconds) that will pass before a port that was used by a closed pinhole can be recycled for use by another pinhole. All hold times must be at least 1 second.")
  portReuseHoldTime?: PortReuseHoldTimes;

  @doc("Maximum number of UDP and TCP pinholes that can be open simultaneously on the core interface. For 5G networks, this is the N6 interface. For 4G networks, this is the SGi interface.")
  @maxValue(65536)
  @minValue(1)
  pinholeLimits?: int32;

  @doc("Expiry times of inactive NAPT pinholes, in seconds. All timers must be at least 1 second.")
  pinholeTimeouts?: PinholeTimeouts;
}

@doc("""
Range of port numbers to use as translated ports on each translated address.
If not specified and NAPT is enabled, this range defaults to 1,024 - 49,999.
(Ports under 1,024 should not be used because these are special purpose ports reserved by IANA. Ports 50,000 and above are reserved for non-NAPT use.)
""")
model PortRange {
  @doc("The minimum port number")
  @maxValue(65535)
  @minValue(1024)
  minPort?: int32;

  @doc("The maximum port number")
  @maxValue(65535)
  @minValue(1024)
  maxPort?: int32;
}

@doc("The minimum time (in seconds) that will pass before a port that was used by a closed pinhole can be recycled for use by another pinhole. All hold times must be minimum 1 second.")
model PortReuseHoldTimes {
  @doc("Minimum time in seconds that will pass before a TCP port that was used by a closed pinhole can be reused. Default for TCP is 2 minutes.")
  @minValue(1)
  tcp?: int32;

  @doc("Minimum time in seconds that will pass before a UDP port that was used by a closed pinhole can be reused. Default for UDP is 1 minute.")
  @minValue(1)
  udp?: int32;
}

@doc("Expiry times of inactive NAPT pinholes, in seconds. All timers must be at least 1 second.")
model PinholeTimeouts {
  @doc("Pinhole timeout for TCP pinholes in seconds. Default for TCP is 3 minutes.")
  @minValue(1)
  tcp?: int32;

  @doc("Pinhole timeout for UDP pinholes in seconds. Default for UDP is 30 seconds.")
  @minValue(1)
  udp?: int32;

  @doc("Pinhole timeout for ICMP pinholes in seconds. Default for ICMP Echo is 30 seconds.")
  @minValue(1)
  icmp?: int32;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. E.g. \"/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}\"")
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

@doc("Tags object for patch operations.")
model TagsObject {
  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Data network properties.")
model DataNetworkPropertiesFormat {
  @doc("The provisioning state of the data network resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("An optional description for this data network.")
  description?: string;
}

@doc("Diagnostics package properties.")
model DiagnosticsPackagePropertiesFormat {
  @doc("The provisioning state of the diagnostics package resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The status of the diagnostics package collection.")
  @visibility("read")
  status?: DiagnosticsPackageStatus;

  @doc("The reason for the current state of the diagnostics package collection.")
  @visibility("read")
  reason?: string;
}

@doc("Mobile network properties.")
model MobileNetworkPropertiesFormat {
  @doc("The provisioning state of the mobile network resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The unique public land mobile network identifier for the network. This is made up of the mobile country code and mobile network code, as defined in https://www.itu.int/rec/T-REC-E.212. The values 001-01 and 001-001 can be used for testing and the values 999-99 and 999-999 can be used on internal private networks.")
  publicLandMobileNetworkIdentifier: PlmnId;

  @doc("The mobile network resource identifier")
  @visibility("read")
  serviceKey?: string;
}

@doc("Public land mobile network (PLMN) ID.")
model PlmnId {
  @doc("Mobile country code (MCC).")
  @pattern("^\\d{3}$")
  mcc: string;

  @doc("Mobile network code (MNC).")
  @pattern("^\\d{2,3}$")
  mnc: string;
}

@doc("Packet capture session properties.")
model PacketCapturePropertiesFormat {
  @doc("The provisioning state of the packet capture session resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The status of the packet capture session.")
  @visibility("read")
  status?: PacketCaptureStatus;

  @doc("The reason the current packet capture session state.")
  @visibility("read")
  reason?: string;

  @doc("The start time of the packet capture session.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  captureStartTime?: utcDateTime;

  @doc("List of network interfaces to capture on.")
  networkInterfaces?: string[];

  @doc("Number of bytes captured per packet, the remaining bytes are truncated. The default \"0\" means the entire packet is captured.")
  @maxValue(4294967295)
  bytesToCapturePerPacket?: int32;

  @doc("Maximum size of the capture output.")
  @maxValue(4294967295)
  @minValue(1000)
  totalBytesPerSession?: int32;

  @doc("Maximum duration of the capture session in seconds.")
  @maxValue(18000)
  @minValue(5)
  timeLimitInSeconds?: int32;

  @doc("The list of output files of a packet capture session.")
  @visibility("read")
  outputFiles?: string[];
}

@doc("The current status of an async operation.")
model AsyncOperationStatus {
  @doc("Fully qualified ID for the async operation.")
  id?: string;

  @doc("Name of the async operation.")
  name?: string;

  @doc("The operation status.")
  status: string;

  @doc("Fully qualified ID for the resource that this async operation status relates to.")
  resourceId?: string;

  @doc("The start time of the operation.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The end time of the operation.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Percentage of the operation that is complete.")
  @maxValue(100)
  percentComplete?: float32;

  @doc("Properties returned by the resource provider on a successful operation")
  properties?: Record<unknown>;

  @doc("If present, details of the operation error.")
  error?: ErrorDetail;
}

@doc("Packet core control plane properties.")
model PacketCoreControlPlanePropertiesFormat {
  @doc("The provisioning state of the packet core control plane resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The installation state of the packet core control plane resource.")
  installation?: Installation;

  @doc("Site(s) under which this packet core control plane should be deployed. The sites must be in the same location as the packet core control plane.")
  sites: SiteResourceId[];

  @doc("The platform where the packet core is deployed.")
  platform: PlatformConfiguration;

  @doc("The core network technology generation (5G core or EPC / 4G core).")
  coreNetworkTechnology?: CoreNetworkType;

  @doc("The desired version of the packet core software.")
  version?: string;

  @doc("The currently installed version of the packet core software.")
  @visibility("read")
  installedVersion?: string;

  @doc("The previous version of the packet core software that was deployed. Used when performing the rollback action.")
  @visibility("read")
  rollbackVersion?: string;

  @doc("The control plane interface on the access network. For 5G networks, this is the N2 interface. For 4G networks, this is the S1-MME interface.")
  controlPlaneAccessInterface: InterfaceProperties;

  @doc("The virtual IP address(es) for the control plane on the access network in a High Availability (HA) system. In an HA deployment the access network router should be configured to anycast traffic for this address to the control plane access interfaces on the active and standby nodes. In non-HA system this list should be omitted or empty.")
  controlPlaneAccessVirtualIpv4Addresses?: string[];

  @doc("The SKU defining the throughput and SIM allowances for this packet core control plane deployment.")
  sku: BillingSku;

  @doc("The MTU (in bytes) signaled to the UE. The same MTU is set on the user plane data links for all data networks. The MTU set on the user plane access link is calculated to be 60 bytes greater than this value to allow for GTP encapsulation.")
  @maxValue(1930)
  @minValue(1280)
  ueMtu?: int32;

  @doc("The kubernetes ingress configuration to control access to packet core diagnostics over local APIs.")
  localDiagnosticsAccess: LocalDiagnosticsAccessConfiguration;

  @doc("Configuration for uploading packet core diagnostics")
  diagnosticsUpload?: DiagnosticsUploadConfiguration;

  @doc("Configuration for sending packet core events to an Azure Event Hub.")
  eventHub?: EventHubConfiguration;

  @doc("Signaling configuration for the packet core.")
  signaling?: SignalingConfiguration;

  @doc("Settings to allow interoperability with third party components e.g. RANs and UEs.")
  interopSettings?: Record<unknown>;
}

@doc("The installation state of the packet core.")
model Installation {
  @doc("The desired installation state")
  desiredState?: DesiredInstallationState;

  @doc("Installation state")
  @visibility("read")
  state?: InstallationState;

  @doc("Whether a reinstall of the packet core is required to pick up the latest configuration changes.")
  @visibility("read")
  reinstallRequired?: ReinstallRequired;

  @doc("Reason(s) for the current installation state of the packet core.")
  @visibility("read")
  reasons?: InstallationReason[];

  @doc("A reference to an in-progress installation operation")
  @visibility("read")
  operation?: AsyncOperationId;
}

@doc("Reference to an Azure Async Operation ID.")
model AsyncOperationId {
  @doc("Azure Async Operation ID.")
  @pattern("^/[pP][rR][oO][vV][iI][dD][eE][rR][sS]/[^/?#]+/[lL][oO][cC][aA][tT][iI][oO][nN][sS]/[^/?#]+/[oO][pP][eE][rR][aA][tT][iI][oO][nN][sS][tT][aA][tT][uU][sS][eE][sS]/[^/?#]+$")
  id: string;
}

@doc("Reference to a site resource.")
model SiteResourceId {
  @doc("Site resource ID.")
  @pattern("^/[sS][uU][bB][sS][cC][rR][iI][pP][tT][iI][oO][nN][sS]/[^/?#]+/[rR][eE][sS][oO][uU][rR][cC][eE][gG][rR][oO][uU][pP][sS]/[^/?#]+/[pP][rR][oO][vV][iI][dD][eE][rR][sS]/[mM][iI][cC][rR][oO][sS][oO][fF][tT]\\.[mM][oO][bB][iI][lL][eE][nN][eE][tT][wW][oO][rR][kK]/[mM][oO][bB][iI][lL][eE][nN][eE][tT][wW][oO][rR][kK][sS]/[^/?#]+/[sS][iI][tT][eE][sS]/[^/?#]+$")
  id: string;
}

@doc("The platform where the packet core is deployed.")
model PlatformConfiguration {
  @doc("The platform type where packet core is deployed.")
  type: PlatformType;

  @doc("The Azure Stack Edge device where the packet core is deployed. If the device is part of a fault tolerant pair, either device in the pair can be specified.")
  azureStackEdgeDevice?: AzureStackEdgeDeviceResourceId;

  @doc("The Azure Stack Edge devices where the packet core is deployed. If the packet core is deployed across multiple devices, all devices will appear in this list.")
  @visibility("read")
  azureStackEdgeDevices?: AzureStackEdgeDeviceResourceId[];

  @doc("The Azure Stack HCI cluster where the packet core is deployed.")
  azureStackHciCluster?: AzureStackHCIClusterResourceId;

  @doc("Azure Arc connected cluster where the packet core is deployed.")
  connectedCluster?: ConnectedClusterResourceId;

  @doc("Azure Arc custom location where the packet core is deployed.")
  customLocation?: CustomLocationResourceId;
}

@doc("Reference to an Azure Stack Edge device resource.")
model AzureStackEdgeDeviceResourceId {
  @doc("Azure Stack Edge device resource ID.")
  @pattern("^/[sS][uU][bB][sS][cC][rR][iI][pP][tT][iI][oO][nN][sS]/[^/?#]+/[rR][eE][sS][oO][uU][rR][cC][eE][gG][rR][oO][uU][pP][sS]/[^/?#]+/[pP][rR][oO][vV][iI][dD][eE][rR][sS]/[mM][iI][cC][rR][oO][sS][oO][fF][tT]\\.[dD][aA][tT][aA][bB][oO][xX][eE][dD][gG][eE]/[dD][aA][tT][aA][bB][oO][xX][eE][dD][gG][eE][dD][eE][vV][iI][cC][eE][sS]/[^/?#]+$")
  id: string;
}

@doc("Reference to an Azure Stack HCI cluster resource.")
model AzureStackHCIClusterResourceId {
  @doc("Azure Stack HCI cluster resource ID.")
  @pattern("^/[sS][uU][bB][sS][cC][rR][iI][pP][tT][iI][oO][nN][sS]/[^/?#]+/[rR][eE][sS][oO][uU][rR][cC][eE][gG][rR][oO][uU][pP][sS]/[^/?#]+/[pP][rR][oO][vV][iI][dD][eE][rR][sS]/[mM][iI][cC][rR][oO][sS][oO][fF][tT]\\.[aA][zZ][uU][rR][eE][sS][tT][aA][cC][kK][hH][cC][iI]/[cC][lL][uU][sS][tT][eE][rR][sS]/[^/?#]+$")
  id: string;
}

@doc("Reference to an Azure Arc custom location resource.")
model ConnectedClusterResourceId {
  @doc("Azure Arc connected cluster resource ID.")
  @pattern("^/[sS][uU][bB][sS][cC][rR][iI][pP][tT][iI][oO][nN][sS]/[^/?#]+/[rR][eE][sS][oO][uU][rR][cC][eE][gG][rR][oO][uU][pP][sS]/[^/?#]+/[pP][rR][oO][vV][iI][dD][eE][rR][sS]/[mM][iI][cC][rR][oO][sS][oO][fF][tT]\\.[kK][uU][bB][eE][rR][nN][eE][tT][eE][sS]/[cC][oO][nN][nN][eE][cC][tT][eE][dD][cC][lL][uU][sS][tT][eE][rR][sS]/[^/?#]+$")
  id: string;
}

@doc("Reference to an Azure Arc custom location resource.")
model CustomLocationResourceId {
  @doc("Azure Arc custom location resource ID.")
  @pattern("^/[sS][uU][bB][sS][cC][rR][iI][pP][tT][iI][oO][nN][sS]/[^/?#]+/[rR][eE][sS][oO][uU][rR][cC][eE][gG][rR][oO][uU][pP][sS]/[^/?#]+/[pP][rR][oO][vV][iI][dD][eE][rR][sS]/[mM][iI][cC][rR][oO][sS][oO][fF][tT]\\.[eE][xX][tT][eE][nN][dD][eE][dD][lL][oO][cC][aA][tT][iI][oO][nN]/[cC][uU][sS][tT][oO][mM][lL][oO][cC][aA][tT][iI][oO][nN][sS]/[^/?#]+$")
  id: string;
}

@doc("The kubernetes ingress configuration to control access to packet core diagnostics over local APIs.")
model LocalDiagnosticsAccessConfiguration {
  @doc("How to authenticate users who access local diagnostics APIs.")
  authenticationType: AuthenticationType;

  @doc("The HTTPS server TLS certificate used to secure local access to diagnostics.")
  httpsServerCertificate?: HttpsServerCertificate;
}

@doc("HTTPS server certificate configuration.")
model HttpsServerCertificate {
  @doc("The certificate URL, unversioned. For example: https://contosovault.vault.azure.net/certificates/ingress.")
  certificateUrl: string;

  @doc("The provisioning state of the certificate.")
  @visibility("read")
  provisioning?: CertificateProvisioning;
}

@doc("Certificate provisioning state")
model CertificateProvisioning {
  @doc("The certificate's provisioning state")
  @visibility("read")
  state?: CertificateProvisioningState;

  @doc("Reason for certificate provisioning failure.")
  @visibility("read")
  reason?: string;
}

@doc("Configuration for uploading packet core diagnostics.")
model DiagnosticsUploadConfiguration {
  @doc("The Storage Account Container URL to upload diagnostics to.")
  storageAccountContainerUrl: string;
}

@doc("Configuration for sending packet core events to Azure Event Hub.")
model EventHubConfiguration {
  @doc("Resource ID  of Azure Event Hub to send packet core events to.")
  @pattern("^/[sS][uU][bB][sS][cC][rR][iI][pP][tT][iI][oO][nN][sS]/[^/?#]+/[rR][eE][sS][oO][uU][rR][cC][eE][gG][rR][oO][uU][pP][sS]/[^/?#]+/[pP][rR][oO][vV][iI][dD][eE][rR][sS]/[mM][iI][cC][rR][oO][sS][oO][fF][tT]\\.[eE][vV][eE][nN][tT][hH][uU][bB]/[nN][aA][mM][eE][sS][pP][aA][cC][eE][sS]/[^/?#]+/[eV][vV][eE][nN][tT][hH][uU][bB][sS]/[^/?#]+$")
  id: string;

  @doc("The duration (in seconds) between UE usage reports.")
  @maxValue(3600)
  @minValue(30)
  reportingInterval?: int32;
}

@doc("Signaling configuration for the packet core.")
model SignalingConfiguration {
  @doc("Configuration enabling 4G NAS reroute.")
  nasReroute?: NASRerouteConfiguration;
}

@doc("Configuration enabling NAS reroute.")
model NASRerouteConfiguration {
  @doc("The macro network's MME group ID. This is where unknown UEs are sent to via NAS reroute.")
  @maxValue(65535)
  macroMmeGroupId: int32;
}

@doc("Identity and Tags object for patch operations.")
model IdentityAndTagsObject {
  @doc("The managed service identity associated with this resource.")
  identity?: ManagedServiceIdentity;

  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Packet core control plane collect diagnostics package options")
model PacketCoreControlPlaneCollectDiagnosticsPackage {
  @doc("The Storage Account Blob URL to upload the diagnostics package to.")
  storageAccountBlobUrl: string;
}

@doc("Packet core control plane version properties.")
model PacketCoreControlPlaneVersionPropertiesFormat {
  @doc("The provisioning state of the packet core control plane version resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Platform specific packet core control plane version properties.")
  platforms?: Platform[];
}

@doc("Platform specific packet core control plane version properties.")
model Platform {
  @doc("The platform type where this version can be deployed.")
  platformType?: PlatformType;

  @doc("The state of this packet core control plane version on this platform.")
  versionState?: VersionState;

  @doc("The minimum software version of the platform where this packet core version can be deployed.")
  minimumPlatformSoftwareVersion?: string;

  @doc("The maximum software version of the platform where this packet core version can be deployed.")
  maximumPlatformSoftwareVersion?: string;

  @doc("Indicates whether this is the recommended version for this platform.")
  recommendedVersion?: RecommendedVersion;

  @doc("Indicates whether this version is obsoleted for this platform.")
  obsoleteVersion?: ObsoleteVersion;
}

@doc("Packet core data plane properties.")
model PacketCoreDataPlanePropertiesFormat {
  @doc("The provisioning state of the packet core data plane resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The user plane interface on the access network. For 5G networks, this is the N3 interface. For 4G networks, this is the S1-U interface.")
  userPlaneAccessInterface: InterfaceProperties;

  @doc("The virtual IP address(es) for the user plane on the access network in a High Availability (HA) system. In an HA deployment the access network router should be configured to forward traffic for this address to the control plane access interface on the active or standby node. In non-HA system this list should be omitted or empty.")
  userPlaneAccessVirtualIpv4Addresses?: string[];
}

@doc("Service properties.")
model ServicePropertiesFormat {
  @doc("The provisioning state of the service resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("A precedence value that is used to decide between services when identifying the QoS values to use for a particular SIM. A lower value means a higher priority. This value should be unique among all services configured in the mobile network.")
  @maxValue(255)
  servicePrecedence: int32;

  @doc("The QoS policy to use for packets matching this service. This can be overridden for particular flows using the ruleQosPolicy field in a PccRuleConfiguration. If this field is null then the UE's SIM policy will define the QoS settings.")
  serviceQosPolicy?: QosPolicy;

  @doc("The set of data flow policy rules that make up this service.")
  pccRules: PccRuleConfiguration[];
}

@doc("QoS policy")
model QosPolicy {
  @doc("5G QoS Flow Indicator value. The 5QI identifies a specific QoS forwarding treatment to be provided to a flow. See 3GPP TS23.501 section 5.7.2.1 for a full description of the 5QI parameter, and table 5.7.4-1 for the definition the 5QI values.")
  @maxValue(127)
  @minValue(1)
  @projectedName("json", "5qi")
  fiveQi?: int32;

  @doc("QoS Flow allocation and retention priority (ARP) level. Flows with higher priority preempt flows with lower priority, if the settings of `preemptionCapability` and `preemptionVulnerability` allow it. 1 is the highest level of priority. If this field is not specified then `5qi` is used to derive the ARP value. See 3GPP TS23.501 section 5.7.2.2 for a full description of the ARP parameters.")
  @maxValue(15)
  @minValue(1)
  allocationAndRetentionPriorityLevel?: int32;

  @doc("QoS Flow preemption capability. The preemption capability of a QoS Flow controls whether it can preempt another QoS Flow with a lower priority level. See 3GPP TS23.501 section 5.7.2.2 for a full description of the ARP parameters.")
  preemptionCapability?: PreemptionCapability;

  @doc("QoS Flow preemption vulnerability. The preemption vulnerability of a QoS Flow controls whether it can be preempted by a QoS Flow with a higher priority level. See 3GPP TS23.501 section 5.7.2.2 for a full description of the ARP parameters.")
  preemptionVulnerability?: PreemptionVulnerability;

  @doc("The maximum bit rate (MBR) for all service data flows that use this data flow policy rule or service.")
  maximumBitRate: Ambr;
}

@doc("Aggregate maximum bit rate.")
model Ambr {
  @doc("Uplink bit rate.")
  @pattern("^\\d+(\\.\\d+)? (bps|Kbps|Mbps|Gbps|Tbps)$")
  uplink: string;

  @doc("Downlink bit rate.")
  @pattern("^\\d+(\\.\\d+)? (bps|Kbps|Mbps|Gbps|Tbps)$")
  downlink: string;
}

@doc("Data flow policy rule configuration")
model PccRuleConfiguration {
  @doc("The name of the rule. This must be unique within the parent service. You must not use any of the following reserved strings - `default`, `requested` or `service`.")
  @maxLength(64)
  @pattern("^(?!(default|requested|service)$)[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  ruleName: string;

  @doc("A precedence value that is used to decide between data flow policy rules when identifying the QoS values to use for a particular SIM. A lower value means a higher priority. This value should be unique among all data flow policy rules configured in the mobile network.")
  @maxValue(255)
  rulePrecedence: int32;

  @doc("The QoS policy to use for packets matching this rule. If this field is null then the parent service will define the QoS settings.")
  ruleQosPolicy?: PccRuleQosPolicy;

  @doc("Determines whether flows that match this data flow policy rule are permitted.")
  trafficControl?: TrafficControlPermission;

  @doc("The set of data flow templates to use for this data flow policy rule.")
  serviceDataFlowTemplates: ServiceDataFlowTemplate[];
}

@doc("Data flow policy rule QoS policy")
model PccRuleQosPolicy extends QosPolicy {
  @doc("The guaranteed bit rate (GBR) for all service data flows that use this data flow policy rule. This is an optional setting. If you do not provide a value, there will be no GBR set for the data flow policy rule that uses this QoS definition.")
  guaranteedBitRate?: Ambr;
}

@doc("Data flow template")
model ServiceDataFlowTemplate {
  @doc("The name of the data flow template. This must be unique within the parent data flow policy rule. You must not use any of the following reserved strings - `default`, `requested` or `service`.")
  @maxLength(64)
  @pattern("^(?!(default|requested|service)$)[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  templateName: string;

  @doc("The direction of this flow.")
  direction: SdfDirection;

  @doc("A list of the allowed protocol(s) for this flow. If you want this flow to be able to use any protocol within the internet protocol suite, use the value `ip`. If you only want to allow a selection of protocols, you must use the corresponding IANA Assigned Internet Protocol Number for each protocol, as described in https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml. For example, for UDP, you must use 17. If you use the value `ip` then you must leave the field `port` unspecified.")
  protocol: string[];

  @doc("The remote IP address(es) to which UEs will connect for this flow. If you want to allow connections on any IP address, use the value `any`. Otherwise, you must provide each of the remote IP addresses to which the packet core instance will connect for this flow. You must provide each IP address in CIDR notation, including the netmask (for example, 192.0.2.54/24).")
  remoteIpList: string[];

  @doc("The port(s) to which UEs will connect for this flow. You can specify zero or more ports or port ranges. If you specify one or more ports or port ranges then you must specify a value other than `ip` in the `protocol` field. This is an optional setting. If you do not specify it then connections will be allowed on all ports. Port ranges must be specified as <FirstPort>-<LastPort>. For example: [`8080`, `8082-8085`].")
  ports?: string[];
}

@doc("SIM properties.")
model SimPropertiesFormat extends CommonSimPropertiesFormat {
  @doc("The Ki value for the SIM.")
  @visibility("create", "update")
  @pattern("^[0-9a-fA-F]{32}$")
  authenticationKey?: string;

  @doc("The Opc value for the SIM.")
  @visibility("create", "update")
  @pattern("^[0-9a-fA-F]{32}$")
  operatorKeyCode?: string;
}

@doc("Common SIM properties.")
model CommonSimPropertiesFormat {
  @doc("The provisioning state of the SIM resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The state of the SIM resource.")
  @visibility("read")
  simState?: SimState;

  @doc("A dictionary of sites to the provisioning state of this SIM on that site.")
  @visibility("read")
  siteProvisioningState?: Record<SiteProvisioningState>;

  @doc("The international mobile subscriber identity (IMSI) for the SIM.")
  @visibility("read", "create")
  @pattern("^[0-9]{5,15}$")
  internationalMobileSubscriberIdentity: string;

  @doc("The integrated circuit card ID (ICCID) for the SIM.")
  @pattern("^[0-9]{10,20}$")
  integratedCircuitCardIdentifier?: string;

  @doc("An optional free-form text field that can be used to record the device type this SIM is associated with, for example 'Video camera'. The Azure portal allows SIMs to be grouped and filtered based on this value.")
  deviceType?: string;

  @doc("The SIM policy used by this SIM. The SIM policy must be in the same location as the SIM.")
  simPolicy?: SimPolicyResourceId;

  @doc("A list of static IP addresses assigned to this SIM. Each address is assigned at a defined network scope, made up of {attached data network, slice}.")
  staticIpConfiguration?: SimStaticIpProperties[];

  @doc("The name of the SIM vendor who provided this SIM, if any.")
  @visibility("read")
  vendorName?: string;

  @doc("The public key fingerprint of the SIM vendor who provided this SIM, if any.")
  @visibility("read")
  vendorKeyFingerprint?: string;
}

@doc("Reference to a SIM policy resource.")
model SimPolicyResourceId {
  @doc("SIM policy resource ID.")
  @pattern("^/[sS][uU][bB][sS][cC][rR][iI][pP][tT][iI][oO][nN][sS]/[^/?#]+/[rR][eE][sS][oO][uU][rR][cC][eE][gG][rR][oO][uU][pP][sS]/[^/?#]+/[pP][rR][oO][vV][iI][dD][eE][rR][sS]/[mM][iI][cC][rR][oO][sS][oO][fF][tT]\\.[mM][oO][bB][iI][lL][eE][nN][eE][tT][wW][oO][rR][kK]/[mM][oO][bB][iI][lL][eE][nN][eE][tT][wW][oO][rR][kK][sS]/[^/?#]+/[sS][iI][mM][pP][oO][lL][iI][cC][iI][eE][sS]/[^/?#]+$")
  id: string;
}

@doc("Static IP configuration for a SIM, scoped to a particular attached data network and slice.")
model SimStaticIpProperties {
  @doc("The attached data network on which the static IP address will be used. The combination of attached data network and slice defines the network scope of the IP address. The attached data network must be in the same location as the SIM.")
  attachedDataNetwork?: AttachedDataNetworkResourceId;

  @doc("The network slice on which the static IP address will be used. The combination of attached data network and slice defines the network scope of the IP address. The slice must be in the same location as the SIM.")
  slice?: SliceResourceId;

  @doc("The static IP configuration for the SIM to use at the defined network scope.")
  staticIp?: SimStaticIpPropertiesStaticIp;
}

@doc("Reference to an attached data network resource.")
model AttachedDataNetworkResourceId {
  @doc("Attached data network resource ID.")
  @pattern("^/[sS][uU][bB][sS][cC][rR][iI][pP][tT][iI][oO][nN][sS]/[^/?#]+/[rR][eE][sS][oO][uU][rR][cC][eE][gG][rR][oO][uU][pP][sS]/[^/?#]+/[pP][rR][oO][vV][iI][dD][eE][rR][sS]/[mM][iI][cC][rR][oO][sS][oO][fF][tT]\\.[mM][oO][bB][iI][lL][eE][nN][eE][tT][wW][oO][rR][kK]/[pP][aA][cC][kK][eE][tT][cC][oO][rR][eE][cC][oO][nN][tT][rR][oO][lL][pP][lL][aA][nN][eE][sS]/[^/?#]+/[pP][aA][cC][kK][eE][tT][cC][oO][rR][eE][dD][aA][tT][aA][pP][lL][aA][nN][eE][sS]/[^/?#]+/[aA][tT][tT][aA][cC][hH][eE][dD][dD][aA][tT][aA][nN][eE][tT][wW][oO][rR][kK][sS]/[^/?#]+$")
  id: string;
}

@doc("Reference to a slice resource.")
model SliceResourceId {
  @doc("Slice resource ID.")
  @pattern("^/[sS][uU][bB][sS][cC][rR][iI][pP][tT][iI][oO][nN][sS]/[^/?#]+/[rR][eE][sS][oO][uU][rR][cC][eE][gG][rR][oO][uU][pP][sS]/[^/?#]+/[pP][rR][oO][vV][iI][dD][eE][rR][sS]/[mM][iI][cC][rR][oO][sS][oO][fF][tT]\\.[mM][oO][bB][iI][lL][eE][nN][eE][tT][wW][oO][rR][kK]/[mM][oO][bB][iI][lL][eE][nN][eE][tT][wW][oO][rR][kK][sS]/[^/?#]+/[sS][lL][iI][cC][eE][sS]/[^/?#]+$")
  id: string;
}

@doc("The static IP configuration for the SIM to use at the defined network scope.")
model SimStaticIpPropertiesStaticIp {
  @doc("The IPv4 address assigned to the SIM at this network scope. This address must be in the userEquipmentStaticAddressPoolPrefix defined in the attached data network.")
  @pattern("^(([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])$")
  ipv4Address?: string;
}

@doc("The SIMs to upload.")
model SimUploadList {
  @doc("A list of SIMs to upload.")
  sims: SimNameAndProperties[];
}

@doc("SIM name and properties.")
model SimNameAndProperties {
  @doc("The name of the SIM.")
  name: string;

  @doc("SIM Properties.")
  properties: SimPropertiesFormat;
}

@doc("The SIMs to delete.")
model SimDeleteList {
  @doc("A list of SIM resource names to delete.")
  sims: string[];
}

@doc("The SIMs to upload. The SIM credentials must be encrypted.")
model EncryptedSimUploadList {
  @doc("The upload file format version.")
  @minValue(1)
  version: int32;

  @doc("An identifier for the Azure SIM onboarding public key used for encrypted upload.")
  @minValue(1)
  azureKeyIdentifier: int32;

  @doc("The fingerprint of the SIM vendor public key. The private counterpart is used for signing the encrypted transport key.")
  @pattern("^[0-9a-fA-F]+$")
  vendorKeyFingerprint: string;

  @doc("The transport key used for encrypting SIM credentials, encrypted using the SIM onboarding public key.")
  @pattern("^[0-9a-fA-F]+$")
  encryptedTransportKey: string;

  @doc("The encrypted transport key, signed using the SIM vendor private key.")
  @pattern("^[0-9a-fA-F]+$")
  signedTransportKey: string;

  @doc("A list of SIMs to upload, with encrypted properties.")
  sims: SimNameAndEncryptedProperties[];
}

@doc("SIM name and encrypted properties.")
model SimNameAndEncryptedProperties {
  @doc("The name of the SIM.")
  name: string;

  @doc("Encrypted SIM Properties.")
  properties: EncryptedSimPropertiesFormat;
}

@doc("Encrypted SIM properties.")
model EncryptedSimPropertiesFormat extends CommonSimPropertiesFormat {
  @doc("The encrypted SIM credentials.")
  @pattern("^[0-9a-fA-F]+$")
  encryptedCredentials?: string;
}

@doc("SIM group properties.")
model SimGroupPropertiesFormat {
  @doc("The provisioning state of the SIM group resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("A key to encrypt the SIM data that belongs to this SIM group.")
  encryptionKey?: KeyVaultKey;

  @doc("Mobile network that this SIM group belongs to. The mobile network must be in the same location as the SIM group.")
  mobileNetwork?: MobileNetworkResourceId;
}

@doc("An Azure key vault key.")
model KeyVaultKey {
  @doc("The key URL, unversioned. For example: https://contosovault.vault.azure.net/keys/azureKey.")
  keyUrl?: string;
}

@doc("Reference to a mobile network resource.")
model MobileNetworkResourceId {
  @doc("Mobile network resource ID.")
  @pattern("^/[sS][uU][bB][sS][cC][rR][iI][pP][tT][iI][oO][nN][sS]/[^/?#]+/[rR][eE][sS][oO][uU][rR][cC][eE][gG][rR][oO][uU][pP][sS]/[^/?#]+/[pP][rR][oO][vV][iI][dD][eE][rR][sS]/[mM][iI][cC][rR][oO][sS][oO][fF][tT]\\.[mM][oO][bB][iI][lL][eE][nN][eE][tT][wW][oO][rR][kK]/[mM][oO][bB][iI][lL][eE][nN][eE][tT][wW][oO][rR][kK][sS]/[^/?#]+$")
  id: string;
}

@doc("SIM policy properties. Must be created in the same location as its parent mobile network.")
model SimPolicyPropertiesFormat {
  @doc("The provisioning state of the SIM policy resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("A dictionary of sites to the provisioning state of this SIM policy on that site.")
  @visibility("read")
  siteProvisioningState?: Record<SiteProvisioningState>;

  @doc("Aggregate maximum bit rate across all non-GBR QoS flows of all PDU sessions of a given UE. See 3GPP TS23.501 section 5.7.2.6 for a full description of the UE-AMBR.")
  ueAmbr: Ambr;

  @doc("The default slice to use if the UE does not explicitly specify it. This slice must exist in the `sliceConfigurations` map. The slice must be in the same location as the SIM policy.")
  defaultSlice: SliceResourceId;

  @doc("RAT/Frequency Selection Priority Index, defined in 3GPP TS 36.413. This is an optional setting and by default is unspecified.")
  @maxValue(256)
  @minValue(1)
  rfspIndex?: int32;

  @doc("UE periodic registration update timer (5G) or UE periodic tracking area update timer (4G), in seconds.")
  @minValue(30)
  registrationTimer?: int32;

  @doc("The allowed slices and the settings to use for them. The list must not contain duplicate items and must contain at least one item.")
  sliceConfigurations: SliceConfiguration[];
}

@doc("Per-slice settings")
model SliceConfiguration {
  @doc("A reference to the slice that these settings apply to. The slice must be in the same location as the SIM policy.")
  slice: SliceResourceId;

  @doc("The default data network to use if the UE does not explicitly specify it. Configuration for this object must exist in the `dataNetworkConfigurations` map. The data network must be in the same location as the SIM policy.")
  defaultDataNetwork: DataNetworkResourceId;

  @doc("The allowed data networks and the settings to use for them. The list must not contain duplicate items and must contain at least one item.")
  dataNetworkConfigurations: DataNetworkConfiguration[];
}

@doc("Reference to a data network resource.")
model DataNetworkResourceId {
  @doc("Data network resource ID.")
  @pattern("^/[sS][uU][bB][sS][cC][rR][iI][pP][tT][iI][oO][nN][sS]/[^/?#]+/[rR][eE][sS][oO][uU][rR][cC][eE][gG][rR][oO][uU][pP][sS]/[^/?#]+/[pP][rR][oO][vV][iI][dD][eE][rR][sS]/[mM][iI][cC][rR][oO][sS][oO][fF][tT]\\.[mM][oO][bB][iI][lL][eE][nN][eE][tT][wW][oO][rR][kK]/[mM][oO][bB][iI][lL][eE][nN][eE][tT][wW][oO][rR][kK][sS]/[^/?#]+/[dD][aA][tT][aA][nN][eE][tT][wW][oO][rR][kK][sS]/[^/?#]+$")
  id: string;
}

@doc("Settings controlling data network use")
model DataNetworkConfiguration {
  @doc("A reference to the data network that these settings apply to. The data network must be in the same location as the SIM policy.")
  dataNetwork: DataNetworkResourceId;

  @doc("Aggregate maximum bit rate across all non-GBR QoS flows of a given PDU session. See 3GPP TS23.501 section 5.7.2.6 for a full description of the Session-AMBR.")
  sessionAmbr: Ambr;

  @doc("Default 5G QoS Flow Indicator value. The 5QI identifies a specific QoS forwarding treatment to be provided to a flow. See 3GPP TS23.501 section 5.7.2.1 for a full description of the 5QI parameter, and table 5.7.4-1 for the definition the 5QI values.")
  @maxValue(255)
  @projectedName("json", "5qi")
  fiveQi?: int32;

  @doc("Default QoS Flow allocation and retention priority (ARP) level. Flows with higher priority preempt flows with lower priority, if the settings of `preemptionCapability` and `preemptionVulnerability` allow it. 1 is the highest level of priority. If this field is not specified then `5qi` is used to derive the ARP value. See 3GPP TS23.501 section 5.7.2.2 for a full description of the ARP parameters.")
  @maxValue(15)
  @minValue(1)
  allocationAndRetentionPriorityLevel?: int32;

  @doc("Default QoS Flow preemption capability. The preemption capability of a QoS Flow controls whether it can preempt another QoS Flow with a lower priority level. See 3GPP TS23.501 section 5.7.2.2 for a full description of the ARP parameters.")
  preemptionCapability?: PreemptionCapability;

  @doc("Default QoS Flow preemption vulnerability. The preemption vulnerability of a QoS Flow controls whether it can be preempted by a QoS Flow with a higher priority level. See 3GPP TS23.501 section 5.7.2.2 for a full description of the ARP parameters.")
  preemptionVulnerability?: PreemptionVulnerability;

  @doc("The default PDU session type, which is used if the UE does not request a specific session type.")
  defaultSessionType?: PduSessionType;

  @doc("Allowed session types in addition to the default session type. Must not duplicate the default session type.")
  additionalAllowedSessionTypes?: PduSessionType[];

  @doc("List of services that can be used as part of this SIM policy. The list must not contain duplicate items and must contain at least one item. The services must be in the same location as the SIM policy.")
  allowedServices: ServiceResourceId[];

  @doc("The maximum number of downlink packets to buffer at the user plane for High Latency Communication - Extended Buffering. See 3GPP TS29.272 v15.10.0 section 7.3.188 for a full description. This maximum is not guaranteed because there is a internal limit on buffered packets across all PDU sessions.")
  maximumNumberOfBufferedPackets?: int32;
}

@doc("Reference to a service resource.")
model ServiceResourceId {
  @doc("Service resource ID.")
  @pattern("^/[sS][uU][bB][sS][cC][rR][iI][pP][tT][iI][oO][nN][sS]/[^/?#]+/[rR][eE][sS][oO][uU][rR][cC][eE][gG][rR][oO][uU][pP][sS]/[^/?#]+/[pP][rR][oO][vV][iI][dD][eE][rR][sS]/[mM][iI][cC][rR][oO][sS][oO][fF][tT]\\.[mM][oO][bB][iI][lL][eE][nN][eE][tT][wW][oO][rR][kK]/[mM][oO][bB][iI][lL][eE][nN][eE][tT][wW][oO][rR][kK][sS]/[^/?#]+/[sS][eE][rR][vV][iI][cC][eE][sS]/[^/?#]+$")
  id: string;
}

@doc("Site properties.")
model SitePropertiesFormat {
  @doc("The provisioning state of the site resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("An array of IDs of the network functions deployed in the site. Deleting the site will delete any network functions that are deployed in the site.")
  @visibility("read")
  networkFunctions?: SubResource[];
}

@doc("Reference to another sub resource.")
model SubResource {
  @doc("Resource ID.")
  id: string;
}

@doc("The packet core to delete under a site.")
model SiteDeletePacketCore {
  @doc("Reference to an packet core control plane resource.")
  packetCore?: PacketCoreControlPlaneResourceId;
}

@doc("Reference to an packet core control plane resource.")
model PacketCoreControlPlaneResourceId {
  @doc("Packet core control plane resource ID.")
  @pattern("^/[sS][uU][bB][sS][cC][rR][iI][pP][tT][iI][oO][nN][sS]/[^/?#]+/[rR][eE][sS][oO][uU][rR][cC][eE][gG][rR][oO][uU][pP][sS]/[^/?#]+/[pP][rR][oO][vV][iI][dD][eE][rR][sS]/[mM][iI][cC][rR][oO][sS][oO][fF][tT]\\.[mM][oO][bB][iI][lL][eE][nN][eE][tT][wW][oO][rR][kK]/[pP][aA][cC][kK][eE][tT][cC][oO][rR][eE][cC][oO][nN][tT][rR][oO][lL][pP][lL][aA][nN][eE][sS]/[^/?#]+$")
  id: string;
}

@doc("Network slice properties.")
model SlicePropertiesFormat {
  @doc("The provisioning state of the network slice resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Single-network slice selection assistance information (S-NSSAI). Unique at the scope of a mobile network.")
  snssai: Snssai;

  @doc("An optional description for this network slice.")
  description?: string;
}

@doc("Single-network slice selection assistance information (S-NSSAI).")
model Snssai {
  @doc("Slice/service type (SST).")
  @maxValue(255)
  sst: int32;

  @doc("Slice differentiator (SD).")
  @pattern("^[A-Fa-f0-9]{6}$")
  sd?: string;
}

@doc("Reference to a SIM group resource.")
model SimGroupResourceId {
  @doc("SIM group resource ID.")
  @pattern("^/[sS][uU][bB][sS][cC][rR][iI][pP][tT][iI][oO][nN][sS]/[^/?#]+/[rR][eE][sS][oO][uU][rR][cC][eE][gG][rR][oO][uU][pP][sS]/[^/?#]+/[pP][rR][oO][vV][iI][dD][eE][rR][sS]/[mM][iI][cC][rR][oO][sS][oO][fF][tT]\\.[mM][oO][bB][iI][lL][eE][nN][eE][tT][wW][oO][rR][kK]/[sS][iI][mM][gG][rR][oO][uU][pP][sS]/[^/?#]+$")
  id: string;
}

@doc("Allocation and Retention Priority (ARP) parameters.")
model Arp {
  @doc("ARP priority level.")
  @maxValue(15)
  @minValue(1)
  priorityLevel: int32;

  @doc("ARP preemption capability.")
  preemptCap: PreemptionCapability;

  @doc("ARP preemption vulnerability")
  preemptVuln: PreemptionVulnerability;
}
