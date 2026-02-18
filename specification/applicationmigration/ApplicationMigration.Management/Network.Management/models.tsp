import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.ApplicationMigration;

// ──────────────────────────────────────────────
//  Extensible Enums (unions with string fallback)
// ──────────────────────────────────────────────

/**
 * The provisioning state of a resource.
 */
union ProvisioningState {
  string,

  /** Resource has been created. */
  Succeeded: "Succeeded",

  /** Resource creation failed. */
  Failed: "Failed",

  /** Resource creation was canceled. */
  Canceled: "Canceled",

  /** The resource is being created. */
  Creating: "Creating",

  /** The resource is being deleted. */
  Deleting: "Deleting",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The provisioning state is unknown. */
  Unknown: "Unknown",
}

/**
 * The ingestion status of a discovery operation.
 */
union IngestionStatus {
  string,

  /** Ingestion completed successfully. */
  Complete: "Complete",

  /** Ingestion completed partially. */
  Partial: "Partial",

  /** Ingestion failed. */
  Failed: "Failed",
}

/**
 * The high-availability mode of a gateway.
 */
union HaMode {
  string,

  /** Active-active HA mode. */
  ACTIVE_ACTIVE: "ACTIVE_ACTIVE",

  /** Active-standby HA mode. */
  ACTIVE_STANDBY: "ACTIVE_STANDBY",
}

/**
 * The administrative state.
 */
union AdminState {
  string,

  /** Resource is up. */
  UP: "UP",

  /** Resource is down. */
  DOWN: "DOWN",

  /** Resource is enabled. */
  ENABLED: "ENABLED",

  /** Resource is disabled. */
  DISABLED: "DISABLED",
}

/**
 * The type of an NSX segment.
 */
union SegmentType {
  string,

  /** Routed segment. */
  ROUTED: "ROUTED",

  /** Extended segment. */
  EXTENDED: "EXTENDED",

  /** Routed and extended segment. */
  ROUTED_AND_EXTENDED: "ROUTED_AND_EXTENDED",

  /** Disconnected segment. */
  DISCONNECTED: "DISCONNECTED",
}

/**
 * The type of NAT rule.
 */
union NatType {
  string,

  /** Source NAT. */
  SNAT: "SNAT",

  /** Destination NAT. */
  DNAT: "DNAT",
}

/**
 * The type of load balancer.
 */
union LbType {
  string,

  /** Layer 4 load balancer. */
  L4: "L4",

  /** Layer 7 load balancer. */
  L7: "L7",
}

/**
 * The protocol for load balancer frontend/health probe.
 */
union LbProtocol {
  string,

  /** TCP protocol. */
  TCP: "TCP",

  /** HTTP protocol. */
  HTTP: "HTTP",

  /** HTTPS protocol. */
  HTTPS: "HTTPS",
}

/**
 * The load balancing algorithm.
 */
union LbAlgorithm {
  string,

  /** Round robin algorithm. */
  ROUND_ROBIN: "ROUND_ROBIN",

  /** Least connection algorithm. */
  LEAST_CONNECTION: "LEAST_CONNECTION",

  /** Weighted round robin algorithm. */
  WEIGHTED_ROUND_ROBIN: "WEIGHTED_ROUND_ROBIN",

  /** Weighted least connection algorithm. */
  WEIGHTED_LEAST_CONNECTION: "WEIGHTED_LEAST_CONNECTION",
}

/**
 * The admin state of a backend pool member.
 */
union MemberAdminState {
  string,

  /** Member is enabled. */
  ENABLED: "ENABLED",

  /** Member is disabled. */
  DISABLED: "DISABLED",

  /** Member is gracefully disabled. */
  GRACEFUL_DISABLED: "GRACEFUL_DISABLED",
}

/**
 * The SNAT type for a load balancer.
 */
union SnatType {
  string,

  /** SNAT is disabled. */
  DISABLED: "DISABLED",

  /** SNAT uses auto-mapped IPs. */
  AUTOMAP: "AUTOMAP",

  /** SNAT uses an IP pool. */
  IPPOOL: "IPPOOL",
}

/**
 * The action for a firewall rule.
 */
union FirewallAction {
  string,

  /** Allow traffic. */
  ALLOW: "ALLOW",

  /** Drop traffic. */
  DROP: "DROP",

  /** Reject traffic. */
  REJECT: "REJECT",
}

/**
 * The direction for a firewall rule.
 */
