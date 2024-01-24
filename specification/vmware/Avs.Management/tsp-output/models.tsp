import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AVS;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Trial status
 */
enum TrialStatus {
  TrialAvailable,
  TrialUsed,
  TrialDisabled,
}

/**
 * Host quota is active for current subscription
 */
enum QuotaEnabled {
  Enabled,
  Disabled,
}

/**
 * The provisioning state
 */
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

/**
 * Flag to indicate whether the private cloud has the quota for provisioned NSX Public IP count raised from 64 to 1024
 */
enum NsxPublicIpQuotaRaisedEnum {
  Enabled,
  Disabled,
}

/**
 * The state of the cluster provisioning
 */
enum ClusterProvisioningState {
  Succeeded,
  Failed,
  Cancelled,
  Deleting,
  Updating,
  Canceled,
}

/**
 * Connectivity to internet is enabled or disabled
 */
enum InternetEnum {
  Enabled,
  Disabled,
}

/**
 * Protect LDAP communication using SSL certificate (LDAPS)
 */
enum SslEnum {
  Enabled,
  Disabled,
}

/**
 * The availability strategy for the private cloud
 */
enum AvailabilityStrategy {
  SingleZone,
  DualZone,
}

/**
 * Status of customer managed encryption key
 */
enum EncryptionState {
  Enabled,
  Disabled,
}

/**
 * The state of key provided
 */
enum EncryptionKeyStatus {
  Connected,
  AccessDenied,
}

/**
 * Property of the key if user provided or auto detected
 */
enum EncryptionVersionType {
  Fixed,
  AutoDetected,
}

/**
 * The type of identity used for the private cloud. The type 'SystemAssigned' refers to an implicitly created identity. The type 'None' will remove any identities from the Private Cloud.
 */
enum ResourceIdentityType {
  SystemAssigned,
  None,
}

/**
 * The state of the datastore provisioning
 */
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

/**
 * Mode that describes whether the LUN has to be mounted as a datastore or attached as a LUN
 */
enum MountOptionEnum {
  MOUNT,
  ATTACH,
}

/**
 * The operational status of the datastore
 */
enum DatastoreStatus {
  Unknown,
  Accessible,
  Inaccessible,
  Attached,
  Detached,
  LostCommunication,
  DeadOrError,
}

/**
 * The status of the HCX Enterprise Site
 */
enum HcxEnterpriseSiteStatus {
  Available,
  Consumed,
  Deactivated,
  Deleted,
}

/**
 * The state of the  ExpressRoute Circuit Authorization provisioning
 */
enum ExpressRouteAuthorizationProvisioningState {
  Succeeded,
  Failed,
  Updating,
  Canceled,
}

/**
 * The state of the  ExpressRoute Circuit Authorization provisioning
 */
enum GlobalReachConnectionProvisioningState {
  Succeeded,
  Failed,
  Updating,
  Canceled,
}

/**
 * The connection status of the global reach connection
 */
enum GlobalReachConnectionStatus {
  Connected,
  Connecting,
  Disconnected,
}

enum WorkloadNetworkName {
  default,
}

/**
 * Segment status.
 */
enum SegmentStatusEnum {
  SUCCESS,
  FAILURE,
}

/**
 * The provisioning state
 */
enum WorkloadNetworkSegmentProvisioningState {
  Succeeded,
  Failed,
  Building,
  Deleting,
  Updating,
  Canceled,
}

/**
 * Type of DHCP: SERVER or RELAY.
 */
enum DhcpTypeEnum {
  SERVER,
  RELAY,
}

/**
 * The provisioning state
 */
enum WorkloadNetworkDhcpProvisioningState {
  Succeeded,
  Failed,
  Building,
  Deleting,
  Updating,
  Canceled,
}

/**
 * Direction of port mirroring profile.
 */
enum PortMirroringDirectionEnum {
  INGRESS,
  EGRESS,
  BIDIRECTIONAL,
}

/**
 * Port Mirroring Status.
 */
enum PortMirroringStatusEnum {
  SUCCESS,
  FAILURE,
}

/**
 * The provisioning state
 */
enum WorkloadNetworkPortMirroringProvisioningState {
  Succeeded,
  Failed,
  Building,
  Deleting,
  Updating,
  Canceled,
}

/**
 * VM Group status.
 */
enum VMGroupStatusEnum {
  SUCCESS,
  FAILURE,
}

/**
 * The provisioning state
 */
enum WorkloadNetworkVMGroupProvisioningState {
  Succeeded,
  Failed,
  Building,
  Deleting,
  Updating,
  Canceled,
}

/**
 * Virtual machine type.
 */
enum VMTypeEnum {
  REGULAR,
  EDGE,
  SERVICE,
}

/**
 * DNS Service log level.
 */
enum DnsServiceLogLevelEnum {
  DEBUG,
  INFO,
  WARNING,
  ERROR,
  FATAL,
}

