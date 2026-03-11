import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./NetworkInterface.tsp";
import "./NetworkInterfaceIPConfiguration.tsp";
import "./NetworkInterfaceTapConfiguration.tsp";
import "./PublicIPAddress.tsp";
import "./NetworkSecurityGroup.tsp";
import "./ApplicationSecurityGroup.tsp";
import "./RouteTable.tsp";
import "./ServiceEndpointPolicy.tsp";
import "./PrivateEndpoint.tsp";
import "./NatGateway.tsp";
import "./FlowLog.tsp";
import "./VirtualNetworkTap.tsp";
import "./PrivateLinkService.tsp";
import "./Subnet.tsp";
import "./BackendAddressPool.tsp";
import "./FrontendIPConfiguration.tsp";
import "./InboundNatRule.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum Features1 {
  applicationGateway,
  expressRoute,
  firewall,
  loadBalancer,
  networkGateway,
  networkManager,
  networkSecurityPerimeter,
  networkWatcher,
  networkingOperations,
  virtualNetwork,
  virtualWAN,
}

/**
 * The supported ExtendedLocation types. Currently only EdgeZone is supported in Microsoft.Network resources.
 */
union ExtendedLocationTypes {
  string,

  /**
   * EdgeZone
   */
  EdgeZone: "EdgeZone",
}

/**
 * Provisioning states of a resource.
 */
union ProvisioningState {
  string,

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",
}

/**
 * The current provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union NetworkProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The type of Azure hop the packet should be sent to.
 */
union RouteNextHopType {
  string,

  /**
   * VirtualNetworkGateway
   */
  VirtualNetworkGateway: "VirtualNetworkGateway",

  /**
   * VnetLocal
   */
  VnetLocal: "VnetLocal",

  /**
   * Internet
   */
  Internet: "Internet",

  /**
   * VirtualAppliance
   */
  VirtualAppliance: "VirtualAppliance",

  /**
   * None
   */
  None: "None",
}

/**
 * Specifies the IP version type for the private IPs of the private endpoint. If not defined, this defaults to IPv4.
 */
union PrivateEndpointIPVersionType {
  string,

  /**
   * Indicates that the Private IPs of the private endpoint will be IPv4 only.
   */
  IPv4: "IPv4",

  /**
   * Indicates that the Private IPs of the private endpoint will be IPv6 only.
   */
  IPv6: "IPv6",

  /**
   * Indicates that the Private IPs of the private endpoint can be both IPv4 and IPv6.
   */
  DualStack: "DualStack",
}

/**
 * IP address allocation method.
 */
union IPAllocationMethod {
  string,

  /**
   * Static
   */
  Static: "Static",

  /**
   * Dynamic
   */
  Dynamic: "Dynamic",
}

/**
 * Name of a public IP address SKU.
 */
union PublicIPAddressSkuName {
  string,

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * StandardV2
   */
  StandardV2: "StandardV2",
}

/**
 * Tier of a public IP address SKU.
 */
union PublicIPAddressSkuTier {
  string,

  /**
   * Regional
   */
  Regional: "Regional",

  /**
   * Global
   */
  Global: "Global",
}

/**
 * IP address version.
 */
union IPVersion {
  string,

  /**
   * IPv4
   */
  IPv4: "IPv4",

  /**
   * IPv6
   */
  IPv6: "IPv6",
}

/**
 * The DDoS protection mode of the public IP
 */
union DdosSettingsProtectionMode {
  string,

  /**
   * VirtualNetworkInherited
   */
  VirtualNetworkInherited: "VirtualNetworkInherited",

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Name of Nat Gateway SKU.
 */
union NatGatewaySkuName {
  string,

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * StandardV2
   */
  StandardV2: "StandardV2",
}

/**
 * Migration phase of Public IP Address.
 */
union PublicIPAddressMigrationPhase {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Prepare
   */
  Prepare: "Prepare",

  /**
   * Commit
   */
  Commit: "Commit",

  /**
   * Abort
   */
  Abort: "Abort",

  /**
   * Committed
   */
  Committed: "Committed",
}

/**
 * Specify what happens to the public IP address when the VM using it is deleted
 */
union DeleteOptions {
  string,

  /**
   * Delete
   */
  Delete: "Delete",

  /**
   * Detach
   */
  Detach: "Detach",
}

/**
 * Enable or Disable apply network policies on private end point in the subnet.
 */
union VirtualNetworkPrivateEndpointNetworkPolicies {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * NetworkSecurityGroupEnabled
   */
  NetworkSecurityGroupEnabled: "NetworkSecurityGroupEnabled",

