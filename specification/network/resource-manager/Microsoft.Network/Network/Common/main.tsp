import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
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
import "./Route.tsp";
import "./SecurityRule.tsp";
import "./ServiceEndpointPolicyDefinition.tsp";
import "./PrivateEndpointConnection.tsp";
import "./LoadBalancer.tsp";
import "./LoadBalancingRule.tsp";
import "./OutboundRule.tsp";
import "./Probe.tsp";
import "./VirtualNetwork.tsp";
import "./VirtualNetworkPeering.tsp";
import "./NetworkWatcher.tsp";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.versioned(Versions)
namespace Common;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2025-05-01 API version.
   */
  v2025_05_01: "2025-05-01",

  /**
   * The 2025-07-01 API version.
   */
  v2025_07_01: "2025-07-01",
}

#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required"
enum Features {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  applicationGateway,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  expressRoute,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  firewall,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  loadBalancer,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  networkGateway,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  networkManager,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  networkSecurityPerimeter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  networkWatcher,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  networkingOperations,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  virtualNetwork,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  virtualWAN,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  firewallPolicy,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  azureWebCategory,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  serviceGateway,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  virtualNetworkAppliance,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  smartGroup,
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
 * Name of a load balancer SKU.
 */
union LoadBalancerSkuName {
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
   * Gateway
   */
  Gateway: "Gateway",
}

/**
 * Tier of a load balancer SKU.
 */
union LoadBalancerSkuTier {
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
 * Indicates the scope of the load balancer: external (Public) or internal (Private).
 */
union LoadBalancerScope {
  string,

  /**
   * Public
   */
  Public: "Public",

  /**
   * Private
   */
  Private: "Private",
}

/**
 * If the encrypted VNet allows VM that does not support encryption. This field is for future support, AllowUnencrypted is the only supported value at general availability.
 */
union VirtualNetworkEncryptionEnforcement {
  string,

  /**
   * DropUnencrypted
   */
  DropUnencrypted: "DropUnencrypted",

  /**
   * AllowUnencrypted
   */
  AllowUnencrypted: "AllowUnencrypted",
}

/**
 * Private Endpoint VNet Policies.
 */
union PrivateEndpointVNetPolicies {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Basic
   */
  Basic: "Basic",
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
 * Whether Nat64 is enabled for the NAT gateway resource.
 */
@added(Versions.v2025_07_01)
union Nat64State {
  string,

  /**
   * Nat64 Property is not set.
   */
  None: "None",

  /**
   * Nat64 is enabled.
   */
  Enabled: "Enabled",

  /**
   * Nat64 is disabled.
   */
  Disabled: "Disabled",
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
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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
  provisioningState?: ProvisioningState;

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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model SubResourceModel extends SubResource {
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
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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
  provisioningState?: ProvisioningState;

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
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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
  provisioningState?: ProvisioningState;
}

/**
 * IP configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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
  provisioningState?: ProvisioningState;
}

/**
 * SKU of a public IP address.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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
  provisioningState?: ProvisioningState;

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
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model DdosSettings {
  /**
   * The DDoS protection mode of the public IP
   */
  protectionMode?: DdosSettingsProtectionMode;

  /**
   * The DDoS custom policy associated with the public IP.
   */
  ddosCustomPolicy?: SubResource;

  /**
   * The DDoS protection plan associated with the public IP. Can only be set if ProtectionMode is Enabled
   */
  ddosProtectionPlan?: SubResource;
}

/**
 * Contains the IpTag associated with the object.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model IPConfigurationProfilePropertiesFormat {
  /**
   * The reference to the subnet resource to create a container network interface ip configuration.
   */
  subnet?: Subnet;

  /**
   * The provisioning state of the IP configuration profile resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * ResourceNavigationLink resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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
  provisioningState?: ProvisioningState;
}

/**
 * ServiceAssociationLink resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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
  provisioningState?: ProvisioningState;

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
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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
  provisioningState?: ProvisioningState;
}

/**
 * IP configuration of an application gateway. Currently 1 public and 1 private IP configuration is allowed.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
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
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayIPConfigurationPropertiesFormat {
  /**
   * Reference to the subnet resource. A subnet from where application gateway gets its private address.
   */
  subnet?: SubResource;

  /**
   * The provisioning state of the application gateway IP configuration resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * IpamPool prefix allocation reference.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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
  provisioningState?: ProvisioningState;

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
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
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
  provisioningState?: ProvisioningState;

  /**
   * The DDoS protection settings associated with the frontend IP configuration.
   */
  @added(Versions.v2025_07_01)
  ddosSettings?: DdosFrontendIpConfigurationSettings;
}

/** DDoS protection settings for a frontend IP configuration. */
@added(Versions.v2025_07_01)
model DdosFrontendIpConfigurationSettings {
  /** The reference to the DDoS Custom Policy resource. */
  ddosCustomPolicy?: SubResource;
}

/**
 * Backend Address Pool of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
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
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
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
  provisioningState?: ProvisioningState;
}

/**
 * Backend address of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
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
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
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
  provisioningState?: ProvisioningState;

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
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
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
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
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
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
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
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
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
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
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
  provisioningState?: ProvisioningState;
}

/**
 * PrivateLinkConnection properties for the network interface.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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

/**
 * Network protocol this rule applies to.
 */
union SecurityRuleProtocol {
  string,