/**
 * DNS Service status.
 */
enum DnsServiceStatusEnum {
  SUCCESS,
  FAILURE,
}

/**
 * The provisioning state
 */
enum WorkloadNetworkDnsServiceProvisioningState {
  Succeeded,
  Failed,
  Building,
  Deleting,
  Updating,
  Canceled,
}

/**
 * The provisioning state
 */
enum WorkloadNetworkDnsZoneProvisioningState {
  Succeeded,
  Failed,
  Building,
  Deleting,
  Updating,
  Canceled,
}

/**
 * The provisioning state
 */
enum WorkloadNetworkPublicIPProvisioningState {
  Succeeded,
  Failed,
  Building,
  Deleting,
  Updating,
  Canceled,
}

/**
 * The state of the cloud link.
 */
enum CloudLinkStatus {
  Active,
  Building,
  Deleting,
  Failed,
  Disconnected,
}

/**
 * The type of private cloud addon
 */
enum AddonType {
  SRM,
  VR,
  HCX,
  Arc,
}

/**
 * The state of the addon provisioning
 */
enum AddonProvisioningState {
  Succeeded,
  Failed,
  Cancelled,
  Building,
  Deleting,
  Updating,
  Canceled,
}

/**
 * Whether VM DRS-driven movement is restricted (enabled) or not (disabled)
 */
enum VirtualMachineRestrictMovementState {
  Enabled,
  Disabled,
}

/**
 * placement policy type
 */
enum PlacementPolicyType {
  VmVm,
  VmHost,
}

/**
 * Whether the placement policy is enabled or disabled
 */
enum PlacementPolicyState {
  Enabled,
  Disabled,
}

/**
 * The provisioning state
 */
enum PlacementPolicyProvisioningState {
  Succeeded,
  Failed,
  Building,
  Deleting,
  Updating,
  Canceled,
}

/**
 * VM-Host placement policy affinity strength (should/must)
 */
enum AffinityStrength {
  Should,
  Must,
}

/**
 * Placement policy hosts opt-in Azure Hybrid Benefit type
 */
enum AzureHybridBenefitType {
  SqlHost,
  None,
}

/**
 * The type of parameter the script is expecting. psCredential is a PSCredentialObject
 */
enum ScriptParameterTypes {
  String,
  SecureString,
  Credential,
  Int,
  Bool,
  Float,
}

/**
 * Should this parameter be visible to arm and passed in the parameters argument when executing
 */
enum VisibilityParameterEnum {
  Visible,
  Hidden,
}

/**
 * Is this parameter required or optional
 */
enum OptionalParamEnum {
  Optional,
  Required,
}

/**
 * The type of execution parameter
 */
enum ScriptExecutionParameterType {
  Value,
  SecureValue,
  Credential,
}

/**
 * The state of the script execution resource
 */
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

/**
 * Placement policy affinity type
 */
enum AffinityType {
  Affinity,
  AntiAffinity,
}

/**
 * Extra Operation properties
 */