  /**
   * RouteTableEnabled
   */
  RouteTableEnabled: "RouteTableEnabled",
}

/**
 * Enable or Disable apply network policies on private link service in the subnet.
 */
union VirtualNetworkPrivateLinkServiceNetworkPolicies {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Set this property to Tenant to allow sharing subnet with other subscriptions in your AAD tenant. This property can only be set if defaultOutboundAccess is set to false, both properties can only be set if subnet is empty.
 */
union SharingScope {
  string,

  /**
   * Tenant
   */
  Tenant: "Tenant",

  /**
   * DelegatedServices
   */
  DelegatedServices: "DelegatedServices",
}

/**
 * The file type of flow log.
 */
union FlowLogFormatType {
  string,

  /**
   * JSON
   */
  JSON: "JSON",
}

/**
 * Protocol of gateway load balancer tunnel interface.
 */
union GatewayLoadBalancerTunnelProtocol {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Native
   */
  Native: "Native",

  /**
   * VXLAN
   */
  VXLAN: "VXLAN",
}

/**
 * Traffic type of gateway load balancer tunnel interface.
 */
union GatewayLoadBalancerTunnelInterfaceType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Internal
   */
  Internal: "Internal",

  /**
   * External
   */
  External: "External",
}

/**
 * A list of administrative states which once set can override health probe so that Load Balancer will always forward new connections to backend, or deny new connections and reset existing connections.
 */
union LoadBalancerBackendAddressAdminState {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Up
   */
  Up: "Up",

  /**
   * Down
   */
  Down: "Down",
}

/**
 * Backend address synchronous mode for the backend pool
 */
union SyncMode {
  string,

  /**
   * Automatic
   */
  Automatic: "Automatic",

  /**
   * Manual
   */
  Manual: "Manual",
}

/**
 * The transport protocol for the endpoint.
 */
union TransportProtocol {
  string,

  /**
   * Udp
   */
  Udp: "Udp",

  /**
   * Tcp
   */
  Tcp: "Tcp",

  /**
   * All
   */
  All: "All",

  /**
   * Quic
   */
  Quic: "Quic",
}

/**
 * Type of Network Interface resource.
 */
union NetworkInterfaceNicType {
  string,

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * Elastic
   */
  Elastic: "Elastic",
}

/**
 * The access mode of the private link service.
 */
union AccessMode {
  string,

  /**
   * Allows unrestricted access to the private link service.
   */
  Default: "Default",

  /**
   * Limits access to subscriptions which are inside visibility list only.
   */
  Restricted: "Restricted",
}

/**
 * Migration phase of Network Interface resource.
 */
union NetworkInterfaceMigrationPhase {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Prepare
   */
  Prepare: "Prepare",

  /**
   * Commit
   */
  Commit: "Commit",

  /**
   * Abort
   */
  Abort: "Abort",

  /**
   * Committed
   */
  Committed: "Committed",
}

/**
 * Auxiliary mode of Network Interface resource.
 */
union NetworkInterfaceAuxiliaryMode {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * MaxConnections
   */
  MaxConnections: "MaxConnections",

  /**
   * Floating
   */
  Floating: "Floating",

  /**
   * AcceleratedConnections
   */
  AcceleratedConnections: "AcceleratedConnections",
}

/**
 * Auxiliary sku of Network Interface resource.
 */
union NetworkInterfaceAuxiliarySku {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * A1
   */
  A1: "A1",

  /**
   * A2
   */
  A2: "A2",

  /**
   * A4
   */
  A4: "A4",

  /**
   * A8
   */
  A8: "A8",
}

/**
 * The domain name label scope. If a domain name label and a domain name label scope are specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system with a hashed value includes in FQDN.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum PublicIpAddressDnsSettingsDomainNameLabelScope {
  /**
   * TenantReuse
   */
  TenantReuse,

  /**
   * SubscriptionReuse
   */
  SubscriptionReuse,

  /**
   * ResourceGroupReuse
   */
  ResourceGroupReuse,

  /**
   * NoReuse
   */
  NoReuse,
}

/**
 * The type of identity used for the resource. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the virtual machine.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ResourceIdentityType {
  /**
   * SystemAssigned
   */
  SystemAssigned,

  /**
   * UserAssigned
   */
  UserAssigned,

  /**
   * SystemAssigned, UserAssigned
   */
  `SystemAssigned, UserAssigned`,

  /**
   * None
   */
  None,
}

