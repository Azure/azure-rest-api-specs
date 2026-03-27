import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Compute;

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
 * The current provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ProvisioningState {
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
 * NetworkSecurityGroup resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NetworkSecurityGroup extends Resource {
  /**
   * Properties of the network security group.
   */
  properties?: NetworkSecurityGroupPropertiesFormat;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Network Security Group resource.
 */
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
 * Network security rule.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecurityRule extends SubResource {
  /**
   * Properties of the security rule.
   */
  properties?: SecurityRulePropertiesFormat;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  name?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
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
 * An application security group in a resource group.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ApplicationSecurityGroup extends Resource {
  /**
   * Properties of the application security group.
   */
  properties?: ApplicationSecurityGroupPropertiesFormat;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Application security group properties.
 */
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
 * Common resource representation.
 */
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
 * Subnet in a virtual network resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Subnet extends SubResource {
  /**
   * Properties of the subnet.
   */
  properties?: SubnetPropertiesFormat;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
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
 * Properties of the subnet.
 */
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
 * Route table resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RouteTable extends Resource {
  /**
   * Properties of the route table.
   */
  properties?: RouteTablePropertiesFormat;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Route Table resource.
 */
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
 * Route resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Route extends SubResource {
  /**
   * Properties of the route.
   */
  properties?: RoutePropertiesFormat;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  name?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The type of the resource.
   */
  type?: string;
}

/**
 * Route resource.
 */
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
 * The service endpoint properties.
 */
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
 * Service End point policy resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServiceEndpointPolicy extends Resource {
  /**
   * Properties of the service end point policy.
   */
  properties?: ServiceEndpointPolicyPropertiesFormat;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Kind of service endpoint policy. This is metadata used for the Azure portal experience.
   */
  @visibility(Lifecycle.Read)
  kind?: string;
}

/**
 * Service Endpoint Policy resource.
 */
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
 * Service Endpoint policy definitions.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServiceEndpointPolicyDefinition extends SubResource {
  /**
   * Properties of the service endpoint policy definition.
   */
  properties?: ServiceEndpointPolicyDefinitionPropertiesFormat;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  name?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The type of the resource.
   */
  type?: string;
}

/**
 * Service Endpoint policy definition resource.
 */
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
 * Private endpoint resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateEndpoint extends Resource {
  /**
   * The extended location of the load balancer.
   */
  extendedLocation?: ExtendedLocation;

  /**
   * Properties of the private endpoint.
   */
  properties?: PrivateEndpointProperties;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Properties of the private endpoint.
 */
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
 * PrivateLinkServiceConnection resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * Properties of the PrivateLinkServiceConnection.
 */
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
 * A collection of information about the state of the connection between service consumer and provider.
 */
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
 * Contains custom Dns resolution configuration from customer.
 */
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
 * An IP Configuration of the private endpoint.
 */
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
 * IP configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * Nat Gateway resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NatGateway extends Resource {
  /**
   * The nat gateway SKU.
   */
  sku?: NatGatewaySku;

  /**
   * Nat Gateway properties.
   */
  properties?: NatGatewayPropertiesFormat;

  /**
   * A list of availability zones denoting the zone in which Nat Gateway should be deployed.
   */
  zones?: string[];

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * SKU of nat gateway.
 */
model NatGatewaySku {
  /**
   * Name of Nat Gateway SKU.
   */
  name?: NatGatewaySkuName;
}

/**
 * Nat Gateway properties.
 */
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
 * IP configuration profile child resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
model IpamPoolPrefixAllocationPool {
  /**
   * Resource id of the associated Azure IpamPool resource.
   */
  id?: Azure.Core.armResourceIdentifier;
}

/**
 * A flow log resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FlowLog extends Resource {
  /**
   * Properties of the flow log.
   */
  properties?: FlowLogPropertiesFormat;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * FlowLog resource Managed Identity
   */
  identity?: ManagedServiceIdentity;
}

/**
 * Parameters that define the configuration of flow log.
 */
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
model FlowLogFormatParameters {
  /**
   * The file type of flow log.
   */
  type?: FlowLogFormatType;

  /**
   * The version (revision) of the flow log.
   */
  version?: int32;
}

/**
 * Parameters that define the configuration of traffic analytics.
 */
model TrafficAnalyticsProperties {
  /**
   * Parameters that define the configuration of traffic analytics.
   */
  networkWatcherFlowAnalyticsConfiguration?: TrafficAnalyticsConfigurationProperties;
}

/**
 * Parameters that define the configuration of traffic analytics.
 */
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
  @maxValue(128)
  @minValue(1)
  privateIPAddressPrefixLength?: int32;

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
 * Virtual Network Tap resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VirtualNetworkTap extends Resource {
  /**
   * Virtual Network Tap Properties.
   */
  properties?: VirtualNetworkTapPropertiesFormat;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Virtual Network Tap properties.
 */
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
 * Tap configuration in a Network Interface.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NetworkInterfaceTapConfiguration extends SubResource {
  /**
   * Properties of the Virtual Network Tap configuration.
   */
  properties?: NetworkInterfaceTapConfigurationPropertiesFormat;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  name?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Sub Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Properties of Virtual Network Tap configuration.
 */
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
 * Frontend IP address of the load balancer.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FrontendIPConfiguration extends SubResource {
  /**
   * Properties of the load balancer probe.
   */
  properties?: FrontendIPConfigurationPropertiesFormat;

  /**
   * The name of the resource that is unique within the set of frontend IP configurations used by the load balancer. This name can be used to access the resource.
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

  /**
   * A list of availability zones denoting the IP allocated for the resource needs to come from.
   */
  zones?: string[];
}

/**
 * Properties of Frontend IP Configuration of the load balancer.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
}

/**
 * Backend Address Pool of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * Pool of backend IP addresses.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BackendAddressPool extends SubResource {
  /**
   * Properties of load balancer backend address pool.
   */
  properties?: BackendAddressPoolPropertiesFormat;

  /**
   * The name of the resource that is unique within the set of backend address pools used by the load balancer. This name can be used to access the resource.
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
 * Properties of the backend address pool.
 */
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
 * Inbound NAT rule of the load balancer.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model InboundNatRule extends SubResource {
  /**
   * Properties of load balancer inbound NAT rule.
   */
  properties?: InboundNatRulePropertiesFormat;

  /**
   * The name of the resource that is unique within the set of inbound NAT rules used by the load balancer. This name can be used to access the resource.
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
 * Properties of the inbound NAT rule.
 */
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
 * Private link service resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateLinkService extends Resource {
  /**
   * The extended location of the load balancer.
   */
  extendedLocation?: ExtendedLocation;

  /**
   * Properties of the private link service.
   */
  properties?: PrivateLinkServiceProperties;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Properties of the private link service.
 */
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
 * The private link service ip configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * PrivateEndpointConnection resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateEndpointConnection extends SubResource {
  /**
   * Properties of the private end point connection.
   */
  properties?: PrivateEndpointConnectionProperties;

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
 * Properties of the PrivateEndpointConnectProperties.
 */
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
 * The visibility list of the private link service.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateLinkServicePropertiesVisibility extends ResourceSet {}

/**
 * The base resource set for visibility and auto-approval.
 */
model ResourceSet {
  /**
   * The list of subscriptions.
   */
  subscriptions?: string[];
}

/**
 * The auto-approval list of the private link service.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateLinkServicePropertiesAutoApproval extends ResourceSet {}

/**
 * An error response from the service.
 */
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