model OperationProperties {
  /**
   * Service specifications of the operation
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * Service specification payload
 */
model ServiceSpecification {
  /**
   * Specifications of the Log for Azure Monitoring
   */
  logSpecifications?: LogSpecification[];

  /**
   * Specifications of the Metrics for Azure Monitoring
   */
  metricSpecifications?: MetricSpecification[];
}

/**
 * Specifications of the Log for Azure Monitoring
 */
model LogSpecification {
  /**
   * Name of the log
   */
  name?: string;

  /**
   * Localized friendly display name of the log
   */
  displayName?: string;

  /**
   * Blob duration of the log
   */
  blobDuration?: string;
}

/**
 * Specifications of the Metrics for Azure Monitoring
 */
model MetricSpecification {
  /**
   * Name of the metric
   */
  name?: string;

  /**
   * Localized friendly display name of the metric
   */
  displayName?: string;

  /**
   * Localized friendly description of the metric
   */
  displayDescription?: string;

  /**
   * Unit that makes sense for the metric
   */
  unit?: string;

  /**
   * Name of the metric category that the metric belongs to. A metric can only belong to a single category.
   */
  category?: string;

  /**
   * Only provide one value for this field. Valid values: Average, Minimum, Maximum, Total, Count.
   */
  aggregationType?: string;

  /**
   * Supported aggregation types
   */
  supportedAggregationTypes?: string[];

  /**
   * Supported time grain types
   */
  supportedTimeGrainTypes?: string[];

  /**
   * Optional. If set to true, then zero will be returned for time duration where no metric is emitted/published.
   */
  fillGapWithZero?: boolean;

  /**
   * Dimensions of the metric
   */
  dimensions?: MetricDimension[];

  /**
   * Whether or not the service is using regional MDM accounts.
   */
  enableRegionalMdmAccount?: string;

  /**
   * The name of the MDM account.
   */
  sourceMdmAccount?: string;

  /**
   * The name of the MDM namespace.
   */
  sourceMdmNamespace?: string;
}

/**
 * Specifications of the Dimension of metrics
 */
model MetricDimension {
  /**
   * Name of the dimension
   */
  name?: string;

  /**
   * Localized friendly display name of the dimension
   */
  displayName?: string;

  /**
   * Name of the dimension as it appears in MDM
   */
  internalName?: string;

  /**
   * A boolean flag indicating whether this dimension should be included for the shoebox export scenario
   */
  toBeExportedForShoebox?: boolean;
}

/**
 * The resource model definition representing SKU
 */
model Sku {
  /**
   * The name of the SKU.
   */
  name: string;
}

/**
 * Subscription trial availability
 */
model Trial {
  /**
   * Trial status
   */
  @visibility("read")
  status?: TrialStatus;

  /**
   * Number of trial hosts available
   */
  @visibility("read")
  availableHosts?: int32;
}

/**
 * Subscription quotas
 */
model Quota {
  /**
   * Remaining hosts quota by sku type
   */
  @visibility("read")
  hostsRemaining?: Record<int32>;

  /**
   * Host quota is active for current subscription
   */
  @visibility("read")
  quotaEnabled?: QuotaEnabled;
}

/**
 * The properties of a private cloud resource
 */
model PrivateCloudProperties extends PrivateCloudUpdateProperties {
  /**
   * The provisioning state
   */
  @visibility("read")
  provisioningState?: PrivateCloudProvisioningState;

  /**
   * An ExpressRoute Circuit
   */
  circuit?: Circuit;

  /**
   * The endpoints
   */
  @visibility("read")
  endpoints?: Endpoints;

  /**
   * The block of addresses should be unique across VNet in your subscription as well as on-premise. Make sure the CIDR format is conformed to (A.B.C.D/X) where A,B,C,D are between 0 and 255, and X is between 0 and 22
   */
  @visibility("read", "create")
  networkBlock: string;

  /**
   * Network used to access vCenter Server and NSX-T Manager
   */
  @visibility("read")
  managementNetwork?: string;

  /**
   * Used for virtual machine cold migration, cloning, and snapshot migration
   */
  @visibility("read")
  provisioningNetwork?: string;

  /**
   * Used for live migration of virtual machines
   */
  @visibility("read")
  vmotionNetwork?: string;

  /**
   * Optionally, set the vCenter admin password when the private cloud is created
   */
  vcenterPassword?: string;

  /**
   * Optionally, set the NSX-T Manager password when the private cloud is created
   */
  nsxtPassword?: string;

  /**
   * Thumbprint of the vCenter Server SSL certificate
   */
  @visibility("read")
  vcenterCertificateThumbprint?: string;

  /**
   * Thumbprint of the NSX-T Manager SSL certificate
   */
  @visibility("read")
  nsxtCertificateThumbprint?: string;

  /**
   * Array of cloud link IDs from other clouds that connect to this one
   */
  @visibility("read")
  externalCloudLinks?: string[];

  /**
   * A secondary expressRoute circuit from a separate AZ. Only present in a stretched private cloud
   */
  secondaryCircuit?: Circuit;

  /**
   * Flag to indicate whether the private cloud has the quota for provisioned NSX Public IP count raised from 64 to 1024
   */
  @visibility("read")
  nsxPublicIpQuotaRaised?: NsxPublicIpQuotaRaisedEnum;
}

/**
 * An ExpressRoute Circuit
 */
model Circuit {
  /**
   * CIDR of primary subnet
   */
  @visibility("read")
  primarySubnet?: string;

  /**
   * CIDR of secondary subnet
   */
  @visibility("read")
  secondarySubnet?: string;

  /**
   * Identifier of the ExpressRoute Circuit (Microsoft Colo only)
   */
  @visibility("read")
  expressRouteID?: string;

  /**
   * ExpressRoute Circuit private peering identifier
   */
  @visibility("read")
  expressRoutePrivatePeeringID?: string;
}

/**
 * Endpoint addresses
 */
model Endpoints {
  /**
   * Endpoint for the NSX-T Data Center manager
   */
  @visibility("read")
  nsxtManager?: string;

  /**
   * Endpoint for Virtual Center Server Appliance
   */
  @visibility("read")
  vcsa?: string;

  /**
   * Endpoint for the HCX Cloud Manager
   */
  @visibility("read")
  hcxCloudManager?: string;
}

/**
 * The properties of a private cloud resource that may be updated
 */
model PrivateCloudUpdateProperties {
  /**
   * The default cluster used for management
   */
  managementCluster?: ManagementCluster;

  /**
   * Connectivity to internet is enabled or disabled
   */
  internet?: InternetEnum = InternetEnum.Disabled;

  /**
   * vCenter Single Sign On Identity Sources
   */
  identitySources?: IdentitySource[];

  /**
   * Properties describing how the cloud is distributed across availability zones
   */
  @visibility("read", "create")
  availability?: AvailabilityProperties;

  /**
   * Customer managed key encryption, can be enabled or disabled
   */
  encryption?: Encryption;

  /**
   * Array of additional networks noncontiguous with networkBlock. Networks must be unique and non-overlapping across VNet in your subscription, on-premise, and this privateCloud networkBlock attribute. Make sure the CIDR format conforms to (A.B.C.D/X).
   */
  extendedNetworkBlocks?: string[];
}

/**
 * The properties of a management cluster
 */
model ManagementCluster extends CommonClusterProperties {}

/**
 * The common properties of a cluster
 */
model CommonClusterProperties {
  /**
   * The cluster size
   */
  clusterSize?: int32;

  /**
   * The state of the cluster provisioning
   */
  @visibility("read")
  provisioningState?: ClusterProvisioningState;

  /**
   * The identity
   */
  @visibility("read")
  clusterId?: int32;

  /**
   * The hosts
   */
  hosts?: string[];
}

/**
 * vCenter Single Sign On Identity Source
 */
model IdentitySource {
  /**
   * The name of the identity source
   */
  name?: string;

  /**
   * The domain's NetBIOS name
   */
  `alias`?: string;

  /**
   * The domain's dns name
   */
  domain?: string;

  /**
   * The base distinguished name for users
   */
  baseUserDN?: string;

  /**
   * The base distinguished name for groups
   */
  baseGroupDN?: string;

  /**
   * Primary server URL
   */
  primaryServer?: string;

  /**
   * Secondary server URL
   */
  secondaryServer?: string;

  /**
   * Protect LDAP communication using SSL certificate (LDAPS)
   */
  ssl?: SslEnum;

  /**
   * The ID of an Active Directory user with a minimum of read-only access to Base DN for users and group
   */
  username?: string;

  /**
   * The password of the Active Directory user with a minimum of read-only access to Base DN for users and groups.
   */
  password?: string;
}

/**
 * The properties describing private cloud availability zone distribution
 */
model AvailabilityProperties {
  /**
   * The availability strategy for the private cloud
   */
  strategy?: AvailabilityStrategy;

  /**
   * The primary availability zone for the private cloud
   */
  zone?: int32;

  /**
   * The secondary availability zone for the private cloud
   */
  secondaryZone?: int32;
}

/**
 * The properties of customer managed encryption key
 */
model Encryption {
  /**
   * Status of customer managed encryption key
   */
  status?: EncryptionState;

  /**
   * The key vault where the encryption key is stored
   */
  keyVaultProperties?: EncryptionKeyVaultProperties;
}

/**
 * An Encryption Key
 */
model EncryptionKeyVaultProperties {
  /**
   * The name of the key.
   */
  keyName?: string;

  /**
   * The version of the key.
   */
  keyVersion?: string;

  /**
   * The auto-detected version of the key if versionType is auto-detected.
   */
  @visibility("read")
  autoDetectedKeyVersion?: string;

  /**
   * The URL of the vault.
   */
  keyVaultUrl?: string;

  /**
   * The state of key provided
   */
  @visibility("read")
  keyState?: EncryptionKeyStatus;

  /**
   * Property of the key if user provided or auto detected
   */
  @visibility("read")
  versionType?: EncryptionVersionType;
}

/**
 * Identity for the virtual machine.
 */
model PrivateCloudIdentity {
  /**
   * The principal ID of private cloud identity. This property will only be provided for a system assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID associated with the private cloud. This property will only be provided for a system assigned identity.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The type of identity used for the private cloud. The type 'SystemAssigned' refers to an implicitly created identity. The type 'None' will remove any identities from the Private Cloud.
   */
  type?: ResourceIdentityType;
}

/**
 * The core properties of ARM resources
 */
model Resource {
  /**
   * Resource ID.
   */
  @visibility("read")
  id?: string;

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
}

/**
 * An update to a private cloud resource
 */
model PrivateCloudUpdate {
  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * The updatable properties of a private cloud resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: PrivateCloudUpdateProperties;

  /**
   * The identity of the private cloud, if configured.
   */
  identity?: PrivateCloudIdentity;
}

/**
 * The properties of a cluster
 */
model ClusterProperties extends CommonClusterProperties {}

/**
 * An update of a cluster resource
 */
model ClusterUpdate {
  /**
   * The properties of a cluster resource that may be updated
   */
  @extension("x-ms-client-flatten", true)
  properties?: ClusterUpdateProperties;
}

/**
 * The properties of a cluster that may be updated
 */
model ClusterUpdateProperties {
  /**
   * The cluster size
   */
  clusterSize?: int32;

  /**
   * The hosts
   */
  hosts?: string[];
}

/**
 * List of all zones and associated hosts for a cluster
 */
@pagedResult
model ClusterZoneList {
  /**
   * Zone and associated hosts info
   */
  @items
  zones?: ClusterZone[];
}

/**
 * Zone and associated hosts info
 */
model ClusterZone {
  /**
   * List of hosts belonging to the availability zone in a cluster
   */
  @visibility("read")
  hosts?: string[];

  /**
   * Availability zone identifier
   */
  @visibility("read")
  zone?: string;
}

/**
 * The properties of a datastore
 */
model DatastoreProperties {
  /**
   * The state of the datastore provisioning
   */
  @visibility("read")
  provisioningState?: DatastoreProvisioningState;

  /**
   * An Azure NetApp Files volume
   */
  netAppVolume?: NetAppVolume;

  /**
   * An iSCSI volume
   */
  diskPoolVolume?: DiskPoolVolume;

  /**
   * The operational status of the datastore
   */
  @visibility("read")
  status?: DatastoreStatus;
}

/**
 * An Azure NetApp Files volume from Microsoft.NetApp provider
 */
model NetAppVolume {
  /**
   * Azure resource ID of the NetApp volume
   */
  id: string;
}

/**
 * An iSCSI volume from Microsoft.StoragePool provider
 */
model DiskPoolVolume {
  /**
   * Azure resource ID of the iSCSI target
   */
  targetId: string;

  /**
   * Name of the LUN to be used for datastore
   */
  lunName: string;

  /**
   * Mode that describes whether the LUN has to be mounted as a datastore or attached as a LUN
   */
  mountOption?: MountOptionEnum = MountOptionEnum.MOUNT;

  /**
   * Device path
   */
  @visibility("read")
  path?: string;
}

/**
 * Administrative credentials for accessing vCenter and NSX-T
 */
model AdminCredentials {
  /**
   * NSX-T Manager username
   */
  @visibility("read")
  nsxtUsername?: string;

  /**
   * NSX-T Manager password
   */
  @visibility("read")
  nsxtPassword?: string;

  /**
   * vCenter admin username
   */
  @visibility("read")
  vcenterUsername?: string;

  /**
   * vCenter admin password
   */
  @visibility("read")
  vcenterPassword?: string;
}

/**
 * The properties of an HCX Enterprise Site
 */
model HcxEnterpriseSiteProperties {
  /**
   * The activation key
   */
  @visibility("read")
  activationKey?: string;

  /**
   * The status of the HCX Enterprise Site
   */
  @visibility("read")
  status?: HcxEnterpriseSiteStatus;
}

/**
 * The properties of an ExpressRoute Circuit Authorization resource
 */
model ExpressRouteAuthorizationProperties {
  /**
   * The state of the  ExpressRoute Circuit Authorization provisioning
   */
  @visibility("read")
  provisioningState?: ExpressRouteAuthorizationProvisioningState;

  /**
   * The ID of the ExpressRoute Circuit Authorization
   */
  @visibility("read")
  expressRouteAuthorizationId?: string;

  /**
   * The key of the ExpressRoute Circuit Authorization
   */
  @visibility("read")
  expressRouteAuthorizationKey?: string;

  /**
   * The ID of the ExpressRoute Circuit
   */
  expressRouteId?: string;
}

/**
 * The properties of a global reach connection
 */
model GlobalReachConnectionProperties {
  /**
   * The state of the  ExpressRoute Circuit Authorization provisioning
   */
  @visibility("read")
  provisioningState?: GlobalReachConnectionProvisioningState;

  /**
   * The network used for global reach carved out from the original network block provided for the private cloud
   */
  @visibility("read")
  addressPrefix?: string;

  /**
   * Authorization key from the peer express route used for the global reach connection
   */
  authorizationKey?: string;

  /**
   * The connection status of the global reach connection
   */
  @visibility("read")
  circuitConnectionStatus?: GlobalReachConnectionStatus;

  /**
   * Identifier of the ExpressRoute Circuit to peer with in the global reach connection
   */
  peerExpressRouteCircuit?: string;

  /**
   * The ID of the Private Cloud's ExpressRoute Circuit that is participating in the global reach connection
   */
  expressRouteId?: string;
}

/**
 * NSX Segment Properties
 */
model WorkloadNetworkSegmentProperties {
  /**
   * Display name of the segment.
   */
  displayName?: string;

  /**
   * Gateway which to connect segment to.
   */
  connectedGateway?: string;

  /**
   * Subnet which to connect segment to.
   */
  subnet?: WorkloadNetworkSegmentSubnet;

  /**
   * Port Vif which segment is associated with.
   */
  @visibility("read")
  portVif?: WorkloadNetworkSegmentPortVif[];

  /**
   * Segment status.
   */
  @visibility("read")
  status?: SegmentStatusEnum;

  /**
   * The provisioning state
   */
  @visibility("read")
  provisioningState?: WorkloadNetworkSegmentProvisioningState;

  /**
   * NSX revision number.
   */
  revision?: int64;
}

/**
 * Subnet configuration for segment
 */
model WorkloadNetworkSegmentSubnet {
  /**
   * DHCP Range assigned for subnet.
   */
  dhcpRanges?: string[];

  /**
   * Gateway address.
   */
  gatewayAddress?: string;
}

/**
 * Ports and any VIF attached to segment.
 */
model WorkloadNetworkSegmentPortVif {
  /**
   * Name of port or VIF attached to segment.
   */
  portName?: string;
}

/**
 * Base class for WorkloadNetworkDhcpServer and WorkloadNetworkDhcpRelay to inherit from
 */
@discriminator("dhcpType")
model WorkloadNetworkDhcpEntity {
  /**
   * Display name of the DHCP entity.
   */
  displayName?: string;

  /**
   * NSX Segments consuming DHCP.
   */
  @visibility("read")
  segments?: string[];

  /**
   * The provisioning state
   */
  @visibility("read")
  provisioningState?: WorkloadNetworkDhcpProvisioningState;

  /**
   * NSX revision number.
   */
  revision?: int64;
}

/**
 * Properties of a NSX Gateway.
 */
model WorkloadNetworkGatewayProperties {
  /**
   * Display name of the DHCP entity.
   */
  displayName?: string;

  /**
   * NSX Gateway Path.
   */
  @visibility("read")
  path?: string;
}

/**
 * NSX Port Mirroring Properties
 */
model WorkloadNetworkPortMirroringProperties {
  /**
   * Display name of the port mirroring profile.
   */
  displayName?: string;

  /**
   * Direction of port mirroring profile.
   */
  direction?: PortMirroringDirectionEnum;

  /**
   * Source VM Group.
   */
  source?: string;

  /**
   * Destination VM Group.
   */
  destination?: string;

  /**
   * Port Mirroring Status.
   */
  @visibility("read")
  status?: PortMirroringStatusEnum;

  /**
   * The provisioning state
   */
  @visibility("read")
  provisioningState?: WorkloadNetworkPortMirroringProvisioningState;

  /**
   * NSX revision number.
   */
  revision?: int64;
}

/**
 * NSX VM Group Properties
 */
model WorkloadNetworkVMGroupProperties {
  /**
   * Display name of the VM group.
   */
  displayName?: string;

  /**
   * Virtual machine members of this group.
   */
  members?: string[];

  /**
   * VM Group status.
   */
  @visibility("read")
  status?: VMGroupStatusEnum;

  /**
   * The provisioning state
   */
  @visibility("read")
  provisioningState?: WorkloadNetworkVMGroupProvisioningState;

  /**
   * NSX revision number.
   */
  revision?: int64;
}

/**
 * NSX Virtual Machine Properties
 */
model WorkloadNetworkVirtualMachineProperties {
  /**
   * Display name of the VM.
   */
  displayName?: string;

  /**
   * Virtual machine type.
   */
  @visibility("read")
  vmType?: VMTypeEnum;
}

/**
 * NSX DNS Service Properties
 */
model WorkloadNetworkDnsServiceProperties {
  /**
   * Display name of the DNS Service.
   */
  displayName?: string;

  /**
   * DNS service IP of the DNS Service.
   */
  dnsServiceIp?: string;

  /**
   * Default DNS zone of the DNS Service.
   */
  defaultDnsZone?: string;

  /**
   * FQDN zones of the DNS Service.
   */
  fqdnZones?: string[];

  /**
   * DNS Service log level.
   */
  logLevel?: DnsServiceLogLevelEnum;

  /**
   * DNS Service status.
   */
  @visibility("read")
  status?: DnsServiceStatusEnum;

  /**
   * The provisioning state
   */
  @visibility("read")
  provisioningState?: WorkloadNetworkDnsServiceProvisioningState;

  /**
   * NSX revision number.
   */
  revision?: int64;
}

/**
 * NSX DNS Zone Properties
 */
model WorkloadNetworkDnsZoneProperties {
  /**
   * Display name of the DNS Zone.
   */
  displayName?: string;

  /**
   * Domain names of the DNS Zone.
   */
  domain?: string[];

  /**
   * DNS Server IP array of the DNS Zone.
   */
  dnsServerIps?: string[];

  /**
   * Source IP of the DNS Zone.
   */
  sourceIp?: string;

  /**
   * Number of DNS Services using the DNS zone.
   */
  dnsServices?: int64;

  /**
   * The provisioning state
   */
  @visibility("read")
  provisioningState?: WorkloadNetworkDnsZoneProvisioningState;

  /**
   * NSX revision number.
   */
  revision?: int64;
}

/**
 * NSX Public IP Block Properties
 */
model WorkloadNetworkPublicIPProperties {
  /**
   * Display name of the Public IP Block.
   */
  displayName?: string;

  /**
   * Number of Public IPs requested.
   */
  numberOfPublicIPs?: int64;

  /**
   * CIDR Block of the Public IP Block.
   */
  @visibility("read")
  publicIPBlock?: string;

  /**
   * The provisioning state
   */
  @visibility("read")
  provisioningState?: WorkloadNetworkPublicIPProvisioningState;
}

/**
 * The properties of a cloud link.
 */
model CloudLinkProperties {
  /**
   * The state of the cloud link.
   */
  @visibility("read")
  status?: CloudLinkStatus;

  /**
   * Identifier of the other private cloud participating in the link.
   */
  linkedCloud?: string;
}

/**
 * The properties of an addon
 */
@discriminator("addonType")
model AddonProperties {
  /**
   * The state of the addon provisioning
   */
  @visibility("read")
  provisioningState?: AddonProvisioningState;
}

/**
 * Virtual Machine Properties
 */
model VirtualMachineProperties {
  /**
   * Display name of the VM.
   */
  @visibility("read")
  displayName?: string;

  /**
   * Virtual machine managed object reference id
   */
  @visibility("read")
  moRefId?: string;

  /**
   * Path to virtual machine's folder starting from datacenter virtual machine folder
   */
  @visibility("read")
  folderPath?: string;

  /**
   * Whether VM DRS-driven movement is restricted (enabled) or not (disabled)
   */
  @visibility("read")
  restrictMovement?: VirtualMachineRestrictMovementState;
}

/**
 * Set VM DRS-driven movement to restricted (enabled) or not (disabled)
 */
model VirtualMachineRestrictMovement {
  /**
   * Whether VM DRS-driven movement is restricted (enabled) or not (disabled)
   */
  restrictMovement?: VirtualMachineRestrictMovementState;
}

/**
 * Abstract placement policy properties
 */
@discriminator("type")
model PlacementPolicyProperties {
  /**
   * Whether the placement policy is enabled or disabled
   */
  state?: PlacementPolicyState;

  /**
   * Display name of the placement policy
   */
  displayName?: string;

  /**
   * The provisioning state
   */
  @visibility("read")
  provisioningState?: PlacementPolicyProvisioningState;
}

/**
 * An update of a DRS placement policy resource
 */
model PlacementPolicyUpdate {
  /**
   * The properties of a placement policy resource that may be updated
   */
  @extension("x-ms-client-flatten", true)
  properties?: PlacementPolicyUpdateProperties;
}

/**
 * The properties of a placement policy resource that may be updated
 */
model PlacementPolicyUpdateProperties {
  /**
   * Whether the placement policy is enabled or disabled
   */
  state?: PlacementPolicyState;

  /**
   * Virtual machine members list
   */
  vmMembers?: string[];

  /**
   * Host members list
   */
  hostMembers?: string[];

  /**
   * vm-host placement policy affinity strength (should/must)
   */
  affinityStrength?: AffinityStrength;

  /**
   * placement policy azure hybrid benefit opt-in type
   */
  azureHybridBenefitType?: AzureHybridBenefitType;
}

/**
 * Properties of a Script Package subresource
 */
model ScriptPackageProperties {
  /**
   * User friendly description of the package
   */
  @visibility("read")
  description?: string;

  /**
   * Module version
   */
  @visibility("read")
  version?: string;

  /**
   * Company that created and supports the package
   */
  @visibility("read")
  company?: string;

  /**
   * Link to support by the package vendor
   */
  @visibility("read")
  uri?: string;
}

/**
 * Properties of a pre-canned script
 */
model ScriptCmdletProperties {
  /**
   * Description of the scripts functionality
   */
  @visibility("read")
  description?: string;

  /**
   * Recommended time limit for execution
   */
  @visibility("read")
  timeout?: duration;

  /**
   * Parameters the script will accept
   */
  @visibility("read")
  parameters?: ScriptParameter[];
}

/**
 * An parameter that the script will accept
 */
model ScriptParameter {
  /**
   * The type of parameter the script is expecting. psCredential is a PSCredentialObject
   */
  @visibility("read")
  type?: ScriptParameterTypes;

  /**
   * The parameter name that the script will expect a parameter value for
   */
  name?: string;

  /**
   * User friendly description of the parameter
   */
  @visibility("read")
  description?: string;

  /**
   * Should this parameter be visible to arm and passed in the parameters argument when executing
   */
  @visibility("read")
  visibility?: VisibilityParameterEnum;

  /**
   * Is this parameter required or optional
   */
  @visibility("read")
  optional?: OptionalParamEnum;
}

/**
 * Properties of a user-invoked script
 */
model ScriptExecutionProperties {
  /**
   * A reference to the script cmdlet resource if user is running a AVS script
   */
  scriptCmdletId?: string;

  /**
   * Parameters the script will accept
   */
  parameters?: ScriptExecutionParameter[];

  /**
   * Parameters that will be hidden/not visible to ARM, such as passwords and credentials
   */
  hiddenParameters?: ScriptExecutionParameter[];

  /**
   * Error message if the script was able to run, but if the script itself had errors or powershell threw an exception
   */
  failureReason?: string;

  /**
   * Time limit for execution
   */
  timeout: string;

  /**
   * Time to live for the resource. If not provided, will be available for 60 days
   */
  retention?: string;

  /**
   * Time the script execution was submitted
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  submittedAt?: utcDateTime;

  /**
   * Time the script execution was started
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedAt?: utcDateTime;

  /**
   * Time the script execution was finished
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  finishedAt?: utcDateTime;

  /**
   * The state of the script execution resource
   */
  @visibility("read")
  provisioningState?: ScriptExecutionProvisioningState;

  /**
   * Standard output stream from the powershell execution
   */
  output?: string[];

  /**
   * User-defined dictionary.
   */
  namedOutputs?: Record<unknown>;

  /**
   * Standard information out stream from the powershell execution
   */
  @visibility("read")
  information?: string[];

  /**
   * Standard warning out stream from the powershell execution
   */
  @visibility("read")
  warnings?: string[];

  /**
   * Standard error output stream from the powershell execution
   */
  @visibility("read")
  errors?: string[];
}

/**
 * The arguments passed in to the execution
 */
@discriminator("type")
model ScriptExecutionParameter {
  /**
   * The parameter name
   */
  name: string;
}

/**
 * The properties of a Site Recovery Manager (SRM) addon
 */
model AddonSrmProperties extends AddonProperties {
  /**
   * The Site Recovery Manager (SRM) license
   */
  licenseKey?: string;

  /**
   * The type of private cloud addon
   */
  addonType: "SRM";
}

/**
 * The properties of a vSphere Replication (VR) addon
 */
model AddonVrProperties extends AddonProperties {
  /**
   * The vSphere Replication Server (VRS) count
   */
  vrsCount: int32;

  /**
   * The type of private cloud addon
   */
  addonType: "VR";
}

/**
 * The properties of an HCX addon
 */
model AddonHcxProperties extends AddonProperties {
  /**
   * The HCX offer, example VMware MaaS Cloud Provider (Enterprise)
   */
  offer: string;

  /**
   * The type of private cloud addon
   */
  addonType: "HCX";
}

/**
 * The properties of an Arc addon
 */
model AddonArcProperties extends AddonProperties {
  /**
   * The VMware vCenter resource ID
   */
  vCenter?: string;

  /**
   * The type of private cloud addon
   */
  addonType: "Arc";
}

/**
 * NSX DHCP Server
 */
model WorkloadNetworkDhcpServer extends WorkloadNetworkDhcpEntity {
  /**
   * DHCP Server Address.
   */
  serverAddress?: string;

  /**
   * DHCP Server Lease Time.
   */
  leaseTime?: int64;

  /**
   * Type of DHCP: SERVER or RELAY.
   */
  dhcpType: "SERVER";
}

/**
 * NSX DHCP Relay
 */
model WorkloadNetworkDhcpRelay extends WorkloadNetworkDhcpEntity {
  /**
   * DHCP Relay Addresses. Max 3.
   */
  serverAddresses?: string[];

  /**
   * Type of DHCP: SERVER or RELAY.
   */
  dhcpType: "RELAY";
}

/**
 * VM-VM placement policy properties
 */
model VmVmPlacementPolicyProperties extends PlacementPolicyProperties {
  /**
   * Virtual machine members list
   */
  vmMembers: string[];

  /**
   * placement policy affinity type
   */
  affinityType: AffinityType;

  /**
   * placement policy type
   */
  type: "VmVm";
}

/**
 * VM-Host placement policy properties
 */
model VmHostPlacementPolicyProperties extends PlacementPolicyProperties {
  /**
   * Virtual machine members list
   */
  vmMembers: string[];

  /**
   * Host members list
   */
  hostMembers: string[];

  /**
   * placement policy affinity type
   */
  affinityType: AffinityType;

  /**
   * vm-host placement policy affinity strength (should/must)
   */
  affinityStrength?: AffinityStrength;

  /**
   * placement policy azure hybrid benefit opt-in type
   */
  azureHybridBenefitType?: AzureHybridBenefitType;

  /**
   * placement policy type
   */
  type: "VmHost";
}

/**
 * a plain text value execution parameter
 */
model ScriptSecureStringExecutionParameter extends ScriptExecutionParameter {
  /**
   * A secure value for the passed parameter, not to be stored in logs
   */
  secureValue?: string;

  /**
   * The type of execution parameter
   */
  type: "SecureValue";
}

/**
 * a plain text value execution parameter
 */
model ScriptStringExecutionParameter extends ScriptExecutionParameter {
  /**
   * The value for the passed parameter
   */
  value?: string;

  /**
   * The type of execution parameter
   */
  type: "Value";
}

/**
 * a powershell credential object
 */
model PSCredentialExecutionParameter extends ScriptExecutionParameter {
  /**
   * username for login
   */
  username?: string;

  /**
   * password for login
   */
  password?: string;

  /**
   * The type of execution parameter
   */
  type: "Credential";
}