/**
 * ExtendedLocation complex type.
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
 * NetworkInterface properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model NetworkInterfacePropertiesFormat {
  /**
   * The reference to a virtual machine.
   */
  @visibility(Lifecycle.Read)
  virtualMachine?: SubResource;

  /**
   * The reference to the NetworkSecurityGroup resource.
   */
  networkSecurityGroup?: NetworkSecurityGroup;

  /**
   * A reference to the private endpoint to which the network interface is linked.
   */
  @visibility(Lifecycle.Read)
  privateEndpoint?: PrivateEndpoint;

  /**
   * A list of IPConfigurations of the network interface.
   */
  ipConfigurations?: NetworkInterfaceIPConfiguration[];

  /**
   * A list of TapConfigurations of the network interface.
   */
  @visibility(Lifecycle.Read)
  tapConfigurations?: NetworkInterfaceTapConfiguration[];

  /**
   * The DNS settings in network interface.
   */
  dnsSettings?: NetworkInterfaceDnsSettings;

  /**
   * The MAC address of the network interface.
   */
  @visibility(Lifecycle.Read)
  macAddress?: string;

  /**
   * Whether this is a primary network interface on a virtual machine.
   */
  @visibility(Lifecycle.Read)
  primary?: boolean;

  /**
   * Whether the virtual machine this nic is attached to supports encryption.
   */
  @visibility(Lifecycle.Read)
  vnetEncryptionSupported?: boolean;

  /**
   * Whether default outbound connectivity for nic was configured or not.
   */
  @visibility(Lifecycle.Read)
  defaultOutboundConnectivityEnabled?: boolean;

  /**
   * If the network interface is configured for accelerated networking. Not applicable to VM sizes which require accelerated networking.
   */
  enableAcceleratedNetworking?: boolean;

  /**
   * Indicates whether to disable tcp state tracking.
   */
  disableTcpStateTracking?: boolean;

  /**
   * Indicates whether IP forwarding is enabled on this network interface.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableIPForwarding?: boolean;

  /**
   * A list of references to linked BareMetal resources.
   */
  @visibility(Lifecycle.Read)
  hostedWorkloads?: string[];

  /**
   * A reference to the dscp configuration to which the network interface is linked.
   */
  @visibility(Lifecycle.Read)
  dscpConfiguration?: SubResource;

  /**
   * The resource GUID property of the network interface resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The provisioning state of the network interface resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * WorkloadType of the NetworkInterface for BareMetal resources
   */
  workloadType?: string;

  /**
   * Type of Network Interface resource.
   */
  nicType?: NetworkInterfaceNicType;

  /**
   * Privatelinkservice of the network interface resource.
   */
  privateLinkService?: PrivateLinkService;

  /**
   * Migration phase of Network Interface resource.
   */
  migrationPhase?: NetworkInterfaceMigrationPhase;

  /**
   * Auxiliary mode of Network Interface resource.
   */
  auxiliaryMode?: NetworkInterfaceAuxiliaryMode;

  /**
   * Auxiliary sku of Network Interface resource.
   */
  auxiliarySku?: NetworkInterfaceAuxiliarySku;
}

/**
 * Reference to another subresource.
 */
model SubResource {
  /**
   * Resource ID.
   */
  id?: string;
}

/**
 * Common resource representation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model Resource {
  /**
   * Resource ID.
   */
  id?: string;

  /**
   * Resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource location.
   */
  location?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Reference to another subresource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model SubResourceModel {
  /**
   * Resource ID.
   */
  id?: string;

  /**
   * Name of the resource.
   */
  name?: string;

  /**
   * Type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Properties of the subnet.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model SubnetPropertiesFormat {
  /**
   * The address prefix for the subnet.
   */
  addressPrefix?: string;

  /**
   * List of address prefixes for the subnet.
   */
  addressPrefixes?: string[];

  /**
   * The reference to the NetworkSecurityGroup resource.
   */
  networkSecurityGroup?: NetworkSecurityGroup;

  /**
   * The reference to the RouteTable resource.
   */
  routeTable?: RouteTable;

  /**
   * Nat gateway associated with this subnet.
   */
  natGateway?: SubResource;

  /**
   * An array of service endpoints.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serviceEndpoints?: ServiceEndpointPropertiesFormat[];

  /**
   * An array of service endpoint policies.
   */
  serviceEndpointPolicies?: ServiceEndpointPolicy[];

  /**
   * An array of references to private endpoints.
   */
  @visibility(Lifecycle.Read)
  privateEndpoints?: PrivateEndpoint[];

  /**
   * An array of references to the network interface IP configurations using subnet.
   */
  @visibility(Lifecycle.Read)
  ipConfigurations?: IPConfiguration[];

  /**
   * Array of IP configuration profiles which reference this subnet.
   */
  @visibility(Lifecycle.Read)
  ipConfigurationProfiles?: IPConfigurationProfile[];

  /**
   * Array of IpAllocation which reference this subnet.
   */
  ipAllocations?: SubResource[];

  /**
   * An array of references to the external resources using subnet.
   */
  @visibility(Lifecycle.Read)
  resourceNavigationLinks?: ResourceNavigationLink[];

  /**
   * An array of references to services injecting into this subnet.
   */
  @visibility(Lifecycle.Read)
  serviceAssociationLinks?: ServiceAssociationLink[];

  /**
   * An array of references to the delegations on the subnet.
   */
  delegations?: Delegation[];

  /**
   * A read-only string identifying the intention of use for this subnet based on delegations and other user-defined properties.
   */
  @visibility(Lifecycle.Read)
  purpose?: string;

  /**
   * The provisioning state of the subnet resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * Enable or Disable apply network policies on private end point in the subnet.
   */
  privateEndpointNetworkPolicies?: VirtualNetworkPrivateEndpointNetworkPolicies = VirtualNetworkPrivateEndpointNetworkPolicies.Disabled;

  /**
   * Enable or Disable apply network policies on private link service in the subnet.
   */
  privateLinkServiceNetworkPolicies?: VirtualNetworkPrivateLinkServiceNetworkPolicies = VirtualNetworkPrivateLinkServiceNetworkPolicies.Enabled;

  /**
   * Application gateway IP configurations of virtual network resource.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  applicationGatewayIPConfigurations?: ApplicationGatewayIPConfiguration[];

  /**
   * Set this property to Tenant to allow sharing subnet with other subscriptions in your AAD tenant. This property can only be set if defaultOutboundAccess is set to false, both properties can only be set if subnet is empty.
   */
  sharingScope?: SharingScope;

  /**
   * Set this property to false to disable default outbound connectivity for all VMs in the subnet.
   */
  defaultOutboundAccess?: boolean;

  /**
   * A list of IPAM Pools for allocating IP address prefixes.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ipamPoolPrefixAllocations?: IpamPoolPrefixAllocation[];

  /**
   * Reference to an existing service gateway.
   */
  serviceGateway?: SubResource;
}