union FirewallDirection {
  string,

  /** Inbound traffic. */
  IN: "IN",

  /** Outbound traffic. */
  OUT: "OUT",

  /** Both inbound and outbound traffic. */
  IN_OUT: "IN_OUT",
}

/**
 * The type of a DNS forwarder zone.
 */
union DnsZoneType {
  string,

  /** FQDN-based zone. */
  FQDN: "FQDN",
}

/**
 * The protocol for NAT rule matching.
 */
union MatchProtocol {
  string,

  /** TCP protocol. */
  TCP: "TCP",

  /** UDP protocol. */
  UDP: "UDP",

  /** ICMP protocol. */
  ICMP: "ICMP",

  /** Any protocol. */
  ANY: "ANY",
}

/**
 * The member type in a group expression.
 */
union GroupMemberType {
  string,

  /** Virtual machine member. */
  VirtualMachine: "VirtualMachine",

  /** NsxSegment port member. */
  SegmentPort: "SegmentPort",
}

/**
 * The operator in a group expression condition.
 */
union GroupExpressionOperator {
  string,

  /** Contains operator. */
  CONTAINS: "CONTAINS",

  /** Equals operator. */
  EQUALS: "EQUALS",

  /** Starts with operator. */
  STARTSWITH: "STARTSWITH",

  /** Ends with operator. */
  ENDSWITH: "ENDSWITH",
}

/**
 * The conjunction operator between group expressions.
 */
union ConjunctionOperator {
  string,

  /** Logical OR. */
  OR: "OR",

  /** Logical AND. */
  AND: "AND",
}

/**
 * The key used in a group expression condition.
 */
union GroupExpressionKey {
  string,

  /** Match by name. */
  Name: "Name",

  /** Match by tag. */
  Tag: "Tag",

  /** Match by OS name. */
  OSName: "OSName",

  /** Match by computer name. */
  ComputerName: "ComputerName",
}

/**
 * The category of a gateway firewall policy.
 */
union GatewayPolicyCategory {
  string,

  /** Local gateway rules category. */
  LocalGatewayRules: "LocalGatewayRules",
}

/**
 * The federation scope of a gateway firewall policy.
 */
union FederationScope {
  string,

  /** Local scope. */
  Local: "Local",

  /** Global scope. */
  Global: "Global",
}

// ──────────────────────────────────────────────
//  Base Properties
// ──────────────────────────────────────────────

/**
 * Base properties shared by all resources.
 */
model AzureResourceProperties {
  /** The provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

// ──────────────────────────────────────────────
//  Patch Helpers
// ──────────────────────────────────────────────

/**
 * Tags update model.
 */
model TagsUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}

/**
 * Site-level patch model (tags only).
 */
model SiteTagsPatch {
  ...TagsUpdate;
}

// ──────────────────────────────────────────────
//  Shared Sub-models
// ──────────────────────────────────────────────

/**
 * Original NSX resource reference metadata.
 */
model NsxOriginal {
  /** The NSX path identifier. */
  id?: string;

  /** The NSX local identifier. */
  localId?: string;

  /** The NSX display name. */
  displayName?: string;

  /** The NSX resource type. */
  resourceType?: string;
}

/**
 * An NSX tag (scope + tag pair).
 */
model NsxTag {
  /** The tag scope. */
  scope?: string;

  /** The tag value. */
  tag?: string;
}

/**
 * A subnet definition within a segment.
 */
model Subnet {
  /** The gateway address in CIDR notation. */
  gatewayAddress?: string;

  /** The network address in CIDR notation. */
  network?: string;
}

/**
 * A discovery time window.
 */
model DiscoveryWindow {
  /** The start time of the discovery window. */
  startTime?: string;

  /** The end time of the discovery window. */
  endTime?: string;
}

/**
 * Coverage counts for discovered NSX resources.
 */
model CoverageCounts {
  /** Number of Tier-0 gateways. */
  tier0Gateways?: int32;

  /** Number of Tier-1 gateways. */
  tier1Gateways?: int32;

  /** Number of segments. */
  segments?: int32;

  /** Number of groups. */
  groups?: int32;

  /** Number of gateway firewall policies. */
  gatewayFirewallPolicies?: int32;

  /** Number of NAT rules. */
  natRules?: int32;

  /** Number of load balancers. */
  loadBalancers?: int32;

  /** Number of DNS services. */
  dnsServices?: int32;
}

