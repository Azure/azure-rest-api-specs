import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AVS;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Trial status")
enum TrialStatus {
  TrialAvailable,
  TrialUsed,
  TrialDisabled,
}

@doc("Host quota is active for current subscription")
enum QuotaEnabled {
  Enabled,
  Disabled,
}

@doc("The provisioning state")
enum PrivateCloudProvisioningState {
  Succeeded,
  Failed,
  Cancelled,
  Pending,
  Building,
  Deleting,
  Updating,
  Canceled,
}

@doc("Flag to indicate whether the private cloud has the quota for provisioned NSX Public IP count raised from 64 to 1024")
enum NsxPublicIpQuotaRaisedEnum {
  Enabled,
  Disabled,
}

@doc("The state of the cluster provisioning")
enum ClusterProvisioningState {
  Succeeded,
  Failed,
  Cancelled,
  Deleting,
  Updating,
  Canceled,
}

@doc("Connectivity to internet is enabled or disabled")
enum InternetEnum {
  Enabled,
  Disabled,
}

@doc("Protect LDAP communication using SSL certificate (LDAPS)")
enum SslEnum {
  Enabled,
  Disabled,
}

@doc("The availability strategy for the private cloud")
enum AvailabilityStrategy {
  SingleZone,
  DualZone,
}

@doc("Status of customer managed encryption key")
enum EncryptionState {
  Enabled,
  Disabled,
}

@doc("The state of key provided")
enum EncryptionKeyStatus {
  Connected,
  AccessDenied,
}

@doc("Property of the key if user provided or auto detected")
enum EncryptionVersionType {
  Fixed,
  AutoDetected,
}

@doc("The type of identity used for the private cloud. The type 'SystemAssigned' refers to an implicitly created identity. The type 'None' will remove any identities from the Private Cloud.")
enum ResourceIdentityType {
  SystemAssigned,
  None,
}

@doc("The state of the datastore provisioning")
enum DatastoreProvisioningState {
  Succeeded,
  Failed,
  Cancelled,
  Pending,
  Creating,
  Updating,
  Deleting,
  Canceled,
}

@doc("Mode that describes whether the LUN has to be mounted as a datastore or attached as a LUN")
enum MountOptionEnum {
  MOUNT,
  ATTACH,
}

@doc("The operational status of the datastore")
enum DatastoreStatus {
  Unknown,
  Accessible,
  Inaccessible,
  Attached,
  Detached,
  LostCommunication,
  DeadOrError,
}

@doc("The status of the HCX Enterprise Site")
enum HcxEnterpriseSiteStatus {
  Available,
  Consumed,
  Deactivated,
  Deleted,
}

@doc("The state of the  ExpressRoute Circuit Authorization provisioning")
enum ExpressRouteAuthorizationProvisioningState {
  Succeeded,
  Failed,
  Updating,
  Canceled,
}

@doc("The state of the  ExpressRoute Circuit Authorization provisioning")
enum GlobalReachConnectionProvisioningState {
  Succeeded,
  Failed,
  Updating,
  Canceled,
}

@doc("The connection status of the global reach connection")
enum GlobalReachConnectionStatus {
  Connected,
  Connecting,
  Disconnected,
}

enum WorkloadNetworkName {
  default,
}

@doc("Segment status.")
enum SegmentStatusEnum {
  SUCCESS,
  FAILURE,
}

@doc("The provisioning state")
enum WorkloadNetworkSegmentProvisioningState {
  Succeeded,
  Failed,
  Building,
  Deleting,
  Updating,
  Canceled,
}

@doc("Type of DHCP: SERVER or RELAY.")
enum DhcpTypeEnum {
  SERVER,
  RELAY,
}

@doc("The provisioning state")
enum WorkloadNetworkDhcpProvisioningState {
  Succeeded,
  Failed,
  Building,
  Deleting,
  Updating,
  Canceled,
}

@doc("Direction of port mirroring profile.")
enum PortMirroringDirectionEnum {
  INGRESS,
  EGRESS,
  BIDIRECTIONAL,
}

@doc("Port Mirroring Status.")
enum PortMirroringStatusEnum {
  SUCCESS,
  FAILURE,
}

@doc("The provisioning state")
enum WorkloadNetworkPortMirroringProvisioningState {
  Succeeded,
  Failed,
  Building,
  Deleting,
  Updating,
  Canceled,
}

@doc("VM Group status.")
enum VMGroupStatusEnum {
  SUCCESS,
  FAILURE,
}