/**
 * The service endpoint properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model ServiceEndpointPropertiesFormat {
  /**
   * The type of the endpoint service.
   */
  service?: string;

  /**
   * SubResource as network identifier.
   */
  networkIdentifier?: SubResource;

  /**
   * A list of locations.
   */
  locations?: string[];

  /**
   * The provisioning state of the service endpoint resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * IP configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model IPConfiguration extends SubResource {
  /**
   * Properties of the IP configuration.
   */
  properties?: IPConfigurationPropertiesFormat;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  name?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Properties of IP configuration.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model IPConfigurationPropertiesFormat {
  /**
   * The private IP address of the IP configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateIPAddress?: string;

  /**
   * The private IP address allocation method.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateIPAllocationMethod?: IPAllocationMethod;

  /**
   * The reference to the subnet resource.
   */
  subnet?: Subnet;

  /**
   * The reference to the public IP resource.
   */
  publicIPAddress?: PublicIPAddress;

  /**
   * The provisioning state of the IP configuration resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * SKU of a public IP address.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model PublicIPAddressSku {
  /**
   * Name of a public IP address SKU.
   */
  name?: PublicIPAddressSkuName;

  /**
   * Tier of a public IP address SKU.
   */
  tier?: PublicIPAddressSkuTier;
}

/**
 * Public IP address properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model PublicIPAddressPropertiesFormat {
  /**
   * The public IP address allocation method.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicIPAllocationMethod?: IPAllocationMethod;

  /**
   * The public IP address version.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicIPAddressVersion?: IPVersion;

  /**
   * The IP configuration associated with the public IP address.
   */
  @visibility(Lifecycle.Read)
  ipConfiguration?: IPConfiguration;

  /**
   * The FQDN of the DNS record associated with the public IP address.
   */
  dnsSettings?: PublicIPAddressDnsSettings;

  /**
   * The DDoS protection custom policy associated with the public IP address.
   */
  ddosSettings?: DdosSettings;

  /**
   * The list of tags associated with the public IP address.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ipTags?: IpTag[];

  /**
   * The IP address associated with the public IP address resource.
   */
  ipAddress?: string;

  /**
   * The Public IP Prefix this Public IP Address should be allocated from.
   */
  publicIPPrefix?: SubResource;

  /**
   * The idle timeout of the public IP address.
   */
  idleTimeoutInMinutes?: int32;

  /**
   * The resource GUID property of the public IP address resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The provisioning state of the public IP address resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The service public IP address of the public IP address resource.
   */
  servicePublicIPAddress?: PublicIPAddress;

  /**
   * The NatGateway for the Public IP address.
   */
  natGateway?: NatGateway;

  /**
   * Migration phase of Public IP Address.
   */
  migrationPhase?: PublicIPAddressMigrationPhase;

  /**
   * The linked public IP address of the public IP address resource.
   */
  linkedPublicIPAddress?: PublicIPAddress;

  /**
   * Specify what happens to the public IP address when the VM using it is deleted
   */
  deleteOption?: DeleteOptions;
}

