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

  /** The NSX display name. */
  displayName?: string;

  /** The NSX original path identifier. */
  nsxOriginalId?: string;

  /** ARM resource ID of the associated NSX Manager. */
  nsxManagerRef?: Azure.Core.armResourceIdentifier;

  /** The NSX unique identifier. */
  uniqueId?: string;

  /** NSX tags applied to this resource. */
  @identifiers(#[])
  nsxTags?: NsxTag[];
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
 * An NSX service definition for firewall rules.
 */
model FirewallService {
  /** The display name of the service. */
  displayName?: string;

  /** The service entries. */
  @identifiers(#[])
  serviceEntries?: ServiceEntry[];
}

/**
 * A service entry within a firewall service.
 */
model ServiceEntry {
  /** The type of service entry (e.g. L4PortSetServiceEntry). */
  serviceEntryType?: string;

  /** The display name of the service entry. */
  displayName?: string;

  /** The Layer 4 protocol (TCP, UDP, etc.). */
  l4Protocol?: string;

  /** The source port ranges. */
  sourcePorts?: string[];

  /** The destination port ranges. */
  destinationPorts?: string[];

  /** The protocol. */
  protocol?: string;

  /** The ICMP type. */
  icmpType?: string;

  /** The application layer gateway type. */
  alg?: string;

  /** The IP protocol number. */
  protocolNumber?: int32;
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
 * A reference to an effective virtual machine.
 */
model EffectiveVmRef {
  /** ARM resource ID of the virtual machine. */
  vmRef?: Azure.Core.armResourceIdentifier;

  /** Display name of the virtual machine. */
  displayName?: string;
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

  /** ARM resource ID of the virtual machine. */
  vmRef?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OffAzure/vmwareSites/machines";
    }
  ]>;
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
  type?: SnatType;

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
  /** IP addresses to match. */
  ipAddress?: string[];

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

/** NsxManager patch envelope. */
model NsxManagerPatchProperties {
  /** Patch payload. */
  properties?: NsxManagerPatchFields;
}

/** NsxManager updatable fields. */
model NsxManagerPatchFields {
  /** The run-as account credential reference. */
  runAsAccount?: string;
}

/** NsxTier0Gateway patch envelope. */
model NsxTier0GatewayPatchProperties {
  /** Patch payload. */
  properties?: NsxTier0GatewayPatchFields;
}

/** NsxTier0Gateway updatable fields. */
model NsxTier0GatewayPatchFields {
  /** The high-availability mode. */
  haMode?: HaMode;

  /** Whether the firewall is enabled. */
  firewallEnabled?: boolean;
}

/** NsxTier1Gateway patch envelope. */
model NsxTier1GatewayPatchProperties {
  /** Patch payload. */
  properties?: NsxTier1GatewayPatchFields;
}

/** NsxTier1Gateway updatable fields. */
model NsxTier1GatewayPatchFields {
  /** The high-availability mode. */
  haMode?: HaMode;

  /** Whether the firewall is enabled. */
  firewallEnabled?: boolean;
}

/** NsxSegment patch envelope. */
model NsxSegmentPatchProperties {
  /** Patch payload. */
  properties?: NsxSegmentPatchFields;
}

/** NsxSegment updatable fields. */
model NsxSegmentPatchFields {
  /** The admin state. */
  adminState?: AdminState;
}

/** NsxNsGroup patch envelope. */
model NsxNsGroupPatchProperties {
  /** Patch payload. */
  properties?: NsxNsGroupPatchFields;
}

/** NsxNsGroup updatable fields. */
model NsxNsGroupPatchFields {
  /** The group membership expressions. */
  @identifiers(#[])
  expressions?: GroupExpression[];
}

/** NsxGatewayFirewallPolicy patch envelope. */
model NsxGatewayFirewallPolicyPatchProperties {
  /** Patch payload. */
  properties?: NsxGatewayFirewallPolicyPatchFields;
}

/** NsxGatewayFirewallPolicy updatable fields. */
model NsxGatewayFirewallPolicyPatchFields {
  /** The sequence number. */
  sequenceNumber?: int32;
}

/** NsxGatewayFirewallRule patch envelope. */
model NsxGatewayFirewallRulePatchProperties {
  /** Patch payload. */
  properties?: NsxGatewayFirewallRulePatchFields;
}

/** NsxGatewayFirewallRule updatable fields. */
model NsxGatewayFirewallRulePatchFields {
  /** Whether the rule is disabled. */
  disabled?: boolean;

  /** The sequence number. */
  sequenceNumber?: int32;
}

/** NsxLoadBalancer patch envelope. */
model NsxLoadBalancerPatchProperties {
  /** Patch payload. */
  properties?: NsxLoadBalancerPatchFields;
}

/** NsxLoadBalancer updatable fields. */
model NsxLoadBalancerPatchFields {
  /** The admin state. */
  adminState?: AdminState;
}

/** NsxNatRule patch envelope. */
model NsxNatRulePatchProperties {
  /** Patch payload. */
  properties?: NsxNatRulePatchFields;
}

/** NsxNatRule updatable fields. */
model NsxNatRulePatchFields {
  /** The admin state. */
  adminState?: AdminState;
}

// ──────────────────────────────────────────────
//  Network Agent Models
// ──────────────────────────────────────────────

/**
 * List of NetworkAgent resources.
 */
model NetworkAgentList is Azure.Core.Page<NetworkAgent>;

/**
 * Properties of a network agent.
 */
model NetworkAgentProperties is AzureResourceProperties {
  /**
   * Service principal identity details used by agent for communication to the service.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  servicePrincipalIdentityDetails: AgentSpnProperties;

  /**
   * Name of the appliance on which agent is running.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  migrateApplianceName: string;

  /**
   * Name of the fabric site associated with the agent.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  fabricSiteName: string;

  /**
   * Health details of the agent.
   */
  healthDetails?: AgentHealthProperties;
}

/**
 * Service principal properties for agent authentication.
 */
model AgentSpnProperties {
  /**
   * Tenant Id for the service principal.
   */
  tenantId?: string;

  /**
   * Application/client Id for the service principal.
   */
  applicationId?: string;

  /**
   * Object Id of the service principal.
   */
  objectId?: string;
}

/**
 * Health properties of an agent.
 */
model AgentHealthProperties {
  /** Version of the agent. */
  version?: string;

  /** Last heartbeat time of the agent in UTC. */
  lastHeartBeatUtc?: utcDateTime;
}

/** NetworkAgent patch envelope. */
model NetworkAgentPatchProperties {
  /** Patch payload. */
  properties?: NetworkAgentPatchFields;
}

/** NetworkAgent updatable fields. */
model NetworkAgentPatchFields {
  /** Health details of the agent. */
  healthDetails?: AgentHealthProperties;
}