@doc("The provisioning state")
enum WorkloadNetworkVMGroupProvisioningState {
  Succeeded,
  Failed,
  Building,
  Deleting,
  Updating,
  Canceled,
}

@doc("Virtual machine type.")
enum VMTypeEnum {
  REGULAR,
  EDGE,
  SERVICE,
}

@doc("DNS Service log level.")
enum DnsServiceLogLevelEnum {
  DEBUG,
  INFO,
  WARNING,
  ERROR,
  FATAL,
}

@doc("DNS Service status.")
enum DnsServiceStatusEnum {
  SUCCESS,
  FAILURE,
}

@doc("The provisioning state")
enum WorkloadNetworkDnsServiceProvisioningState {
  Succeeded,
  Failed,
  Building,
  Deleting,
  Updating,
  Canceled,
}

@doc("The provisioning state")
enum WorkloadNetworkDnsZoneProvisioningState {
  Succeeded,
  Failed,
  Building,
  Deleting,
  Updating,
  Canceled,
}

@doc("The provisioning state")
enum WorkloadNetworkPublicIPProvisioningState {
  Succeeded,
  Failed,
  Building,
  Deleting,
  Updating,
  Canceled,
}

@doc("The state of the cloud link.")
enum CloudLinkStatus {
  Active,
  Building,
  Deleting,
  Failed,
  Disconnected,
}

@doc("The type of private cloud addon")
enum AddonType {
  SRM,
  VR,
  HCX,
  Arc,
}

@doc("The state of the addon provisioning")
enum AddonProvisioningState {
  Succeeded,
  Failed,
  Cancelled,
  Building,
  Deleting,
  Updating,
  Canceled,
}

@doc("Whether VM DRS-driven movement is restricted (enabled) or not (disabled)")
enum VirtualMachineRestrictMovementState {
  Enabled,
  Disabled,
}

@doc("placement policy type")
enum PlacementPolicyType {
  VmVm,
  VmHost,
}

@doc("Whether the placement policy is enabled or disabled")
enum PlacementPolicyState {
  Enabled,
  Disabled,
}

@doc("The provisioning state")
enum PlacementPolicyProvisioningState {
  Succeeded,
  Failed,
  Building,
  Deleting,
  Updating,
  Canceled,
}

@doc("VM-Host placement policy affinity strength (should/must)")
enum AffinityStrength {
  Should,
  Must,
}

@doc("Placement policy hosts opt-in Azure Hybrid Benefit type")
enum AzureHybridBenefitType {
  SqlHost,
  None,
}

@doc("The type of parameter the script is expecting. psCredential is a PSCredentialObject")
enum ScriptParameterTypes {
  String,
  SecureString,
  Credential,
  Int,
  Bool,
  Float,
}

@doc("Should this parameter be visible to arm and passed in the parameters argument when executing")
enum VisibilityParameterEnum {
  Visible,
  Hidden,
}

@doc("Is this parameter required or optional")
enum OptionalParamEnum {
  Optional,
  Required,
}

@doc("The type of execution parameter")
enum ScriptExecutionParameterType {
  Value,
  SecureValue,
  Credential,
}

@doc("The state of the script execution resource")
enum ScriptExecutionProvisioningState {
  Pending,
  Running,
  Succeeded,
  Failed,
  Cancelling,
  Cancelled,
  Deleting,
  Canceled,
}

enum ScriptOutputStreamType {
  Information,
  Warning,
  Output,
  Error,
}

@doc("Placement policy affinity type")
enum AffinityType {
  Affinity,
  AntiAffinity,
}

@doc("Extra Operation properties")
model OperationProperties {
  @doc("Service specifications of the operation")
  serviceSpecification?: ServiceSpecification;
}

@doc("Service specification payload")
model ServiceSpecification {
  @doc("Specifications of the Log for Azure Monitoring")
  logSpecifications?: LogSpecification[];

  @doc("Specifications of the Metrics for Azure Monitoring")
  metricSpecifications?: MetricSpecification[];
}

@doc("Specifications of the Log for Azure Monitoring")
model LogSpecification {
  @doc("Name of the log")
  name?: string;

  @doc("Localized friendly display name of the log")
  displayName?: string;

  @doc("Blob duration of the log")
  blobDuration?: string;
}