  /**
   * Tcp
   */
  Tcp: "Tcp",

  /**
   * Udp
   */
  Udp: "Udp",

  /**
   * Icmp
   */
  Icmp: "Icmp",

  /**
   * Esp
   */
  Esp: "Esp",

  /**
   * *
   */
  Asterisk: "*",

  /**
   * Ah
   */
  Ah: "Ah",
}

/**
 * Whether network traffic is allowed or denied.
 */
union SecurityRuleAccess {
  string,

  /**
   * Allow
   */
  Allow: "Allow",

  /**
   * Deny
   */
  Deny: "Deny",
}

/**
 * The direction of the rule. The direction specifies if rule will be evaluated on incoming or outgoing traffic.
 */
union SecurityRuleDirection {
  string,

  /**
   * Inbound
   */
  Inbound: "Inbound",

  /**
   * Outbound
   */
  Outbound: "Outbound",
}

/**
 * Properties of Virtual Network Tap configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model NetworkInterfaceTapConfigurationPropertiesFormat {
  /**
   * The reference to the Virtual Network Tap resource.
   */
  virtualNetworkTap?: VirtualNetworkTap;

  /**
   * The provisioning state of the network interface tap configuration resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Security rule resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
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
   * The application security group specified as source.
   */
  sourceApplicationSecurityGroups?: ApplicationSecurityGroup[];

  /**
   * The destination address prefix. CIDR or destination IP range. Asterisk '*' can also be used to match all source IPs. Default tags such as 'VirtualNetwork', 'AzureLoadBalancer' and 'Internet' can also be used.
   */
  destinationAddressPrefix?: string;

  /**
   * The destination address prefixes. CIDR or destination IP ranges.
   */
  destinationAddressPrefixes?: string[];

  /**
   * The application security group specified as destination.
   */
  destinationApplicationSecurityGroups?: ApplicationSecurityGroup[];

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

  /**
   * The provisioning state of the security rule resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * A collection of information about the state of the connection between service consumer and provider.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PrivateLinkServiceConnectionState {
  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
   */
  status?: string;

  /**
   * The reason for approval/rejection of the connection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: string;
}

/**
 * Properties of the PrivateEndpointConnectProperties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PrivateEndpointConnectionProperties {
  /**
   * The resource of private end point.
   */
  @visibility(Lifecycle.Read)
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;

  /**
   * The provisioning state of the private endpoint connection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The consumer link id.
   */
  @visibility(Lifecycle.Read)
  linkIdentifier?: string;

  /**
   * The location of the private endpoint.
   */
  @visibility(Lifecycle.Read)
  privateEndpointLocation?: string;
}

/**
 * PrivateLinkServiceConnection resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PrivateLinkServiceConnection extends SubResource {
  /**
   * Properties of the private link service connection.
   */
  properties?: PrivateLinkServiceConnectionProperties;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  name?: string;

  /**
   * The resource type.
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
 * Virtual Network Tap properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model VirtualNetworkTapPropertiesFormat {
  /**
   * Specifies the list of resource IDs for the network interface IP configuration that needs to be tapped.
   */
  @visibility(Lifecycle.Read)
  networkInterfaceTapConfigurations?: NetworkInterfaceTapConfiguration[];

  /**
   * The resource GUID property of the virtual network tap resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The provisioning state of the virtual network tap resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The reference to the private IP Address of the collector nic that will receive the tap.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  destinationNetworkInterfaceIPConfiguration?: NetworkInterfaceIPConfiguration;

  /**
   * The reference to the private IP address on the internal Load Balancer that will receive the tap.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  destinationLoadBalancerFrontEndIPConfiguration?: FrontendIPConfiguration;

  /**
   * The VXLAN destination port that will receive the tapped traffic.
   */
  destinationPort?: int32;
}