/**
 * Contains FQDN of the DNS record associated with the public IP address.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model PublicIPAddressDnsSettings {
  /**
   * The domain name label. The concatenation of the domain name label and the regionalized DNS zone make up the fully qualified domain name associated with the public IP address. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system.
   */
  domainNameLabel?: string;

  /**
   * The domain name label scope. If a domain name label and a domain name label scope are specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system with a hashed value includes in FQDN.
   */
  domainNameLabelScope?: PublicIpAddressDnsSettingsDomainNameLabelScope;

  /**
   * The Fully Qualified Domain Name of the A DNS record associated with the public IP. This is the concatenation of the domainNameLabel and the regionalized DNS zone.
   */
  fqdn?: string;

  /**
   * The reverse FQDN. A user-visible, fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN.
   */
  reverseFqdn?: string;
}

/**
 * Contains the DDoS protection settings of the public IP.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model DdosSettings {
  /**
   * The DDoS protection mode of the public IP
   */
  protectionMode?: DdosSettingsProtectionMode;

  /**
   * The DDoS protection plan associated with the public IP. Can only be set if ProtectionMode is Enabled
   */
  ddosProtectionPlan?: SubResource;
}

/**
 * Contains the IpTag associated with the object.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model IpTag {
  /**
   * The IP tag type. Example: FirstPartyUsage.
   */
  ipTagType?: string;

  /**
   * The value of the IP tag associated with the public IP. Example: SQL.
   */
  tag?: string;
}

/**
 * IP configuration profile child resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model IPConfigurationProfile extends SubResource {
  /**
   * Properties of the IP configuration profile.
   */
  properties?: IPConfigurationProfilePropertiesFormat;

  /**
   * The name of the resource. This name can be used to access the resource.
   */
  name?: string;

  /**
   * Sub Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * IP configuration profile properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model IPConfigurationProfilePropertiesFormat {
  /**
   * The reference to the subnet resource to create a container network interface ip configuration.
   */
  subnet?: Subnet;

  /**
   * The provisioning state of the IP configuration profile resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * ResourceNavigationLink resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model ResourceNavigationLink extends SubResource {
  /**
   * Resource navigation link properties format.
   */
  properties?: ResourceNavigationLinkFormat;

  /**
   * Name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  name?: string;

  /**
   * Resource navigation link identifier.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Properties of ResourceNavigationLink.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model ResourceNavigationLinkFormat {
  /**
   * Resource type of the linked resource.
   */
  linkedResourceType?: string;

  /**
   * Link to the external resource.
   */
  link?: string;

  /**
   * The provisioning state of the resource navigation link resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * ServiceAssociationLink resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model ServiceAssociationLink extends SubResource {
  /**
   * Resource navigation link properties format.
   */
  properties?: ServiceAssociationLinkPropertiesFormat;

  /**
   * Name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  name?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Properties of ServiceAssociationLink.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model ServiceAssociationLinkPropertiesFormat {
  /**
   * Resource type of the linked resource.
   */
  linkedResourceType?: string;

  /**
   * Link to the external resource.
   */
  link?: string;

  /**
   * The provisioning state of the service association link resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * If true, the resource can be deleted.
   */
  allowDelete?: boolean;

  /**
   * A list of locations.
   */
  locations?: string[];
}

/**
 * Details the service to which the subnet is delegated.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model Delegation extends SubResource {
  /**
   * Properties of the subnet.
   */
  properties?: ServiceDelegationPropertiesFormat;

  /**
   * The name of the resource that is unique within a subnet. This name can be used to access the resource.
   */
  name?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Resource type.
   */
  type?: string;
}

/**
 * Properties of a service delegation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model ServiceDelegationPropertiesFormat {
  /**
   * The name of the service to whom the subnet should be delegated (e.g. Microsoft.Sql/servers).
   */
  serviceName?: string;

  /**
   * The actions permitted to the service upon delegation.
   */
  @visibility(Lifecycle.Read)
  actions?: string[];

  /**
   * The provisioning state of the service delegation resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * IP configuration of an application gateway. Currently 1 public and 1 private IP configuration is allowed.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.applicationGateway)
model ApplicationGatewayIPConfiguration extends SubResource {
  /**
   * Properties of the application gateway IP configuration.
   */
  properties?: ApplicationGatewayIPConfigurationPropertiesFormat;

  /**
   * Name of the IP configuration that is unique within an Application Gateway.
   */
  name?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Properties of IP configuration of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.applicationGateway)