@doc("Specifications of the Metrics for Azure Monitoring")
model MetricSpecification {
  @doc("Name of the metric")
  name?: string;

  @doc("Localized friendly display name of the metric")
  displayName?: string;

  @doc("Localized friendly description of the metric")
  displayDescription?: string;

  @doc("Unit that makes sense for the metric")
  unit?: string;

  @doc("Name of the metric category that the metric belongs to. A metric can only belong to a single category.")
  category?: string;

  @doc("Only provide one value for this field. Valid values: Average, Minimum, Maximum, Total, Count.")
  aggregationType?: string;

  @doc("Supported aggregation types")
  supportedAggregationTypes?: string[];

  @doc("Supported time grain types")
  supportedTimeGrainTypes?: string[];

  @doc("Optional. If set to true, then zero will be returned for time duration where no metric is emitted/published.")
  fillGapWithZero?: boolean;

  @doc("Dimensions of the metric")
  dimensions?: MetricDimension[];

  @doc("Whether or not the service is using regional MDM accounts.")
  enableRegionalMdmAccount?: string;

  @doc("The name of the MDM account.")
  sourceMdmAccount?: string;

  @doc("The name of the MDM namespace.")
  sourceMdmNamespace?: string;
}

@doc("Specifications of the Dimension of metrics")
model MetricDimension {
  @doc("Name of the dimension")
  name?: string;

  @doc("Localized friendly display name of the dimension")
  displayName?: string;

  @doc("Name of the dimension as it appears in MDM")
  internalName?: string;

  @doc("A boolean flag indicating whether this dimension should be included for the shoebox export scenario")
  toBeExportedForShoebox?: boolean;
}

@doc("API error response")
@error
model CloudError {
  @doc("An error returned by the API")
  error?: ErrorResponse;
}

@doc("The resource model definition representing SKU")
model Sku {
  @doc("The name of the SKU.")
  name: string;
}

@doc("Subscription trial availability")
model Trial {
  @doc("Trial status")
  @visibility("read")
  status?: TrialStatus;

  @doc("Number of trial hosts available")
  @visibility("read")
  availableHosts?: int32;
}

@doc("Subscription quotas")
model Quota {
  @doc("Remaining hosts quota by sku type")
  @visibility("read")
  hostsRemaining?: Record<int32>;

  @doc("Host quota is active for current subscription")
  @visibility("read")
  quotaEnabled?: QuotaEnabled;
}

@doc("The properties of a private cloud resource")
model PrivateCloudProperties extends PrivateCloudUpdateProperties {
  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: PrivateCloudProvisioningState;

  @doc("An ExpressRoute Circuit")
  circuit?: Circuit;

  @doc("The endpoints")
  @visibility("read")
  endpoints?: Endpoints;

  @doc("The block of addresses should be unique across VNet in your subscription as well as on-premise. Make sure the CIDR format is conformed to (A.B.C.D/X) where A,B,C,D are between 0 and 255, and X is between 0 and 22")
  @visibility("read", "create")
  networkBlock: string;

  @doc("Network used to access vCenter Server and NSX-T Manager")
  @visibility("read")
  managementNetwork?: string;

  @doc("Used for virtual machine cold migration, cloning, and snapshot migration")
  @visibility("read")
  provisioningNetwork?: string;

  @doc("Used for live migration of virtual machines")
  @visibility("read")
  vmotionNetwork?: string;

  @doc("Optionally, set the vCenter admin password when the private cloud is created")
  vcenterPassword?: string;

  @doc("Optionally, set the NSX-T Manager password when the private cloud is created")
  nsxtPassword?: string;

  @doc("Thumbprint of the vCenter Server SSL certificate")
  @visibility("read")
  vcenterCertificateThumbprint?: string;

  @doc("Thumbprint of the NSX-T Manager SSL certificate")
  @visibility("read")
  nsxtCertificateThumbprint?: string;

  @doc("Array of cloud link IDs from other clouds that connect to this one")
  @visibility("read")
  externalCloudLinks?: string[];

  @doc("A secondary expressRoute circuit from a separate AZ. Only present in a stretched private cloud")
  secondaryCircuit?: Circuit;

  @doc("Flag to indicate whether the private cloud has the quota for provisioned NSX Public IP count raised from 64 to 1024")
  @visibility("read")
  nsxPublicIpQuotaRaised?: NsxPublicIpQuotaRaisedEnum;
}

@doc("An ExpressRoute Circuit")
model Circuit {
  @doc("CIDR of primary subnet")
  @visibility("read")
  primarySubnet?: string;

  @doc("CIDR of secondary subnet")
  @visibility("read")
  secondarySubnet?: string;

  @doc("Identifier of the ExpressRoute Circuit (Microsoft Colo only)")
  @visibility("read")
  expressRouteID?: string;

  @doc("ExpressRoute Circuit private peering identifier")
  @visibility("read")
  expressRoutePrivatePeeringID?: string;
}