/**
 * Network Security Group resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model NetworkSecurityGroupPropertiesFormat {
  /**
   * When enabled, flows created from Network Security Group connections will be re-evaluated when rules are updates. Initial enablement will trigger re-evaluation.
   */
  flushConnection?: boolean;

  /**
   * A collection of security rules of the network security group.
   */
  securityRules?: SecurityRule[];

  /**
   * The default security rules of network security group.
   */
  @visibility(Lifecycle.Read)
  defaultSecurityRules?: SecurityRule[];

  /**
   * A collection of references to network interfaces.
   */
  @visibility(Lifecycle.Read)
  networkInterfaces?: NetworkInterface[];

  /**
   * A collection of references to subnets.
   */
  @visibility(Lifecycle.Read)
  subnets?: Subnet[];

  /**
   * A collection of references to flow log resources.
   */
  @visibility(Lifecycle.Read)
  flowLogs?: FlowLog[];

  /**
   * The resource GUID property of the network security group resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The provisioning state of the network security group resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Application security group properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model ApplicationSecurityGroupPropertiesFormat {
  /**
   * The resource GUID property of the application security group resource. It uniquely identifies a resource, even if the user changes its name or migrate the resource across subscriptions or resource groups.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The provisioning state of the application security group resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Properties of the private endpoint.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PrivateEndpointProperties {
  /**
   * The ID of the subnet from which the private IP will be allocated.
   */
  subnet?: Subnet;

  /**
   * An array of references to the network interfaces created for this private endpoint.
   */
  @visibility(Lifecycle.Read)
  networkInterfaces?: NetworkInterface[];

  /**
   * The provisioning state of the private endpoint resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Specifies the IP version type for the private IPs of the private endpoint. If not defined, this defaults to IPv4.
   */
  ipVersionType?: PrivateEndpointIPVersionType = PrivateEndpointIPVersionType.IPv4;

  /**
   * A grouping of information about the connection to the remote resource.
   */
  privateLinkServiceConnections?: PrivateLinkServiceConnection[];

  /**
   * A grouping of information about the connection to the remote resource. Used when the network admin does not have access to approve connections to the remote resource.
   */
  manualPrivateLinkServiceConnections?: PrivateLinkServiceConnection[];

  /**
   * An array of custom dns configurations.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  customDnsConfigs?: CustomDnsConfigPropertiesFormat[];

  /**
   * Application security groups in which the private endpoint IP configuration is included.
   */
  applicationSecurityGroups?: ApplicationSecurityGroup[];

  /**
   * A list of IP configurations of the private endpoint. This will be used to map to the First Party Service's endpoints.
   */
  ipConfigurations?: PrivateEndpointIPConfiguration[];

  /**
   * The custom name of the network interface attached to the private endpoint.
   */
  customNetworkInterfaceName?: string;
}

/**
 * Contains custom Dns resolution configuration from customer.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model CustomDnsConfigPropertiesFormat {
  /**
   * Fqdn that resolves to private endpoint ip address.
   */
  fqdn?: string;

  /**
   * A list of private ip addresses of the private endpoint.
   */
  ipAddresses?: string[];
}

/**
 * Properties of the private link service.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PrivateLinkServiceProperties {
  /**
   * An array of references to the load balancer IP configurations.
   */
  loadBalancerFrontendIpConfigurations?: FrontendIPConfiguration[];

  /**
   * An array of private link service IP configurations.
   */
  ipConfigurations?: PrivateLinkServiceIpConfiguration[];

  /**
   * The destination IP address of the private link service.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  destinationIPAddress?: string;

  /**
   * The access mode of the private link service.
   */
  accessMode?: AccessMode;

  /**
   * An array of references to the network interfaces created for this private link service.
   */
  @visibility(Lifecycle.Read)
  networkInterfaces?: NetworkInterface[];

  /**
   * The provisioning state of the private link service resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * An array of list about connections to the private endpoint.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * The visibility list of the private link service.
   */
  visibility?: PrivateLinkServicePropertiesVisibility;

  /**
   * The auto-approval list of the private link service.
   */
  autoApproval?: PrivateLinkServicePropertiesAutoApproval;

  /**
   * The list of Fqdn.
   */
  fqdns?: string[];

  /**
   * The alias of the private link service.
   */
  @visibility(Lifecycle.Read)
  `alias`?: string;

  /**
   * Whether the private link service is enabled for proxy protocol or not.
   */
  enableProxyProtocol?: boolean;
}

/**
 * The visibility list of the private link service.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PrivateLinkServicePropertiesVisibility extends ResourceSet {}

/**
 * The base resource set for visibility and auto-approval.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model ResourceSet {
  /**
   * The list of subscriptions.
   */
  subscriptions?: string[];
}

/**
 * The auto-approval list of the private link service.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PrivateLinkServicePropertiesAutoApproval extends ResourceSet {}

/**
 * Parameters that define the configuration of flow log.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model FlowLogPropertiesFormat {
  /**
   * ID of network security group to which flow log will be applied.
   */
  targetResourceId: string;

  /**
   * Guid of network security group to which flow log will be applied.
   */
  @visibility(Lifecycle.Read)
  targetResourceGuid?: string;

  /**
   * ID of the storage account which is used to store the flow log.
   */
  storageId: string;

  /**
   * Optional field to filter network traffic logs based on SrcIP, SrcPort, DstIP, DstPort, Protocol, Encryption, Direction and Action. If not specified, all network traffic will be logged.
   */
  enabledFilteringCriteria?: string;

  /**
   * Optional field to filter network traffic logs based on flow states. Value of this field could be any comma separated combination string of letters B,C,E or D. B represents Begin, when a flow is created. C represents Continue for an ongoing flow generated at every five-minute interval. E represents End, when a flow is terminated. D represents Deny, when a flow is denied. If not specified, all network traffic will be logged.
   */
  recordTypes?: string;

  /**
   * Flag to enable/disable flow logging.
   */
  enabled?: boolean;

  /**
   * Parameters that define the retention policy for flow log.
   */
  retentionPolicy?: RetentionPolicyParameters;

  /**
   * Parameters that define the flow log format.
   */
  format?: FlowLogFormatParameters;

  /**
   * Parameters that define the configuration of traffic analytics.
   */
  flowAnalyticsConfiguration?: TrafficAnalyticsProperties;

  /**
   * The provisioning state of the flow log.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Parameters that define the retention policy for flow log.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model RetentionPolicyParameters {
  /**
   * Number of days to retain flow log records.
   */
  days?: int32 = 0;

  /**
   * Flag to enable/disable retention.
   */
  enabled?: boolean = false;
}