/**
 * A reference to an effective virtual machine.
 */
model EffectiveVmRef {
  /** ARM resource ID of the virtual machine. */
  vmRef?: Azure.Core.armResourceIdentifier;

  /** Display name of the virtual machine. */
  displayName?: string;
}

/**
 * An upstream DNS server.
 */
model UpstreamServer {
  /** The IP address of the upstream server. */
  ip?: string;

  /** ARM resource ID of the associated virtual machine. */
  vmRef?: Azure.Core.armResourceIdentifier;
}

/**
 * Routing context referencing a Tier-1 gateway.
 */
model RoutingContext {
  /** ARM resource ID of the associated Tier-1 gateway. */
  tier1Gateway?: Azure.Core.armResourceIdentifier;
}

/**
 * A member of a load balancer backend pool.
 */
model BackendPoolMember {
  /** The IP address of the member. */
  ipAddress?: string;

  /** The port number. */
  port?: int32;

  /** The admin state of the member. */
  adminState?: MemberAdminState;

  /** The weight of the member. */
  weight?: int32;

  /** The associated compute resource. */
  associatedCompute?: AssociatedCompute;
}

/**
 * An associated compute resource reference.
 */
model AssociatedCompute {
  /** The type of compute (e.g. VMwareVM). */
  `type`?: string;

  /** ARM resource ID of the compute resource. */
  id?: Azure.Core.armResourceIdentifier;
}

/**
 * Health probe configuration for a load balancer.
 */
model HealthProbe {
  /** The protocol for health checks. */
  protocol?: LbProtocol;

  /** The port for health checks. */
  port?: int32;
}

/**
 * SNAT configuration for a load balancer.
 */
model SnatConfig {
  /** The SNAT type. */
  `type`?: SnatType;

  /** IP pool addresses for SNAT. */
  ipPoolAddresses?: string[];
}

/**
 * Frontend configuration for a load balancer.
 */
model FrontendConfig {
  /** The virtual IP address. */
  vip?: string;

  /** The frontend port. */
  port?: int32;

  /** The frontend protocol. */
  protocol?: LbProtocol;
}

/**
 * A backend pool definition.
 */