@doc("Endpoint addresses")
model Endpoints {
  @doc("Endpoint for the NSX-T Data Center manager")
  @visibility("read")
  nsxtManager?: string;

  @doc("Endpoint for Virtual Center Server Appliance")
  @visibility("read")
  vcsa?: string;

  @doc("Endpoint for the HCX Cloud Manager")
  @visibility("read")
  hcxCloudManager?: string;
}

@doc("The properties of a private cloud resource that may be updated")
model PrivateCloudUpdateProperties {
  @doc("The default cluster used for management")
  managementCluster?: ManagementCluster;

  @doc("Connectivity to internet is enabled or disabled")
  internet?: InternetEnum;

  @doc("vCenter Single Sign On Identity Sources")
  identitySources?: IdentitySource[];

  @doc("Properties describing how the cloud is distributed across availability zones")
  @visibility("read", "create")
  availability?: AvailabilityProperties;

  @doc("Customer managed key encryption, can be enabled or disabled")
  encryption?: Encryption;
}

@doc("The properties of a management cluster")
model ManagementCluster extends CommonClusterProperties {}

@doc("The common properties of a cluster")
model CommonClusterProperties {
  @doc("The cluster size")
  clusterSize?: int32;

  @doc("The state of the cluster provisioning")
  @visibility("read")
  provisioningState?: ClusterProvisioningState;

  @doc("The identity")
  @visibility("read")
  clusterId?: int32;

  @doc("The hosts")
  hosts?: string[];
}

@doc("vCenter Single Sign On Identity Source")
model IdentitySource {
  @doc("The name of the identity source")
  name?: string;

  @doc("The domain's NetBIOS name")
  `alias`?: string;

  @doc("The domain's dns name")
  domain?: string;

  @doc("The base distinguished name for users")
  baseUserDN?: string;

  @doc("The base distinguished name for groups")
  baseGroupDN?: string;

  @doc("Primary server URL")
  primaryServer?: string;

  @doc("Secondary server URL")
  secondaryServer?: string;

  @doc("Protect LDAP communication using SSL certificate (LDAPS)")
  ssl?: SslEnum;

  @doc("The ID of an Active Directory user with a minimum of read-only access to Base DN for users and group")
  username?: string;

  @doc("The password of the Active Directory user with a minimum of read-only access to Base DN for users and groups.")
  password?: string;
}

@doc("The properties describing private cloud availability zone distribution")
model AvailabilityProperties {
  @doc("The availability strategy for the private cloud")
  strategy?: AvailabilityStrategy;

  @doc("The primary availability zone for the private cloud")
  zone?: int32;

  @doc("The secondary availability zone for the private cloud")
  secondaryZone?: int32;
}

@doc("The properties of customer managed encryption key")
model Encryption {
  @doc("Status of customer managed encryption key")
  status?: EncryptionState;

  @doc("The key vault where the encryption key is stored")
  keyVaultProperties?: EncryptionKeyVaultProperties;
}

@doc("An Encryption Key")
model EncryptionKeyVaultProperties {
  @doc("The name of the key.")
  keyName?: string;

  @doc("The version of the key.")
  keyVersion?: string;

  @doc("The auto-detected version of the key if versionType is auto-detected.")
  @visibility("read")
  autoDetectedKeyVersion?: string;

  @doc("The URL of the vault.")
  keyVaultUrl?: string;

  @doc("The state of key provided")
  @visibility("read")
  keyState?: EncryptionKeyStatus;

  @doc("Property of the key if user provided or auto detected")
  @visibility("read")
  versionType?: EncryptionVersionType;
}

@doc("Identity for the virtual machine.")
model PrivateCloudIdentity {
  @doc("The principal ID of private cloud identity. This property will only be provided for a system assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID associated with the private cloud. This property will only be provided for a system assigned identity.")
  @visibility("read")
  tenantId?: string;

  @doc("The type of identity used for the private cloud. The type 'SystemAssigned' refers to an implicitly created identity. The type 'None' will remove any identities from the Private Cloud.")
  type?: ResourceIdentityType;
}

@doc("The core properties of ARM resources")
model Resource {
  @doc("Resource ID.")
  @visibility("read")
  id?: string;

  @doc("Resource name.")
  @visibility("read")
  name?: string;

  @doc("Resource type.")
  @visibility("read")
  type?: string;
}

@doc("An update to a private cloud resource")
model PrivateCloudUpdate {
  @doc("Resource tags")
  tags?: Record<string>;

  @doc("The updatable properties of a private cloud resource")
  properties?: PrivateCloudUpdateProperties;

  @doc("The identity of the private cloud, if configured.")
  identity?: PrivateCloudIdentity;
}