/**
 * Parameters that define the flow log format.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model FlowLogFormatParameters {
  /**
   * The file type of flow log.
   */
  type?: FlowLogFormatType;

  /**
   * The version (revision) of the flow log.
   */
  version?: int32 = 0;
}

/**
 * Parameters that define the configuration of traffic analytics.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model TrafficAnalyticsProperties {
  /**
   * Parameters that define the configuration of traffic analytics.
   */
  networkWatcherFlowAnalyticsConfiguration?: TrafficAnalyticsConfigurationProperties;
}

/**
 * Parameters that define the configuration of traffic analytics.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model TrafficAnalyticsConfigurationProperties {
  /**
   * Flag to enable/disable traffic analytics.
   */
  enabled?: boolean;

  /**
   * The resource guid of the attached workspace.
   */
  workspaceId?: string;

  /**
   * The location of the attached workspace.
   */
  workspaceRegion?: string;

  /**
   * Resource Id of the attached workspace.
   */
  workspaceResourceId?: string;

  /**
   * The interval in minutes which would decide how frequently TA service should do flow analytics.
   */
  trafficAnalyticsInterval?: int32;
}

/**
 * Route Table resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model RouteTablePropertiesFormat {
  /**
   * Collection of routes contained within a route table.
   */
  routes?: Route[];

  /**
   * A collection of references to subnets.
   */
  @visibility(Lifecycle.Read)
  subnets?: Subnet[];

  /**
   * Whether to disable the routes learned by BGP on that route table. True means disable.
   */
  disableBgpRoutePropagation?: boolean;

  /**
   * The provisioning state of the route table resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The resource GUID property of the route table.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;
}

/**
 * Service Endpoint Policy resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ServiceEndpointPolicyPropertiesFormat {
  /**
   * A collection of service endpoint policy definitions of the service endpoint policy.
   */
  serviceEndpointPolicyDefinitions?: ServiceEndpointPolicyDefinition[];

  /**
   * A collection of references to subnets.
   */
  @visibility(Lifecycle.Read)
  subnets?: Subnet[];

  /**
   * The resource GUID property of the service endpoint policy resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The provisioning state of the service endpoint policy resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The alias indicating if the policy belongs to a service
   */
  serviceAlias?: string;

  /**
   * A collection of contextual service endpoint policy.
   */
  contextualServiceEndpointPolicies?: string[];
}

/**
 * SKU of nat gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model NatGatewaySku {
  /**
   * Name of Nat Gateway SKU.
   */
  name?: NatGatewaySkuName;
}