model ApplicationGatewayIPConfigurationPropertiesFormat {
  /**
   * Reference to the subnet resource. A subnet from where application gateway gets its private address.
   */
  subnet?: SubResource;

  /**
   * The provisioning state of the application gateway IP configuration resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * IpamPool prefix allocation reference.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model IpamPoolPrefixAllocation {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  pool?: IpamPoolPrefixAllocationPool;

  /**
   * Number of IP addresses to allocate.
   */
  numberOfIpAddresses?: string;

  /**
   * List of assigned IP address prefixes in the IpamPool of the associated resource.
   */
  @visibility(Lifecycle.Read)
  allocatedAddressPrefixes?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model IpamPoolPrefixAllocationPool {
  /**
   * Resource id of the associated Azure IpamPool resource.
   */
  id?: Azure.Core.armResourceIdentifier;
}

/**
 * Identity for the resource.
 */
model ManagedServiceIdentity {
  /**
   * The principal id of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant id of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The type of identity used for the resource. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the virtual machine.
   */
  type?: ResourceIdentityType;

  /**
   * The list of user identities associated with resource. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<Components1Jq1T4ISchemasManagedserviceidentityPropertiesUserassignedidentitiesAdditionalproperties>;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Components1Jq1T4ISchemasManagedserviceidentityPropertiesUserassignedidentitiesAdditionalproperties {
  /**
   * The principal id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * Properties of IP configuration.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model NetworkInterfaceIPConfigurationPropertiesFormat {
  /**
   * The reference to gateway load balancer frontend IP.
   */
  gatewayLoadBalancer?: SubResource;

  /**
   * The reference to Virtual Network Taps.
   */
  virtualNetworkTaps?: VirtualNetworkTap[];

  /**
   * The reference to ApplicationGatewayBackendAddressPool resource.
   */
  applicationGatewayBackendAddressPools?: ApplicationGatewayBackendAddressPool[];

  /**
   * The reference to LoadBalancerBackendAddressPool resource.
   */
  loadBalancerBackendAddressPools?: BackendAddressPool[];

  /**
   * A list of references of LoadBalancerInboundNatRules.
   */
  loadBalancerInboundNatRules?: InboundNatRule[];

  /**
   * Private IP address of the IP configuration. It can be a single IP address or a CIDR block in the format <address>/<prefix-length>.
   */
  privateIPAddress?: string;

  /**
   * The private IP address prefix length. If specified and the allocation method is dynamic, the service will allocate a CIDR block instead of a single IP address.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @maxValue(128)
  @minValue(1)
  privateIPAddressPrefixLength?: int32 | null;

  /**
   * The private IP address allocation method.
   */
  privateIPAllocationMethod?: IPAllocationMethod;

  /**
   * Whether the specific IP configuration is IPv4 or IPv6. Default is IPv4.
   */
  privateIPAddressVersion?: IPVersion;

  /**
   * Subnet bound to the IP configuration.
   */
  subnet?: Subnet;

  /**
   * Whether this is a primary customer address on the network interface.
   */
  primary?: boolean;

  /**
   * Public IP address bound to the IP configuration.
   */
  publicIPAddress?: PublicIPAddress;

  /**
   * Application security groups in which the IP configuration is included.
   */
  applicationSecurityGroups?: ApplicationSecurityGroup[];

  /**
   * The provisioning state of the network interface IP configuration.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * PrivateLinkConnection properties for the network interface.
   */
  @visibility(Lifecycle.Read)
  privateLinkConnectionProperties?: NetworkInterfaceIPConfigurationPrivateLinkConnectionProperties;
}

/**
 * Properties of Frontend IP Configuration of the load balancer.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.loadBalancer)
model FrontendIPConfigurationPropertiesFormat {
  /**
   * An array of references to inbound rules that use this frontend IP.
   */
  @visibility(Lifecycle.Read)
  inboundNatRules?: SubResource[];

  /**
   * An array of references to inbound pools that use this frontend IP.
   */
  @visibility(Lifecycle.Read)
  inboundNatPools?: SubResource[];

  /**
   * An array of references to outbound rules that use this frontend IP.
   */
  @visibility(Lifecycle.Read)
  outboundRules?: SubResource[];

  /**
   * An array of references to load balancing rules that use this frontend IP.
   */
  @visibility(Lifecycle.Read)
  loadBalancingRules?: SubResource[];

  /**
   * The private IP address of the IP configuration.
   */
  privateIPAddress?: string;

  /**
   * The Private IP allocation method.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateIPAllocationMethod?: IPAllocationMethod;

  /**
   * Whether the specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateIPAddressVersion?: IPVersion;

  /**
   * The reference to the subnet resource.
   */
  subnet?: Subnet;

  /**
   * The reference to the Public IP resource.
   */
  publicIPAddress?: PublicIPAddress;

  /**
   * The reference to the Public IP Prefix resource.
   */
  publicIPPrefix?: SubResource;

  /**
   * The reference to gateway load balancer frontend IP.
   */
  gatewayLoadBalancer?: SubResource;

  /**
   * The provisioning state of the frontend IP configuration resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Backend Address Pool of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.applicationGateway)
model ApplicationGatewayBackendAddressPool extends SubResource {
  /**
   * Properties of the application gateway backend address pool.
   */
  properties?: ApplicationGatewayBackendAddressPoolPropertiesFormat;

  /**
   * Name of the backend address pool that is unique within an Application Gateway.
   */
  name?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Properties of Backend Address Pool of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.applicationGateway)