@doc("The properties of a cluster")
model ClusterProperties extends CommonClusterProperties {}

@doc("An update of a cluster resource")
model ClusterUpdate {
  @doc("The properties of a cluster resource that may be updated")
  properties?: ClusterUpdateProperties;
}

@doc("The properties of a cluster that may be updated")
model ClusterUpdateProperties {
  @doc("The cluster size")
  clusterSize?: int32;

  @doc("The hosts")
  hosts?: string[];
}

@doc("List of all zones and associated hosts for a cluster")
@pagedResult
model ClusterZoneList {
  @doc("Zone and associated hosts info")
  @items
  zones?: ClusterZone[];
}

@doc("Zone and associated hosts info")
model ClusterZone {
  @doc("List of hosts belonging to the availability zone in a cluster")
  @visibility("read")
  hosts?: string[];

  @doc("Availability zone identifier")
  @visibility("read")
  zone?: string;
}

@doc("The properties of a datastore")
model DatastoreProperties {
  @doc("The state of the datastore provisioning")
  @visibility("read")
  provisioningState?: DatastoreProvisioningState;

  @doc("An Azure NetApp Files volume")
  netAppVolume?: NetAppVolume;

  @doc("An iSCSI volume")
  diskPoolVolume?: DiskPoolVolume;

  @doc("The operational status of the datastore")
  @visibility("read")
  status?: DatastoreStatus;
}

@doc("An Azure NetApp Files volume from Microsoft.NetApp provider")
model NetAppVolume {
  @doc("Azure resource ID of the NetApp volume")
  id: string;
}

@doc("An iSCSI volume from Microsoft.StoragePool provider")
model DiskPoolVolume {
  @doc("Azure resource ID of the iSCSI target")
  targetId: string;

  @doc("Name of the LUN to be used for datastore")
  lunName: string;

  @doc("Mode that describes whether the LUN has to be mounted as a datastore or attached as a LUN")
  mountOption?: MountOptionEnum;

  @doc("Device path")
  @visibility("read")
  path?: string;
}

@doc("Administrative credentials for accessing vCenter and NSX-T")
model AdminCredentials {
  @doc("NSX-T Manager username")
  @visibility("read")
  nsxtUsername?: string;

  @doc("NSX-T Manager password")
  @visibility("read")
  nsxtPassword?: string;

  @doc("vCenter admin username")
  @visibility("read")
  vcenterUsername?: string;

  @doc("vCenter admin password")
  @visibility("read")
  vcenterPassword?: string;
}

@doc("The properties of an HCX Enterprise Site")
model HcxEnterpriseSiteProperties {
  @doc("The activation key")
  @visibility("read")
  activationKey?: string;

  @doc("The status of the HCX Enterprise Site")
  @visibility("read")
  status?: HcxEnterpriseSiteStatus;
}

@doc("The properties of an ExpressRoute Circuit Authorization resource")
model ExpressRouteAuthorizationProperties {
  @doc("The state of the  ExpressRoute Circuit Authorization provisioning")
  @visibility("read")
  provisioningState?: ExpressRouteAuthorizationProvisioningState;

  @doc("The ID of the ExpressRoute Circuit Authorization")
  @visibility("read")
  expressRouteAuthorizationId?: string;

  @doc("The key of the ExpressRoute Circuit Authorization")
  @visibility("read")
  expressRouteAuthorizationKey?: string;

  @doc("The ID of the ExpressRoute Circuit")
  expressRouteId?: string;
}

@doc("The properties of a global reach connection")
model GlobalReachConnectionProperties {
  @doc("The state of the  ExpressRoute Circuit Authorization provisioning")
  @visibility("read")
  provisioningState?: GlobalReachConnectionProvisioningState;

  @doc("The network used for global reach carved out from the original network block provided for the private cloud")
  @visibility("read")
  addressPrefix?: string;

  @doc("Authorization key from the peer express route used for the global reach connection")
  authorizationKey?: string;

  @doc("The connection status of the global reach connection")
  @visibility("read")
  circuitConnectionStatus?: GlobalReachConnectionStatus;

  @doc("Identifier of the ExpressRoute Circuit to peer with in the global reach connection")
  peerExpressRouteCircuit?: string;

  @doc("The ID of the Private Cloud's ExpressRoute Circuit that is participating in the global reach connection")
  expressRouteId?: string;
}