/**
 * Nat Gateway properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model NatGatewayPropertiesFormat {
  /**
   * The idle timeout of the nat gateway.
   */
  idleTimeoutInMinutes?: int32;

  /**
   * An array of public ip addresses V4 associated with the nat gateway resource.
   */
  publicIpAddresses?: SubResource[];

  /**
   * An array of public ip addresses V6 associated with the nat gateway resource.
   */
  publicIpAddressesV6?: SubResource[];

  /**
   * An array of public ip prefixes V4 associated with the nat gateway resource.
   */
  publicIpPrefixes?: SubResource[];

  /**
   * An array of public ip prefixes V6 associated with the nat gateway resource.
   */
  publicIpPrefixesV6?: SubResource[];

  /**
   * An array of references to the subnets using this nat gateway resource.
   */
  @visibility(Lifecycle.Read)
  subnets?: SubResource[];

  /**
   * A reference to the source virtual network using this nat gateway resource.
   */
  sourceVirtualNetwork?: SubResource;

  /**
   * Reference to an existing service gateway.
   */
  serviceGateway?: SubResource;

  /**
   * Whether Nat64 is enabled for the NAT gateway resource.
   */
  @added(Versions.v2025_07_01)
  nat64?: Nat64State;

  /**
   * The resource GUID property of the NAT gateway resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The provisioning state of the NAT gateway resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Properties of the load balancer.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
model LoadBalancingRulePropertiesFormat {
  /**
   * A reference to frontend IP addresses.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  frontendIPConfiguration?: SubResource;

  /**
   * A reference to a pool of DIPs. Inbound traffic is randomly load balanced across IPs in the backend IPs.
   */
  backendAddressPool?: SubResource;

  /**
   * An array of references to pool of DIPs.
   */
  backendAddressPools?: SubResource[];

  /**
   * The reference to the load balancer probe used by the load balancing rule.
   */
  probe?: SubResource;

  /**
   * The reference to the transport protocol used by the load balancing rule.
   */
  protocol: TransportProtocol;

  /**
   * The load distribution policy for this rule.
   */
  loadDistribution?: LoadDistribution;

  /**
   * The port for the external endpoint. Port numbers for each rule must be unique within the Load Balancer. Acceptable values are between 0 and 65534. Note that value 0 enables "Any Port".
   */
  frontendPort: int32;

  /**
   * The port used for internal connections on the endpoint. Acceptable values are between 0 and 65535. Note that value 0 enables "Any Port".
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
   * Configures SNAT for the VMs in the backend pool to use the publicIP address specified in the frontend of the load balancing rule.
   */
  disableOutboundSnat?: boolean;

  /**
   * Defines whether connections between 2 communicating endpoints can be tracked and associated to the same backend VM over its lifetime when using UDP protocol.
   */
  enableConnectionTracking?: boolean;

  /**
   * The provisioning state of the load balancing rule resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Load balancer probe resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
model ProbePropertiesFormat {
  /**
   * The load balancer rules that use this probe.
   */
  @visibility(Lifecycle.Read)
  loadBalancingRules?: SubResource[];

  /**
   * The protocol of the end point. If 'Tcp' is specified, a received ACK is required for the probe to be successful. If 'Http' or 'Https' is specified, a 200 OK response from the specifies URI is required for the probe to be successful.
   */
  protocol: ProbeProtocol;

  /**
   * The port for communicating the probe. Possible values range from 1 to 65535, inclusive.
   */
  port: int32;

  /**
   * The interval, in seconds, for how frequently to probe the endpoint for health status. Typically, the interval is slightly less than half the allocated timeout period (in seconds) which allows two full probes before taking the instance out of rotation. The default value is 15, the minimum value is 5.
   */
  intervalInSeconds?: int32;

  /**
   * Determines how new connections are handled by the load balancer when all backend instances are probed down.
   */
  noHealthyBackendsBehavior?: ProbeNoHealthyBackendsBehavior;

  /**
   * The number of probes where if no response, will result in stopping further traffic from being delivered to the endpoint. This values allows endpoints to be taken out of rotation faster or slower than the typical times used in Azure.
   */
  numberOfProbes?: int32;

  /**
   * The number of consecutive successful or failed probes in order to allow or deny traffic from being delivered to this endpoint. After failing the number of consecutive probes equal to this value, the endpoint will be taken out of rotation and require the same number of successful consecutive probes to be placed back in rotation.
   */
  probeThreshold?: int32;

  /**
   * The URI used for requesting health status from the VM. Path is required if a protocol is set to http. Otherwise, it is not allowed. There is no default value.
   */
  requestPath?: string;

  /**
   * The provisioning state of the probe resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Inbound NAT pool of the load balancer.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
model InboundNatPool extends SubResource {
  /**
   * Properties of load balancer inbound nat pool.
   */
  properties?: InboundNatPoolPropertiesFormat;

  /**
   * The name of the resource that is unique within the set of inbound NAT pools used by the load balancer. This name can be used to access the resource.
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
 * Properties of Inbound NAT pool.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
model InboundNatPoolPropertiesFormat {
  /**
   * A reference to frontend IP addresses.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  frontendIPConfiguration?: SubResource;

  /**
   * The reference to the transport protocol used by the inbound NAT pool.
   */
  protocol: TransportProtocol;

  /**
   * The first port number in the range of external ports that will be used to provide Inbound Nat to NICs associated with a load balancer. Acceptable values range between 1 and 65534.
   */
  frontendPortRangeStart: int32;

  /**
   * The last port number in the range of external ports that will be used to provide Inbound Nat to NICs associated with a load balancer. Acceptable values range between 1 and 65535.
   */
  frontendPortRangeEnd: int32;

  /**
   * The port used for internal connections on the endpoint. Acceptable values are between 1 and 65535.
   */
  backendPort: int32;

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
   * The provisioning state of the inbound NAT pool resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Outbound rule of the load balancer.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
model OutboundRulePropertiesFormat {
  /**
   * The number of outbound ports to be used for NAT.
   */
  allocatedOutboundPorts?: int32;

  /**
   * The Frontend IP addresses of the load balancer.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  frontendIPConfigurations: SubResource[];

  /**
   * A reference to a pool of DIPs. Outbound traffic is randomly load balanced across IPs in the backend IPs.
   */
  backendAddressPool: SubResource;

  /**
   * The provisioning state of the outbound rule resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The protocol for the outbound rule in load balancer.
   */
  protocol: LoadBalancerOutboundRuleProtocol;

  /**
   * Receive bidirectional TCP Reset on TCP flow idle timeout or unexpected connection termination. This element is only used when the protocol is set to TCP.
   */
  enableTcpReset?: boolean;

  /**
   * The timeout for the TCP idle connection.
   */
  idleTimeoutInMinutes?: int32;
}

