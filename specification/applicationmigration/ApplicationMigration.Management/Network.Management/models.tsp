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

  /** Emergency rules category. */
  Emergency: "Emergency",

  /** Infrastructure rules category. */
  Infrastructure: "Infrastructure",

  /** Environment rules category. */
  Environment: "Environment",

  /** Application rules category. */
  Application: "Application",

  /** Local gateway rules category. */
  LocalGatewayRules: "LocalGatewayRules",

  /** Default rules category. */
  Default: "Default",
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

/**
 * The context type of a gateway firewall policy.
 */
union PolicyContextType {
  string,

  /** Generic context. */
  Generic: "Generic",

  /** Gateway-specific context. */
  GatewaySpecific: "GatewaySpecific",
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
  nsxOriginalPath?: string;

  /** The NSX unique identifier. */
  @pattern("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$")
  uniqueId?: string;

  /** NSX tags applied to this resource. */
  @identifiers(#[])
  nsxTags?: NsxTag[];

  /** The list of errors. */
  @identifiers(#[])
  errors?: Error[];

  /** The number of errors. */
  errorCount?: int64;
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

/**
 * Defines the error.
 */
model Error {
  /** The error ID. */
  id?: string;

  /** The error code. */
  code?: string;

  /** The summarized error message. */
  summaryMessage?: string;

  /** The run-as account ID used during discovery. */
  runAsAccountId?: string;

  /** The detailed error message. */
  message?: string;

  /** The possible cause of the error. */
  possibleCause?: string;

  /** The recommended action to resolve the error. */
  recommendedAction?: string;

  /** The severity of the error. */
  severity?: string;

  /** The time when this error was last updated. */
  updatedTimeStamp?: utcDateTime;
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
  /** The display name. */
  displayName?: string;

  /** NSX tags. */
  @identifiers(#[])
  nsxTags?: NsxTag[];

  /** The list of errors. */
  @identifiers(#[])
  errors?: Error[];

  /** The number of errors. */
  errorCount?: int64;

  /** The fully qualified domain name of the NSX Manager. */
  fqdn?: string;

  /** The run-as account credential reference. */
  runAsAccount?: string;

  /** ARM resource IDs of local NSX Manager references. */
  localNsxManagerRefs?: Azure.Core.armResourceIdentifier[];

  /** ARM resource IDs of managed vCenter servers. */
  vcenterRefs?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OffAzure/vmwareSites/vcenters";
    }
  ]>[];
}

/** NsxTier0Gateway patch envelope. */
model NsxTier0GatewayPatchProperties {
  /** Patch payload. */
  properties?: NsxTier0GatewayPatchFields;
}

/** NsxTier0Gateway updatable fields. */
model NsxTier0GatewayPatchFields {
  /** The display name. */
  displayName?: string;

  /** NSX tags. */
  @identifiers(#[])
  nsxTags?: NsxTag[];

  /** The list of errors. */
  @identifiers(#[])
  errors?: Error[];

  /** The number of errors. */
  errorCount?: int64;

  /** The high-availability mode. */
  haMode?: HaMode;

  /** Whether the firewall is enabled. */
  firewallEnabled?: boolean;

  /** ARM resource IDs of associated Tier-1 gateways. */
  associatedTier1Gateways?: Azure.Core.armResourceIdentifier[];

  /** ARM resource IDs of associated segments. */
  associatedSegments?: Azure.Core.armResourceIdentifier[];

  /** ARM resource IDs of associated NAT rules. */
  associatedNatRules?: Azure.Core.armResourceIdentifier[];

  /** ARM resource IDs of associated gateway firewall policies. */
  associatedGfwPolicies?: Azure.Core.armResourceIdentifier[];
}

/** NsxTier1Gateway patch envelope. */
model NsxTier1GatewayPatchProperties {
  /** Patch payload. */
  properties?: NsxTier1GatewayPatchFields;
}

/** NsxTier1Gateway updatable fields. */
model NsxTier1GatewayPatchFields {
  /** The display name. */
  displayName?: string;

  /** NSX tags. */
  @identifiers(#[])
  nsxTags?: NsxTag[];

  /** The list of errors. */
  @identifiers(#[])
  errors?: Error[];

  /** The number of errors. */
  errorCount?: int64;

  /** The high-availability mode. */
  haMode?: HaMode;

  /** Whether the firewall is enabled. */
  firewallEnabled?: boolean;

  /** ARM resource ID of the parent Tier-0 gateway. */
  parentTier0Gateway?: Azure.Core.armResourceIdentifier;

  /** ARM resource IDs of associated segments. */
  associatedSegments?: Azure.Core.armResourceIdentifier[];

  /** ARM resource IDs of associated NAT rules. */
  associatedNatRules?: Azure.Core.armResourceIdentifier[];

  /** ARM resource IDs of associated gateway firewall policies. */
  associatedGfwPolicies?: Azure.Core.armResourceIdentifier[];

  /** ARM resource IDs of associated load balancers. */
  associatedLoadBalancers?: Azure.Core.armResourceIdentifier[];
}

/** NsxSegment patch envelope. */
model NsxSegmentPatchProperties {
  /** Patch payload. */
  properties?: NsxSegmentPatchFields;
}

/** NsxSegment updatable fields. */
model NsxSegmentPatchFields {
  /** The display name. */
  displayName?: string;

  /** NSX tags. */
  @identifiers(#[])
  nsxTags?: NsxTag[];

  /** The list of errors. */
  @identifiers(#[])
  errors?: Error[];

  /** The number of errors. */
  errorCount?: int64;

  /** ARM resource ID of the parent gateway. */
  parentGateway?: Azure.Core.armResourceIdentifier;

  /** The segment type. */
  segmentType?: SegmentType;

  /** VLAN identifiers for this segment. */
  vlanIds?: string[];

  /** The subnet definitions. */
  @identifiers(#[])
  subnets?: Subnet[];

  /** Whether this segment is system-owned. */
  systemOwned?: boolean;

  /** The administrative state of the segment. */
  adminState?: AdminState;

  /** ARM resource IDs of virtual machines connected to this segment. */
  associatedVirtualMachines?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OffAzure/vmwareSites/machines";
    }
  ]>[];
}

/** NsxNsGroup patch envelope. */
model NsxNsGroupPatchProperties {
  /** Patch payload. */
  properties?: NsxNsGroupPatchFields;
}

/** NsxNsGroup updatable fields. */
model NsxNsGroupPatchFields {
  /** The display name. */
  displayName?: string;

  /** NSX tags. */
  @identifiers(#[])
  nsxTags?: NsxTag[];

  /** The list of errors. */
  @identifiers(#[])
  errors?: Error[];

  /** The number of errors. */
  errorCount?: int64;

  /** The group membership expressions. */
  @identifiers(#[])
  expressions?: GroupExpression[];

  /** Effective virtual machine references resolved by the group. */
  @identifiers(#[])
  effectiveVirtualMachineRefs?: EffectiveVmRef[];

  /** Effective IP address members resolved by the group. */
  effectiveIpMembers?: string[];
}

/** NsxGatewayFirewallPolicy patch envelope. */
model NsxGatewayFirewallPolicyPatchProperties {
  /** Patch payload. */
  properties?: NsxGatewayFirewallPolicyPatchFields;
}

/** NsxGatewayFirewallPolicy updatable fields. */
model NsxGatewayFirewallPolicyPatchFields {
  /** The display name. */
  displayName?: string;

  /** NSX tags. */
  @identifiers(#[])
  nsxTags?: NsxTag[];

  /** The list of errors. */
  @identifiers(#[])
  errors?: Error[];

  /** The number of errors. */
  errorCount?: int64;

  /** The policy category. */
  category?: GatewayPolicyCategory;

  /** The sequence number determining policy evaluation order. */
  sequenceNumber?: int32;

  /** Whether this is a default policy. */
  isDefault?: boolean;

  /** The context type. */
  contextType?: PolicyContextType;

  /** The federation scope of the policy. */
  federationScope?: FederationScope;

  /** ARM resource IDs of scopes this policy is applied to. */
  appliedScopes?: Azure.Core.armResourceIdentifier[];

  /** ARM resource IDs of effective scopes. */
  effectiveScopes?: Azure.Core.armResourceIdentifier[];
}

/** NsxGatewayFirewallRule patch envelope. */
model NsxGatewayFirewallRulePatchProperties {
  /** Patch payload. */
  properties?: NsxGatewayFirewallRulePatchFields;
}

/** NsxGatewayFirewallRule updatable fields. */
model NsxGatewayFirewallRulePatchFields {
  /** The display name. */
  displayName?: string;

  /** NSX tags. */
  @identifiers(#[])
  nsxTags?: NsxTag[];

  /** The list of errors. */
  @identifiers(#[])
  errors?: Error[];

  /** The number of errors. */
  errorCount?: int64;

  /** The action to take when the rule matches. */
  action?: FirewallAction;

  /** The traffic direction the rule applies to. */
  direction?: FirewallDirection;

  /** Whether the rule is disabled. */
  disabled?: boolean;

  /** The sequence number determining rule evaluation order. */
  sequenceNumber?: int32;

  /** The global priority of the rule. */
  globalPriority?: string;

  /** ARM resource IDs of source IP groups. */
  sourceIpGroups?: Azure.Core.armResourceIdentifier[];

  /** Source IP addresses. */
  sourceAddresses?: string[];

  /** ARM resource IDs of destination IP groups. */
  destinationIpGroups?: Azure.Core.armResourceIdentifier[];

  /** Destination IP addresses. */
  destinationAddresses?: string[];

  /** The services this rule applies to. */
  @identifiers(#[])
  services?: FirewallService[];

  /** ARM resource IDs of scopes this rule is applied to. */
  appliedScopes?: Azure.Core.armResourceIdentifier[];

  /** ARM resource IDs of effective scopes. */
  effectiveScopes?: Azure.Core.armResourceIdentifier[];
}

/** NsxLoadBalancer patch envelope. */
model NsxLoadBalancerPatchProperties {
  /** Patch payload. */
  properties?: NsxLoadBalancerPatchFields;
}

/** NsxLoadBalancer updatable fields. */
model NsxLoadBalancerPatchFields {
  /** The display name. */
  displayName?: string;

  /** NSX tags. */
  @identifiers(#[])
  nsxTags?: NsxTag[];

  /** The list of errors. */
  @identifiers(#[])
  errors?: Error[];

  /** The number of errors. */
  errorCount?: int64;

  /** The type of load balancer (L4 or L7). */
  lbType?: LbType;

  /** The administrative state. */
  adminState?: AdminState;

  /** ARM resource ID of the parent gateway. */
  parentGateway?: Azure.Core.armResourceIdentifier;

  /** The frontend configuration. */
  frontend?: FrontendConfig;

  /** The backend configuration (pool, health probe, SNAT). */
  backendConfig?: BackendConfig;
}

/** NsxNatRule patch envelope. */
model NsxNatRulePatchProperties {
  /** Patch payload. */
  properties?: NsxNatRulePatchFields;
}

/** NsxNatRule updatable fields. */
model NsxNatRulePatchFields {
  /** The display name. */
  displayName?: string;

  /** NSX tags. */
  @identifiers(#[])
  nsxTags?: NsxTag[];

  /** The list of errors. */
  @identifiers(#[])
  errors?: Error[];

  /** The number of errors. */
  errorCount?: int64;

  /** The NAT type (SNAT or DNAT). */
  natType?: NatType;

  /** The administrative state. */
  adminState?: AdminState;

  /** ARM resource ID of the parent gateway. */
  parentGateway?: Azure.Core.armResourceIdentifier;

  /** The match criteria. */
  match?: NatMatch;

  /** The translation target. */
  translate?: NatTranslate;
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
model NetworkAgentProperties {
  /** The provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The display name of the agent. */
  displayName?: string;

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

  /** The list of errors. */
  @identifiers(#[])
  errors?: Error[];

  /** The number of errors. */
  errorCount?: int64;
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
  /** The display name of the agent. */
  displayName?: string;

  /** Health details of the agent. */
  healthDetails?: AgentHealthProperties;

  /** The list of errors. */
  @identifiers(#[])
  errors?: Error[];

  /** The number of errors. */
  errorCount?: int64;
}