model BackendPool {
  /** The load balancing algorithm. */
  algorithm?: LbAlgorithm;

  /** The backend pool members. */
  @identifiers(#[])
  members?: BackendPoolMember[];
}

/**
 * Backend configuration for a load balancer.
 */
model BackendConfig {
  /** The backend pool. */
  backendPool?: BackendPool;

  /** The health probe configuration. */
  healthProbe?: HealthProbe;

  /** The SNAT configuration. */
  snat?: SnatConfig;
}

/**
 * NAT rule match endpoint.
 */
model NatEndpoint {
  /** IP ranges to match. */
  ipRanges?: string[];

  /** Port to match. */
  port?: string;
}

/**
 * NAT rule match criteria.
 */
model NatMatch {
  /** Source match criteria. */
  source?: NatEndpoint;

  /** Destination match criteria. */
  destination?: NatEndpoint;

  /** Protocol to match. */
  protocol?: MatchProtocol;
}

/**
 * NAT rule translation target.
 */
model NatTranslate {
  /** The translated IP address. */
  ipAddress?: string;

  /** The translated port. */
  port?: string;
}

/**
 * A group membership expression.
 */
model GroupExpression {
  /** The resource type (Condition or ConjunctionOperator). */
  resourceType?: string;

  /** The member type for conditions. */
  memberType?: GroupMemberType;

  /** The key for conditions. */
  key?: GroupExpressionKey;

  /** The operator for conditions. */
  operator?: GroupExpressionOperator;

  /** The value for conditions. */
  value?: string;

  /** The conjunction operator (for ConjunctionOperator type). */
  conjunctionOperator?: ConjunctionOperator;
}

// ──────────────────────────────────────────────
//  Patch Models for ProxyResources
// ──────────────────────────────────────────────

/**
 * Patch properties for NsxManager.
 */
model NsxManagerPatchProperties {
  /** The patch properties. */
  properties?: NsxManagerPatchFields;
}

/**
 * Patchable fields for NsxManager.
 */
model NsxManagerPatchFields {
  /** The run-as account credential reference. */
  runAsAccount?: string;

  /** The NSX Manager version. */
  version?: string;
}

/**
 * Patch properties for Tier-0 gateway.
 */
model NsxTier0GatewayPatchProperties {
  /** The patch properties. */
  properties?: NsxTier0GatewayPatchFields;
}

/**
 * Patchable fields for Tier-0 gateway.
 */
model NsxTier0GatewayPatchFields {
  /** The high-availability mode. */
  haMode?: HaMode;

  /** Whether the firewall is enabled. */
  firewallEnabled?: boolean;
}

/**
 * Patch properties for Tier-1 gateway.
 */
model NsxTier1GatewayPatchProperties {
  /** The patch properties. */
  properties?: NsxTier1GatewayPatchFields;
}

/**
 * Patchable fields for Tier-1 gateway.
 */
model NsxTier1GatewayPatchFields {
  /** The high-availability mode. */
  haMode?: HaMode;

  /** Whether the firewall is enabled. */
  firewallEnabled?: boolean;
}

/**
 * Patch properties for NsxSegment.
 */
model NsxSegmentPatchProperties {
  /** The patch properties. */
  properties?: NsxSegmentPatchFields;
}

/**
 * Patchable fields for NsxSegment.
 */
model NsxSegmentPatchFields {
  /** The admin state. */
  adminState?: AdminState;
}

/**
 * Patch properties for NsxGroup.
 */
model NsxGroupPatchProperties {
  /** The patch properties. */
  properties?: NsxGroupPatchFields;
}

/**
 * Patchable fields for NsxGroup.
 */
model NsxGroupPatchFields {
  /** The group membership expressions. */
  @identifiers(#[])
  expressions?: GroupExpression[];
}

/**
 * Patch properties for NsxGatewayFirewallPolicy.
 */
model NsxGatewayFirewallPolicyPatchProperties {
  /** The patch properties. */
  properties?: NsxGatewayFirewallPolicyPatchFields;
}

/**
 * Patchable fields for NsxGatewayFirewallPolicy.
 */
model NsxGatewayFirewallPolicyPatchFields {
  /** The sequence number. */
  sequenceNumber?: int32;
}

/**
 * Patch properties for NsxGatewayFirewallRule.
 */
model NsxGatewayFirewallRulePatchProperties {
  /** The patch properties. */
  properties?: NsxGatewayFirewallRulePatchFields;
}

/**
 * Patchable fields for NsxGatewayFirewallRule.
 */
model NsxGatewayFirewallRulePatchFields {
  /** Whether the rule is disabled. */
  disabled?: boolean;

  /** The sequence number. */
  sequenceNumber?: int32;
}

/**
 * Patch properties for NsxLoadBalancer.
 */
model NsxLoadBalancerPatchProperties {
  /** The patch properties. */
  properties?: NsxLoadBalancerPatchFields;
}

/**
 * Patchable fields for NsxLoadBalancer.
 */
model NsxLoadBalancerPatchFields {
  /** The admin state. */
  adminState?: AdminState;
}

/**
 * Patch properties for NsxNatRule.
 */
model NsxNatRulePatchProperties {
  /** The patch properties. */
  properties?: NsxNatRulePatchFields;
}

/**
 * Patchable fields for NsxNatRule.
 */
model NsxNatRulePatchFields {
  /** The admin state. */
  adminState?: AdminState;
}

/**
 * Patch properties for NsxDnsService.
 */
model NsxDnsServicePatchProperties {
  /** The patch properties. */
  properties?: NsxDnsServicePatchFields;
}

/**
 * Patchable fields for NsxDnsService.
 */
model NsxDnsServicePatchFields {
  /** The listener IP address. */
  listenerIp?: string;
}

/**
 * Patch properties for NsxDnsForwarderZone.
 */
model NsxDnsForwarderZonePatchProperties {
  /** The patch properties. */
  properties?: NsxDnsForwarderZonePatchFields;
}

/**
 * Patchable fields for NsxDnsForwarderZone.
 */
model NsxDnsForwarderZonePatchFields {
  /** The upstream DNS servers. */
  @identifiers(#[])
  upstreamServers?: UpstreamServer[];
}

/**
 * Patch properties for NsxFabric (kept for NsxManager-level fabric patching).
 */
model NsxFabricPatchProperties {
  /** The patch properties. */
  properties?: NsxFabricPatchFields;
}

/**
 * Patchable fields for NsxFabric.
 */
model NsxFabricPatchFields {
  /** The source appliance identifier. */
  sourceApplianceId?: string;
}
