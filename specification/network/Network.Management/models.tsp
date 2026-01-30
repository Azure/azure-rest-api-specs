import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Network;

/**
 * Name of an application gateway SKU.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewaySkuName {
  string,

  /**
   * Standard_Small
   */
  Standard_Small: "Standard_Small",

  /**
   * Standard_Medium
   */
  Standard_Medium: "Standard_Medium",

  /**
   * Standard_Large
   */
  Standard_Large: "Standard_Large",

  /**
   * WAF_Medium
   */
  WAF_Medium: "WAF_Medium",

  /**
   * WAF_Large
   */
  WAF_Large: "WAF_Large",

  /**
   * Standard_v2
   */
  Standard_v2: "Standard_v2",

  /**
   * WAF_v2
   */
  WAF_v2: "WAF_v2",

  /**
   * Basic
   */
  Basic: "Basic",
}

/**
 * Tier of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewayTier {
  string,

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * WAF
   */
  WAF: "WAF",

  /**
   * Standard_v2
   */
  Standard_v2: "Standard_v2",

  /**
   * WAF_v2
   */
  WAF_v2: "WAF_v2",

  /**
   * Basic
   */
  Basic: "Basic",
}

/**
 * Family of an application gateway SKU.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewaySkuFamily {
  string,

  /**
   * Generation_1
   */
  Generation_1: "Generation_1",

  /**
   * Generation_2
   */
  Generation_2: "Generation_2",
}

/**
 * Ssl protocol enums.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewaySslProtocol {
  string,

  /**
   * TLSv1_0
   */
  TLSv1_0: "TLSv1_0",

  /**
   * TLSv1_1
   */
  TLSv1_1: "TLSv1_1",

  /**
   * TLSv1_2
   */
  TLSv1_2: "TLSv1_2",

  /**
   * TLSv1_3
   */
  TLSv1_3: "TLSv1_3",
}

/**
 * Type of Ssl Policy.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewaySslPolicyType {
  string,

  /**
   * Predefined
   */
  Predefined: "Predefined",

  /**
   * Custom
   */
  Custom: "Custom",

  /**
   * CustomV2
   */
  CustomV2: "CustomV2",
}

/**
 * Ssl predefined policy name enums.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewaySslPolicyName {
  string,

  /**
   * AppGwSslPolicy20150501
   */
  AppGwSslPolicy20150501: "AppGwSslPolicy20150501",

  /**
   * AppGwSslPolicy20170401
   */
  AppGwSslPolicy20170401: "AppGwSslPolicy20170401",

  /**
   * AppGwSslPolicy20170401S
   */
  AppGwSslPolicy20170401S: "AppGwSslPolicy20170401S",

  /**
   * AppGwSslPolicy20220101
   */
  AppGwSslPolicy20220101: "AppGwSslPolicy20220101",

  /**
   * AppGwSslPolicy20220101S
   */
  AppGwSslPolicy20220101S: "AppGwSslPolicy20220101S",
}

/**
 * Ssl cipher suites enums.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewaySslCipherSuite {
  string,

  /**
   * TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
   */
  TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384: "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384",

  /**
   * TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256
   */
  TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256: "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256",

  /**
   * TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA
   */
  TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA: "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA",

  /**
   * TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA
   */
  TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA: "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA",

  /**
   * TLS_DHE_RSA_WITH_AES_256_GCM_SHA384
   */
  TLS_DHE_RSA_WITH_AES_256_GCM_SHA384: "TLS_DHE_RSA_WITH_AES_256_GCM_SHA384",

  /**
   * TLS_DHE_RSA_WITH_AES_128_GCM_SHA256
   */
  TLS_DHE_RSA_WITH_AES_128_GCM_SHA256: "TLS_DHE_RSA_WITH_AES_128_GCM_SHA256",

  /**
   * TLS_DHE_RSA_WITH_AES_256_CBC_SHA
   */
  TLS_DHE_RSA_WITH_AES_256_CBC_SHA: "TLS_DHE_RSA_WITH_AES_256_CBC_SHA",

  /**
   * TLS_DHE_RSA_WITH_AES_128_CBC_SHA
   */
  TLS_DHE_RSA_WITH_AES_128_CBC_SHA: "TLS_DHE_RSA_WITH_AES_128_CBC_SHA",

  /**
   * TLS_RSA_WITH_AES_256_GCM_SHA384
   */
  TLS_RSA_WITH_AES_256_GCM_SHA384: "TLS_RSA_WITH_AES_256_GCM_SHA384",

  /**
   * TLS_RSA_WITH_AES_128_GCM_SHA256
   */
  TLS_RSA_WITH_AES_128_GCM_SHA256: "TLS_RSA_WITH_AES_128_GCM_SHA256",

  /**
   * TLS_RSA_WITH_AES_256_CBC_SHA256
   */
  TLS_RSA_WITH_AES_256_CBC_SHA256: "TLS_RSA_WITH_AES_256_CBC_SHA256",

  /**
   * TLS_RSA_WITH_AES_128_CBC_SHA256
   */
  TLS_RSA_WITH_AES_128_CBC_SHA256: "TLS_RSA_WITH_AES_128_CBC_SHA256",

  /**
   * TLS_RSA_WITH_AES_256_CBC_SHA
   */
  TLS_RSA_WITH_AES_256_CBC_SHA: "TLS_RSA_WITH_AES_256_CBC_SHA",

  /**
   * TLS_RSA_WITH_AES_128_CBC_SHA
   */
  TLS_RSA_WITH_AES_128_CBC_SHA: "TLS_RSA_WITH_AES_128_CBC_SHA",

  /**
   * TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
   */
  TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384: "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384",

  /**
   * TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
   */
  TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256: "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256",

  /**
   * TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384
   */
  TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384: "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384",

  /**
   * TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256
   */
  TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256: "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256",

  /**
   * TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA
   */
  TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA: "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA",

  /**
   * TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
   */
  TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA: "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA",

  /**
   * TLS_DHE_DSS_WITH_AES_256_CBC_SHA256
   */
  TLS_DHE_DSS_WITH_AES_256_CBC_SHA256: "TLS_DHE_DSS_WITH_AES_256_CBC_SHA256",

  /**
   * TLS_DHE_DSS_WITH_AES_128_CBC_SHA256
   */
  TLS_DHE_DSS_WITH_AES_128_CBC_SHA256: "TLS_DHE_DSS_WITH_AES_128_CBC_SHA256",

  /**
   * TLS_DHE_DSS_WITH_AES_256_CBC_SHA
   */
  TLS_DHE_DSS_WITH_AES_256_CBC_SHA: "TLS_DHE_DSS_WITH_AES_256_CBC_SHA",

  /**
   * TLS_DHE_DSS_WITH_AES_128_CBC_SHA
   */
  TLS_DHE_DSS_WITH_AES_128_CBC_SHA: "TLS_DHE_DSS_WITH_AES_128_CBC_SHA",

  /**
   * TLS_RSA_WITH_3DES_EDE_CBC_SHA
   */
  TLS_RSA_WITH_3DES_EDE_CBC_SHA: "TLS_RSA_WITH_3DES_EDE_CBC_SHA",

  /**
   * TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA
   */
  TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA: "TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA",

  /**
   * TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
   */
  TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256: "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",

  /**
   * TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
   */
  TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384: "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
}

/**
 * Operational state of the application gateway resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewayOperationalState {
  string,

  /**
   * Stopped
   */
  Stopped: "Stopped",

  /**
   * Starting
   */
  Starting: "Starting",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Stopping
   */
  Stopping: "Stopping",
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
 * Application Gateway protocol.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewayProtocol {
  string,

  /**
   * Supported for httpListeners and  backendHttpSettingsCollection properties.
   */
  Http: "Http",

  /**
   * Supported for httpListeners and  backendHttpSettingsCollection properties.
   */
  Https: "Https",

  /**
   * Supported for listeners and backendSettingsCollection properties.
   */
  Tcp: "Tcp",

  /**
   * Supported for listeners and backendSettingsCollection properties.
   */
  Tls: "Tls",
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
 * Cookie based affinity.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewayCookieBasedAffinity {
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
 * Status code of the application gateway custom error.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewayCustomErrorStatusCode {
  string,

  /**
   * HttpStatus400
   */
  HttpStatus400: "HttpStatus400",

  /**
   * HttpStatus403
   */
  HttpStatus403: "HttpStatus403",

  /**
   * HttpStatus404
   */
  HttpStatus404: "HttpStatus404",

  /**
   * HttpStatus405
   */
  HttpStatus405: "HttpStatus405",

  /**
   * HttpStatus408
   */
  HttpStatus408: "HttpStatus408",

  /**
   * HttpStatus500
   */
  HttpStatus500: "HttpStatus500",

  /**
   * HttpStatus502
   */
  HttpStatus502: "HttpStatus502",

  /**
   * HttpStatus503
   */
  HttpStatus503: "HttpStatus503",

  /**
   * HttpStatus504
   */
  HttpStatus504: "HttpStatus504",
}

/**
 * Verify client certificate revocation status.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewayClientRevocationOptions {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * OCSP
   */
  OCSP: "OCSP",
}

/**
 * Verify client Authentication mode.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewayClientAuthVerificationModes {
  string,

  /**
   * Strict
   */
  Strict: "Strict",

  /**
   * Passthrough
   */
  Passthrough: "Passthrough",
}

/**
 * Rule type.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewayRequestRoutingRuleType {
  string,

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * PathBasedRouting
   */
  PathBasedRouting: "PathBasedRouting",
}

/**
 * Redirect type enum.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewayRedirectType {
  string,

  /**
   * Permanent
   */
  Permanent: "Permanent",

  /**
   * Found
   */
  Found: "Found",

  /**
   * SeeOther
   */
  SeeOther: "SeeOther",

  /**
   * Temporary
   */
  Temporary: "Temporary",
}

/**
 * Web application firewall mode.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewayFirewallMode {
  string,

  /**
   * Detection
   */
  Detection: "Detection",

  /**
   * Prevention
   */
  Prevention: "Prevention",
}

/**
 * Load Distribution Algorithm enums.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewayLoadDistributionAlgorithm {
  string,

  /**
   * RoundRobin
   */
  RoundRobin: "RoundRobin",

  /**
   * LeastConnections
   */
  LeastConnections: "LeastConnections",

  /**
   * IpHash
   */
  IpHash: "IpHash",
}

/**
 * Unauthorized request action.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewayUnAuthorizedRequestAction {
  string,

  /**
   * Deny
   */
  Deny: "Deny",

  /**
   * Allow
   */
  Allow: "Allow",
}

/**
 * Health of backend server.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewayBackendHealthServerHealth {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Up
   */
  Up: "Up",

  /**
   * Down
   */
  Down: "Down",

  /**
   * Partial
   */
  Partial: "Partial",

  /**
   * Draining
   */
  Draining: "Draining",
}

/**
 * The string representation of the web application firewall rule state.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewayWafRuleStateTypes {
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
 * The string representation of the web application firewall rule action.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewayWafRuleActionTypes {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * AnomalyScoring
   */
  AnomalyScoring: "AnomalyScoring",

  /**
   * Allow
   */
  Allow: "Allow",

  /**
   * Block
   */
  Block: "Block",

  /**
   * Log
   */
  Log: "Log",
}

/**
 * The string representation of the web application firewall rule sensitivity.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewayWafRuleSensitivityTypes {
  string,

  /**
   * Low
   */
  Low: "Low",

  /**
   * Medium
   */
  Medium: "Medium",

  /**
   * High
   */
  High: "High",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewayTierTypes {
  string,

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * WAF
   */
  WAF: "WAF",

  /**
   * Standard_v2
   */
  Standard_v2: "Standard_v2",

  /**
   * WAF_v2
   */
  WAF_v2: "WAF_v2",
}

/**
 * The rule set status
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewayRuleSetStatusOptions {
  string,

  /**
   * Preview
   */
  Preview: "Preview",

  /**
   * GA
   */
  GA: "GA",

  /**
   * Supported
   */
  Supported: "Supported",

  /**
   * Deprecated
   */
  Deprecated: "Deprecated",
}

/**
 * The action type of a rule collection.
 */
union AzureFirewallRCActionType {
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
 * The protocol type of a Application Rule resource.
 */
union AzureFirewallApplicationRuleProtocolType {
  string,

  /**
   * Http
   */
  Http: "Http",

  /**
   * Https
   */
  Https: "Https",

  /**
   * Mssql
   */
  Mssql: "Mssql",
}

/**
 * The action type of a NAT rule collection.
 */
union AzureFirewallNatRCActionType {
  string,

  /**
   * Snat
   */
  Snat: "Snat",

  /**
   * Dnat
   */
  Dnat: "Dnat",
}

/**
 * The protocol of a Network Rule resource.
 */
union AzureFirewallNetworkRuleProtocol {
  string,

  /**
   * TCP
   */
  TCP: "TCP",

  /**
   * UDP
   */
  UDP: "UDP",

  /**
   * Any
   */
  Any: "Any",

  /**
   * ICMP
   */
  ICMP: "ICMP",
}

/**
 * The operation mode for Threat Intel.
 */
union AzureFirewallThreatIntelMode {
  string,

  /**
   * Alert
   */
  Alert: "Alert",

  /**
   * Deny
   */
  Deny: "Deny",

  /**
   * Off
   */
  Off: "Off",
}

/**
 * Name of an Azure Firewall SKU.
 */
union AzureFirewallSkuName {
  string,

  /**
   * AZFW_VNet
   */
  AZFW_VNet: "AZFW_VNet",

  /**
   * AZFW_Hub
   */
  AZFW_Hub: "AZFW_Hub",
}

/**
 * Tier of an Azure Firewall.
 */
union AzureFirewallSkuTier {
  string,

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * Premium
   */
  Premium: "Premium",

  /**
   * Basic
   */
  Basic: "Basic",
}

/**
 * The flags type to be captured.
 */
union AzureFirewallPacketCaptureFlagsType {
  string,

  /**
   * fin
   */
  fin: "fin",

  /**
   * syn
   */
  syn: "syn",

  /**
   * rst
   */
  rst: "rst",

  /**
   * push
   */
  push: "push",

  /**
   * ack
   */
  ack: "ack",

  /**
   * urg
   */
  urg: "urg",
}

/**
 * The packet capture operation to perform. If the Start operation is selected, please provide all the fields in the firewallPacketCaptureParameters to successfully initiate the packet capture. If the Status or Stop operation is selected, only the operation field is required; all other fields in the firewallPacketCaptureParameters can be omitted to successfully retrieve the capture status or stop the capture.
 */
union AzureFirewallPacketCaptureOperationType {
  string,

  /**
   * Start
   */
  Start: "Start",

  /**
   * Status
   */
  Status: "Status",

  /**
   * Stop
   */
  Stop: "Stop",
}

/**
 * The packet capture operation response codes.
 */
union AzureFirewallPacketCaptureResponseCode {
  string,

  /**
   * NotImplemented
   */
  NotImplemented: "NotImplemented",

  /**
   * AzureFirewallPacketCaptureStartSucceeded
   */
  AzureFirewallPacketCaptureStartSucceeded: "AzureFirewallPacketCaptureStartSucceeded",

  /**
   * AzureFirewallPacketCaptureStartFailed
   */
  AzureFirewallPacketCaptureStartFailed: "AzureFirewallPacketCaptureStartFailed",

  /**
   * AzureFirewallPacketCaptureStartFailedToUpload
   */
  AzureFirewallPacketCaptureStartFailedToUpload: "AzureFirewallPacketCaptureStartFailedToUpload",

  /**
   * AzureFirewallPacketCaptureStartFailure
   */
  AzureFirewallPacketCaptureStartFailure: "AzureFirewallPacketCaptureStartFailure",

  /**
   * AzureFirewallPacketCaptureInProgress
   */
  AzureFirewallPacketCaptureInProgress: "AzureFirewallPacketCaptureInProgress",

  /**
   * AzureFirewallPacketCaptureNotInProgress
   */
  AzureFirewallPacketCaptureNotInProgress: "AzureFirewallPacketCaptureNotInProgress",

  /**
   * AzureFirewallPacketCaptureStopSucceeded
   */
  AzureFirewallPacketCaptureStopSucceeded: "AzureFirewallPacketCaptureStopSucceeded",

  /**
   * AzureFirewallPacketCaptureFailed
   */
  AzureFirewallPacketCaptureFailed: "AzureFirewallPacketCaptureFailed",

  /**
   * AzureFirewallPacketCaptureCompleted
   */
  AzureFirewallPacketCaptureCompleted: "AzureFirewallPacketCaptureCompleted",
}

/**
 * The name of the sku of this Bastion Host.
 */
union BastionHostSkuName {
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
   * Developer
   */
  Developer: "Developer",

  /**
   * Premium
   */
  Premium: "Premium",
}

/**
 * The protocol used to connect to the target.
 */
union BastionConnectProtocol {
  string,

  /**
   * SSH
   */
  SSH: "SSH",

  /**
   * RDP
   */
  RDP: "RDP",
}

/**
 * The commissioned state of the Custom IP Prefix.
 */
union CommissionedState {
  string,

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Provisioned
   */
  Provisioned: "Provisioned",

  /**
   * Commissioning
   */
  Commissioning: "Commissioning",

  /**
   * CommissionedNoInternetAdvertise
   */
  CommissionedNoInternetAdvertise: "CommissionedNoInternetAdvertise",

  /**
   * Commissioned
   */
  Commissioned: "Commissioned",

  /**
   * Decommissioning
   */
  Decommissioning: "Decommissioning",

  /**
   * Deprovisioning
   */
  Deprovisioning: "Deprovisioning",

  /**
   * Deprovisioned
   */
  Deprovisioned: "Deprovisioned",
}

/**
 * The Geo for CIDR advertising. Should be an Geo code.
 */
union Geo {
  string,

  /**
   * GLOBAL
   */
  GLOBAL: "GLOBAL",

  /**
   * AFRI
   */
  AFRI: "AFRI",

  /**
   * APAC
   */
  APAC: "APAC",

  /**
   * EURO
   */
  EURO: "EURO",

  /**
   * LATAM
   */
  LATAM: "LATAM",

  /**
   * NAM
   */
  NAM: "NAM",

  /**
   * ME
   */
  ME: "ME",

  /**
   * OCEANIA
   */
  OCEANIA: "OCEANIA",

  /**
   * AQ
   */
  AQ: "AQ",
}

/**
 * Type of custom IP prefix. Should be Singular, Parent, or Child.
 */
union CustomIpPrefixType {
  string,

  /**
   * Singular
   */
  Singular: "Singular",

  /**
   * Parent
   */
  Parent: "Parent",

  /**
   * Child
   */
  Child: "Child",
}

/**
 * The detection mode for the DDoS detection rule.
 */
union DdosDetectionMode {
  string,

  /**
   * TrafficThreshold
   */
  TrafficThreshold: "TrafficThreshold",
}

/**
 * The traffic type (one of Tcp, Udp, TcpSyn) that the detection rule will be applied upon.
 */
union DdosTrafficType {
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
   * TcpSyn
   */
  TcpSyn: "TcpSyn",
}

/**
 * RNM supported protocol types.
 */
union ProtocolType {
  string,

  /**
   * DoNotUse
   */
  DoNotUse: "DoNotUse",

  /**
   * Icmp
   */
  Icmp: "Icmp",

  /**
   * Tcp
   */
  Tcp: "Tcp",

  /**
   * Udp
   */
  Udp: "Udp",

  /**
   * Gre
   */
  Gre: "Gre",

  /**
   * Esp
   */
  Esp: "Esp",

  /**
   * Ah
   */
  Ah: "Ah",

  /**
   * Vxlan
   */
  Vxlan: "Vxlan",

  /**
   * All
   */
  All: "All",
}

/**
 * The authorization use status.
 */
union AuthorizationUseStatus {
  string,

  /**
   * Available
   */
  Available: "Available",

  /**
   * InUse
   */
  InUse: "InUse",
}

/**
 * The peering type.
 */
union ExpressRoutePeeringType {
  string,

  /**
   * AzurePublicPeering
   */
  AzurePublicPeering: "AzurePublicPeering",

  /**
   * AzurePrivatePeering
   */
  AzurePrivatePeering: "AzurePrivatePeering",

  /**
   * MicrosoftPeering
   */
  MicrosoftPeering: "MicrosoftPeering",
}

/**
 * The state of peering.
 */
union ExpressRoutePeeringState {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * The advertised public prefix state of the Peering resource.
 */
union ExpressRouteCircuitPeeringAdvertisedPublicPrefixState {
  string,

  /**
   * NotConfigured
   */
  NotConfigured: "NotConfigured",

  /**
   * Configuring
   */
  Configuring: "Configuring",

  /**
   * Configured
   */
  Configured: "Configured",

  /**
   * ValidationNeeded
   */
  ValidationNeeded: "ValidationNeeded",
}

/**
 * Advertised Public Prefix State that denotes if the prefix is validated or not.
 */
union AdvertisedPublicPrefixPropertiesValidationState {
  string,

  /**
   * NotConfigured
   */
  NotConfigured: "NotConfigured",

  /**
   * Configuring
   */
  Configuring: "Configuring",

  /**
   * Configured
   */
  Configured: "Configured",

  /**
   * ValidationNeeded
   */
  ValidationNeeded: "ValidationNeeded",

  /**
   * ValidationFailed
   */
  ValidationFailed: "ValidationFailed",

  /**
   * ManualValidationNeeded
   */
  ManualValidationNeeded: "ManualValidationNeeded",

  /**
   * AsnValidationFailed
   */
  AsnValidationFailed: "AsnValidationFailed",

  /**
   * CertificateMissingInRoutingRegistry
   */
  CertificateMissingInRoutingRegistry: "CertificateMissingInRoutingRegistry",

  /**
   * InvalidSignatureEncoding
   */
  InvalidSignatureEncoding: "InvalidSignatureEncoding",

  /**
   * SignatureVerificationFailed
   */
  SignatureVerificationFailed: "SignatureVerificationFailed",
}

/**
 * The state of peering.
 */
union ExpressRouteCircuitPeeringState {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * Express Route Circuit connection state.
 */
union CircuitConnectionStatus {
  string,

  /**
   * Connected
   */
  Connected: "Connected",

  /**
   * Connecting
   */
  Connecting: "Connecting",

  /**
   * Disconnected
   */
  Disconnected: "Disconnected",
}

/**
 * The tier of the SKU.
 */
union ExpressRouteCircuitSkuTier {
  string,

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * Premium
   */
  Premium: "Premium",

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * Local
   */
  Local: "Local",
}

/**
 * The family of the SKU.
 */
union ExpressRouteCircuitSkuFamily {
  string,

  /**
   * UnlimitedData
   */
  UnlimitedData: "UnlimitedData",

  /**
   * MeteredData
   */
  MeteredData: "MeteredData",
}

/**
 * The ServiceProviderProvisioningState state of the resource.
 */
union ServiceProviderProvisioningState {
  string,

  /**
   * NotProvisioned
   */
  NotProvisioned: "NotProvisioned",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Provisioned
   */
  Provisioned: "Provisioned",

  /**
   * Deprovisioning
   */
  Deprovisioning: "Deprovisioning",
}

/**
 * Encapsulation method on physical ports.
 */
union ExpressRoutePortsEncapsulation {
  string,

  /**
   * Dot1Q
   */
  Dot1Q: "Dot1Q",

  /**
   * QinQ
   */
  QinQ: "QinQ",
}

/**
 * Physical fiber port type.
 */
union ExpressRouteLinkConnectorType {
  string,

  /**
   * LC
   */
  LC: "LC",

  /**
   * SC
   */
  SC: "SC",
}

/**
 * Administrative state of the physical port.
 */
union ExpressRouteLinkAdminState {
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
 * Mac security cipher.
 */
union ExpressRouteLinkMacSecCipher {
  string,

  /**
   * GcmAes256
   */
  GcmAes256: "GcmAes256",

  /**
   * GcmAes128
   */
  GcmAes128: "GcmAes128",

  /**
   * GcmAesXpn128
   */
  GcmAesXpn128: "GcmAesXpn128",

  /**
   * GcmAesXpn256
   */
  GcmAesXpn256: "GcmAesXpn256",
}

/**
 * Sci mode enabled/disabled.
 */
union ExpressRouteLinkMacSecSciState {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * The billing type of the ExpressRoutePort resource.
 */
union ExpressRoutePortsBillingType {
  string,

  /**
   * MeteredData
   */
  MeteredData: "MeteredData",

  /**
   * UnlimitedData
   */
  UnlimitedData: "UnlimitedData",
}

/**
 * The authorization use status.
 */
union ExpressRoutePortAuthorizationUseStatus {
  string,

  /**
   * Available
   */
  Available: "Available",

  /**
   * InUse
   */
  InUse: "InUse",
}

/**
 * The operation mode for automatically learning private ranges to not be SNAT
 */
union AutoLearnPrivateRangesMode {
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
 * Possible state values.
 */
union FirewallPolicyIntrusionDetectionStateType {
  string,

  /**
   * Off
   */
  Off: "Off",

  /**
   * Alert
   */
  Alert: "Alert",

  /**
   * Deny
   */
  Deny: "Deny",
}

/**
 * Possible Intrusion Detection profile values.
 */
union FirewallPolicyIntrusionDetectionProfileType {
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
   * Advanced
   */
  Advanced: "Advanced",

  /**
   * Extended
   */
  Extended: "Extended",
}

/**
 * Possible intrusion detection bypass traffic protocols.
 */
union FirewallPolicyIntrusionDetectionProtocol {
  string,

  /**
   * TCP
   */
  TCP: "TCP",

  /**
   * UDP
   */
  UDP: "UDP",

  /**
   * ICMP
   */
  ICMP: "ICMP",

  /**
   * ANY
   */
  ANY: "ANY",
}

/**
 * Tier of Firewall Policy.
 */
union FirewallPolicySkuTier {
  string,

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * Premium
   */
  Premium: "Premium",

  /**
   * Basic
   */
  Basic: "Basic",
}

/**
 * The type of the rule collection.
 */
union FirewallPolicyRuleCollectionType {
  string,

  /**
   * FirewallPolicyNatRuleCollection
   */
  FirewallPolicyNatRuleCollection: "FirewallPolicyNatRuleCollection",

  /**
   * FirewallPolicyFilterRuleCollection
   */
  FirewallPolicyFilterRuleCollection: "FirewallPolicyFilterRuleCollection",
}

/**
 * Describes if results should be in ascending/descending order
 */
union FirewallPolicyIdpsQuerySortOrder {
  string,

  /**
   * Ascending
   */
  Ascending: "Ascending",

  /**
   * Descending
   */
  Descending: "Descending",
}

/**
 * Enumeration to indicate the IP type.
 */
union IpType {
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
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * IpAllocation type.
 */
union IpAllocationType {
  string,

  /**
   * Undefined
   */
  Undefined: "Undefined",

  /**
   * Hypernet
   */
  Hypernet: "Hypernet",
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
 * Who created the route.
 */
union EffectiveRouteSource {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * User
   */
  User: "User",

  /**
   * VirtualNetworkGateway
   */
  VirtualNetworkGateway: "VirtualNetworkGateway",

  /**
   * Default
   */
  Default: "Default",
}

/**
 * The value of effective route.
 */
union EffectiveRouteState {
  string,

  /**
   * Active
   */
  Active: "Active",

  /**
   * Invalid
   */
  Invalid: "Invalid",
}

/**
 * The network protocol this rule applies to.
 */
union EffectiveSecurityRuleProtocol {
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
 * Configuration Deployment Type.
 */
union ConfigurationType {
  string,

  /**
   * SecurityAdmin
   */
  SecurityAdmin: "SecurityAdmin",

  /**
   * Connectivity
   */
  Connectivity: "Connectivity",

  /**
   * SecurityUser
   */
  SecurityUser: "SecurityUser",

  /**
   * Routing
   */
  Routing: "Routing",
}

/**
 * Deployment Status.
 */
union DeploymentStatus {
  string,

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * Deploying
   */
  Deploying: "Deploying",

  /**
   * Deployed
   */
  Deployed: "Deployed",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * Connectivity topology type.
 */
union ConnectivityTopology {
  string,

  /**
   * HubAndSpoke
   */
  HubAndSpoke: "HubAndSpoke",

  /**
   * Mesh
   */
  Mesh: "Mesh",
}

/**
 * Flag if global mesh is supported.
 */
union IsGlobal {
  string,

  /**
   * False
   */
  False: "False",

  /**
   * True
   */
  True: "True",
}

/**
 * Option indicating the scale of private endpoints allowed in the connected group of the connectivity configuration.
 */
union ConnectedGroupPrivateEndpointsScale {
  string,

  /**
   * Default. Allows for up to 2K private endpoints in the connected group.
   */
  Standard: "Standard",

  /**
   * Allows for up to 20K private endpoints in the connected group.
   */
  HighScale: "HighScale",
}

/**
 * Behavior to handle overlapped IP address space among members of the connected group of the connectivity configuration.
 */
union ConnectedGroupAddressOverlap {
  string,

  /**
   * Default. Allows connected group members to have overlapping IP address space.
   */
  Allowed: "Allowed",

  /**
   * Strictly disallows connected group members from having overlapping IP address space. Prevents the addition of a virtual network with overlapping address to the connected group, blocks peering between a virtual network and a connected group member if any connected group member has an overlapping range, and restricts address space modifications that would introduce overlap.
   */
  Disallowed: "Disallowed",
}

/**
 * Option indicating enforcement of peerings created by the connectivity configuration.
 */
union PeeringEnforcement {
  string,

  /**
   * Default. Peerings created by the connectivity configuration may be modified or deleted outside of the network manager.
   */
  Unenforced: "Unenforced",

  /**
   * Peerings created by the connectivity configuration will not be modifiable or deletable outside of the network manager.
   */
  Enforced: "Enforced",
}

/**
 * Flag if need to use hub gateway.
 */
union UseHubGateway {
  string,

  /**
   * False
   */
  False: "False",

  /**
   * True
   */
  True: "True",
}

/**
 * Group connectivity type.
 */
union GroupConnectivity {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * DirectlyConnected
   */
  DirectlyConnected: "DirectlyConnected",
}

/**
 * Flag if need to remove current existing peerings.
 */
union DeleteExistingPeering {
  string,

  /**
   * False
   */
  False: "False",

  /**
   * True
   */
  True: "True",
}

/**
 * Network Group member type
 */
union GroupMemberType {
  string,

  /**
   * VirtualNetwork
   */
  VirtualNetwork: "VirtualNetwork",

  /**
   * Subnet
   */
  Subnet: "Subnet",
}

/**
 * Whether the rule is custom or default.
 */
union EffectiveAdminRuleKind {
  string,

  /**
   * Custom
   */
  Custom: "Custom",

  /**
   * Default
   */
  Default: "Default",
}

/**
 * The current scope connection state.
 */
union ScopeConnectionState {
  string,

  /**
   * Connected
   */
  Connected: "Connected",

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Conflict
   */
  Conflict: "Conflict",

  /**
   * Revoked
   */
  Revoked: "Revoked",

  /**
   * Rejected
   */
  Rejected: "Rejected",
}

/**
 * Route table usage mode defines which route table will be used by the configuration. If not defined, this will default to 'ManagedOnly'.
 */
union RouteTableUsageMode {
  string,

  /**
   * Only route tables managed by the routing configuration will be used.
   */
  ManagedOnly: "ManagedOnly",

  /**
   * Use existing user-defined route tables already associated with resources.
   */
  UseExisting: "UseExisting",
}

/**
 * Determines whether BGP route propagation is enabled. Defaults to true.
 */
union DisableBgpRoutePropagation {
  string,

  /**
   * BGP route propagation is enabled.
   */
  False: "False",

  /**
   * BGP route propagation is disabled.
   */
  True: "True",
}

/**
 * Routing rule destination type.
 */
union RoutingRuleDestinationType {
  string,

  /**
   * Destination specified as an IP address prefix (CIDR).
   */
  AddressPrefix: "AddressPrefix",

  /**
   * Destination specified as an Azure service tag.
   */
  ServiceTag: "ServiceTag",
}

/**
 * Routing rule next hop type.
 */
union RoutingRuleNextHopType {
  string,

  /**
   * Forward traffic to the Internet.
   */
  Internet: "Internet",

  /**
   * No next hop will be used.
   */
  NoNextHop: "NoNextHop",

  /**
   * Forward traffic to a specified virtual appliance IP address.
   */
  VirtualAppliance: "VirtualAppliance",

  /**
   * Forward traffic to the virtual network gateway.
   */
  VirtualNetworkGateway: "VirtualNetworkGateway",

  /**
   * Keep traffic within the local virtual network
   */
  VnetLocal: "VnetLocal",
}

/**
 * Network intent policy based services.
 */
union NetworkIntentPolicyBasedService {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * All
   */
  All: "All",

  /**
   * AllowRulesOnly
   */
  AllowRulesOnly: "AllowRulesOnly",
}

/**
 * Option indicating the update behavior of a resource's address prefixes referenced within a network manager configuration.
 */
union AddressSpaceAggregationOption {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Manual
   */
  Manual: "Manual",
}

/**
 * Whether the rule is custom or default.
 */
union AdminRuleKind {
  string,

  /**
   * Custom
   */
  Custom: "Custom",

  /**
   * Default
   */
  Default: "Default",
}

/**
 * Network protocol this rule applies to.
 */
union SecurityConfigurationRuleProtocol {
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
   * Any
   */
  Any: "Any",

  /**
   * Ah
   */
  Ah: "Ah",
}

/**
 * Address prefix type.
 */
union AddressPrefixType {
  string,

  /**
   * IPPrefix
   */
  IPPrefix: "IPPrefix",

  /**
   * ServiceTag
   */
  ServiceTag: "ServiceTag",

  /**
   * NetworkGroup
   */
  NetworkGroup: "NetworkGroup",
}

/**
 * The direction of the rule. The direction specifies if the rule will be evaluated on incoming or outgoing traffic.
 */
union SecurityConfigurationRuleDirection {
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
 * The current provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union NspProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

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

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * Direction that specifies whether the access rules is inbound/outbound.
 */
union AccessRuleDirection {
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
 * Access mode on the association.
 */
union AssociationAccessMode {
  string,

  /**
   * Learning
   */
  Learning: "Learning",

  /**
   * Enforced
   */
  Enforced: "Enforced",

  /**
   * Audit
   */
  Audit: "Audit",
}

/**
 * The current provisioning state of NSP Link/LinkReference.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union NspLinkProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

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

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * WaitForRemoteCompletion
   */
  WaitForRemoteCompletion: "WaitForRemoteCompletion",
}

/**
 * The NSP link state.
 */
union NspLinkStatus {
  string,

  /**
   * Approved
   */
  Approved: "Approved",

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Rejected
   */
  Rejected: "Rejected",

  /**
   * Disconnected
   */
  Disconnected: "Disconnected",
}

/**
 * Network Protocol.
 */
union NetworkProtocol {
  string,

  /**
   * Any
   */
  Any: "Any",

  /**
   * TCP
   */
  TCP: "TCP",

  /**
   * UDP
   */
  UDP: "UDP",

  /**
   * ICMP
   */
  ICMP: "ICMP",
}

/**
 * NIC type - PublicNic, PrivateNic, or AdditionalNic; AdditionalPrivateNic and AdditionalPublicNic are only supported for NVAs deployed in VNets.
 */
union NicTypeInResponse {
  string,

  /**
   * PublicNic
   */
  PublicNic: "PublicNic",

  /**
   * PrivateNic
   */
  PrivateNic: "PrivateNic",

  /**
   * AdditionalNic
   */
  AdditionalNic: "AdditionalNic",
}

/**
 * NIC type. This should be either PublicNic or PrivateNic.
 */
union NicTypeInRequest {
  string,

  /**
   * PublicNic
   */
  PublicNic: "PublicNic",

  /**
   * PrivateNic
   */
  PrivateNic: "PrivateNic",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union NvaNicType {
  string,

  /**
   * The private NIC type
   */
  PrivateNic: "PrivateNic",

  /**
   * The public NIC type
   */
  PublicNic: "PublicNic",

  /**
   * An additional private NIC type
   */
  AdditionalPrivateNic: "AdditionalPrivateNic",

  /**
   * An additional public NIC type
   */
  AdditionalPublicNic: "AdditionalPublicNic",
}

/**
 * Rule Type. This should be either AutoExpire or Permanent. Auto Expire Rule only creates NSG rules. Permanent Rule creates NSG rule and SLB LB Rule.
 */
union InboundSecurityRuleType {
  string,

  /**
   * AutoExpire
   */
  AutoExpire: "AutoExpire",

  /**
   * Permanent
   */
  Permanent: "Permanent",
}

/**
 * Protocol. This should be either TCP or UDP.
 */
union InboundSecurityRulesProtocol {
  string,

  /**
   * TCP
   */
  TCP: "TCP",

  /**
   * UDP
   */
  UDP: "UDP",
}

/**
 * The association type of the child resource to the parent resource.
 */
union AssociationType {
  string,

  /**
   * Associated
   */
  Associated: "Associated",

  /**
   * Contains
   */
  Contains: "Contains",
}

/**
 * The direction of the traffic.
 */
union Direction {
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
 * Protocol to be verified on.
 */
union IpFlowProtocol {
  string,

  /**
   * TCP
   */
  TCP: "TCP",

  /**
   * UDP
   */
  UDP: "UDP",
}

/**
 * Access to be allowed or denied.
 */
union Access {
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
 * Next hop type.
 */
union NextHopType {
  string,

  /**
   * Internet
   */
  Internet: "Internet",

  /**
   * VirtualAppliance
   */
  VirtualAppliance: "VirtualAppliance",

  /**
   * VirtualNetworkGateway
   */
  VirtualNetworkGateway: "VirtualNetworkGateway",

  /**
   * VnetLocal
   */
  VnetLocal: "VnetLocal",

  /**
   * HyperNetGateway
   */
  HyperNetGateway: "HyperNetGateway",

  /**
   * None
   */
  None: "None",
}

/**
 * Protocol to be filtered on.
 */
union PcProtocol {
  string,

  /**
   * TCP
   */
  TCP: "TCP",

  /**
   * UDP
   */
  UDP: "UDP",

  /**
   * Any
   */
  Any: "Any",
}

/**
 * The status of the packet capture session.
 */
union PcStatus {
  string,

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Stopped
   */
  Stopped: "Stopped",

  /**
   * Error
   */
  Error: "Error",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union PcError {
  string,

  /**
   * InternalError
   */
  InternalError: "InternalError",

  /**
   * AgentStopped
   */
  AgentStopped: "AgentStopped",

  /**
   * CaptureFailed
   */
  CaptureFailed: "CaptureFailed",

  /**
   * LocalFileFailed
   */
  LocalFileFailed: "LocalFileFailed",

  /**
   * StorageFailed
   */
  StorageFailed: "StorageFailed",
}

/**
 * Network protocol.
 */
union Protocol {
  string,

  /**
   * Tcp
   */
  Tcp: "Tcp",

  /**
   * Http
   */
  Http: "Http",

  /**
   * Https
   */
  Https: "Https",

  /**
   * Icmp
   */
  Icmp: "Icmp",
}

/**
 * HTTP method.
 */
union HttpMethod {
  string,

  /**
   * Get
   */
  Get: "Get",
}

/**
 * The origin of the issue.
 */
union Origin {
  string,

  /**
   * Local
   */
  Local: "Local",

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
 * The severity of the issue.
 */
union Severity {
  string,

  /**
   * Error
   */
  Error: "Error",

  /**
   * Warning
   */
  Warning: "Warning",
}

/**
 * The type of issue.
 */
union IssueType {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * AgentStopped
   */
  AgentStopped: "AgentStopped",

  /**
   * GuestFirewall
   */
  GuestFirewall: "GuestFirewall",

  /**
   * DnsResolution
   */
  DnsResolution: "DnsResolution",

  /**
   * SocketBind
   */
  SocketBind: "SocketBind",

  /**
   * NetworkSecurityRule
   */
  NetworkSecurityRule: "NetworkSecurityRule",

  /**
   * UserDefinedRoute
   */
  UserDefinedRoute: "UserDefinedRoute",

  /**
   * PortThrottled
   */
  PortThrottled: "PortThrottled",

  /**
   * Platform
   */
  Platform: "Platform",
}

/**
 * The connection status.
 */
union ConnectionStatus {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Connected
   */
  Connected: "Connected",

  /**
   * Disconnected
   */
  Disconnected: "Disconnected",

  /**
   * Degraded
   */
  Degraded: "Degraded",
}

/**
 * Verbosity level.
 */
union VerbosityLevel {
  string,

  /**
   * Normal
   */
  Normal: "Normal",

  /**
   * Minimum
   */
  Minimum: "Minimum",

  /**
   * Full
   */
  Full: "Full",
}

/**
 * The endpoint type.
 */
union EndpointType {
  string,

  /**
   * AzureVM
   */
  AzureVM: "AzureVM",

  /**
   * AzureVNet
   */
  AzureVNet: "AzureVNet",

  /**
   * AzureSubnet
   */
  AzureSubnet: "AzureSubnet",

  /**
   * ExternalAddress
   */
  ExternalAddress: "ExternalAddress",

  /**
   * MMAWorkspaceMachine
   */
  MMAWorkspaceMachine: "MMAWorkspaceMachine",

  /**
   * MMAWorkspaceNetwork
   */
  MMAWorkspaceNetwork: "MMAWorkspaceNetwork",

  /**
   * AzureArcVM
   */
  AzureArcVM: "AzureArcVM",

  /**
   * AzureVMSS
   */
  AzureVMSS: "AzureVMSS",

  /**
   * AzureArcNetwork
   */
  AzureArcNetwork: "AzureArcNetwork",
}

/**
 * The behavior of the endpoint filter. Currently only 'Include' is supported.
 */
union ConnectionMonitorEndpointFilterType {
  string,

  /**
   * Include
   */
  Include: "Include",
}

/**
 * The type of item included in the filter. Currently only 'AgentAddress' is supported.
 */
union ConnectionMonitorEndpointFilterItemType {
  string,

  /**
   * AgentAddress
   */
  AgentAddress: "AgentAddress",
}

/**
 * Test coverage for the endpoint.
 */
union CoverageLevel {
  string,

  /**
   * Default
   */
  Default: "Default",

  /**
   * Low
   */
  Low: "Low",

  /**
   * BelowAverage
   */
  BelowAverage: "BelowAverage",

  /**
   * Average
   */
  Average: "Average",

  /**
   * AboveAverage
   */
  AboveAverage: "AboveAverage",

  /**
   * Full
   */
  Full: "Full",
}

/**
 * The protocol to use in test evaluation.
 */
union ConnectionMonitorTestConfigurationProtocol {
  string,

  /**
   * Tcp
   */
  Tcp: "Tcp",

  /**
   * Http
   */
  Http: "Http",

  /**
   * Icmp
   */
  Icmp: "Icmp",
}

/**
 * The preferred IP version to use in test evaluation. The connection monitor may choose to use a different version depending on other parameters.
 */
union PreferredIPVersion {
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
 * The HTTP method to use.
 */
union HttpConfigurationMethod {
  string,

  /**
   * Get
   */
  Get: "Get",

  /**
   * Post
   */
  Post: "Post",
}

/**
 * Destination port behavior.
 */
union DestinationPortBehavior {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * ListenIfAvailable
   */
  ListenIfAvailable: "ListenIfAvailable",
}

/**
 * Connection monitor output destination type. Currently, only "Workspace" is supported.
 */
union OutputType {
  string,

  /**
   * Workspace
   */
  Workspace: "Workspace",
}

/**
 * Type of connection monitor.
 */
union ConnectionMonitorType {
  string,

  /**
   * MultiEndpoint
   */
  MultiEndpoint: "MultiEndpoint",

  /**
   * SingleSourceDestination
   */
  SingleSourceDestination: "SingleSourceDestination",
}

/**
 * Value indicating whether the IP address is DDoS workload protected or not.
 */
union IsWorkloadProtected {
  string,

  /**
   * False
   */
  False: "False",

  /**
   * True
   */
  True: "True",
}

/**
 * When true, reverts from Static to Dynamic allocation (undo reservation).
 */
union IsRollback {
  string,

  /**
   * true
   */
  `true`: "true",

  /**
   * false
   */
  `false`: "false",
}

/**
 * Name of a public IP prefix SKU.
 */
union PublicIPPrefixSkuName {
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
 * Tier of a public IP prefix SKU.
 */
union PublicIPPrefixSkuTier {
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
 * The rule type of the rule.
 */
union RouteFilterRuleType {
  string,

  /**
   * Community
   */
  Community: "Community",
}

/**
 * The Security Providers.
 */
union SecurityProviderName {
  string,

  /**
   * ZScaler
   */
  ZScaler: "ZScaler",

  /**
   * IBoss
   */
  IBoss: "IBoss",

  /**
   * Checkpoint
   */
  Checkpoint: "Checkpoint",
}

/**
 * The current state of the connection with Security Partner Provider.
 */
union SecurityPartnerProviderConnectionStatus {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * PartiallyConnected
   */
  PartiallyConnected: "PartiallyConnected",

  /**
   * Connected
   */
  Connected: "Connected",

  /**
   * NotConnected
   */
  NotConnected: "NotConnected",
}

/**
 * An enum describing the unit of measurement.
 */
union UsageUnit {
  string,

  /**
   * Count
   */
  Count: "Count",
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union SyncRemoteAddressSpace {
  string,

  /**
   * true
   */
  `true`: "true",
}

/**
 * The type of this virtual network gateway.
 */
union VirtualNetworkGatewayType {
  string,

  /**
   * Vpn
   */
  Vpn: "Vpn",

  /**
   * ExpressRoute
   */
  ExpressRoute: "ExpressRoute",

  /**
   * LocalGateway
   */
  LocalGateway: "LocalGateway",
}

/**
 * The type of this virtual network gateway.
 */
union VpnType {
  string,

  /**
   * PolicyBased
   */
  PolicyBased: "PolicyBased",

  /**
   * RouteBased
   */
  RouteBased: "RouteBased",
}

/**
 * The generation for this VirtualNetworkGateway. Must be None if gatewayType is not VPN.
 */
union VpnGatewayGeneration {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Generation1
   */
  Generation1: "Generation1",

  /**
   * Generation2
   */
  Generation2: "Generation2",
}

/**
 * Represent the current state of gateway migration.
 */
union VirtualNetworkGatewayMigrationState {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * Represent the current migration phase of gateway.
 */
union VirtualNetworkGatewayMigrationPhase {
  string,

  /**
   * No migration phase set on gateway.
   */
  None: "None",

  /**
   * Gateway is going through prepare migration or prepare has failed. Please see state and error details for more information.
   */
  Prepare: "Prepare",

  /**
   * Prepare succeeded on gateway.
   */
  PrepareSucceeded: "PrepareSucceeded",

  /**
   * Gateway is going through execute migration or execute has failed. Please see state and error details for more information.
   */
  Execute: "Execute",

  /**
   * Execute succeeded on gateway.
   */
  ExecuteSucceeded: "ExecuteSucceeded",

  /**
   * Gateway is going through commit migration or commit has failed. Please see state and error details for more information.
   */
  Commit: "Commit",

  /**
   * Commit succeeded, represent migration is complete for the gateway.
   */
  CommitSucceeded: "CommitSucceeded",

  /**
   * Represent abort succeeded on gateway, start with prepare to retrigger migration.
   */
  AbortSucceeded: "AbortSucceeded",

  /**
   * Gateway is going through abort migration or abort has failed. Please see state and error details for more information.
   */
  Abort: "Abort",
}

/**
 * Gateway SKU name.
 */
union VirtualNetworkGatewaySkuName {
  string,

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * HighPerformance
   */
  HighPerformance: "HighPerformance",

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * UltraPerformance
   */
  UltraPerformance: "UltraPerformance",

  /**
   * VpnGw1
   */
  VpnGw1: "VpnGw1",

  /**
   * VpnGw2
   */
  VpnGw2: "VpnGw2",

  /**
   * VpnGw3
   */
  VpnGw3: "VpnGw3",

  /**
   * VpnGw4
   */
  VpnGw4: "VpnGw4",

  /**
   * VpnGw5
   */
  VpnGw5: "VpnGw5",

  /**
   * VpnGw1AZ
   */
  VpnGw1AZ: "VpnGw1AZ",

  /**
   * VpnGw2AZ
   */
  VpnGw2AZ: "VpnGw2AZ",

  /**
   * VpnGw3AZ
   */
  VpnGw3AZ: "VpnGw3AZ",

  /**
   * VpnGw4AZ
   */
  VpnGw4AZ: "VpnGw4AZ",

  /**
   * VpnGw5AZ
   */
  VpnGw5AZ: "VpnGw5AZ",

  /**
   * ErGw1AZ
   */
  ErGw1AZ: "ErGw1AZ",

  /**
   * ErGw2AZ
   */
  ErGw2AZ: "ErGw2AZ",

  /**
   * ErGw3AZ
   */
  ErGw3AZ: "ErGw3AZ",

  /**
   * ErGwScale
   */
  ErGwScale: "ErGwScale",
}

/**
 * Gateway SKU tier.
 */
union VirtualNetworkGatewaySkuTier {
  string,

  /**
   * Basic
   */
  Basic: "Basic",

  /**
   * HighPerformance
   */
  HighPerformance: "HighPerformance",

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * UltraPerformance
   */
  UltraPerformance: "UltraPerformance",

  /**
   * VpnGw1
   */
  VpnGw1: "VpnGw1",

  /**
   * VpnGw2
   */
  VpnGw2: "VpnGw2",

  /**
   * VpnGw3
   */
  VpnGw3: "VpnGw3",

  /**
   * VpnGw4
   */
  VpnGw4: "VpnGw4",

  /**
   * VpnGw5
   */
  VpnGw5: "VpnGw5",

  /**
   * VpnGw1AZ
   */
  VpnGw1AZ: "VpnGw1AZ",

  /**
   * VpnGw2AZ
   */
  VpnGw2AZ: "VpnGw2AZ",

  /**
   * VpnGw3AZ
   */
  VpnGw3AZ: "VpnGw3AZ",

  /**
   * VpnGw4AZ
   */
  VpnGw4AZ: "VpnGw4AZ",

  /**
   * VpnGw5AZ
   */
  VpnGw5AZ: "VpnGw5AZ",

  /**
   * ErGw1AZ
   */
  ErGw1AZ: "ErGw1AZ",

  /**
   * ErGw2AZ
   */
  ErGw2AZ: "ErGw2AZ",

  /**
   * ErGw3AZ
   */
  ErGw3AZ: "ErGw3AZ",

  /**
   * ErGwScale
   */
  ErGwScale: "ErGwScale",
}

/**
 * VPN client protocol enabled for the virtual network gateway.
 */
union VpnClientProtocol {
  string,

  /**
   * IkeV2
   */
  IkeV2: "IkeV2",

  /**
   * SSTP
   */
  SSTP: "SSTP",

  /**
   * OpenVPN
   */
  OpenVPN: "OpenVPN",
}

/**
 * VPN authentication types enabled for the virtual network gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
union VpnAuthenticationType {
  string,

  /**
   * Certificate
   */
  Certificate: "Certificate",

  /**
   * Radius
   */
  Radius: "Radius",

  /**
   * AAD
   */
  AAD: "AAD",
}

/**
 * The IPSec encryption algorithm (IKE phase 1).
 */
union IpsecEncryption {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * DES
   */
  DES: "DES",

  /**
   * DES3
   */
  DES3: "DES3",

  /**
   * AES128
   */
  AES128: "AES128",

  /**
   * AES192
   */
  AES192: "AES192",

  /**
   * AES256
   */
  AES256: "AES256",

  /**
   * GCMAES128
   */
  GCMAES128: "GCMAES128",

  /**
   * GCMAES192
   */
  GCMAES192: "GCMAES192",

  /**
   * GCMAES256
   */
  GCMAES256: "GCMAES256",
}

/**
 * The IPSec integrity algorithm (IKE phase 1).
 */
union IpsecIntegrity {
  string,

  /**
   * MD5
   */
  MD5: "MD5",

  /**
   * SHA1
   */
  SHA1: "SHA1",

  /**
   * SHA256
   */
  SHA256: "SHA256",

  /**
   * GCMAES128
   */
  GCMAES128: "GCMAES128",

  /**
   * GCMAES192
   */
  GCMAES192: "GCMAES192",

  /**
   * GCMAES256
   */
  GCMAES256: "GCMAES256",
}

/**
 * The IKE encryption algorithm (IKE phase 2).
 */
union IkeEncryption {
  string,

  /**
   * DES
   */
  DES: "DES",

  /**
   * DES3
   */
  DES3: "DES3",

  /**
   * AES128
   */
  AES128: "AES128",

  /**
   * AES192
   */
  AES192: "AES192",

  /**
   * AES256
   */
  AES256: "AES256",

  /**
   * GCMAES256
   */
  GCMAES256: "GCMAES256",

  /**
   * GCMAES128
   */
  GCMAES128: "GCMAES128",
}

/**
 * The IKE integrity algorithm (IKE phase 2).
 */
union IkeIntegrity {
  string,

  /**
   * MD5
   */
  MD5: "MD5",

  /**
   * SHA1
   */
  SHA1: "SHA1",

  /**
   * SHA256
   */
  SHA256: "SHA256",

  /**
   * SHA384
   */
  SHA384: "SHA384",

  /**
   * GCMAES256
   */
  GCMAES256: "GCMAES256",

  /**
   * GCMAES128
   */
  GCMAES128: "GCMAES128",
}

/**
 * The DH Groups used in IKE Phase 1 for initial SA.
 */
union DhGroup {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * DHGroup1
   */
  DHGroup1: "DHGroup1",

  /**
   * DHGroup2
   */
  DHGroup2: "DHGroup2",

  /**
   * DHGroup14
   */
  DHGroup14: "DHGroup14",

  /**
   * DHGroup2048
   */
  DHGroup2048: "DHGroup2048",

  /**
   * ECP256
   */
  ECP256: "ECP256",

  /**
   * ECP384
   */
  ECP384: "ECP384",

  /**
   * DHGroup24
   */
  DHGroup24: "DHGroup24",
}

/**
 * The Pfs Groups used in IKE Phase 2 for new child SA.
 */
union PfsGroup {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * PFS1
   */
  PFS1: "PFS1",

  /**
   * PFS2
   */
  PFS2: "PFS2",

  /**
   * PFS2048
   */
  PFS2048: "PFS2048",

  /**
   * ECP256
   */
  ECP256: "ECP256",

  /**
   * ECP384
   */
  ECP384: "ECP384",

  /**
   * PFS24
   */
  PFS24: "PFS24",

  /**
   * PFS14
   */
  PFS14: "PFS14",

  /**
   * PFSMM
   */
  PFSMM: "PFSMM",
}

/**
 * The Vpn Policy member attribute type.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
union VpnPolicyMemberAttributeType {
  string,

  /**
   * CertificateGroupId
   */
  CertificateGroupId: "CertificateGroupId",

  /**
   * AADGroupId
   */
  AADGroupId: "AADGroupId",

  /**
   * RadiusAzureGroupId
   */
  RadiusAzureGroupId: "RadiusAzureGroupId",
}

/**
 * The type of NAT rule for VPN NAT.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
union VpnNatRuleType {
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
 * The Source NAT direction of a VPN NAT.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
union VpnNatRuleMode {
  string,

  /**
   * EgressSnat
   */
  EgressSnat: "EgressSnat",

  /**
   * IngressSnat
   */
  IngressSnat: "IngressSnat",
}

/**
 * Property to indicate if the Express Route Gateway serves traffic when there are multiple Express Route Gateways in the vnet
 */
union AdminState {
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
 * Property to indicate if the Express Route Gateway has resiliency model of MultiHomed or SingleHomed
 */
union ResiliencyModel {
  string,

  /**
   * SingleHomed
   */
  SingleHomed: "SingleHomed",

  /**
   * MultiHomed
   */
  MultiHomed: "MultiHomed",
}

/**
 * Gateway connection type.
 */
union VirtualNetworkGatewayConnectionType {
  string,

  /**
   * IPsec
   */
  IPsec: "IPsec",

  /**
   * Vnet2Vnet
   */
  Vnet2Vnet: "Vnet2Vnet",

  /**
   * ExpressRoute
   */
  ExpressRoute: "ExpressRoute",

  /**
   * VPNClient
   */
  VPNClient: "VPNClient",
}

/**
 * Gateway connection protocol.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
union VirtualNetworkGatewayConnectionProtocol {
  string,

  /**
   * IKEv2
   */
  IKEv2: "IKEv2",

  /**
   * IKEv1
   */
  IKEv1: "IKEv1",
}

/**
 * Gateway connection type.
 */
union VirtualNetworkGatewayConnectionMode {
  string,

  /**
   * Default
   */
  Default: "Default",

  /**
   * ResponderOnly
   */
  ResponderOnly: "ResponderOnly",

  /**
   * InitiatorOnly
   */
  InitiatorOnly: "InitiatorOnly",
}

/**
 * Virtual Network Gateway connection status.
 */
union VirtualNetworkGatewayConnectionStatus {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Connecting
   */
  Connecting: "Connecting",

  /**
   * Connected
   */
  Connected: "Connected",

  /**
   * NotConnected
   */
  NotConnected: "NotConnected",
}

/**
 * VPN client Processor Architecture.
 */
union ProcessorArchitecture {
  string,

  /**
   * Amd64
   */
  Amd64: "Amd64",

  /**
   * X86
   */
  X86: "X86",
}

/**
 * VPN client authentication method.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
union AuthenticationMethod {
  string,

  /**
   * EAPTLS
   */
  EAPTLS: "EAPTLS",

  /**
   * EAPMSCHAPv2
   */
  EAPMSCHAPv2: "EAPMSCHAPv2",
}

/**
 * The BGP peer state.
 */
union BgpPeerState {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Stopped
   */
  Stopped: "Stopped",

  /**
   * Idle
   */
  Idle: "Idle",

  /**
   * Connecting
   */
  Connecting: "Connecting",

  /**
   * Connected
   */
  Connected: "Connected",
}

/**
 * The current status of the test
 */
union FailoverTestStatus {
  string,

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * Starting
   */
  Starting: "Starting",

  /**
   * Running
   */
  Running: "Running",

  /**
   * StartFailed
   */
  StartFailed: "StartFailed",

  /**
   * Stopping
   */
  Stopping: "Stopping",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * StopFailed
   */
  StopFailed: "StopFailed",

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * Expired
   */
  Expired: "Expired",
}

/**
 * The current status of the connection
 */
union FailoverConnectionStatus {
  string,

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
 * The type of failover test
 */
union FailoverTestType {
  string,

  /**
   * SingleSiteFailover
   */
  SingleSiteFailover: "SingleSiteFailover",

  /**
   * MultiSiteFailover
   */
  MultiSiteFailover: "MultiSiteFailover",

  /**
   * All
   */
  All: "All",
}

/**
 * The current status of the test
 */
union FailoverTestStatusForSingleTest {
  string,

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * Starting
   */
  Starting: "Starting",

  /**
   * Running
   */
  Running: "Running",

  /**
   * StartFailed
   */
  StartFailed: "StartFailed",

  /**
   * Stopping
   */
  Stopping: "Stopping",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * StopFailed
   */
  StopFailed: "StopFailed",

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * Expired
   */
  Expired: "Expired",
}

/**
 * Gateway connection authentication type.
 */
union ConnectionAuthenticationType {
  string,

  /**
   * Pre-shared key authentication method for VPN gateway connections.
   */
  PSK: "PSK",

  /**
   * Certificate-based authentication method for VPN gateway connections.
   */
  Certificate: "Certificate",
}

/**
 * MigrationType for the virtual network gateway.
 */
union VirtualNetworkGatewayMigrationType {
  string,

  /**
   * Indicates that it is a migration process from basic IP CSES to standard IP VMSS.
   */
  UpgradeDeploymentToStandardIP: "UpgradeDeploymentToStandardIP",
}

/**
 * The office traffic category.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
union OfficeTrafficCategory {
  string,

  /**
   * Optimize
   */
  Optimize: "Optimize",

  /**
   * OptimizeAndAllow
   */
  OptimizeAndAllow: "OptimizeAndAllow",

  /**
   * All
   */
  All: "All",

  /**
   * None
   */
  None: "None",
}

/**
 * The virtual wan security provider type.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
union VirtualWanSecurityProviderType {
  string,

  /**
   * External
   */
  External: "External",

  /**
   * Native
   */
  Native: "Native",
}

/**
 * VPN protocol enabled for the VpnServerConfiguration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
union VpnGatewayTunnelingProtocol {
  string,

  /**
   * IkeV2
   */
  IkeV2: "IkeV2",

  /**
   * OpenVPN
   */
  OpenVPN: "OpenVPN",
}

/**
 * Parameter determining whether NVA in spoke vnet is bypassed for traffic with destination in spoke vnet.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
union VnetLocalRouteOverrideCriteria {
  string,

  /**
   * Contains
   */
  Contains: "Contains",

  /**
   * Equal
   */
  Equal: "Equal",
}

/**
 * The current routing state of the VirtualHub.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
union RoutingState {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Provisioned
   */
  Provisioned: "Provisioned",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The preferred routing gateway types
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
union PreferredRoutingGateway {
  string,

  /**
   * ExpressRoute
   */
  ExpressRoute: "ExpressRoute",

  /**
   * VpnGateway
   */
  VpnGateway: "VpnGateway",

  /**
   * None
   */
  None: "None",
}

/**
 * The hub routing preference gateway types
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
union HubRoutingPreference {
  string,

  /**
   * ExpressRoute
   */
  ExpressRoute: "ExpressRoute",

  /**
   * VpnGateway
   */
  VpnGateway: "VpnGateway",

  /**
   * ASPath
   */
  ASPath: "ASPath",
}

/**
 * Match condition to apply RouteMap rules.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
union RouteMapMatchCondition {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Contains
   */
  Contains: "Contains",

  /**
   * Equals
   */
  Equals: "Equals",

  /**
   * NotContains
   */
  NotContains: "NotContains",

  /**
   * NotEquals
   */
  NotEquals: "NotEquals",
}

/**
 * Kind of actions which can be taken on a matched route. Add, Replace, Remove refer to parameters on the route, like community or prefix
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
union RouteMapActionType {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Remove
   */
  Remove: "Remove",

  /**
   * Add
   */
  Add: "Add",

  /**
   * Replace
   */
  Replace: "Replace",

  /**
   * Drop
   */
  Drop: "Drop",
}

/**
 * Supported next step behaviors after a rule is applied to a matched route
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
union NextStep {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Continue
   */
  Continue: "Continue",

  /**
   * Terminate
   */
  Terminate: "Terminate",
}

/**
 * The current state of the vpn connection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
union VpnConnectionStatus {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Connecting
   */
  Connecting: "Connecting",

  /**
   * Connected
   */
  Connected: "Connected",

  /**
   * NotConnected
   */
  NotConnected: "NotConnected",
}

/**
 * Vpn link connection mode.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
union VpnLinkConnectionMode {
  string,

  /**
   * Default
   */
  Default: "Default",

  /**
   * ResponderOnly
   */
  ResponderOnly: "ResponderOnly",

  /**
   * InitiatorOnly
   */
  InitiatorOnly: "InitiatorOnly",
}

/**
 * The current state of the VirtualHub to Peer.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
union HubBgpConnectionStatus {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Connecting
   */
  Connecting: "Connecting",

  /**
   * Connected
   */
  Connected: "Connected",

  /**
   * NotConnected
   */
  NotConnected: "NotConnected",
}

/**
 * The state of the policy.
 */
union WebApplicationFirewallEnabledState {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * The mode of the policy.
 */
union WebApplicationFirewallMode {
  string,

  /**
   * Prevention
   */
  Prevention: "Prevention",

  /**
   * Detection
   */
  Detection: "Detection",
}

/**
 * State of the log scrubbing config. Default value is Enabled.
 */
union WebApplicationFirewallScrubbingState {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * The variable to be scrubbed from the logs.
 */
union ScrubbingRuleEntryMatchVariable {
  string,

  /**
   * RequestHeaderNames
   */
  RequestHeaderNames: "RequestHeaderNames",

  /**
   * RequestCookieNames
   */
  RequestCookieNames: "RequestCookieNames",

  /**
   * RequestArgNames
   */
  RequestArgNames: "RequestArgNames",

  /**
   * RequestPostArgNames
   */
  RequestPostArgNames: "RequestPostArgNames",

  /**
   * RequestJSONArgNames
   */
  RequestJSONArgNames: "RequestJSONArgNames",

  /**
   * RequestIPAddress
   */
  RequestIPAddress: "RequestIPAddress",
}

/**
 * When matchVariable is a collection, operate on the selector to specify which elements in the collection this rule applies to.
 */
union ScrubbingRuleEntryMatchOperator {
  string,

  /**
   * Equals
   */
  Equals: "Equals",

  /**
   * EqualsAny
   */
  EqualsAny: "EqualsAny",
}

/**
 * Defines the state of log scrubbing rule. Default value is Enabled.
 */
union ScrubbingRuleEntryState {
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
 * Describes if the custom rule is in enabled or disabled state. Defaults to Enabled if not specified.
 */
union WebApplicationFirewallState {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * Duration over which Rate Limit policy will be applied. Applies only when ruleType is RateLimitRule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
union ApplicationGatewayFirewallRateLimitDuration {
  string,

  /**
   * OneMin
   */
  OneMin: "OneMin",

  /**
   * FiveMins
   */
  FiveMins: "FiveMins",
}

/**
 * The rule type.
 */
union WebApplicationFirewallRuleType {
  string,

  /**
   * MatchRule
   */
  MatchRule: "MatchRule",

  /**
   * RateLimitRule
   */
  RateLimitRule: "RateLimitRule",

  /**
   * Invalid
   */
  Invalid: "Invalid",
}

/**
 * Match Variable.
 */
union WebApplicationFirewallMatchVariable {
  string,

  /**
   * RemoteAddr
   */
  RemoteAddr: "RemoteAddr",

  /**
   * RequestMethod
   */
  RequestMethod: "RequestMethod",

  /**
   * QueryString
   */
  QueryString: "QueryString",

  /**
   * PostArgs
   */
  PostArgs: "PostArgs",

  /**
   * RequestUri
   */
  RequestUri: "RequestUri",

  /**
   * RequestHeaders
   */
  RequestHeaders: "RequestHeaders",

  /**
   * RequestBody
   */
  RequestBody: "RequestBody",

  /**
   * RequestCookies
   */
  RequestCookies: "RequestCookies",
}

/**
 * The operator to be matched.
 */
union WebApplicationFirewallOperator {
  string,

  /**
   * IPMatch
   */
  IPMatch: "IPMatch",

  /**
   * Equal
   */
  Equal: "Equal",

  /**
   * Contains
   */
  Contains: "Contains",

  /**
   * LessThan
   */
  LessThan: "LessThan",

  /**
   * GreaterThan
   */
  GreaterThan: "GreaterThan",

  /**
   * LessThanOrEqual
   */
  LessThanOrEqual: "LessThanOrEqual",

  /**
   * GreaterThanOrEqual
   */
  GreaterThanOrEqual: "GreaterThanOrEqual",

  /**
   * BeginsWith
   */
  BeginsWith: "BeginsWith",

  /**
   * EndsWith
   */
  EndsWith: "EndsWith",

  /**
   * Regex
   */
  Regex: "Regex",

  /**
   * GeoMatch
   */
  GeoMatch: "GeoMatch",

  /**
   * Any
   */
  Any: "Any",
}

/**
 * Transforms applied before matching.
 */
union WebApplicationFirewallTransform {
  string,

  /**
   * Uppercase
   */
  Uppercase: "Uppercase",

  /**
   * Lowercase
   */
  Lowercase: "Lowercase",

  /**
   * Trim
   */
  Trim: "Trim",

  /**
   * UrlDecode
   */
  UrlDecode: "UrlDecode",

  /**
   * UrlEncode
   */
  UrlEncode: "UrlEncode",

  /**
   * RemoveNulls
   */
  RemoveNulls: "RemoveNulls",

  /**
   * HtmlEntityDecode
   */
  HtmlEntityDecode: "HtmlEntityDecode",
}

/**
 * User Session clause variable.
 */
union ApplicationGatewayFirewallUserSessionVariable {
  string,

  /**
   * ClientAddr
   */
  ClientAddr: "ClientAddr",

  /**
   * GeoLocation
   */
  GeoLocation: "GeoLocation",

  /**
   * None
   */
  None: "None",

  /**
   * ClientAddrXFFHeader
   */
  ClientAddrXFFHeader: "ClientAddrXFFHeader",

  /**
   * GeoLocationXFFHeader
   */
  GeoLocationXFFHeader: "GeoLocationXFFHeader",
}

/**
 * Type of Actions.
 */
union WebApplicationFirewallAction {
  string,

  /**
   * Allow
   */
  Allow: "Allow",

  /**
   * Block
   */
  Block: "Block",

  /**
   * Log
   */
  Log: "Log",

  /**
   * JSChallenge
   */
  JSChallenge: "JSChallenge",
}

/**
 * Resource status of the policy.
 */
union WebApplicationFirewallPolicyResourceState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Enabling
   */
  Enabling: "Enabling",

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabling
   */
  Disabling: "Disabling",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Deleting
   */
  Deleting: "Deleting",
}

/**
 * The variable on which we evaluate the exception condition
 */
union ExceptionEntryMatchVariable {
  string,

  /**
   * RequestURI
   */
  RequestURI: "RequestURI",

  /**
   * RemoteAddr
   */
  RemoteAddr: "RemoteAddr",

  /**
   * RequestHeader
   */
  RequestHeader: "RequestHeader",
}

/**
 * Operates on the allowed values for the matchVariable
 */
union ExceptionEntryValueMatchOperator {
  string,

  /**
   * Equals
   */
  Equals: "Equals",

  /**
   * Contains
   */
  Contains: "Contains",

  /**
   * StartsWith
   */
  StartsWith: "StartsWith",

  /**
   * EndsWith
   */
  EndsWith: "EndsWith",

  /**
   * IPMatch
   */
  IPMatch: "IPMatch",
}

/**
 * When the matchVariable points to a key-value pair (e.g, RequestHeader), this operates on the selector
 */
union ExceptionEntrySelectorMatchOperator {
  string,

  /**
   * Equals
   */
  Equals: "Equals",

  /**
   * Contains
   */
  Contains: "Contains",

  /**
   * StartsWith
   */
  StartsWith: "StartsWith",

  /**
   * EndsWith
   */
  EndsWith: "EndsWith",
}

/**
 * The variable to be excluded.
 */
union OwaspCrsExclusionEntryMatchVariable {
  string,

  /**
   * RequestHeaderNames
   */
  RequestHeaderNames: "RequestHeaderNames",

  /**
   * RequestCookieNames
   */
  RequestCookieNames: "RequestCookieNames",

  /**
   * RequestArgNames
   */
  RequestArgNames: "RequestArgNames",

  /**
   * RequestHeaderKeys
   */
  RequestHeaderKeys: "RequestHeaderKeys",

  /**
   * RequestHeaderValues
   */
  RequestHeaderValues: "RequestHeaderValues",

  /**
   * RequestCookieKeys
   */
  RequestCookieKeys: "RequestCookieKeys",

  /**
   * RequestCookieValues
   */
  RequestCookieValues: "RequestCookieValues",

  /**
   * RequestArgKeys
   */
  RequestArgKeys: "RequestArgKeys",

  /**
   * RequestArgValues
   */
  RequestArgValues: "RequestArgValues",
}

/**
 * When matchVariable is a collection, operate on the selector to specify which elements in the collection this exclusion applies to.
 */
union OwaspCrsExclusionEntrySelectorMatchOperator {
  string,

  /**
   * Equals
   */
  Equals: "Equals",

  /**
   * Contains
   */
  Contains: "Contains",

  /**
   * StartsWith
   */
  StartsWith: "StartsWith",

  /**
   * EndsWith
   */
  EndsWith: "EndsWith",

  /**
   * EqualsAny
   */
  EqualsAny: "EqualsAny",
}

/**
 * The state of the managed rule. Defaults to Disabled if not specified.
 */
union ManagedRuleEnabledState {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * Defines the action to take on rule match.
 */
union ActionType {
  string,

  /**
   * AnomalyScoring
   */
  AnomalyScoring: "AnomalyScoring",

  /**
   * Allow
   */
  Allow: "Allow",

  /**
   * Block
   */
  Block: "Block",

  /**
   * Log
   */
  Log: "Log",

  /**
   * JSChallenge
   */
  JSChallenge: "JSChallenge",
}

/**
 * Defines the sensitivity for the rule.
 */
union SensitivityType {
  string,

  /**
   * Low
   */
  Low: "Low",

  /**
   * Medium
   */
  Medium: "Medium",

  /**
   * High
   */
  High: "High",
}

/**
 * The action type of a rule.
 */
union FirewallPolicyNatRuleCollectionActionType {
  string,

  /**
   * DNAT
   */
  DNAT: "DNAT",
}

/**
 * Rule Type.
 */
union FirewallPolicyRuleType {
  string,

  /**
   * ApplicationRule
   */
  ApplicationRule: "ApplicationRule",

  /**
   * NetworkRule
   */
  NetworkRule: "NetworkRule",

  /**
   * NatRule
   */
  NatRule: "NatRule",
}

/**
 * The action type of a rule.
 */
union FirewallPolicyFilterRuleCollectionActionType {
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
 * The application protocol type of a Rule.
 */
union FirewallPolicyRuleApplicationProtocolType {
  string,

  /**
   * Http
   */
  Http: "Http",

  /**
   * Https
   */
  Https: "Https",
}

/**
 * The Network protocol of a Rule.
 */
union FirewallPolicyRuleNetworkProtocol {
  string,

  /**
   * TCP
   */
  TCP: "TCP",

  /**
   * UDP
   */
  UDP: "UDP",

  /**
   * Any
   */
  Any: "Any",

  /**
   * ICMP
   */
  ICMP: "ICMP",
}

/**
 * Status of the Azure async operation.
 */
union NetworkOperationStatus {
  string,

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * Whether network traffic is allowed or denied.
 */
union SecurityConfigurationRuleAccess {
  string,

  /**
   * Allow
   */
  Allow: "Allow",

  /**
   * Deny
   */
  Deny: "Deny",

  /**
   * AlwaysAllow
   */
  AlwaysAllow: "AlwaysAllow",
}

/**
 * The connection state.
 */
union ConnectionState {
  string,

  /**
   * Reachable
   */
  Reachable: "Reachable",

  /**
   * Unreachable
   */
  Unreachable: "Unreachable",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * Connectivity analysis evaluation state.
 */
union EvaluationState {
  string,

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Completed
   */
  Completed: "Completed",
}

/**
 * Status of connection monitor source.
 */
union ConnectionMonitorSourceStatus {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Active
   */
  Active: "Active",

  /**
   * Inactive
   */
  Inactive: "Inactive",
}

/**
 * The current state of the tunnel.
 */
union TunnelConnectionStatus {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Connecting
   */
  Connecting: "Connecting",

  /**
   * Connected
   */
  Connected: "Connected",

  /**
   * NotConnected
   */
  NotConnected: "NotConnected",
}

/**
 * The current state of the VirtualHub to vnet connection.
 */
union HubVirtualNetworkConnectionStatus {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Connecting
   */
  Connecting: "Connecting",

  /**
   * Connected
   */
  Connected: "Connected",

  /**
   * NotConnected
   */
  NotConnected: "NotConnected",
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
 * Specifies slot info on a cloud service
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SlotType {
  /**
   * Production
   */
  Production,

  /**
   * Staging
   */
  Staging,
}

/**
 * The current mode enforced, 0 - Disabled, 1 - Alert, 2 -Deny
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum FirewallPolicyIdpsSignatureMode {
  /**
   * 0
   */
  `0`: 0,

  /**
   * 1
   */
  `1`: 1,

  /**
   * 2
   */
  `2`: 2,
}

/**
 * Describes the severity of signature: 1 - High, 2 - Medium, 3 - Low
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum FirewallPolicyIdpsSignatureSeverity {
  /**
   * 1
   */
  `1`: 1,

  /**
   * 2
   */
  `2`: 2,

  /**
   * 3
   */
  `3`: 3,
}

/**
 * Describes in which direction signature is being enforced: 0 - OutBound, 1 - InBound, 2 - Any, 3 - Internal, 4 - InternalOutbound, 5 - InternalInbound
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum FirewallPolicyIdpsSignatureDirection {
  /**
   * 0
   */
  `0`: 0,

  /**
   * 1
   */
  `1`: 1,

  /**
   * 2
   */
  `2`: 2,

  /**
   * 3
   */
  `3`: 3,

  /**
   * 4
   */
  `4`: 4,

  /**
   * 5
   */
  `5`: 5,
}

/**
 * Target type of the resource provided.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum PacketCaptureTargetType {
  /**
   * AzureVM
   */
  AzureVM,

  /**
   * AzureVMSS
   */
  AzureVMSS,
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
 * Properties of the application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayPropertiesFormat {
  /**
   * SKU of the application gateway resource.
   */
  sku?: ApplicationGatewaySku;

  /**
   * SSL policy of the application gateway resource.
   */
  sslPolicy?: ApplicationGatewaySslPolicy;

  /**
   * Operational state of the application gateway resource.
   */
  @visibility(Lifecycle.Read)
  operationalState?: ApplicationGatewayOperationalState;

  /**
   * Subnets of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits).
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  gatewayIPConfigurations?: ApplicationGatewayIPConfiguration[];

  /**
   * Authentication certificates of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits).
   */
  authenticationCertificates?: ApplicationGatewayAuthenticationCertificate[];

  /**
   * Trusted Root certificates of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits).
   */
  trustedRootCertificates?: ApplicationGatewayTrustedRootCertificate[];

  /**
   * Trusted client certificates of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits).
   */
  trustedClientCertificates?: ApplicationGatewayTrustedClientCertificate[];

  /**
   * SSL certificates of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits).
   */
  sslCertificates?: ApplicationGatewaySslCertificate[];

  /**
   * Frontend IP addresses of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits).
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  frontendIPConfigurations?: ApplicationGatewayFrontendIPConfiguration[];

  /**
   * Frontend ports of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits).
   */
  frontendPorts?: ApplicationGatewayFrontendPort[];

  /**
   * Probes of the application gateway resource.
   */
  probes?: ApplicationGatewayProbe[];

  /**
   * Backend address pool of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits).
   */
  backendAddressPools?: ApplicationGatewayBackendAddressPool[];

  /**
   * Backend http settings of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits).
   */
  backendHttpSettingsCollection?: ApplicationGatewayBackendHttpSettings[];

  /**
   * Backend settings of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits).
   */
  backendSettingsCollection?: ApplicationGatewayBackendSettings[];

  /**
   * Http listeners of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits).
   */
  httpListeners?: ApplicationGatewayHttpListener[];

  /**
   * Listeners of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits).
   */
  listeners?: ApplicationGatewayListener[];

  /**
   * SSL profiles of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits).
   */
  sslProfiles?: ApplicationGatewaySslProfile[];

  /**
   * URL path map of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits).
   */
  urlPathMaps?: ApplicationGatewayUrlPathMap[];

  /**
   * Request routing rules of the application gateway resource.
   */
  requestRoutingRules?: ApplicationGatewayRequestRoutingRule[];

  /**
   * Routing rules of the application gateway resource.
   */
  routingRules?: ApplicationGatewayRoutingRule[];

  /**
   * Rewrite rules for the application gateway resource.
   */
  rewriteRuleSets?: ApplicationGatewayRewriteRuleSet[];

  /**
   * Redirect configurations of the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits).
   */
  redirectConfigurations?: ApplicationGatewayRedirectConfiguration[];

  /**
   * Web application firewall configuration.
   */
  webApplicationFirewallConfiguration?: ApplicationGatewayWebApplicationFirewallConfiguration;

  /**
   * Reference to the FirewallPolicy resource.
   */
  firewallPolicy?: SubResource;

  /**
   * Whether HTTP2 is enabled on the application gateway resource.
   */
  enableHttp2?: boolean;

  /**
   * Whether FIPS is enabled on the application gateway resource.
   */
  enableFips?: boolean;

  /**
   * Autoscale Configuration.
   */
  autoscaleConfiguration?: ApplicationGatewayAutoscaleConfiguration;

  /**
   * PrivateLink configurations on application gateway.
   */
  privateLinkConfigurations?: ApplicationGatewayPrivateLinkConfiguration[];

  /**
   * Private Endpoint connections on application gateway.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: ApplicationGatewayPrivateEndpointConnection[];

  /**
   * The resource GUID property of the application gateway resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The provisioning state of the application gateway resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * Custom error configurations of the application gateway resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  customErrorConfigurations?: ApplicationGatewayCustomError[];

  /**
   * If true, associates a firewall policy with an application gateway regardless whether the policy differs from the WAF Config.
   */
  forceFirewallPolicyAssociation?: boolean;

  /**
   * Load distribution policies of the application gateway resource.
   */
  loadDistributionPolicies?: ApplicationGatewayLoadDistributionPolicy[];

  /**
   * Entra JWT validation configurations for the application gateway resource. For default limits, see [Application Gateway limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#application-gateway-limits).
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  entraJWTValidationConfigs?: ApplicationGatewayEntraJWTValidationConfig[];

  /**
   * Global Configuration.
   */
  globalConfiguration?: ApplicationGatewayGlobalConfiguration;

  /**
   * The default predefined SSL Policy applied on the application gateway resource.
   */
  @visibility(Lifecycle.Read)
  defaultPredefinedSslPolicy?: ApplicationGatewaySslPolicyName;
}

/**
 * SKU of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewaySku {
  /**
   * Name of an application gateway SKU.
   */
  name?: ApplicationGatewaySkuName;

  /**
   * Tier of an application gateway.
   */
  tier?: ApplicationGatewayTier;

  /**
   * Capacity (instance count) of an application gateway.
   */
  capacity?: int32;

  /**
   * Family of an application gateway SKU.
   */
  family?: ApplicationGatewaySkuFamily;
}

/**
 * Application Gateway Ssl policy.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewaySslPolicy {
  /**
   * Ssl protocols to be disabled on application gateway.
   */
  disabledSslProtocols?: ApplicationGatewaySslProtocol[];

  /**
   * Type of Ssl Policy.
   */
  policyType?: ApplicationGatewaySslPolicyType;

  /**
   * Name of Ssl predefined policy.
   */
  policyName?: ApplicationGatewaySslPolicyName;

  /**
   * Ssl cipher suites to be enabled in the specified order to application gateway.
   */
  cipherSuites?: ApplicationGatewaySslCipherSuite[];

  /**
   * Minimum version of Ssl protocol to be supported on application gateway.
   */
  minProtocolVersion?: ApplicationGatewaySslProtocol;
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
  provisioningState?: NetworkProvisioningState;
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
 * Reference to another subresource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model ReadOnlySubResourceModel {
  /**
   * Resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Proxy resource representation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model ProxyResource {
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
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Proxy resource representation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model ProxyResourceWithReadOnlyID {
  /**
   * Resource ID.
   */
  @visibility(Lifecycle.Read)
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
}

/**
 * Proxy resource representation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model ProxyResourcewithoutEtag {
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
}

/**
 * Tracked resource with optional location.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model TrackedResourcewithOptionalLocation {
  /**
   * ID of the connection monitor.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Name of the connection monitor.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Connection monitor type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Connection monitor location.
   */
  location?: string;

  /**
   * Connection monitor tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Authentication certificates of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayAuthenticationCertificate extends SubResource {
  /**
   * Properties of the application gateway authentication certificate.
   */
  properties?: ApplicationGatewayAuthenticationCertificatePropertiesFormat;

  /**
   * Name of the authentication certificate that is unique within an Application Gateway.
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
 * Authentication certificates properties of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayAuthenticationCertificatePropertiesFormat {
  /**
   * Certificate public data.
   */
  data?: string;

  /**
   * The provisioning state of the authentication certificate resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Trusted Root certificates of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayTrustedRootCertificate extends SubResource {
  /**
   * Properties of the application gateway trusted root certificate.
   */
  properties?: ApplicationGatewayTrustedRootCertificatePropertiesFormat;

  /**
   * Name of the trusted root certificate that is unique within an Application Gateway.
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
 * Trusted Root certificates properties of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayTrustedRootCertificatePropertiesFormat {
  /**
   * Certificate public data.
   */
  data?: string;

  /**
   * Secret Id of (base-64 encoded unencrypted pfx) 'Secret' or 'Certificate' object stored in KeyVault.
   */
  keyVaultSecretId?: string;

  /**
   * The provisioning state of the trusted root certificate resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Trusted client certificates of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayTrustedClientCertificate extends SubResource {
  /**
   * Properties of the application gateway trusted client certificate.
   */
  properties?: ApplicationGatewayTrustedClientCertificatePropertiesFormat;

  /**
   * Name of the trusted client certificate that is unique within an Application Gateway.
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
 * Trusted client certificates properties of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayTrustedClientCertificatePropertiesFormat {
  /**
   * Certificate public data.
   */
  data?: string;

  /**
   * Validated certificate data.
   */
  @visibility(Lifecycle.Read)
  validatedCertData?: string;

  /**
   * Distinguished name of client certificate issuer.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  clientCertIssuerDN?: string;

  /**
   * The provisioning state of the trusted client certificate resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * SSL certificates of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewaySslCertificate extends SubResource {
  /**
   * Properties of the application gateway SSL certificate.
   */
  properties?: ApplicationGatewaySslCertificatePropertiesFormat;

  /**
   * Name of the SSL certificate that is unique within an Application Gateway.
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
 * Properties of SSL certificates of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewaySslCertificatePropertiesFormat {
  /**
   * Base-64 encoded pfx certificate. Only applicable in PUT Request.
   */
  data?: string;

  /**
   * Password for the pfx file specified in data. Only applicable in PUT request.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  password?: string;

  /**
   * Base-64 encoded Public cert data corresponding to pfx specified in data. Only applicable in GET request.
   */
  @visibility(Lifecycle.Read)
  publicCertData?: string;

  /**
   * Secret Id of (base-64 encoded unencrypted pfx) 'Secret' or 'Certificate' object stored in KeyVault.
   */
  keyVaultSecretId?: string;

  /**
   * The provisioning state of the SSL certificate resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Frontend IP configuration of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayFrontendIPConfiguration extends SubResource {
  /**
   * Properties of the application gateway frontend IP configuration.
   */
  properties?: ApplicationGatewayFrontendIPConfigurationPropertiesFormat;

  /**
   * Name of the frontend IP configuration that is unique within an Application Gateway.
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
 * Properties of Frontend IP configuration of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayFrontendIPConfigurationPropertiesFormat {
  /**
   * PrivateIPAddress of the network interface IP Configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateIPAddress?: string;

  /**
   * The private IP address allocation method.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateIPAllocationMethod?: IPAllocationMethod;

  /**
   * Reference to the subnet resource.
   */
  subnet?: SubResource;

  /**
   * Reference to the PublicIP resource.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicIPAddress?: SubResource;

  /**
   * Reference to the application gateway private link configuration.
   */
  privateLinkConfiguration?: SubResource;

  /**
   * The provisioning state of the frontend IP configuration resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Frontend port of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayFrontendPort extends SubResource {
  /**
   * Properties of the application gateway frontend port.
   */
  properties?: ApplicationGatewayFrontendPortPropertiesFormat;

  /**
   * Name of the frontend port that is unique within an Application Gateway.
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
 * Properties of Frontend port of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayFrontendPortPropertiesFormat {
  /**
   * Frontend port.
   */
  port?: int32;

  /**
   * The provisioning state of the frontend port resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Probe of the application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayProbe extends SubResource {
  /**
   * Properties of the application gateway probe.
   */
  properties?: ApplicationGatewayProbePropertiesFormat;

  /**
   * Name of the probe that is unique within an Application Gateway.
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
 * Properties of probe of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayProbePropertiesFormat {
  /**
   * The protocol used for the probe.
   */
  protocol?: ApplicationGatewayProtocol;

  /**
   * Host name to send the probe to.
   */
  host?: string;

  /**
   * Relative path of probe. Valid path starts from '/'. Probe is sent to <Protocol>://<host>:<port><path>.
   */
  path?: string;

  /**
   * The probing interval in seconds. This is the time interval between two consecutive probes. Acceptable values are from 1 second to 86400 seconds.
   */
  interval?: int32;

  /**
   * The probe timeout in seconds. Probe marked as failed if valid response is not received with this timeout period. Acceptable values are from 1 second to 86400 seconds.
   */
  timeout?: int32;

  /**
   * The probe retry count. Backend server is marked down after consecutive probe failure count reaches UnhealthyThreshold. Acceptable values are from 1 second to 20.
   */
  unhealthyThreshold?: int32;

  /**
   * Whether the host header should be picked from the backend http settings. Default value is false.
   */
  pickHostNameFromBackendHttpSettings?: boolean;

  /**
   * Whether the server name indication should be picked from the backend settings for Tls protocol. Default value is false.
   */
  pickHostNameFromBackendSettings?: boolean;

  /**
   * Minimum number of servers that are always marked healthy. Default value is 0.
   */
  minServers?: int32;

  /**
   * Criterion for classifying a healthy probe response.
   */
  match?: ApplicationGatewayProbeHealthResponseMatch;

  /**
   * Whether to send Proxy Protocol header along with the Health Probe over TCP or TLS protocol. Default value is false.
   */
  enableProbeProxyProtocolHeader?: boolean;

  /**
   * The provisioning state of the probe resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * Custom port which will be used for probing the backend servers. The valid value ranges from 1 to 65535. In case not set, port from http settings will be used. This property is valid for Basic, Standard_v2 and WAF_v2 only.
   */
  @maxValue(65535)
  @minValue(1)
  port?: int32;
}

/**
 * Application gateway probe health response match.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayProbeHealthResponseMatch {
  /**
   * Body that must be contained in the health response. Default value is empty.
   */
  body?: string;

  /**
   * Allowed ranges of healthy status codes. Default range of healthy status codes is 200-399.
   */
  statusCodes?: string[];
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
  backendAddresses?: ApplicationGatewayBackendAddress[];

  /**
   * The provisioning state of the backend address pool resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateIPAddress?: string;

  /**
   * The private IP address prefix length. If specified and the allocation method is dynamic, the service will allocate a CIDR block instead of a single IP address.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @maxValue(128)
  @minValue(1)
  privateIPAddressPrefixLength?: int32 | null;

  /**
   * The private IP address allocation method.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateIPAllocationMethod?: IPAllocationMethod;

  /**
   * Whether the specific IP configuration is IPv4 or IPv6. Default is IPv4.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  provisioningState?: NetworkProvisioningState;

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
  provisioningState?: NetworkProvisioningState;
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicIPAddress?: PublicIPAddress;

  /**
   * The reference to the Public IP Prefix resource.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  provisioningState?: NetworkProvisioningState;
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
  provisioningState?: NetworkProvisioningState;
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
  provisioningState?: NetworkProvisioningState;
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
  provisioningState?: NetworkProvisioningState;

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
 * Properties of the PrivateLinkServiceConnection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PrivateLinkServiceConnectionProperties {
  /**
   * The provisioning state of the private link service connection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

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
  provisioningState?: NetworkProvisioningState;

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
  provisioningState?: NetworkProvisioningState;

  /**
   * Whether the specific IP configuration is IPv4 or IPv6. Default is IPv4.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateIPAddressVersion?: IPVersion;
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
  provisioningState?: NetworkProvisioningState;

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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  provisioningState?: NetworkProvisioningState;
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  provisioningState?: NetworkProvisioningState;

  /**
   * The resource GUID property of the route table.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;
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
  provisioningState?: NetworkProvisioningState;

  /**
   * A value indicating whether this route overrides overlapping BGP routes regardless of LPM.
   */
  @visibility(Lifecycle.Read)
  hasBgpOverride?: boolean;
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
  provisioningState?: NetworkProvisioningState;
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
  provisioningState?: NetworkProvisioningState;

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
  provisioningState?: NetworkProvisioningState;
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
  privateIPAllocationMethod?: IPAllocationMethod = IPAllocationMethod.Dynamic;

  /**
   * The reference to the subnet resource.
   */
  subnet?: Subnet;

  /**
   * The reference to the public IP resource.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
   * The resource GUID property of the NAT gateway resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The provisioning state of the NAT gateway resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * IP configuration profile child resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  provisioningState?: NetworkProvisioningState;
}

/**
 * ResourceNavigationLink resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  provisioningState?: NetworkProvisioningState;
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
  provisioningState?: NetworkProvisioningState;
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
model IpamPoolPrefixAllocationPool {
  /**
   * Resource id of the associated Azure IpamPool resource.
   */
  id?: Azure.Core.armResourceIdentifier;
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
  provisioningState?: NetworkProvisioningState;
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
 * Backend address pool settings of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayBackendHttpSettings extends SubResource {
  /**
   * Properties of the application gateway backend HTTP settings.
   */
  properties?: ApplicationGatewayBackendHttpSettingsPropertiesFormat;

  /**
   * Name of the backend http settings that is unique within an Application Gateway.
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
 * Properties of Backend address pool settings of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayBackendHttpSettingsPropertiesFormat {
  /**
   * The destination port on the backend.
   */
  port?: int32;

  /**
   * The protocol used to communicate with the backend.
   */
  protocol?: ApplicationGatewayProtocol;

  /**
   * Cookie based affinity.
   */
  cookieBasedAffinity?: ApplicationGatewayCookieBasedAffinity;

  /**
   * Request timeout in seconds. Application Gateway will fail the request if response is not received within RequestTimeout. Acceptable values are from 1 second to 86400 seconds.
   */
  requestTimeout?: int32;

  /**
   * Probe resource of an application gateway.
   */
  probe?: SubResource;

  /**
   * Array of references to application gateway authentication certificates.
   */
  authenticationCertificates?: SubResource[];

  /**
   * Array of references to application gateway trusted root certificates.
   */
  trustedRootCertificates?: SubResource[];

  /**
   * Connection draining of the backend http settings resource.
   */
  connectionDraining?: ApplicationGatewayConnectionDraining;

  /**
   * Host header to be sent to the backend servers.
   */
  hostName?: string;

  /**
   * Whether to pick host header should be picked from the host name of the backend server. Default value is false.
   */
  pickHostNameFromBackendAddress?: boolean;

  /**
   * Cookie name to use for the affinity cookie.
   */
  affinityCookieName?: string;

  /**
   * Whether the probe is enabled. Default value is false.
   */
  probeEnabled?: boolean;

  /**
   * Path which should be used as a prefix for all HTTP requests. Null means no path will be prefixed. Default value is null.
   */
  path?: string;

  /**
   * Enable or disable dedicated connection per backend server. Default is set to false.
   */
  dedicatedBackendConnection?: boolean;

  /**
   * Verify or skip both chain and expiry validations of the certificate on the backend server. Default is set to true.
   */
  validateCertChainAndExpiry?: boolean = true;

  /**
   * When enabled, verifies if the Common Name of the certificate provided by the backend server matches the Server Name Indication (SNI) value. Default value is true.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  validateSNI?: boolean = true;

  /**
   * Specify an SNI value to match the common name of the certificate on the backend. By default, the application gateway uses the incoming request’s host header as the SNI. Default value is null.
   */
  sniName?: string;

  /**
   * The provisioning state of the backend HTTP settings resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Connection draining allows open connections to a backend server to be active for a specified time after the backend server got removed from the configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayConnectionDraining {
  /**
   * Whether connection draining is enabled or not.
   */
  enabled: boolean;

  /**
   * The number of seconds connection draining is active. Acceptable values are from 1 second to 3600 seconds.
   */
  @maxValue(3600)
  @minValue(1)
  drainTimeoutInSec: int32;
}

/**
 * Backend address pool settings of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayBackendSettings extends SubResource {
  /**
   * Properties of the application gateway backend settings.
   */
  properties?: ApplicationGatewayBackendSettingsPropertiesFormat;

  /**
   * Name of the backend settings that is unique within an Application Gateway.
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
 * Properties of Backend address pool settings of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayBackendSettingsPropertiesFormat {
  /**
   * The destination port on the backend.
   */
  port?: int32;

  /**
   * The protocol used to communicate with the backend.
   */
  protocol?: ApplicationGatewayProtocol;

  /**
   * Connection timeout in seconds. Application Gateway will fail the request if response is not received within ConnectionTimeout. Acceptable values are from 1 second to 86400 seconds.
   */
  timeout?: int32;

  /**
   * Probe resource of an application gateway.
   */
  probe?: SubResource;

  /**
   * Array of references to application gateway trusted root certificates.
   */
  trustedRootCertificates?: SubResource[];

  /**
   * Server name indication to be sent to the backend servers for Tls protocol.
   */
  hostName?: string;

  /**
   * Whether to pick server name indication from the host name of the backend server for Tls protocol. Default value is false.
   */
  pickHostNameFromBackendAddress?: boolean;

  /**
   * Whether to send Proxy Protocol header to backend servers over TCP or TLS protocols. Default value is false.
   */
  enableL4ClientIpPreservation?: boolean;

  /**
   * The provisioning state of the backend HTTP settings resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Http listener of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayHttpListener extends SubResource {
  /**
   * Properties of the application gateway HTTP listener.
   */
  properties?: ApplicationGatewayHttpListenerPropertiesFormat;

  /**
   * Name of the HTTP listener that is unique within an Application Gateway.
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
 * Properties of HTTP listener of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayHttpListenerPropertiesFormat {
  /**
   * Frontend IP configuration resource of an application gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  frontendIPConfiguration?: SubResource;

  /**
   * Frontend port resource of an application gateway.
   */
  frontendPort?: SubResource;

  /**
   * Protocol of the HTTP listener.
   */
  protocol?: ApplicationGatewayProtocol;

  /**
   * Host name of HTTP listener.
   */
  hostName?: string;

  /**
   * SSL certificate resource of an application gateway.
   */
  sslCertificate?: SubResource;

  /**
   * SSL profile resource of the application gateway.
   */
  sslProfile?: SubResource;

  /**
   * Applicable only if protocol is https. Enables SNI for multi-hosting.
   */
  requireServerNameIndication?: boolean;

  /**
   * The provisioning state of the HTTP listener resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * Custom error configurations of the HTTP listener.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  customErrorConfigurations?: ApplicationGatewayCustomError[];

  /**
   * Reference to the FirewallPolicy resource.
   */
  firewallPolicy?: SubResource;

  /**
   * List of Host names for HTTP Listener that allows special wildcard characters as well.
   */
  hostNames?: string[];
}

/**
 * Custom error of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayCustomError {
  /**
   * Status code of the application gateway custom error.
   */
  statusCode?: ApplicationGatewayCustomErrorStatusCode;

  /**
   * Error page URL of the application gateway custom error.
   */
  customErrorPageUrl?: string;
}

/**
 * Listener of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayListener extends SubResource {
  /**
   * Properties of the application gateway listener.
   */
  properties?: ApplicationGatewayListenerPropertiesFormat;

  /**
   * Name of the listener that is unique within an Application Gateway.
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
 * Properties of listener of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayListenerPropertiesFormat {
  /**
   * Frontend IP configuration resource of an application gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  frontendIPConfiguration?: SubResource;

  /**
   * Frontend port resource of an application gateway.
   */
  frontendPort?: SubResource;

  /**
   * Protocol of the listener.
   */
  protocol?: ApplicationGatewayProtocol;

  /**
   * SSL certificate resource of an application gateway.
   */
  sslCertificate?: SubResource;

  /**
   * SSL profile resource of the application gateway.
   */
  sslProfile?: SubResource;

  /**
   * The provisioning state of the listener resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * List of Server Name Indications(SNI) for TLS Multi-site Listener that allows special wildcard characters as well.
   */
  hostNames?: string[];
}

/**
 * SSL profile of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewaySslProfile extends SubResource {
  /**
   * Properties of the application gateway SSL profile.
   */
  properties?: ApplicationGatewaySslProfilePropertiesFormat;

  /**
   * Name of the SSL profile that is unique within an Application Gateway.
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
 * Properties of SSL profile of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewaySslProfilePropertiesFormat {
  /**
   * Array of references to application gateway trusted client certificates.
   */
  trustedClientCertificates?: SubResource[];

  /**
   * SSL policy of the application gateway resource.
   */
  sslPolicy?: ApplicationGatewaySslPolicy;

  /**
   * Client authentication configuration of the application gateway resource.
   */
  clientAuthConfiguration?: ApplicationGatewayClientAuthConfiguration;

  /**
   * The provisioning state of the HTTP listener resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Application gateway client authentication configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayClientAuthConfiguration {
  /**
   * Verify client certificate issuer name on the application gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  verifyClientCertIssuerDN?: boolean;

  /**
   * Verify client certificate revocation status.
   */
  verifyClientRevocation?: ApplicationGatewayClientRevocationOptions;

  /**
   * Verify client Authentication mode.
   */
  verifyClientAuthMode?: ApplicationGatewayClientAuthVerificationModes;
}

/**
 * UrlPathMaps give a url path to the backend mapping information for PathBasedRouting.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayUrlPathMap extends SubResource {
  /**
   * Properties of the application gateway URL path map.
   */
  properties?: ApplicationGatewayUrlPathMapPropertiesFormat;

  /**
   * Name of the URL path map that is unique within an Application Gateway.
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
 * Properties of UrlPathMap of the application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayUrlPathMapPropertiesFormat {
  /**
   * Default backend address pool resource of URL path map.
   */
  defaultBackendAddressPool?: SubResource;

  /**
   * Default backend http settings resource of URL path map.
   */
  defaultBackendHttpSettings?: SubResource;

  /**
   * Default Rewrite rule set resource of URL path map.
   */
  defaultRewriteRuleSet?: SubResource;

  /**
   * Default redirect configuration resource of URL path map.
   */
  defaultRedirectConfiguration?: SubResource;

  /**
   * Default Load Distribution Policy resource of URL path map.
   */
  defaultLoadDistributionPolicy?: SubResource;

  /**
   * Path rule of URL path map resource.
   */
  pathRules?: ApplicationGatewayPathRule[];

  /**
   * The provisioning state of the URL path map resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Path rule of URL path map of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayPathRule extends SubResource {
  /**
   * Properties of the application gateway path rule.
   */
  properties?: ApplicationGatewayPathRulePropertiesFormat;

  /**
   * Name of the path rule that is unique within an Application Gateway.
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
 * Properties of path rule of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayPathRulePropertiesFormat {
  /**
   * Path rules of URL path map.
   */
  paths?: string[];

  /**
   * Backend address pool resource of URL path map path rule.
   */
  backendAddressPool?: SubResource;

  /**
   * Backend http settings resource of URL path map path rule.
   */
  backendHttpSettings?: SubResource;

  /**
   * Redirect configuration resource of URL path map path rule.
   */
  redirectConfiguration?: SubResource;

  /**
   * Rewrite rule set resource of URL path map path rule.
   */
  rewriteRuleSet?: SubResource;

  /**
   * Load Distribution Policy resource of URL path map path rule.
   */
  loadDistributionPolicy?: SubResource;

  /**
   * The provisioning state of the path rule resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * Reference to the FirewallPolicy resource.
   */
  firewallPolicy?: SubResource;
}

/**
 * Request routing rule of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayRequestRoutingRule extends SubResource {
  /**
   * Properties of the application gateway request routing rule.
   */
  properties?: ApplicationGatewayRequestRoutingRulePropertiesFormat;

  /**
   * Name of the request routing rule that is unique within an Application Gateway.
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
 * Properties of request routing rule of the application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayRequestRoutingRulePropertiesFormat {
  /**
   * Rule type.
   */
  ruleType?: ApplicationGatewayRequestRoutingRuleType;

  /**
   * Priority of the request routing rule.
   */
  @maxValue(20000)
  @minValue(1)
  priority?: int32;

  /**
   * Backend address pool resource of the application gateway.
   */
  backendAddressPool?: SubResource;

  /**
   * Backend http settings resource of the application gateway.
   */
  backendHttpSettings?: SubResource;

  /**
   * Http listener resource of the application gateway.
   */
  httpListener?: SubResource;

  /**
   * URL path map resource of the application gateway.
   */
  urlPathMap?: SubResource;

  /**
   * Rewrite Rule Set resource in Basic rule of the application gateway.
   */
  rewriteRuleSet?: SubResource;

  /**
   * Redirect configuration resource of the application gateway.
   */
  redirectConfiguration?: SubResource;

  /**
   * Load Distribution Policy resource of the application gateway.
   */
  loadDistributionPolicy?: SubResource;

  /**
   * Entra JWT validation configuration resource of the application gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  entraJWTValidationConfig?: SubResource;

  /**
   * The provisioning state of the request routing rule resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Routing rule of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayRoutingRule extends SubResource {
  /**
   * Properties of the application gateway routing rule.
   */
  properties?: ApplicationGatewayRoutingRulePropertiesFormat;

  /**
   * Name of the routing rule that is unique within an Application Gateway.
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
 * Properties of routing rule of the application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayRoutingRulePropertiesFormat {
  /**
   * Rule type.
   */
  ruleType?: ApplicationGatewayRequestRoutingRuleType;

  /**
   * Priority of the routing rule.
   */
  @maxValue(20000)
  @minValue(1)
  priority: int32;

  /**
   * Backend address pool resource of the application gateway.
   */
  backendAddressPool?: SubResource;

  /**
   * Backend settings resource of the application gateway.
   */
  backendSettings?: SubResource;

  /**
   * Listener resource of the application gateway.
   */
  listener?: SubResource;

  /**
   * The provisioning state of the request routing rule resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Rewrite rule set of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayRewriteRuleSet extends SubResource {
  /**
   * Properties of the application gateway rewrite rule set.
   */
  properties?: ApplicationGatewayRewriteRuleSetPropertiesFormat;

  /**
   * Name of the rewrite rule set that is unique within an Application Gateway.
   */
  name?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Properties of rewrite rule set of the application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayRewriteRuleSetPropertiesFormat {
  /**
   * Rewrite rules in the rewrite rule set.
   */
  rewriteRules?: ApplicationGatewayRewriteRule[];

  /**
   * The provisioning state of the rewrite rule set resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Rewrite rule of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayRewriteRule {
  /**
   * Name of the rewrite rule that is unique within an Application Gateway.
   */
  name?: string;

  /**
   * Rule Sequence of the rewrite rule that determines the order of execution of a particular rule in a RewriteRuleSet.
   */
  ruleSequence?: int32;

  /**
   * Conditions based on which the action set execution will be evaluated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  conditions?: ApplicationGatewayRewriteRuleCondition[];

  /**
   * Set of actions to be done as part of the rewrite Rule.
   */
  actionSet?: ApplicationGatewayRewriteRuleActionSet;
}

/**
 * Set of conditions in the Rewrite Rule in Application Gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayRewriteRuleCondition {
  /**
   * The condition parameter of the RewriteRuleCondition.
   */
  variable?: string;

  /**
   * The pattern, either fixed string or regular expression, that evaluates the truthfulness of the condition.
   */
  pattern?: string;

  /**
   * Setting this parameter to truth value with force the pattern to do a case in-sensitive comparison.
   */
  ignoreCase?: boolean;

  /**
   * Setting this value as truth will force to check the negation of the condition given by the user.
   */
  negate?: boolean;
}

/**
 * Set of actions in the Rewrite Rule in Application Gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayRewriteRuleActionSet {
  /**
   * Request Header Actions in the Action Set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  requestHeaderConfigurations?: ApplicationGatewayHeaderConfiguration[];

  /**
   * Response Header Actions in the Action Set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  responseHeaderConfigurations?: ApplicationGatewayHeaderConfiguration[];

  /**
   * Url Configuration Action in the Action Set.
   */
  urlConfiguration?: ApplicationGatewayUrlConfiguration;
}

/**
 * Header configuration of the Actions set in Application Gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayHeaderConfiguration {
  /**
   * Header name of the header configuration.
   */
  headerName?: string;

  /**
   * An optional field under "Rewrite Action". It lets you capture and modify the value(s) of a specific header when multiple headers with the same name exist. Currently supported for Set-Cookie Response header only. For more details, visit https://aka.ms/appgwheadercrud
   */
  headerValueMatcher?: HeaderValueMatcher;

  /**
   * Header value of the header configuration.
   */
  headerValue?: string;
}

/**
 * An optional field under "Rewrite Action". It lets you capture and modify the value(s) of a specific header when multiple headers with the same name exist. Currently supported for Set-Cookie Response header only. For more details, visit https://aka.ms/appgwheadercrud
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model HeaderValueMatcher {
  /**
   * The pattern, either fixed string or regular expression, that evaluates if a header value should be selected for rewrite.
   */
  pattern?: string;

  /**
   * Setting this parameter to truth value with force the pattern to do a case in-sensitive comparison.
   */
  ignoreCase?: boolean;

  /**
   * Setting this value as truth will force to check the negation of the condition given by the user in the pattern field.
   */
  negate?: boolean;
}

/**
 * Url configuration of the Actions set in Application Gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayUrlConfiguration {
  /**
   * Url path which user has provided for url rewrite. Null means no path will be updated. Default value is null.
   */
  modifiedPath?: string;

  /**
   * Query string which user has provided for url rewrite. Null means no query string will be updated. Default value is null.
   */
  modifiedQueryString?: string;

  /**
   * If set as true, it will re-evaluate the url path map provided in path based request routing rules using modified path. Default value is false.
   */
  reroute?: boolean;
}

/**
 * Redirect configuration of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayRedirectConfiguration extends SubResource {
  /**
   * Properties of the application gateway redirect configuration.
   */
  properties?: ApplicationGatewayRedirectConfigurationPropertiesFormat;

  /**
   * Name of the redirect configuration that is unique within an Application Gateway.
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
 * Properties of redirect configuration of the application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayRedirectConfigurationPropertiesFormat {
  /**
   * HTTP redirection type.
   */
  redirectType?: ApplicationGatewayRedirectType;

  /**
   * Reference to a listener to redirect the request to.
   */
  targetListener?: SubResource;

  /**
   * Url to redirect the request to.
   */
  targetUrl?: string;

  /**
   * Include path in the redirected url.
   */
  includePath?: boolean;

  /**
   * Include query string in the redirected url.
   */
  includeQueryString?: boolean;

  /**
   * Request routing specifying redirect configuration.
   */
  requestRoutingRules?: SubResource[];

  /**
   * Url path maps specifying default redirect configuration.
   */
  urlPathMaps?: SubResource[];

  /**
   * Path rules specifying redirect configuration.
   */
  pathRules?: SubResource[];
}

/**
 * Application gateway web application firewall configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayWebApplicationFirewallConfiguration {
  /**
   * Whether the web application firewall is enabled or not.
   */
  enabled: boolean;

  /**
   * Web application firewall mode.
   */
  firewallMode: ApplicationGatewayFirewallMode;

  /**
   * The type of the web application firewall rule set. Possible values are: 'OWASP'.
   */
  ruleSetType: string;

  /**
   * The version of the rule set type.
   */
  ruleSetVersion: string;

  /**
   * The disabled rule groups.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disabledRuleGroups?: ApplicationGatewayFirewallDisabledRuleGroup[];

  /**
   * Whether allow WAF to check request Body.
   */
  requestBodyCheck?: boolean;

  /**
   * Maximum request body size for WAF.
   */
  @maxValue(128)
  @minValue(8)
  maxRequestBodySize?: int32;

  /**
   * Maximum request body size in Kb for WAF.
   */
  @maxValue(128)
  @minValue(8)
  maxRequestBodySizeInKb?: int32;

  /**
   * Maximum file upload size in Mb for WAF.
   */
  @minValue(0)
  fileUploadLimitInMb?: int32;

  /**
   * The exclusion list.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  exclusions?: ApplicationGatewayFirewallExclusion[];
}

/**
 * Allows to disable rules within a rule group or an entire rule group.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayFirewallDisabledRuleGroup {
  /**
   * The name of the rule group that will be disabled.
   */
  ruleGroupName: string;

  /**
   * The list of rules that will be disabled. If null, all rules of the rule group will be disabled.
   */
  rules?: int32[];
}

/**
 * Allow to exclude some variable satisfy the condition for the WAF check.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayFirewallExclusion {
  /**
   * The variable to be excluded.
   */
  matchVariable: string;

  /**
   * When matchVariable is a collection, operate on the selector to specify which elements in the collection this exclusion applies to.
   */
  selectorMatchOperator: string;

  /**
   * When matchVariable is a collection, operator used to specify which elements in the collection this exclusion applies to.
   */
  selector: string;
}

/**
 * Application Gateway autoscale configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayAutoscaleConfiguration {
  /**
   * Lower bound on number of Application Gateway capacity.
   */
  @minValue(0)
  minCapacity: int32;

  /**
   * Upper bound on number of Application Gateway capacity.
   */
  @minValue(2)
  maxCapacity?: int32;
}

/**
 * Private Link Configuration on an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayPrivateLinkConfiguration extends SubResource {
  /**
   * Properties of the application gateway private link configuration.
   */
  properties?: ApplicationGatewayPrivateLinkConfigurationProperties;

  /**
   * Name of the private link configuration that is unique within an Application Gateway.
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
 * Properties of private link configuration on an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayPrivateLinkConfigurationProperties {
  /**
   * An array of application gateway private link ip configurations.
   */
  ipConfigurations?: ApplicationGatewayPrivateLinkIpConfiguration[];

  /**
   * The provisioning state of the application gateway private link configuration.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * The application gateway private link ip configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayPrivateLinkIpConfiguration extends SubResource {
  /**
   * Properties of an application gateway private link ip configuration.
   */
  properties?: ApplicationGatewayPrivateLinkIpConfigurationProperties;

  /**
   * The name of application gateway private link ip configuration.
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
 * Properties of an application gateway private link IP configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayPrivateLinkIpConfigurationProperties {
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
   * Reference to the subnet resource.
   */
  subnet?: SubResource;

  /**
   * Whether the ip configuration is primary or not.
   */
  primary?: boolean;

  /**
   * The provisioning state of the application gateway private link IP configuration.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Properties of Private Link Resource of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayPrivateEndpointConnectionProperties {
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
   * The provisioning state of the application gateway private endpoint connection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The consumer link id.
   */
  @visibility(Lifecycle.Read)
  linkIdentifier?: string;
}

/**
 * Load Distribution Policy of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayLoadDistributionPolicy extends SubResource {
  /**
   * Properties of the application gateway load distribution policy.
   */
  properties?: ApplicationGatewayLoadDistributionPolicyPropertiesFormat;

  /**
   * Name of the load distribution policy that is unique within an Application Gateway.
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
 * Properties of Load Distribution Policy of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayLoadDistributionPolicyPropertiesFormat {
  /**
   * Load Distribution Targets resource of an application gateway.
   */
  loadDistributionTargets?: ApplicationGatewayLoadDistributionTarget[];

  /**
   * Load Distribution Targets resource of an application gateway.
   */
  loadDistributionAlgorithm?: ApplicationGatewayLoadDistributionAlgorithm;

  /**
   * The provisioning state of the Load Distribution Policy resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Load Distribution Target of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayLoadDistributionTarget extends SubResource {
  /**
   * Properties of the application gateway load distribution target.
   */
  properties?: ApplicationGatewayLoadDistributionTargetPropertiesFormat;

  /**
   * Name of the load distribution policy that is unique within an Application Gateway.
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayLoadDistributionTargetPropertiesFormat {
  /**
   * Weight per server. Range between 1 and 100.
   */
  @maxValue(100)
  @minValue(1)
  weightPerServer?: int32;

  /**
   * Backend address pool resource of the application gateway.
   */
  backendAddressPool?: SubResource;
}

/**
 * Entra JWT Validation Configuration of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayEntraJWTValidationConfig extends SubResource {
  /**
   * Properties of the application gateway entra jwt validation configuration.
   */
  properties?: ApplicationGatewayEntraJWTValidationConfigPropertiesFormat;

  /**
   * Name of the entra jwt validation configuration that is unique within an application gateway.
   */
  name?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Properties of entra jwt validation configuration of the application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayEntraJWTValidationConfigPropertiesFormat {
  /**
   * Unauthorized request action.
   */
  unAuthorizedRequestAction?: ApplicationGatewayUnAuthorizedRequestAction;

  /**
   * The Tenant ID of the Microsoft Entra ID application.
   */
  tenantId?: string;

  /**
   * The Client ID of the Microsoft Entra ID application.
   */
  clientId?: string;

  /**
   * List of acceptable audience claims that can be present in the token (aud claim). A maximum of 5 audiences are permitted.
   */
  audiences?: string[];

  /**
   * The provisioning state of the entra jwt validation configuration resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Application Gateway global configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayGlobalConfiguration {
  /**
   * Enable request buffering.
   */
  enableRequestBuffering?: boolean;

  /**
   * Enable response buffering.
   */
  enableResponseBuffering?: boolean;
}

/**
 * Tags object for patch operations.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TagsObject {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Response for ApplicationGatewayBackendHealth API service call.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayBackendHealth {
  /**
   * A list of ApplicationGatewayBackendHealthPool resources.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  backendAddressPools?: ApplicationGatewayBackendHealthPool[];
}

/**
 * Application gateway BackendHealth pool.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayBackendHealthPool {
  /**
   * Reference to an ApplicationGatewayBackendAddressPool resource.
   */
  backendAddressPool?: ApplicationGatewayBackendAddressPool;

  /**
   * List of ApplicationGatewayBackendHealthHttpSettings resources.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  backendHttpSettingsCollection?: ApplicationGatewayBackendHealthHttpSettings[];
}

/**
 * Application gateway BackendHealthHttp settings.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayBackendHealthHttpSettings {
  /**
   * Reference to an ApplicationGatewayBackendHttpSettings resource.
   */
  backendHttpSettings?: ApplicationGatewayBackendHttpSettings;

  /**
   * List of ApplicationGatewayBackendHealthServer resources.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  servers?: ApplicationGatewayBackendHealthServer[];
}

/**
 * Application gateway backendhealth http settings.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayBackendHealthServer {
  /**
   * IP address or FQDN of backend server.
   */
  address?: string;

  /**
   * Reference to IP configuration of backend server.
   */
  ipConfiguration?: NetworkInterfaceIPConfiguration;

  /**
   * Health of backend server.
   */
  health?: ApplicationGatewayBackendHealthServerHealth;

  /**
   * Health Probe Log.
   */
  healthProbeLog?: string;
}

/**
 * Details of on demand test probe request.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayOnDemandProbe {
  /**
   * The protocol used for the probe.
   */
  protocol?: ApplicationGatewayProtocol;

  /**
   * Host name to send the probe to.
   */
  host?: string;

  /**
   * Relative path of probe. Valid path starts from '/'. Probe is sent to <Protocol>://<host>:<port><path>.
   */
  path?: string;

  /**
   * The probe timeout in seconds. Probe marked as failed if valid response is not received with this timeout period. Acceptable values are from 1 second to 86400 seconds.
   */
  timeout?: int32;

  /**
   * Whether the host header should be picked from the backend http settings. Default value is false.
   */
  pickHostNameFromBackendHttpSettings?: boolean;

  /**
   * Whether to send Proxy Protocol header along with the Health Probe over TCP or TLS protocol. Default value is false.
   */
  enableProbeProxyProtocolHeader?: boolean;

  /**
   * Criterion for classifying a healthy probe response.
   */
  match?: ApplicationGatewayProbeHealthResponseMatch;

  /**
   * Reference to backend pool of application gateway to which probe request will be sent.
   */
  backendAddressPool?: SubResource;

  /**
   * Reference to backend http setting of application gateway to be used for test probe.
   */
  backendHttpSettings?: SubResource;
}

/**
 * Result of on demand test probe.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayBackendHealthOnDemand {
  /**
   * Reference to an ApplicationGatewayBackendAddressPool resource.
   */
  backendAddressPool?: ApplicationGatewayBackendAddressPool;

  /**
   * Application gateway BackendHealthHttp settings.
   */
  backendHealthHttpSettings?: ApplicationGatewayBackendHealthHttpSettings;
}

/**
 * PrivateLink Resource of an application gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayPrivateLinkResource extends SubResource {
  /**
   * Properties of the application gateway private link resource.
   */
  properties?: ApplicationGatewayPrivateLinkResourceProperties;

  /**
   * Name of the private link resource that is unique within an Application Gateway.
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
 * Properties of a private link resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayPrivateLinkResourceProperties {
  /**
   * Group identifier of private link resource.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * Required member names of private link resource.
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * Required DNS zone names of the the private link resource.
   */
  requiredZoneNames?: string[];
}

/**
 * Common error representation.
 */
@error
model Error {
  /**
   * Error code.
   */
  code?: string;

  /**
   * Error message.
   */
  message?: string;

  /**
   * Error target.
   */
  target?: string;

  /**
   * Error details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  details?: ErrorDetails[];

  /**
   * Inner error message.
   */
  innerError?: string;
}

/**
 * Common error details representation.
 */
model ErrorDetails {
  /**
   * Error code.
   */
  code?: string;

  /**
   * Error target.
   */
  target?: string;

  /**
   * Error message.
   */
  message?: string;
}

/**
 * Response for ApplicationGatewayAvailableWafRuleSets API service call.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayAvailableWafRuleSetsResult {
  /**
   * The list of application gateway rule sets.
   */
  value?: ApplicationGatewayFirewallRuleSet[];
}

/**
 * A web application firewall rule set.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayFirewallRuleSet extends Resource {
  /**
   * Properties of the application gateway firewall rule set.
   */
  properties?: ApplicationGatewayFirewallRuleSetPropertiesFormat;
}

/**
 * Properties of the web application firewall rule set.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayFirewallRuleSetPropertiesFormat {
  /**
   * The provisioning state of the web application firewall rule set.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The type of the web application firewall rule set.
   */
  ruleSetType: string;

  /**
   * The version of the web application firewall rule set type.
   */
  ruleSetVersion: string;

  /**
   * The rule groups of the web application firewall rule set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ruleGroups: ApplicationGatewayFirewallRuleGroup[];

  /**
   * Tier of an application gateway that support the rule set.
   */
  tiers?: ApplicationGatewayTierTypes[];
}

/**
 * A web application firewall rule group.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayFirewallRuleGroup {
  /**
   * The name of the web application firewall rule group.
   */
  ruleGroupName: string;

  /**
   * The description of the web application firewall rule group.
   */
  description?: string;

  /**
   * The rules of the web application firewall rule group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rules: ApplicationGatewayFirewallRule[];
}

/**
 * A web application firewall rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayFirewallRule {
  /**
   * The identifier of the web application firewall rule.
   */
  ruleId: int32;

  /**
   * The string representation of the web application firewall rule identifier.
   */
  ruleIdString?: string;

  /**
   * The string representation of the web application firewall rule state.
   */
  state?: ApplicationGatewayWafRuleStateTypes;

  /**
   * The string representation of the web application firewall rule action.
   */
  action?: ApplicationGatewayWafRuleActionTypes;

  /**
   * The string representation of the web application firewall rule sensitivity.
   */
  sensitivity?: ApplicationGatewayWafRuleSensitivityTypes;

  /**
   * The description of the web application firewall rule.
   */
  description?: string;
}

/**
 * Properties of ApplicationGatewayAvailableSslOptions.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayAvailableSslOptionsPropertiesFormat {
  /**
   * List of available Ssl predefined policy.
   */
  predefinedPolicies?: SubResource[];

  /**
   * Name of the Ssl predefined policy applied by default to application gateway.
   */
  defaultPolicy?: ApplicationGatewaySslPolicyName;

  /**
   * List of available Ssl cipher suites.
   */
  availableCipherSuites?: ApplicationGatewaySslCipherSuite[];

  /**
   * List of available Ssl protocols.
   */
  availableProtocols?: ApplicationGatewaySslProtocol[];
}

/**
 * Response for ApplicationGatewayAvailableSslOptions API service call.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayAvailableSslPredefinedPolicies
  is Azure.Core.Page<ApplicationGatewaySslPredefinedPolicy>;

/**
 * An Ssl predefined policy.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewaySslPredefinedPolicy extends SubResource {
  /**
   * Name of the Ssl predefined policy.
   */
  name?: string;

  /**
   * Properties of the application gateway SSL predefined policy.
   */
  properties?: ApplicationGatewaySslPredefinedPolicyPropertiesFormat;
}

/**
 * Properties of ApplicationGatewaySslPredefinedPolicy.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewaySslPredefinedPolicyPropertiesFormat {
  /**
   * Ssl cipher suites to be enabled in the specified order for application gateway.
   */
  cipherSuites?: ApplicationGatewaySslCipherSuite[];

  /**
   * Minimum version of Ssl protocol to be supported on application gateway.
   */
  minProtocolVersion?: ApplicationGatewaySslProtocol;
}

/**
 * Properties of ApplicationGatewayWafDynamicManifest.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayWafDynamicManifestPropertiesResult {
  /**
   * The default ruleset.
   */
  defaultRuleSet?: DefaultRuleSetPropertyFormat;

  /**
   * The available rulesets.
   */
  @identifiers(#[])
  availableRuleSets?: ApplicationGatewayFirewallManifestRuleSet[];
}

/**
 * the default web application firewall rule set.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model DefaultRuleSetPropertyFormat {
  /**
   * The type of the web application firewall rule set.
   */
  ruleSetType?: string;

  /**
   * The version of the web application firewall rule set type.
   */
  ruleSetVersion?: string;
}

/**
 * Properties of the web application firewall rule set.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayFirewallManifestRuleSet {
  /**
   * The type of the web application firewall rule set.
   */
  ruleSetType: string;

  /**
   * The version of the web application firewall rule set type.
   */
  ruleSetVersion: string;

  /**
   * The rule set status
   */
  status?: ApplicationGatewayRuleSetStatusOptions;

  /**
   * Tier of an application gateway that support the rule set.
   */
  tiers?: ApplicationGatewayTierTypes[];

  /**
   * The rule groups of the web application firewall rule set.
   */
  @identifiers(#[])
  ruleGroups: ApplicationGatewayFirewallRuleGroup[];
}

/**
 * Response for ApplicationGatewayWafDynamicManifests API service call.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayWafDynamicManifestResultList
  is Azure.Core.Page<ApplicationGatewayWafDynamicManifestResult>;

/**
 * An array of available delegations.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model AvailableDelegationsResult is Azure.Core.Page<AvailableDelegation>;

/**
 * The serviceName of an AvailableDelegation indicates a possible delegation for a subnet.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model AvailableDelegation {
  /**
   * The name of the AvailableDelegation resource.
   */
  name?: string;

  /**
   * A unique identifier of the AvailableDelegation resource.
   */
  id?: string;

  /**
   * Resource type.
   */
  type?: string;

  /**
   * The name of the service and resource.
   */
  serviceName?: string;

  /**
   * The actions permitted to the service upon delegation.
   */
  actions?: string[];
}

/**
 * An array of available service aliases.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model AvailableServiceAliasesResult is Azure.Core.Page<AvailableServiceAlias>;

/**
 * The available service alias.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model AvailableServiceAlias {
  /**
   * The name of the service alias.
   */
  name?: string;

  /**
   * The ID of the service alias.
   */
  id?: string;

  /**
   * The type of the resource.
   */
  type?: string;

  /**
   * The resource name of the service alias.
   */
  resourceName?: string;
}

/**
 * Properties of the Azure Firewall.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallPropertiesFormat {
  /**
   * Collection of application rule collections used by Azure Firewall.
   */
  applicationRuleCollections?: AzureFirewallApplicationRuleCollection[];

  /**
   * Collection of NAT rule collections used by Azure Firewall.
   */
  natRuleCollections?: AzureFirewallNatRuleCollection[];

  /**
   * Collection of network rule collections used by Azure Firewall.
   */
  networkRuleCollections?: AzureFirewallNetworkRuleCollection[];

  /**
   * IP configuration of the Azure Firewall resource.
   */
  ipConfigurations?: AzureFirewallIPConfiguration[];

  /**
   * IP configuration of the Azure Firewall used for management traffic.
   */
  managementIpConfiguration?: AzureFirewallIPConfiguration;

  /**
   * The provisioning state of the Azure firewall resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The operation mode for Threat Intelligence.
   */
  threatIntelMode?: AzureFirewallThreatIntelMode;

  /**
   * The virtualHub to which the firewall belongs.
   */
  virtualHub?: SubResource;

  /**
   * The firewallPolicy associated with this azure firewall.
   */
  firewallPolicy?: SubResource;

  /**
   * IP addresses associated with AzureFirewall.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  hubIPAddresses?: HubIPAddresses;

  /**
   * IpGroups associated with AzureFirewall.
   */
  @visibility(Lifecycle.Read)
  ipGroups?: AzureFirewallIPGroups[];

  /**
   * The Azure Firewall Resource SKU.
   */
  sku?: AzureFirewallSku;

  /**
   * The additional properties used to further config this azure firewall.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalProperties?: Record<string>;

  /**
   * Properties to provide a custom autoscale configuration to this azure firewall.
   */
  autoscaleConfiguration?: AzureFirewallAutoscaleConfiguration;
}

/**
 * Application rule collection resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallApplicationRuleCollection extends SubResource {
  /**
   * Properties of the azure firewall application rule collection.
   */
  properties?: AzureFirewallApplicationRuleCollectionPropertiesFormat;

  /**
   * The name of the resource that is unique within the Azure firewall. This name can be used to access the resource.
   */
  name?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Properties of the application rule collection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallApplicationRuleCollectionPropertiesFormat {
  /**
   * Priority of the application rule collection resource.
   */
  @maxValue(65000)
  @minValue(100)
  priority?: int32;

  /**
   * The action type of a rule collection.
   */
  action?: AzureFirewallRCAction;

  /**
   * Collection of rules used by a application rule collection.
   */
  rules?: AzureFirewallApplicationRule[];

  /**
   * The provisioning state of the application rule collection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Properties of the AzureFirewallRCAction.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallRCAction {
  /**
   * The type of action.
   */
  type?: AzureFirewallRCActionType;
}

/**
 * Properties of an application rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallApplicationRule {
  /**
   * Name of the application rule.
   */
  name?: string;

  /**
   * Description of the rule.
   */
  description?: string;

  /**
   * List of source IP addresses for this rule.
   */
  sourceAddresses?: string[];

  /**
   * Array of ApplicationRuleProtocols.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  protocols?: AzureFirewallApplicationRuleProtocol[];

  /**
   * List of FQDNs for this rule.
   */
  targetFqdns?: string[];

  /**
   * List of FQDN Tags for this rule.
   */
  fqdnTags?: string[];

  /**
   * List of source IpGroups for this rule.
   */
  sourceIpGroups?: string[];
}

/**
 * Properties of the application rule protocol.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallApplicationRuleProtocol {
  /**
   * Protocol type.
   */
  protocolType?: AzureFirewallApplicationRuleProtocolType;

  /**
   * Port number for the protocol, cannot be greater than 64000. This field is optional.
   */
  @minValue(0)
  @maxValue(64000)
  port?: int32;
}

/**
 * NAT rule collection resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallNatRuleCollection extends SubResource {
  /**
   * Properties of the azure firewall NAT rule collection.
   */
  properties?: AzureFirewallNatRuleCollectionProperties;

  /**
   * The name of the resource that is unique within the Azure firewall. This name can be used to access the resource.
   */
  name?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Properties of the NAT rule collection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallNatRuleCollectionProperties {
  /**
   * Priority of the NAT rule collection resource.
   */
  @maxValue(65000)
  @minValue(100)
  priority?: int32;

  /**
   * The action type of a NAT rule collection.
   */
  action?: AzureFirewallNatRCAction;

  /**
   * Collection of rules used by a NAT rule collection.
   */
  rules?: AzureFirewallNatRule[];

  /**
   * The provisioning state of the NAT rule collection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * AzureFirewall NAT Rule Collection Action.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallNatRCAction {
  /**
   * The type of action.
   */
  type?: AzureFirewallNatRCActionType;
}

/**
 * Properties of a NAT rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallNatRule {
  /**
   * Name of the NAT rule.
   */
  name?: string;

  /**
   * Description of the rule.
   */
  description?: string;

  /**
   * List of source IP addresses for this rule.
   */
  sourceAddresses?: string[];

  /**
   * List of destination IP addresses for this rule. Supports IP ranges, prefixes, and service tags.
   */
  destinationAddresses?: string[];

  /**
   * List of destination ports.
   */
  destinationPorts?: string[];

  /**
   * Array of AzureFirewallNetworkRuleProtocols applicable to this NAT rule.
   */
  protocols?: AzureFirewallNetworkRuleProtocol[];

  /**
   * The translated address for this NAT rule.
   */
  translatedAddress?: string;

  /**
   * The translated port for this NAT rule.
   */
  translatedPort?: string;

  /**
   * The translated FQDN for this NAT rule.
   */
  translatedFqdn?: string;

  /**
   * List of source IpGroups for this rule.
   */
  sourceIpGroups?: string[];
}

/**
 * Network rule collection resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallNetworkRuleCollection extends SubResource {
  /**
   * Properties of the azure firewall network rule collection.
   */
  properties?: AzureFirewallNetworkRuleCollectionPropertiesFormat;

  /**
   * The name of the resource that is unique within the Azure firewall. This name can be used to access the resource.
   */
  name?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Properties of the network rule collection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallNetworkRuleCollectionPropertiesFormat {
  /**
   * Priority of the network rule collection resource.
   */
  @maxValue(65000)
  @minValue(100)
  priority?: int32;

  /**
   * The action type of a rule collection.
   */
  action?: AzureFirewallRCAction;

  /**
   * Collection of rules used by a network rule collection.
   */
  rules?: AzureFirewallNetworkRule[];

  /**
   * The provisioning state of the network rule collection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Properties of the network rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallNetworkRule {
  /**
   * Name of the network rule.
   */
  name?: string;

  /**
   * Description of the rule.
   */
  description?: string;

  /**
   * Array of AzureFirewallNetworkRuleProtocols.
   */
  protocols?: AzureFirewallNetworkRuleProtocol[];

  /**
   * List of source IP addresses for this rule.
   */
  sourceAddresses?: string[];

  /**
   * List of destination IP addresses.
   */
  destinationAddresses?: string[];

  /**
   * List of destination ports.
   */
  destinationPorts?: string[];

  /**
   * List of destination FQDNs.
   */
  destinationFqdns?: string[];

  /**
   * List of source IpGroups for this rule.
   */
  sourceIpGroups?: string[];

  /**
   * List of destination IpGroups for this rule.
   */
  destinationIpGroups?: string[];
}

/**
 * IP configuration of an Azure Firewall.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallIPConfiguration extends SubResource {
  /**
   * Properties of the azure firewall IP configuration.
   */
  properties?: AzureFirewallIPConfigurationPropertiesFormat;

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
   * Type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Properties of IP configuration of an Azure Firewall.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallIPConfigurationPropertiesFormat {
  /**
   * The Firewall Internal Load Balancer IP to be used as the next hop in User Defined Routes.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  privateIPAddress?: string;

  /**
   * Reference to the subnet resource. This resource must be named 'AzureFirewallSubnet' or 'AzureFirewallManagementSubnet'.
   */
  subnet?: SubResource;

  /**
   * Reference to the PublicIP resource. This field is a mandatory input if subnet is not null.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicIPAddress?: SubResource;

  /**
   * The provisioning state of the Azure firewall IP configuration resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * IP addresses associated with azure firewall.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model HubIPAddresses {
  /**
   * Public IP addresses associated with azure firewall.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicIPs?: HubPublicIPAddresses;

  /**
   * Private IP Address associated with azure firewall.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateIPAddress?: string;
}

/**
 * Public IP addresses associated with azure firewall.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model HubPublicIPAddresses {
  /**
   * The list of Public IP addresses associated with azure firewall or IP addresses to be retained.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  addresses?: AzureFirewallPublicIPAddress[];

  /**
   * The number of Public IP addresses associated with azure firewall.
   */
  count?: int32;
}

/**
 * Public IP Address associated with azure firewall.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallPublicIPAddress {
  /**
   * Public IP Address value.
   */
  address?: string;
}

/**
 * IpGroups associated with azure firewall.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallIPGroups {
  /**
   * Resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The iteration number.
   */
  @visibility(Lifecycle.Read)
  changeNumber?: string;
}

/**
 * SKU of an Azure Firewall.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallSku {
  /**
   * Name of an Azure Firewall SKU.
   */
  name?: AzureFirewallSkuName;

  /**
   * Tier of an Azure Firewall.
   */
  tier?: AzureFirewallSkuTier;
}

/**
 * Azure Firewall Autoscale Configuration parameters.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallAutoscaleConfiguration {
  /**
   * The minimum number of capacity units for this azure firewall. Use null to reset the value to the service default.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @minValue(2)
  minCapacity?: int32 | null;

  /**
   * The maximum number of capacity units for this azure firewall. Use null to reset the value to the service default.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @minValue(2)
  maxCapacity?: int32 | null;
}

/**
 * List of SNAT IP Prefixes learnt by firewall to not SNAT
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model IPPrefixesList {
  /**
   * IP Prefix value.
   */
  ipPrefixes?: string[];
}

/**
 * Azure Firewall Packet Capture Parameters.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model FirewallPacketCaptureParameters {
  /**
   * Duration of packet capture in seconds. If the field is not provided, the default value is 60.
   */
  @maxValue(1800)
  @minValue(30)
  durationInSeconds?: int32 = 60;

  /**
   * Number of packets to be captured. If the field is not provided, the default value is 1000.
   */
  @maxValue(90000)
  @minValue(100)
  numberOfPacketsToCapture?: int32 = 1000;

  /**
   * Upload capture location
   */
  sasUrl?: string;

  /**
   * Name of file to be uploaded to sasURL
   */
  fileName?: string;

  /**
   * The protocol of packets to capture
   */
  protocol?: AzureFirewallNetworkRuleProtocol;

  /**
   * The tcp-flag type to be captured. Used with protocol TCP
   */
  @identifiers(#[])
  flags?: AzureFirewallPacketCaptureFlags[];

  /**
   * Rules to filter packet captures.
   */
  @identifiers(#[])
  filters?: AzureFirewallPacketCaptureRule[];

  /**
   * The packet capture operation to perform. If the Start operation is selected, please provide all the fields in the firewallPacketCaptureParameters to successfully initiate the packet capture. If the Status or Stop operation is selected, only the operation field is required; all other fields in the firewallPacketCaptureParameters can be omitted to successfully retrieve the capture status or stop the capture.
   */
  operation?: AzureFirewallPacketCaptureOperationType = AzureFirewallPacketCaptureOperationType.Start;
}

/**
 * Properties of the AzureFirewallRCAction.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallPacketCaptureFlags {
  /**
   * Flags to capture
   */
  type?: AzureFirewallPacketCaptureFlagsType;
}

/**
 * Group of src/dest ips and ports to be captured.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallPacketCaptureRule {
  /**
   * List of source IP addresses/subnets to be captured.
   */
  sources?: string[];

  /**
   * List of destination IP addresses/subnets to be captured.
   */
  destinations?: string[];

  /**
   * List of ports to be captured.
   */
  destinationPorts?: string[];
}

/**
 * Response of an Azure Firewall Packet Capture Operation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallPacketCaptureResponse {
  /**
   * The response code of the performed packet capture operation
   */
  statusCode?: AzureFirewallPacketCaptureResponseCode;

  /**
   * Localized Message String of The Result Of The Azure Firewall Packet Capture Operation
   */
  message?: string;
}

/**
 * Azure Firewall FQDN Tag Resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallFqdnTag extends Resource {
  /**
   * Properties of the azure firewall FQDN tag.
   */
  properties?: AzureFirewallFqdnTagPropertiesFormat;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Azure Firewall FQDN Tag Properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.firewall)
model AzureFirewallFqdnTagPropertiesFormat {
  /**
   * The provisioning state of the Azure firewall FQDN tag resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The name of this FQDN Tag.
   */
  @visibility(Lifecycle.Read)
  fqdnTagName?: string;
}

/**
 * Azure Web Category Properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureWebCategoryPropertiesFormat {
  /**
   * The name of the group that the category belongs to.
   */
  @visibility(Lifecycle.Read)
  group?: string;
}

/**
 * Properties of the Bastion Host.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model BastionHostPropertiesFormat {
  /**
   * IP configuration of the Bastion Host resource.
   */
  ipConfigurations?: BastionHostIPConfiguration[];

  /**
   * FQDN for the endpoint on which bastion host is accessible.
   */
  dnsName?: string;

  /**
   * Reference to an existing virtual network required for Developer Bastion Host only.
   */
  virtualNetwork?: SubResource;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  networkAcls?: BastionHostPropertiesFormatNetworkAcls;

  /**
   * The provisioning state of the bastion host resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The scale units for the Bastion Host resource.
   */
  @maxValue(50)
  @minValue(2)
  scaleUnits?: int32;

  /**
   * Enable/Disable Copy/Paste feature of the Bastion Host resource.
   */
  disableCopyPaste?: boolean = false;

  /**
   * Enable/Disable File Copy feature of the Bastion Host resource.
   */
  enableFileCopy?: boolean = false;

  /**
   * Enable/Disable IP Connect feature of the Bastion Host resource.
   */
  enableIpConnect?: boolean = false;

  /**
   * Enable/Disable Shareable Link of the Bastion Host resource.
   */
  enableShareableLink?: boolean = false;

  /**
   * Enable/Disable Tunneling feature of the Bastion Host resource.
   */
  enableTunneling?: boolean = false;

  /**
   * Enable/Disable Kerberos feature of the Bastion Host resource.
   */
  enableKerberos?: boolean = false;

  /**
   * Enable/Disable Session Recording feature of the Bastion Host resource.
   */
  enableSessionRecording?: boolean = false;

  /**
   * Enable/Disable Private Only feature of the Bastion Host resource.
   */
  enablePrivateOnlyBastion?: boolean = false;
}

/**
 * IP configuration of an Bastion Host.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model BastionHostIPConfiguration extends SubResource {
  /**
   * Represents the ip configuration associated with the resource.
   */
  properties?: BastionHostIPConfigurationPropertiesFormat;

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
   * Ip configuration type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Properties of IP configuration of an Bastion Host.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model BastionHostIPConfigurationPropertiesFormat {
  /**
   * Reference of the subnet resource.
   */
  subnet: SubResource;

  /**
   * Reference of the PublicIP resource. Null for private only bastion
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicIPAddress?: SubResource;

  /**
   * The provisioning state of the bastion host IP configuration resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * Private IP allocation method.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateIPAllocationMethod?: IPAllocationMethod;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BastionHostPropertiesFormatNetworkAcls {
  /**
   * Sets the IP ACL rules for Developer Bastion Host.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ipRules?: IPRule[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model IPRule {
  /**
   * Specifies the IP or IP range in CIDR format. Only IPV4 address is allowed.
   */
  addressPrefix?: string;
}

/**
 * The sku of this Bastion Host.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model Sku {
  /**
   * The name of the sku of this Bastion Host.
   */
  name?: BastionHostSkuName = BastionHostSkuName.Standard;
}

/**
 * Post request for Create/Delete/Get Bastion Shareable Link endpoints.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model BastionShareableLinkListRequest {
  /**
   * List of VM references.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vms?: BastionShareableLink[];
}

/**
 * Bastion Shareable Link.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model BastionShareableLink {
  /**
   * Reference of the virtual machine resource.
   */
  vm: VM;

  /**
   * The unique Bastion Shareable Link to the virtual machine.
   */
  @visibility(Lifecycle.Read)
  bsl?: string;

  /**
   * The time when the link was created.
   */
  @visibility(Lifecycle.Read)
  createdAt?: string;

  /**
   * Optional field indicating the warning or error message related to the vm in case of partial failure.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Describes a Virtual Machine.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VM extends Resource {}

/**
 * Response for all the Bastion Shareable Link endpoints.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model BastionShareableLinkListResult is Azure.Core.Page<BastionShareableLink>;

/**
 * Post request for Delete Bastion Shareable Link By Token endpoint.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model BastionShareableLinkTokenListRequest {
  /**
   * List of Bastion Shareable Link Token.
   */
  tokens?: string[];
}

/**
 * Response for GetActiveSessions.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model BastionActiveSessionListResult is Azure.Core.Page<BastionActiveSession>;

/**
 * The session detail for a target.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model BastionActiveSession {
  /**
   * A unique id for the session.
   */
  @visibility(Lifecycle.Read)
  sessionId?: string;

  /**
   * The time when the session started.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  startTime?: unknown;

  /**
   * The subscription id for the target virtual machine.
   */
  @visibility(Lifecycle.Read)
  targetSubscriptionId?: string;

  /**
   * The type of the resource.
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * The host name of the target.
   */
  @visibility(Lifecycle.Read)
  targetHostName?: string;

  /**
   * The resource group of the target.
   */
  @visibility(Lifecycle.Read)
  targetResourceGroup?: string;

  /**
   * The user name who is active on this session.
   */
  @visibility(Lifecycle.Read)
  userName?: string;

  /**
   * The IP Address of the target.
   */
  @visibility(Lifecycle.Read)
  targetIpAddress?: string;

  /**
   * The protocol used to connect to the target.
   */
  @visibility(Lifecycle.Read)
  protocol?: BastionConnectProtocol;

  /**
   * The resource id of the target.
   */
  @visibility(Lifecycle.Read)
  targetResourceId?: string;

  /**
   * Duration in mins the session has been active.
   */
  @visibility(Lifecycle.Read)
  sessionDurationInMins?: float32;
}

/**
 * List of session IDs.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model SessionIds {
  /**
   * List of session IDs.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sessionIds?: string[];
}

/**
 * Response for DisconnectActiveSessions.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model BastionSessionDeleteResult is Azure.Core.Page<BastionSessionState>;

/**
 * The session state detail for a target.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model BastionSessionState {
  /**
   * A unique id for the session.
   */
  @visibility(Lifecycle.Read)
  sessionId?: string;

  /**
   * Used for extra information.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The state of the session. Disconnected/Failed/NotFound.
   */
  @visibility(Lifecycle.Read)
  state?: string;
}

/**
 * Response for the CheckDnsNameAvailability API service call.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model DnsNameAvailabilityResult {
  /**
   * Domain availability (True/False).
   */
  available?: boolean;
}

/**
 * Swap resource properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model SwapResourceProperties {
  /**
   * Specifies slot info on a cloud service
   */
  slotType?: SlotType;
}

/**
 * SwapResource List with single entry to represent slot type on the specified cloud service.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model SwapResourceListResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pageItems
  value?: SwapResource[];
}

/**
 * Custom IP prefix properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model CustomIpPrefixPropertiesFormat {
  /**
   * The ASN for CIDR advertising. Should be an integer as string.
   */
  asn?: string;

  /**
   * The prefix range in CIDR notation. Should include the start address and the prefix length.
   */
  cidr?: string;

  /**
   * Signed message for WAN validation.
   */
  signedMessage?: string;

  /**
   * Authorization message for WAN validation.
   */
  authorizationMessage?: string;

  /**
   * The Parent CustomIpPrefix for IPv6 /64 CustomIpPrefix.
   */
  customIpPrefixParent?: SubResource;

  /**
   * The list of all Children for IPv6 /48 CustomIpPrefix.
   */
  @visibility(Lifecycle.Read)
  childCustomIpPrefixes?: SubResource[];

  /**
   * The commissioned state of the Custom IP Prefix.
   */
  commissionedState?: CommissionedState;

  /**
   * Whether to do express route advertise.
   */
  expressRouteAdvertise?: boolean;

  /**
   * The Geo for CIDR advertising. Should be an Geo code.
   */
  geo?: Geo;

  /**
   * Whether to Advertise the range to Internet.
   */
  noInternetAdvertise?: boolean;

  /**
   * Type of custom IP prefix. Should be Singular, Parent, or Child.
   */
  prefixType?: CustomIpPrefixType;

  /**
   * The list of all referenced PublicIpPrefixes.
   */
  @visibility(Lifecycle.Read)
  publicIpPrefixes?: SubResource[];

  /**
   * The resource GUID property of the custom IP prefix resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The reason why resource is in failed state.
   */
  @visibility(Lifecycle.Read)
  failedReason?: string;

  /**
   * The provisioning state of the custom IP prefix resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * DDoS custom policy properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model DdosCustomPolicyPropertiesFormat {
  /**
   * The resource GUID property of the DDoS custom policy resource. It uniquely identifies the resource, even if the user changes its name or migrate the resource across subscriptions or resource groups.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The provisioning state of the DDoS custom policy resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The list of DDoS detection rules associated with the custom policy.
   */
  detectionRules?: DdosDetectionRule[];

  /**
   * The list of frontend IP configurations associated with the custom policy.
   */
  frontEndIpConfiguration?: SubResource[];
}

/**
 * A DDoS detection rule resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model DdosDetectionRule extends SubResource {
  /**
   * The name of the DDoS detection rule.
   */
  name?: string;

  /**
   * The resource ID of the DDoS detection rule.
   */
  @visibility(Lifecycle.Read)
  id?: string;

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

  /**
   * Properties of the DDoS detection rule.
   */
  properties?: DdosDetectionRulePropertiesFormat;
}

/**
 * DDoS detection rule properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model DdosDetectionRulePropertiesFormat {
  /**
   * The provisioning state of the DDoS detection rule.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The detection mode for the DDoS detection rule.
   */
  detectionMode?: DdosDetectionMode;

  /**
   * The traffic detection rule details.
   */
  trafficDetectionRule?: TrafficDetectionRule;
}

/**
 * Ddos Custom Policy traffic detection rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model TrafficDetectionRule {
  /**
   * The traffic type (one of Tcp, Udp, TcpSyn) that the detection rule will be applied upon.
   */
  trafficType?: DdosTrafficType;

  /**
   * The customized packets per second threshold.
   */
  packetsPerSecond?: int32;
}

/**
 * DDoS protection plan properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model DdosProtectionPlanPropertiesFormat {
  /**
   * The resource GUID property of the DDoS protection plan resource. It uniquely identifies the resource, even if the user changes its name or migrate the resource across subscriptions or resource groups.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The provisioning state of the DDoS protection plan resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The list of public IPs associated with the DDoS protection plan resource. This list is read-only.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  publicIPAddresses?: SubResource[];

  /**
   * The list of virtual networks associated with the DDoS protection plan resource. This list is read-only.
   */
  @visibility(Lifecycle.Read)
  virtualNetworks?: SubResource[];
}

/**
 * Differentiated Services Code Point configuration properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model DscpConfigurationPropertiesFormat {
  /**
   * List of markings to be used in the configuration.
   */
  markings?: int32[];

  /**
   * Source IP ranges.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceIpRanges?: QosIpRange[];

  /**
   * Destination IP ranges.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  destinationIpRanges?: QosIpRange[];

  /**
   * Sources port ranges.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourcePortRanges?: QosPortRange[];

  /**
   * Destination port ranges.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  destinationPortRanges?: QosPortRange[];

  /**
   * RNM supported protocol types.
   */
  protocol?: ProtocolType;

  /**
   * QoS object definitions
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  qosDefinitionCollection?: QosDefinition[];

  /**
   * Qos Collection ID generated by RNM.
   */
  @visibility(Lifecycle.Read)
  qosCollectionId?: string;

  /**
   * Associated Network Interfaces to the DSCP Configuration.
   */
  @visibility(Lifecycle.Read)
  associatedNetworkInterfaces?: NetworkInterface[];

  /**
   * The resource GUID property of the DSCP Configuration resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The provisioning state of the DSCP Configuration resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Qos Traffic Profiler IP Range properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model QosIpRange {
  /**
   * Start IP Address.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  startIP?: string;

  /**
   * End IP Address.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endIP?: string;
}

/**
 * Qos Traffic Profiler Port range properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model QosPortRange {
  /**
   * Qos Port Range start.
   */
  start?: int32;

  /**
   * Qos Port Range end.
   */
  end?: int32;
}

/**
 * Quality of Service defines the traffic configuration between endpoints. Mandatory to have one marking.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model QosDefinition {
  /**
   * List of markings to be used in the configuration.
   */
  markings?: int32[];

  /**
   * Source IP ranges.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceIpRanges?: QosIpRange[];

  /**
   * Destination IP ranges.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  destinationIpRanges?: QosIpRange[];

  /**
   * Sources port ranges.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourcePortRanges?: QosPortRange[];

  /**
   * Destination port ranges.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  destinationPortRanges?: QosPortRange[];

  /**
   * RNM supported protocol types.
   */
  protocol?: ProtocolType;
}

/**
 * Endpoint service.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model EndpointServiceResult extends SubResource {
  /**
   * Name of the endpoint service.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Type of the endpoint service.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Properties of ExpressRouteCircuitAuthorization.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model AuthorizationPropertiesFormat {
  /**
   * The authorization key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authorizationKey?: string;

  /**
   * The authorization use status.
   */
  authorizationUseStatus?: AuthorizationUseStatus;

  /**
   * The reference to the ExpressRoute connection resource using the authorization.
   */
  @visibility(Lifecycle.Read)
  connectionResourceUri?: string;

  /**
   * The provisioning state of the authorization resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Properties of the express route circuit peering.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteCircuitPeeringPropertiesFormat {
  /**
   * The peering type.
   */
  peeringType?: ExpressRoutePeeringType;

  /**
   * The peering state.
   */
  state?: ExpressRoutePeeringState;

  /**
   * The Azure ASN.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureASN?: int32;

  /**
   * The peer ASN.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @maxValue(4294967295)
  @minValue(1)
  peerASN?: int64;

  /**
   * The primary address prefix.
   */
  primaryPeerAddressPrefix?: string;

  /**
   * The secondary address prefix.
   */
  secondaryPeerAddressPrefix?: string;

  /**
   * The primary port.
   */
  primaryAzurePort?: string;

  /**
   * The secondary port.
   */
  secondaryAzurePort?: string;

  /**
   * The shared key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sharedKey?: string;

  /**
   * The VLAN ID.
   */
  vlanId?: int32;

  /**
   * The Microsoft peering configuration.
   */
  microsoftPeeringConfig?: ExpressRouteCircuitPeeringConfig;

  /**
   * The peering stats of express route circuit.
   */
  stats?: ExpressRouteCircuitStats;

  /**
   * The provisioning state of the express route circuit peering resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The GatewayManager Etag.
   */
  gatewayManagerEtag?: string;

  /**
   * Who was the last to modify the peering.
   */
  @visibility(Lifecycle.Read)
  lastModifiedBy?: string;

  /**
   * The reference to the RouteFilter resource.
   */
  routeFilter?: SubResource;

  /**
   * The IPv6 peering configuration.
   */
  ipv6PeeringConfig?: Ipv6ExpressRouteCircuitPeeringConfig;

  /**
   * The ExpressRoute connection.
   */
  expressRouteConnection?: ExpressRouteConnectionId;

  /**
   * The list of circuit connections associated with Azure Private Peering for this circuit.
   */
  connections?: ExpressRouteCircuitConnection[];

  /**
   * The list of peered circuit connections associated with Azure Private Peering for this circuit.
   */
  @visibility(Lifecycle.Read)
  peeredConnections?: PeerExpressRouteCircuitConnection[];
}

/**
 * Specifies the peering configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteCircuitPeeringConfig {
  /**
   * The reference to AdvertisedPublicPrefixes.
   */
  advertisedPublicPrefixes?: string[];

  /**
   * The communities of bgp peering. Specified for microsoft peering.
   */
  advertisedCommunities?: string[];

  /**
   * The advertised public prefix state of the Peering resource.
   */
  @visibility(Lifecycle.Read)
  advertisedPublicPrefixesState?: ExpressRouteCircuitPeeringAdvertisedPublicPrefixState;

  /**
   * The legacy mode of the peering.
   */
  legacyMode?: int32;

  /**
   * The CustomerASN of the peering.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  customerASN?: int32;

  /**
   * The RoutingRegistryName of the configuration.
   */
  routingRegistryName?: string;

  /**
   * List of Prefix information required to perform validation.
   */
  @identifiers(#[])
  advertisedPublicPrefixInfo?: AdvertisedPublicPrefixProperties[];
}

/**
 * Prefix properties required to perform validation using openssl signature.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model AdvertisedPublicPrefixProperties {
  /**
   * Advertised Public Prefix.
   */
  prefix?: string;

  /**
   * Validation string that contains circuit peering info.
   */
  validationId?: string;

  /**
   * Signed string generated by encrypting validationId with a private key.
   */
  signature?: string;

  /**
   * Advertised Public Prefix State that denotes if the prefix is validated or not.
   */
  @visibility(Lifecycle.Read)
  validationState?: AdvertisedPublicPrefixPropertiesValidationState;
}

/**
 * Contains stats associated with the peering.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteCircuitStats {
  /**
   * The Primary BytesIn of the peering.
   */
  primarybytesIn?: int64;

  /**
   * The primary BytesOut of the peering.
   */
  primarybytesOut?: int64;

  /**
   * The secondary BytesIn of the peering.
   */
  secondarybytesIn?: int64;

  /**
   * The secondary BytesOut of the peering.
   */
  secondarybytesOut?: int64;
}

/**
 * Contains IPv6 peering config.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model Ipv6ExpressRouteCircuitPeeringConfig {
  /**
   * The primary address prefix.
   */
  primaryPeerAddressPrefix?: string;

  /**
   * The secondary address prefix.
   */
  secondaryPeerAddressPrefix?: string;

  /**
   * The Microsoft peering configuration.
   */
  microsoftPeeringConfig?: ExpressRouteCircuitPeeringConfig;

  /**
   * The reference to the RouteFilter resource.
   */
  routeFilter?: SubResource;

  /**
   * The state of peering.
   */
  state?: ExpressRouteCircuitPeeringState;
}

/**
 * The ID of the ExpressRouteConnection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model ExpressRouteConnectionId {
  /**
   * The ID of the ExpressRouteConnection.
   */
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * Properties of the express route circuit connection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteCircuitConnectionPropertiesFormat {
  /**
   * Reference to Express Route Circuit Private Peering Resource of the circuit initiating connection.
   */
  expressRouteCircuitPeering?: SubResource;

  /**
   * Reference to Express Route Circuit Private Peering Resource of the peered circuit.
   */
  peerExpressRouteCircuitPeering?: SubResource;

  /**
   * /29 IP address space to carve out Customer addresses for tunnels.
   */
  addressPrefix?: string;

  /**
   * The authorization key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authorizationKey?: string;

  /**
   * IPv6 Address PrefixProperties of the express route circuit connection.
   */
  ipv6CircuitConnectionConfig?: Ipv6CircuitConnectionConfig;

  /**
   * Express Route Circuit connection state.
   */
  @visibility(Lifecycle.Read)
  circuitConnectionStatus?: CircuitConnectionStatus;

  /**
   * The provisioning state of the express route circuit connection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * IPv6 Circuit Connection properties for global reach.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model Ipv6CircuitConnectionConfig {
  /**
   * /125 IP address space to carve out customer addresses for global reach.
   */
  addressPrefix?: string;

  /**
   * Express Route Circuit connection state.
   */
  @visibility(Lifecycle.Read)
  circuitConnectionStatus?: CircuitConnectionStatus;
}

/**
 * Properties of the peer express route circuit connection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model PeerExpressRouteCircuitConnectionPropertiesFormat {
  /**
   * Reference to Express Route Circuit Private Peering Resource of the circuit.
   */
  expressRouteCircuitPeering?: SubResource;

  /**
   * Reference to Express Route Circuit Private Peering Resource of the peered circuit.
   */
  peerExpressRouteCircuitPeering?: SubResource;

  /**
   * /29 IP address space to carve out Customer addresses for tunnels.
   */
  addressPrefix?: string;

  /**
   * Express Route Circuit connection state.
   */
  @visibility(Lifecycle.Read)
  circuitConnectionStatus?: CircuitConnectionStatus;

  /**
   * The name of the express route circuit connection resource.
   */
  connectionName?: string;

  /**
   * The resource guid of the authorization used for the express route circuit connection.
   */
  authResourceGuid?: string;

  /**
   * The provisioning state of the peer express route circuit connection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Contains SKU in an ExpressRouteCircuit.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteCircuitSku {
  /**
   * The name of the SKU.
   */
  name?: string;

  /**
   * The tier of the SKU.
   */
  tier?: ExpressRouteCircuitSkuTier;

  /**
   * The family of the SKU.
   */
  family?: ExpressRouteCircuitSkuFamily;
}

/**
 * Properties of ExpressRouteCircuit.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteCircuitPropertiesFormat {
  /**
   * Allow classic operations.
   */
  allowClassicOperations?: boolean;

  /**
   * The CircuitProvisioningState state of the resource.
   */
  circuitProvisioningState?: string;

  /**
   * The ServiceProviderProvisioningState state of the resource.
   */
  serviceProviderProvisioningState?: ServiceProviderProvisioningState;

  /**
   * The list of authorizations.
   */
  authorizations?: ExpressRouteCircuitAuthorization[];

  /**
   * The list of peerings.
   */
  peerings?: ExpressRouteCircuitPeering[];

  /**
   * The ServiceKey.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serviceKey?: string;

  /**
   * The ServiceProviderNotes.
   */
  serviceProviderNotes?: string;

  /**
   * The ServiceProviderProperties.
   */
  serviceProviderProperties?: ExpressRouteCircuitServiceProviderProperties;

  /**
   * The reference to the ExpressRoutePort resource when the circuit is provisioned on an ExpressRoutePort resource.
   */
  expressRoutePort?: SubResource;

  /**
   * The bandwidth of the circuit when the circuit is provisioned on an ExpressRoutePort resource.
   */
  bandwidthInGbps?: float32;

  /**
   * The identifier of the circuit traffic. Outer tag for QinQ encapsulation.
   */
  @visibility(Lifecycle.Read)
  stag?: int32;

  /**
   * The provisioning state of the express route circuit resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The GatewayManager Etag.
   */
  gatewayManagerEtag?: string;

  /**
   * Flag denoting global reach status.
   */
  globalReachEnabled?: boolean;

  /**
   * The authorizationKey.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authorizationKey?: string;

  /**
   * The authorization status of the Circuit.
   */
  @visibility(Lifecycle.Read)
  authorizationStatus?: string;

  /**
   * Flag denoting rate-limiting status of the ExpressRoute direct-port circuit.
   */
  enableDirectPortRateLimit?: boolean;
}

/**
 * Contains ServiceProviderProperties in an ExpressRouteCircuit.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteCircuitServiceProviderProperties {
  /**
   * The serviceProviderName.
   */
  serviceProviderName?: string;

  /**
   * The peering location.
   */
  peeringLocation?: string;

  /**
   * The BandwidthInMbps.
   */
  bandwidthInMbps?: int32;
}

/**
 * Response for ListArpTable associated with the Express Route Circuits API.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteCircuitsArpTableListResult
  is Azure.Core.Page<ExpressRouteCircuitArpTable>;

/**
 * The ARP table associated with the ExpressRouteCircuit.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteCircuitArpTable {
  /**
   * Entry age in minutes.
   */
  age?: int32;

  /**
   * Interface address.
   */
  `interface`?: string;

  /**
   * The IP address.
   */
  ipAddress?: string;

  /**
   * The MAC address.
   */
  macAddress?: string;
}

/**
 * Response for ListRoutesTable associated with the Express Route Circuits API.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteCircuitsRoutesTableListResult
  is Azure.Core.Page<ExpressRouteCircuitRoutesTable>;

/**
 * The routes table associated with the ExpressRouteCircuit.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteCircuitRoutesTable {
  /**
   * IP address of a network entity.
   */
  network?: string;

  /**
   * NextHop address.
   */
  nextHop?: string;

  /**
   * Local preference value as set with the set local-preference route-map configuration command.
   */
  locPrf?: string;

  /**
   * Route Weight.
   */
  weight?: int32;

  /**
   * Autonomous system paths to the destination network.
   */
  path?: string;
}

/**
 * Response for ListRoutesTable associated with the Express Route Circuits API.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteCircuitsRoutesTableSummaryListResult
  is Azure.Core.Page<ExpressRouteCircuitRoutesTableSummary>;

/**
 * The routes table associated with the ExpressRouteCircuit.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteCircuitRoutesTableSummary {
  /**
   * IP address of the neighbor.
   */
  neighbor?: string;

  /**
   * BGP version number spoken to the neighbor.
   */
  v?: int32;

  /**
   * Autonomous system number.
   */
  as?: int32;

  /**
   * The length of time that the BGP session has been in the Established state, or the current status if not in the Established state.
   */
  upDown?: string;

  /**
   * Current state of the BGP session, and the number of prefixes that have been received from a neighbor or peer group.
   */
  statePfxRcd?: string;
}

/**
 * A ExpressRouteResourceProvider object.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteServiceProvider extends Resource {
  /**
   * Properties of the express route service provider.
   */
  properties?: ExpressRouteServiceProviderPropertiesFormat;
}

/**
 * Properties of ExpressRouteServiceProvider.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteServiceProviderPropertiesFormat {
  /**
   * A list of peering locations.
   */
  peeringLocations?: string[];

  /**
   * A list of bandwidths offered.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  bandwidthsOffered?: ExpressRouteServiceProviderBandwidthsOffered[];

  /**
   * The provisioning state of the express route service provider resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Contains bandwidths offered in ExpressRouteServiceProvider resources.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteServiceProviderBandwidthsOffered {
  /**
   * The OfferName.
   */
  offerName?: string;

  /**
   * The ValueInMbps.
   */
  valueInMbps?: int32;
}

/**
 * Properties of ExpressRouteCrossConnection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteCrossConnectionProperties {
  /**
   * The name of the primary port.
   */
  @visibility(Lifecycle.Read)
  primaryAzurePort?: string;

  /**
   * The name of the secondary port.
   */
  @visibility(Lifecycle.Read)
  secondaryAzurePort?: string;

  /**
   * The identifier of the circuit traffic.
   */
  @visibility(Lifecycle.Read)
  sTag?: int32;

  /**
   * The peering location of the ExpressRoute circuit.
   */
  @visibility(Lifecycle.Read)
  peeringLocation?: string;

  /**
   * The circuit bandwidth In Mbps.
   */
  @visibility(Lifecycle.Read)
  bandwidthInMbps?: int32;

  /**
   * The ExpressRouteCircuit.
   */
  expressRouteCircuit?: ExpressRouteCircuitReference;

  /**
   * The provisioning state of the circuit in the connectivity provider system.
   */
  serviceProviderProvisioningState?: ServiceProviderProvisioningState;

  /**
   * Additional read only notes set by the connectivity provider.
   */
  serviceProviderNotes?: string;

  /**
   * The provisioning state of the express route cross connection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The list of peerings.
   */
  peerings?: ExpressRouteCrossConnectionPeering[];
}

/**
 * Reference to an express route circuit.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteCircuitReference {
  /**
   * Corresponding Express Route Circuit Id.
   */
  id?: string;
}

/**
 * Peering in an ExpressRoute Cross Connection resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteCrossConnectionPeering extends SubResource {
  /**
   * Properties of the express route cross connection peering.
   */
  properties?: ExpressRouteCrossConnectionPeeringProperties;

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
 * Properties of express route cross connection peering.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteCrossConnectionPeeringProperties {
  /**
   * The peering type.
   */
  peeringType?: ExpressRoutePeeringType;

  /**
   * The peering state.
   */
  state?: ExpressRoutePeeringState;

  /**
   * The Azure ASN.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  azureASN?: int32;

  /**
   * The peer ASN.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @maxValue(4294967295)
  @minValue(1)
  peerASN?: int64;

  /**
   * The primary address prefix.
   */
  primaryPeerAddressPrefix?: string;

  /**
   * The secondary address prefix.
   */
  secondaryPeerAddressPrefix?: string;

  /**
   * The primary port.
   */
  @visibility(Lifecycle.Read)
  primaryAzurePort?: string;

  /**
   * The secondary port.
   */
  @visibility(Lifecycle.Read)
  secondaryAzurePort?: string;

  /**
   * The shared key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sharedKey?: string;

  /**
   * The VLAN ID.
   */
  vlanId?: int32;

  /**
   * The Microsoft peering configuration.
   */
  microsoftPeeringConfig?: ExpressRouteCircuitPeeringConfig;

  /**
   * The provisioning state of the express route cross connection peering resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The GatewayManager Etag.
   */
  gatewayManagerEtag?: string;

  /**
   * Who was the last to modify the peering.
   */
  @visibility(Lifecycle.Read)
  lastModifiedBy?: string;

  /**
   * The IPv6 peering configuration.
   */
  ipv6PeeringConfig?: Ipv6ExpressRouteCircuitPeeringConfig;
}

/**
 * Response for ListPeering API service call retrieves all peerings that belong to an ExpressRouteCrossConnection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteCrossConnectionPeeringList
  is Azure.Core.Page<ExpressRouteCrossConnectionPeering>;

/**
 * Response for ListRoutesTable associated with the Express Route Cross Connections.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteCrossConnectionsRoutesTableSummaryListResult
  is Azure.Core.Page<ExpressRouteCrossConnectionRoutesTableSummary>;

/**
 * The routes table associated with the ExpressRouteCircuit.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteCrossConnectionRoutesTableSummary {
  /**
   * IP address of Neighbor router.
   */
  neighbor?: string;

  /**
   * Autonomous system number.
   */
  asn?: int32;

  /**
   * The length of time that the BGP session has been in the Established state, or the current status if not in the Established state.
   */
  upDown?: string;

  /**
   * Current state of the BGP session, and the number of prefixes that have been received from a neighbor or peer group.
   */
  stateOrPrefixesReceived?: string;
}

/**
 * Properties specific to ExpressRoutePorts peering location resources.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@summary("ExpressRoutePorts Location Properties")
model ExpressRoutePortsLocationPropertiesFormat {
  /**
   * Address of peering location.
   */
  @visibility(Lifecycle.Read)
  address?: string;

  /**
   * Contact details of peering locations.
   */
  @visibility(Lifecycle.Read)
  contact?: string;

  /**
   * The inventory of available ExpressRoutePort bandwidths.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  availableBandwidths?: ExpressRoutePortsLocationBandwidths[];

  /**
   * The provisioning state of the express route port location resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Real-time inventory of available ExpressRoute port bandwidths.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@summary("ExpressRoutePorts Location Bandwidths")
model ExpressRoutePortsLocationBandwidths {
  /**
   * Bandwidth descriptive name.
   */
  @visibility(Lifecycle.Read)
  offerName?: string;

  /**
   * Bandwidth value in Gbps.
   */
  @visibility(Lifecycle.Read)
  valueInGbps?: int32;
}

/**
 * Properties specific to ExpressRoutePort resources.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@summary("ExpressRoutePort Properties")
model ExpressRoutePortPropertiesFormat {
  /**
   * The name of the peering location that the ExpressRoutePort is mapped to physically.
   */
  peeringLocation?: string;

  /**
   * Bandwidth of procured ports in Gbps.
   */
  bandwidthInGbps?: int32;

  /**
   * Aggregate Gbps of associated circuit bandwidths.
   */
  @visibility(Lifecycle.Read)
  provisionedBandwidthInGbps?: float32;

  /**
   * Maximum transmission unit of the physical port pair(s).
   */
  @visibility(Lifecycle.Read)
  mtu?: string;

  /**
   * Encapsulation method on physical ports.
   */
  encapsulation?: ExpressRoutePortsEncapsulation;

  /**
   * Ether type of the physical port.
   */
  @visibility(Lifecycle.Read)
  etherType?: string;

  /**
   * Date of the physical port allocation to be used in Letter of Authorization.
   */
  @visibility(Lifecycle.Read)
  allocationDate?: string;

  /**
   * The set of physical links of the ExpressRoutePort resource.
   */
  @summary("ExpressRouteLink Sub-Resources")
  links?: ExpressRouteLink[];

  /**
   * Reference the ExpressRoute circuit(s) that are provisioned on this ExpressRoutePort resource.
   */
  @visibility(Lifecycle.Read)
  circuits?: SubResource[];

  /**
   * The provisioning state of the express route port resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The resource GUID property of the express route port resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The billing type of the ExpressRoutePort resource.
   */
  billingType?: ExpressRoutePortsBillingType;
}

/**
 * ExpressRouteLink child resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@summary("ExpressRouteLink")
model ExpressRouteLink extends SubResource {
  /**
   * ExpressRouteLink properties.
   */
  properties?: ExpressRouteLinkPropertiesFormat;

  /**
   * Name of child port resource that is unique among child port resources of the parent.
   */
  name?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Properties specific to ExpressRouteLink resources.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@summary("ExpressRouteLink Resource Properties")
model ExpressRouteLinkPropertiesFormat {
  /**
   * Name of Azure router associated with physical port.
   */
  @visibility(Lifecycle.Read)
  routerName?: string;

  /**
   * Name of Azure router interface.
   */
  @visibility(Lifecycle.Read)
  interfaceName?: string;

  /**
   * Mapping between physical port to patch panel port.
   */
  @visibility(Lifecycle.Read)
  patchPanelId?: string;

  /**
   * Mapping of physical patch panel to rack.
   */
  @visibility(Lifecycle.Read)
  rackId?: string;

  /**
   * Cololocation for ExpressRoute Hybrid Direct.
   */
  @visibility(Lifecycle.Read)
  coloLocation?: string;

  /**
   * Physical fiber port type.
   */
  @visibility(Lifecycle.Read)
  connectorType?: ExpressRouteLinkConnectorType;

  /**
   * Administrative state of the physical port.
   */
  adminState?: ExpressRouteLinkAdminState;

  /**
   * The provisioning state of the express route link resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * MacSec configuration.
   */
  macSecConfig?: ExpressRouteLinkMacSecConfig;
}

/**
 * ExpressRouteLink Mac Security Configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@summary("Definition of ExpressRouteLink Mac Security configuration.")
model ExpressRouteLinkMacSecConfig {
  /**
   * Keyvault Secret Identifier URL containing Mac security CKN key.
   */
  cknSecretIdentifier?: string;

  /**
   * Keyvault Secret Identifier URL containing Mac security CAK key.
   */
  cakSecretIdentifier?: string;

  /**
   * Mac security cipher.
   */
  cipher?: ExpressRouteLinkMacSecCipher;

  /**
   * Sci mode enabled/disabled.
   */
  sciState?: ExpressRouteLinkMacSecSciState;
}

/**
 * Response for ListExpressRouteLinks API service call.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("ExpressRouteLink List Result")
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteLinkListResult is Azure.Core.Page<ExpressRouteLink>;

/**
 * The customer name to be printed on a letter of authorization.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model GenerateExpressRoutePortsLOARequest {
  /**
   * The customer name.
   */
  customerName: string;
}

/**
 * Response for GenerateExpressRoutePortsLOA API service call.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model GenerateExpressRoutePortsLOAResult {
  /**
   * The content as a base64 encoded string.
   */
  encodedContent?: string;
}

/**
 * Properties of ExpressRoutePort Authorization.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@summary("ExpressRoute Port Authorization Properties")
model ExpressRoutePortAuthorizationPropertiesFormat {
  /**
   * The authorization key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  authorizationKey?: string;

  /**
   * The authorization use status.
   */
  @visibility(Lifecycle.Read)
  authorizationUseStatus?: ExpressRoutePortAuthorizationUseStatus;

  /**
   * The reference to the ExpressRoute circuit resource using the authorization.
   */
  @visibility(Lifecycle.Read)
  circuitResourceUri?: string;

  /**
   * The provisioning state of the authorization resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Properties of ExpressRouteProviderPort.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRouteProviderPortProperties {
  /**
   * The name of the port pair.
   */
  @visibility(Lifecycle.Read)
  portPairDescriptor?: string;

  /**
   * The name of the primary port.
   */
  @visibility(Lifecycle.Read)
  primaryAzurePort?: string;

  /**
   * The name of the secondary port.
   */
  @visibility(Lifecycle.Read)
  secondaryAzurePort?: string;

  /**
   * The peering location of the port pair.
   */
  peeringLocation?: string;

  /**
   * Overprovisioning factor for the port pair.
   */
  overprovisionFactor?: int32;

  /**
   * Bandwidth of the port in Mbps
   */
  portBandwidthInMbps?: int32;

  /**
   * Used Bandwidth of the port in Mbps
   */
  usedBandwidthInMbps?: int32;

  /**
   * Remaining Bandwidth of the port in Mbps
   */
  remainingBandwidthInMbps?: int32;
}

/**
 * Firewall Policy definition.
 */
model FirewallPolicyPropertiesFormat {
  /**
   * A read-only string that represents the size of the FirewallPolicyPropertiesFormat in MB. (ex 0.5MB)
   */
  @visibility(Lifecycle.Read)
  size?: string;

  /**
   * List of references to FirewallPolicyRuleCollectionGroups.
   */
  @visibility(Lifecycle.Read)
  ruleCollectionGroups?: SubResource[];

  /**
   * The provisioning state of the firewall policy resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The parent firewall policy from which rules are inherited.
   */
  basePolicy?: SubResource;

  /**
   * List of references to Azure Firewalls that this Firewall Policy is associated with.
   */
  @visibility(Lifecycle.Read)
  firewalls?: SubResource[];

  /**
   * List of references to Child Firewall Policies.
   */
  @visibility(Lifecycle.Read)
  childPolicies?: SubResource[];

  /**
   * The operation mode for Threat Intelligence.
   */
  threatIntelMode?: AzureFirewallThreatIntelMode;

  /**
   * ThreatIntel Whitelist for Firewall Policy.
   */
  threatIntelWhitelist?: FirewallPolicyThreatIntelWhitelist;

  /**
   * Insights on Firewall Policy.
   */
  insights?: FirewallPolicyInsights;

  /**
   * The private IP addresses/IP ranges to which traffic will not be SNAT.
   */
  snat?: FirewallPolicySnat;

  /**
   * SQL Settings definition.
   */
  sql?: FirewallPolicySQL;

  /**
   * DNS Proxy Settings definition.
   */
  dnsSettings?: DnsSettings;

  /**
   * Explicit Proxy Settings definition.
   */
  explicitProxy?: ExplicitProxy;

  /**
   * The configuration for Intrusion detection.
   */
  intrusionDetection?: FirewallPolicyIntrusionDetection;

  /**
   * TLS Configuration definition.
   */
  transportSecurity?: FirewallPolicyTransportSecurity;

  /**
   * The Firewall Policy SKU.
   */
  sku?: FirewallPolicySku;
}

/**
 * ThreatIntel Whitelist for Firewall Policy.
 */
model FirewallPolicyThreatIntelWhitelist {
  /**
   * List of IP addresses for the ThreatIntel Whitelist.
   */
  ipAddresses?: string[];

  /**
   * List of FQDNs for the ThreatIntel Whitelist.
   */
  fqdns?: string[];
}

/**
 * Firewall Policy Insights.
 */
model FirewallPolicyInsights {
  /**
   * A flag to indicate if the insights are enabled on the policy.
   */
  isEnabled?: boolean;

  /**
   * Number of days the insights should be enabled on the policy.
   */
  retentionDays?: int32;

  /**
   * Workspaces needed to configure the Firewall Policy Insights.
   */
  logAnalyticsResources?: FirewallPolicyLogAnalyticsResources;
}

/**
 * Log Analytics Resources for Firewall Policy Insights.
 */
model FirewallPolicyLogAnalyticsResources {
  /**
   * List of workspaces for Firewall Policy Insights.
   */
  @identifiers(#[])
  workspaces?: FirewallPolicyLogAnalyticsWorkspace[];

  /**
   * The default workspace Id for Firewall Policy Insights.
   */
  defaultWorkspaceId?: SubResource;
}

/**
 * Log Analytics Workspace for Firewall Policy Insights.
 */
model FirewallPolicyLogAnalyticsWorkspace {
  /**
   * Region to configure the Workspace.
   */
  region?: string;

  /**
   * The workspace Id for Firewall Policy Insights.
   */
  workspaceId?: SubResource;
}

/**
 * The private IP addresses/IP ranges to which traffic will not be SNAT.
 */
model FirewallPolicySnat {
  /**
   * List of private IP addresses/IP address ranges to not be SNAT.
   */
  privateRanges?: string[];

  /**
   * The operation mode for automatically learning private ranges to not be SNAT
   */
  autoLearnPrivateRanges?: AutoLearnPrivateRangesMode;
}

/**
 * SQL Settings in Firewall Policy.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FirewallPolicySQL {
  /**
   * A flag to indicate if SQL Redirect traffic filtering is enabled. Turning on the flag requires no rule using port 11000-11999.
   */
  allowSqlRedirect?: boolean;
}

/**
 * DNS Proxy Settings in Firewall Policy.
 */
model DnsSettings {
  /**
   * List of Custom DNS Servers.
   */
  servers?: string[];

  /**
   * Enable DNS Proxy on Firewalls attached to the Firewall Policy.
   */
  enableProxy?: boolean;

  /**
   * FQDNs in Network Rules are supported when set to true.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  requireProxyForNetworkRules?: boolean | null;
}

/**
 * Explicit Proxy Settings in Firewall Policy.
 */
model ExplicitProxy {
  /**
   * When set to true, explicit proxy mode is enabled.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableExplicitProxy?: boolean | null;

  /**
   * Port number for explicit proxy http protocol, cannot be greater than 64000.
   */
  @minValue(0)
  @maxValue(64000)
  httpPort?: int32;

  /**
   * Port number for explicit proxy https protocol, cannot be greater than 64000.
   */
  @minValue(0)
  @maxValue(64000)
  httpsPort?: int32;

  /**
   * When set to true, pac file port and url needs to be provided.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enablePacFile?: boolean | null;

  /**
   * Port number for firewall to serve PAC file.
   */
  @minValue(0)
  @maxValue(64000)
  pacFilePort?: int32;

  /**
   * SAS URL for PAC file.
   */
  pacFile?: string;
}

/**
 * Configuration for intrusion detection mode and rules.
 */
model FirewallPolicyIntrusionDetection {
  /**
   * Intrusion detection general state. When attached to a parent policy, the firewall's effective IDPS mode is the stricter mode of the two.
   */
  mode?: FirewallPolicyIntrusionDetectionStateType;

  /**
   * IDPS profile name. When attached to a parent policy, the firewall's effective profile is the profile name of the parent policy.
   */
  profile?: FirewallPolicyIntrusionDetectionProfileType;

  /**
   * Intrusion detection configuration properties.
   */
  configuration?: FirewallPolicyIntrusionDetectionConfiguration;
}

/**
 * The operation for configuring intrusion detection.
 */
model FirewallPolicyIntrusionDetectionConfiguration {
  /**
   * List of specific signatures states.
   */
  signatureOverrides?: FirewallPolicyIntrusionDetectionSignatureSpecification[];

  /**
   * List of rules for traffic to bypass.
   */
  @identifiers(#[])
  bypassTrafficSettings?: FirewallPolicyIntrusionDetectionBypassTrafficSpecifications[];

  /**
   * IDPS Private IP address ranges are used to identify traffic direction (i.e. inbound, outbound, etc.). By default, only ranges defined by IANA RFC 1918 are considered private IP addresses. To modify default ranges, specify your Private IP address ranges with this property
   */
  privateRanges?: string[];
}

/**
 * Intrusion detection signatures specification states.
 */
model FirewallPolicyIntrusionDetectionSignatureSpecification {
  /**
   * Signature id.
   */
  id?: string;

  /**
   * The signature state.
   */
  mode?: FirewallPolicyIntrusionDetectionStateType;
}

/**
 * Intrusion detection bypass traffic specification.
 */
model FirewallPolicyIntrusionDetectionBypassTrafficSpecifications {
  /**
   * Name of the bypass traffic rule.
   */
  name?: string;

  /**
   * Description of the bypass traffic rule.
   */
  description?: string;

  /**
   * The rule bypass protocol.
   */
  protocol?: FirewallPolicyIntrusionDetectionProtocol;

  /**
   * List of source IP addresses or ranges for this rule.
   */
  sourceAddresses?: string[];

  /**
   * List of destination IP addresses or ranges for this rule.
   */
  destinationAddresses?: string[];

  /**
   * List of destination ports or ranges.
   */
  destinationPorts?: string[];

  /**
   * List of source IpGroups for this rule.
   */
  sourceIpGroups?: string[];

  /**
   * List of destination IpGroups for this rule.
   */
  destinationIpGroups?: string[];
}

/**
 * Configuration needed to perform TLS termination & initiation.
 */
model FirewallPolicyTransportSecurity {
  /**
   * The CA used for intermediate CA generation.
   */
  certificateAuthority?: FirewallPolicyCertificateAuthority;
}

/**
 * Trusted Root certificates properties for tls.
 */
model FirewallPolicyCertificateAuthority {
  /**
   * Secret Id of (base-64 encoded unencrypted pfx) 'Secret' or 'Certificate' object stored in KeyVault.
   */
  keyVaultSecretId?: string;

  /**
   * Name of the CA certificate.
   */
  name?: string;
}

/**
 * SKU of Firewall policy.
 */
model FirewallPolicySku {
  /**
   * Tier of Firewall Policy.
   */
  tier?: FirewallPolicySkuTier;
}

/**
 * Properties of the rule collection group.
 */
model FirewallPolicyRuleCollectionGroupProperties {
  /**
   * A read-only string that represents the size of the FirewallPolicyRuleCollectionGroupProperties in MB. (ex 1.2MB)
   */
  @visibility(Lifecycle.Read)
  size?: string;

  /**
   * Priority of the Firewall Policy Rule Collection Group resource.
   */
  @maxValue(65000)
  @minValue(100)
  priority?: int32;

  /**
   * Group of Firewall Policy rule collections.
   */
  @identifiers(#[])
  ruleCollections?: FirewallPolicyRuleCollection[];

  /**
   * The provisioning state of the firewall policy rule collection group resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Properties of the rule collection.
 */
@discriminator("ruleCollectionType")
model FirewallPolicyRuleCollection {
  /**
   * The type of the rule collection.
   */
  ruleCollectionType: FirewallPolicyRuleCollectionType;

  /**
   * The name of the rule collection.
   */
  name?: string;

  /**
   * Priority of the Firewall Policy Rule Collection resource.
   */
  @maxValue(65000)
  @minValue(100)
  priority?: int32;
}

/**
 * Will describe the query to run against the IDPS signatures DB
 */
model IdpsQueryObject {
  /**
   * Contain all filters names and values
   */
  @identifiers(#[])
  filters?: FilterItems[];

  /**
   * Search term in all columns
   */
  search?: string;

  /**
   * Column to sort response by
   */
  orderBy?: OrderBy;

  /**
   * The number of the results to return in each page
   */
  @maxValue(1000)
  @minValue(1)
  resultsPerPage?: int32;

  /**
   * The number of records matching the filter to skip
   */
  skip?: int32;
}

/**
 * Will contain the filter name and values to operate on
 */
model FilterItems {
  /**
   * The name of the field we would like to filter
   */
  field?: string;

  /**
   * List of values to filter the current field by
   */
  values?: string[];
}

/**
 * Describes a column to sort
 */
model OrderBy {
  /**
   * Describes the actual column name to sort by
   */
  field?: string;

  /**
   * Describes if results should be in ascending/descending order
   */
  order?: FirewallPolicyIdpsQuerySortOrder;
}

/**
 * Query result
 */
model QueryResults {
  /**
   * Number of total records matching the query.
   */
  matchingRecordsCount?: int64;

  /**
   * Array containing the results of the query
   */
  @identifiers(#[])
  signatures?: SingleQueryResult[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SingleQueryResult {
  /**
   * The ID of the signature
   */
  signatureId?: int32;

  /**
   * The current mode enforced, 0 - Disabled, 1 - Alert, 2 -Deny
   */
  mode?: FirewallPolicyIdpsSignatureMode;

  /**
   * Describes the severity of signature: 1 - High, 2 - Medium, 3 - Low
   */
  severity?: FirewallPolicyIdpsSignatureSeverity;

  /**
   * Describes in which direction signature is being enforced: 0 - OutBound, 1 - InBound, 2 - Any, 3 - Internal, 4 - InternalOutbound, 5 - InternalInbound
   */
  direction?: FirewallPolicyIdpsSignatureDirection;

  /**
   * Describes the groups the signature belongs to
   */
  group?: string;

  /**
   * Describes what is the signature enforces
   */
  description?: string;

  /**
   * Describes the protocol the signatures is being enforced in
   */
  protocol?: string;

  /**
   * Describes the list of source ports related to this signature
   */
  sourcePorts?: string[];

  /**
   * Describes the list of destination ports related to this signature
   */
  destinationPorts?: string[];

  /**
   * Describes the last updated time of the signature (provided from 3rd party vendor)
   */
  lastUpdated?: string;

  /**
   * Describes if this override is inherited from base policy or not
   */
  inheritedFromParentPolicy?: boolean;
}

/**
 * Will contain the properties of the resource (the actual signature overrides)
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SignaturesOverridesProperties {
  /**
   * Dictionary of <string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  signatures?: Record<string>;
}

/**
 * Describes the filter values possibles for a given column
 */
model SignatureOverridesFilterValuesQuery {
  /**
   * Describes the name of the column which values will be returned
   */
  filterName?: string;
}

/**
 * Describes the list of all possible values for a specific filter value
 */
model SignatureOverridesFilterValuesResponse {
  /**
   * Describes the possible values
   */
  filterValues?: string[];
}

/**
 * Describes an object containing an array with a single item
 */
model SignaturesOverridesList {
  /**
   * Describes a list consisting exactly one item describing the policy's signature override status
   */
  @pageItems
  value?: SignaturesOverrides[];
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FirewallPolicyDraftProperties {
  /**
   * The parent firewall policy from which rules are inherited.
   */
  basePolicy?: SubResource;

  /**
   * The operation mode for Threat Intelligence.
   */
  threatIntelMode?: AzureFirewallThreatIntelMode;

  /**
   * ThreatIntel Whitelist for Firewall Policy.
   */
  threatIntelWhitelist?: FirewallPolicyThreatIntelWhitelist;

  /**
   * Insights on Firewall Policy.
   */
  insights?: FirewallPolicyInsights;

  /**
   * The private IP addresses/IP ranges to which traffic will not be SNAT.
   */
  snat?: FirewallPolicySnat;

  /**
   * SQL Settings definition.
   */
  sql?: FirewallPolicySQL;

  /**
   * DNS Proxy Settings definition.
   */
  dnsSettings?: DnsSettings;

  /**
   * Explicit Proxy Settings definition.
   */
  explicitProxy?: ExplicitProxy;

  /**
   * The configuration for Intrusion detection.
   */
  intrusionDetection?: FirewallPolicyIntrusionDetection;
}

/**
 * Properties of the rule collection group draft.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FirewallPolicyRuleCollectionGroupDraftProperties {
  /**
   * A read-only string that represents the size of the FirewallPolicyRuleCollectionGroupProperties in MB. (ex 1.2MB)
   */
  @visibility(Lifecycle.Read)
  size?: string;

  /**
   * Priority of the Firewall Policy Rule Collection Group resource.
   */
  @maxValue(65000)
  @minValue(100)
  priority?: int32;

  /**
   * Group of Firewall Policy rule collections.
   */
  @identifiers(#[])
  ruleCollections?: FirewallPolicyRuleCollection[];
}

/**
 * List of IpamPool
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model IpamPoolList is Azure.Core.Page<IpamPool>;

/**
 * Properties of IpamPool resource properties which are specific to the Pool resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model IpamPoolProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description?: string;

  /**
   * String representing a friendly name for the resource.
   */
  displayName?: string;

  /**
   * List of IP address type for the IpamPool.
   */
  @visibility(Lifecycle.Read)
  ipAddressType?: IpType[];

  /**
   * String representing parent IpamPool resource name. If empty the IpamPool will be a root pool.
   */
  parentPoolName?: string;

  /**
   * List of IP address prefixes of the resource.
   */
  addressPrefixes: string[];

  /**
   * Provisioning states of a resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The resource model definition for an Azure Resource Manager tracked top level resource which has 'tags' and a 'location'
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("Tracked Resource")
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model CommonTrackedResource extends CommonResource {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * The geo-location where the resource lives
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
@summary("Resource")
model CommonResource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).
 */
@error
@summary("Error response")
model CommonErrorResponse {
  /**
   * The error object.
   */
  error?: CommonErrorDetail;
}

/**
 * The error detail.
 */
model CommonErrorDetail {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The error target.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * The error details.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["message", "target"])
  details?: CommonErrorDetail[];

  /**
   * The error additional info.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  additionalInfo?: CommonErrorAdditionalInfo[];
}

/**
 * The resource management error additional info.
 */
model CommonErrorAdditionalInfo {
  /**
   * The additional info type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The additional info.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  info?: unknown;
}

/**
 * Represents the IpamPool update API request interface.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model IpamPoolUpdate {
  /**
   * Dictionary of <string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Represents the IpamPool update properties.
   */
  properties?: IpamPoolUpdateProperties;
}

/**
 * Represents the IpamPool update properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model IpamPoolUpdateProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description?: string;

  /**
   * String representing a friendly name for the resource.
   */
  displayName?: string;
}

/**
 * IpamPool usage information.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PoolUsage {
  /**
   * List of IP address prefixes of the resource.
   */
  @visibility(Lifecycle.Read)
  addressPrefixes?: string[];

  /**
   * List of IpamPool that are children of this IpamPool.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["resourceId"])
  childPools?: ResourceBasics[];

  /**
   * List of assigned IP address prefixes.
   */
  @visibility(Lifecycle.Read)
  allocatedAddressPrefixes?: string[];

  /**
   * List of reserved IP address prefixes. These IP addresses could be reclaimed if not assigned in the given time.
   */
  @visibility(Lifecycle.Read)
  reservedAddressPrefixes?: string[];

  /**
   * List of available IP address prefixes.
   */
  @visibility(Lifecycle.Read)
  availableAddressPrefixes?: string[];

  /**
   * Total number of IP addresses managed in the IpamPool.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  totalNumberOfIPAddresses?: string;

  /**
   * Total number of assigned IP addresses in the IpamPool.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  numberOfAllocatedIPAddresses?: string;

  /**
   * Total number of reserved IP addresses in the IpamPool.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  numberOfReservedIPAddresses?: string;

  /**
   * Total number of available IP addresses in the IpamPool.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  numberOfAvailableIPAddresses?: string;
}

/**
 * Representation of basic resource information.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model ResourceBasics {
  /**
   * ResourceId of the Azure resource.
   */
  resourceId?: Azure.Core.armResourceIdentifier;

  /**
   * List of IP address prefixes of the resource.
   */
  addressPrefixes?: string[];
}

/**
 * List of PoolAssociation
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PoolAssociationList is Azure.Core.Page<PoolAssociation>;

/**
 * IpamPool association information.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PoolAssociation {
  /**
   * Resource id of the associated Azure resource.
   */
  resourceId: Azure.Core.armResourceIdentifier;

  /**
   * IpamPool id for which the resource is associated to.
   */
  poolId?: Azure.Core.armResourceIdentifier;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description?: string;

  /**
   * List of assigned IP address prefixes in the IpamPool of the associated resource.
   */
  @visibility(Lifecycle.Read)
  addressPrefixes?: string[];

  /**
   * List of reserved IP address prefixes in the IpamPool of the associated resource.
   */
  @visibility(Lifecycle.Read)
  reservedPrefixes?: string[];

  /**
   * Total number of assigned IP addresses of the association.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  totalNumberOfIPAddresses?: string;

  /**
   * Total number of reserved IP addresses of the association.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  numberOfReservedIPAddresses?: string;

  /**
   * Creation time of the association.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Expire time for IP addresses reserved.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reservationExpiresAt?: utcDateTime;
}

/**
 * List of StaticCidr
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model StaticCidrList is Azure.Core.Page<StaticCidr>;

/**
 * Properties of static CIDR resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model StaticCidrProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description?: string;

  /**
   * Number of IP addresses to allocate for a static CIDR resource. The IP addresses will be assigned based on IpamPools available space.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  numberOfIPAddressesToAllocate?: string;

  /**
   * List of IP address prefixes of the resource.
   */
  addressPrefixes?: string[];

  /**
   * Total number of IP addresses allocated for the static CIDR resource.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  totalNumberOfIPAddresses?: string;

  /**
   * Provisioning states of a resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The resource model definition for a Azure Resource Manager proxy resource. It will not have tags and a location
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("Proxy Resource")
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model CommonProxyResource extends CommonResource {}

/**
 * Properties of the IpAllocation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model IpAllocationPropertiesFormat {
  /**
   * The Subnet that using the prefix of this IpAllocation resource.
   */
  @visibility(Lifecycle.Read)
  subnet?: SubResource;

  /**
   * The VirtualNetwork that using the prefix of this IpAllocation resource.
   */
  @visibility(Lifecycle.Read)
  virtualNetwork?: SubResource;

  /**
   * The type for the IpAllocation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type?: IpAllocationType;

  /**
   * The address prefix for the IpAllocation.
   */
  prefix?: string;

  /**
   * The address prefix length for the IpAllocation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  prefixLength?: int32 | null = 0;

  /**
   * The address prefix Type for the IpAllocation.
   */
  prefixType?: IPVersion;

  /**
   * The IPAM allocation ID.
   */
  ipamAllocationId?: string;

  /**
   * IpAllocation tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allocationTags?: Record<string>;
}

/**
 * The IpGroups property information.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model IpGroupPropertiesFormat {
  /**
   * The provisioning state of the IpGroups resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * IpAddresses/IpAddressPrefixes in the IpGroups resource.
   */
  ipAddresses?: string[];

  /**
   * List of references to Firewall resources that this IpGroups is associated with.
   */
  @visibility(Lifecycle.Read)
  firewalls?: SubResource[];

  /**
   * List of references to Firewall Policies resources that this IpGroups is associated with.
   */
  @visibility(Lifecycle.Read)
  firewallPolicies?: SubResource[];
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
  provisioningState?: NetworkProvisioningState;

  /**
   * Indicates the scope of the load balancer: external (Public) or internal (Private).
   */
  scope?: LoadBalancerScope;
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
  provisioningState?: NetworkProvisioningState;
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
  provisioningState?: NetworkProvisioningState;
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
  provisioningState?: NetworkProvisioningState;
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
  provisioningState?: NetworkProvisioningState;

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
 * The request for a VIP swap.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
model LoadBalancerVipSwapRequest {
  /**
   * A list of frontend IP configuration resources that should swap VIPs.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  frontendIPConfigurations?: LoadBalancerVipSwapRequestFrontendIPConfiguration[];
}

/**
 * VIP swap request's frontend IP configuration object.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
model LoadBalancerVipSwapRequestFrontendIPConfiguration {
  /**
   * The ID of frontend IP configuration resource.
   */
  id?: string;

  /**
   * The properties of VIP swap request's frontend IP configuration object.
   */
  properties?: LoadBalancerVipSwapRequestFrontendIPConfigurationProperties;
}

/**
 * The properties of VIP swap request's frontend IP configuration object.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
model LoadBalancerVipSwapRequestFrontendIPConfigurationProperties {
  /**
   * A reference to public IP address resource.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicIPAddress?: SubResource;
}

/**
 * The request for a QueryInboundNatRulePortMapping API. Either IpConfiguration or IpAddress should be set
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
model QueryInboundNatRulePortMappingRequest {
  /**
   * NetworkInterfaceIPConfiguration set in load balancer backend address.
   */
  ipConfiguration?: SubResource;

  /**
   * IP address set in load balancer backend address.
   */
  ipAddress?: string;
}

/**
 * The response for a QueryInboundNatRulePortMapping API.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
model BackendAddressInboundNatRulePortMappings {
  /**
   * Collection of inbound NAT rule port mappings.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  inboundNatRulePortMappings?: InboundNatRulePortMapping[];
}

/**
 * Individual port mappings for inbound NAT rule created for backend pool.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
model InboundNatRulePortMapping {
  /**
   * Name of inbound NAT rule.
   */
  @visibility(Lifecycle.Read)
  inboundNatRuleName?: string;

  /**
   * The reference to the transport protocol used by the inbound NAT rule.
   */
  @visibility(Lifecycle.Read)
  protocol?: TransportProtocol;

  /**
   * Frontend port.
   */
  @visibility(Lifecycle.Read)
  frontendPort?: int32;

  /**
   * Backend port.
   */
  @visibility(Lifecycle.Read)
  backendPort?: int32;
}

/**
 * The response for a Health API.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
model LoadBalancerHealthPerRule {
  /**
   * Number of backend instances associated to the LB rule that are considered healthy.
   */
  up?: int32;

  /**
   * Number of backend instances associated to the LB rule that are considered unhealthy.
   */
  down?: int32;

  /**
   * Information about the health per rule of the backend addresses.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  loadBalancerBackendAddresses?: LoadBalancerHealthPerRulePerBackendAddress[];
}

/**
 * The information about health per rule per backend address.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
model LoadBalancerHealthPerRulePerBackendAddress {
  /**
   * The IP address belonging to the backend address.
   */
  ipAddress?: string;

  /**
   * Resource ID of the Network Interface IP Configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  networkInterfaceIPConfigurationId?: string;

  /**
   * The current health of the backend instances that is associated to the LB rule.
   */
  state?: string;

  /**
   * The explanation of the State
   */
  reason?: string;
}

/**
 * The request for a migrateToIpBased API.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
model MigrateLoadBalancerToIpBasedRequest {
  /**
   * A list of pool names that should be migrated from Nic based to IP based pool
   */
  pools?: string[];
}

/**
 * The response for a migrateToIpBased API.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
model MigratedPools {
  /**
   * A list of pools migrated from Nic based to IP based pool
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  migratedPools?: string[];
}

/**
 * Response for list effective route API service call.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model EffectiveRouteListResult is Azure.Core.Page<EffectiveRoute>;

/**
 * Effective Route.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model EffectiveRoute {
  /**
   * The name of the user defined route. This is optional.
   */
  name?: string;

  /**
   * If true, on-premises routes are not propagated to the network interfaces in the subnet.
   */
  disableBgpRoutePropagation?: boolean;

  /**
   * Who created the route.
   */
  source?: EffectiveRouteSource;

  /**
   * The value of effective route.
   */
  state?: EffectiveRouteState;

  /**
   * The address prefixes of the effective routes in CIDR notation.
   */
  addressPrefix?: string[];

  /**
   * The IP address of the next hop of the effective route.
   */
  nextHopIpAddress?: string[];

  /**
   * The type of Azure hop the packet should be sent to.
   */
  nextHopType?: RouteNextHopType;
}

/**
 * Response for list effective network security groups API service call.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model EffectiveNetworkSecurityGroupListResult
  is Azure.Core.Page<EffectiveNetworkSecurityGroup>;

/**
 * Effective network security group.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model EffectiveNetworkSecurityGroup {
  /**
   * The ID of network security group that is applied.
   */
  networkSecurityGroup?: SubResource;

  /**
   * Associated resources.
   */
  association?: EffectiveNetworkSecurityGroupAssociation;

  /**
   * A collection of effective security rules.
   */
  effectiveSecurityRules?: EffectiveNetworkSecurityRule[];

  /**
   * Mapping of tags to list of IP Addresses included within the tag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tagMap?: Record<string[]>;
}

/**
 * The effective network security group association.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model EffectiveNetworkSecurityGroupAssociation {
  /**
   * The ID of the Azure network manager if assigned.
   */
  networkManager?: SubResource;

  /**
   * The ID of the subnet if assigned.
   */
  subnet?: SubResource;

  /**
   * The ID of the network interface if assigned.
   */
  networkInterface?: SubResource;
}

/**
 * Effective network security rules.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model EffectiveNetworkSecurityRule {
  /**
   * The name of the security rule specified by the user (if created by the user).
   */
  name?: string;

  /**
   * The network protocol this rule applies to.
   */
  protocol?: EffectiveSecurityRuleProtocol;

  /**
   * The source port or range.
   */
  sourcePortRange?: string;

  /**
   * The destination port or range.
   */
  destinationPortRange?: string;

  /**
   * The source port ranges. Expected values include a single integer between 0 and 65535, a range using '-' as separator (e.g. 100-400), or an asterisk (*).
   */
  sourcePortRanges?: string[];

  /**
   * The destination port ranges. Expected values include a single integer between 0 and 65535, a range using '-' as separator (e.g. 100-400), or an asterisk (*).
   */
  destinationPortRanges?: string[];

  /**
   * The source address prefix.
   */
  sourceAddressPrefix?: string;

  /**
   * The destination address prefix.
   */
  destinationAddressPrefix?: string;

  /**
   * The source address prefixes. Expected values include CIDR IP ranges, Default Tags (VirtualNetwork, AzureLoadBalancer, Internet), System Tags, and the asterisk (*).
   */
  sourceAddressPrefixes?: string[];

  /**
   * The destination address prefixes. Expected values include CIDR IP ranges, Default Tags (VirtualNetwork, AzureLoadBalancer, Internet), System Tags, and the asterisk (*).
   */
  destinationAddressPrefixes?: string[];

  /**
   * The expanded source address prefix.
   */
  expandedSourceAddressPrefix?: string[];

  /**
   * Expanded destination address prefix.
   */
  expandedDestinationAddressPrefix?: string[];

  /**
   * Whether network traffic is allowed or denied.
   */
  access?: SecurityRuleAccess;

  /**
   * The priority of the rule.
   */
  priority?: int32;

  /**
   * The direction of the rule.
   */
  direction?: SecurityRuleDirection;
}

/**
 * Properties of Managed Network
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model NetworkManagerProperties {
  /**
   * A description of the network manager.
   */
  description?: string;

  /**
   * Scope of Network Manager.
   */
  networkManagerScopes: NetworkManagerPropertiesNetworkManagerScopes;

  /**
   * Scope Access.
   */
  networkManagerScopeAccesses?: ConfigurationType[];

  /**
   * The provisioning state of the network manager resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * Unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;
}

/**
 * Scope of Network Manager.
 */
model NetworkManagerPropertiesNetworkManagerScopes {
  /**
   * List of management groups.
   */
  managementGroups?: string[];

  /**
   * List of subscriptions.
   */
  subscriptions?: string[];

  /**
   * List of cross tenant scopes.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  crossTenantScopes?: CrossTenantScopes[];
}

/**
 * Cross tenant scopes.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model CrossTenantScopes {
  /**
   * Tenant ID.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * List of management groups.
   */
  @visibility(Lifecycle.Read)
  managementGroups?: string[];

  /**
   * List of subscriptions.
   */
  @visibility(Lifecycle.Read)
  subscriptions?: string[];
}

/**
 * Object for patch operations.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model PatchObject {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Network Manager Commit.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model NetworkManagerCommit {
  /**
   * Commit Id.
   */
  @visibility(Lifecycle.Read)
  commitId?: string;

  /**
   * List of target locations.
   */
  targetLocations: string[];

  /**
   * List of configuration ids.
   */
  configurationIds?: string[];

  /**
   * Commit Type.
   */
  commitType: ConfigurationType;
}

/**
 * Network Manager Deployment Status Parameter.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model NetworkManagerDeploymentStatusParameter {
  /**
   * List of locations.
   */
  regions?: string[];

  /**
   * List of deployment types.
   */
  deploymentTypes?: ConfigurationType[];

  /**
   * Continuation token for pagination, capturing the next page size and offset, as well as the context of the query.
   */
  skipToken?: string;
}

/**
 * A list of Network Manager Deployment Status
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model NetworkManagerDeploymentStatusListResult {
  /**
   * Gets a page of Network Manager Deployment Status
   */
  @pageItems
  @identifiers(#[])
  value?: NetworkManagerDeploymentStatus[];

  /**
   * When present, the value can be passed to a subsequent query call (together with the same query and scopes used in the current request) to retrieve the next page of data.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  skipToken?: string;
}

/**
 * Network Manager Deployment Status.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model NetworkManagerDeploymentStatus {
  /**
   * Commit Time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  commitTime?: utcDateTime;

  /**
   * Region Name.
   */
  region?: string;

  /**
   * Deployment Status.
   */
  deploymentStatus?: DeploymentStatus;

  /**
   * List of configuration ids.
   */
  configurationIds?: string[];

  /**
   * Configuration Deployment Type.
   */
  deploymentType?: ConfigurationType;

  /**
   * Error Message.
   */
  errorMessage?: string;
}

/**
 * Effective Virtual Networks Parameter.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model ActiveConfigurationParameter {
  /**
   * List of regions.
   */
  regions?: string[];

  /**
   * When present, the value can be passed to a subsequent query call (together with the same query and scopes used in the current request) to retrieve the next page of data.
   */
  skipToken?: string;
}

/**
 * Result of the request to list active connectivity configurations. It contains a list of active connectivity configurations and a skiptoken to get the next set of results.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model ActiveConnectivityConfigurationsListResult {
  /**
   * Gets a page of active connectivity configurations.
   */
  @pageItems
  value?: ActiveConnectivityConfiguration[];

  /**
   * When present, the value can be passed to a subsequent query call (together with the same query and scopes used in the current request) to retrieve the next page of data.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  skipToken?: string;
}

/**
 * Active connectivity configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model ActiveConnectivityConfiguration
  extends EffectiveConnectivityConfiguration {
  /**
   * Deployment time string.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  commitTime?: utcDateTime;

  /**
   * Deployment region.
   */
  region?: string;
}

/**
 * The network manager effective connectivity configuration
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model EffectiveConnectivityConfiguration {
  /**
   * Connectivity configuration ID.
   */
  id?: string;

  /**
   * Properties of a network manager connectivity configuration
   */
  properties?: ConnectivityConfigurationProperties;

  /**
   * Effective configuration groups.
   */
  configurationGroups?: ConfigurationGroup[];
}

/**
 * Properties of network manager connectivity configuration
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model ConnectivityConfigurationProperties {
  /**
   * A description of the connectivity configuration.
   */
  description?: string;

  /**
   * Connectivity topology type.
   */
  connectivityTopology: ConnectivityTopology;

  /**
   * List of hubItems
   */
  @identifiers(#["resourceId"])
  hubs?: Hub[];

  /**
   * Flag if global mesh is supported.
   */
  isGlobal?: IsGlobal;

  /**
   * Collection of additional settings to enhance specific topology behaviors of the connectivity configuration resource.
   */
  connectivityCapabilities?: ConnectivityConfigurationPropertiesConnectivityCapabilities;

  /**
   * Groups for configuration
   */
  @identifiers(#["networkGroupId"])
  appliesToGroups: ConnectivityGroupItem[];

  /**
   * The provisioning state of the connectivity configuration resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * Flag if need to remove current existing peerings.
   */
  deleteExistingPeering?: DeleteExistingPeering;

  /**
   * Unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;
}

/**
 * Hub Item.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model Hub {
  /**
   * Resource Id.
   */
  resourceId?: string;

  /**
   * Resource Type.
   */
  resourceType?: string;
}

/**
 * Collection of additional settings to enhance specific topology behaviors of the connectivity configuration resource.
 */
model ConnectivityConfigurationPropertiesConnectivityCapabilities {
  /**
   * Option indicating the scale of private endpoints allowed in the connected group of the connectivity configuration.
   */
  connectedGroupPrivateEndpointsScale: ConnectedGroupPrivateEndpointsScale = ConnectedGroupPrivateEndpointsScale.Standard;

  /**
   * Behavior to handle overlapped IP address space among members of the connected group of the connectivity configuration.
   */
  connectedGroupAddressOverlap: ConnectedGroupAddressOverlap = ConnectedGroupAddressOverlap.Allowed;

  /**
   * Option indicating enforcement of peerings created by the connectivity configuration.
   */
  peeringEnforcement: PeeringEnforcement = PeeringEnforcement.Unenforced;
}

/**
 * Connectivity group item.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model ConnectivityGroupItem {
  /**
   * Network group Id.
   */
  networkGroupId: string;

  /**
   * Flag if need to use hub gateway.
   */
  useHubGateway?: UseHubGateway;

  /**
   * Flag if global is supported.
   */
  isGlobal?: IsGlobal;

  /**
   * Group connectivity type.
   */
  groupConnectivity: GroupConnectivity;
}

/**
 * The network configuration group resource
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model ConfigurationGroup {
  /**
   * Network group ID.
   */
  id?: string;

  /**
   * The network configuration group properties
   */
  properties?: NetworkGroupProperties;
}

/**
 * Properties of network group
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model NetworkGroupProperties {
  /**
   * A description of the network group.
   */
  description?: string;

  /**
   * The type of the group member.
   */
  memberType?: GroupMemberType;

  /**
   * The provisioning state of the scope assignment resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * Unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;
}

/**
 * Result of the request to list active security admin rules. It contains a list of active security admin rules and a skiptoken to get the next set of results.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model ActiveSecurityAdminRulesListResult {
  /**
   * Gets a page of active security admin rules.
   */
  @pageItems
  value?: ActiveBaseSecurityAdminRule[];

  /**
   * When present, the value can be passed to a subsequent query call (together with the same query and scopes used in the current request) to retrieve the next page of data.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  skipToken?: string;
}

/**
 * Network base admin rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
@discriminator("kind")
model ActiveBaseSecurityAdminRule {
  /**
   * Resource ID.
   */
  id?: string;

  /**
   * Deployment time string.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  commitTime?: utcDateTime;

  /**
   * Deployment region.
   */
  region?: string;

  /**
   * A description of the security admin configuration.
   */
  configurationDescription?: string;

  /**
   * A description of the rule collection.
   */
  ruleCollectionDescription?: string;

  /**
   * Groups for rule collection
   */
  @identifiers(#[])
  ruleCollectionAppliesToGroups?: NetworkManagerSecurityGroupItem[];

  /**
   * Effective configuration groups.
   */
  ruleGroups?: ConfigurationGroup[];

  /**
   * Whether the rule is custom or default.
   */
  kind: EffectiveAdminRuleKind;
}

/**
 * Network manager security group item.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model NetworkManagerSecurityGroupItem {
  /**
   * Network manager group Id.
   */
  networkGroupId: string;
}

/**
 * Information about the network manager connection.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model NetworkManagerConnectionProperties {
  /**
   * Network Manager Id.
   */
  networkManagerId?: string;

  /**
   * Connection state.
   */
  @visibility(Lifecycle.Read)
  connectionState?: ScopeConnectionState;

  /**
   * A description of the network manager connection.
   */
  description?: string;
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
 * Common resource representation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model WritableResource {
  /**
   * Resource ID.
   */
  id?: string;

  /**
   * Resource name.
   */
  name?: string;

  /**
   * Resource type.
   */
  type?: string;
}

/**
 * Common resource representation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model ResourceWithWritableName {
  /**
   * Resource ID.
   */
  id?: string;

  /**
   * Resource name.
   */
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
 * Common resource representation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model ResourceWithRequiredLocation {
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
  location: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Common resource representation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model ResourceWithReadOnlyNameAndID {
  /**
   * Resource ID.
   */
  @visibility(Lifecycle.Read)
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
 * Common resource representation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model ResourceWithReadOnlyID {
  /**
   * Resource ID.
   */
  @visibility(Lifecycle.Read)
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
 * Proxy resource representation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model ChildResource {
  /**
   * Resource ID.
   */
  @visibility(Lifecycle.Read)
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
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Query Request Options
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model QueryRequestOptions {
  /**
   * When present, the value can be passed to a subsequent query call (together with the same query and scopes used in the current request) to retrieve the next page of data.
   */
  skipToken?: string;
}

/**
 * Result of the request to list networkManagerEffectiveConnectivityConfiguration. It contains a list of groups and a skiptoken to get the next set of results.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model NetworkManagerEffectiveConnectivityConfigurationListResult {
  /**
   * Gets a page of NetworkManagerEffectiveConnectivityConfiguration
   */
  @pageItems
  value?: EffectiveConnectivityConfiguration[];

  /**
   * When present, the value can be passed to a subsequent query call (together with the same query and scopes used in the current request) to retrieve the next page of data.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  skipToken?: string;
}

/**
 * Result of the request to list networkManagerEffectiveSecurityAdminRules. It contains a list of groups and a skiptoken to get the next set of results.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model NetworkManagerEffectiveSecurityAdminRulesListResult {
  /**
   * Gets a page of NetworkManagerEffectiveSecurityAdminRules
   */
  @pageItems
  value?: EffectiveBaseSecurityAdminRule[];

  /**
   * When present, the value can be passed to a subsequent query call (together with the same query and scopes used in the current request) to retrieve the next page of data.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  skipToken?: string;
}

/**
 * Network base admin rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
@discriminator("kind")
model EffectiveBaseSecurityAdminRule {
  /**
   * Resource ID.
   */
  id?: string;

  /**
   * A description of the security admin configuration.
   */
  configurationDescription?: string;

  /**
   * A description of the rule collection.
   */
  ruleCollectionDescription?: string;

  /**
   * Groups for rule collection
   */
  @identifiers(#["networkGroupId"])
  ruleCollectionAppliesToGroups?: NetworkManagerSecurityGroupItem[];

  /**
   * Effective configuration groups.
   */
  ruleGroups?: ConfigurationGroup[];

  /**
   * Whether the rule is custom or default.
   */
  kind: EffectiveAdminRuleKind;
}

/**
 * Properties of static member.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model StaticMemberProperties {
  /**
   * Resource Id.
   */
  resourceId?: string;

  /**
   * Resource region.
   */
  @visibility(Lifecycle.Read)
  region?: string;

  /**
   * The provisioning state of the scope assignment resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Defines the routing configuration properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model NetworkManagerRoutingConfigurationPropertiesFormat {
  /**
   * A description of the routing configuration.
   */
  description?: string;

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * Unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * Route table usage mode defines which route table will be used by the configuration. If not defined, this will default to 'ManagedOnly'.
   */
  routeTableUsageMode?: RouteTableUsageMode = RouteTableUsageMode.ManagedOnly;
}

/**
 * Defines the routing rule collection properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model RoutingRuleCollectionPropertiesFormat {
  /**
   * A description of the routing rule collection.
   */
  description?: string;

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * Unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * Groups for configuration
   */
  @identifiers(#["networkGroupId"])
  appliesTo: NetworkManagerRoutingGroupItem[];

  /**
   * Determines whether BGP route propagation is enabled. Defaults to true.
   */
  disableBgpRoutePropagation?: DisableBgpRoutePropagation;
}

/**
 * Network manager routing group item.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model NetworkManagerRoutingGroupItem {
  /**
   * Network manager group Id.
   */
  networkGroupId: string;
}

/**
 * Routing rule resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model RoutingRulePropertiesFormat {
  /**
   * A description for this rule.
   */
  description?: string;

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * Unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * Indicates the destination for this particular rule.
   */
  destination: RoutingRuleRouteDestination;

  /**
   * Indicates the next hop for this particular rule.
   */
  nextHop: RoutingRuleNextHop;
}

/**
 * Route destination.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model RoutingRuleRouteDestination {
  /**
   * Destination type.
   */
  type: RoutingRuleDestinationType;

  /**
   * Destination address.
   */
  destinationAddress: string;
}

/**
 * Next hop.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model RoutingRuleNextHop {
  /**
   * Next hop type.
   */
  nextHopType: RoutingRuleNextHopType;

  /**
   * Next hop address. Only required if the next hop type is VirtualAppliance.
   */
  nextHopAddress?: string;
}

/**
 * Scope connection.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model ScopeConnectionProperties {
  /**
   * Tenant ID.
   */
  tenantId?: string;

  /**
   * Resource ID.
   */
  resourceId?: string;

  /**
   * Connection State
   */
  @visibility(Lifecycle.Read)
  connectionState?: ScopeConnectionState;

  /**
   * A description of the scope connection.
   */
  description?: string;
}

/**
 * Defines the security admin configuration properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model SecurityAdminConfigurationPropertiesFormat {
  /**
   * A description of the security configuration.
   */
  description?: string;

  /**
   * Enum list of network intent policy based services.
   */
  applyOnNetworkIntentPolicyBasedServices?: NetworkIntentPolicyBasedService[];

  /**
   * Determine update behavior for changes to network groups referenced within the rules in this configuration.
   */
  networkGroupAddressSpaceAggregationOption?: AddressSpaceAggregationOption;

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;
}

/**
 * Defines the admin rule collection properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model AdminRuleCollectionPropertiesFormat {
  /**
   * A description of the admin rule collection.
   */
  description?: string;

  /**
   * Groups for configuration
   */
  @identifiers(#["networkGroupId"])
  appliesToGroups: NetworkManagerSecurityGroupItem[];

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;
}

/**
 * Defines the security user configuration properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model SecurityUserConfigurationPropertiesFormat {
  /**
   * A description of the security user configuration.
   */
  description?: string;

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * Unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;
}

/**
 * Defines the security user rule collection properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model SecurityUserRuleCollectionPropertiesFormat {
  /**
   * A description of the security user rule collection.
   */
  description?: string;

  /**
   * Groups for configuration
   */
  @identifiers(#["networkGroupId"])
  appliesToGroups: SecurityUserGroupItem[];

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * Unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;
}

/**
 * Network manager security user group item.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model SecurityUserGroupItem {
  /**
   * Network manager group Id.
   */
  networkGroupId: string;
}

/**
 * Security rule resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model SecurityUserRulePropertiesFormat {
  /**
   * A description for this rule.
   */
  description?: string;

  /**
   * Network protocol this rule applies to.
   */
  protocol: SecurityConfigurationRuleProtocol;

  /**
   * The CIDR or source IP ranges.
   */
  @identifiers(#["addressPrefix"])
  sources?: AddressPrefixItem[];

  /**
   * The destination address prefixes. CIDR or destination IP ranges.
   */
  @identifiers(#["addressPrefix"])
  destinations?: AddressPrefixItem[];

  /**
   * The source port ranges.
   */
  sourcePortRanges?: string[];

  /**
   * The destination port ranges.
   */
  destinationPortRanges?: string[];

  /**
   * Indicates if the traffic matched against the rule in inbound or outbound.
   */
  direction: SecurityConfigurationRuleDirection;

  /**
   * The provisioning state of the security configuration user rule resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * Unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;
}

/**
 * Address prefix item.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model AddressPrefixItem {
  /**
   * Address prefix.
   */
  addressPrefix?: string;

  /**
   * Address prefix type.
   */
  addressPrefixType?: AddressPrefixType;
}

/**
 * Network profile properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model NetworkProfilePropertiesFormat {
  /**
   * List of child container network interfaces.
   */
  @visibility(Lifecycle.Read)
  containerNetworkInterfaces?: ContainerNetworkInterface[];

  /**
   * List of chid container network interface configurations.
   */
  containerNetworkInterfaceConfigurations?: ContainerNetworkInterfaceConfiguration[];

  /**
   * The resource GUID property of the network profile resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The provisioning state of the network profile resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Container network interface child resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model ContainerNetworkInterface extends SubResource {
  /**
   * Container network interface properties.
   */
  properties?: ContainerNetworkInterfacePropertiesFormat;

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
 * Properties of container network interface.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model ContainerNetworkInterfacePropertiesFormat {
  /**
   * Container network interface configuration from which this container network interface is created.
   */
  @visibility(Lifecycle.Read)
  containerNetworkInterfaceConfiguration?: ContainerNetworkInterfaceConfiguration;

  /**
   * Reference to the container to which this container network interface is attached.
   */
  container?: Container;

  /**
   * Reference to the ip configuration on this container nic.
   */
  @visibility(Lifecycle.Read)
  ipConfigurations?: ContainerNetworkInterfaceIpConfiguration[];

  /**
   * The provisioning state of the container network interface resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Container network interface configuration child resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model ContainerNetworkInterfaceConfiguration extends SubResource {
  /**
   * Container network interface configuration properties.
   */
  properties?: ContainerNetworkInterfaceConfigurationPropertiesFormat;

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
 * Container network interface configuration properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model ContainerNetworkInterfaceConfigurationPropertiesFormat {
  /**
   * A list of ip configurations of the container network interface configuration.
   */
  ipConfigurations?: IPConfigurationProfile[];

  /**
   * A list of container network interfaces created from this container network interface configuration.
   */
  containerNetworkInterfaces?: SubResource[];

  /**
   * The provisioning state of the container network interface configuration resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Reference to container resource in remote resource provider.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model Container extends SubResource {}

/**
 * The ip configuration for a container network interface.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model ContainerNetworkInterfaceIpConfiguration {
  /**
   * Properties of the container network interface IP configuration.
   */
  properties?: ContainerNetworkInterfaceIpConfigurationPropertiesFormat;

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
 * Properties of the container network interface IP configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model ContainerNetworkInterfaceIpConfigurationPropertiesFormat {
  /**
   * The provisioning state of the container network interface IP configuration resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Properties of network security perimeter.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkSecurityPerimeter)
model NetworkSecurityPerimeterProperties {
  /**
   * The provisioning state of the scope assignment resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NspProvisioningState;

  /**
   * perimeter guid of the network security perimeter.
   */
  @visibility(Lifecycle.Read)
  perimeterGuid?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model SecurityPerimeterResource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SecurityPerimeterSystemData;
}

/**
 * Metadata pertaining to creation and last modification of the resource.
 */
model SecurityPerimeterSystemData {
  /**
   * The identity that created the resource.
   */
  createdBy?: string;

  /**
   * The type of identity that created the resource.
   */
  createdByType?: CreatedByType;

  /**
   * The timestamp of resource creation (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The identity that last modified the resource.
   */
  lastModifiedBy?: string;

  /**
   * The type of identity that last modified the resource.
   */
  lastModifiedByType?: CreatedByType;

  /**
   * The timestamp of resource last modification (UTC)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

/**
 * Update tags request.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkSecurityPerimeter)
model UpdateTagsRequest {
  /**
   * Network security perimeter identifier.
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/networkSecurityPerimeters";
    }
  ]>;

  /**
   * List of tags for Network Security Perimeter
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Properties of NSP profile.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkSecurityPerimeter)
model NspProfileProperties {
  /**
   * Version number that increases with every update to access rules within the profile.
   */
  @visibility(Lifecycle.Read)
  accessRulesVersion?: string;

  /**
   * Version number that increases with every update to diagnostic settings within the profile.
   */
  @visibility(Lifecycle.Read)
  diagnosticSettingsVersion?: string;
}

/**
 * The resource model definition for a Azure Resource Manager proxy resource. It will not have tags and a location
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecurityPerimeterProxyResource extends SecurityPerimeterResource {}

/**
 * Properties of NSP access rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkSecurityPerimeter)
model NspAccessRuleProperties {
  /**
   * The provisioning state of the scope assignment resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NspProvisioningState;

  /**
   * Direction that specifies whether the access rules is inbound/outbound.
   */
  direction?: AccessRuleDirection;

  /**
   * Inbound address prefixes (IPv4/IPv6)
   */
  addressPrefixes?: string[];

  /**
   * Outbound rules in fully qualified domain name format.
   */
  fullyQualifiedDomainNames?: string[];

  /**
   * List of subscription ids
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  subscriptions?: SubscriptionId[];

  /**
   * Rule specified by the perimeter id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  networkSecurityPerimeters?: PerimeterBasedAccessRule[];

  /**
   * Outbound rules in email address format. This access rule type is currently unavailable for use.
   */
  emailAddresses?: string[];

  /**
   * Outbound rules in phone number format. This access rule type is currently unavailable for use.
   */
  phoneNumbers?: string[];

  /**
   * Inbound rules of type service tag. This access rule type is currently unavailable for use.
   */
  serviceTags?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkSecurityPerimeter)
model SubscriptionId {
  /**
   * Subscription id in the ARM id format.
   */
  id?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Resources/subscriptions";
    }
  ]>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkSecurityPerimeter)
model PerimeterBasedAccessRule {
  /**
   * NSP id in the ARM id format.
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/networkSecurityPerimeters";
    }
  ]>;

  /**
   * Resource guid of the NSP supplied.
   */
  @visibility(Lifecycle.Read)
  perimeterGuid?: string;

  /**
   * Location of the NSP supplied.
   */
  @visibility(Lifecycle.Read)
  location?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkSecurityPerimeter)
model NspAssociationProperties {
  /**
   * The provisioning state of the resource  association resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NspProvisioningState;

  /**
   * The PaaS resource to be associated.
   */
  privateLinkResource?: SubResource;

  /**
   * Profile id to which the PaaS resource is associated.
   */
  profile?: SubResource;

  /**
   * Access mode on the association.
   */
  accessMode?: AssociationAccessMode;

  /**
   * Specifies if there are provisioning issues
   */
  @visibility(Lifecycle.Read)
  hasProvisioningIssues?: string;
}

/**
 * Resource that is onboarded to use network security perimeter. Also referred as perimeter associable resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkSecurityPerimeter)
model PerimeterAssociableResource {
  /**
   * Properties of the perimeter associable resource.
   */
  properties?: PerimeterAssociableResourceProperties;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  name?: string;

  /**
   * Identifier of the perimeter associable resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Properties of the perimeter associable resources.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkSecurityPerimeter)
model PerimeterAssociableResourceProperties {
  /**
   * A friendly name for the properties of perimeter associable resources.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Resource type/provider name.
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * Public DNS zone names of the resources.
   */
  @visibility(Lifecycle.Read)
  publicDnsZones?: string[];
}

/**
 * Properties of NSP Link resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkSecurityPerimeter)
model NspLinkProperties {
  /**
   * The provisioning state of the NSP Link resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NspLinkProvisioningState;

  /**
   * Perimeter ARM Id for the remote NSP with which the link gets created in Auto-approval mode. It should be used when the NSP admin have Microsoft.Network/networkSecurityPerimeters/linkPerimeter/action permission on the remote NSP resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  autoApprovedRemotePerimeterResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/networkSecurityPerimeters";
    }
  ]>;

  /**
   * Remote NSP Guid with which the link gets created.
   */
  @visibility(Lifecycle.Read)
  remotePerimeterGuid?: string;

  /**
   * Remote NSP location with which the link gets created.
   */
  @visibility(Lifecycle.Read)
  remotePerimeterLocation?: string;

  /**
   * Local Inbound profile names to which Inbound is allowed. Use ['*'] to allow inbound to all profiles.
   */
  @uniqueItems
  localInboundProfiles?: string[];

  /**
   * Local Outbound profile names from which Outbound is allowed. In current version, it is readonly property and it's value is set to ['*'] to allow outbound from all profiles. In later version, user will be able to modify it.
   */
  @uniqueItems
  @visibility(Lifecycle.Read)
  localOutboundProfiles?: string[];

  /**
   * Remote Inbound profile names to which Inbound is allowed. Use ['*'] to allow inbound to all profiles. This property can only be updated in auto-approval mode.
   */
  @uniqueItems
  remoteInboundProfiles?: string[];

  /**
   * Remote Outbound profile names from which Outbound is allowed. In current version, it is readonly property and it's value is set to ['*'] to allow outbound from all profiles. In later version, user will be able to modify it.
   */
  @uniqueItems
  @visibility(Lifecycle.Read)
  remoteOutboundProfiles?: string[];

  /**
   * A message passed to the owner of the remote NSP link resource with this connection request. In case of Auto-approved flow, it is default to 'Auto Approved'. Restricted to 140 chars.
   */
  description?: string;

  /**
   * The NSP link state.
   */
  @visibility(Lifecycle.Read)
  status?: NspLinkStatus;
}

/**
 * Properties of NSP LinkReference resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkSecurityPerimeter)
model NspLinkReferenceProperties {
  /**
   * The provisioning state of the NSP LinkReference resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NspLinkProvisioningState;

  /**
   * Perimeter ARM Id for the remote NSP with which the link is created.
   */
  @visibility(Lifecycle.Read)
  remotePerimeterResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/networkSecurityPerimeters";
    }
  ]>;

  /**
   * Remote NSP Guid with which the link is created.
   */
  @visibility(Lifecycle.Read)
  remotePerimeterGuid?: string;

  /**
   * Remote NSP location with which the link gets created.
   */
  @visibility(Lifecycle.Read)
  remotePerimeterLocation?: string;

  /**
   * Local Inbound profile names to which Inbound is allowed. Use ['*'] to allow inbound to all profiles.
   */
  @uniqueItems
  localInboundProfiles?: string[];

  /**
   * Local Outbound profile names from which Outbound is allowed. In current version, it is readonly property and it's value is set to ['*'] to allow outbound from all profiles. In later version, user will be able to modify it.
   */
  @uniqueItems
  @visibility(Lifecycle.Read)
  localOutboundProfiles?: string[];

  /**
   * Remote Inbound profile names to which Inbound is allowed. ['*'] value implies inbound is allowed to all profiles at remote perimeter. This property can only be updated from corresponding link resource present in remote perimeter.
   */
  @visibility(Lifecycle.Read)
  remoteInboundProfiles?: string[];

  /**
   * Remote Outbound profile names from which Outbound is allowed. ['*'] value implies outbound is allowed from all profiles at remote perimeter. This property can only be updated from corresponding link resource present in remote perimeter.
   */
  @visibility(Lifecycle.Read)
  remoteOutboundProfiles?: string[];

  /**
   * A message sent by the remote NSP link admin for connection request. In case of Auto-approved flow, it is default to 'Auto Approved'.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The NSP linkReference state. It cannot be changed if link is created in auto-approval mode.
   */
  status?: NspLinkStatus;
}

/**
 * The NSP logging configuration properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkSecurityPerimeter)
model NspLoggingConfigurationProperties {
  /**
   * The log categories to enable in the NSP logging configuration.
   */
  enabledLogCategories?: string[];

  /**
   * The version of the NSP logging configuration.
   */
  version?: string;
}

/**
 * Result of the request to list NSP service tags.
 */
model NspServiceTagsListResult is Azure.Core.Page<NspServiceTagsResource>;

/**
 * Resource containing list of NSP service tags.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkSecurityPerimeter)
model NspServiceTagsResource {
  /**
   * NSP service tags.
   */
  serviceTags?: string[];
}

/**
 * Represents the Reachability Analysis Intent properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model ReachabilityAnalysisIntentProperties {
  /**
   * Provisioning states of a resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description?: string;

  /**
   * Source resource id to verify the reachability path of.
   */
  sourceResourceId: Azure.Core.armResourceIdentifier;

  /**
   * Destination resource id to verify the reachability path of.
   */
  destinationResourceId: Azure.Core.armResourceIdentifier;

  /**
   * IP traffic information.
   */
  ipTraffic: IPTraffic;
}

/**
 * IP traffic information.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model IPTraffic {
  /**
   * List of source IP addresses of the traffic..
   */
  sourceIps: string[];

  /**
   * List of destination IP addresses of the traffic..
   */
  destinationIps: string[];

  /**
   * The source ports of the traffic.
   */
  sourcePorts: string[];

  /**
   * The destination ports of the traffic.
   */
  destinationPorts: string[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  protocols: NetworkProtocol[];
}

/**
 * Represents the Reachability Analysis Run properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model ReachabilityAnalysisRunProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description?: string;

  /**
   * Id of the intent resource to run analysis on.
   */
  intentId: string;

  /**
   * Intent information.
   */
  @visibility(Lifecycle.Read)
  intentContent?: IntentContent;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  analysisResult?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * Provisioning states of a resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Intent information.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model IntentContent {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description?: string;

  /**
   * Source resource id of the intent.
   */
  sourceResourceId: Azure.Core.armResourceIdentifier;

  /**
   * Destination resource id of the intent.
   */
  destinationResourceId: Azure.Core.armResourceIdentifier;

  /**
   * IP traffic information.
   */
  ipTraffic: IPTraffic;
}

/**
 * Properties of Verifier Workspace resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VerifierWorkspaceProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description?: string;

  /**
   * Provisioning states of a resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Represents the VerifierWorkspace update API request interface.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VerifierWorkspaceUpdate {
  /**
   * Dictionary of <string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Represents the VerifierWorkspace update properties.
   */
  properties?: VerifierWorkspaceUpdateProperties;
}

/**
 * Represents the VerifierWorkspace update properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VerifierWorkspaceUpdateProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  description?: string;
}

/**
 * Network Virtual Appliance definition.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model NetworkVirtualAppliancePropertiesFormat {
  /**
   * Network Virtual Appliance SKU.
   */
  nvaSku?: VirtualApplianceSkuProperties;

  /**
   * Address Prefix.
   */
  @visibility(Lifecycle.Read)
  addressPrefix?: string;

  /**
   * BootStrapConfigurationBlobs storage URLs.
   */
  bootStrapConfigurationBlobs?: string[];

  /**
   * The Virtual Hub where Network Virtual Appliance is being deployed.
   */
  virtualHub?: SubResource;

  /**
   * CloudInitConfigurationBlob storage URLs.
   */
  cloudInitConfigurationBlobs?: string[];

  /**
   * CloudInitConfiguration string in plain text.
   */
  cloudInitConfiguration?: string;

  /**
   * VirtualAppliance ASN. Microsoft private, public and IANA reserved ASN are not supported.
   */
  @minValue(0)
  @maxValue(4294967295)
  virtualApplianceAsn?: int64;

  /**
   * Public key for SSH login.
   */
  sshPublicKey?: string;

  /**
   * List of Virtual Appliance Network Interfaces.
   */
  @visibility(Lifecycle.Read)
  virtualApplianceNics?: VirtualApplianceNicProperties[];

  /**
   * Network Profile containing configurations for Public and Private NIC.
   */
  networkProfile?: NetworkVirtualAppliancePropertiesFormatNetworkProfile;

  /**
   * Details required for Additional Network Interface. This property is not compatible with the NVA deployed in VNets.
   */
  @identifiers(#[])
  additionalNics?: VirtualApplianceAdditionalNicProperties[];

  /**
   * List of Resource Uri of Public IPs for Internet Ingress Scenario.
   */
  @identifiers(#[])
  internetIngressPublicIps?: InternetIngressPublicIpsProperties[];

  /**
   * List of references to VirtualApplianceSite.
   */
  @visibility(Lifecycle.Read)
  virtualApplianceSites?: SubResource[];

  /**
   * List of references to VirtualApplianceConnections.
   */
  @visibility(Lifecycle.Read)
  virtualApplianceConnections?: SubResource[];

  /**
   * List of references to InboundSecurityRules.
   */
  @visibility(Lifecycle.Read)
  inboundSecurityRules?: SubResource[];

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The deployment type. PartnerManaged for the SaaS NVA
   */
  @visibility(Lifecycle.Read)
  deploymentType?: string;

  /**
   * The delegation for the Virtual Appliance. Only appliable for SaaS NVA.
   */
  delegation?: DelegationProperties;

  /**
   * The delegation for the Virtual Appliance
   */
  partnerManagedResource?: PartnerManagedResourceProperties;

  /**
   * The NVA in VNet interface configurations
   */
  @maxItems(3)
  nvaInterfaceConfigurations?: NvaInterfaceConfigurationsProperties[];

  /**
   * A Internal Load Balancer's HA port frontend IP address. Can be used to set routes & UDR to load balance traffic between NVA instances
   */
  @visibility(Lifecycle.Read)
  privateIpAddress?: string;
}

/**
 * Network Virtual Appliance Sku Properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VirtualApplianceSkuProperties {
  /**
   * Virtual Appliance Vendor.
   */
  vendor?: string;

  /**
   * Virtual Appliance Scale Unit.
   */
  bundledScaleUnit?: string;

  /**
   * Virtual Appliance Version.
   */
  marketPlaceVersion?: string;
}

/**
 * Network Virtual Appliance NIC properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VirtualApplianceNicProperties {
  /**
   * NIC type - PublicNic, PrivateNic, or AdditionalNic; AdditionalPrivateNic and AdditionalPublicNic are only supported for NVAs deployed in VNets.
   */
  @visibility(Lifecycle.Read)
  nicType?: NicTypeInResponse;

  /**
   * NIC name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Public IP address.
   */
  @visibility(Lifecycle.Read)
  publicIpAddress?: string;

  /**
   * Private IP address.
   */
  @visibility(Lifecycle.Read)
  privateIpAddress?: string;

  /**
   * Instance on which nic is attached.
   */
  @visibility(Lifecycle.Read)
  instanceName?: string;
}

/**
 * Network Profile containing configurations for Public and Private NIC.
 */
model NetworkVirtualAppliancePropertiesFormatNetworkProfile {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  networkInterfaceConfigurations?: VirtualApplianceNetworkInterfaceConfiguration[];
}

/**
 * Represents a single NIC configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VirtualApplianceNetworkInterfaceConfiguration {
  /**
   * NIC type. This should be either PublicNic or PrivateNic.
   */
  type?: NicTypeInRequest;

  /**
   * Represents a single NIC configuration properties.
   */
  properties?: VirtualApplianceNetworkInterfaceConfigurationProperties;
}

/**
 * Represents a single NIC configuration properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VirtualApplianceNetworkInterfaceConfigurationProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  ipConfigurations?: VirtualApplianceIPConfiguration[];
}

/**
 * Represents a single IP configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VirtualApplianceIPConfiguration {
  /**
   * For hub NVAs, primary IP configs must be named 'privatenicipconfig' and 'publicnicipconfig', with non-primary configs using these prefixes; no naming restrictions apply for NVAs in VNets. Maximum 80 character are allowed.
   */
  name?: string;

  /**
   * Represents a single IP configuration properties.
   */
  properties?: VirtualApplianceIPConfigurationProperties;
}

/**
 * Represents a single IP configuration properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VirtualApplianceIPConfigurationProperties {
  /**
   * Whether or not this is primary IP configuration of the NIC.
   */
  primary?: boolean;
}

/**
 * Network Virtual Appliance Additional NIC properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@summary("Network Virtual Appliance Additional Nic Properties")
model VirtualApplianceAdditionalNicProperties {
  /**
   * Name of additional nic
   */
  name?: string;

  /**
   * Flag (true or false) for Intent for Public Ip on additional nic
   */
  hasPublicIp?: boolean;
}

/**
 * Resource Uri of Public Ip for Standard Load Balancer Frontend End.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@summary("Internet Ingress Public Ip Properties")
model InternetIngressPublicIpsProperties {
  /**
   * Resource Uri of Public Ip
   */
  id?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/publicIPAddresses";
    }
  ]>;
}

/**
 * Properties of the delegation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model DelegationProperties {
  /**
   * The service name to which the NVA is delegated.
   */
  serviceName?: string;

  /**
   * Provisioning states of a resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Properties of the partner managed resource. Only appliable for SaaS NVA.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PartnerManagedResourceProperties {
  /**
   * The partner managed resource id.
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier<[
    {
      type: "PaloAltoNetworks.Cloudngfw/firewalls";
    }
  ]>;

  /**
   * The partner managed ILB resource id
   */
  @visibility(Lifecycle.Read)
  internalLoadBalancerId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/loadBalancers";
    }
  ]>;

  /**
   * The partner managed SLB resource id
   */
  @visibility(Lifecycle.Read)
  standardLoadBalancerId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/loadBalancers";
    }
  ]>;
}

/**
 * Specifies input parameters required NVA in VNet interface configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model NvaInterfaceConfigurationsProperties {
  /**
   * A subnet resource id where the NIC will be deployed. Each subnet resource uri should be unique.
   */
  subnet?: NvaInVnetSubnetReferenceProperties;

  /**
   * Specifies the NIC types for the NVA interface configuration. Allowed values: PrivateNic, PublicNic, AdditionalPrivateNic, AdditionalPublicNic. Only the combination of PrivateNic and PublicNic is currently supported.
   */
  type?: NvaNicType[];

  /**
   * Specifies the name of the interface. Maximum length is 70 characters.
   */
  @maxLength(70)
  name?: string;
}

/**
 * The resource URI of the subnets where the NVA NICS will be deployed
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@summary("Subnet references where the NVA NICS will be deployed")
model NvaInVnetSubnetReferenceProperties {
  /**
   * Resource Uri of Subnet
   */
  id?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;
}

/**
 * Specifies a list of virtual machine instance IDs from the Network Virtual Appliance VM instances.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model NetworkVirtualApplianceInstanceIds {
  /**
   * The network virtual appliance instance ids. Omitting the network virtual appliance instance ids will result in the operation being performed on all virtual machines belonging to the network virtual appliance.
   */
  instanceIds?: string[];
}

/**
 * Specifies input parameters required to retrieve the boot diagnostic logs for an NVA instance
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model NetworkVirtualApplianceBootDiagnosticParameters {
  /**
   * The network virtual appliance instance id for which boot diagnostic logs is being requested
   */
  instanceId?: int32;

  /**
   * Specifies the sas-url to the storage blob into which serial console logs for the requested instance will be written
   */
  serialConsoleStorageSasUrl?: url;

  /**
   * Specifies the sas-url to the storage blob into which console screen shot for the requested instance will be written
   */
  consoleScreenshotStorageSasUrl?: url;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model NetworkVirtualApplianceInstanceId {
  /**
   * The network virtual appliance instance id for which boot diagnostic logs is being requested
   */
  instanceId?: int32;
}

/**
 * Properties of the rule group.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VirtualApplianceSiteProperties {
  /**
   * Address Prefix.
   */
  addressPrefix?: string;

  /**
   * Office 365 Policy.
   */
  o365Policy?: Office365PolicyProperties;

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Network Virtual Appliance Sku Properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model Office365PolicyProperties {
  /**
   * Office 365 breakout categories.
   */
  breakOutCategories?: BreakOutCategoryPolicies;
}

/**
 * Network Virtual Appliance Sku Properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model BreakOutCategoryPolicies {
  /**
   * Flag to control breakout of o365 allow category.
   */
  allow?: boolean;

  /**
   * Flag to control breakout of o365 optimize category.
   */
  optimize?: boolean;

  /**
   * Flag to control breakout of o365 default category.
   */
  default?: boolean;
}

/**
 * Properties specific to NetworkVirtualApplianceSkus.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@summary("Network Virtual Appliance Sku Properties")
model NetworkVirtualApplianceSkuPropertiesFormat {
  /**
   * Network Virtual Appliance Sku vendor.
   */
  @visibility(Lifecycle.Read)
  vendor?: string;

  /**
   * Available Network Virtual Appliance versions.
   */
  @visibility(Lifecycle.Read)
  availableVersions?: string[];

  /**
   * The list of scale units available.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  availableScaleUnits?: NetworkVirtualApplianceSkuInstances[];
}

/**
 * List of available Sku and instances.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@summary("Network Virtual Appliance Sku Instances")
model NetworkVirtualApplianceSkuInstances {
  /**
   * Scale Unit.
   */
  @visibility(Lifecycle.Read)
  scaleUnit?: string;

  /**
   * Instance Count.
   */
  @visibility(Lifecycle.Read)
  instanceCount?: int32;
}

/**
 * Properties of the Inbound Security Rules resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model InboundSecurityRuleProperties {
  /**
   * Rule Type. This should be either AutoExpire or Permanent. Auto Expire Rule only creates NSG rules. Permanent Rule creates NSG rule and SLB LB Rule.
   */
  ruleType?: InboundSecurityRuleType;

  /**
   * List of allowed rules.
   */
  rules?: InboundSecurityRules[];

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Properties of the Inbound Security Rules resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model InboundSecurityRules {
  /**
   * Name of the rule.
   */
  name?: string;

  /**
   * Protocol. This should be either TCP or UDP.
   */
  protocol?: InboundSecurityRulesProtocol;

  /**
   * The CIDR or source IP range.
   */
  sourceAddressPrefix?: string;

  /**
   * NVA port ranges to be opened up. One needs to provide specific ports.
   */
  @minValue(0)
  @maxValue(65535)
  destinationPortRange?: int32;

  /**
   * NVA port ranges to be opened up. One can provide a range of ports. Allowed port value between 0 and 65535.
   */
  destinationPortRanges?: string[];

  /**
   * Public IP name in case of Permanent Rule type & Interface Name in case of Auto Expire Rule type
   */
  appliesOn?: string[];
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
  provisioningState?: NetworkProvisioningState;
}

/**
 * The error object.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
@error
model ErrorResponse {
  /**
   * The error details object.
   */
  @summary("Error")
  error?: ErrorDetails;
}

/**
 * Response for ListNetworkWatchers API service call.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model NetworkWatcherListResult {
  /**
   * List of network watcher resources.
   */
  @pageItems
  value?: NetworkWatcher[];

  /**
   * URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Parameters that define the representation of topology.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model TopologyParameters {
  /**
   * The name of the target resource group to perform topology on.
   */
  targetResourceGroupName?: string;

  /**
   * The reference to the Virtual Network resource.
   */
  targetVirtualNetwork?: SubResource;

  /**
   * The reference to the Subnet resource.
   */
  targetSubnet?: SubResource;
}

/**
 * Topology of the specified resource group.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model Topology {
  /**
   * GUID representing the operation id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The datetime when the topology was initially created for the resource group.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime?: utcDateTime;

  /**
   * The datetime when the topology was last modified.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  /**
   * A list of topology resources.
   */
  resources?: TopologyResource[];
}

/**
 * The network resource topology information for the given resource group.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model TopologyResource {
  /**
   * Name of the resource.
   */
  name?: string;

  /**
   * ID of the resource.
   */
  id?: string;

  /**
   * Resource location.
   */
  location?: string;

  /**
   * Holds the associations the resource has with other resources in the resource group.
   */
  associations?: TopologyAssociation[];
}

/**
 * Resources that have an association with the parent resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model TopologyAssociation {
  /**
   * The name of the resource that is associated with the parent resource.
   */
  name?: string;

  /**
   * The ID of the resource that is associated with the parent resource.
   */
  resourceId?: string;

  /**
   * The association type of the child resource to the parent resource.
   */
  associationType?: AssociationType;
}

/**
 * Parameters that define the IP flow to be verified.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model VerificationIPFlowParameters {
  /**
   * The ID of the target resource to perform next-hop on.
   */
  targetResourceId: string;

  /**
   * The direction of the packet represented as a 5-tuple.
   */
  direction: Direction;

  /**
   * Protocol to be verified on.
   */
  protocol: IpFlowProtocol;

  /**
   * The local port. Acceptable values are a single integer in the range (0-65535). Support for * for the source port, which depends on the direction.
   */
  localPort: string;

  /**
   * The remote port. Acceptable values are a single integer in the range (0-65535). Support for * for the source port, which depends on the direction.
   */
  remotePort: string;

  /**
   * The local IP address. Acceptable values are valid IPv4 addresses.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  localIPAddress: string;

  /**
   * The remote IP address. Acceptable values are valid IPv4 addresses.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  remoteIPAddress: string;

  /**
   * The NIC ID. (If VM has multiple NICs and IP forwarding is enabled on any of them, then this parameter must be specified. Otherwise optional).
   */
  targetNicResourceId?: string;
}

/**
 * Results of IP flow verification on the target resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model VerificationIPFlowResult {
  /**
   * Indicates whether the traffic is allowed or denied.
   */
  access?: Access;

  /**
   * Name of the rule. If input is not matched against any security rule, it is not displayed.
   */
  ruleName?: string;
}

/**
 * Parameters that define the source and destination endpoint.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model NextHopParameters {
  /**
   * The resource identifier of the target resource against which the action is to be performed.
   */
  targetResourceId: string;

  /**
   * The source IP address.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sourceIPAddress: string;

  /**
   * The destination IP address.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  destinationIPAddress: string;

  /**
   * The NIC ID. (If VM has multiple NICs and IP forwarding is enabled on any of the nics, then this parameter must be specified. Otherwise optional).
   */
  targetNicResourceId?: string;
}

/**
 * The information about next hop from the specified VM.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model NextHopResult {
  /**
   * Next hop type.
   */
  nextHopType?: NextHopType;

  /**
   * Next hop IP Address.
   */
  nextHopIpAddress?: string;

  /**
   * The resource identifier for the route table associated with the route being returned. If the route being returned does not correspond to any user created routes then this field will be the string 'System Route'.
   */
  routeTableId?: string;
}

/**
 * Parameters that define the VM to check security groups for.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model SecurityGroupViewParameters {
  /**
   * ID of the target VM.
   */
  targetResourceId: string;
}

/**
 * The information about security rules applied to the specified VM.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model SecurityGroupViewResult {
  /**
   * List of network interfaces on the specified VM.
   */
  networkInterfaces?: SecurityGroupNetworkInterface[];
}

/**
 * Network interface and all its associated security rules.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model SecurityGroupNetworkInterface {
  /**
   * ID of the network interface.
   */
  id?: string;

  /**
   * All security rules associated with the network interface.
   */
  securityRuleAssociations?: SecurityRuleAssociations;
}

/**
 * All security rules associated with the network interface.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model SecurityRuleAssociations {
  /**
   * Network interface and it's custom security rules.
   */
  networkInterfaceAssociation?: NetworkInterfaceAssociation;

  /**
   * Subnet and it's custom security rules.
   */
  subnetAssociation?: SubnetAssociation;

  /**
   * Collection of default security rules of the network security group.
   */
  defaultSecurityRules?: SecurityRule[];

  /**
   * Collection of effective security rules.
   */
  effectiveSecurityRules?: EffectiveNetworkSecurityRule[];
}

/**
 * Network interface and its custom security rules.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model NetworkInterfaceAssociation {
  /**
   * Network interface ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Collection of custom security rules.
   */
  securityRules?: SecurityRule[];
}

/**
 * Subnet and it's custom security rules.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model SubnetAssociation {
  /**
   * Subnet ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Collection of custom security rules.
   */
  securityRules?: SecurityRule[];
}

/**
 * Parameters that define the create packet capture operation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model PacketCapture {
  /**
   * Properties of the packet capture.
   */
  properties: PacketCaptureParameters;
}

/**
 * Parameters that define the create packet capture operation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model PacketCaptureParameters {
  /**
   * The ID of the targeted resource, only AzureVM and AzureVMSS as target type are currently supported.
   */
  target: string;

  /**
   * A list of AzureVMSS instances which can be included or excluded to run packet capture. If both included and excluded are empty, then the packet capture will run on all instances of AzureVMSS.
   */
  scope?: PacketCaptureMachineScope;

  /**
   * Target type of the resource provided.
   */
  targetType?: PacketCaptureTargetType;

  /**
   * Number of bytes captured per packet, the remaining bytes are truncated.
   */
  @minValue(0)
  @maxValue(4294967295)
  bytesToCapturePerPacket?: int64 = 0;

  /**
   * Maximum size of the capture output.
   */
  @minValue(0)
  @maxValue(4294967295)
  totalBytesPerSession?: int64 = 1073741824;

  /**
   * Maximum duration of the capture session in seconds.
   */
  @minValue(0)
  @maxValue(18000)
  timeLimitInSeconds?: int32 = 18000;

  /**
   * The storage location for a packet capture session.
   */
  storageLocation: PacketCaptureStorageLocation;

  /**
   * A list of packet capture filters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  filters?: PacketCaptureFilter[];

  /**
   * This continuous capture is a nullable boolean, which can hold 'null', 'true' or 'false' value. If we do not pass this parameter, it would be consider as 'null', default value is 'null'.
   */
  continuousCapture?: boolean;

  /**
   * The capture setting holds the 'FileCount', 'FileSizeInBytes', 'SessionTimeLimitInSeconds' values.
   */
  captureSettings?: PacketCaptureSettings;
}

/**
 * A list of AzureVMSS instances which can be included or excluded to run packet capture. If both included and excluded are empty, then the packet capture will run on all instances of AzureVMSS.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model PacketCaptureMachineScope {
  /**
   * List of AzureVMSS instances to run packet capture on.
   */
  include?: string[];

  /**
   * List of AzureVMSS instances which has to be excluded from the AzureVMSS from running packet capture.
   */
  exclude?: string[];
}

/**
 * The storage location for a packet capture session.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model PacketCaptureStorageLocation {
  /**
   * The ID of the storage account to save the packet capture session. Required if no localPath or filePath is provided.
   */
  storageId?: string;

  /**
   * The URI of the storage path to save the packet capture. Must be a well-formed URI describing the location to save the packet capture.
   */
  storagePath?: string;

  /**
   * This path is invalid if 'Continuous Capture' is provided with 'true' or 'false'. A valid local path on the targeting VM. Must include the name of the capture file (*.cap). For linux virtual machine it must start with /var/captures. Required if no storage ID is provided, otherwise optional.
   */
  filePath?: string;

  /**
   * This path is valid if 'Continuous Capture' is provided with 'true' or 'false' and required if no storage ID is provided, otherwise optional. Must include the name of the capture file (*.cap). For linux virtual machine it must start with /var/captures.
   */
  localPath?: string;
}

/**
 * Filter that is applied to packet capture request. Multiple filters can be applied.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model PacketCaptureFilter {
  /**
   * Protocol to be filtered on.
   */
  protocol?: PcProtocol = PcProtocol.Any;

  /**
   * Local IP Address to be filtered on. Notation: "127.0.0.1" for single address entry. "127.0.0.1-127.0.0.255" for range. "127.0.0.1;127.0.0.5"? for multiple entries. Multiple ranges not currently supported. Mixing ranges with multiple entries not currently supported. Default = null.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  localIPAddress?: string;

  /**
   * Local IP Address to be filtered on. Notation: "127.0.0.1" for single address entry. "127.0.0.1-127.0.0.255" for range. "127.0.0.1;127.0.0.5;" for multiple entries. Multiple ranges not currently supported. Mixing ranges with multiple entries not currently supported. Default = null.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  remoteIPAddress?: string;

  /**
   * Local port to be filtered on. Notation: "80" for single port entry."80-85" for range. "80;443;" for multiple entries. Multiple ranges not currently supported. Mixing ranges with multiple entries not currently supported. Default = null.
   */
  localPort?: string;

  /**
   * Remote port to be filtered on. Notation: "80" for single port entry."80-85" for range. "80;443;" for multiple entries. Multiple ranges not currently supported. Mixing ranges with multiple entries not currently supported. Default = null.
   */
  remotePort?: string;
}

/**
 * The storage location for a packet capture session.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model PacketCaptureSettings {
  /**
   * Number of file count. Default value of count is 10 and maximum number is 10000.
   */
  @minValue(0)
  @maxValue(10000)
  fileCount?: int32 = 10;

  /**
   * Number of bytes captured per packet. Default value in bytes 104857600 (100MB) and maximum in bytes 4294967295 (4GB).
   */
  @minValue(0)
  @maxValue(4294967295)
  fileSizeInBytes?: int64 = 104857600;

  /**
   * Maximum duration of the capture session in seconds is 604800s (7 days) for a file. Default value in second 86400s (1 day).
   */
  @minValue(0)
  @maxValue(604800)
  sessionTimeLimitInSeconds?: int32 = 86400;
}

/**
 * Information about packet capture session.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model PacketCaptureResult {
  /**
   * Name of the packet capture session.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * ID of the packet capture operation.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Properties of the packet capture result.
   */
  properties?: PacketCaptureResultProperties;
}

/**
 * The properties of a packet capture session.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model PacketCaptureResultProperties extends PacketCaptureParameters {
  /**
   * The provisioning state of the packet capture session.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Status of packet capture session.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model PacketCaptureQueryStatusResult {
  /**
   * The name of the packet capture resource.
   */
  name?: string;

  /**
   * The ID of the packet capture resource.
   */
  id?: string;

  /**
   * The start time of the packet capture session.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  captureStartTime?: utcDateTime;

  /**
   * The status of the packet capture session.
   */
  packetCaptureStatus?: PcStatus;

  /**
   * The reason the current packet capture session was stopped.
   */
  stopReason?: string;

  /**
   * List of errors of packet capture session.
   */
  packetCaptureError?: PcError[];
}

/**
 * List of packet capture sessions.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model PacketCaptureListResult {
  /**
   * Information about packet capture sessions.
   */
  @pageItems
  value?: PacketCaptureResult[];

  /**
   * URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Parameters that define the resource to troubleshoot.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model TroubleshootingParameters {
  /**
   * The target resource to troubleshoot.
   */
  targetResourceId: string;

  /**
   * Properties of the troubleshooting resource.
   */
  properties: TroubleshootingProperties;
}

/**
 * Storage location provided for troubleshoot.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model TroubleshootingProperties {
  /**
   * The ID for the storage account to save the troubleshoot result.
   */
  storageId: string;

  /**
   * The path to the blob to save the troubleshoot result in.
   */
  storagePath: string;
}

/**
 * Troubleshooting information gained from specified resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model TroubleshootingResult {
  /**
   * The start time of the troubleshooting.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The end time of the troubleshooting.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The result code of the troubleshooting.
   */
  code?: string;

  /**
   * Information from troubleshooting.
   */
  results?: TroubleshootingDetails[];
}

/**
 * Information gained from troubleshooting of specified resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model TroubleshootingDetails {
  /**
   * The id of the get troubleshoot operation.
   */
  id?: string;

  /**
   * Reason type of failure.
   */
  reasonType?: string;

  /**
   * A summary of troubleshooting.
   */
  summary?: string;

  /**
   * Details on troubleshooting results.
   */
  detail?: string;

  /**
   * List of recommended actions.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recommendedActions?: TroubleshootingRecommendedActions[];
}

/**
 * Recommended actions based on discovered issues.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model TroubleshootingRecommendedActions {
  /**
   * ID of the recommended action.
   */
  actionId?: string;

  /**
   * Description of recommended actions.
   */
  actionText?: string;

  /**
   * The uri linking to a documentation for the recommended troubleshooting actions.
   */
  actionUri?: string;

  /**
   * The information from the URI for the recommended troubleshooting actions.
   */
  actionUriText?: string;
}

/**
 * Parameters that define the resource to query the troubleshooting result.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model QueryTroubleshootingParameters {
  /**
   * The target resource ID to query the troubleshooting result.
   */
  targetResourceId: string;
}

/**
 * Information on the configuration of flow log and traffic analytics (optional) .
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model FlowLogInformation {
  /**
   * The ID of the resource to configure for flow log and traffic analytics (optional) .
   */
  targetResourceId: string;

  /**
   * Properties of the flow log.
   */
  properties: FlowLogProperties;

  /**
   * Parameters that define the configuration of traffic analytics.
   */
  flowAnalyticsConfiguration?: TrafficAnalyticsProperties;

  /**
   * FlowLog resource Managed Identity
   */
  identity?: ManagedServiceIdentity;
}

/**
 * Parameters that define the configuration of flow log.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model FlowLogProperties {
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
  enabled: boolean;

  /**
   * Parameters that define the retention policy for flow log.
   */
  retentionPolicy?: RetentionPolicyParameters;

  /**
   * Parameters that define the flow log format.
   */
  format?: FlowLogFormatParameters;
}

/**
 * Parameters that define a resource to query flow log and traffic analytics (optional) status.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model FlowLogStatusParameters {
  /**
   * The target resource where getting the flow log and traffic analytics (optional) status.
   */
  targetResourceId: string;
}

/**
 * Parameters that determine how the connectivity check will be performed.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectivityParameters {
  /**
   * The source of the connection.
   */
  source: ConnectivitySource;

  /**
   * The destination of connection.
   */
  destination: ConnectivityDestination;

  /**
   * Network protocol.
   */
  protocol?: Protocol;

  /**
   * Configuration of the protocol.
   */
  protocolConfiguration?: ProtocolConfiguration;

  /**
   * Preferred IP version of the connection.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preferredIPVersion?: IPVersion;
}

/**
 * Parameters that define the source of the connection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectivitySource {
  /**
   * The ID of the resource from which a connectivity check will be initiated.
   */
  resourceId: string;

  /**
   * The source port from which a connectivity check will be performed.
   */
  @minValue(0)
  @maxValue(65535)
  port?: int32;
}

/**
 * Parameters that define destination of connection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectivityDestination {
  /**
   * The ID of the resource to which a connection attempt will be made.
   */
  resourceId?: string;

  /**
   * The IP address or URI the resource to which a connection attempt will be made.
   */
  address?: string;

  /**
   * Port on which check connectivity will be performed.
   */
  @minValue(0)
  @maxValue(65535)
  port?: int32;
}

/**
 * Configuration of the protocol.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ProtocolConfiguration {
  /**
   * HTTP configuration of the connectivity check.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  HTTPConfiguration?: HttpConfiguration;
}

/**
 * HTTP configuration of the connectivity check.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model HttpConfiguration {
  /**
   * HTTP method.
   */
  method?: HttpMethod;

  /**
   * List of HTTP headers.
   */
  headers?: HttpHeader[];

  /**
   * Valid status codes.
   */
  validStatusCodes?: int32[];
}

/**
 * The HTTP header.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model HttpHeader {
  /**
   * The name in HTTP header.
   */
  name?: string;

  /**
   * The value in HTTP header.
   */
  value?: string;
}

/**
 * Information on the connectivity status.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectivityInformation {
  /**
   * List of hops between the source and the destination.
   */
  @visibility(Lifecycle.Read)
  hops?: ConnectivityHop[];

  /**
   * The connection status.
   */
  @visibility(Lifecycle.Read)
  connectionStatus?: ConnectionStatus;

  /**
   * Average latency in milliseconds.
   */
  @visibility(Lifecycle.Read)
  avgLatencyInMs?: int32;

  /**
   * Minimum latency in milliseconds.
   */
  @visibility(Lifecycle.Read)
  minLatencyInMs?: int32;

  /**
   * Maximum latency in milliseconds.
   */
  @visibility(Lifecycle.Read)
  maxLatencyInMs?: int32;

  /**
   * Total number of probes sent.
   */
  @visibility(Lifecycle.Read)
  probesSent?: int32;

  /**
   * Number of failed probes.
   */
  @visibility(Lifecycle.Read)
  probesFailed?: int32;
}

/**
 * Information about a hop between the source and the destination.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectivityHop {
  /**
   * The type of the hop.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The ID of the hop.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The IP address of the hop.
   */
  @visibility(Lifecycle.Read)
  address?: string;

  /**
   * The ID of the resource corresponding to this hop.
   */
  @visibility(Lifecycle.Read)
  resourceId?: string;

  /**
   * List of next hop identifiers.
   */
  @visibility(Lifecycle.Read)
  nextHopIds?: string[];

  /**
   * List of previous hop identifiers.
   */
  @visibility(Lifecycle.Read)
  previousHopIds?: string[];

  /**
   * List of hop links.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  links?: HopLink[];

  /**
   * List of previous hop links.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  previousLinks?: HopLink[];

  /**
   * List of issues.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  issues?: ConnectivityIssue[];
}

/**
 * Hop link.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model HopLink {
  /**
   * The ID of the next hop.
   */
  @visibility(Lifecycle.Read)
  nextHopId?: string;

  /**
   * Link type.
   */
  @visibility(Lifecycle.Read)
  linkType?: string;

  /**
   * Hop link properties.
   */
  properties?: HopLinkProperties;

  /**
   * List of issues.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  issues?: ConnectivityIssue[];

  /**
   * Provides additional context on links.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  context?: Record<string>;

  /**
   * Resource ID.
   */
  @visibility(Lifecycle.Read)
  resourceId?: string;
}

/**
 * Hop link properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model HopLinkProperties {
  /**
   * Minimum roundtrip time in milliseconds.
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(4294967295)
  roundTripTimeMin?: int64;

  /**
   * Average roundtrip time in milliseconds.
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(4294967295)
  roundTripTimeAvg?: int64;

  /**
   * Maximum roundtrip time in milliseconds.
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(4294967295)
  roundTripTimeMax?: int64;
}

/**
 * Information about an issue encountered in the process of checking for connectivity.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectivityIssue {
  /**
   * The origin of the issue.
   */
  @visibility(Lifecycle.Read)
  origin?: Origin;

  /**
   * The severity of the issue.
   */
  @visibility(Lifecycle.Read)
  severity?: Severity;

  /**
   * The type of issue.
   */
  @visibility(Lifecycle.Read)
  type?: IssueType;

  /**
   * Provides additional context on the issue.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  context?: Record<string>[];
}

/**
 * Geographic and time constraints for Azure reachability report.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model AzureReachabilityReportParameters {
  /**
   * Parameters that define a geographic location.
   */
  providerLocation: AzureReachabilityReportLocation;

  /**
   * List of Internet service providers.
   */
  providers?: string[];

  /**
   * Optional Azure regions to scope the query to.
   */
  azureLocations?: string[];

  /**
   * The start time for the Azure reachability report.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime: utcDateTime;

  /**
   * The end time for the Azure reachability report.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime: utcDateTime;
}

/**
 * Parameters that define a geographic location.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model AzureReachabilityReportLocation {
  /**
   * The name of the country.
   */
  country: string;

  /**
   * The name of the state.
   */
  state?: string;

  /**
   * The name of the city or town.
   */
  city?: string;
}

/**
 * Azure reachability report details.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model AzureReachabilityReport {
  /**
   * The aggregation level of Azure reachability report. Can be Country, State or City.
   */
  aggregationLevel: string;

  /**
   * Parameters that define a geographic location.
   */
  providerLocation: AzureReachabilityReportLocation;

  /**
   * List of Azure reachability report items.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  reachabilityReport: AzureReachabilityReportItem[];
}

/**
 * Azure reachability report details for a given provider location.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model AzureReachabilityReportItem {
  /**
   * The Internet service provider.
   */
  provider?: string;

  /**
   * The Azure region.
   */
  azureLocation?: string;

  /**
   * List of latency details for each of the time series.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  latencies?: AzureReachabilityReportLatencyInfo[];
}

/**
 * Details on latency for a time series.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model AzureReachabilityReportLatencyInfo {
  /**
   * The time stamp.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeStamp?: utcDateTime;

  /**
   * The relative latency score between 1 and 100, higher values indicating a faster connection.
   */
  @maxValue(100)
  @minValue(1)
  score?: int32;
}

/**
 * Constraints that determine the list of available Internet service providers.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model AvailableProvidersListParameters {
  /**
   * A list of Azure regions.
   */
  azureLocations?: string[];

  /**
   * The country for available providers list.
   */
  country?: string;

  /**
   * The state for available providers list.
   */
  state?: string;

  /**
   * The city or town for available providers list.
   */
  city?: string;
}

/**
 * List of available countries with details.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model AvailableProvidersList {
  /**
   * List of available countries.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  countries: AvailableProvidersListCountry[];
}

/**
 * Country details.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model AvailableProvidersListCountry {
  /**
   * The country name.
   */
  countryName?: string;

  /**
   * A list of Internet service providers.
   */
  providers?: string[];

  /**
   * List of available states in the country.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  states?: AvailableProvidersListState[];
}

/**
 * State details.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model AvailableProvidersListState {
  /**
   * The state name.
   */
  stateName?: string;

  /**
   * A list of Internet service providers.
   */
  providers?: string[];

  /**
   * List of available cities or towns in the state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  cities?: AvailableProvidersListCity[];
}

/**
 * City or town details.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model AvailableProvidersListCity {
  /**
   * The city or town name.
   */
  cityName?: string;

  /**
   * A list of Internet service providers.
   */
  providers?: string[];
}

/**
 * Parameters to get network configuration diagnostic.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model NetworkConfigurationDiagnosticParameters {
  /**
   * The ID of the target resource to perform network configuration diagnostic. Valid options are VM, NetworkInterface, VMSS/NetworkInterface and Application Gateway.
   */
  targetResourceId: string;

  /**
   * Verbosity level.
   */
  verbosityLevel?: VerbosityLevel;

  /**
   * List of network configuration diagnostic profiles.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  profiles: NetworkConfigurationDiagnosticProfile[];
}

/**
 * Parameters to compare with network configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model NetworkConfigurationDiagnosticProfile {
  /**
   * The direction of the traffic.
   */
  direction: Direction;

  /**
   * Protocol to be verified on. Accepted values are '*', TCP, UDP.
   */
  protocol: string;

  /**
   * Traffic source. Accepted values are '*', IP Address/CIDR, Service Tag.
   */
  source: string;

  /**
   * Traffic destination. Accepted values are: '*', IP Address/CIDR, Service Tag.
   */
  destination: string;

  /**
   * Traffic destination port. Accepted values are '*' and a single port in the range (0 - 65535).
   */
  destinationPort: string;
}

/**
 * Results of network configuration diagnostic on the target resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model NetworkConfigurationDiagnosticResponse {
  /**
   * List of network configuration diagnostic results.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  results?: NetworkConfigurationDiagnosticResult[];
}

/**
 * Network configuration diagnostic result corresponded to provided traffic query.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model NetworkConfigurationDiagnosticResult {
  /**
   * Network configuration diagnostic profile.
   */
  profile?: NetworkConfigurationDiagnosticProfile;

  /**
   * Network security group result.
   */
  networkSecurityGroupResult?: NetworkSecurityGroupResult;
}

/**
 * Network configuration diagnostic result corresponded provided traffic query.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model NetworkSecurityGroupResult {
  /**
   * The network traffic is allowed or denied.
   */
  securityRuleAccessResult?: SecurityRuleAccess;

  /**
   * List of results network security groups diagnostic.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  evaluatedNetworkSecurityGroups?: EvaluatedNetworkSecurityGroup[];
}

/**
 * Results of network security group evaluation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model EvaluatedNetworkSecurityGroup {
  /**
   * Network security group ID.
   */
  networkSecurityGroupId?: string;

  /**
   * Resource ID of nic or subnet to which network security group is applied.
   */
  appliedTo?: string;

  /**
   * Matched network security rule.
   */
  matchedRule?: MatchedRule;

  /**
   * List of network security rules evaluation results.
   */
  @visibility(Lifecycle.Read)
  rulesEvaluationResult?: NetworkSecurityRulesEvaluationResult[];
}

/**
 * Matched rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model MatchedRule {
  /**
   * Name of the matched network security rule.
   */
  ruleName?: string;

  /**
   * The network traffic is allowed or denied. Possible values are 'Allow' and 'Deny'.
   */
  action?: string;
}

/**
 * Network security rules evaluation result.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model NetworkSecurityRulesEvaluationResult {
  /**
   * Name of the network security rule.
   */
  name?: string;

  /**
   * Value indicating whether protocol is matched.
   */
  protocolMatched?: boolean;

  /**
   * Value indicating whether source is matched.
   */
  sourceMatched?: boolean;

  /**
   * Value indicating whether source port is matched.
   */
  sourcePortMatched?: boolean;

  /**
   * Value indicating whether destination is matched.
   */
  destinationMatched?: boolean;

  /**
   * Value indicating whether destination port is matched.
   */
  destinationPortMatched?: boolean;
}

/**
 * Parameters that define the operation to create a connection monitor.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectionMonitor {
  /**
   * Connection monitor location.
   */
  location?: string;

  /**
   * Connection monitor tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Properties of the connection monitor.
   */
  properties: ConnectionMonitorParameters;
}

/**
 * Parameters that define the operation to create a connection monitor.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectionMonitorParameters {
  /**
   * Describes the source of connection monitor.
   */
  source?: ConnectionMonitorSource;

  /**
   * Describes the destination of connection monitor.
   */
  destination?: ConnectionMonitorDestination;

  /**
   * Determines if the connection monitor will start automatically once created.
   */
  autoStart?: boolean = true;

  /**
   * Monitoring interval in seconds.
   */
  @maxValue(1800)
  @minValue(30)
  monitoringIntervalInSeconds?: int32 = 60;

  /**
   * List of connection monitor endpoints.
   */
  endpoints?: ConnectionMonitorEndpoint[];

  /**
   * List of connection monitor test configurations.
   */
  testConfigurations?: ConnectionMonitorTestConfiguration[];

  /**
   * List of connection monitor test groups.
   */
  testGroups?: ConnectionMonitorTestGroup[];

  /**
   * List of connection monitor outputs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  outputs?: ConnectionMonitorOutput[];

  /**
   * Optional notes to be associated with the connection monitor.
   */
  notes?: string;
}

/**
 * Describes the source of connection monitor.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectionMonitorSource {
  /**
   * The ID of the resource used as the source by connection monitor.
   */
  resourceId: string;

  /**
   * The source port used by connection monitor.
   */
  @minValue(0)
  @maxValue(65535)
  port?: int32;
}

/**
 * Describes the destination of connection monitor.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectionMonitorDestination {
  /**
   * The ID of the resource used as the destination by connection monitor.
   */
  resourceId?: string;

  /**
   * Address of the connection monitor destination (IP or domain name).
   */
  address?: string;

  /**
   * The destination port used by connection monitor.
   */
  @minValue(0)
  @maxValue(65535)
  port?: int32;
}

/**
 * Describes the connection monitor endpoint.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectionMonitorEndpoint {
  /**
   * The name of the connection monitor endpoint.
   */
  name: string;

  /**
   * The endpoint type.
   */
  type?: EndpointType;

  /**
   * Resource ID of the connection monitor endpoint are supported for AzureVM, AzureVMSS, AzureVNet, AzureSubnet, MMAWorkspaceMachine, MMAWorkspaceNetwork, AzureArcVM endpoint type.
   */
  resourceId?: string;

  /**
   * Address of the connection monitor endpoint. Supported for AzureVM, ExternalAddress, ArcMachine, MMAWorkspaceMachine endpoint type.
   */
  address?: string;

  /**
   * Filter field is getting deprecated and should not be used. Instead use Include/Exclude scope fields for it.
   */
  filter?: ConnectionMonitorEndpointFilter;

  /**
   * Endpoint scope defines which target resource to monitor in case of compound resource endpoints like VMSS, AzureSubnet, AzureVNet, MMAWorkspaceNetwork, AzureArcNetwork.
   */
  scope?: ConnectionMonitorEndpointScope;

  /**
   * Test coverage for the endpoint.
   */
  coverageLevel?: CoverageLevel;

  /**
   * Location details is optional and only being used for 'AzureArcNetwork' type endpoints, which contains region details.
   */
  locationDetails?: ConnectionMonitorEndpointLocationDetails;

  /**
   * Subscription ID for connection monitor endpoint. It's an optional parameter which is being used for 'AzureArcNetwork' type endpoint.
   */
  subscriptionId?: string;
}

/**
 * Describes the connection monitor endpoint filter.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectionMonitorEndpointFilter {
  /**
   * The behavior of the endpoint filter. Currently only 'Include' is supported.
   */
  type?: ConnectionMonitorEndpointFilterType;

  /**
   * List of items in the filter.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  items?: ConnectionMonitorEndpointFilterItem[];
}

/**
 * Describes the connection monitor endpoint filter item.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectionMonitorEndpointFilterItem {
  /**
   * The type of item included in the filter. Currently only 'AgentAddress' is supported.
   */
  type?: ConnectionMonitorEndpointFilterItemType;

  /**
   * The address of the filter item.
   */
  address?: string;
}

/**
 * Describes the connection monitor endpoint scope.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectionMonitorEndpointScope {
  /**
   * List of items which needs to be included to the endpoint scope.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  include?: ConnectionMonitorEndpointScopeItem[];

  /**
   * List of items which needs to be excluded from the endpoint scope.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  exclude?: ConnectionMonitorEndpointScopeItem[];
}

/**
 * Describes the connection monitor endpoint scope item.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectionMonitorEndpointScopeItem {
  /**
   * The address of the endpoint item. Supported types are IPv4/IPv6 subnet mask or IPv4/IPv6 IP address.
   */
  address?: string;
}

/**
 * Connection monitor endpoint location details only being used for 'AzureArcNetwork' type endpoints, which contains the region details.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectionMonitorEndpointLocationDetails {
  /**
   * Region for connection monitor endpoint.
   */
  region?: string;
}

/**
 * Describes a connection monitor test configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectionMonitorTestConfiguration {
  /**
   * The name of the connection monitor test configuration.
   */
  name: string;

  /**
   * The frequency of test evaluation, in seconds.
   */
  testFrequencySec?: int32;

  /**
   * The protocol to use in test evaluation.
   */
  protocol: ConnectionMonitorTestConfigurationProtocol;

  /**
   * The preferred IP version to use in test evaluation. The connection monitor may choose to use a different version depending on other parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preferredIPVersion?: PreferredIPVersion;

  /**
   * The parameters used to perform test evaluation over HTTP.
   */
  httpConfiguration?: ConnectionMonitorHttpConfiguration;

  /**
   * The parameters used to perform test evaluation over TCP.
   */
  tcpConfiguration?: ConnectionMonitorTcpConfiguration;

  /**
   * The parameters used to perform test evaluation over ICMP.
   */
  icmpConfiguration?: ConnectionMonitorIcmpConfiguration;

  /**
   * The threshold for declaring a test successful.
   */
  successThreshold?: ConnectionMonitorSuccessThreshold;
}

/**
 * Describes the HTTP configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectionMonitorHttpConfiguration {
  /**
   * The port to connect to.
   */
  @minValue(0)
  @maxValue(65535)
  port?: int32;

  /**
   * The HTTP method to use.
   */
  method?: HttpConfigurationMethod;

  /**
   * The path component of the URI. For instance, "/dir1/dir2".
   */
  path?: string;

  /**
   * The HTTP headers to transmit with the request.
   */
  requestHeaders?: HttpHeader[];

  /**
   * HTTP status codes to consider successful. For instance, "2xx,301-304,418".
   */
  validStatusCodeRanges?: string[];

  /**
   * Value indicating whether HTTPS is preferred over HTTP in cases where the choice is not explicit.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preferHTTPS?: boolean;
}

/**
 * Describes the TCP configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectionMonitorTcpConfiguration {
  /**
   * The port to connect to.
   */
  @minValue(0)
  @maxValue(65535)
  port?: int32;

  /**
   * Value indicating whether path evaluation with trace route should be disabled.
   */
  disableTraceRoute?: boolean;

  /**
   * Destination port behavior.
   */
  destinationPortBehavior?: DestinationPortBehavior;
}

/**
 * Describes the ICMP configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectionMonitorIcmpConfiguration {
  /**
   * Value indicating whether path evaluation with trace route should be disabled.
   */
  disableTraceRoute?: boolean;
}

/**
 * Describes the threshold for declaring a test successful.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectionMonitorSuccessThreshold {
  /**
   * The maximum percentage of failed checks permitted for a test to evaluate as successful.
   */
  checksFailedPercent?: int32;

  /**
   * The maximum round-trip time in milliseconds permitted for a test to evaluate as successful.
   */
  roundTripTimeMs?: float32;
}

/**
 * Describes the connection monitor test group.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectionMonitorTestGroup {
  /**
   * The name of the connection monitor test group.
   */
  name: string;

  /**
   * Value indicating whether test group is disabled.
   */
  disable?: boolean;

  /**
   * List of test configuration names.
   */
  testConfigurations: string[];

  /**
   * List of source endpoint names.
   */
  sources: string[];

  /**
   * List of destination endpoint names.
   */
  destinations: string[];
}

/**
 * Describes a connection monitor output destination.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectionMonitorOutput {
  /**
   * Connection monitor output destination type. Currently, only "Workspace" is supported.
   */
  type?: OutputType;

  /**
   * Describes the settings for producing output into a log analytics workspace.
   */
  workspaceSettings?: ConnectionMonitorWorkspaceSettings;
}

/**
 * Describes the settings for producing output into a log analytics workspace.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectionMonitorWorkspaceSettings {
  /**
   * Log analytics workspace resource ID.
   */
  workspaceResourceId?: string;
}

/**
 * Describes the properties of a connection monitor.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectionMonitorResultProperties extends ConnectionMonitorParameters {
  /**
   * The provisioning state of the connection monitor.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The date and time when the connection monitor was started.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The monitoring status of the connection monitor.
   */
  @visibility(Lifecycle.Read)
  monitoringStatus?: string;

  /**
   * Type of connection monitor.
   */
  @visibility(Lifecycle.Read)
  connectionMonitorType?: ConnectionMonitorType;
}

/**
 * List of connection monitors.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectionMonitorListResult {
  /**
   * Information about connection monitors.
   */
  @pageItems
  value?: ConnectionMonitorResult[];

  /**
   * URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Network REST API operation definition.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkingOperations)
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}.
   */
  name?: string;

  /**
   * Display metadata associated with the operation.
   */
  display?: OperationDisplay;

  /**
   * Origin of the operation.
   */
  origin?: string;

  /**
   * Operation properties format.
   */
  properties?: OperationPropertiesFormat;
}

/**
 * Display metadata associated with the operation.
 */
model OperationDisplay {
  /**
   * Service provider: Microsoft Network.
   */
  provider?: string;

  /**
   * Resource on which the operation is performed.
   */
  resource?: string;

  /**
   * Type of the operation: get, read, delete, etc.
   */
  operation?: string;

  /**
   * Description of the operation.
   */
  description?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkingOperations)
model OperationListResult is Azure.Core.Page<Operation>;

/**
 * Description of operation properties format.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkingOperations)
model OperationPropertiesFormat {
  /**
   * Specification of the service.
   */
  serviceSpecification?: OperationPropertiesFormatServiceSpecification;
}

/**
 * Specification of the service.
 */
model OperationPropertiesFormatServiceSpecification {
  /**
   * Operation service specification.
   */
  metricSpecifications?: MetricSpecification[];

  /**
   * Operation log specification.
   */
  logSpecifications?: LogSpecification[];
}

/**
 * Description of metrics specification.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkingOperations)
model MetricSpecification {
  /**
   * The name of the metric.
   */
  name?: string;

  /**
   * The display name of the metric.
   */
  displayName?: string;

  /**
   * The description of the metric.
   */
  displayDescription?: string;

  /**
   * Units the metric to be displayed in.
   */
  unit?: string;

  /**
   * The aggregation type.
   */
  aggregationType?: string;

  /**
   * List of availability.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  availabilities?: Availability[];

  /**
   * Whether regional MDM account enabled.
   */
  enableRegionalMdmAccount?: boolean;

  /**
   * Whether gaps would be filled with zeros.
   */
  fillGapWithZero?: boolean;

  /**
   * Pattern for the filter of the metric.
   */
  metricFilterPattern?: string;

  /**
   * List of dimensions.
   */
  dimensions?: Dimension[];

  /**
   * Whether the metric is internal.
   */
  isInternal?: boolean;

  /**
   * The source MDM account.
   */
  sourceMdmAccount?: string;

  /**
   * The source MDM namespace.
   */
  sourceMdmNamespace?: string;

  /**
   * The resource Id dimension name override.
   */
  resourceIdDimensionNameOverride?: string;
}

/**
 * Availability of the metric.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkingOperations)
model Availability {
  /**
   * The time grain of the availability.
   */
  timeGrain?: string;

  /**
   * The retention of the availability.
   */
  retention?: string;

  /**
   * Duration of the availability blob.
   */
  blobDuration?: string;
}

/**
 * Dimension of the metric.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkingOperations)
model Dimension {
  /**
   * The name of the dimension.
   */
  name?: string;

  /**
   * The display name of the dimension.
   */
  displayName?: string;

  /**
   * The internal name of the dimension.
   */
  internalName?: string;
}

/**
 * Description of logging specification.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkingOperations)
model LogSpecification {
  /**
   * The name of the specification.
   */
  name?: string;

  /**
   * The display name of the specification.
   */
  displayName?: string;

  /**
   * Duration of the blob.
   */
  blobDuration?: string;
}

/**
 * An array of available PrivateEndpoint types.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model AvailablePrivateEndpointTypesResult
  is Azure.Core.Page<AvailablePrivateEndpointType>;

/**
 * The information of an AvailablePrivateEndpointType.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model AvailablePrivateEndpointType {
  /**
   * The name of the service and resource.
   */
  name?: string;

  /**
   * A unique identifier of the AvailablePrivateEndpoint Type resource.
   */
  id?: string;

  /**
   * Resource type.
   */
  type?: string;

  /**
   * The name of the service and resource.
   */
  resourceName?: string;

  /**
   * Display name of the resource.
   */
  displayName?: string;
}

/**
 * Private dns zone group resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PrivateDnsZoneGroup extends SubResource {
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
   * Properties of the private dns zone group.
   */
  properties?: PrivateDnsZoneGroupPropertiesFormat;
}

/**
 * Properties of the private dns zone group.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PrivateDnsZoneGroupPropertiesFormat {
  /**
   * The provisioning state of the private dns zone group resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * A collection of private dns zone configurations of the private dns zone group.
   */
  privateDnsZoneConfigs?: PrivateDnsZoneConfig[];
}

/**
 * PrivateDnsZoneConfig resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PrivateDnsZoneConfig {
  /**
   * Name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  name?: string;

  /**
   * Properties of the private dns zone configuration.
   */
  properties?: PrivateDnsZonePropertiesFormat;
}

/**
 * Properties of the private dns zone configuration resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PrivateDnsZonePropertiesFormat {
  /**
   * The resource id of the private dns zone.
   */
  privateDnsZoneId?: string;

  /**
   * A collection of information regarding a recordSet, holding information to identify private resources.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  recordSets?: RecordSet[];
}

/**
 * A collective group of information about the record set information.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model RecordSet {
  /**
   * Resource record type.
   */
  recordType?: string;

  /**
   * Recordset name.
   */
  recordSetName?: string;

  /**
   * Fqdn that resolves to private endpoint ip address.
   */
  fqdn?: string;

  /**
   * The provisioning state of the recordset.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * Recordset time to live.
   */
  ttl?: int32;

  /**
   * The private ip address of the private endpoint.
   */
  ipAddresses?: string[];
}

/**
 * Response for the ListPrivateDnsZoneGroups API service call.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PrivateDnsZoneGroupListResult is Azure.Core.Page<PrivateDnsZoneGroup>;

/**
 * Request body of the CheckPrivateLinkServiceVisibility API service call.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model CheckPrivateLinkServiceVisibilityRequest {
  /**
   * The alias of the private link service.
   */
  privateLinkServiceAlias?: string;
}

/**
 * Response for the CheckPrivateLinkServiceVisibility API service call.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PrivateLinkServiceVisibility {
  /**
   * Private Link Service Visibility (True/False).
   */
  visible?: boolean;
}

/**
 * An array of private link service id that can be linked to a private end point with auto approved.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model AutoApprovedPrivateLinkServicesResult
  is Azure.Core.Page<AutoApprovedPrivateLinkService>;

/**
 * The information of an AutoApprovedPrivateLinkService.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model AutoApprovedPrivateLinkService {
  /**
   * The id of the private link service resource.
   */
  privateLinkService?: string;
}

/**
 * Response for GetPublicIpAddressDdosProtectionStatusOperation API service call.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PublicIpDdosProtectionStatusResult {
  /**
   * Public IP ARM resource ID
   */
  publicIpAddressId?: string;

  /**
   * IP Address of the Public IP Resource
   */
  publicIpAddress?: string;

  /**
   * Value indicating whether the IP address is DDoS workload protected or not.
   */
  isWorkloadProtected?: IsWorkloadProtected;

  /**
   *  DDoS protection plan Resource Id of a if IP address is protected through a plan.
   */
  ddosProtectionPlanId?: string;
}

/**
 * The request for ReserveCloudServicePublicIpAddressOperation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model ReserveCloudServicePublicIpAddressRequest {
  /**
   * When true, reverts from Static to Dynamic allocation (undo reservation).
   */
  isRollback: IsRollback;
}

/**
 * The request for DisassociateCloudServicePublicIpOperation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model DisassociateCloudServicePublicIpRequest {
  /**
   * ARM ID of the Standalone Public IP to associate. This is of the form : /subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Network/publicIPAddresses/{publicIpAddressName}
   */
  publicIpArmId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/publicIPAddresses";
    }
  ]>;
}

/**
 * SKU of a public IP prefix.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PublicIPPrefixSku {
  /**
   * Name of a public IP prefix SKU.
   */
  name?: PublicIPPrefixSkuName;

  /**
   * Tier of a public IP prefix SKU.
   */
  tier?: PublicIPPrefixSkuTier;
}

/**
 * Public IP prefix properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PublicIPPrefixPropertiesFormat {
  /**
   * The public IP address version.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicIPAddressVersion?: IPVersion;

  /**
   * The list of tags associated with the public IP prefix.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ipTags?: IpTag[];

  /**
   * The Length of the Public IP Prefix.
   */
  prefixLength?: int32;

  /**
   * The allocated Prefix.
   */
  @visibility(Lifecycle.Read)
  ipPrefix?: string;

  /**
   * The list of all referenced PublicIPAddresses.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  publicIPAddresses?: ReferencedPublicIpAddress[];

  /**
   * The reference to load balancer frontend IP configuration associated with the public IP prefix.
   */
  @visibility(Lifecycle.Read)
  loadBalancerFrontendIpConfiguration?: SubResource;

  /**
   * The customIpPrefix that this prefix is associated with.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  customIPPrefix?: SubResource;

  /**
   * The resource GUID property of the public IP prefix resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The provisioning state of the public IP prefix resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * NatGateway of Public IP Prefix.
   */
  natGateway?: NatGateway;
}

/**
 * Reference to a public IP address.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model ReferencedPublicIpAddress {
  /**
   * The PublicIPAddress Reference.
   */
  id?: string;
}

/**
 * Route Filter Resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model RouteFilterPropertiesFormat {
  /**
   * Collection of RouteFilterRules contained within a route filter.
   */
  rules?: RouteFilterRule[];

  /**
   * A collection of references to express route circuit peerings.
   */
  @visibility(Lifecycle.Read)
  peerings?: ExpressRouteCircuitPeering[];

  /**
   * A collection of references to express route circuit ipv6 peerings.
   */
  @visibility(Lifecycle.Read)
  ipv6Peerings?: ExpressRouteCircuitPeering[];

  /**
   * The provisioning state of the route filter resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Route Filter Rule Resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model RouteFilterRule extends SubResource {
  /**
   * Properties of the route filter rule.
   */
  properties?: RouteFilterRulePropertiesFormat;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  name?: string;

  /**
   * Resource location.
   */
  location?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Route Filter Rule Resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model RouteFilterRulePropertiesFormat {
  /**
   * The access type of the rule.
   */
  access: Access;

  /**
   * The rule type of the rule.
   */
  routeFilterRuleType: RouteFilterRuleType;

  /**
   * The collection for bgp community values to filter on. e.g. ['12076:5010','12076:5020'].
   */
  communities: string[];

  /**
   * The provisioning state of the route filter rule resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Response for the ListRouteFilterRules API service call.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model RouteFilterRuleListResult is Azure.Core.Page<RouteFilterRule>;

/**
 * Properties of the Security Partner Provider.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model SecurityPartnerProviderPropertiesFormat {
  /**
   * The provisioning state of the Security Partner Provider resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The security provider name.
   */
  securityProviderName?: SecurityProviderName;

  /**
   * The connection status with the Security Partner Provider.
   */
  @visibility(Lifecycle.Read)
  connectionStatus?: SecurityPartnerProviderConnectionStatus;

  /**
   * The virtualHub to which the Security Partner Provider belongs.
   */
  virtualHub?: SubResource;
}

/**
 * Service Community Properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model BgpServiceCommunity extends Resource {
  /**
   * Properties of the BGP service community.
   */
  properties?: BgpServiceCommunityPropertiesFormat;
}

/**
 * Properties of Service Community.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model BgpServiceCommunityPropertiesFormat {
  /**
   * The name of the bgp community. e.g. Skype.
   */
  serviceName?: string;

  /**
   * A list of bgp communities.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  bgpCommunities?: BGPCommunity[];
}

/**
 * Contains bgp community information offered in Service Community resources.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model BGPCommunity {
  /**
   * The region which the service support. e.g. For O365, region is Global.
   */
  serviceSupportedRegion?: string;

  /**
   * The name of the bgp community. e.g. Skype.
   */
  communityName?: string;

  /**
   * The value of the bgp community. For more information: https://docs.microsoft.com/en-us/azure/expressroute/expressroute-routing.
   */
  communityValue?: string;

  /**
   * The prefixes that the bgp community contains.
   */
  communityPrefixes?: string[];

  /**
   * Customer is authorized to use bgp community or not.
   */
  isAuthorizedToUse?: boolean;

  /**
   * The service group of the bgp community contains.
   */
  serviceGroup?: string;
}

/**
 * Response for the ListServiceTags API service call.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model ServiceTagsListResult {
  /**
   * The name of the cloud.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The ID of the cloud.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The azure resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The iteration number.
   */
  @visibility(Lifecycle.Read)
  changeNumber?: string;

  /**
   * The name of the cloud.
   */
  @visibility(Lifecycle.Read)
  cloud?: string;

  /**
   * The list of service tag information resources.
   */
  @visibility(Lifecycle.Read)
  values?: ServiceTagInformation[];

  /**
   * The URL to get next page of service tag information resources.
   */
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * The service tag information.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model ServiceTagInformation {
  /**
   * Properties of the service tag information.
   */
  @visibility(Lifecycle.Read)
  properties?: ServiceTagInformationPropertiesFormat;

  /**
   * The name of service tag.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The ID of service tag.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The iteration number of service tag object for region.
   */
  @visibility(Lifecycle.Read)
  serviceTagChangeNumber?: string;
}

/**
 * Properties of the service tag information.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model ServiceTagInformationPropertiesFormat {
  /**
   * The iteration number of service tag.
   */
  @visibility(Lifecycle.Read)
  changeNumber?: string;

  /**
   * The region of service tag.
   */
  @visibility(Lifecycle.Read)
  region?: string;

  /**
   * The name of system service.
   */
  @visibility(Lifecycle.Read)
  systemService?: string;

  /**
   * The list of IP address prefixes.
   */
  @visibility(Lifecycle.Read)
  addressPrefixes?: string[];

  /**
   * The state of the service tag.
   */
  @visibility(Lifecycle.Read)
  state?: string;
}

/**
 * Response for Get ServiceTagInformation API service call. Retrieves the list of service tag information resources.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model ServiceTagInformationListResult is Azure.Core.Page<ServiceTagInformation>;

/**
 * The list usages operation response.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model UsagesListResult is Azure.Core.Page<Usage>;

/**
 * The network resource usage.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model Usage {
  /**
   * Resource identifier.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * An enum describing the unit of measurement.
   */
  unit: UsageUnit;

  /**
   * The current value of the usage.
   */
  currentValue: int64;

  /**
   * The limit of usage.
   */
  limit: int64;

  /**
   * The name of the type of usage.
   */
  name: UsageName;
}

/**
 * The usage names.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model UsageName {
  /**
   * A string describing the resource name.
   */
  value?: string;

  /**
   * A localized string describing the resource name.
   */
  localizedValue?: string;
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
  provisioningState?: NetworkProvisioningState;

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
  provisioningState?: NetworkProvisioningState;

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
 * Details of PrepareNetworkPolicies for Subnet.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model PrepareNetworkPoliciesRequest {
  /**
   * The name of the service for which subnet is being prepared for.
   */
  serviceName?: string;

  /**
   * A list of NetworkIntentPolicyConfiguration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  networkIntentPolicyConfigurations?: NetworkIntentPolicyConfiguration[];
}

/**
 * Details of NetworkIntentPolicyConfiguration for PrepareNetworkPoliciesRequest.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model NetworkIntentPolicyConfiguration {
  /**
   * The name of the Network Intent Policy for storing in target subscription.
   */
  networkIntentPolicyName?: string;

  /**
   * Source network intent policy.
   */
  sourceNetworkIntentPolicy?: NetworkIntentPolicy;
}

/**
 * Network Intent Policy resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model NetworkIntentPolicy extends Resource {
  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Details of UnprepareNetworkPolicies for Subnet.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model UnprepareNetworkPoliciesRequest {
  /**
   * The name of the service for which subnet is being unprepared for.
   */
  serviceName?: string;
}

/**
 * Response for CheckIPAddressAvailability API service call.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model IPAddressAvailabilityResult {
  /**
   * Private IP address availability.
   */
  available?: boolean;

  /**
   * Contains other available private IP addresses if the asked for address is taken.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  availableIPAddresses?: string[];

  /**
   * Private IP address platform reserved.
   */
  isPlatformReserved?: boolean;
}

/**
 * Response for the virtual networks GetUsage API service call.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VirtualNetworkListUsageResult is Azure.Core.Page<VirtualNetworkUsage>;

/**
 * Usage details for subnet.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VirtualNetworkUsage {
  /**
   * Indicates number of IPs used from the Subnet.
   */
  @visibility(Lifecycle.Read)
  currentValue?: float64;

  /**
   * Subnet identifier.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Indicates the size of the subnet.
   */
  @visibility(Lifecycle.Read)
  limit?: float64;

  /**
   * The name containing common and localized value for usage.
   */
  @visibility(Lifecycle.Read)
  name?: VirtualNetworkUsageName;

  /**
   * Usage units. Returns 'Count'.
   */
  @visibility(Lifecycle.Read)
  unit?: string;
}

/**
 * Usage strings container.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VirtualNetworkUsageName {
  /**
   * Localized subnet size and usage string.
   */
  @visibility(Lifecycle.Read)
  localizedValue?: string;

  /**
   * Subnet size and usage string.
   */
  @visibility(Lifecycle.Read)
  value?: string;
}

/**
 * Response for GetVirtualNetworkDdosProtectionStatusOperation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VirtualNetworkDdosProtectionStatusResult
  is Azure.Core.Page<PublicIpDdosProtectionStatusResult>;

/**
 * VirtualNetworkGateway properties.
 */
model VirtualNetworkGatewayPropertiesFormat {
  /**
   * Autoscale configuration for virutal network gateway
   */
  autoScaleConfiguration?: VirtualNetworkGatewayAutoScaleConfiguration;

  /**
   * IP configurations for virtual network gateway.
   */
  ipConfigurations?: VirtualNetworkGatewayIPConfiguration[];

  /**
   * The type of this virtual network gateway.
   */
  gatewayType?: VirtualNetworkGatewayType;

  /**
   * The type of this virtual network gateway.
   */
  vpnType?: VpnType;

  /**
   * The generation for this VirtualNetworkGateway. Must be None if gatewayType is not VPN.
   */
  vpnGatewayGeneration?: VpnGatewayGeneration;

  /**
   * Whether BGP is enabled for this virtual network gateway or not.
   */
  enableBgp?: boolean;

  /**
   * Whether private IP needs to be enabled on this gateway for connections or not.
   */
  enablePrivateIpAddress?: boolean;

  /**
   * The reference to the VirtualNetworkGatewayMigrationStatus which represents the status of migration.
   */
  virtualNetworkGatewayMigrationStatus?: VirtualNetworkGatewayMigrationStatus;

  /**
   * ActiveActive flag.
   */
  activeActive?: boolean;

  /**
   * To enable Advanced Connectivity feature for VPN gateway
   */
  enableHighBandwidthVpnGateway?: boolean;

  /**
   * disableIPSecReplayProtection flag.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disableIPSecReplayProtection?: boolean;

  /**
   * The reference to the LocalNetworkGateway resource which represents local network site having default routes. Assign Null value in case of removing existing default site setting.
   */
  gatewayDefaultSite?: SubResource;

  /**
   * The reference to the VirtualNetworkGatewaySku resource which represents the SKU selected for Virtual network gateway.
   */
  sku?: VirtualNetworkGatewaySku;

  /**
   * The reference to the VpnClientConfiguration resource which represents the P2S VpnClient configurations.
   */
  vpnClientConfiguration?: VpnClientConfiguration;

  /**
   * The reference to the VirtualNetworkGatewayPolicyGroup resource which represents the available VirtualNetworkGatewayPolicyGroup for the gateway.
   */
  virtualNetworkGatewayPolicyGroups?: VirtualNetworkGatewayPolicyGroup[];

  /**
   * Virtual network gateway's BGP speaker settings.
   */
  bgpSettings?: BgpSettings;

  /**
   * The reference to the address space resource which represents the custom routes address space specified by the customer for virtual network gateway and VpnClient.
   */
  customRoutes?: AddressSpace;

  /**
   * The resource GUID property of the virtual network gateway resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The provisioning state of the virtual network gateway resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * Whether dns forwarding is enabled or not.
   */
  enableDnsForwarding?: boolean;

  /**
   * The IP address allocated by the gateway to which dns requests can be sent.
   */
  @visibility(Lifecycle.Read)
  inboundDnsForwardingEndpoint?: string;

  /**
   * Customer vnet resource id. VirtualNetworkGateway of type local gateway is associated with the customer vnet.
   */
  vNetExtendedLocationResourceId?: string;

  /**
   * NatRules for virtual network gateway.
   */
  natRules?: VirtualNetworkGatewayNatRule[];

  /**
   * EnableBgpRouteTranslationForNat flag.
   */
  enableBgpRouteTranslationForNat?: boolean;

  /**
   * Configures this gateway to accept traffic from remote Virtual WAN networks.
   */
  allowVirtualWanTraffic?: boolean;

  /**
   * Configure this gateway to accept traffic from other Azure Virtual Networks. This configuration does not support connectivity to Azure Virtual WAN.
   */
  allowRemoteVnetTraffic?: boolean;

  /**
   * Property to indicate if the Express Route Gateway serves traffic when there are multiple Express Route Gateways in the vnet
   */
  adminState?: AdminState;

  /**
   * Property to indicate if the Express Route Gateway has resiliency model of MultiHomed or SingleHomed
   */
  resiliencyModel?: ResiliencyModel;
}

/**
 * Virtual Network Gateway Autoscale Configuration details
 */
model VirtualNetworkGatewayAutoScaleConfiguration {
  /**
   * The bounds of the autoscale configuration
   */
  bounds?: VirtualNetworkGatewayAutoScaleBounds;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VirtualNetworkGatewayAutoScaleBounds {
  /**
   * Minimum scale Units for Autoscale configuration
   */
  min?: int32;

  /**
   * Maximum Scale Units for Autoscale configuration
   */
  max?: int32;
}

/**
 * IP configuration for virtual network gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VirtualNetworkGatewayIPConfiguration extends SubResource {
  /**
   * Properties of the virtual network gateway ip configuration.
   */
  properties?: VirtualNetworkGatewayIPConfigurationPropertiesFormat;

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
 * Properties of VirtualNetworkGatewayIPConfiguration.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model VirtualNetworkGatewayIPConfigurationPropertiesFormat {
  /**
   * The private IP address allocation method.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateIPAllocationMethod?: IPAllocationMethod;

  /**
   * The reference to the subnet resource.
   */
  subnet?: SubResource;

  /**
   * The reference to the public IP resource.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicIPAddress?: SubResource;

  /**
   * Private IP Address for this gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  privateIPAddress?: string;

  /**
   * The provisioning state of the virtual network gateway IP configuration resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Migration status for the Virtual Network Gateway.
 */
model VirtualNetworkGatewayMigrationStatus {
  /**
   * Represent the current state of gateway migration.
   */
  state?: VirtualNetworkGatewayMigrationState;

  /**
   * Represent the current migration phase of gateway.
   */
  phase?: VirtualNetworkGatewayMigrationPhase;

  /**
   * Error if any occurs during migration.
   */
  errorMessage?: string;
}

/**
 * VirtualNetworkGatewaySku details.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model VirtualNetworkGatewaySku {
  /**
   * Gateway SKU name.
   */
  name?: VirtualNetworkGatewaySkuName;

  /**
   * Gateway SKU tier.
   */
  tier?: VirtualNetworkGatewaySkuTier;

  /**
   * The capacity.
   */
  @visibility(Lifecycle.Read)
  capacity?: int32;
}

/**
 * VpnClientConfiguration for P2S client.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model VpnClientConfiguration {
  /**
   * The reference to the address space resource which represents Address space for P2S VpnClient.
   */
  vpnClientAddressPool?: AddressSpace;

  /**
   * VpnClientRootCertificate for virtual network gateway.
   */
  vpnClientRootCertificates?: VpnClientRootCertificate[];

  /**
   * VpnClientRevokedCertificate for Virtual network gateway.
   */
  vpnClientRevokedCertificates?: VpnClientRevokedCertificate[];

  /**
   * VpnClientProtocols for Virtual network gateway.
   */
  vpnClientProtocols?: VpnClientProtocol[];

  /**
   * VPN authentication types for the virtual network gateway..
   */
  vpnAuthenticationTypes?: VpnAuthenticationType[];

  /**
   * VpnClientIpsecPolicies for virtual network gateway P2S client.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vpnClientIpsecPolicies?: IpsecPolicy[];

  /**
   * The radius server address property of the VirtualNetworkGateway resource for vpn client connection.
   */
  radiusServerAddress?: string;

  /**
   * The radius secret property of the VirtualNetworkGateway resource for vpn client connection. We will no longer return radiusServerSecret in VirtualNetworkGateway Create/Update/Get/List/UpdateTags APIs response. Please use VirtualNetworkGateway ListRadiusSecrets API to fetch radius server secrets.
   */
  @secret
  radiusServerSecret?: string;

  /**
   * The radiusServers property for multiple radius server configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  radiusServers?: RadiusServer[];

  /**
   * The AADTenant property of the VirtualNetworkGateway resource for vpn client connection used for AAD authentication.
   */
  aadTenant?: string;

  /**
   * The AADAudience property of the VirtualNetworkGateway resource for vpn client connection used for AAD authentication.
   */
  aadAudience?: string;

  /**
   * The AADIssuer property of the VirtualNetworkGateway resource for vpn client connection used for AAD authentication.
   */
  aadIssuer?: string;

  /**
   * per ip address pool connection policy for virtual network gateway P2S client.
   */
  vngClientConnectionConfigurations?: VngClientConnectionConfiguration[];
}

/**
 * VPN client root certificate of virtual network gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VpnClientRootCertificate extends SubResource {
  /**
   * Properties of the vpn client root certificate.
   */
  properties: VpnClientRootCertificatePropertiesFormat;

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
 * Properties of SSL certificates of application gateway.
 */
model VpnClientRootCertificatePropertiesFormat {
  /**
   * The certificate public data.
   */
  publicCertData: string;

  /**
   * The provisioning state of the VPN client root certificate resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * VPN client revoked certificate of virtual network gateway.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VpnClientRevokedCertificate extends SubResource {
  /**
   * Properties of the vpn client revoked certificate.
   */
  properties?: VpnClientRevokedCertificatePropertiesFormat;

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
 * Properties of the revoked VPN client certificate of virtual network gateway.
 */
model VpnClientRevokedCertificatePropertiesFormat {
  /**
   * The revoked VPN client certificate thumbprint.
   */
  thumbprint?: string;

  /**
   * The provisioning state of the VPN client revoked certificate resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * An IPSec Policy configuration for a virtual network gateway connection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model IpsecPolicy {
  /**
   * The IPSec Security Association (also called Quick Mode or Phase 2 SA) lifetime in seconds for a site to site VPN tunnel.
   */
  saLifeTimeSeconds: int32;

  /**
   * The IPSec Security Association (also called Quick Mode or Phase 2 SA) payload size in KB for a site to site VPN tunnel.
   */
  saDataSizeKilobytes: int32;

  /**
   * The IPSec encryption algorithm (IKE phase 1).
   */
  ipsecEncryption: IpsecEncryption;

  /**
   * The IPSec integrity algorithm (IKE phase 1).
   */
  ipsecIntegrity: IpsecIntegrity;

  /**
   * The IKE encryption algorithm (IKE phase 2).
   */
  ikeEncryption: IkeEncryption;

  /**
   * The IKE integrity algorithm (IKE phase 2).
   */
  ikeIntegrity: IkeIntegrity;

  /**
   * The DH Group used in IKE Phase 1 for initial SA.
   */
  dhGroup: DhGroup;

  /**
   * The Pfs Group used in IKE Phase 2 for new child SA.
   */
  pfsGroup: PfsGroup;
}

/**
 * Radius Server Settings.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model RadiusServer {
  /**
   * The address of this radius server.
   */
  radiusServerAddress: string;

  /**
   * The initial score assigned to this radius server.
   */
  radiusServerScore?: int64;

  /**
   * The secret used for this radius server. We will no longer return radiusServerSecret in VirtualNetworkGateway Create/Update/Get/List/UpdateTags APIs response. Please use VirtualNetworkGateway ListRadiusSecrets API to fetch radius server secrets.
   */
  @secret
  radiusServerSecret?: string;
}

/**
 * A vpn client connection configuration for client connection configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VngClientConnectionConfiguration extends SubResource {
  /**
   * Properties of the vpn client root certificate.
   */
  properties?: VngClientConnectionConfigurationProperties;

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
 * Properties of VngClientConnectionConfiguration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model VngClientConnectionConfigurationProperties {
  /**
   * The reference to the address space resource which represents Address space for P2S VpnClient.
   */
  vpnClientAddressPool: AddressSpace;

  /**
   * List of references to virtualNetworkGatewayPolicyGroups
   */
  virtualNetworkGatewayPolicyGroups: SubResource[];

  /**
   * The provisioning state of the VngClientConnectionConfiguration resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Parameters for VirtualNetworkGatewayPolicyGroup.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VirtualNetworkGatewayPolicyGroup extends SubResource {
  /**
   * Properties of tVirtualNetworkGatewayPolicyGroup.
   */
  properties?: VirtualNetworkGatewayPolicyGroupProperties;

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
 * Properties of VirtualNetworkGatewayPolicyGroup.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model VirtualNetworkGatewayPolicyGroupProperties {
  /**
   * Shows if this is a Default VirtualNetworkGatewayPolicyGroup or not.
   */
  isDefault: boolean;

  /**
   * Priority for VirtualNetworkGatewayPolicyGroup.
   */
  priority: int32;

  /**
   * Multiple PolicyMembers for VirtualNetworkGatewayPolicyGroup.
   */
  @identifiers(#[])
  policyMembers: VirtualNetworkGatewayPolicyGroupMember[];

  /**
   * List of references to vngClientConnectionConfigurations.
   */
  @visibility(Lifecycle.Read)
  vngClientConnectionConfigurations?: SubResource[];

  /**
   * The provisioning state of the VirtualNetworkGatewayPolicyGroup resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Vpn Client Connection configuration PolicyGroup member
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model VirtualNetworkGatewayPolicyGroupMember {
  /**
   * Name of the VirtualNetworkGatewayPolicyGroupMember.
   */
  name?: string;

  /**
   * The Vpn Policy member attribute type.
   */
  attributeType?: VpnPolicyMemberAttributeType;

  /**
   * The value of Attribute used for this VirtualNetworkGatewayPolicyGroupMember.
   */
  attributeValue?: string;
}

/**
 * BGP settings details.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model BgpSettings {
  /**
   * The BGP speaker's ASN.
   */
  @minValue(0)
  @maxValue(4294967295)
  asn?: int64;

  /**
   * The BGP peering address and BGP identifier of this BGP speaker.
   */
  bgpPeeringAddress?: string;

  /**
   * The weight added to routes learned from this BGP speaker.
   */
  peerWeight?: int32;

  /**
   * BGP peering address with IP configuration ID for virtual network gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  bgpPeeringAddresses?: IPConfigurationBgpPeeringAddress[];
}

/**
 * Properties of IPConfigurationBgpPeeringAddress.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model IPConfigurationBgpPeeringAddress {
  /**
   * The ID of IP configuration which belongs to gateway.
   */
  ipconfigurationId?: string;

  /**
   * The list of default BGP peering addresses which belong to IP configuration.
   */
  @visibility(Lifecycle.Read)
  defaultBgpIpAddresses?: string[];

  /**
   * The list of custom BGP peering addresses which belong to IP configuration.
   */
  customBgpIpAddresses?: string[];

  /**
   * The list of tunnel public IP addresses which belong to IP configuration.
   */
  @visibility(Lifecycle.Read)
  tunnelIpAddresses?: string[];
}

/**
 * Parameters for VirtualNetworkGatewayNatRule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model VirtualNetworkGatewayNatRuleProperties {
  /**
   * The provisioning state of the NAT Rule resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The type of NAT rule for VPN NAT.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type?: VpnNatRuleType;

  /**
   * The Source NAT direction of a VPN NAT.
   */
  mode?: VpnNatRuleMode;

  /**
   * The private IP address internal mapping for NAT.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  internalMappings?: VpnNatRuleMapping[];

  /**
   * The private IP address external mapping for NAT.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  externalMappings?: VpnNatRuleMapping[];

  /**
   * The IP Configuration ID this NAT rule applies to.
   */
  ipConfigurationId?: string;
}

/**
 * Vpn NatRule mapping.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnNatRuleMapping {
  /**
   * Address space for Vpn NatRule mapping.
   */
  addressSpace?: string;

  /**
   * Port range for Vpn NatRule mapping.
   */
  portRange?: string;
}

/**
 * Response for the VirtualNetworkGatewayListConnections API service call.
 */
model VirtualNetworkGatewayListConnectionsResult
  is Azure.Core.Page<VirtualNetworkGatewayConnectionListEntity>;

/**
 * A common class for general resource information.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VirtualNetworkGatewayConnectionListEntity extends Resource {
  /**
   * Properties of the virtual network gateway connection.
   */
  properties: VirtualNetworkGatewayConnectionListEntityPropertiesFormat;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * VirtualNetworkGatewayConnection properties.
 */
model VirtualNetworkGatewayConnectionListEntityPropertiesFormat {
  /**
   * The authorizationKey.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authorizationKey?: string;

  /**
   * The reference to virtual network gateway resource.
   */
  virtualNetworkGateway1: VirtualNetworkConnectionGatewayReference;

  /**
   * The reference to virtual network gateway resource.
   */
  virtualNetworkGateway2?: VirtualNetworkConnectionGatewayReference;

  /**
   * The reference to local network gateway resource.
   */
  localNetworkGateway2?: VirtualNetworkConnectionGatewayReference;

  /**
   * Gateway connection type.
   */
  connectionType: VirtualNetworkGatewayConnectionType;

  /**
   * Connection protocol used for this connection.
   */
  connectionProtocol?: VirtualNetworkGatewayConnectionProtocol;

  /**
   * The routing weight.
   */
  routingWeight?: int32;

  /**
   * The connection mode for this connection.
   */
  connectionMode?: VirtualNetworkGatewayConnectionMode;

  /**
   * The IPSec shared key. We will no longer return sharedKey in VirtualNetworkGatewayConnection Create/Update/Get/List/UpdateTags APIs response. Please use VirtualNetworkGatewayConnection GetSharedKey API to fetch connection sharedKey.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sharedKey?: string;

  /**
   * Virtual Network Gateway connection status.
   */
  @visibility(Lifecycle.Read)
  connectionStatus?: VirtualNetworkGatewayConnectionStatus;

  /**
   * Collection of all tunnels' connection health status.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tunnelConnectionStatus?: TunnelConnectionHealth[];

  /**
   * The egress bytes transferred in this connection.
   */
  @visibility(Lifecycle.Read)
  egressBytesTransferred?: int64;

  /**
   * The ingress bytes transferred in this connection.
   */
  @visibility(Lifecycle.Read)
  ingressBytesTransferred?: int64;

  /**
   * The reference to peerings resource.
   */
  peer?: SubResource;

  /**
   * EnableBgp flag.
   */
  enableBgp?: boolean;

  /**
   * GatewayCustomBgpIpAddresses to be used for virtual network gateway Connection.
   */
  @identifiers(#[])
  gatewayCustomBgpIpAddresses?: GatewayCustomBgpIpAddressIpConfiguration[];

  /**
   * Enable policy-based traffic selectors.
   */
  usePolicyBasedTrafficSelectors?: boolean;

  /**
   * The IPSec Policies to be considered by this connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ipsecPolicies?: IpsecPolicy[];

  /**
   * The Traffic Selector Policies to be considered by this connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  trafficSelectorPolicies?: TrafficSelectorPolicy[];

  /**
   * The resource GUID property of the virtual network gateway connection resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The provisioning state of the virtual network gateway connection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * Bypass ExpressRoute Gateway for data forwarding.
   */
  expressRouteGatewayBypass?: boolean;

  /**
   * Bypass the ExpressRoute gateway when accessing private-links. ExpressRoute FastPath (expressRouteGatewayBypass) must be enabled.
   */
  enablePrivateLinkFastPath?: boolean;
}

/**
 * A reference to VirtualNetworkGateway or LocalNetworkGateway resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model VirtualNetworkConnectionGatewayReference {
  /**
   * The ID of VirtualNetworkGateway or LocalNetworkGateway resource.
   */
  id: string;
}

/**
 * VirtualNetworkGatewayConnection properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model TunnelConnectionHealth {
  /**
   * Tunnel name.
   */
  @visibility(Lifecycle.Read)
  tunnel?: string;

  /**
   * Virtual Network Gateway connection status.
   */
  @visibility(Lifecycle.Read)
  connectionStatus?: VirtualNetworkGatewayConnectionStatus;

  /**
   * The Ingress Bytes Transferred in this connection.
   */
  @visibility(Lifecycle.Read)
  ingressBytesTransferred?: int64;

  /**
   * The Egress Bytes Transferred in this connection.
   */
  @visibility(Lifecycle.Read)
  egressBytesTransferred?: int64;

  /**
   * The time at which connection was established in Utc format.
   */
  @visibility(Lifecycle.Read)
  lastConnectionEstablishedUtcTime?: string;
}

/**
 * GatewayCustomBgpIpAddressIpConfiguration for a virtual network gateway connection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model GatewayCustomBgpIpAddressIpConfiguration {
  /**
   * The IpconfigurationId of ipconfiguration which belongs to gateway.
   */
  ipConfigurationId: string;

  /**
   * The custom BgpPeeringAddress which belongs to IpconfigurationId.
   */
  customBgpIpAddress: string;
}

/**
 * An traffic selector policy for a virtual network gateway connection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model TrafficSelectorPolicy {
  /**
   * A collection of local address spaces in CIDR format.
   */
  localAddressRanges: string[];

  /**
   * A collection of remote address spaces in CIDR format.
   */
  remoteAddressRanges: string[];
}

/**
 * Vpn Client Parameters for package generation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model VpnClientParameters {
  /**
   * VPN client Processor Architecture.
   */
  processorArchitecture?: ProcessorArchitecture;

  /**
   * VPN client authentication method.
   */
  authenticationMethod?: AuthenticationMethod;

  /**
   * The public certificate data for the radius server authentication certificate as a Base-64 encoded string. Required only if external radius authentication has been configured with EAPTLS authentication.
   */
  radiusServerAuthCertificate?: string;

  /**
   * A list of client root certificates public certificate data encoded as Base-64 strings. Optional parameter for external radius based authentication with EAPTLS.
   */
  clientRootCertificates?: string[];
}

/**
 * Response for list BGP peer status API service call.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model BgpPeerStatusListResult {
  /**
   * List of BGP peers.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pageItems
  value?: BgpPeerStatus[];
}

/**
 * BGP peer status details.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model BgpPeerStatus {
  /**
   * The virtual network gateway's local address.
   */
  @visibility(Lifecycle.Read)
  localAddress?: string;

  /**
   * The remote BGP peer.
   */
  @visibility(Lifecycle.Read)
  neighbor?: string;

  /**
   * The autonomous system number of the remote BGP peer.
   */
  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(4294967295)
  asn?: int64;

  /**
   * The BGP peer state.
   */
  @visibility(Lifecycle.Read)
  state?: BgpPeerState;

  /**
   * For how long the peering has been up.
   */
  @visibility(Lifecycle.Read)
  connectedDuration?: string;

  /**
   * The number of routes learned from this peer.
   */
  @visibility(Lifecycle.Read)
  routesReceived?: int64;

  /**
   * The number of BGP messages sent.
   */
  @visibility(Lifecycle.Read)
  messagesSent?: int64;

  /**
   * The number of BGP messages received.
   */
  @visibility(Lifecycle.Read)
  messagesReceived?: int64;
}

/**
 * List of Radius servers with respective radius secrets.
 */
model RadiusAuthServerListResult is Azure.Core.Page<RadiusAuthServer>;

/**
 * Gateway or VpnServerConfiguration Radius server with radius secret details
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model RadiusAuthServer {
  /**
   * Radius server IPAddress
   */
  radiusServerAddress?: string;

  /**
   * Radius server secret
   */
  @secret
  radiusServerSecret?: string;
}

/**
 * List of virtual network gateway routes.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model GatewayRouteListResult {
  /**
   * List of gateway routes.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pageItems
  value?: GatewayRoute[];
}

/**
 * Gateway routing details.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model GatewayRoute {
  /**
   * The gateway's local address.
   */
  @visibility(Lifecycle.Read)
  localAddress?: string;

  /**
   * The route's network prefix.
   */
  @visibility(Lifecycle.Read)
  network?: string;

  /**
   * The route's next hop.
   */
  @visibility(Lifecycle.Read)
  nextHop?: string;

  /**
   * The peer this route was learned from.
   */
  @visibility(Lifecycle.Read)
  sourcePeer?: string;

  /**
   * The source this route was learned from.
   */
  @visibility(Lifecycle.Read)
  origin?: string;

  /**
   * The route's AS path sequence.
   */
  @visibility(Lifecycle.Read)
  asPath?: string;

  /**
   * The route's weight.
   */
  @visibility(Lifecycle.Read)
  weight?: int32;
}

/**
 * Gateway Resiliency Information
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model GatewayResiliencyInformation {
  /**
   * Current Resiliency Score for the gateway
   */
  overallScore?: string;

  /**
   * Update in the Resiliency Score for the gateway from the last computed score
   */
  scoreChange?: string;

  /**
   * Minimum increase expected in the score if the at least one of the recommendations is applied for the gateway
   */
  minScoreFromRecommendations?: string;

  /**
   * Maximum increase expected in the score if all of the recommendations are applied for the gateway
   */
  maxScoreFromRecommendations?: string;

  /**
   * Timestamp denoting the last time when the resiliency score was computed for the gateway
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastComputedTime?: utcDateTime;

  /**
   * Timestamp denoting the next eligible time to re-compute the resiliency score for the gateway
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextEligibleComputeTime?: utcDateTime;

  /**
   * List of Resiliency based Recommendation Components for the gateway
   */
  components?: ResiliencyRecommendationComponents[];
}

/**
 * Gateway Resiliency based Recommendations
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model ResiliencyRecommendationComponents {
  /**
   * Name of the Resiliency based Recommendation Component
   */
  name?: string;

  /**
   * Current Score of the gateway
   */
  currentScore?: string;

  /**
   * Max score that the gateway can achieve if the specified recommendation is applied
   */
  maxScore?: string;

  /**
   * List of Gateway Resiliency based Recommendations
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  recommendations?: GatewayResiliencyRecommendation[];
}

/**
 * Resiliency Recommendation details
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model GatewayResiliencyRecommendation {
  /**
   * Recommendation Title
   */
  recommendationTitle?: string;

  /**
   * Recommendation Id
   */
  recommendationId?: string;

  /**
   * Impact associated with the recommendation
   */
  severity?: string;

  /**
   * Recommendation details
   */
  recommendationText?: string;

  /**
   * Acton items to apply the recommendation
   */
  callToActionText?: string;

  /**
   * Link to the public documentation for the associated recommendation
   */
  callToActionLink?: string;
}

/**
 * Gateway Route Sets Information
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model GatewayRouteSetsInformation {
  /**
   * Timestamp denoting the last time when the route sets were computed for the gateway
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastComputedTime?: utcDateTime;

  /**
   * Timestamp denoting the next eligible time to re-compute the route sets for the gateway
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextEligibleComputeTime?: utcDateTime;

  /**
   * Version for the route set
   */
  routeSetVersion?: string;

  /**
   * List of Gateway Route Sets
   */
  routeSets?: GatewayRouteSet[];

  /**
   * Dictionary containing map of the circuit id and circuit details
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  circuitsMetadataMap?: Record<CircuitMetadataMap>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model GatewayRouteSet {
  /**
   * Route Set name
   */
  name?: string;

  /**
   * List of different locations from where the routes are learned
   */
  locations?: string[];

  /**
   * List of different Route Sources
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  details?: Record<RouteSourceDetails[]>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model RouteSourceDetails {
  /**
   * Express Route Circuit identifier
   */
  circuit?: string;

  /**
   * Flag to indicate if the route learned from the primary device is active or passive
   */
  pri?: string;

  /**
   * Flag to indicate if the route learned from the secondary device is active or passive
   */
  sec?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model CircuitMetadataMap {
  /**
   * Express Route Circuit Name
   */
  name?: string;

  /**
   * Link to the Express Route circuit
   */
  link?: string;

  /**
   * Peering location of the Express Route Circuit
   */
  location?: string;
}

/**
 * An IPSec parameters for a virtual network gateway P2S connection.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model VpnClientIPsecParameters {
  /**
   * The IPSec Security Association (also called Quick Mode or Phase 2 SA) lifetime in seconds for P2S client.
   */
  saLifeTimeSeconds: int32;

  /**
   * The IPSec Security Association (also called Quick Mode or Phase 2 SA) payload size in KB for P2S client..
   */
  saDataSizeKilobytes: int32;

  /**
   * The IPSec encryption algorithm (IKE phase 1).
   */
  ipsecEncryption: IpsecEncryption;

  /**
   * The IPSec integrity algorithm (IKE phase 1).
   */
  ipsecIntegrity: IpsecIntegrity;

  /**
   * The IKE encryption algorithm (IKE phase 2).
   */
  ikeEncryption: IkeEncryption;

  /**
   * The IKE integrity algorithm (IKE phase 2).
   */
  ikeIntegrity: IkeIntegrity;

  /**
   * The DH Group used in IKE Phase 1 for initial SA.
   */
  dhGroup: DhGroup;

  /**
   * The Pfs Group used in IKE Phase 2 for new child SA.
   */
  pfsGroup: PfsGroup;
}

/**
 * Vpn device configuration script generation parameters.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model VpnDeviceScriptParameters {
  /**
   * The vendor for the vpn device.
   */
  vendor?: string;

  /**
   * The device family for the vpn device.
   */
  deviceFamily?: string;

  /**
   * The firmware version for the vpn device.
   */
  firmwareVersion?: string;
}

/**
 * Start packet capture parameters on virtual network gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model VpnPacketCaptureStartParameters {
  /**
   * Start Packet capture parameters.
   */
  filterData?: string;
}

/**
 * Stop packet capture parameters.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model VpnPacketCaptureStopParameters {
  /**
   * SAS url for packet capture on virtual network gateway.
   */
  sasUrl?: string;
}

/**
 * ExpressRoute failover test details
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model ExpressRouteFailoverTestDetails {
  /**
   * Peering location of the test
   */
  peeringLocation?: string;

  /**
   * All circuits in the peering location
   */
  circuits?: ExpressRouteFailoverCircuitResourceDetails[];

  /**
   * The current status of the test
   */
  status?: FailoverTestStatus;

  /**
   * Time when the test was started
   */
  startTime?: string;

  /**
   * Time when the test was completed
   */
  endTime?: string;

  /**
   * All connections to the circuits in the peering location
   */
  connections?: ExpressRouteFailoverConnectionResourceDetails[];

  /**
   * The unique GUID associated with the test
   */
  testGuid?: string;

  /**
   * The type of failover test
   */
  testType?: FailoverTestType;

  /**
   * A list of all issues with the test
   */
  issues?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model ExpressRouteFailoverCircuitResourceDetails {
  /**
   * NRP Resource URI of the circuit
   */
  nrpResourceUri?: Azure.Core.armResourceIdentifier;

  /**
   * Circuit Name
   */
  name?: string;

  /**
   * Connection name associated with the circuit
   */
  connectionName?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model ExpressRouteFailoverConnectionResourceDetails {
  /**
   * NRP Resource URI of the connection
   */
  nrpResourceUri?: Azure.Core.armResourceIdentifier;

  /**
   * Connection Name
   */
  name?: string;

  /**
   * The current status of the connection
   */
  status?: FailoverConnectionStatus;

  /**
   * Time when the connection was last updated
   */
  lastUpdatedTime?: string;
}

/**
 * ExpressRoute failover single test details
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model ExpressRouteFailoverSingleTestDetails {
  /**
   * Peering location of the test
   */
  peeringLocation?: string;

  /**
   * The current status of the test
   */
  status?: FailoverTestStatusForSingleTest;

  /**
   * Time when the test was started
   */
  startTimeUtc?: string;

  /**
   * Time when the test was completed
   */
  endTimeUtc?: string;

  /**
   * List of routes received from this peering as well as some other peering location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  redundantRoutes?: ExpressRouteFailoverRedundantRoute[];

  /**
   * List of al the routes that were received only from this peering location
   */
  nonRedundantRoutes?: string[];

  /**
   * Whether the failover simulation was successful or not
   */
  wasSimulationSuccessful?: boolean;

  /**
   * List of all the failover connections for this peering location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  failoverConnectionDetails?: FailoverConnectionDetails[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model ExpressRouteFailoverRedundantRoute {
  /**
   * A list of all the peering locations for the redundant routes
   */
  peeringLocations?: string[];

  /**
   * A list of all the redundant routes in the peering locations
   */
  routes?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model FailoverConnectionDetails {
  /**
   * Name of the failover connection
   */
  failoverConnectionName?: string;

  /**
   * Location of the failover connection
   */
  failoverLocation?: string;

  /**
   * Whether the customer was able to establish connectivity through this failover connection or not
   */
  isVerified?: boolean;
}

/**
 * Start packet capture parameters on virtual network gateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model ExpressRouteFailoverStopApiParameters {
  /**
   * Peering location of the test
   */
  peeringLocation?: string;

  /**
   * Whether the failover simulation was successful or not
   */
  wasSimulationSuccessful?: boolean;

  /**
   * List of all the failover connections for this peering location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  details?: FailoverConnectionDetails[];
}

/**
 * VirtualNetworkGatewayConnection properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model VirtualNetworkGatewayConnectionPropertiesFormat {
  /**
   * The authorizationKey.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authorizationKey?: string;

  /**
   * The reference to virtual network gateway resource.
   */
  virtualNetworkGateway1: VirtualNetworkGateway;

  /**
   * The reference to virtual network gateway resource.
   */
  virtualNetworkGateway2?: VirtualNetworkGateway;

  /**
   * The reference to local network gateway resource.
   */
  localNetworkGateway2?: LocalNetworkGateway;

  /**
   * List of ingress NatRules.
   */
  ingressNatRules?: SubResource[];

  /**
   * List of egress NatRules.
   */
  egressNatRules?: SubResource[];

  /**
   * Gateway connection type.
   */
  connectionType: VirtualNetworkGatewayConnectionType;

  /**
   * Connection protocol used for this connection.
   */
  connectionProtocol?: VirtualNetworkGatewayConnectionProtocol;

  /**
   * The routing weight.
   */
  routingWeight?: int32;

  /**
   * The dead peer detection timeout of this connection in seconds.
   */
  dpdTimeoutSeconds?: int32;

  /**
   * The connection mode for this connection.
   */
  connectionMode?: VirtualNetworkGatewayConnectionMode;

  /**
   * Tunnel properties for virtual network gateway connection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tunnelProperties?: VirtualNetworkGatewayConnectionTunnelProperties[];

  /**
   * The IPSec shared key.
   */
  @secret
  sharedKey?: string;

  /**
   * Virtual Network Gateway connection status.
   */
  @visibility(Lifecycle.Read)
  connectionStatus?: VirtualNetworkGatewayConnectionStatus;

  /**
   * Collection of all tunnels' connection health status.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tunnelConnectionStatus?: TunnelConnectionHealth[];

  /**
   * The egress bytes transferred in this connection.
   */
  @visibility(Lifecycle.Read)
  egressBytesTransferred?: int64;

  /**
   * The ingress bytes transferred in this connection.
   */
  @visibility(Lifecycle.Read)
  ingressBytesTransferred?: int64;

  /**
   * The reference to peerings resource.
   */
  peer?: SubResource;

  /**
   * EnableBgp flag.
   */
  enableBgp?: boolean;

  /**
   * GatewayCustomBgpIpAddresses to be used for virtual network gateway Connection.
   */
  @identifiers(#[])
  gatewayCustomBgpIpAddresses?: GatewayCustomBgpIpAddressIpConfiguration[];

  /**
   * Use private local Azure IP for the connection.
   */
  useLocalAzureIpAddress?: boolean;

  /**
   * Enable policy-based traffic selectors.
   */
  usePolicyBasedTrafficSelectors?: boolean;

  /**
   * The IPSec Policies to be considered by this connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ipsecPolicies?: IpsecPolicy[];

  /**
   * The Traffic Selector Policies to be considered by this connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  trafficSelectorPolicies?: TrafficSelectorPolicy[];

  /**
   * The resource GUID property of the virtual network gateway connection resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The provisioning state of the virtual network gateway connection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * Bypass ExpressRoute Gateway for data forwarding.
   */
  expressRouteGatewayBypass?: boolean;

  /**
   * Bypass the ExpressRoute gateway when accessing private-links. ExpressRoute FastPath (expressRouteGatewayBypass) must be enabled.
   */
  enablePrivateLinkFastPath?: boolean;

  /**
   * Gateway connection authentication type.
   */
  authenticationType?: ConnectionAuthenticationType;

  /**
   * Certificate Authentication information for a certificate based authentication connection.
   */
  certificateAuthentication?: CertificateAuthentication;
}

/**
 * LocalNetworkGateway properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model LocalNetworkGatewayPropertiesFormat {
  /**
   * Local network site address space.
   */
  localNetworkAddressSpace?: AddressSpace;

  /**
   * IP address of local network gateway.
   */
  gatewayIpAddress?: string;

  /**
   * FQDN of local network gateway.
   */
  fqdn?: string;

  /**
   * Local network gateway's BGP speaker settings.
   */
  bgpSettings?: BgpSettings;

  /**
   * The resource GUID property of the local network gateway resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The provisioning state of the local network gateway resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VirtualNetworkGatewayConnectionTunnelProperties {
  /**
   * Tunnel remote IP address
   */
  tunnelIpAddress?: string;

  /**
   * Tunnel BGP peering address
   */
  bgpPeeringAddress?: string;
}

/**
 * Certificate Authentication information for a certificate based authentication connection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model CertificateAuthentication {
  /**
   * Keyvault secret ID for outbound authentication certificate.
   */
  outboundAuthCertificate?: url;

  /**
   * Inbound authentication certificate subject name.
   */
  inboundAuthCertificateSubjectName?: string;

  /**
   * Inbound authentication certificate public keys.
   */
  inboundAuthCertificateChain?: string[];
}

/**
 * Response for GetConnectionSharedKey API service call.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model ConnectionSharedKey extends SubResource {
  /**
   * The virtual network connection shared key value.
   */
  value: string;
}

/**
 * The virtual network connection reset shared key.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model ConnectionResetSharedKey {
  /**
   * The virtual network connection reset shared key length, should between 1 and 128.
   */
  @maxValue(128)
  @minValue(1)
  keyLength: int32;
}

/**
 * List of virtual network gateway vpn client connection health.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model VpnClientConnectionHealthDetailListResult {
  /**
   * List of vpn client connection health.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pageItems
  value?: VpnClientConnectionHealthDetail[];
}

/**
 * VPN client connection health detail.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model VpnClientConnectionHealthDetail {
  /**
   * The vpn client Id.
   */
  @visibility(Lifecycle.Read)
  vpnConnectionId?: string;

  /**
   * The duration time of a connected vpn client.
   */
  @visibility(Lifecycle.Read)
  vpnConnectionDuration?: int64;

  /**
   * The start time of a connected vpn client.
   */
  @visibility(Lifecycle.Read)
  vpnConnectionTime?: string;

  /**
   * The public Ip of a connected vpn client.
   */
  @visibility(Lifecycle.Read)
  publicIpAddress?: string;

  /**
   * The assigned private Ip of a connected vpn client.
   */
  @visibility(Lifecycle.Read)
  privateIpAddress?: string;

  /**
   * The user name of a connected vpn client.
   */
  @visibility(Lifecycle.Read)
  vpnUserName?: string;

  /**
   * The max band width.
   */
  @visibility(Lifecycle.Read)
  maxBandwidth?: int64;

  /**
   * The egress packets per second.
   */
  @visibility(Lifecycle.Read)
  egressPacketsTransferred?: int64;

  /**
   * The egress bytes per second.
   */
  @visibility(Lifecycle.Read)
  egressBytesTransferred?: int64;

  /**
   * The ingress packets per second.
   */
  @visibility(Lifecycle.Read)
  ingressPacketsTransferred?: int64;

  /**
   * The ingress bytes per second.
   */
  @visibility(Lifecycle.Read)
  ingressBytesTransferred?: int64;

  /**
   * The max packets transferred per second.
   */
  @visibility(Lifecycle.Read)
  maxPacketsPerSecond?: int64;
}

/**
 * List of p2s vpn connections to be disconnected.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model P2SVpnConnectionRequest {
  /**
   * List of p2s vpn connection Ids.
   */
  vpnConnectionIds?: string[];
}

/**
 * Result of the request to list all nat rules to a virtual network gateway. It contains a list of Nat rules and a URL nextLink to get the next set of results.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model ListVirtualNetworkGatewayNatRulesResult
  is Azure.Core.Page<VirtualNetworkGatewayNatRule>;

/**
 * Virtual network gateway migration parameters.
 */
model VirtualNetworkGatewayMigrationParameters {
  /**
   * MigrationType for the virtual network gateway.
   */
  migrationType: VirtualNetworkGatewayMigrationType;

  /**
   * Resource url that needs to be passed in to migration.
   */
  resourceUrl?: string;
}

/**
 * Virtual Router definition.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VirtualRouterPropertiesFormat {
  /**
   * VirtualRouter ASN.
   */
  @minValue(0)
  @maxValue(4294967295)
  virtualRouterAsn?: int64;

  /**
   * VirtualRouter IPs.
   */
  virtualRouterIps?: string[];

  /**
   * The Subnet on which VirtualRouter is hosted.
   */
  hostedSubnet?: SubResource;

  /**
   * The Gateway on which VirtualRouter is hosted.
   */
  hostedGateway?: SubResource;

  /**
   * List of references to VirtualRouterPeerings.
   */
  @visibility(Lifecycle.Read)
  peerings?: SubResource[];

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Properties of the rule group.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VirtualRouterPeeringProperties {
  /**
   * Peer ASN.
   */
  @minValue(0)
  @maxValue(4294967295)
  peerAsn?: int64;

  /**
   * Peer IP.
   */
  peerIp?: string;

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Parameters for VirtualWAN.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VirtualWanProperties {
  /**
   * Vpn encryption to be disabled or not.
   */
  disableVpnEncryption?: boolean;

  /**
   * List of VirtualHubs in the VirtualWAN.
   */
  @visibility(Lifecycle.Read)
  virtualHubs?: SubResource[];

  /**
   * List of VpnSites in the VirtualWAN.
   */
  @visibility(Lifecycle.Read)
  vpnSites?: SubResource[];

  /**
   * True if branch to branch traffic is allowed.
   */
  allowBranchToBranchTraffic?: boolean;

  /**
   * True if Vnet to Vnet traffic is allowed.
   */
  allowVnetToVnetTraffic?: boolean;

  /**
   * The office local breakout category.
   */
  @visibility(Lifecycle.Read)
  office365LocalBreakoutCategory?: OfficeTrafficCategory;

  /**
   * The provisioning state of the virtual WAN resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The type of the VirtualWAN.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type?: string;
}

/**
 * Result of the request to list VirtualWANs. It contains a list of VirtualWANs and a URL nextLink to get the next set of results.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model ListVirtualWANsResult is Azure.Core.Page<VirtualWAN>;

/**
 * Parameters for VpnSite.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnSiteProperties {
  /**
   * The VirtualWAN to which the vpnSite belongs.
   */
  virtualWan?: SubResource;

  /**
   * The device properties.
   */
  deviceProperties?: DeviceProperties;

  /**
   * The ip-address for the vpn-site.
   */
  ipAddress?: string;

  /**
   * The key for vpn-site that can be used for connections.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  siteKey?: string;

  /**
   * The AddressSpace that contains an array of IP address ranges.
   */
  addressSpace?: AddressSpace;

  /**
   * The set of bgp properties.
   */
  bgpProperties?: BgpSettings;

  /**
   * The provisioning state of the VPN site resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * IsSecuritySite flag.
   */
  isSecuritySite?: boolean;

  /**
   * List of all vpn site links.
   */
  vpnSiteLinks?: VpnSiteLink[];

  /**
   * Office365 Policy.
   */
  o365Policy?: O365PolicyProperties;
}

/**
 * List of properties of the device.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model DeviceProperties {
  /**
   * Name of the device Vendor.
   */
  deviceVendor?: string;

  /**
   * Model of the device.
   */
  deviceModel?: string;

  /**
   * Link speed.
   */
  linkSpeedInMbps?: int32;
}

/**
 * Parameters for VpnSite.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnSiteLinkProperties {
  /**
   * The link provider properties.
   */
  linkProperties?: VpnLinkProviderProperties;

  /**
   * The ip-address for the vpn-site-link.
   */
  ipAddress?: string;

  /**
   * FQDN of vpn-site-link.
   */
  fqdn?: string;

  /**
   * The set of bgp properties.
   */
  bgpProperties?: VpnLinkBgpSettings;

  /**
   * The provisioning state of the VPN site link resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * List of properties of a link provider.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnLinkProviderProperties {
  /**
   * Name of the link provider.
   */
  linkProviderName?: string;

  /**
   * Link speed.
   */
  linkSpeedInMbps?: int32;
}

/**
 * BGP settings details for a link.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnLinkBgpSettings {
  /**
   * The BGP speaker's ASN.
   */
  asn?: int64;

  /**
   * The BGP peering address and BGP identifier of this BGP speaker.
   */
  bgpPeeringAddress?: string;
}

/**
 * The Office365 breakout policy.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model O365PolicyProperties {
  /**
   * Office365 breakout categories.
   */
  breakOutCategories?: O365BreakOutCategoryPolicies;
}

/**
 * Office365 breakout categories.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model O365BreakOutCategoryPolicies {
  /**
   * Flag to control allow category.
   */
  allow?: boolean;

  /**
   * Flag to control optimize category.
   */
  optimize?: boolean;

  /**
   * Flag to control default category.
   */
  default?: boolean;
}

/**
 * Result of the request to list VpnSites. It contains a list of VpnSites and a URL nextLink to get the next set of results.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model ListVpnSitesResult is Azure.Core.Page<VpnSite>;

/**
 * Result of the request to list VpnSiteLinks. It contains a list of VpnSiteLinks and a URL nextLink to get the next set of results.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model ListVpnSiteLinksResult is Azure.Core.Page<VpnSiteLink>;

/**
 * List of Vpn-Sites.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model GetVpnSitesConfigurationRequest {
  /**
   * List of resource-ids of the vpn-sites for which config is to be downloaded.
   */
  vpnSites?: string[];

  /**
   * The sas-url to download the configurations for vpn-sites.
   */
  outputBlobSasUrl: string;
}

/**
 * Collection of SecurityProviders.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VirtualWanSecurityProviders {
  /**
   * List of VirtualWAN security providers.
   */
  supportedProviders?: VirtualWanSecurityProvider[];
}

/**
 * Collection of SecurityProviders.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VirtualWanSecurityProvider {
  /**
   * Name of the security provider.
   */
  name?: string;

  /**
   * Url of the security provider.
   */
  url?: string;

  /**
   * Name of the security provider.
   */
  @visibility(Lifecycle.Read)
  type?: VirtualWanSecurityProviderType;
}

/**
 * Parameters for VpnServerConfiguration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnServerConfigurationProperties {
  /**
   * The name of the VpnServerConfiguration that is unique within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: string;

  /**
   * VPN protocols for the VpnServerConfiguration.
   */
  vpnProtocols?: VpnGatewayTunnelingProtocol[];

  /**
   * VPN authentication types for the VpnServerConfiguration.
   */
  vpnAuthenticationTypes?: VpnAuthenticationType[];

  /**
   * VPN client root certificate of VpnServerConfiguration.
   */
  vpnClientRootCertificates?: VpnServerConfigVpnClientRootCertificate[];

  /**
   * VPN client revoked certificate of VpnServerConfiguration.
   */
  vpnClientRevokedCertificates?: VpnServerConfigVpnClientRevokedCertificate[];

  /**
   * Radius Server root certificate of VpnServerConfiguration.
   */
  radiusServerRootCertificates?: VpnServerConfigRadiusServerRootCertificate[];

  /**
   * Radius client root certificate of VpnServerConfiguration.
   */
  radiusClientRootCertificates?: VpnServerConfigRadiusClientRootCertificate[];

  /**
   * VpnClientIpsecPolicies for VpnServerConfiguration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vpnClientIpsecPolicies?: IpsecPolicy[];

  /**
   * The radius server address property of the VpnServerConfiguration resource for point to site client connection.
   */
  radiusServerAddress?: string;

  /**
   * The radius secret property of the VpnServerConfiguration resource for point to site client connection. We will no longer return radiusServerSecret in VpnServerConfiguration Create/Update/Get/List/UpdateTags APIs response. Please use VpnServerConfiguration ListRadiusSecrets API to fetch radius server secrets.
   */
  @secret
  radiusServerSecret?: string;

  /**
   * Multiple Radius Server configuration for VpnServerConfiguration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  radiusServers?: RadiusServer[];

  /**
   * The set of aad vpn authentication parameters.
   */
  aadAuthenticationParameters?: AadAuthenticationParameters;

  /**
   * The provisioning state of the VpnServerConfiguration resource. Possible values are: 'Updating', 'Deleting', and 'Failed'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * List of references to P2SVpnGateways.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  p2SVpnGateways?: P2SVpnGateway[];

  /**
   * List of all VpnServerConfigurationPolicyGroups.
   */
  configurationPolicyGroups?: VpnServerConfigurationPolicyGroup[];

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Properties of VPN client root certificate of VpnServerConfiguration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnServerConfigVpnClientRootCertificate {
  /**
   * The certificate name.
   */
  name?: string;

  /**
   * The certificate public data.
   */
  publicCertData?: string;
}

/**
 * Properties of the revoked VPN client certificate of VpnServerConfiguration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnServerConfigVpnClientRevokedCertificate {
  /**
   * The certificate name.
   */
  name?: string;

  /**
   * The revoked VPN client certificate thumbprint.
   */
  thumbprint?: string;
}

/**
 * Properties of Radius Server root certificate of VpnServerConfiguration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnServerConfigRadiusServerRootCertificate {
  /**
   * The certificate name.
   */
  name?: string;

  /**
   * The certificate public data.
   */
  publicCertData?: string;
}

/**
 * Properties of the Radius client root certificate of VpnServerConfiguration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnServerConfigRadiusClientRootCertificate {
  /**
   * The certificate name.
   */
  name?: string;

  /**
   * The Radius client root certificate thumbprint.
   */
  thumbprint?: string;
}

/**
 * AAD Vpn authentication type related parameters.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model AadAuthenticationParameters {
  /**
   * AAD Vpn authentication parameter AAD tenant.
   */
  aadTenant?: string;

  /**
   * AAD Vpn authentication parameter AAD audience.
   */
  aadAudience?: string;

  /**
   * AAD Vpn authentication parameter AAD issuer.
   */
  aadIssuer?: string;
}

/**
 * Parameters for P2SVpnGateway.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model P2SVpnGatewayProperties {
  /**
   * The VirtualHub to which the gateway belongs.
   */
  virtualHub?: SubResource;

  /**
   * List of all p2s connection configurations of the gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  p2SConnectionConfigurations?: P2SConnectionConfiguration[];

  /**
   * The provisioning state of the P2S VPN gateway resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The scale unit for this p2s vpn gateway.
   */
  vpnGatewayScaleUnit?: int32;

  /**
   * The VpnServerConfiguration to which the p2sVpnGateway is attached to.
   */
  vpnServerConfiguration?: SubResource;

  /**
   * All P2S VPN clients' connection health status.
   */
  @visibility(Lifecycle.Read)
  vpnClientConnectionHealth?: VpnClientConnectionHealth;

  /**
   * List of all customer specified DNS servers IP addresses.
   */
  customDnsServers?: string[];

  /**
   * Enable Routing Preference property for the Public IP Interface of the P2SVpnGateway.
   */
  isRoutingPreferenceInternet?: boolean;
}

/**
 * P2SConnectionConfiguration Resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model P2SConnectionConfiguration extends SubResource {
  /**
   * Properties of the P2S connection configuration.
   */
  properties?: P2SConnectionConfigurationProperties;

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
 * Parameters for P2SConnectionConfiguration.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model P2SConnectionConfigurationProperties {
  /**
   * The reference to the address space resource which represents Address space for P2S VpnClient.
   */
  vpnClientAddressPool?: AddressSpace;

  /**
   * The Routing Configuration indicating the associated and propagated route tables on this connection.
   */
  routingConfiguration?: RoutingConfiguration;

  /**
   * Flag indicating whether the enable internet security flag is turned on for the P2S Connections or not.
   */
  enableInternetSecurity?: boolean;

  /**
   * List of Configuration Policy Groups that this P2SConnectionConfiguration is attached to.
   */
  configurationPolicyGroupAssociations?: SubResource[];

  /**
   * List of previous Configuration Policy Groups that this P2SConnectionConfiguration was attached to.
   */
  @visibility(Lifecycle.Read)
  previousConfigurationPolicyGroupAssociations?: VpnServerConfigurationPolicyGroup[];

  /**
   * The provisioning state of the P2SConnectionConfiguration resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Routing Configuration indicating the associated and propagated route tables for this connection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model RoutingConfiguration {
  /**
   * The resource id RouteTable associated with this RoutingConfiguration.
   */
  associatedRouteTable?: SubResource;

  /**
   * The list of RouteTables to advertise the routes to.
   */
  propagatedRouteTables?: PropagatedRouteTable;

  /**
   * List of routes that control routing from VirtualHub into a virtual network connection.
   */
  vnetRoutes?: VnetRoute;

  /**
   * The resource id of the RouteMap associated with this RoutingConfiguration for inbound learned routes.
   */
  inboundRouteMap?: SubResource;

  /**
   * The resource id of theRouteMap associated with this RoutingConfiguration for outbound advertised routes.
   */
  outboundRouteMap?: SubResource;
}

/**
 * The list of RouteTables to advertise the routes to.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model PropagatedRouteTable {
  /**
   * The list of labels.
   */
  labels?: string[];

  /**
   * The list of resource ids of all the RouteTables.
   */
  ids?: SubResource[];
}

/**
 * List of routes that control routing from VirtualHub into a virtual network connection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VnetRoute {
  /**
   * Configuration for static routes on this HubVnetConnection.
   */
  staticRoutesConfig?: StaticRoutesConfig;

  /**
   * List of all Static Routes.
   */
  staticRoutes?: StaticRoute[];

  /**
   * The list of references to HubBgpConnection objects.
   */
  @visibility(Lifecycle.Read)
  bgpConnections?: SubResource[];
}

/**
 * Configuration for static routes on this HubVnetConnectionConfiguration for static routes on this HubVnetConnection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model StaticRoutesConfig {
  /**
   * Boolean indicating whether static routes on this connection are automatically propagate to route tables which this connection propagates to.
   */
  @visibility(Lifecycle.Read)
  propagateStaticRoutes?: boolean;

  /**
   * Parameter determining whether NVA in spoke vnet is bypassed for traffic with destination in spoke.
   */
  vnetLocalRouteOverrideCriteria?: VnetLocalRouteOverrideCriteria;
}

/**
 * List of all Static Routes.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model StaticRoute {
  /**
   * The name of the StaticRoute that is unique within a VnetRoute.
   */
  name?: string;

  /**
   * List of all address prefixes.
   */
  addressPrefixes?: string[];

  /**
   * The ip address of the next hop.
   */
  nextHopIpAddress?: string;
}

/**
 * Parameters for VpnServerConfigurationPolicyGroup.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnServerConfigurationPolicyGroupProperties {
  /**
   * Shows if this is a Default VpnServerConfigurationPolicyGroup or not.
   */
  isDefault?: boolean;

  /**
   * Priority for VpnServerConfigurationPolicyGroup.
   */
  priority?: int32;

  /**
   * Multiple PolicyMembers for VpnServerConfigurationPolicyGroup.
   */
  @identifiers(#[])
  policyMembers?: VpnServerConfigurationPolicyGroupMember[];

  /**
   * List of references to P2SConnectionConfigurations.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  p2SConnectionConfigurations?: SubResource[];

  /**
   * The provisioning state of the VpnServerConfigurationPolicyGroup resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * VpnServerConfiguration PolicyGroup member
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnServerConfigurationPolicyGroupMember {
  /**
   * Name of the VpnServerConfigurationPolicyGroupMember.
   */
  name?: string;

  /**
   * The Vpn Policy member attribute type.
   */
  attributeType?: VpnPolicyMemberAttributeType;

  /**
   * The value of Attribute used for this VpnServerConfigurationPolicyGroupMember.
   */
  attributeValue?: string;
}

/**
 * VpnClientConnectionHealth properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
model VpnClientConnectionHealth {
  /**
   * Total of the Ingress Bytes Transferred in this P2S Vpn connection.
   */
  @visibility(Lifecycle.Read)
  totalIngressBytesTransferred?: int64;

  /**
   * Total of the Egress Bytes Transferred in this connection.
   */
  @visibility(Lifecycle.Read)
  totalEgressBytesTransferred?: int64;

  /**
   * The total of p2s vpn clients connected at this time to this P2SVpnGateway.
   */
  vpnClientConnectionsCount?: int32;

  /**
   * List of allocated ip addresses to the connected p2s vpn clients.
   */
  allocatedIpAddresses?: string[];
}

/**
 * Result of the request to list all VpnServerConfigurations. It contains a list of VpnServerConfigurations and a URL nextLink to get the next set of results.
 */
model ListVpnServerConfigurationsResult
  is Azure.Core.Page<VpnServerConfiguration>;

/**
 * Result of the request to list VpnServerConfigurationPolicyGroups. It contains a list of VpnServerConfigurationPolicyGroups and a URL nextLink to get the next set of results.
 */
model ListVpnServerConfigurationPolicyGroupsResult
  is Azure.Core.Page<VpnServerConfigurationPolicyGroup>;

/**
 * Parameters for VirtualHub.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VirtualHubProperties {
  /**
   * The VirtualWAN to which the VirtualHub belongs.
   */
  virtualWan?: SubResource;

  /**
   * The VpnGateway associated with this VirtualHub.
   */
  vpnGateway?: SubResource;

  /**
   * The P2SVpnGateway associated with this VirtualHub.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  p2SVpnGateway?: SubResource;

  /**
   * The expressRouteGateway associated with this VirtualHub.
   */
  expressRouteGateway?: SubResource;

  /**
   * The azureFirewall associated with this VirtualHub.
   */
  azureFirewall?: SubResource;

  /**
   * The securityPartnerProvider associated with this VirtualHub.
   */
  securityPartnerProvider?: SubResource;

  /**
   * Address-prefix for this VirtualHub.
   */
  addressPrefix?: string;

  /**
   * The routeTable associated with this virtual hub.
   */
  routeTable?: VirtualHubRouteTable;

  /**
   * The provisioning state of the virtual hub resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The Security Provider name.
   */
  securityProviderName?: string;

  /**
   * List of all virtual hub route table v2s associated with this VirtualHub.
   */
  virtualHubRouteTableV2s?: VirtualHubRouteTableV2[];

  /**
   * The sku of this VirtualHub.
   */
  sku?: string;

  /**
   * The routing state.
   */
  @visibility(Lifecycle.Read)
  routingState?: RoutingState;

  /**
   * List of references to Bgp Connections.
   */
  @visibility(Lifecycle.Read)
  bgpConnections?: SubResource[];

  /**
   * List of references to IpConfigurations.
   */
  @visibility(Lifecycle.Read)
  ipConfigurations?: SubResource[];

  /**
   * List of references to RouteMaps.
   */
  @visibility(Lifecycle.Read)
  routeMaps?: SubResource[];

  /**
   * VirtualRouter ASN.
   */
  @minValue(0)
  @maxValue(4294967295)
  virtualRouterAsn?: int64;

  /**
   * VirtualRouter IPs.
   */
  virtualRouterIps?: string[];

  /**
   * Flag to control transit for VirtualRouter hub.
   */
  allowBranchToBranchTraffic?: boolean;

  /**
   * The preferred gateway to route on-prem traffic
   */
  preferredRoutingGateway?: PreferredRoutingGateway;

  /**
   * The hubRoutingPreference of this VirtualHub.
   */
  hubRoutingPreference?: HubRoutingPreference;

  /**
   * The VirtualHub Router autoscale configuration.
   */
  virtualRouterAutoScaleConfiguration?: VirtualRouterAutoScaleConfiguration;
}

/**
 * VirtualHub route table.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VirtualHubRouteTable {
  /**
   * List of all routes.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  routes?: VirtualHubRoute[];
}

/**
 * VirtualHub route.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VirtualHubRoute {
  /**
   * List of all addressPrefixes.
   */
  addressPrefixes?: string[];

  /**
   * NextHop ip address.
   */
  nextHopIpAddress?: string;
}

/**
 * VirtualHubRouteTableV2 Resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VirtualHubRouteTableV2 extends SubResource {
  /**
   * Properties of the virtual hub route table v2.
   */
  properties?: VirtualHubRouteTableV2Properties;

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
 * Parameters for VirtualHubRouteTableV2.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VirtualHubRouteTableV2Properties {
  /**
   * List of all routes.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  routes?: VirtualHubRouteV2[];

  /**
   * List of all connections attached to this route table v2.
   */
  attachedConnections?: string[];

  /**
   * The provisioning state of the virtual hub route table v2 resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * VirtualHubRouteTableV2 route.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VirtualHubRouteV2 {
  /**
   * The type of destinations.
   */
  destinationType?: string;

  /**
   * List of all destinations.
   */
  destinations?: string[];

  /**
   * The type of next hops.
   */
  nextHopType?: string;

  /**
   * NextHops ip address.
   */
  nextHops?: string[];
}

/**
 * The VirtualHub Router autoscale configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VirtualRouterAutoScaleConfiguration {
  /**
   * The minimum number of scale units for VirtualHub Router.
   */
  @minValue(0)
  minCapacity?: int32;
}

/**
 * Result of the request to list VirtualHubs. It contains a list of VirtualHubs and a URL nextLink to get the next set of results.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model ListVirtualHubsResult is Azure.Core.Page<VirtualHub>;

/**
 * Properties of RouteMap resource
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model RouteMapProperties {
  /**
   * List of connections which have this RoutMap associated for inbound traffic.
   */
  associatedInboundConnections?: string[];

  /**
   * List of connections which have this RoutMap associated for outbound traffic.
   */
  associatedOutboundConnections?: string[];

  /**
   * List of RouteMap rules to be applied.
   */
  @identifiers(#[])
  rules?: RouteMapRule[];

  /**
   * The provisioning state of the RouteMap resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * A RouteMap Rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model RouteMapRule {
  /**
   * The unique name for the rule.
   */
  name?: string;

  /**
   * List of matching criterion which will be applied to traffic.
   */
  @identifiers(#[])
  matchCriteria?: Criterion[];

  /**
   * List of actions which will be applied on a match.
   */
  @identifiers(#[])
  actions?: Action[];

  /**
   * Next step after rule is evaluated. Current supported behaviors are 'Continue'(to next rule) and 'Terminate'.
   */
  nextStepIfMatched?: NextStep;
}

/**
 * A matching criteria which matches routes based on route prefix, community, and AS path.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model Criterion {
  /**
   * List of route prefixes which this criteria matches.
   */
  routePrefix?: string[];

  /**
   * List of BGP communities which this criteria matches.
   */
  community?: string[];

  /**
   * List of AS paths which this criteria matches.
   */
  asPath?: string[];

  /**
   * Match condition to apply RouteMap rules.
   */
  matchCondition?: RouteMapMatchCondition;
}

/**
 * Action to be taken on a route matching a RouteMap criterion.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model Action {
  /**
   * Type of action to be taken. Supported types are 'Remove', 'Add', 'Replace', and 'Drop.'
   */
  type?: RouteMapActionType;

  /**
   * List of parameters relevant to the action.For instance if type is drop then parameters has list of prefixes to be dropped.If type is add, parameters would have list of ASN numbers to be added
   */
  @identifiers(#[])
  parameters?: Parameter[];
}

/**
 * Parameters for an Action.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model Parameter {
  /**
   * List of route prefixes.
   */
  routePrefix?: string[];

  /**
   * List of BGP communities.
   */
  community?: string[];

  /**
   * List of AS paths.
   */
  asPath?: string[];
}

/**
 * List of RouteMaps and a URL nextLink to get the next set of results.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model ListRouteMapsResult is Azure.Core.Page<RouteMap>;

/**
 * HubVirtualNetworkConnection Resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model HubVirtualNetworkConnection extends SubResource {
  /**
   * Properties of the hub virtual network connection.
   */
  properties?: HubVirtualNetworkConnectionProperties;

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
 * Parameters for HubVirtualNetworkConnection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model HubVirtualNetworkConnectionProperties {
  /**
   * Reference to the remote virtual network.
   */
  remoteVirtualNetwork?: SubResource;

  /**
   * Deprecated: VirtualHub to RemoteVnet transit to enabled or not.
   */
  allowHubToRemoteVnetTransit?: boolean;

  /**
   * Deprecated: Allow RemoteVnet to use Virtual Hub's gateways.
   */
  allowRemoteVnetToUseHubVnetGateways?: boolean;

  /**
   * Enable internet security.
   */
  enableInternetSecurity?: boolean;

  /**
   * The Routing Configuration indicating the associated and propagated route tables on this connection.
   */
  routingConfiguration?: RoutingConfiguration;

  /**
   * The provisioning state of the hub virtual network connection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * List of HubVirtualNetworkConnections and a URL nextLink to get the next set of results.
 */
model ListHubVirtualNetworkConnectionsResult
  is Azure.Core.Page<HubVirtualNetworkConnection>;

/**
 * Parameters for VpnGateway.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnGatewayProperties {
  /**
   * The VirtualHub to which the gateway belongs.
   */
  virtualHub?: SubResource;

  /**
   * List of all vpn connections to the gateway.
   */
  connections?: VpnConnection[];

  /**
   * Local network gateway's BGP speaker settings.
   */
  bgpSettings?: BgpSettings;

  /**
   * The provisioning state of the VPN gateway resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The scale unit for this vpn gateway.
   */
  vpnGatewayScaleUnit?: int32;

  /**
   * List of all IPs configured on the gateway.
   */
  @visibility(Lifecycle.Read)
  ipConfigurations?: VpnGatewayIpConfiguration[];

  /**
   * Enable BGP routes translation for NAT on this VpnGateway.
   */
  enableBgpRouteTranslationForNat?: boolean;

  /**
   * Enable Routing Preference property for the Public IP Interface of the VpnGateway.
   */
  isRoutingPreferenceInternet?: boolean;

  /**
   * List of all the nat Rules associated with the gateway.
   */
  natRules?: VpnGatewayNatRule[];
}

/**
 * VpnConnection Resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnConnection extends SubResource {
  /**
   * Properties of the VPN connection.
   */
  properties?: VpnConnectionProperties;

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
 * Parameters for VpnConnection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnConnectionProperties {
  /**
   * Id of the connected vpn site.
   */
  remoteVpnSite?: SubResource;

  /**
   * Routing weight for vpn connection.
   */
  routingWeight?: int32;

  /**
   * DPD timeout in seconds for vpn connection.
   */
  dpdTimeoutSeconds?: int32;

  /**
   * The connection status.
   */
  @visibility(Lifecycle.Read)
  connectionStatus?: VpnConnectionStatus;

  /**
   * Connection protocol used for this connection.
   */
  vpnConnectionProtocolType?: VirtualNetworkGatewayConnectionProtocol;

  /**
   * Ingress bytes transferred.
   */
  @visibility(Lifecycle.Read)
  ingressBytesTransferred?: int64;

  /**
   * Egress bytes transferred.
   */
  @visibility(Lifecycle.Read)
  egressBytesTransferred?: int64;

  /**
   * Expected bandwidth in MBPS.
   */
  connectionBandwidth?: int32;

  /**
   * Deprecated: SharedKey for the vpn connection. This is no more used.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sharedKey?: string;

  /**
   * EnableBgp flag.
   */
  enableBgp?: boolean;

  /**
   * Enable policy-based traffic selectors.
   */
  usePolicyBasedTrafficSelectors?: boolean;

  /**
   * The IPSec Policies to be considered by this connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ipsecPolicies?: IpsecPolicy[];

  /**
   * The Traffic Selector Policies to be considered by this connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  trafficSelectorPolicies?: TrafficSelectorPolicy[];

  /**
   * EnableBgp flag.
   */
  enableRateLimiting?: boolean;

  /**
   * Enable internet security.
   */
  enableInternetSecurity?: boolean;

  /**
   * Use local azure ip to initiate connection.
   */
  useLocalAzureIpAddress?: boolean;

  /**
   * The provisioning state of the VPN connection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * List of all vpn site link connections to the gateway.
   */
  vpnLinkConnections?: VpnSiteLinkConnection[];

  /**
   * The Routing Configuration indicating the associated and propagated route tables on this connection.
   */
  routingConfiguration?: RoutingConfiguration;
}

/**
 * Parameters for VpnConnection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnSiteLinkConnectionProperties {
  /**
   * Id of the connected vpn site link.
   */
  vpnSiteLink?: SubResource;

  /**
   * Routing weight for vpn connection.
   */
  routingWeight?: int32;

  /**
   * Vpn link connection mode.
   */
  vpnLinkConnectionMode?: VpnLinkConnectionMode;

  /**
   * The connection status.
   */
  @visibility(Lifecycle.Read)
  connectionStatus?: VpnConnectionStatus;

  /**
   * Connection protocol used for this connection.
   */
  vpnConnectionProtocolType?: VirtualNetworkGatewayConnectionProtocol;

  /**
   * Ingress bytes transferred.
   */
  @visibility(Lifecycle.Read)
  ingressBytesTransferred?: int64;

  /**
   * Egress bytes transferred.
   */
  @visibility(Lifecycle.Read)
  egressBytesTransferred?: int64;

  /**
   * Expected bandwidth in MBPS.
   */
  connectionBandwidth?: int32;

  /**
   * SharedKey for the vpn link connection. We will no longer return sharedKey in any Create/Update/Get/List/UpdateTags VpnGateway/VpnConnection/VpnLinkConnection APIs response. Please use 'Vpn Link Connections - List Default Shared Key' API to fetch Vpn link connection sharedKey.
   */
  @secret
  sharedKey?: string;

  /**
   * EnableBgp flag.
   */
  enableBgp?: boolean;

  /**
   * vpnGatewayCustomBgpAddresses used by this connection.
   */
  @identifiers(#[])
  vpnGatewayCustomBgpAddresses?: GatewayCustomBgpIpAddressIpConfiguration[];

  /**
   * Enable policy-based traffic selectors.
   */
  usePolicyBasedTrafficSelectors?: boolean;

  /**
   * The IPSec Policies to be considered by this connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ipsecPolicies?: IpsecPolicy[];

  /**
   * EnableBgp flag.
   */
  enableRateLimiting?: boolean;

  /**
   * Use local azure ip to initiate connection.
   */
  useLocalAzureIpAddress?: boolean;

  /**
   * The provisioning state of the VPN site link connection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * List of ingress NatRules.
   */
  ingressNatRules?: SubResource[];

  /**
   * List of egress NatRules.
   */
  egressNatRules?: SubResource[];

  /**
   * Dead Peer Detection timeout in seconds for VpnLink connection.
   */
  dpdTimeoutSeconds?: int32;
}

/**
 * IP Configuration of a VPN Gateway Resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnGatewayIpConfiguration {
  /**
   * The identifier of the IP configuration for a VPN Gateway.
   */
  id?: string;

  /**
   * The public IP address of this IP configuration.
   */
  publicIpAddress?: string;

  /**
   * The private IP address of this IP configuration.
   */
  privateIpAddress?: string;
}

/**
 * Parameters for VpnGatewayNatRule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnGatewayNatRuleProperties {
  /**
   * The provisioning state of the NAT Rule resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The type of NAT rule for VPN NAT.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type?: VpnNatRuleType;

  /**
   * The Source NAT direction of a VPN NAT.
   */
  mode?: VpnNatRuleMode;

  /**
   * The private IP address internal mapping for NAT.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  internalMappings?: VpnNatRuleMapping[];

  /**
   * The private IP address external mapping for NAT.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  externalMappings?: VpnNatRuleMapping[];

  /**
   * The IP Configuration ID this NAT rule applies to.
   */
  ipConfigurationId?: string;

  /**
   * List of egress VpnSiteLinkConnections.
   */
  @visibility(Lifecycle.Read)
  egressVpnSiteLinkConnections?: SubResource[];

  /**
   * List of ingress VpnSiteLinkConnections.
   */
  @visibility(Lifecycle.Read)
  ingressVpnSiteLinkConnections?: SubResource[];
}

/**
 * Start packet capture parameters.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnGatewayPacketCaptureStartParameters {
  /**
   * Start Packet capture parameters on vpn gateway.
   */
  filterData?: string;
}

/**
 * Stop packet capture parameters.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnGatewayPacketCaptureStopParameters {
  /**
   * SAS url for packet capture on vpn gateway.
   */
  sasUrl?: string;
}

/**
 * The list of shared keys for the vpn link connection. It should only contain one shared key for each vpn link connection.
 */
model ConnectionSharedKeyResultList
  is Azure.Core.Page<ConnectionSharedKeyResult>;

/**
 * Parameters for SharedKey.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model SharedKeyProperties {
  /**
   * The value of the shared key for the vpn link connection.
   */
  @secret
  sharedKey?: string;

  /**
   * The length of the shared key for the vpn link connection.
   */
  @maxValue(128)
  @minValue(1)
  sharedKeyLength?: int32;

  /**
   * The provisioning state of the SharedKey resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * Result of the request to list VpnGateways. It contains a list of VpnGateways and a URL nextLink to get the next set of results.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model ListVpnGatewaysResult is Azure.Core.Page<VpnGateway>;

/**
 * Vpn Connection packet capture parameters supplied to start packet capture on gateway connection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnConnectionPacketCaptureStartParameters {
  /**
   * Start Packet capture parameters on vpn connection.
   */
  filterData?: string;

  /**
   * List of site link connection names.
   */
  linkConnectionNames?: string[];
}

/**
 * Vpn Connection packet capture parameters supplied to stop packet capture on gateway connection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnConnectionPacketCaptureStopParameters {
  /**
   * SAS url for packet capture on vpn connection.
   */
  sasUrl?: string;

  /**
   * List of site link connection names.
   */
  linkConnectionNames?: string[];
}

/**
 * Result of the request to list all vpn connections to a virtual wan vpn gateway. It contains a list of Vpn Connections and a URL nextLink to get the next set of results.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model ListVpnConnectionsResult is Azure.Core.Page<VpnConnection>;

/**
 * Result of the request to list all vpn connections to a virtual wan vpn gateway. It contains a list of Vpn Connections and a URL nextLink to get the next set of results.
 */
model ListVpnSiteLinkConnectionsResult
  is Azure.Core.Page<VpnSiteLinkConnection>;

/**
 * Result of the request to list all nat rules to a virtual wan vpn gateway. It contains a list of Nat rules and a URL nextLink to get the next set of results.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model ListVpnGatewayNatRulesResult is Azure.Core.Page<VpnGatewayNatRule>;

/**
 * Result of the request to list P2SVpnGateways. It contains a list of P2SVpnGateways and a URL nextLink to get the next set of results.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model ListP2SVpnGatewaysResult is Azure.Core.Page<P2SVpnGateway>;

/**
 * Vpn Client Parameters for package generation.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model P2SVpnProfileParameters {
  /**
   * VPN client authentication method.
   */
  authenticationMethod?: AuthenticationMethod;
}

/**
 * Vpn Profile Response for package generation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnProfileResponse {
  /**
   * URL to the VPN profile.
   */
  profileUrl?: string;
}

/**
 * List of P2S Vpn connection health request.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model P2SVpnConnectionHealthRequest {
  /**
   * The list of p2s vpn user names whose p2s vpn connection detailed health to retrieve for.
   */
  vpnUserNamesFilter?: string[];

  /**
   * The sas-url to download the P2S Vpn connection health detail.
   */
  outputBlobSasUrl?: string;
}

/**
 * P2S Vpn connection detailed health written to sas url.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model P2SVpnConnectionHealth {
  /**
   * Returned sas url of the blob to which the p2s vpn connection detailed health will be written.
   */
  sasUrl?: string;
}

/**
 * VpnServerConfigurations list associated with VirtualWan Response.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnServerConfigurationsResponse {
  /**
   * List of VpnServerConfigurations associated with VirtualWan.
   */
  vpnServerConfigurationResourceIds?: string[];
}

/**
 * Virtual Wan Vpn profile parameters Vpn profile generation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VirtualWanVpnProfileParameters {
  /**
   * VpnServerConfiguration partial resource uri with which VirtualWan is associated to.
   */
  vpnServerConfigurationResourceId?: string;

  /**
   * VPN client authentication method.
   */
  authenticationMethod?: AuthenticationMethod;
}

/**
 * List of VirtualHubRouteTableV2s and a URL nextLink to get the next set of results.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ListVirtualHubRouteTableV2SResult
  is Azure.Core.Page<VirtualHubRouteTableV2>;

/**
 * List of ExpressRoute gateways.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model ExpressRouteGatewayList {
  /**
   * List of ExpressRoute gateways.
   */
  @pageItems
  value?: ExpressRouteGateway[];
}

/**
 * ExpressRoute gateway resource properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model ExpressRouteGatewayProperties {
  /**
   * Configuration for auto scaling.
   */
  autoScaleConfiguration?: ExpressRouteGatewayPropertiesAutoScaleConfiguration;

  /**
   * List of ExpressRoute connections to the ExpressRoute gateway.
   */
  expressRouteConnections?: ExpressRouteConnection[];

  /**
   * The provisioning state of the express route gateway resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The Virtual Hub where the ExpressRoute gateway is or will be deployed.
   */
  virtualHub: VirtualHubId;

  /**
   * Configures this gateway to accept traffic from non Virtual WAN networks.
   */
  allowNonVirtualWanTraffic?: boolean;
}

/**
 * Configuration for auto scaling.
 */
model ExpressRouteGatewayPropertiesAutoScaleConfiguration {
  /**
   * Minimum and maximum number of scale units to deploy.
   */
  bounds?: ExpressRouteGatewayPropertiesAutoScaleConfigurationBounds;
}

/**
 * Minimum and maximum number of scale units to deploy.
 */
model ExpressRouteGatewayPropertiesAutoScaleConfigurationBounds {
  /**
   * Minimum number of scale units deployed for ExpressRoute gateway.
   */
  min?: int32;

  /**
   * Maximum number of scale units deployed for ExpressRoute gateway.
   */
  max?: int32;
}

/**
 * ExpressRouteConnection resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model ExpressRouteConnection extends SubResource {
  /**
   * Properties of the express route connection.
   */
  properties?: ExpressRouteConnectionProperties;

  /**
   * The name of the resource.
   */
  name: string;
}

/**
 * Properties of the ExpressRouteConnection subresource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model ExpressRouteConnectionProperties {
  /**
   * The provisioning state of the express route connection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The ExpressRoute circuit peering.
   */
  expressRouteCircuitPeering: ExpressRouteCircuitPeeringId;

  /**
   * Authorization key to establish the connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authorizationKey?: string;

  /**
   * The routing weight associated to the connection.
   */
  routingWeight?: int32;

  /**
   * Enable internet security.
   */
  enableInternetSecurity?: boolean;

  /**
   * Enable FastPath to vWan Firewall hub.
   */
  expressRouteGatewayBypass?: boolean;

  /**
   * Bypass the ExpressRoute gateway when accessing private-links. ExpressRoute FastPath (expressRouteGatewayBypass) must be enabled.
   */
  enablePrivateLinkFastPath?: boolean;

  /**
   * The Routing Configuration indicating the associated and propagated route tables on this connection.
   */
  routingConfiguration?: RoutingConfiguration;
}

/**
 * ExpressRoute circuit peering identifier.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model ExpressRouteCircuitPeeringId {
  /**
   * The ID of the ExpressRoute circuit peering.
   */
  id?: string;
}

/**
 * Virtual Hub identifier.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VirtualHubId {
  /**
   * The resource URI for the Virtual Hub where the ExpressRoute gateway is or will be deployed. The Virtual Hub resource and the ExpressRoute gateway resource reside in the same subscription.
   */
  id?: string;
}

/**
 * ExpressRouteConnection list.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model ExpressRouteConnectionList {
  /**
   * The list of ExpressRoute connections.
   */
  @pageItems
  value?: ExpressRouteConnection[];
}

/**
 * NetworkVirtualApplianceConnection resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model NetworkVirtualApplianceConnection extends SubResource {
  /**
   * Properties of the express route connection.
   */
  properties?: NetworkVirtualApplianceConnectionProperties;

  /**
   * The name of the resource.
   */
  name?: string;
}

/**
 * Properties of the NetworkVirtualApplianceConnection subresource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model NetworkVirtualApplianceConnectionProperties {
  /**
   * The name of the resource.
   */
  name?: string;

  /**
   * The provisioning state of the NetworkVirtualApplianceConnection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * Network Virtual Appliance ASN.
   */
  @minValue(0)
  @maxValue(4294967295)
  asn?: int64;

  /**
   * Unique identifier for the connection.
   */
  @minValue(0)
  @maxValue(4294967295)
  tunnelIdentifier?: int64;

  /**
   * List of bgpPeerAddresses for the NVA instances
   */
  bgpPeerAddress?: string[];

  /**
   * Enable internet security.
   */
  enableInternetSecurity?: boolean;

  /**
   * The Routing Configuration indicating the associated and propagated route tables on this connection.
   */
  routingConfiguration?: RoutingConfiguration;
}

/**
 * NetworkVirtualApplianceConnection list.
 */
model NetworkVirtualApplianceConnectionList
  is Azure.Core.Page<NetworkVirtualApplianceConnection>;

/**
 * Properties of the bgp connection.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model BgpConnectionProperties {
  /**
   * Peer ASN.
   */
  @minValue(0)
  @maxValue(4294967295)
  peerAsn?: int64;

  /**
   * Peer IP.
   */
  peerIp?: string;

  /**
   * The reference to the HubVirtualNetworkConnection resource.
   */
  hubVirtualNetworkConnection?: SubResource;

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * The current state of the VirtualHub to Peer.
   */
  @visibility(Lifecycle.Read)
  connectionState?: HubBgpConnectionStatus;
}

/**
 * VirtualHubBgpConnections list.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model ListVirtualHubBgpConnectionResults is Azure.Core.Page<BgpConnection>;

/**
 * Peer routing details.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model PeerRoute {
  /**
   * The peer's local address.
   */
  @visibility(Lifecycle.Read)
  localAddress?: string;

  /**
   * The route's network prefix.
   */
  @visibility(Lifecycle.Read)
  network?: string;

  /**
   * The route's next hop.
   */
  @visibility(Lifecycle.Read)
  nextHop?: string;

  /**
   * The peer this route was learned from.
   */
  @visibility(Lifecycle.Read)
  sourcePeer?: string;

  /**
   * The source this route was learned from.
   */
  @visibility(Lifecycle.Read)
  origin?: string;

  /**
   * The route's AS path sequence.
   */
  @visibility(Lifecycle.Read)
  asPath?: string;

  /**
   * The route's weight.
   */
  @visibility(Lifecycle.Read)
  weight?: int32;
}

/**
 * Map from virtual router instance to list of peer routes.
 */
alias PeerRouteList = Record<PeerRoute[]>;

/**
 * Properties of IP configuration.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model HubIPConfigurationPropertiesFormat {
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicIPAddress?: PublicIPAddress;

  /**
   * The provisioning state of the IP configuration resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * VirtualHubIpConfigurations list.
 */
model ListVirtualHubIpConfigurationResults
  is Azure.Core.Page<HubIpConfiguration>;

/**
 * Parameters for RouteTable.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model HubRouteTableProperties {
  /**
   * List of all routes.
   */
  routes?: HubRoute[];

  /**
   * List of labels associated with this route table.
   */
  labels?: string[];

  /**
   * List of all connections associated with this route table.
   */
  @visibility(Lifecycle.Read)
  associatedConnections?: string[];

  /**
   * List of all connections that advertise to this route table.
   */
  @visibility(Lifecycle.Read)
  propagatingConnections?: string[];

  /**
   * The provisioning state of the RouteTable resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * RouteTable route.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model HubRoute {
  /**
   * The name of the Route that is unique within a RouteTable. This name can be used to access this route.
   */
  name: string;

  /**
   * The type of destinations (eg: CIDR, ResourceId, Service).
   */
  destinationType: string;

  /**
   * List of all destinations.
   */
  destinations: string[];

  /**
   * The type of next hop (eg: ResourceId).
   */
  nextHopType: string;

  /**
   * NextHop resource ID.
   */
  nextHop: string;
}

/**
 * List of RouteTables and a URL nextLink to get the next set of results.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model ListHubRouteTablesResult is Azure.Core.Page<HubRouteTable>;

/**
 * The parameters specifying the resource whose effective routes are being requested.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model EffectiveRoutesParameters {
  /**
   * The resource whose effective routes are being requested.
   */
  resourceId?: string;

  /**
   * The type of the specified resource like RouteTable, ExpressRouteConnection, HubVirtualNetworkConnection, VpnConnection and P2SConnection.
   */
  virtualWanResourceType?: string;
}

/**
 * EffectiveRoutes List.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VirtualHubEffectiveRouteList {
  /**
   * The list of effective routes configured on the virtual hub or the specified resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pageItems
  value?: VirtualHubEffectiveRoute[];
}

/**
 * The effective route configured on the virtual hub or specified resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VirtualHubEffectiveRoute {
  /**
   * The list of address prefixes.
   */
  addressPrefixes?: string[];

  /**
   * The list of next hops.
   */
  nextHops?: string[];

  /**
   * The type of the next hop.
   */
  nextHopType?: string;

  /**
   * The ASPath of this route.
   */
  asPath?: string;

  /**
   * The origin of this route.
   */
  routeOrigin?: string;
}

/**
 * The parameters specifying the connection resource whose inbound routes are being requested.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model GetInboundRoutesParameters {
  /**
   * The connection resource whose inbound routes are being requested.
   */
  resourceUri?: string;

  /**
   * The type of the specified connection resource like ExpressRouteConnection, HubVirtualNetworkConnection, VpnConnection and P2SConnection.
   */
  connectionType?: string;
}

/**
 * EffectiveRouteMapRoute List.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model EffectiveRouteMapRouteList {
  /**
   * The list of Effective RouteMap Routes configured on the connection resource.
   */
  @pageItems
  @identifiers(#[])
  value?: EffectiveRouteMapRoute[];
}

/**
 * The effective RouteMap route configured on the connection resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model EffectiveRouteMapRoute {
  /**
   * The address prefix of the route.
   */
  prefix?: string;

  /**
   * BGP communities of the route.
   */
  bgpCommunities?: string;

  /**
   * The ASPath of this route.
   */
  asPath?: string;
}

/**
 * The parameters specifying the connection resource whose outbound routes are being requested.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model GetOutboundRoutesParameters {
  /**
   * The connection resource whose outbound routes are being requested.
   */
  resourceUri?: string;

  /**
   * The type of the specified connection resource like ExpressRouteConnection, HubVirtualNetworkConnection, VpnConnection and P2SConnection.
   */
  connectionType?: string;
}

/**
 * The properties of a RoutingIntent resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model RoutingIntentProperties {
  /**
   * List of routing policies.
   */
  routingPolicies?: RoutingPolicy[];

  /**
   * The provisioning state of the RoutingIntent resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;
}

/**
 * The routing policy object used in a RoutingIntent resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model RoutingPolicy {
  /**
   * The unique name for the routing policy.
   */
  name: string;

  /**
   * List of all destinations which this routing policy is applicable to (for example: Internet, PrivateTraffic).
   */
  destinations: string[];

  /**
   * The next hop resource id on which this routing policy is applicable to.
   */
  nextHop: string;
}

/**
 * List of the routing intent result and a URL nextLink to get the next set of results.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model ListRoutingIntentResult is Azure.Core.Page<RoutingIntent>;

/**
 * Defines web application firewall policy properties.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model WebApplicationFirewallPolicyPropertiesFormat {
  /**
   * The PolicySettings for policy.
   */
  policySettings?: PolicySettings;

  /**
   * The custom rules inside the policy.
   */
  customRules?: WebApplicationFirewallCustomRule[];

  /**
   * A collection of references to application gateways.
   */
  @visibility(Lifecycle.Read)
  applicationGateways?: ApplicationGateway[];

  /**
   * The provisioning state of the web application firewall policy resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkProvisioningState;

  /**
   * Resource status of the policy.
   */
  @summary("Resource status of the policy.")
  @visibility(Lifecycle.Read)
  resourceState?: WebApplicationFirewallPolicyResourceState;

  /**
   * Describes the managedRules structure.
   */
  managedRules: ManagedRulesDefinition;

  /**
   * A collection of references to application gateway http listeners.
   */
  @visibility(Lifecycle.Read)
  httpListeners?: SubResource[];

  /**
   * A collection of references to application gateway path rules.
   */
  @visibility(Lifecycle.Read)
  pathBasedRules?: SubResource[];

  /**
   * A collection of references to application gateway for containers.
   */
  @visibility(Lifecycle.Read)
  applicationGatewayForContainers?: ApplicationGatewayForContainersReferenceDefinition[];
}

/**
 * Defines contents of a web application firewall global configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model PolicySettings {
  /**
   * The state of the policy.
   */
  state?: WebApplicationFirewallEnabledState;

  /**
   * The mode of the policy.
   */
  mode?: WebApplicationFirewallMode;

  /**
   * Whether to allow WAF to check request Body.
   */
  requestBodyCheck?: boolean;

  /**
   * Max inspection limit in KB for request body inspection for WAF.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  requestBodyInspectLimitInKB?: int32;

  /**
   * Whether allow WAF to enforce request body limits.
   */
  requestBodyEnforcement?: boolean = true;

  /**
   * Maximum request body size in Kb for WAF.
   */
  @minValue(8)
  maxRequestBodySizeInKb?: int32;

  /**
   * Whether allow WAF to enforce file upload limits.
   */
  fileUploadEnforcement?: boolean = true;

  /**
   * Maximum file upload size in Mb for WAF.
   */
  @minValue(0)
  fileUploadLimitInMb?: int32;

  /**
   * If the action type is block, customer can override the response status code.
   */
  @minValue(0)
  customBlockResponseStatusCode?: int32;

  /**
   * If the action type is block, customer can override the response body. The body must be specified in base64 encoding.
   */
  @maxLength(32768)
  @pattern("^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{4})$")
  customBlockResponseBody?: string;

  /**
   * To scrub sensitive log fields
   */
  logScrubbing?: PolicySettingsLogScrubbing;

  /**
   * Web Application Firewall JavaScript Challenge Cookie Expiration time in minutes.
   */
  @maxValue(1440)
  @minValue(5)
  jsChallengeCookieExpirationInMins?: int32;
}

/**
 * To scrub sensitive log fields
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model PolicySettingsLogScrubbing {
  /**
   * State of the log scrubbing config. Default value is Enabled.
   */
  state?: WebApplicationFirewallScrubbingState;

  /**
   * The rules that are applied to the logs for scrubbing.
   */
  @identifiers(#[])
  scrubbingRules?: WebApplicationFirewallScrubbingRules[];
}

/**
 * Allow certain variables to be scrubbed on WAF logs
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model WebApplicationFirewallScrubbingRules {
  /**
   * The variable to be scrubbed from the logs.
   */
  matchVariable: ScrubbingRuleEntryMatchVariable;

  /**
   * When matchVariable is a collection, operate on the selector to specify which elements in the collection this rule applies to.
   */
  selectorMatchOperator: ScrubbingRuleEntryMatchOperator;

  /**
   * When matchVariable is a collection, operator used to specify which elements in the collection this rule applies to.
   */
  selector?: string;

  /**
   * Defines the state of log scrubbing rule. Default value is Enabled.
   */
  state?: ScrubbingRuleEntryState;
}

/**
 * Defines contents of a web application rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model WebApplicationFirewallCustomRule {
  /**
   * The name of the resource that is unique within a policy. This name can be used to access the resource.
   */
  @maxLength(128)
  name?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Priority of the rule. Rules with a lower value will be evaluated before rules with a higher value.
   */
  priority: int32;

  /**
   * Describes if the custom rule is in enabled or disabled state. Defaults to Enabled if not specified.
   */
  state?: WebApplicationFirewallState;

  /**
   * Duration over which Rate Limit policy will be applied. Applies only when ruleType is RateLimitRule.
   */
  rateLimitDuration?: ApplicationGatewayFirewallRateLimitDuration;

  /**
   * Rate Limit threshold to apply in case ruleType is RateLimitRule. Must be greater than or equal to 1
   */
  rateLimitThreshold?: int32;

  /**
   * The rule type.
   */
  ruleType: WebApplicationFirewallRuleType;

  /**
   * List of match conditions.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  matchConditions: MatchCondition[];

  /**
   * List of user session identifier group by clauses.
   */
  @identifiers(#[])
  groupByUserSession?: GroupByUserSession[];

  /**
   * Type of Actions.
   */
  action: WebApplicationFirewallAction;
}

/**
 * Define match conditions.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model MatchCondition {
  /**
   * List of match variables.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  matchVariables: MatchVariable[];

  /**
   * The operator to be matched.
   */
  operator: WebApplicationFirewallOperator;

  /**
   * Whether this is negate condition or not.
   */
  negationConditon?: boolean;

  /**
   * Match value.
   */
  matchValues: string[];

  /**
   * List of transforms.
   */
  transforms?: WebApplicationFirewallTransform[];
}

/**
 * Define match variables.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model MatchVariable {
  /**
   * Match Variable.
   */
  variableName: WebApplicationFirewallMatchVariable;

  /**
   * The selector of match variable.
   */
  selector?: string;
}

/**
 * Define user session identifier group by clauses.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model GroupByUserSession {
  /**
   * List of group by clause variables.
   */
  @identifiers(#[])
  groupByVariables: GroupByVariable[];
}

/**
 * Define user session group by clause variables.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model GroupByVariable {
  /**
   * User Session clause variable.
   */
  variableName: ApplicationGatewayFirewallUserSessionVariable;
}

/**
 * Allow to exclude some variable satisfy the condition for the WAF check.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ManagedRulesDefinition {
  /**
   * The exceptions that are applied on the policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  exceptions?: ExceptionEntry[];

  /**
   * The Exclusions that are applied on the policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  exclusions?: OwaspCrsExclusionEntry[];

  /**
   * The managed rule sets that are associated with the policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  managedRuleSets: ManagedRuleSet[];
}

/**
 * Adds exception to allow a request when the condition is satisfied.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ExceptionEntry {
  /**
   * The variable on which we evaluate the exception condition
   */
  matchVariable: ExceptionEntryMatchVariable;

  /**
   * Allowed values for the matchVariable
   */
  values?: string[];

  /**
   * Operates on the allowed values for the matchVariable
   */
  valueMatchOperator: ExceptionEntryValueMatchOperator;

  /**
   * When the matchVariable points to a key-value pair (e.g, RequestHeader), this operates on the selector
   */
  selectorMatchOperator?: ExceptionEntrySelectorMatchOperator;

  /**
   * When the matchVariable points to a key-value pair (e.g, RequestHeader), this identifies the key.
   */
  selector?: string;

  /**
   * The managed rule sets that are associated with the exception.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  exceptionManagedRuleSets?: ExclusionManagedRuleSet[];
}

/**
 * Defines a managed rule set for Exclusions.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ExclusionManagedRuleSet {
  /**
   * Defines the rule set type to use.
   */
  ruleSetType: string;

  /**
   * Defines the version of the rule set to use.
   */
  ruleSetVersion: string;

  /**
   * Defines the rule groups to apply to the rule set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ruleGroups?: ExclusionManagedRuleGroup[];
}

/**
 * Defines a managed rule group to use for exclusion.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ExclusionManagedRuleGroup {
  /**
   * The managed rule group for exclusion.
   */
  ruleGroupName: string;

  /**
   * List of rules that will be excluded. If none specified, all rules in the group will be excluded.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rules?: ExclusionManagedRule[];
}

/**
 * Defines a managed rule to use for exclusion.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ExclusionManagedRule {
  /**
   * Identifier for the managed rule.
   */
  ruleId: string;
}

/**
 * Allow to exclude some variable satisfy the condition for the WAF check.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model OwaspCrsExclusionEntry {
  /**
   * The variable to be excluded.
   */
  matchVariable: OwaspCrsExclusionEntryMatchVariable;

  /**
   * When matchVariable is a collection, operate on the selector to specify which elements in the collection this exclusion applies to.
   */
  selectorMatchOperator: OwaspCrsExclusionEntrySelectorMatchOperator;

  /**
   * When matchVariable is a collection, operator used to specify which elements in the collection this exclusion applies to.
   */
  selector: string;

  /**
   * The managed rule sets that are associated with the exclusion.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  exclusionManagedRuleSets?: ExclusionManagedRuleSet[];
}

/**
 * Defines a managed rule set.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ManagedRuleSet {
  /**
   * Defines the rule set type to use.
   */
  ruleSetType: string;

  /**
   * Defines the version of the rule set to use.
   */
  ruleSetVersion: string;

  /**
   * Defines the rule group overrides to apply to the rule set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ruleGroupOverrides?: ManagedRuleGroupOverride[];

  /**
   * Stores the final list of disabled rule groups
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  computedDisabledRules?: ManagedRuleSetRuleGroup[];
}

/**
 * Defines a managed rule group override setting.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ManagedRuleGroupOverride {
  /**
   * The managed rule group to override.
   */
  ruleGroupName: string;

  /**
   * List of rules that will be disabled. If none specified, all rules in the group will be disabled.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rules?: ManagedRuleOverride[];
}

/**
 * Defines a managed rule group override setting.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ManagedRuleOverride {
  /**
   * Identifier for the managed rule.
   */
  ruleId: string;

  /**
   * The state of the managed rule. Defaults to Disabled if not specified.
   */
  state?: ManagedRuleEnabledState;

  /**
   * Describes the override action to be applied when rule matches.
   */
  action?: ActionType;

  /**
   * Describes the override sensitivity to be applied when rule matches.
   */
  sensitivity?: SensitivityType;
}

/**
 * Defines a managed rule set rule group
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ManagedRuleSetRuleGroup {
  /**
   * Name of the rule group
   */
  ruleGroupName: string;

  /**
   * List of rules within the rule group
   */
  rules?: string[];
}

/**
 * Defines an application gateway for containers reference.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model ApplicationGatewayForContainersReferenceDefinition {
  /**
   * Resource Id of the application gateway for containers.
   */
  id: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ServiceNetworking/trafficControllers";
    }
  ]>;
}

/**
 * Firewall Policy NAT Rule Collection.
 */
model FirewallPolicyNatRuleCollection extends FirewallPolicyRuleCollection {
  /**
   * The action type of a Nat rule collection.
   */
  action?: FirewallPolicyNatRuleCollectionAction;

  /**
   * List of rules included in a rule collection.
   */
  @identifiers(#[])
  rules?: FirewallPolicyRule[];

  /**
   * The type of the rule collection.
   */
  ruleCollectionType: "FirewallPolicyNatRuleCollection";
}

/**
 * Properties of the FirewallPolicyNatRuleCollectionAction.
 */
model FirewallPolicyNatRuleCollectionAction {
  /**
   * The type of action.
   */
  type?: FirewallPolicyNatRuleCollectionActionType;
}

/**
 * Properties of a rule.
 */
@discriminator("ruleType")
model FirewallPolicyRule {
  /**
   * Name of the rule.
   */
  name?: string;

  /**
   * Description of the rule.
   */
  description?: string;

  /**
   * Rule Type.
   */
  ruleType: FirewallPolicyRuleType;
}

/**
 * Firewall Policy Filter Rule Collection.
 */
model FirewallPolicyFilterRuleCollection extends FirewallPolicyRuleCollection {
  /**
   * The action type of a Filter rule collection.
   */
  action?: FirewallPolicyFilterRuleCollectionAction;

  /**
   * List of rules included in a rule collection.
   */
  @identifiers(#[])
  rules?: FirewallPolicyRule[];

  /**
   * The type of the rule collection.
   */
  ruleCollectionType: "FirewallPolicyFilterRuleCollection";
}

/**
 * Properties of the FirewallPolicyFilterRuleCollectionAction.
 */
model FirewallPolicyFilterRuleCollectionAction {
  /**
   * The type of action.
   */
  type?: FirewallPolicyFilterRuleCollectionActionType;
}

/**
 * Rule of type application.
 */
model ApplicationRule extends FirewallPolicyRule {
  /**
   * List of source IP addresses for this rule.
   */
  sourceAddresses?: string[];

  /**
   * List of destination IP addresses or Service Tags.
   */
  destinationAddresses?: string[];

  /**
   * Array of Application Protocols.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  protocols?: FirewallPolicyRuleApplicationProtocol[];

  /**
   * List of FQDNs for this rule.
   */
  targetFqdns?: string[];

  /**
   * List of Urls for this rule condition.
   */
  targetUrls?: string[];

  /**
   * List of FQDN Tags for this rule.
   */
  fqdnTags?: string[];

  /**
   * List of source IpGroups for this rule.
   */
  sourceIpGroups?: string[];

  /**
   * Terminate TLS connections for this rule.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  terminateTLS?: boolean;

  /**
   * List of destination azure web categories.
   */
  webCategories?: string[];

  /**
   * List of HTTP/S headers to insert.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  httpHeadersToInsert?: FirewallPolicyHttpHeaderToInsert[];

  /**
   * Rule Type.
   */
  ruleType: "ApplicationRule";
}

/**
 * Properties of the application rule protocol.
 */
model FirewallPolicyRuleApplicationProtocol {
  /**
   * Protocol type.
   */
  protocolType?: FirewallPolicyRuleApplicationProtocolType;

  /**
   * Port number for the protocol, cannot be greater than 64000.
   */
  @minValue(0)
  @maxValue(64000)
  port?: int32;
}

/**
 * name and value of HTTP/S header to insert
 */
model FirewallPolicyHttpHeaderToInsert {
  /**
   * Contains the name of the header
   */
  headerName?: string;

  /**
   * Contains the value of the header
   */
  headerValue?: string;
}

/**
 * Rule of type nat.
 */
model NatRule extends FirewallPolicyRule {
  /**
   * Array of FirewallPolicyRuleNetworkProtocols.
   */
  ipProtocols?: FirewallPolicyRuleNetworkProtocol[];

  /**
   * List of source IP addresses for this rule.
   */
  sourceAddresses?: string[];

  /**
   * List of destination IP addresses or Service Tags.
   */
  destinationAddresses?: string[];

  /**
   * List of destination ports.
   */
  destinationPorts?: string[];

  /**
   * The translated address for this NAT rule.
   */
  translatedAddress?: string;

  /**
   * The translated port for this NAT rule.
   */
  translatedPort?: string;

  /**
   * List of source IpGroups for this rule.
   */
  sourceIpGroups?: string[];

  /**
   * The translated FQDN for this NAT rule.
   */
  translatedFqdn?: string;

  /**
   * Rule Type.
   */
  ruleType: "NatRule";
}

/**
 * Rule of type network.
 */
model NetworkRule extends FirewallPolicyRule {
  /**
   * Array of FirewallPolicyRuleNetworkProtocols.
   */
  ipProtocols?: FirewallPolicyRuleNetworkProtocol[];

  /**
   * List of source IP addresses for this rule.
   */
  sourceAddresses?: string[];

  /**
   * List of destination IP addresses or Service Tags.
   */
  destinationAddresses?: string[];

  /**
   * List of destination ports.
   */
  destinationPorts?: string[];

  /**
   * List of source IpGroups for this rule.
   */
  sourceIpGroups?: string[];

  /**
   * List of destination IpGroups for this rule.
   */
  destinationIpGroups?: string[];

  /**
   * List of destination FQDNs.
   */
  destinationFqdns?: string[];

  /**
   * Rule Type.
   */
  ruleType: "NetworkRule";
}

/**
 * The response body contains the status of the specified asynchronous operation, indicating whether it has succeeded, is in progress, or has failed. Note that this status is distinct from the HTTP status code returned for the Get Operation Status operation itself. If the asynchronous operation succeeded, the response body includes the HTTP status code for the successful request. If the asynchronous operation failed, the response body includes the HTTP status code for the failed request and error information regarding the failure.
 */
model AzureAsyncOperationResult {
  /**
   * Status of the Azure async operation.
   */
  status?: NetworkOperationStatus;

  /**
   * Details of the error occurred during specified asynchronous operation.
   */
  error?: Error;
}

/**
 * Network admin rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model ActiveSecurityAdminRule extends ActiveBaseSecurityAdminRule {
  /**
   * Indicates the properties of the security admin rule
   */
  properties?: AdminPropertiesFormat;

  /**
   * Whether the rule is custom or default.
   */
  kind: "Custom";
}

/**
 * Security admin rule resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model AdminPropertiesFormat {
  /**
   * A description for this rule. Restricted to 140 chars.
   */
  description?: string;

  /**
   * Network protocol this rule applies to.
   */
  protocol: SecurityConfigurationRuleProtocol;

  /**
   * The CIDR or source IP ranges.
   */
  @identifiers(#["addressPrefix"])
  sources?: AddressPrefixItem[];

  /**
   * The destination address prefixes. CIDR or destination IP ranges.
   */
  @identifiers(#["addressPrefix"])
  destinations?: AddressPrefixItem[];

  /**
   * The source port ranges.
   */
  sourcePortRanges?: string[];

  /**
   * The destination port ranges.
   */
  destinationPortRanges?: string[];

  /**
   * Indicates the access allowed for this particular rule
   */
  access: SecurityConfigurationRuleAccess;

  /**
   * The priority of the rule. The value can be between 1 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
   */
  @maxValue(4096)
  @minValue(1)
  priority: int32;

  /**
   * Indicates if the traffic matched against the rule in inbound or outbound.
   */
  direction: SecurityConfigurationRuleDirection;

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;
}

/**
 * Network default admin rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model ActiveDefaultSecurityAdminRule extends ActiveBaseSecurityAdminRule {
  /**
   * Indicates the properties of the default security admin rule
   */
  properties?: DefaultAdminPropertiesFormat;

  /**
   * Whether the rule is custom or default.
   */
  kind: "Default";
}

/**
 * Security default admin rule resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model DefaultAdminPropertiesFormat {
  /**
   * A description for this rule. Restricted to 140 chars.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Default rule flag.
   */
  flag?: string;

  /**
   * Network protocol this rule applies to.
   */
  @visibility(Lifecycle.Read)
  protocol?: SecurityConfigurationRuleProtocol;

  /**
   * The CIDR or source IP ranges.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["addressPrefix"])
  sources?: AddressPrefixItem[];

  /**
   * The destination address prefixes. CIDR or destination IP ranges.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["addressPrefix"])
  destinations?: AddressPrefixItem[];

  /**
   * The source port ranges.
   */
  @visibility(Lifecycle.Read)
  sourcePortRanges?: string[];

  /**
   * The destination port ranges.
   */
  @visibility(Lifecycle.Read)
  destinationPortRanges?: string[];

  /**
   * Indicates the access allowed for this particular rule
   */
  @visibility(Lifecycle.Read)
  access?: SecurityConfigurationRuleAccess;

  /**
   * The priority of the rule. The value can be between 1 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
   */
  @visibility(Lifecycle.Read)
  priority?: int32;

  /**
   * Indicates if the traffic matched against the rule in inbound or outbound.
   */
  @visibility(Lifecycle.Read)
  direction?: SecurityConfigurationRuleDirection;

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Unique identifier for this resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;
}

/**
 * Network admin rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model EffectiveSecurityAdminRule extends EffectiveBaseSecurityAdminRule {
  /**
   * Indicates the properties of the security admin rule
   */
  properties?: AdminPropertiesFormat;

  /**
   * Whether the rule is custom or default.
   */
  kind: "Custom";
}

/**
 * Network default admin rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model EffectiveDefaultSecurityAdminRule extends EffectiveBaseSecurityAdminRule {
  /**
   * Indicates the properties of the default security admin rule
   */
  properties?: DefaultAdminPropertiesFormat;

  /**
   * Whether the rule is custom or default.
   */
  kind: "Default";
}

/**
 * Network admin rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model AdminRule extends BaseAdminRule {
  /**
   * Indicates the properties of the security admin rule
   */
  properties?: AdminPropertiesFormat;

  /**
   * Whether the rule is custom or default.
   */
  kind: "Custom";
}

/**
 * Network default admin rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
model DefaultAdminRule extends BaseAdminRule {
  /**
   * Indicates the properties of the security admin rule
   */
  properties?: DefaultAdminPropertiesFormat;

  /**
   * Whether the rule is custom or default.
   */
  kind: "Default";
}

/**
 * Connection state snapshot.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectionStateSnapshot {
  /**
   * The connection state.
   */
  connectionState?: ConnectionState;

  /**
   * The start time of the connection snapshot.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The end time of the connection snapshot.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Connectivity analysis evaluation state.
   */
  evaluationState?: EvaluationState;

  /**
   * Average latency in ms.
   */
  @maxValue(4294967295)
  avgLatencyInMs?: int64;

  /**
   * Minimum latency in ms.
   */
  @maxValue(4294967295)
  minLatencyInMs?: int64;

  /**
   * Maximum latency in ms.
   */
  @maxValue(4294967295)
  maxLatencyInMs?: int64;

  /**
   * The number of sent probes.
   */
  @maxValue(4294967295)
  probesSent?: int64;

  /**
   * The number of failed probes.
   */
  @maxValue(4294967295)
  probesFailed?: int64;

  /**
   * List of hops between the source and the destination.
   */
  @visibility(Lifecycle.Read)
  hops?: ConnectivityHop[];
}

/**
 * List of connection states snapshots.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
model ConnectionMonitorQueryResult {
  /**
   * Status of connection monitor source.
   */
  sourceStatus?: ConnectionMonitorSourceStatus;

  /**
   * Information about connection states.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  states?: ConnectionStateSnapshot[];
}

/**
 * Route Filter Rule Resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model PatchRouteFilterRule extends SubResource {
  /**
   * Properties of the route filter rule.
   */
  properties?: RouteFilterRulePropertiesFormat;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Route Filter Resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model PatchRouteFilter extends SubResource {
  /**
   * Properties of the route filter.
   */
  properties?: RouteFilterPropertiesFormat;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
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

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * VpnSite Resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VpnSiteId {
  /**
   * The resource-uri of the vpn-site for which config is to be fetched.
   */
  @visibility(Lifecycle.Read)
  vpnSite?: string;
}

/**
 * Response for ApplicationGatewayAvailableServerVariables API service call.
 */
alias ApplicationGatewayAvailableServerVariablesResult = string[];

/**
 * Response for ApplicationGatewayAvailableRequestHeaders API service call.
 */
alias ApplicationGatewayAvailableRequestHeadersResult = string[];

/**
 * Response for ApplicationGatewayAvailableResponseHeaders API service call.
 */
alias ApplicationGatewayAvailableResponseHeadersResult = string[];

/**
 * Gateway Failover All Test Details
 */
alias ExpressRouteFailoverAllTestDetails = ExpressRouteFailoverTestDetails[];

/**
 * Gateway Failover Single Test Details Object
 */
alias ExpressRouteFailoverSingleTestDetailsObject = ExpressRouteFailoverSingleTestDetails[];

model PerimeterAssociableResourcesListResult
  is Azure.Core.Page<PerimeterAssociableResource>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model EndpointServicesListResult is Azure.Core.Page<EndpointServiceResult>;

#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SingletonResource {
  swap,
}

@mediaTypeHint("application/json")
scalar stringApplicationJson extends string;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model AuthorizationListResult
  is Azure.Core.Page<ExpressRouteCircuitAuthorization>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
model LoadBalancerBackendAddressPoolListResult
  is Azure.Core.Page<BackendAddressPool>;

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
model LoadBalancerFrontendIPConfigurationListResult
  is Azure.Core.Page<FrontendIPConfiguration>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
model LoadBalancerOutboundRuleListResult is Azure.Core.Page<OutboundRule>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
model LoadBalancerProbeListResult is Azure.Core.Page<Probe>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
model LoadBalancerLoadBalancingRuleListResult
  is Azure.Core.Page<LoadBalancingRule>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model NetworkInterfaceLoadBalancerListResult is Azure.Core.Page<LoadBalancer>;

model AdminRuleListResult is Azure.Core.Page<BaseAdminRule>;

model NspAssociationsListResult is Azure.Core.Page<NspAssociation>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model NetworkVirtualApplianceSiteListResult
  is Azure.Core.Page<VirtualApplianceSite>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model ResourceNavigationLinksListResult
  is Azure.Core.Page<ResourceNavigationLink>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model ServiceAssociationLinksListResult
  is Azure.Core.Page<ServiceAssociationLink>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.applicationGateway)
model WebApplicationFirewallPolicyListResult
  is Azure.Core.Page<WebApplicationFirewallPolicy>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("ExpressRoute Port List Result")
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRoutePortListResult is Azure.Core.Page<ExpressRoutePort>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("ExpressRoute Port Authorization List Result")
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRoutePortAuthorizationListResult
  is Azure.Core.Page<ExpressRoutePortAuthorization>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("ExpressRoutePorts Location List Result")
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
model ExpressRoutePortsLocationListResult
  is Azure.Core.Page<ExpressRoutePortsLocation>;

model BastionHostListResult is Azure.Core.Page<BastionHost>;

@@Azure.ClientGenerator.Core.clientName(ListVirtualHubRouteTableV2SResult,
  "ListVirtualHubRouteTableV2sResult"
);
@@Azure.ClientGenerator.Core.clientName(HttpConfigurationMethod,
  "HTTPConfigurationMethod"
);
@@Azure.ClientGenerator.Core.clientName(HttpHeader, "HTTPHeader");
@@Azure.ClientGenerator.Core.clientName(ConnectivityGroupItem,
  "connectivityGroupItem"
);
@@Azure.ClientGenerator.Core.clientName(FirewallPolicySnat,
  "FirewallPolicySNAT"
);
@@Azure.ClientGenerator.Core.clientName(HttpConfiguration, "HTTPConfiguration");
@@Azure.ClientGenerator.Core.clientName(HttpMethod, "HTTPMethod");
@@Azure.ClientGenerator.Core.clientName(FirewallPolicyIdpsQuerySortOrder,
  "FirewallPolicyIDPSQuerySortOrder"
);
@@Azure.ClientGenerator.Core.clientName(FirewallPolicyIdpsSignatureMode,
  "FirewallPolicyIDPSSignatureMode"
);
@@Azure.ClientGenerator.Core.clientName(FirewallPolicyIdpsSignatureDirection,
  "FirewallPolicyIDPSSignatureDirection"
);
@@Azure.ClientGenerator.Core.clientName(ScrubbingRuleEntryMatchOperator,
  "scrubbingRuleEntryMatchOperator"
);
@@Azure.ClientGenerator.Core.clientName(ScrubbingRuleEntryState,
  "scrubbingRuleEntryState"
);
@@Azure.ClientGenerator.Core.clientName(FirewallPolicyIdpsSignatureSeverity,
  "FirewallPolicyIDPSSignatureSeverity"
);
@@Azure.ClientGenerator.Core.clientName(VirtualApplianceNetworkInterfaceConfiguration.type,
  "NicType"
);
@@Azure.ClientGenerator.Core.clientName(AzureFirewallIPGroups,
  "AzureFirewallIpGroups"
);
@@doc(PacketCaptureListResult, "List of packet capture sessions.");
@@doc(PacketCaptureListResult.value,
  "Information about packet capture sessions."
);
@@visibility(VirtualNetworkListUsageResult.value, Lifecycle.Read);
@@visibility(WebApplicationFirewallPolicyListResult.value, Lifecycle.Read);