@doc("NSX Segment Properties")
model WorkloadNetworkSegmentProperties {
  @doc("Display name of the segment.")
  displayName?: string;

  @doc("Gateway which to connect segment to.")
  connectedGateway?: string;

  @doc("Subnet which to connect segment to.")
  subnet?: WorkloadNetworkSegmentSubnet;

  @doc("Port Vif which segment is associated with.")
  @visibility("read")
  portVif?: WorkloadNetworkSegmentPortVif[];

  @doc("Segment status.")
  @visibility("read")
  status?: SegmentStatusEnum;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: WorkloadNetworkSegmentProvisioningState;

  @doc("NSX revision number.")
  revision?: int32;
}

@doc("Subnet configuration for segment")
model WorkloadNetworkSegmentSubnet {
  @doc("DHCP Range assigned for subnet.")
  dhcpRanges?: string[];

  @doc("Gateway address.")
  gatewayAddress?: string;
}

@doc("Ports and any VIF attached to segment.")
model WorkloadNetworkSegmentPortVif {
  @doc("Name of port or VIF attached to segment.")
  portName?: string;
}

@doc("Base class for WorkloadNetworkDhcpServer and WorkloadNetworkDhcpRelay to inherit from")
@discriminator("dhcpType")
model WorkloadNetworkDhcpEntity {
  @doc("Display name of the DHCP entity.")
  displayName?: string;

  @doc("NSX Segments consuming DHCP.")
  @visibility("read")
  segments?: string[];

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: WorkloadNetworkDhcpProvisioningState;

  @doc("NSX revision number.")
  revision?: int32;
}

@doc("Properties of a NSX Gateway.")
model WorkloadNetworkGatewayProperties {
  @doc("Display name of the DHCP entity.")
  displayName?: string;

  @doc("NSX Gateway Path.")
  @visibility("read")
  path?: string;
}

@doc("NSX Port Mirroring Properties")
model WorkloadNetworkPortMirroringProperties {
  @doc("Display name of the port mirroring profile.")
  displayName?: string;

  @doc("Direction of port mirroring profile.")
  direction?: PortMirroringDirectionEnum;

  @doc("Source VM Group.")
  source?: string;

  @doc("Destination VM Group.")
  destination?: string;

  @doc("Port Mirroring Status.")
  @visibility("read")
  status?: PortMirroringStatusEnum;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: WorkloadNetworkPortMirroringProvisioningState;

  @doc("NSX revision number.")
  revision?: int32;
}

@doc("NSX VM Group Properties")
model WorkloadNetworkVMGroupProperties {
  @doc("Display name of the VM group.")
  displayName?: string;

  @doc("Virtual machine members of this group.")
  members?: string[];

  @doc("VM Group status.")
  @visibility("read")
  status?: VMGroupStatusEnum;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: WorkloadNetworkVMGroupProvisioningState;

  @doc("NSX revision number.")
  revision?: int32;
}

@doc("NSX Virtual Machine Properties")
model WorkloadNetworkVirtualMachineProperties {
  @doc("Display name of the VM.")
  displayName?: string;

  @doc("Virtual machine type.")
  @visibility("read")
  vmType?: VMTypeEnum;
}

@doc("NSX DNS Service Properties")
model WorkloadNetworkDnsServiceProperties {
  @doc("Display name of the DNS Service.")
  displayName?: string;

  @doc("DNS service IP of the DNS Service.")
  dnsServiceIp?: string;

  @doc("Default DNS zone of the DNS Service.")
  defaultDnsZone?: string;

  @doc("FQDN zones of the DNS Service.")
  fqdnZones?: string[];

  @doc("DNS Service log level.")
  logLevel?: DnsServiceLogLevelEnum;

  @doc("DNS Service status.")
  @visibility("read")
  status?: DnsServiceStatusEnum;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: WorkloadNetworkDnsServiceProvisioningState;

  @doc("NSX revision number.")
  revision?: int32;
}

@doc("NSX DNS Zone Properties")
model WorkloadNetworkDnsZoneProperties {
  @doc("Display name of the DNS Zone.")
  displayName?: string;

  @doc("Domain names of the DNS Zone.")
  domain?: string[];

  @doc("DNS Server IP array of the DNS Zone.")
  dnsServerIps?: string[];

  @doc("Source IP of the DNS Zone.")
  sourceIp?: string;

  @doc("Number of DNS Services using the DNS zone.")
  dnsServices?: int32;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: WorkloadNetworkDnsZoneProvisioningState;

  @doc("NSX revision number.")
  revision?: int32;
}