/**
 * Properties of the virtual network peering.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VirtualNetworkPeeringPropertiesFormat {
  /**
   * Whether the VMs in the local virtual network space would be able to access the VMs in remote virtual network space.
   */
  allowVirtualNetworkAccess?: boolean;

  /**
   * Whether the forwarded traffic from the VMs in the local virtual network will be allowed/disallowed in remote virtual network.
   */
  allowForwardedTraffic?: boolean;

  /**
   * If gateway links can be used in remote virtual networking to link to this virtual network.
   */
  allowGatewayTransit?: boolean;

  /**
   * If remote gateways can be used on this virtual network. If the flag is set to true, and allowGatewayTransit on remote peering is also true, virtual network will use gateways of remote virtual network for transit. Only one peering can have this flag set to true. This flag cannot be set if virtual network already has a gateway.
   */
  useRemoteGateways?: boolean;

  /**
   * The reference to the remote virtual network. The remote virtual network can be in the same or different region (preview). See here to register for the preview and learn more (https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-create-peering).
   */
  remoteVirtualNetwork?: SubResource;

  /**
   * The local address space of the local virtual network that is peered.
   */
  localAddressSpace?: AddressSpace;

  /**
   * The current local address space of the local virtual network that is peered.
   */
  localVirtualNetworkAddressSpace?: AddressSpace;

  /**
   * The reference to the address space peered with the remote virtual network.
   */
  remoteAddressSpace?: AddressSpace;

  /**
   * The reference to the current address space of the remote virtual network.
   */
  remoteVirtualNetworkAddressSpace?: AddressSpace;

  /**
   * The reference to the remote virtual network's Bgp Communities.
   */
  remoteBgpCommunities?: VirtualNetworkBgpCommunities;

  /**
   * The reference to the remote virtual network's encryption
   */
  @visibility(Lifecycle.Read)
  remoteVirtualNetworkEncryption?: VirtualNetworkEncryption;

  /**
   * The status of the virtual network peering.
   */
  peeringState?: VirtualNetworkPeeringState;

  /**
   * The peering sync status of the virtual network peering.
   */
  peeringSyncLevel?: VirtualNetworkPeeringLevel;

  /**
   * The provisioning state of the virtual network peering resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * If we need to verify the provisioning state of the remote gateway.
   */
  doNotVerifyRemoteGateways?: boolean;

  /**
   * The resourceGuid property of the Virtual Network peering resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * Whether complete virtual network address space is peered.
   */
  peerCompleteVnets?: boolean;

  /**
   * Whether only Ipv6 address space is peered for subnet peering.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableOnlyIPv6Peering?: boolean;

  /**
   * List of local subnet names that are subnet peered with remote virtual network.
   */
  localSubnetNames?: string[];

  /**
   * List of remote subnet names from remote virtual network that are subnet peered.
   */
  remoteSubnetNames?: string[];
}

/**
 * Properties of the PrivateLinkServiceConnection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PrivateLinkServiceConnectionProperties {
  /**
   * The provisioning state of the private link service connection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The resource id of private link service.
   */
  privateLinkServiceId?: string;

  /**
   * The ID(s) of the group(s) obtained from the remote resource that this private endpoint should connect to.
   */
  groupIds?: string[];

  /**
   * A message passed to the owner of the remote resource with this connection request. Restricted to 140 chars.
   */
  requestMessage?: string;

  /**
   * A collection of read-only information about the state of the connection to the remote resource.
   */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;
}

/**
 * An IP Configuration of the private endpoint.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PrivateEndpointIPConfiguration {
  /**
   * Properties of private endpoint IP configurations.
   */
  properties?: PrivateEndpointIPConfigurationProperties;

  /**
   * The name of the resource that is unique within a resource group.
   */
  name?: string;

  /**
   * The resource type.
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
 * Properties of an IP Configuration of the private endpoint.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PrivateEndpointIPConfigurationProperties {
  /**
   * The ID of a group obtained from the remote resource that this private endpoint should connect to.
   */
  groupId?: string;

  /**
   * The member name of a group obtained from the remote resource that this private endpoint should connect to.
   */
  memberName?: string;

  /**
   * A private ip address obtained from the private endpoint's subnet.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateIPAddress?: string;
}

/**
 * The private link service ip configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PrivateLinkServiceIpConfiguration extends SubResource {
  /**
   * Properties of the private link service ip configuration.
   */
  properties?: PrivateLinkServiceIpConfigurationProperties;

  /**
   * The name of private link service ip configuration.
   */
  name?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Properties of private link service IP configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PrivateLinkServiceIpConfigurationProperties {
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
   * Whether the ip configuration is primary or not.
   */
  primary?: boolean;

  /**
   * The provisioning state of the private link service IP configuration resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Whether the specific IP configuration is IPv4 or IPv6. Default is IPv4.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateIPAddressVersion?: IPVersion;
}

/**
 * Route resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model RoutePropertiesFormat {
  /**
   * The destination CIDR to which the route applies.
   */
  addressPrefix?: string;

  /**
   * The type of Azure hop the packet should be sent to.
   */
  nextHopType: RouteNextHopType;

  /**
   * The IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance.
   */
  nextHopIpAddress?: string;

  /**
   * The provisioning state of the route resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * A value indicating whether this route overrides overlapping BGP routes regardless of LPM.
   */
  @visibility(Lifecycle.Read)
  hasBgpOverride?: boolean;
}