model ApplicationGatewayBackendAddressPoolPropertiesFormat {
  /**
   * Collection of references to IPs defined in network interfaces.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  backendIPConfigurations?: NetworkInterfaceIPConfiguration[];

  /**
   * Backend addresses.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  backendAddresses?: ApplicationGatewayBackendAddress[];

  /**
   * The provisioning state of the backend address pool resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Backend address of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.applicationGateway)
model ApplicationGatewayBackendAddress {
  /**
   * Fully qualified domain name (FQDN).
   */
  fqdn?: string;

  /**
   * IP address.
   */
  ipAddress?: string;
}

/**
 * Properties of the backend address pool.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.loadBalancer)
model BackendAddressPoolPropertiesFormat {
  /**
   * The location of the backend address pool.
   */
  location?: string;

  /**
   * An array of gateway load balancer tunnel interfaces.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tunnelInterfaces?: GatewayLoadBalancerTunnelInterface[];

  /**
   * An array of backend addresses.
   */
  loadBalancerBackendAddresses?: LoadBalancerBackendAddress[];

  /**
   * An array of references to IP addresses defined in network interfaces.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  backendIPConfigurations?: NetworkInterfaceIPConfiguration[];

  /**
   * An array of references to load balancing rules that use this backend address pool.
   */
  @visibility(Lifecycle.Read)
  loadBalancingRules?: SubResource[];

  /**
   * A reference to an outbound rule that uses this backend address pool.
   */
  @visibility(Lifecycle.Read)
  outboundRule?: SubResource;

  /**
   * An array of references to outbound rules that use this backend address pool.
   */
  @visibility(Lifecycle.Read)
  outboundRules?: SubResource[];

  /**
   * An array of references to inbound NAT rules that use this backend address pool.
   */
  @visibility(Lifecycle.Read)
  inboundNatRules?: SubResource[];

  /**
   * The provisioning state of the backend address pool resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * Amount of seconds Load Balancer waits for before sending RESET to client and backend address.
   */
  drainPeriodInSeconds?: int32;

  /**
   * A reference to a virtual network.
   */
  virtualNetwork?: SubResource;

  /**
   * Backend address synchronous mode for the backend pool
   */
  syncMode?: SyncMode;
}

/**
 * Gateway load balancer tunnel interface of a load balancer backend address pool.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.loadBalancer)
model GatewayLoadBalancerTunnelInterface {
  /**
   * Port of gateway load balancer tunnel interface.
   */
  port?: int32;

  /**
   * Identifier of gateway load balancer tunnel interface.
   */
  identifier?: int32;

  /**
   * Protocol of gateway load balancer tunnel interface.
   */
  protocol?: GatewayLoadBalancerTunnelProtocol;

  /**
   * Traffic type of gateway load balancer tunnel interface.
   */
  type?: GatewayLoadBalancerTunnelInterfaceType;
}

/**
 * Load balancer backend addresses.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.loadBalancer)
model LoadBalancerBackendAddress {
  /**
   * Properties of load balancer backend address pool.
   */
  properties?: LoadBalancerBackendAddressPropertiesFormat;

  /**
   * Name of the backend address.
   */
  name?: string;
}

/**
 * Properties of the load balancer backend addresses.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.loadBalancer)
model LoadBalancerBackendAddressPropertiesFormat {
  /**
   * Reference to an existing virtual network.
   */
  virtualNetwork?: SubResource;

  /**
   * Reference to an existing subnet.
   */
  subnet?: SubResource;

  /**
   * IP Address belonging to the referenced virtual network.
   */
  ipAddress?: string;

  /**
   * Reference to IP address defined in network interfaces.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  networkInterfaceIPConfiguration?: SubResource;

  /**
   * Reference to the frontend ip address configuration defined in regional loadbalancer.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  loadBalancerFrontendIPConfiguration?: SubResource;

  /**
   * Collection of inbound NAT rule port mappings.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  inboundNatRulesPortMapping?: NatRulePortMapping[];

  /**
   * A list of administrative states which once set can override health probe so that Load Balancer will always forward new connections to backend, or deny new connections and reset existing connections.
   */
  adminState?: LoadBalancerBackendAddressAdminState;
}