@doc("NSX Public IP Block Properties")
model WorkloadNetworkPublicIPProperties {
  @doc("Display name of the Public IP Block.")
  displayName?: string;

  @doc("Number of Public IPs requested.")
  numberOfPublicIPs?: int32;

  @doc("CIDR Block of the Public IP Block.")
  @visibility("read")
  publicIPBlock?: string;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: WorkloadNetworkPublicIPProvisioningState;
}

@doc("The properties of a cloud link.")
model CloudLinkProperties {
  @doc("The state of the cloud link.")
  @visibility("read")
  status?: CloudLinkStatus;

  @doc("Identifier of the other private cloud participating in the link.")
  linkedCloud?: string;
}

@doc("The properties of an addon")
@discriminator("addonType")
model AddonProperties {
  @doc("The state of the addon provisioning")
  @visibility("read")
  provisioningState?: AddonProvisioningState;
}

@doc("Virtual Machine Properties")
model VirtualMachineProperties {
  @doc("Display name of the VM.")
  @visibility("read")
  displayName?: string;

  @doc("Virtual machine managed object reference id")
  @visibility("read")
  moRefId?: string;

  @doc("Path to virtual machine's folder starting from datacenter virtual machine folder")
  @visibility("read")
  folderPath?: string;

  @doc("Whether VM DRS-driven movement is restricted (enabled) or not (disabled)")
  @visibility("read")
  restrictMovement?: VirtualMachineRestrictMovementState;
}

@doc("Set VM DRS-driven movement to restricted (enabled) or not (disabled)")
model VirtualMachineRestrictMovement {
  @doc("Whether VM DRS-driven movement is restricted (enabled) or not (disabled)")
  restrictMovement?: VirtualMachineRestrictMovementState;
}

@doc("Abstract placement policy properties")
@discriminator("type")
model PlacementPolicyProperties {
  @doc("Whether the placement policy is enabled or disabled")
  state?: PlacementPolicyState;

  @doc("Display name of the placement policy")
  displayName?: string;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: PlacementPolicyProvisioningState;
}

@doc("An update of a DRS placement policy resource")
model PlacementPolicyUpdate {
  @doc("The properties of a placement policy resource that may be updated")
  properties?: PlacementPolicyUpdateProperties;
}

@doc("The properties of a placement policy resource that may be updated")
model PlacementPolicyUpdateProperties {
  @doc("Whether the placement policy is enabled or disabled")
  state?: PlacementPolicyState;

  @doc("Virtual machine members list")
  vmMembers?: string[];

  @doc("Host members list")
  hostMembers?: string[];

  @doc("vm-host placement policy affinity strength (should/must)")
  affinityStrength?: AffinityStrength;

  @doc("placement policy azure hybrid benefit opt-in type")
  azureHybridBenefitType?: AzureHybridBenefitType;
}

@doc("Properties of a Script Package subresource")
model ScriptPackageProperties {
  @doc("User friendly description of the package")
  @visibility("read")
  description?: string;

  @doc("Module version")
  @visibility("read")
  version?: string;

  @doc("Company that created and supports the package")
  @visibility("read")
  company?: string;

  @doc("Link to support by the package vendor")
  @visibility("read")
  uri?: string;
}

@doc("Properties of a pre-canned script")
model ScriptCmdletProperties {
  @doc("Description of the scripts functionality")
  @visibility("read")
  description?: string;

  @doc("Recommended time limit for execution")
  @visibility("read")
  timeout?: duration;

  @doc("Parameters the script will accept")
  @visibility("read")
  parameters?: ScriptParameter[];
}

@doc("An parameter that the script will accept")
model ScriptParameter {
  @doc("The type of parameter the script is expecting. psCredential is a PSCredentialObject")
  @visibility("read")
  type?: ScriptParameterTypes;

  @doc("The parameter name that the script will expect a parameter value for")
  name?: string;

  @doc("User friendly description of the parameter")
  @visibility("read")
  description?: string;

  @doc("Should this parameter be visible to arm and passed in the parameters argument when executing")
  @visibility("read")
  visibility?: VisibilityParameterEnum;

  @doc("Is this parameter required or optional")
  @visibility("read")
  optional?: OptionalParamEnum;
}