/**
 * Service Endpoint policy definition resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ServiceEndpointPolicyDefinitionPropertiesFormat {
  /**
   * A description for this rule. Restricted to 140 chars.
   */
  description?: string;

  /**
   * Service endpoint name.
   */
  service?: string;

  /**
   * A list of service resources.
   */
  serviceResources?: string[];

  /**
   * The provisioning state of the service endpoint policy definition resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * SKU of a load balancer.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
model LoadBalancerSku {
  /**
   * Name of a load balancer SKU.
   */
  name?: LoadBalancerSkuName;

  /**
   * Tier of a load balancer SKU.
   */
  tier?: LoadBalancerSkuTier;
}

/**
 * Properties of the load balancer.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
model LoadBalancerPropertiesFormat {
  /**
   * Object representing the frontend IPs to be used for the load balancer.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  frontendIPConfigurations?: FrontendIPConfiguration[];

  /**
   * Collection of backend address pools used by a load balancer.
   */
  backendAddressPools?: BackendAddressPool[];

  /**
   * Object collection representing the load balancing rules Gets the provisioning.
   */
  loadBalancingRules?: LoadBalancingRule[];

  /**
   * Collection of probe objects used in the load balancer.
   */
  probes?: Probe[];

  /**
   * Collection of inbound NAT Rules used by a load balancer. Defining inbound NAT rules on your load balancer is mutually exclusive with defining an inbound NAT pool. Inbound NAT pools are referenced from virtual machine scale sets. NICs that are associated with individual virtual machines cannot reference an Inbound NAT pool. They have to reference individual inbound NAT rules.
   */
  inboundNatRules?: InboundNatRule[];

  /**
   * Defines an external port range for inbound NAT to a single backend port on NICs associated with a load balancer. Inbound NAT rules are created automatically for each NIC associated with the Load Balancer using an external port from this range. Defining an Inbound NAT pool on your Load Balancer is mutually exclusive with defining inbound NAT rules. Inbound NAT pools are referenced from virtual machine scale sets. NICs that are associated with individual virtual machines cannot reference an inbound NAT pool. They have to reference individual inbound NAT rules.
   */
  inboundNatPools?: InboundNatPool[];

  /**
   * The outbound rules.
   */
  outboundRules?: OutboundRule[];

  /**
   * The resource GUID property of the load balancer resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The provisioning state of the load balancer resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Indicates the scope of the load balancer: external (Public) or internal (Private).
   */
  scope?: LoadBalancerScope;
}

/**
 * The network watcher properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model NetworkWatcherPropertiesFormat {
  /**
   * The provisioning state of the network watcher resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Properties of the virtual network.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VirtualNetworkPropertiesFormat {
  /**
   * The AddressSpace that contains an array of IP address ranges that can be used by subnets.
   */
  addressSpace?: AddressSpace;

  /**
   * The dhcpOptions that contains an array of DNS servers available to VMs deployed in the virtual network.
   */
  dhcpOptions?: DhcpOptions;

  /**
   * The FlowTimeout value (in minutes) for the Virtual Network
   */
  flowTimeoutInMinutes?: int32;

  /**
   * A list of subnets in a Virtual Network.
   */
  subnets?: Subnet[];

  /**
   * A list of peerings in a Virtual Network.
   */
  virtualNetworkPeerings?: VirtualNetworkPeering[];

  /**
   * The resourceGuid property of the Virtual Network resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The provisioning state of the virtual network resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Indicates if DDoS protection is enabled for all the protected resources in the virtual network. It requires a DDoS protection plan associated with the resource.
   */
  enableDdosProtection?: boolean = false;

  /**
   * Indicates if VM protection is enabled for all the subnets in the virtual network.
   */
  enableVmProtection?: boolean = false;

  /**
   * The DDoS protection plan associated with the virtual network.
   */
  ddosProtectionPlan?: SubResource;

  /**
   * Bgp Communities sent over ExpressRoute with each route corresponding to a prefix in this VNET.
   */
  bgpCommunities?: VirtualNetworkBgpCommunities;

  /**
   * Indicates if encryption is enabled on virtual network and if VM without encryption is allowed in encrypted VNet.
   */
  encryption?: VirtualNetworkEncryption;

  /**
   * Array of IpAllocation which reference this VNET.
   */
  ipAllocations?: SubResource[];

  /**
   * A collection of references to flow log resources.
   */
  @visibility(Lifecycle.Read)
  flowLogs?: FlowLog[];

  /**
   * Private Endpoint VNet Policies.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateEndpointVNetPolicies?: PrivateEndpointVNetPolicies;

  /**
   * A reference to the default public nat gateway being used by this virtual network resource.
   */
  @visibility(Lifecycle.Read)
  defaultPublicNatGateway?: SubResource;

  /**
   * A configurable list of summarized gateway prefixes advertised for the virtual network.
   */
  @added(Versions.v2025_07_01)
  summarizedGatewayPrefixes?: AddressSpace;
}