/**
 * Individual port mappings for inbound NAT rule created for backend pool.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.loadBalancer)
model NatRulePortMapping {
  /**
   * Name of inbound NAT rule.
   */
  inboundNatRuleName?: string;

  /**
   * Frontend port.
   */
  frontendPort?: int32;

  /**
   * Backend port.
   */
  backendPort?: int32;
}

/**
 * Properties of the inbound NAT rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.loadBalancer)
model InboundNatRulePropertiesFormat {
  /**
   * A reference to frontend IP addresses.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  frontendIPConfiguration?: SubResource;

  /**
   * A reference to a private IP address defined on a network interface of a VM. Traffic sent to the frontend port of each of the frontend IP configurations is forwarded to the backend IP.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  backendIPConfiguration?: NetworkInterfaceIPConfiguration;

  /**
   * The reference to the transport protocol used by the load balancing rule.
   */
  protocol?: TransportProtocol;

  /**
   * The port for the external endpoint. Port numbers for each rule must be unique within the Load Balancer. Acceptable values range from 1 to 65534.
   */
  frontendPort?: int32;

  /**
   * The port used for the internal endpoint. Acceptable values range from 1 to 65535.
   */
  backendPort?: int32;

  /**
   * The timeout for the TCP idle connection. The value can be set between 4 and 30 minutes. The default value is 4 minutes. This element is only used when the protocol is set to TCP.
   */
  idleTimeoutInMinutes?: int32;

  /**
   * Configures a virtual machine's endpoint for the floating IP capability required to configure a SQL AlwaysOn Availability Group. This setting is required when using the SQL AlwaysOn Availability Groups in SQL server. This setting can't be changed after you create the endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableFloatingIP?: boolean;

  /**
   * Receive bidirectional TCP Reset on TCP flow idle timeout or unexpected connection termination. This element is only used when the protocol is set to TCP.
   */
  enableTcpReset?: boolean;

  /**
   * The port range start for the external endpoint. This property is used together with BackendAddressPool and FrontendPortRangeEnd. Individual inbound NAT rule port mappings will be created for each backend address from BackendAddressPool. Acceptable values range from 1 to 65534.
   */
  frontendPortRangeStart?: int32;

  /**
   * The port range end for the external endpoint. This property is used together with BackendAddressPool and FrontendPortRangeStart. Individual inbound NAT rule port mappings will be created for each backend address from BackendAddressPool. Acceptable values range from 1 to 65534.
   */
  frontendPortRangeEnd?: int32;

  /**
   * A reference to backendAddressPool resource.
   */
  backendAddressPool?: SubResource;

  /**
   * The provisioning state of the inbound NAT rule resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * PrivateLinkConnection properties for the network interface.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model NetworkInterfaceIPConfigurationPrivateLinkConnectionProperties {
  /**
   * The group ID for current private link connection.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * The required member name for current private link connection.
   */
  @visibility(Lifecycle.Read)
  requiredMemberName?: string;

  /**
   * List of FQDNs for current private link connection.
   */
  @visibility(Lifecycle.Read)
  fqdns?: string[];
}

/**
 * DNS settings of a network interface.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features1.virtualNetwork)
model NetworkInterfaceDnsSettings {
  /**
   * List of DNS servers IP addresses. Use 'AzureProvidedDNS' to switch to azure provided DNS resolution. 'AzureProvidedDNS' value cannot be combined with other IPs, it must be the only value in dnsServers collection.
   */
  dnsServers?: string[];

  /**
   * If the VM that uses this NIC is part of an Availability Set, then this list will have the union of all DNS servers from all NICs that are part of the Availability Set. This property is what is configured on each of those VMs.
   */
  @visibility(Lifecycle.Read)
  appliedDnsServers?: string[];

  /**
   * Relative DNS name for this NIC used for internal communications between VMs in the same virtual network.
   */
  internalDnsNameLabel?: string;

  /**
   * Fully qualified DNS name supporting internal communications between VMs in the same virtual network.
   */
  @visibility(Lifecycle.Read)
  internalFqdn?: string;

  /**
   * Even if internalDnsNameLabel is not specified, a DNS entry is created for the primary NIC of the VM. This DNS name can be constructed by concatenating the VM name with the value of internalDomainNameSuffix.
   */
  @visibility(Lifecycle.Read)
  internalDomainNameSuffix?: string;
}

/**
 * An error response from the service.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
@error
model CloudError {
  /**
   * Cloud error body.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from the service.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
model CloudErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  code?: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  message?: string;

  /**
   * The target of the particular error. For example, the name of the property in error.
   */
  target?: string;

  /**
   * A list of additional details about the error.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  details?: CloudErrorBody[];
}