@doc("Properties of a user-invoked script")
model ScriptExecutionProperties {
  @doc("A reference to the script cmdlet resource if user is running a AVS script")
  scriptCmdletId?: string;

  @doc("Parameters the script will accept")
  parameters?: ScriptExecutionParameter[];

  @doc("Parameters that will be hidden/not visible to ARM, such as passwords and credentials")
  hiddenParameters?: ScriptExecutionParameter[];

  @doc("Error message if the script was able to run, but if the script itself had errors or powershell threw an exception")
  failureReason?: string;

  @doc("Time limit for execution")
  timeout: string;

  @doc("Time to live for the resource. If not provided, will be available for 60 days")
  retention?: string;

  @doc("Time the script execution was submitted")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  submittedAt?: utcDateTime;

  @doc("Time the script execution was started")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedAt?: utcDateTime;

  @doc("Time the script execution was finished")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  finishedAt?: utcDateTime;

  @doc("The state of the script execution resource")
  @visibility("read")
  provisioningState?: ScriptExecutionProvisioningState;

  @doc("Standard output stream from the powershell execution")
  output?: string[];

  @doc("User-defined dictionary.")
  namedOutputs?: Record<unknown>;

  @doc("Standard information out stream from the powershell execution")
  @visibility("read")
  information?: string[];

  @doc("Standard warning out stream from the powershell execution")
  @visibility("read")
  warnings?: string[];

  @doc("Standard error output stream from the powershell execution")
  @visibility("read")
  errors?: string[];
}

@doc("The arguments passed in to the execution")
@discriminator("type")
model ScriptExecutionParameter {
  @doc("The parameter name")
  name: string;
}

@doc("The properties of a Site Recovery Manager (SRM) addon")
model AddonSrmProperties extends AddonProperties {
  @doc("The Site Recovery Manager (SRM) license")
  licenseKey?: string;

  @doc("The type of private cloud addon")
  addonType: "SRM";
}

@doc("The properties of a vSphere Replication (VR) addon")
model AddonVrProperties extends AddonProperties {
  @doc("The vSphere Replication Server (VRS) count")
  vrsCount: int32;

  @doc("The type of private cloud addon")
  addonType: "VR";
}

@doc("The properties of an HCX addon")
model AddonHcxProperties extends AddonProperties {
  @doc("The HCX offer, example VMware MaaS Cloud Provider (Enterprise)")
  offer: string;

  @doc("The type of private cloud addon")
  addonType: "HCX";
}

@doc("The properties of an Arc addon")
model AddonArcProperties extends AddonProperties {
  @doc("The VMware vCenter resource ID")
  vCenter?: string;

  @doc("The type of private cloud addon")
  addonType: "Arc";
}

@doc("NSX DHCP Server")
model WorkloadNetworkDhcpServer extends WorkloadNetworkDhcpEntity {
  @doc("DHCP Server Address.")
  serverAddress?: string;

  @doc("DHCP Server Lease Time.")
  leaseTime?: int32;

  @doc("Type of DHCP: SERVER or RELAY.")
  dhcpType: "SERVER";
}

@doc("NSX DHCP Relay")
model WorkloadNetworkDhcpRelay extends WorkloadNetworkDhcpEntity {
  @doc("DHCP Relay Addresses. Max 3.")
  serverAddresses?: string[];

  @doc("Type of DHCP: SERVER or RELAY.")
  dhcpType: "RELAY";
}

@doc("VM-VM placement policy properties")
model VmVmPlacementPolicyProperties extends PlacementPolicyProperties {
  @doc("Virtual machine members list")
  vmMembers: string[];

  @doc("placement policy affinity type")
  affinityType: AffinityType;

  @doc("placement policy type")
  type: "VmVm";
}

@doc("VM-Host placement policy properties")
model VmHostPlacementPolicyProperties extends PlacementPolicyProperties {
  @doc("Virtual machine members list")
  vmMembers: string[];

  @doc("Host members list")
  hostMembers: string[];

  @doc("placement policy affinity type")
  affinityType: AffinityType;

  @doc("vm-host placement policy affinity strength (should/must)")
  affinityStrength?: AffinityStrength;

  @doc("placement policy azure hybrid benefit opt-in type")
  azureHybridBenefitType?: AzureHybridBenefitType;

  @doc("placement policy type")
  type: "VmHost";
}

@doc("a plain text value execution parameter")
model ScriptSecureStringExecutionParameter extends ScriptExecutionParameter {
  @doc("A secure value for the passed parameter, not to be stored in logs")
  secureValue?: string;

  @doc("The type of execution parameter")
  type: "SecureValue";
}

@doc("a plain text value execution parameter")
model ScriptStringExecutionParameter extends ScriptExecutionParameter {
  @doc("The value for the passed parameter")
  value?: string;

  @doc("The type of execution parameter")
  type: "Value";
}

@doc("a powershell credential object")
model PSCredentialExecutionParameter extends ScriptExecutionParameter {
  @doc("username for login")
  username?: string;

  @doc("password for login")
  password?: string;

  @doc("The type of execution parameter")
  type: "Credential";
}