/**
 * AddressSpace contains an array of IP address ranges that can be used by subnets of the virtual network.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model AddressSpace {
  /**
   * A list of address blocks reserved for this virtual network in CIDR notation.
   */
  addressPrefixes?: string[];

  /**
   * A list of IPAM Pools allocating IP address prefixes.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ipamPoolPrefixAllocations?: IpamPoolPrefixAllocation[];
}

/**
 * DhcpOptions contains an array of DNS servers available to VMs deployed in the virtual network. Standard DHCP option for a subnet overrides VNET DHCP options.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model DhcpOptions {
  /**
   * The list of DNS servers IP addresses.
   */
  dnsServers?: string[];
}

/**
 * Bgp Communities sent over ExpressRoute with each route corresponding to a prefix in this VNET.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VirtualNetworkBgpCommunities {
  /**
   * The BGP community associated with the virtual network.
   */
  virtualNetworkCommunity: string;

  /**
   * The BGP community associated with the region of the virtual network.
   */
  @visibility(Lifecycle.Read)
  regionalCommunity?: string;
}

/**
 * Indicates if encryption is enabled on virtual network and if VM without encryption is allowed in encrypted VNet.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VirtualNetworkEncryption {
  /**
   * Indicates if encryption is enabled on the virtual network.
   */
  enabled: boolean;

  /**
   * If the encrypted VNet allows VM that does not support encryption. This field is for future support, AllowUnencrypted is the only supported value at general availability.
   */
  enforcement?: VirtualNetworkEncryptionEnforcement;
}

/**
 * The load distribution policy for this rule.
 */
union LoadDistribution {
  string,

  /**
   * Default
   */
  Default: "Default",

  /**
   * SourceIP
   */
  SourceIP: "SourceIP",

  /**
   * SourceIPProtocol
   */
  SourceIPProtocol: "SourceIPProtocol",
}

/**
 * The protocol of the end point. If 'Tcp' is specified, a received ACK is required for the probe to be successful. If 'Http' or 'Https' is specified, a 200 OK response from the specifies URI is required for the probe to be successful.
 */
union ProbeProtocol {
  string,

  /**
   * Http
   */
  Http: "Http",

  /**
   * Tcp
   */
  Tcp: "Tcp",

  /**
   * Https
   */
  Https: "Https",
}

/**
 * Determines how new connections are handled by the load balancer when all backend instances are probed down.
 */
union ProbeNoHealthyBackendsBehavior {
  string,

  /**
   * No new flows will be sent to the backend pool.
   */
  AllProbedDown: "AllProbedDown",

  /**
   * When all backend instances are probed down, incoming packets will be sent to all instances.
   */
  AllProbedUp: "AllProbedUp",
}

/**
 * The protocol for the outbound rule in load balancer.
 */
union LoadBalancerOutboundRuleProtocol {
  string,

  /**
   * Tcp
   */
  Tcp: "Tcp",

  /**
   * Udp
   */
  Udp: "Udp",

  /**
   * All
   */
  All: "All",
}

/**
 * The status of the virtual network peering.
 */
union VirtualNetworkPeeringState {
  string,

  /**
   * Initiated
   */
  Initiated: "Initiated",

  /**
   * Connected
   */
  Connected: "Connected",

  /**
   * Disconnected
   */
  Disconnected: "Disconnected",
}

/**
 * The peering sync status of the virtual network peering.
 */
union VirtualNetworkPeeringLevel {
  string,

  /**
   * FullyInSync
   */
  FullyInSync: "FullyInSync",

  /**
   * RemoteNotInSync
   */
  RemoteNotInSync: "RemoteNotInSync",

  /**
   * LocalNotInSync
   */
  LocalNotInSync: "LocalNotInSync",

  /**
   * LocalAndRemoteNotInSync
   */
  LocalAndRemoteNotInSync: "LocalAndRemoteNotInSync",
}

@@clientName(Components1Jq1T4ISchemasManagedserviceidentityPropertiesUserassignedidentitiesAdditionalproperties,
  "ManagedServiceIdentityUserAssignedIdentities",
  "!javascript"
);
