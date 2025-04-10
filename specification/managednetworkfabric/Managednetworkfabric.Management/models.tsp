import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ManagedNetworkFabric;

/**
 * Configuration state for the resource.
 */
union ConfigurationState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Rejected: "Rejected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Provisioned: "Provisioned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ErrorProvisioning: "ErrorProvisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deprovisioning: "Deprovisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deprovisioned: "Deprovisioned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ErrorDeprovisioning: "ErrorDeprovisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DeferredControl: "DeferredControl",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PendingCommit: "PendingCommit",
}

/**
 * The current provisioning state.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * State defined to represent administrative actions or post actions on a particular resource.
 */
union AdministrativeState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MAT: "MAT",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RMA: "RMA",
}

/**
 * Input method to configure Access Control List.
 */
union ConfigurationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  File: "File",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Inline: "Inline",
}

/**
 * community action types. Example: Permit | Deny.
 */
union CommunityActionTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Permit: "Permit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deny: "Deny",
}

/**
 * IP Address type.
 */
union IPAddressType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IPv4: "IPv4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IPv6: "IPv6",
}

/**
 * Port type that needs to be matched.
 */
union PortType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SourcePort: "SourcePort",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DestinationPort: "DestinationPort",
}

/**
 * Layer4 protocol type that needs to be matched.
 */
union Layer4Protocol {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TCP: "TCP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UDP: "UDP",
}

/**
 * IP Address type that needs to be matched.
 */
union SourceDestinationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SourceIP: "SourceIP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DestinationIP: "DestinationIP",
}

/**
 * IP Prefix Type that needs to be matched.
 */
union PrefixType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Prefix: "Prefix",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LongestPrefix: "LongestPrefix",
}

/**
 * Type of actions that can be performed.
 */
union AclActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Drop: "Drop",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Count: "Count",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Log: "Log",
}

/**
 * Administrative state.
 */
union EnableDisableState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enable: "Enable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disable: "Disable",
}

/**
 * Gateway Type of the resource.
 */
union GatewayType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Infrastructure: "Infrastructure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Workload: "Workload",
}

/**
 * Specify action.
 */
union Action {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Allow: "Allow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deny: "Deny",
}

/**
 *
 * `Internet` - Advertise routes to internet community.
 *  `LocalAS` - Advertise routes to only localAS peers.
 *  `NoAdvertise` - Don't advertise routes to any peer.
 * `NoExport` - Don't export to next AS.
 * `GShut` - Graceful Shutdown (GSHUT) withdraw routes before terminating BGP connection.
 *
 */
union WellKnownCommunities {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Internet: "Internet",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LocalAS: "LocalAS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NoAdvertise: "NoAdvertise",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NoExport: "NoExport",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GShut: "GShut",
}

/**
 * Specify prefix-list bounds.
 */
union Condition {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EqualTo: "EqualTo",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GreaterThanOrEqualTo: "GreaterThanOrEqualTo",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LesserThanOrEqualTo: "LesserThanOrEqualTo",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Range: "Range",
}

/**
 * Advertise Connected Subnets. Ex: "True" | "False".
 */
union RedistributeConnectedSubnets {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  False: "False",
}

/**
 * Advertise Static Routes. Ex: "True" | "False".
 */
union RedistributeStaticRoutes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  False: "False",
}

/**
 * Administrative state of the BfdConfiguration. Example: Enabled | Disabled.
 */
union BfdAdministrativeState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MAT: "MAT",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RMA: "RMA",
}

/**
 * Boolean Enum. Example- True/False
 */
union BooleanEnumProperty {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  False: "False",
}

/**
 * Enable Or Disable state.
 */
union AllowASOverride {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enable: "Enable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disable: "Disable",
}

/**
 * Extension. Example: NoExtension | NPB.
 */
union Extension {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NoExtension: "NoExtension",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NPB: "NPB",
}

/**
 * To check whether monitoring of internal network is enabled or not.
 */
union IsMonitoringEnabled {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  False: "False",
}

/**
 * Peering option list.
 */
union PeeringOption {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OptionA: "OptionA",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OptionB: "OptionB",
}

/**
 * Available roles for the network device.
 */
union NetworkDeviceRoleName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CE: "CE",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ToR: "ToR",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NPB: "NPB",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TS: "TS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Management: "Management",
}

/**
 * NetworkDeviceRole is the device role: Example: CE | ToR.
 */
union NetworkDeviceRole {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CE: "CE",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ToR: "ToR",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NPB: "NPB",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TS: "TS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Management: "Management",
}

/**
 * The Interface Type. Example: Management/Data
 */
union InterfaceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Management: "Management",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Data: "Data",
}

/**
 * Type of reboot to be performed. Example: GracefulRebootWithZTP
 */
union RebootType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GracefulRebootWithZTP: "GracefulRebootWithZTP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GracefulRebootWithoutZTP: "GracefulRebootWithoutZTP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UngracefulRebootWithZTP: "UngracefulRebootWithZTP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UngracefulRebootWithoutZTP: "UngracefulRebootWithoutZTP",
}

/**
 * Administrative state.
 */
union DeviceAdministrativeState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RMA: "RMA",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Resync: "Resync",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GracefulQuarantine: "GracefulQuarantine",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Quarantine: "Quarantine",
}

/**
 * A workload management network is required for all the tenant (workload) traffic. This traffic is only dedicated for Tenant workloads which are required to access internet or any other MSFT/Public endpoints.
 */
union IsWorkloadManagementNetworkEnabled {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  False: "False",
}

/**
 * Network Fabric Controller SKU.
 */
union NfcSku {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Basic: "Basic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HighPerformance: "HighPerformance",
}

/**
 * Type of Network Fabric SKU.
 */
union FabricSkuType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SingleRack: "SingleRack",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MultiRack: "MultiRack",
}

/**
 * Action to be performed while upgrading the fabric.
 */
union NetworkFabricUpgradeAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Start: "Start",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Complete: "Complete",
}

/**
 * Validate action that to be performed
 */
union ValidateAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Cabling: "Cabling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Configuration: "Configuration",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Connectivity: "Connectivity",
}

/**
 * Type of NNI used. Example: CE | NPB
 */
union NniType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CE: "CE",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NPB: "NPB",
}

/**
 * Configuration to use NNI for Infrastructure Management. Example: True/False.
 */
union IsManagementType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  False: "False",
}

/**
 * Network Rack SKU name.
 */
union NetworkRackType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Aggregate: "Aggregate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Compute: "Compute",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Combined: "Combined",
}

/**
 * Polling interval in seconds.
 */
union PollingIntervalInSeconds {
  integer,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `30`: 30,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `60`: 60,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `90`: 90,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `120`: 120,
}

/**
 * Encapsulation Type that needs to be matched.
 */
union EncapsulationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GTPv1: "GTPv1",
}

/**
 * Type of actions that can be performed.
 */
union TapRuleActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Drop: "Drop",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Count: "Count",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Log: "Log",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Replicate: "Replicate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Goto: "Goto",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Redirect: "Redirect",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Mirror: "Mirror",
}

/**
 * Type of destination. Input can be IsolationDomain or Direct.
 */
union DestinationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IsolationDomain: "IsolationDomain",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Direct: "Direct",
}

/**
 * Type of encapsulation.
 */
union Encapsulation {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GRE: "GRE",
}

/**
 * Polling type.
 */
union PollingType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pull: "Pull",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Push: "Push",
}

/**
 * AddressFamilyType. This parameter decides whether the given ipv4 or ipv6 route policy.
 */
union AddressFamilyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IPv4: "IPv4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IPv6: "IPv6",
}

/**
 * Type of the condition used.
 */
union RoutePolicyConditionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Or: "Or",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  And: "And",
}

/**
 * Action type. Example: Permit | Deny | Continue.
 */
union RoutePolicyActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Permit: "Permit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deny: "Deny",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Continue: "Continue",
}

/**
 * Access Control List Properties defines the resource properties.
 */
model AccessControlListProperties {
  ...AnnotationResource;
  ...AccessControlListPatchableProperties;

  /**
   * The last synced timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncedTime?: utcDateTime;

  /**
   * Configuration state of the resource.
   */
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Administrative state of the resource.
   */
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;
}

/**
 * Switch configuration entries require a description to discern between configuration groups.
 */
model AnnotationResource {
  /**
   * Switch configuration description.
   */
  annotation?: string;
}

/**
 * Access Control List Patch Properties defines the patchable resource properties.
 */
model AccessControlListPatchableProperties {
  /**
   * Input method to configure Access Control List.
   */
  configurationType?: ConfigurationType;

  /**
   * Access Control List file URL.
   */
  aclsUrl?: url;

  /**
   * Default action that needs to be applied when no condition is matched. Example: Permit | Deny.
   */
  defaultAction?: CommunityActionTypes;

  /**
   * List of match configurations.
   */
  matchConfigurations?: AccessControlListMatchConfiguration[];

  /**
   * List of dynamic match configurations.
   */
  dynamicMatchConfigurations?: CommonDynamicMatchConfiguration[];
}

/**
 * Defines the match configuration that are supported to filter the traffic.
 */
model AccessControlListMatchConfiguration {
  /**
   * The name of the match configuration.
   */
  @minLength(1)
  matchConfigurationName?: string;

  /**
   * Sequence Number of the match configuration.
   */
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber?: int64;

  /**
   * Type of IP Address. IPv4 or IPv6
   */
  ipAddressType?: IPAddressType;

  /**
   * List of the match conditions.
   */
  matchConditions?: AccessControlListMatchCondition[];

  /**
   * List of actions that need to be performed for the matched conditions.
   */
  actions?: AccessControlListAction[];
}

/**
 * Defines the match condition that is supported to filter the traffic.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AccessControlListMatchCondition extends CommonMatchConditions {
  /**
   * List of ether type values that need to be matched.
   */
  etherTypes?: string[];

  /**
   * List of IP fragment packets that need to be matched.
   */
  fragments?: string[];

  /**
   * List of IP Lengths that need to be matched.
   */
  ipLengths?: string[];

  /**
   * List of TTL [Time To Live] values that need to be matched.
   */
  ttlValues?: string[];

  /**
   * List of DSCP Markings that need to be matched.
   */
  dscpMarkings?: string[];

  /**
   * Defines the port condition that needs to be matched.
   */
  portCondition?: AccessControlListPortCondition;
}

/**
 * Defines the port condition that needs to be matched.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AccessControlListPortCondition extends PortCondition {
  /**
   * List of protocol flags that need to be matched. Example: established | initial | <List-of-TCP-flags>. List of eligible TCP Flags are ack, fin, not-ack, not-fin, not-psh, not-rst, not-syn, not-urg, psh, rst, syn, urg
   */
  flags?: string[];
}

/**
 * Port condition that needs to be matched.
 */
model PortCondition {
  /**
   * Port type that needs to be matched.
   */
  portType?: PortType;

  /**
   * Layer4 protocol type that needs to be matched.
   */
  layer4Protocol: Layer4Protocol;

  /**
   * List of the Ports that need to be matched.
   */
  ports?: string[];

  /**
   * List of the port Group Names that need to be matched.
   */
  portGroupNames?: string[];
}

/**
 * Defines the common match conditions of the ACL and Network Tap Rule.
 */
model CommonMatchConditions {
  /**
   * List of the protocols that need to be matched.
   */
  protocolTypes?: string[];

  /**
   * Vlan match condition that needs to be matched.
   */
  vlanMatchCondition?: VlanMatchCondition;

  /**
   * IP condition that needs to be matched.
   */
  ipCondition?: IpMatchCondition;
}

/**
 * The vlan match conditions that need to be matched.
 */
model VlanMatchCondition {
  /**
   * List of vlans that need to be matched.
   */
  vlans?: string[];

  /**
   * List of inner vlans that need to be matched.
   */
  innerVlans?: string[];

  /**
   * List of vlan group names that need to be matched.
   */
  vlanGroupNames?: string[];
}

/**
 * Defines the condition that can be filtered using the selected IPs.
 */
model IpMatchCondition {
  /**
   * IP Address type that needs to be matched.
   */
  type?: SourceDestinationType;

  /**
   * IP Prefix Type that needs to be matched.
   */
  prefixType?: PrefixType;

  /**
   * The list of IP Prefixes that need to be matched.
   */
  ipPrefixValues?: string[];

  /**
   * The List of IP Group Names that need to be matched.
   */
  ipGroupNames?: string[];
}

/**
 * Action that need to performed.
 */
model AccessControlListAction {
  /**
   * Type of actions that can be performed.
   */
  type?: AclActionType;

  /**
   * Name of the counter block to get match count information.
   */
  @minLength(1)
  counterName?: string;
}

/**
 * Dynamic match configuration object.
 */
model CommonDynamicMatchConfiguration {
  /**
   * List of IP Groups.
   */
  ipGroups?: IpGroupProperties[];

  /**
   * List of vlan groups.
   */
  vlanGroups?: VlanGroupProperties[];

  /**
   * List of the port groups.
   */
  portGroups?: PortGroupProperties[];
}

/**
 * IP Group properties.
 */
model IpGroupProperties {
  /**
   * IP Group name.
   */
  @minLength(1)
  name?: string;

  /**
   * IP Address type.
   */
  ipAddressType?: IPAddressType;

  /**
   * List of IP Prefixes.
   */
  ipPrefixes?: string[];
}

/**
 * Vlan group properties.
 */
model VlanGroupProperties {
  /**
   * Vlan group name.
   */
  @minLength(1)
  name?: string;

  /**
   * List of vlans.
   */
  vlans?: string[];
}

/**
 * Port Group properties.
 */
model PortGroupProperties {
  /**
   * The name of the port group.
   */
  @minLength(1)
  name?: string;

  /**
   * List of the ports that need to be matched.
   */
  ports?: string[];
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
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
 * The Access Control Lists patch resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AccessControlListPatch extends TagsUpdate {
  /**
   * Access Control Lists patch properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: AccessControlListPatchProperties;
}

/**
 * Access Control Lists patch properties.
 */
model AccessControlListPatchProperties {
  ...AccessControlListPatchableProperties;
  ...AnnotationResource;
}

/**
 * Base tracked resource type for PATCH updates.
 */
model TagsUpdate {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Update administrative state on list of resources.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model UpdateAdministrativeState extends EnableDisableOnResources {
  /**
   * Administrative state.
   */
  state?: EnableDisableState;
}

/**
 * Update administrative state on list of resources.
 */
model EnableDisableOnResources {
  /**
   * Network Fabrics or Network Rack resource Id.
   */
  resourceIds?: string[];
}

/**
 * Common response for the state updates.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model CommonPostActionResponseForStateUpdate extends ErrorResponse {
  /**
   * Gets the configuration state.
   */
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;
}

/**
 * The response of the action validate configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ValidateConfigurationResponse extends ErrorResponse {
  /**
   * Gets the configuration state.
   */
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  /**
   * URL for the details of the response.
   */
  url?: string;
}

/**
 * Internet Gateway Properties defines the properties of the resource.
 */
model InternetGatewayProperties {
  ...AnnotationResource;
  ...InternetGatewayPatchableProperties;

  /**
   * IPv4 Address of Internet Gateway.
   */
  @visibility(Lifecycle.Read)
  ipv4Address?: string;

  /**
   * Port number of Internet Gateway.
   */
  @visibility(Lifecycle.Read)
  port?: int32;

  /**
   * Gateway Type of the resource.
   */
  type: GatewayType;

  /**
   * ARM Resource ID of the Network Fabric Controller.
   */
  networkFabricControllerId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabricControllers";
    }
  ]>;

  /**
   * Provisioning state of resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Internet Gateway Patchable Properties defines the patchable properties of the resource.
 */
model InternetGatewayPatchableProperties {
  /**
   * ARM Resource ID of the Internet Gateway Rule.
   */
  internetGatewayRuleId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/internetGatewayRules";
    }
  ]>;
}

/**
 * The Internet Gateway patch resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model InternetGatewayPatch extends TagsUpdate {
  /**
   * Resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: InternetGatewayPatchableProperties;
}

/**
 * Internet Gateway Rule Properties defines the resource properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model InternetGatewayRuleProperties extends AnnotationResource {
  /**
   * Rules for the InternetGateways
   */
  ruleProperties: RuleProperties;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * List of Internet Gateway resource Id.
   */
  @visibility(Lifecycle.Read)
  internetGatewayIds?: string[];
}

/**
 * Rules for the InternetGateways
 */
model RuleProperties {
  /**
   * Specify action.
   */
  action: Action;

  /**
   * List of Addresses to be allowed or denied.
   */
  addressList: string[];
}

/**
 * The Internet Gateway Rules patch resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model InternetGatewayRulePatch extends TagsUpdate {}

/**
 * IP Community Properties defines the resource properties.
 */
model IpCommunityProperties {
  ...AnnotationResource;
  ...IpCommunityPatchableProperties;

  /**
   * Configuration state of the resource.
   */
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Administrative state of the resource.
   */
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;
}

/**
 * IP Community patchable properties.
 */
model IpCommunityPatchableProperties {
  /**
   * List of IP Community Rules.
   */
  ipCommunityRules?: IpCommunityRule[];
}

/**
 * IP Community patchable properties.
 */
model IpCommunityRule {
  /**
   * Action to be taken on the configuration. Example: Permit | Deny.
   */
  action: CommunityActionTypes;

  /**
   * Sequence to insert to/delete from existing route. Prefix lists are evaluated starting with the lowest sequence number and continue down the list until a match is made. Once a match is made, the permit or deny statement is applied to that network and the rest of the list is ignored.
   */
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber: int64;

  /**
   * Supported well known Community List.
   */
  wellKnownCommunities?: WellKnownCommunities[];

  /**
   * List the community members of IP Community.
   */
  communityMembers: string[];
}

/**
 * The IP Community patch resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model IpCommunityPatch extends TagsUpdate {
  /**
   * IP Community patchable properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: IpCommunityPatchableProperties;
}

/**
 * IP Extended Community Properties defines the resource properties.
 */
model IpExtendedCommunityProperties {
  ...AnnotationResource;
  ...IpExtendedCommunityPatchableProperties;

  /**
   * Configuration state of the resource.
   */
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Administrative state of the resource.
   */
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;
}

/**
 * IP Extended Community patchable properties.
 */
model IpExtendedCommunityPatchableProperties {
  /**
   * List of IP Extended Community Rules.
   */
  ipExtendedCommunityRules: IpExtendedCommunityRule[];
}

/**
 * List of IP Extended Community Rules.
 */
model IpExtendedCommunityRule {
  /**
   * Action to be taken on the configuration. Example: Permit | Deny.
   */
  action: CommunityActionTypes;

  /**
   * Sequence to insert to/delete from existing route. Prefix lists are evaluated starting with the lowest sequence number and continue down the list until a match is made. Once a match is made, the permit or deny statement is applied to that network and the rest of the list is ignored.
   */
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber: int64;

  /**
   * Route Target List.The expected formats are ASN(plain):NN >> example 4294967294:50, ASN.ASN:NN >> example 65533.65333:40, IP-address:NN >> example 10.10.10.10:65535. The possible values of ASN,NN are in range of 0-65535, ASN(plain) is in range of 0-4294967295.
   */
  routeTargets: string[];
}

/**
 * The IP Extended Communities patch resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model IpExtendedCommunityPatch extends TagsUpdate {
  /**
   * IP Extended Community patchable properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: IpExtendedCommunityPatchProperties;
}

/**
 * IP Extended Community patchable properties.
 */
model IpExtendedCommunityPatchProperties {
  ...IpExtendedCommunityPatchableProperties;
  ...AnnotationResource;
}

/**
 * IP Prefix Properties defines the properties of the resource.
 */
model IpPrefixProperties {
  ...AnnotationResource;
  ...IpPrefixPatchableProperties;

  /**
   * Configuration state of the resource.
   */
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Administrative state of the resource.
   */
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;
}

/**
 * IP Prefix patchable properties.
 */
model IpPrefixPatchableProperties {
  /**
   * The list of IP Prefix Rules.
   */
  ipPrefixRules?: IpPrefixRule[];
}

/**
 * IP Prefix Rule properties.
 */
model IpPrefixRule {
  /**
   * Action to be taken on the configuration. Example: Permit | Deny.
   */
  action: CommunityActionTypes;

  /**
   * Sequence to insert to/delete from existing route. Prefix lists are evaluated starting with the lowest sequence number and continue down the list until a match is made. Once a match is made, the permit or deny statement is applied to that network and the rest of the list is ignored.
   */
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber: int64;

  /**
   * Network Prefix specifying IPv4/IPv6 packets to be permitted or denied. Example: 1.1.1.0/24 | 3FFE:FFFF:0:CD30::/126
   */
  networkPrefix: string;

  /**
   * Specify prefix-list bounds.
   */
  condition?: Condition;

  /**
   * SubnetMaskLength gives the minimum NetworkPrefix length to be matched. Possible values for IPv4 are 1 - 32 . Possible values of IPv6 are 1 - 128.
   */
  subnetMaskLength?: string;
}

/**
 * The IP Prefix patch resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model IpPrefixPatch extends TagsUpdate {
  /**
   * IP Prefix patchable properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: IpPrefixPatchProperties;
}

/**
 * IP Prefix patchable properties.
 */
model IpPrefixPatchProperties {
  ...AnnotationResource;
  ...IpPrefixPatchableProperties;
}

/**
 * L2Isolation Domain Properties defines the properties of the resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model L2IsolationDomainProperties extends AnnotationResource {
  /**
   * ARM Resource ID of the Network Fabric.
   */
  networkFabricId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  /**
   * Vlan Identifier of the Network Fabric. Example: 501.
   */
  @maxValue(4094)
  @minValue(100)
  vlanId: int32;

  /**
   * Maximum transmission unit. Default value is 1500.
   */
  @maxValue(9200)
  @minValue(64)
  mtu?: int32 = 1500;

  /**
   * Configuration state of the resource.
   */
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Administrative state of the resource.
   */
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;
}

/**
 * The L2 Isolation Domain patch resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model L2IsolationDomainPatch extends TagsUpdate {
  /**
   * Resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: L2IsolationDomainPatchProperties;
}

/**
 * L2 Isolation Domain Patch Properties defines the patchable properties of the resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model L2IsolationDomainPatchProperties extends AnnotationResource {
  /**
   * Maximum transmission unit. Default value is 1500.
   */
  @maxValue(9200)
  @minValue(64)
  mtu?: int32 = 1500;
}

/**
 * Common response for device updates.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model CommonPostActionResponseForDeviceUpdate extends ErrorResponse {
  /**
   * Gets the configuration state.
   */
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  /**
   * List of ARM Resource IDs for which the given action applied successfully.
   */
  successfulDevices?: string[];

  /**
   * List of ARM Resource IDs for which the given action failed to apply.
   */
  failedDevices?: string[];
}

/**
 * L3 Isolation Domain Properties defines the properties of the resource.
 */
model L3IsolationDomainProperties {
  ...AnnotationResource;
  ...L3IsolationDomainPatchableProperties;

  /**
   * ARM Resource ID of the Network Fabric.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkFabricId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  /**
   * Configuration state of the resource.
   */
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Administrative state of the resource.
   */
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;
}

/**
 * L3 Isolation Domain Patch Properties defines the patchable properties of the resource.
 */
model L3IsolationDomainPatchableProperties {
  /**
   * Advertise Connected Subnets. Ex: "True" | "False".
   */
  redistributeConnectedSubnets?: RedistributeConnectedSubnets = RedistributeConnectedSubnets.True;

  /**
   * Advertise Static Routes. Ex: "True" | "False".
   */
  redistributeStaticRoutes?: RedistributeStaticRoutes = RedistributeStaticRoutes.False;

  /**
   * Aggregate route configurations.
   */
  aggregateRouteConfiguration?: AggregateRouteConfiguration;

  /**
   * Connected Subnet RoutePolicy
   */
  connectedSubnetRoutePolicy?: ConnectedSubnetRoutePolicy;
}

/**
 * List of IPv4 and IPv6 aggregate routes.
 */
model AggregateRouteConfiguration {
  /**
   * List of IPv4 Route prefixes.
   */
  @OpenAPI.extension("x-ms-identifiers", #["prefix"])
  ipv4Routes?: AggregateRoute[];

  /**
   * List of Ipv6Routes prefixes.
   */
  @OpenAPI.extension("x-ms-identifiers", #["prefix"])
  ipv6Routes?: AggregateRoute[];
}

/**
 * aggregateIpv4Route model.
 */
model AggregateRoute {
  /**
   * IPv4 Prefix of the aggregate Ipv4Route.
   */
  @minLength(1)
  prefix: string;
}

/**
 * Connected Subnet Route Policy properties.
 */
model ConnectedSubnetRoutePolicy {
  /**
   * ARM Resource ID of the Route Policy. This is used for the backward compatibility.
   */
  exportRoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  /**
   * Array of ARM Resource ID of the RoutePolicies.
   */
  exportRoutePolicy?: L3ExportRoutePolicy;
}

/**
 * Array of ARM Resource ID of the RoutePolicies.
 */
model L3ExportRoutePolicy {
  /**
   * ARM Resource ID of the RoutePolicy.
   */
  exportIpv4RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  /**
   * ARM Resource ID of the RoutePolicy.
   */
  exportIpv6RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;
}

/**
 * The L3 Isolation Domain patch resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model L3IsolationDomainPatch extends TagsUpdate {
  /**
   * Resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: L3IsolationDomainPatchProperties;
}

/**
 * Resource properties.
 */
model L3IsolationDomainPatchProperties {
  ...AnnotationResource;
  ...L3IsolationDomainPatchableProperties;
}

/**
 * Internal Network Properties defines the properties of the resource.
 */
model InternalNetworkProperties {
  ...AnnotationResource;
  ...InternalNetworkPatchableProperties;
  ...ExtensionEnumProperty;

  /**
   * Vlan identifier. Example: 1001.
   */
  @maxValue(4094)
  @minValue(100)
  vlanId: int32;

  /**
   * BGP configuration properties.
   */
  bgpConfiguration?: InternalNetworkPropertiesBgpConfiguration;

  /**
   * Static Route Configuration properties.
   */
  staticRouteConfiguration?: InternalNetworkPropertiesStaticRouteConfiguration;

  /**
   * Configuration state of the resource.
   */
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Administrative state of the resource.
   */
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;
}

/**
 * BGP configuration properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model InternalNetworkPropertiesBgpConfiguration extends BgpConfiguration {}

/**
 * BGP configuration properties
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model BgpConfiguration extends AnnotationResource {
  /**
   * BFD configuration properties
   */
  bfdConfiguration?: BfdConfiguration;

  /**
   * Originate a defaultRoute. Ex: "True" | "False".
   */
  defaultRouteOriginate?: BooleanEnumProperty;

  /**
   * Allows for routes to be received and processed even if the router detects its own ASN in the AS-Path. 0 is disable, Possible values are 1-10, default is 2.
   */
  @maxValue(10)
  allowAS?: int32 = 2;

  /**
   * Enable Or Disable state.
   */
  allowASOverride?: AllowASOverride;

  /**
   * ASN of Network Fabric. Example: 65048.
   */
  @visibility(Lifecycle.Read)
  fabricASN?: int64;

  /**
   * Peer ASN. Example: 65047.
   */
  @maxValue(4294967295)
  @minValue(1)
  peerASN?: int64;

  /**
   * List of BGP IPv4 Listen Range prefixes.
   */
  ipv4ListenRangePrefixes?: string[];

  /**
   * List of BGP IPv6 Listen Ranges prefixes.
   */
  ipv6ListenRangePrefixes?: string[];

  /**
   * List with stringified IPv4 Neighbor Addresses.
   */
  @OpenAPI.extension("x-ms-identifiers", #["address"])
  ipv4NeighborAddress?: NeighborAddress[];

  /**
   * List with stringified IPv6 Neighbor Address.
   */
  @OpenAPI.extension("x-ms-identifiers", #["address"])
  ipv6NeighborAddress?: NeighborAddress[];
}

/**
 * BFD configuration properties
 */
model BfdConfiguration {
  /**
   * Administrative state of the BfdConfiguration. Example: Enabled | Disabled.
   */
  @visibility(Lifecycle.Read)
  administrativeState?: BfdAdministrativeState = BfdAdministrativeState.Disabled;

  /**
   * Interval in milliseconds. Example: 300.
   */
  intervalInMilliSeconds?: int32 = 300;

  /**
   * Multiplier for the Bfd Configuration. Example: 5.
   */
  multiplier?: int32 = 5;
}

/**
 * Neighbor Address properties.
 */
model NeighborAddress {
  /**
   * IP Address.
   */
  @minLength(1)
  address?: string;

  /**
   * Configuration state of the resource.
   */
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;
}

/**
 * Static Route Configuration properties.
 */
model InternalNetworkPropertiesStaticRouteConfiguration {
  ...StaticRouteConfiguration;
  ...ExtensionEnumProperty;
}

/**
 * Static Route Configuration properties.
 */
model StaticRouteConfiguration {
  /**
   * BFD configuration properties
   */
  bfdConfiguration?: BfdConfiguration;

  /**
   * List of IPv4 Routes.
   */
  @OpenAPI.extension("x-ms-identifiers", #["prefix"])
  ipv4Routes?: StaticRouteProperties[];

  /**
   * List of IPv6 Routes.
   */
  @OpenAPI.extension("x-ms-identifiers", #["prefix"])
  ipv6Routes?: StaticRouteProperties[];
}

/**
 * Route Properties.
 */
model StaticRouteProperties {
  /**
   * Prefix of the route.
   */
  @minLength(1)
  prefix: string;

  /**
   * List of next hop addresses.
   */
  nextHop: string[];
}

/**
 * Extension property.
 */
model ExtensionEnumProperty {
  /**
   * Extension. Example: NoExtension | NPB.
   */
  extension?: Extension = Extension.NoExtension;
}

/**
 * The InternalNetwork patchable properties.
 */
model InternalNetworkPatchableProperties {
  /**
   * Maximum transmission unit. Default value is 1500.
   */
  @maxValue(9200)
  @minValue(64)
  mtu?: int32 = 1500;

  /**
   * List of Connected IPv4 Subnets.
   */
  @OpenAPI.extension("x-ms-identifiers", #["prefix"])
  connectedIPv4Subnets?: ConnectedSubnet[];

  /**
   * List of connected IPv6 Subnets.
   */
  @OpenAPI.extension("x-ms-identifiers", #["prefix"])
  connectedIPv6Subnets?: ConnectedSubnet[];

  /**
   * ARM Resource ID of the RoutePolicy. This is used for the backward compatibility.
   */
  importRoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  /**
   * ARM Resource ID of the RoutePolicy. This is used for the backward compatibility.
   */
  exportRoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  /**
   * Import Route Policy either IPv4 or IPv6.
   */
  importRoutePolicy?: ImportRoutePolicy;

  /**
   * Export Route Policy either IPv4 or IPv6.
   */
  exportRoutePolicy?: ExportRoutePolicy;

  /**
   * Ingress Acl. ARM resource ID of Access Control Lists.
   */
  ingressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  /**
   * Egress Acl. ARM resource ID of Access Control Lists.
   */
  egressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  /**
   * To check whether monitoring of internal network is enabled or not.
   */
  isMonitoringEnabled?: IsMonitoringEnabled = IsMonitoringEnabled.False;
}

/**
 * Connected Subnet properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ConnectedSubnet extends AnnotationResource {
  /**
   * Prefix of the Connected Subnet.
   */
  @minLength(1)
  prefix: string;
}

/**
 * Import Route Policy either IPv4 or IPv6.
 */
model ImportRoutePolicy {
  /**
   * ARM resource ID of RoutePolicy.
   */
  importIpv4RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  /**
   * ARM resource ID of RoutePolicy.
   */
  importIpv6RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;
}

/**
 * Export Route Policy either IPv4 or IPv6.
 */
model ExportRoutePolicy {
  /**
   * ARM resource ID of RoutePolicy.
   */
  exportIpv4RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  /**
   * ARM resource ID of RoutePolicy.
   */
  exportIpv6RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;
}

/**
 * The InternalNetwork patch resource definition.
 */
model InternalNetworkPatch {
  /**
   * InternalNetwork Patch properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: InternalNetworkPatchProperties;
}

/**
 * InternalNetwork Patch properties.
 */
model InternalNetworkPatchProperties {
  ...AnnotationResource;
  ...InternalNetworkPatchableProperties;

  /**
   * BGP configuration properties.
   */
  bgpConfiguration?: BgpConfiguration;

  /**
   * Static Route Configuration properties.
   */
  staticRouteConfiguration?: StaticRouteConfiguration;
}

/**
 * List of Internal Networks.
 */
model InternalNetworksList is Azure.Core.Page<InternalNetwork>;

/**
 * External Network Properties.
 */
model ExternalNetworkProperties {
  ...AnnotationResource;
  ...ExternalNetworkPatchableProperties;

  /**
   * Peering option list.
   */
  peeringOption: PeeringOption;

  /**
   * option B properties object
   */
  optionBProperties?: L3OptionBProperties;

  /**
   * option A properties object
   */
  optionAProperties?: ExternalNetworkPropertiesOptionAProperties;

  /**
   * Configuration state of the resource.
   */
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Administrative state of the resource.
   */
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;
}

/**
 * Option B configuration.
 */
model L3OptionBProperties {
  /**
   * RouteTargets to be applied. This is used for the backward compatibility.
   */
  importRouteTargets?: string[];

  /**
   * RouteTargets to be applied. This is used for the backward compatibility.
   */
  exportRouteTargets?: string[];

  /**
   * RouteTargets to be applied.
   */
  routeTargets?: RouteTargetInformation;
}

/**
 * Route Target Configuration.
 */
model RouteTargetInformation {
  /**
   * Route Targets to be applied for incoming routes into CE.
   */
  importIpv4RouteTargets?: string[];

  /**
   * Route Targets to be applied for incoming routes from CE.
   */
  importIpv6RouteTargets?: string[];

  /**
   * Route Targets to be applied for outgoing routes into CE.
   */
  exportIpv4RouteTargets?: string[];

  /**
   * Route Targets to be applied for outgoing routes from CE.
   */
  exportIpv6RouteTargets?: string[];
}

/**
 * option A properties object
 */
model ExternalNetworkPropertiesOptionAProperties {
  ...Layer3IpPrefixProperties;
  ...L3OptionAProperties;
}

/**
 * Layer 3 primary and secondary IP Address prefixes.
 */
model Layer3IpPrefixProperties {
  /**
   * IPv4 Address Prefix.
   */
  primaryIpv4Prefix?: string;

  /**
   * IPv6 Address Prefix.
   */
  primaryIpv6Prefix?: string;

  /**
   * Secondary IPv4 Address Prefix.
   */
  secondaryIpv4Prefix?: string;

  /**
   * Secondary IPv6 Address Prefix.
   */
  secondaryIpv6Prefix?: string;
}

/**
 * Peering optionA properties
 */
model L3OptionAProperties {
  /**
   * MTU to use for option A peering.
   */
  @maxValue(9200)
  @minValue(64)
  mtu?: int32 = 1500;

  /**
   * Vlan identifier. Example : 501
   */
  @maxValue(4094)
  @minValue(501)
  vlanId?: int32;

  /**
   * Fabric ASN number. Example 65001
   */
  @visibility(Lifecycle.Read)
  @maxValue(4294967295)
  @minValue(1)
  fabricASN?: int64;

  /**
   * Peer ASN number.Example : 28
   */
  @maxValue(4294967295)
  @minValue(1)
  peerASN?: int64;

  /**
   * BFD configuration properties
   */
  bfdConfiguration?: BfdConfiguration;

  /**
   * Ingress Acl. ARM resource ID of Access Control Lists.
   */
  ingressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  /**
   * Egress Acl. ARM resource ID of Access Control Lists.
   */
  egressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;
}

/**
 * The ExternalNetwork patchable properties.
 */
model ExternalNetworkPatchableProperties {
  /**
   * ARM Resource ID of the networkToNetworkInterconnectId of the ExternalNetwork resource.
   */
  networkToNetworkInterconnectId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics/networkToNetworkInterconnects";
    }
  ]>;

  /**
   * ARM Resource ID of the RoutePolicy. This is used for the backward compatibility.
   */
  importRoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  /**
   * ARM Resource ID of the RoutePolicy. This is used for the backward compatibility.
   */
  exportRoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  /**
   * Import Route Policy either IPv4 or IPv6.
   */
  importRoutePolicy?: ImportRoutePolicy;

  /**
   * Export Route Policy either IPv4 or IPv6.
   */
  exportRoutePolicy?: ExportRoutePolicy;
}

/**
 * The ExternalNetwork patch resource definition.
 */
model ExternalNetworkPatch {
  /**
   * External Network Patch properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ExternalNetworkPatchProperties;
}

/**
 * External Network Patch properties.
 */
model ExternalNetworkPatchProperties {
  ...AnnotationResource;
  ...ExternalNetworkPatchableProperties;

  /**
   * Peering option list.
   */
  peeringOption?: PeeringOption;

  /**
   * option B properties object
   */
  optionBProperties?: L3OptionBProperties;

  /**
   * option A properties object
   */
  optionAProperties?: ExternalNetworkPatchPropertiesOptionAProperties;
}

/**
 * option A properties object
 */
model ExternalNetworkPatchPropertiesOptionAProperties {
  ...Layer3IpPrefixProperties;
  ...L3OptionAProperties;
}

/**
 * List of External Networks.
 */
model ExternalNetworksList is Azure.Core.Page<ExternalNetwork>;

/**
 * Neighbor Group Properties defines the properties of the resource.
 */
model NeighborGroupProperties {
  ...AnnotationResource;
  ...NeighborGroupPatchableProperties;

  /**
   * List of NetworkTap IDs where neighbor group is associated.
   */
  @visibility(Lifecycle.Read)
  networkTapIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTaps";
    }
  ]>[];

  /**
   * List of Network Tap Rule IDs where neighbor group is associated.
   */
  @visibility(Lifecycle.Read)
  networkTapRuleIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTapRules";
    }
  ]>[];

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Neighbor Group Patchable Properties defines the patchable properties of the resource.
 */
model NeighborGroupPatchableProperties {
  /**
   * An array of destination IPv4 Addresses or IPv6 Addresses.
   */
  destination?: NeighborGroupDestination;
}

/**
 * An array of destination IPv4 Addresses or IPv6 Addresses.
 */
model NeighborGroupDestination {
  /**
   * Array of IPv4 Addresses.
   */
  ipv4Addresses?: string[];

  /**
   * Array of IPv6 Addresses.
   */
  ipv6Addresses?: string[];
}

/**
 * The Neighbor Group Patch definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NeighborGroupPatch extends TagsUpdate {
  /**
   * Neighbor Group Patch properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: NeighborGroupPatchProperties;
}

/**
 * Neighbor Group Patch properties.
 */
model NeighborGroupPatchProperties {
  ...AnnotationResource;
  ...NeighborGroupPatchableProperties;
}

/**
 * Network Device SKU Properties defines the properties of the resource.
 */
model NetworkDeviceSkuProperties {
  /**
   * Model of the network device.
   */
  `model`: string;

  /**
   * Manufacturer of the network device.
   */
  manufacturer?: string;

  /**
   * List of supported version details of network device.
   */
  @OpenAPI.extension("x-ms-identifiers", #["version"])
  supportedVersions?: SupportedVersionProperties[];

  /**
   * Available roles for the network device.
   */
  supportedRoleTypes?: NetworkDeviceRoleName[];

  /**
   * List of network device interfaces.
   */
  @OpenAPI.extension("x-ms-identifiers", #["identifier"])
  interfaces?: DeviceInterfaceProperties[];

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Supported version details of the network device.
 */
model SupportedVersionProperties {
  /**
   * Operating system and firmware combined versions.
   */
  version?: string;

  /**
   * Operating system version.
   */
  vendorOsVersion?: string;

  /**
   * Firmware version.
   */
  vendorFirmwareVersion?: string;

  /**
   * If true newly provisioned Fabric will use this device version by default to bootstrap the network devices for the first time.
   */
  isDefault?: BooleanEnumProperty;
}

/**
 * Network device interface properties.
 */
model DeviceInterfaceProperties {
  /**
   * Interface identifier. Example: HundredGigE0/0.
   */
  identifier?: string;

  /**
   * Interface type.
   */
  interfaceType?: string;

  /**
   * List of supported connector types.
   */
  @OpenAPI.extension("x-ms-identifiers", #["connectorType"])
  supportedConnectorTypes?: SupportedConnectorProperties[];
}

/**
 * Supported connector properties.
 */
model SupportedConnectorProperties {
  /**
   * Type of connector used. Example: Optical.
   */
  connectorType?: string;

  /**
   * Maximum speed of the connector in Mbps.
   */
  maxSpeedInMbps?: int32;
}

/**
 * Network Device Properties defines the properties of the resource.
 */
model NetworkDeviceProperties {
  ...AnnotationResource;
  ...NetworkDevicePatchableProperties;

  /**
   * Current version of the device as defined in SKU.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Network Device SKU name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkDeviceSku?: string;

  /**
   * NetworkDeviceRole is the device role: Example: CE | ToR.
   */
  @visibility(Lifecycle.Read)
  networkDeviceRole?: NetworkDeviceRole;

  /**
   * Reference to network rack resource id.
   */
  @visibility(Lifecycle.Read)
  networkRackId?: string;

  /**
   * Management IPv4 Address.
   */
  @visibility(Lifecycle.Read)
  managementIpv4Address?: string;

  /**
   * Management IPv6 Address.
   */
  @visibility(Lifecycle.Read)
  managementIpv6Address?: string;

  /**
   * Configuration state of the resource.
   */
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Administrative state of the resource.
   */
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;
}

/**
 * Network Device updatable properties.
 */
model NetworkDevicePatchableProperties {
  /**
   * The host name of the device.
   */
  @minLength(1)
  hostName?: string;

  /**
   * Serial number of the device. Format of serial Number - Make;Model;HardwareRevisionId;SerialNumber.
   */
  @minLength(1)
  serialNumber?: string;
}

/**
 * The Network Device Patch Parameters defines the patch parameters of the resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NetworkDevicePatchParameters extends TagsUpdate {
  /**
   * Network Device Patch properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: NetworkDevicePatchParametersProperties;
}

/**
 * Network Device Patch properties.
 */
model NetworkDevicePatchParametersProperties {
  ...AnnotationResource;
  ...NetworkDevicePatchableProperties;
}

/**
 * Network Interface Properties defines the properties of the resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NetworkInterfaceProperties extends AnnotationResource {
  /**
   * Physical Identifier of the network interface.
   */
  @visibility(Lifecycle.Read)
  physicalIdentifier?: string;

  /**
   * The ARM resource id of the interface or compute server its connected to.
   */
  @visibility(Lifecycle.Read)
  connectedTo?: string;

  /**
   * The Interface Type. Example: Management/Data
   */
  @visibility(Lifecycle.Read)
  interfaceType?: InterfaceType;

  /**
   * IPv4Address of the interface.
   */
  @visibility(Lifecycle.Read)
  ipv4Address?: string;

  /**
   * IPv6Address of the interface.
   */
  @visibility(Lifecycle.Read)
  ipv6Address?: string;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Administrative state of the resource.
   */
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;
}

/**
 * The NetworkInterfacePatch resource definition.
 */
model NetworkInterfacePatch {
  /**
   * Network Interface Patch properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: NetworkInterfacePatchProperties;
}

/**
 * Network Interface Patch properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NetworkInterfacePatchProperties extends AnnotationResource {}

/**
 * List of NetworkInterfaces.
 */
model NetworkInterfacesList is Azure.Core.Page<NetworkInterface>;

/**
 * Reboot properties.
 */
model RebootProperties {
  /**
   * Type of reboot to be performed. Example: GracefulRebootWithZTP
   */
  rebootType?: RebootType;
}

/**
 * Update the administrative state on list of resources.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model UpdateDeviceAdministrativeState extends EnableDisableOnResources {
  /**
   * Administrative state.
   */
  state?: DeviceAdministrativeState;
}

/**
 * Update version properties.
 */
model UpdateVersion {
  /**
   * Specify the version.
   */
  version?: string;
}

/**
 * NetworkFabricControllerProperties defines the resource properties.
 */
model NetworkFabricControllerProperties {
  ...AnnotationResource;
  ...NetworkFabricControllerPatchableProperties;

  /**
   * InfrastructureServices IP ranges.
   */
  @visibility(Lifecycle.Read)
  infrastructureServices?: ControllerServices;

  /**
   * WorkloadServices IP ranges.
   */
  @visibility(Lifecycle.Read)
  workloadServices?: ControllerServices;

  /**
   * Managed Resource Group configuration properties.
   */
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  /**
   * The NF-ID will be an input parameter used by the NF to link and get associated with the parent NFC Service.
   */
  @visibility(Lifecycle.Read)
  networkFabricIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>[];

  /**
   * A workload management network is required for all the tenant (workload) traffic. This traffic is only dedicated for Tenant workloads which are required to access internet or any other MSFT/Public endpoints. This is used for the backward compatibility.
   */
  @visibility(Lifecycle.Read)
  workloadManagementNetwork?: boolean = true;

  /**
   * A workload management network is required for all the tenant (workload) traffic. This traffic is only dedicated for Tenant workloads which are required to access internet or any other MSFT/Public endpoints.
   */
  isWorkloadManagementNetworkEnabled?: IsWorkloadManagementNetworkEnabled = IsWorkloadManagementNetworkEnabled.True;

  /**
   * List of tenant InternetGateway resource IDs
   */
  @visibility(Lifecycle.Read)
  tenantInternetGatewayIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/internetGateways";
    }
  ]>[];

  /**
   * IPv4 Network Fabric Controller Address Space.
   */
  @minLength(1)
  ipv4AddressSpace?: string = "10.0.0.0/19";

  /**
   * IPv6 Network Fabric Controller Address Space.
   */
  @minLength(1)
  ipv6AddressSpace?: string = "FC00::/59";

  /**
   * Network Fabric Controller SKU.
   */
  nfcSku?: NfcSku = NfcSku.Standard;

  /**
   * Provides you the latest status of the NFC service, whether it is Accepted, updating, Succeeded or Failed. During this process, the states keep changing based on the status of NFC provisioning.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Network Fabric Controller services.
 */
model ControllerServices {
  /**
   * The IPv4 Address space is optional, if the value is not defined at the time of NFC creation, then the default value 10.0.0.0/19 is considered. The IPV4 address subnet is an optional attribute.
   */
  ipv4AddressSpaces?: string[];

  /**
   * The IPv6 is not supported right now.
   */
  ipv6AddressSpaces?: string[];
}

/**
 * Managed Resource Group configuration properties.
 */
model ManagedResourceGroupConfiguration {
  /**
   * The NFC service will be hosted in a Managed resource group.
   */
  name?: string;

  /**
   * Managed resource group location.
   */
  location?: string;
}

/**
 * Network Fabric Controller updatable properties
 */
model NetworkFabricControllerPatchableProperties {
  /**
   * As part of an update, the Infrastructure ExpressRoute CircuitID should be provided to create and Provision a NFC. This Express route is dedicated for Infrastructure services. (This is a Mandatory attribute)
   */
  @OpenAPI.extension("x-ms-identifiers", #["expressRouteCircuitId"])
  infrastructureExpressRouteConnections?: ExpressRouteConnectionInformation[];

  /**
   * As part of an update, the workload ExpressRoute CircuitID should be provided to create and Provision a NFC. This Express route is dedicated for Workload services. (This is a Mandatory attribute).
   */
  @OpenAPI.extension("x-ms-identifiers", #["expressRouteCircuitId"])
  workloadExpressRouteConnections?: ExpressRouteConnectionInformation[];
}

/**
 * The ExpressRoute circuit ID and the Auth Key are required for you to successfully deploy NFC service.
 */
model ExpressRouteConnectionInformation {
  /**
   * The express route circuit Azure resource ID, must be of type Microsoft.Network/expressRouteCircuits/circuitName. The ExpressRoute Circuit is a mandatory attribute.
   */
  expressRouteCircuitId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/expressRouteCircuits";
    }
  ]>;

  /**
   * Authorization key for the circuit, must be of type Microsoft.Network/expressRouteCircuits/authorizations. The Auth Key is a mandatory attribute.
   */
  expressRouteAuthorizationKey: string;
}

/**
 * The Network Fabric Controller Patch payload definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NetworkFabricControllerPatch extends TagsUpdate {
  /**
   * Network Fabric Controller patch properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: NetworkFabricControllerPatchableProperties;
}

/**
 * Network Fabric SKU Properties define properties of the resource.
 */
model NetworkFabricSkuProperties {
  /**
   * Type of Network Fabric SKU.
   */
  @visibility(Lifecycle.Read)
  type?: FabricSkuType;

  /**
   * Maximum number of compute racks available for this Network Fabric SKU. The value of max count racks is 4 for 4 rack SKU and 8 for 8 rack SKU.
   */
  maxComputeRacks?: int32;

  /**
   * Maximum number of servers available for this Network Fabric SKU.
   */
  maximumServerCount?: int32;

  /**
   * List of supported Network Fabric SKU versions.
   */
  @visibility(Lifecycle.Read)
  supportedVersions?: string[];

  /**
   * URL providing detailed configuration of the fabric SKU.
   */
  @visibility(Lifecycle.Read)
  details?: string;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Network Fabric Properties defines the properties of the resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NetworkFabricProperties extends AnnotationResource {
  /**
   * Supported Network Fabric SKU.Example: Compute / Aggregate racks. Once the user chooses a particular SKU, only supported racks can be added to the Network Fabric. The SKU determines whether it is a single / multi rack Network Fabric.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  networkFabricSku: string;

  /**
   * The version of Network Fabric.
   */
  @minLength(1)
  fabricVersion?: string;

  /**
   * Array of router IDs.
   */
  @visibility(Lifecycle.Read)
  routerIds?: string[];

  /**
   * Azure resource ID for the NetworkFabricController the NetworkFabric belongs.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkFabricControllerId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabricControllers";
    }
  ]>;

  /**
   * Number of compute racks associated to Network Fabric.
   */
  @maxValue(8)
  @minValue(1)
  rackCount?: int32;

  /**
   * Number of servers.Possible values are from 1-16.
   */
  @maxValue(16)
  @minValue(1)
  serverCountPerRack: int32;

  /**
   * IPv4Prefix for Management Network. Example: 10.1.0.0/19.
   */
  @minLength(1)
  ipv4Prefix: string;

  /**
   * IPv6Prefix for Management Network. Example: 3FFE:FFFF:0:CD40::/59
   */
  @minLength(1)
  ipv6Prefix?: string;

  /**
   * ASN of CE devices for CE/PE connectivity.
   */
  @maxValue(4294967295)
  @minValue(1)
  fabricASN: int64;

  /**
   * Network and credentials configuration currently applied to terminal server.
   */
  terminalServerConfiguration: TerminalServerConfiguration;

  /**
   * Configuration to be used to setup the management network.
   */
  managementNetworkConfiguration: ManagementNetworkConfigurationProperties;

  /**
   * List of NetworkRack resource IDs under the Network Fabric. The number of racks allowed depends on the Network Fabric SKU.
   */
  @visibility(Lifecycle.Read)
  racks?: string[];

  /**
   * List of L2 Isolation Domain resource IDs under the Network Fabric.
   */
  @visibility(Lifecycle.Read)
  l2IsolationDomains?: string[];

  /**
   * List of L3 Isolation Domain resource IDs under the Network Fabric.
   */
  @visibility(Lifecycle.Read)
  l3IsolationDomains?: string[];

  /**
   * Configuration state of the resource.
   */
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  /**
   * Provides you the latest status of the NFC service, whether it is Accepted, updating, Succeeded or Failed. During this process, the states keep changing based on the status of NFC provisioning.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Administrative state of the resource.
   */
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;
}

/**
 * Network and credentials configuration currently applied to terminal server.
 */
model TerminalServerConfiguration {
  ...TerminalServerPatchableProperties;
  ...Layer3IpPrefixProperties;

  /**
   * ARM Resource ID used for the NetworkDevice.
   */
  @visibility(Lifecycle.Read)
  networkDeviceId?: string;
}

/**
 * Network and credential configuration currently applied on terminal server.
 */
model TerminalServerPatchableProperties {
  /**
   * Username for the terminal server connection.
   */
  @minLength(1)
  username?: string;

  /**
   * Password for the terminal server connection.
   */
  @minLength(1)
  password?: string;

  /**
   * Serial Number of Terminal server.
   */
  @minLength(1)
  serialNumber?: string;
}

/**
 * Configuration to be used to setup the management network.
 */
model ManagementNetworkConfigurationProperties {
  /**
   * VPN Configuration properties.
   */
  infrastructureVpnConfiguration: VpnConfigurationProperties;

  /**
   * VPN Configuration properties.
   */
  workloadVpnConfiguration: VpnConfigurationProperties;
}

/**
 * Network and credential configuration currently applied on terminal server.
 */
model VpnConfigurationProperties {
  /**
   * ARM Resource ID of the Network To Network Interconnect.
   */
  networkToNetworkInterconnectId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics/networkToNetworkInterconnects";
    }
  ]>;

  /**
   * Administrative state of the resource.
   */
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;

  /**
   * Peering option list.
   */
  peeringOption: PeeringOption;

  /**
   * option B properties
   */
  optionBProperties?: OptionBProperties;

  /**
   * option A properties
   */
  optionAProperties?: VpnConfigurationPropertiesOptionAProperties;
}

/**
 * Option B configuration to be used for Management VPN.
 */
model OptionBProperties {
  /**
   * Route Targets to be applied for incoming routes into CE. This is for backward compatibility.
   */
  importRouteTargets?: string[];

  /**
   * Route Targets to be applied for outgoing routes from CE. This is for backward compatibility.
   */
  exportRouteTargets?: string[];

  /**
   * Route Targets to be applied.
   */
  routeTargets?: RouteTargetInformation;
}

/**
 * option A properties
 */
model VpnConfigurationPropertiesOptionAProperties {
  ...OptionAProperties;
  ...Layer3IpPrefixProperties;
}

/**
 * Peering optionA properties
 */
model OptionAProperties {
  /**
   * MTU to use for option A peering.
   */
  @maxValue(9200)
  @minValue(64)
  mtu?: int32 = 1500;

  /**
   * Vlan Id.Example : 501
   */
  @maxValue(4094)
  @minValue(501)
  vlanId?: int32;

  /**
   * Peer ASN number.Example : 28
   */
  @maxValue(4294967295)
  @minValue(1)
  peerASN?: int64;

  /**
   * BFD Configuration properties.
   */
  bfdConfiguration?: BfdConfiguration;
}

/**
 * The Network Fabric resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NetworkFabricPatch extends TagsUpdate {
  /**
   * Network Fabric Patch properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: NetworkFabricPatchProperties;
}

/**
 * Network Fabric Patch properties.
 */
model NetworkFabricPatchProperties {
  ...AnnotationResource;
  ...NetworkFabricPatchableProperties;
}

/**
 * Network Fabric updatable properties.
 */
model NetworkFabricPatchableProperties {
  /**
   * Number of compute racks associated to Network Fabric.
   */
  @maxValue(8)
  @minValue(1)
  rackCount?: int32;

  /**
   * Number of servers.Possible values are from 1-16.
   */
  @maxValue(16)
  @minValue(1)
  serverCountPerRack?: int32;

  /**
   * IPv4Prefix for Management Network. Example: 10.1.0.0/19.
   */
  @minLength(1)
  ipv4Prefix?: string;

  /**
   * IPv6Prefix for Management Network. Example: 3FFE:FFFF:0:CD40::/59.
   */
  @minLength(1)
  ipv6Prefix?: string;

  /**
   * ASN of CE devices for CE/PE connectivity.
   */
  @maxValue(4294967295)
  @minValue(1)
  fabricASN?: int64;

  /**
   * Network and credentials configuration already applied to terminal server.
   */
  terminalServerConfiguration?: NetworkFabricPatchablePropertiesTerminalServerConfiguration;

  /**
   * Configuration to be used to setup the management network.
   */
  managementNetworkConfiguration?: ManagementNetworkConfigurationPatchableProperties;
}

/**
 * Network and credentials configuration already applied to terminal server.
 */
model NetworkFabricPatchablePropertiesTerminalServerConfiguration {
  ...TerminalServerPatchableProperties;
  ...Layer3IpPrefixProperties;
}

/**
 * Configuration to be used to setup the management network.
 */
model ManagementNetworkConfigurationPatchableProperties {
  /**
   * VPN Configuration properties.
   */
  infrastructureVpnConfiguration?: VpnConfigurationPatchableProperties;

  /**
   * VPN Configuration properties.
   */
  workloadVpnConfiguration?: VpnConfigurationPatchableProperties;
}

/**
 * Network and credential configuration currently applied on terminal server.
 */
model VpnConfigurationPatchableProperties {
  /**
   * ARM Resource ID of the Network To Network Interconnect.
   */
  networkToNetworkInterconnectId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics/networkToNetworkInterconnects";
    }
  ]>;

  /**
   * Peering option list.
   */
  peeringOption?: PeeringOption;

  /**
   * option B properties
   */
  optionBProperties?: OptionBProperties;

  /**
   * option A properties
   */
  optionAProperties?: VpnConfigurationPatchablePropertiesOptionAProperties;
}

/**
 * option A properties
 */
model VpnConfigurationPatchablePropertiesOptionAProperties {
  ...OptionAProperties;
  ...Layer3IpPrefixProperties;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model UpgradeNetworkFabricProperties extends UpdateVersion {
  /**
   * Action to be performed while upgrading the fabric.
   */
  action?: NetworkFabricUpgradeAction;
}

/**
 * Validation configuration properties.
 */
model ValidateConfigurationProperties {
  /**
   * Validate action that to be performed
   */
  validateAction?: ValidateAction;
}

/**
 * Configuration used to setup CE-PE connectivity.
 */
model NetworkToNetworkInterconnectProperties {
  /**
   * Type of NNI used. Example: CE | NPB
   */
  nniType?: NniType = NniType.CE;

  /**
   * Configuration to use NNI for Infrastructure Management. Example: True/False.
   */
  isManagementType?: IsManagementType = IsManagementType.True;

  /**
   * Based on this option layer3 parameters are mandatory. Example: True/False
   */
  useOptionB: BooleanEnumProperty;

  /**
   * Common properties for Layer2 Configuration.
   */
  layer2Configuration?: Layer2Configuration;

  /**
   * Common properties for Layer3Configuration.
   */
  optionBLayer3Configuration?: NetworkToNetworkInterconnectPropertiesOptionBLayer3Configuration;

  /**
   * NPB Static Route Configuration properties.
   */
  npbStaticRouteConfiguration?: NpbStaticRouteConfiguration;

  /**
   * Import Route Policy configuration.
   */
  importRoutePolicy?: ImportRoutePolicyInformation;

  /**
   * Export Route Policy configuration.
   */
  exportRoutePolicy?: ExportRoutePolicyInformation;

  /**
   * Egress Acl. ARM resource ID of Access Control Lists.
   */
  egressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  /**
   * Ingress Acl. ARM resource ID of Access Control Lists.
   */
  ingressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  /**
   * Configuration state of the resource.
   */
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Administrative state of the resource.
   */
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;
}

/**
 * Common properties for Layer2 Configuration.
 */
model Layer2Configuration {
  /**
   * MTU of the packets between PE & CE.
   */
  @maxValue(9200)
  @minValue(64)
  mtu?: int32 = 1500;

  /**
   * List of network device interfaces resource IDs.
   */
  interfaces?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices/networkInterfaces";
    }
  ]>[];
}

/**
 * Common properties for Layer3Configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NetworkToNetworkInterconnectPropertiesOptionBLayer3Configuration
  extends OptionBLayer3Configuration {}

/**
 * OptionB Layer3 Configuration properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model OptionBLayer3Configuration extends Layer3IpPrefixProperties {
  /**
   * ASN of PE devices for CE/PE connectivity.Example : 28
   */
  @maxValue(4294967295)
  @minValue(1)
  peerASN?: int64;

  /**
   * VLAN for CE/PE Layer 3 connectivity.Example : 501
   */
  @maxValue(4094)
  @minValue(100)
  vlanId?: int32;

  /**
   * ASN of CE devices for CE/PE connectivity.
   */
  @visibility(Lifecycle.Read)
  fabricASN?: int64;
}

/**
 * NPB Static Route Configuration properties.
 */
model NpbStaticRouteConfiguration {
  /**
   * BFD Configuration properties.
   */
  bfdConfiguration?: BfdConfiguration;

  /**
   * List of IPv4 Routes.
   */
  @OpenAPI.extension("x-ms-identifiers", #["prefix"])
  ipv4Routes?: StaticRouteProperties[];

  /**
   * List of IPv6 Routes.
   */
  @OpenAPI.extension("x-ms-identifiers", #["prefix"])
  ipv6Routes?: StaticRouteProperties[];
}

/**
 * Import Route Policy Configuration.
 */
model ImportRoutePolicyInformation {
  /**
   * Import IPv4 Route Policy Id.
   */
  importIpv4RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  /**
   * Import IPv6 Route Policy Id.
   */
  importIpv6RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;
}

/**
 * Export Route Policy Configuration.
 */
model ExportRoutePolicyInformation {
  /**
   * Export IPv4 Route Policy Id.
   */
  exportIpv4RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;

  /**
   * Export IPv6 Route Policy Id.
   */
  exportIpv6RoutePolicyId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/routePolicies";
    }
  ]>;
}

/**
 * The Network To Network Interconnect resource patch definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NetworkToNetworkInterconnectPatch extends ProxyResource {
  /**
   * Resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: NetworkToNetworkInterconnectPatchableProperties;
}

/**
 * Network to Network Interconnect patchable properties.
 */
model NetworkToNetworkInterconnectPatchableProperties {
  /**
   * Common properties for Layer2Configuration.
   */
  layer2Configuration?: Layer2Configuration;

  /**
   * Common properties for Layer3Configuration.
   */
  optionBLayer3Configuration?: OptionBLayer3Configuration;

  /**
   * NPB Static Route Configuration properties.
   */
  npbStaticRouteConfiguration?: NpbStaticRouteConfiguration;

  /**
   * Import Route Policy information.
   */
  importRoutePolicy?: ImportRoutePolicyInformation;

  /**
   * Export Route Policy information
   */
  exportRoutePolicy?: ExportRoutePolicyInformation;

  /**
   * Egress Acl. ARM resource ID of Access Control Lists.
   */
  egressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;

  /**
   * Ingress Acl. ARM resource ID of Access Control Lists.
   */
  ingressAclId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>;
}

/**
 * List of Network To Network Interconnects.
 */
model NetworkToNetworkInterconnectsList
  is Azure.Core.Page<NetworkToNetworkInterconnect>;

/**
 * Network Packet Broker Properties defines the properties of the resource.
 */
model NetworkPacketBrokerProperties {
  /**
   * ARM resource ID of the Network Fabric.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkFabricId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  /**
   * List of ARM resource IDs of Network Devices [NPB].
   */
  @visibility(Lifecycle.Read)
  networkDeviceIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices";
    }
  ]>[];

  /**
   * List of network interfaces across NPB devices that are used to mirror source traffic.
   */
  @visibility(Lifecycle.Read)
  sourceInterfaceIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices/networkInterfaces";
    }
  ]>[];

  /**
   * List of network Tap IDs configured on NPB.
   */
  @visibility(Lifecycle.Read)
  networkTapIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTaps";
    }
  ]>[];

  /**
   * List of neighbor group IDs configured on NPB.
   */
  @visibility(Lifecycle.Read)
  neighborGroupIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTaps";
    }
  ]>[];

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The NetworkPacketBroker patch resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NetworkPacketBrokerPatch extends TagsUpdate {}

/**
 * Network Rack Properties defines the properties of the resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NetworkRackProperties extends AnnotationResource {
  /**
   * Network Rack SKU name.
   */
  networkRackType?: NetworkRackType;

  /**
   * ARM resource ID of the Network Fabric.
   */
  networkFabricId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  /**
   * List of network device ARM resource IDs.
   */
  @visibility(Lifecycle.Read)
  networkDevices?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkDevices";
    }
  ]>[];

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Network Tap Rule Properties defines the resource properties.
 */
model NetworkTapRuleProperties {
  ...AnnotationResource;
  ...NetworkTapRulePatchableProperties;

  /**
   * The ARM resource Id of the NetworkTap.
   */
  @visibility(Lifecycle.Read)
  networkTapId?: string;

  /**
   * Polling interval in seconds.
   */
  pollingIntervalInSeconds?: PollingIntervalInSeconds;

  /**
   * The last sync timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncedTime?: utcDateTime;

  /**
   * Configuration state of the resource.
   */
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Administrative state of the resource.
   */
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;
}

/**
 * Network Tap Rule updatable properties.
 */
model NetworkTapRulePatchableProperties {
  /**
   * Input method to configure Network Tap Rule.
   */
  configurationType?: ConfigurationType;

  /**
   * Network Tap Rules file URL.
   */
  tapRulesUrl?: url;

  /**
   * List of match configurations.
   */
  matchConfigurations?: NetworkTapRuleMatchConfiguration[];

  /**
   * List of dynamic match configurations.
   */
  dynamicMatchConfigurations?: CommonDynamicMatchConfiguration[];
}

/**
 * Defines the match configuration that are supported to filter the traffic.
 */
model NetworkTapRuleMatchConfiguration {
  /**
   * The name of the match configuration.
   */
  @minLength(1)
  matchConfigurationName?: string;

  /**
   * Sequence Number of the match configuration..
   */
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber?: int64;

  /**
   * Type of IP Address. IPv4 or IPv6
   */
  ipAddressType?: IPAddressType;

  /**
   * List of the match conditions.
   */
  matchConditions?: NetworkTapRuleMatchCondition[];

  /**
   * List of actions that need to be performed for the matched conditions.
   */
  actions?: NetworkTapRuleAction[];
}

/**
 * Defines the match condition that is supported to filter the traffic.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NetworkTapRuleMatchCondition extends CommonMatchConditions {
  /**
   * Encapsulation Type that needs to be matched.
   */
  encapsulationType?: EncapsulationType = EncapsulationType.None;

  /**
   * Defines the port condition that needs to be matched.
   */
  portCondition?: PortCondition;
}

/**
 * Action that need to performed.
 */
model NetworkTapRuleAction {
  /**
   * Type of actions that can be performed.
   */
  type?: TapRuleActionType;

  /**
   * Truncate. 0 indicates do not truncate.
   */
  @minLength(1)
  truncate?: string;

  /**
   * The parameter to enable or disable the timestamp.
   */
  isTimestampEnabled?: BooleanEnumProperty;

  /**
   * Destination Id. The ARM resource Id may be either Network To Network Interconnect or NeighborGroup.
   */
  destinationId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/neighborGroups";
    },
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics/networkToNetworkInterconnects";
    }
  ]>;

  /**
   * The name of the match configuration. This is used when Goto type is provided. If Goto type is selected and no match configuration name is provided. It goes to next configuration.
   */
  @minLength(1)
  matchConfigurationName?: string;
}

/**
 * The NetworkTapRule resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NetworkTapRulePatch extends TagsUpdate {
  /**
   * Network Tap Rule Patch properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: NetworkTapRulePatchProperties;
}

/**
 * Network Tap Rule Patch properties.
 */
model NetworkTapRulePatchProperties {
  ...AnnotationResource;
  ...NetworkTapRulePatchableProperties;
}

/**
 * Network Tap Properties defines the properties of the resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NetworkTapProperties extends AnnotationResource {
  /**
   * ARM resource ID of the Network Packet Broker.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkPacketBrokerId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  /**
   * Source Tap Rule Id. ARM Resource ID of the Network Tap Rule.
   */
  @visibility(Lifecycle.Read)
  sourceTapRuleId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTapRules";
    }
  ]>;

  /**
   * List of destinations to send the filter traffic.
   */
  destinations: NetworkTapPropertiesDestinationsItem[];

  /**
   * Polling type.
   */
  pollingType?: PollingType;

  /**
   * Gets the configurations state of the resource.
   */
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  /**
   * Provides you the latest status of the NFC service, whether it is Accepted, updating, Succeeded or Failed. During this process, the states keep changing based on the status of Network Tap provisioning.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Administrative state of the resource. Example -Enabled/Disabled
   */
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;
}

/**
 * Destination.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NetworkTapPropertiesDestinationsItem extends DestinationProperties {}

/**
 * The network tap destination properties.
 */
model DestinationProperties {
  /**
   * Destination name.
   */
  @minLength(1)
  name?: string;

  /**
   * Type of destination. Input can be IsolationDomain or Direct.
   */
  destinationType?: DestinationType;

  /**
   * The destination Id. ARM Resource ID of either NNI or Internal Networks.
   */
  destinationId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkToNetworkInterconnects";
    },
    {
      type: "Microsoft.ManagedNetworkFabric/l3IsolationDomains/internalNetworks";
    }
  ]>;

  /**
   * Isolation Domain Properties.
   */
  isolationDomainProperties?: IsolationDomainProperties;

  /**
   * ARM Resource ID of destination Tap Rule that contains match configurations.
   */
  destinationTapRuleId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTapRules";
    }
  ]>;
}

/**
 * Isolation Domain Properties.
 */
model IsolationDomainProperties {
  /**
   * Type of encapsulation.
   */
  encapsulation?: Encapsulation;

  /**
   * List of Neighbor Group IDs.
   */
  neighborGroupIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/neighborGroups";
    }
  ]>[];
}

/**
 * The NetworkFabric resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NetworkTapPatch extends TagsUpdate {
  /**
   * Resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: NetworkTapPatchableParameters;
}

/**
 * The Network Tap resource patch definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NetworkTapPatchableParameters extends AnnotationResource {
  /**
   * Polling type.
   */
  pollingType?: PollingType;

  /**
   * List of destination properties to send the filter traffic.
   */
  destinations?: NetworkTapPatchableParametersDestinationsItem[];
}

/**
 * Destination.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NetworkTapPatchableParametersDestinationsItem
  extends DestinationProperties {}

/**
 * RoutePolicyProperties defines the resource properties.
 */
model RoutePolicyProperties {
  ...AnnotationResource;
  ...RoutePolicyPatchableProperties;

  /**
   * Arm Resource ID of Network Fabric.
   */
  networkFabricId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>;

  /**
   * AddressFamilyType. This parameter decides whether the given ipv4 or ipv6 route policy.
   */
  addressFamilyType?: AddressFamilyType = AddressFamilyType.IPv4;

  /**
   * Configuration state of the resource.
   */
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Administrative state of the resource.
   */
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;
}

/**
 * Route Policy patchable properties.
 */
model RoutePolicyPatchableProperties {
  /**
   * Default action that needs to be applied when no condition is matched. Example: Permit | Deny.
   */
  defaultAction?: CommunityActionTypes;

  /**
   * Route Policy statements.
   */
  @OpenAPI.extension("x-ms-identifiers", #["sequenceNumber"])
  statements?: RoutePolicyStatementProperties[];
}

/**
 * Route Policy Statement properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RoutePolicyStatementProperties extends AnnotationResource {
  /**
   * Sequence to insert to/delete from existing route.
   */
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber: int64;

  /**
   * Route policy condition properties.
   */
  condition: StatementConditionProperties;

  /**
   * Route policy action properties.
   */
  action: StatementActionProperties;
}

/**
 * Route policy statement condition properties.
 */
model StatementConditionProperties {
  ...IpCommunityIdList;
  ...IpExtendedCommunityIdList;

  /**
   * Type of the condition used.
   */
  type?: RoutePolicyConditionType = RoutePolicyConditionType.Or;

  /**
   * Arm Resource Id of IpPrefix.
   */
  ipPrefixId?: string;
}

/**
 * IP Community ID list properties.
 */
model IpCommunityIdList {
  /**
   * List of IP Community resource IDs.
   */
  ipCommunityIds?: string[];
}

/**
 * IP Extended Community Id list properties.
 */
model IpExtendedCommunityIdList {
  /**
   * List of IP Extended Community resource IDs.
   */
  ipExtendedCommunityIds?: string[];
}

/**
 * Route policy action properties.
 */
model StatementActionProperties {
  /**
   * Local Preference of the route policy.
   */
  @maxValue(4294967295)
  localPreference?: int64;

  /**
   * Action type. Example: Permit | Deny | Continue.
   */
  actionType: RoutePolicyActionType;

  /**
   * IP Community Properties.
   */
  ipCommunityProperties?: ActionIpCommunityProperties;

  /**
   * IP Extended Community Properties.
   */
  ipExtendedCommunityProperties?: ActionIpExtendedCommunityProperties;
}

/**
 * IP Community Properties.
 */
model ActionIpCommunityProperties {
  ...IpCommunityAddOperationProperties;
  ...IpCommunityDeleteOperationProperties;
  ...IpCommunitySetOperationProperties;
}

/**
 * IP Community add operation properties.
 */
model IpCommunityAddOperationProperties {
  /**
   * List of IP Community IDs.
   */
  add?: IpCommunityIdList;
}

/**
 * IP Community delete operation properties.
 */
model IpCommunityDeleteOperationProperties {
  /**
   * List of IP Community IDs.
   */
  delete?: IpCommunityIdList;
}

/**
 * IP Community set operation properties.
 */
model IpCommunitySetOperationProperties {
  /**
   * List of IP Community IDs.
   */
  set?: IpCommunityIdList;
}

/**
 * IP Extended Community Properties.
 */
model ActionIpExtendedCommunityProperties {
  ...IpExtendedCommunityAddOperationProperties;
  ...IpExtendedCommunityDeleteOperationProperties;
  ...IpExtendedCommunitySetOperationProperties;
}

/**
 * IP Extended Community add operation properties.
 */
model IpExtendedCommunityAddOperationProperties {
  /**
   * List of IP Extended Community IDs.
   */
  add?: IpExtendedCommunityIdList;
}

/**
 * IP Extended Community delete operation properties.
 */
model IpExtendedCommunityDeleteOperationProperties {
  /**
   * List of IP Extended Community IDs.
   */
  delete?: IpExtendedCommunityIdList;
}

/**
 * IP Extended Community set operation properties.
 */
model IpExtendedCommunitySetOperationProperties {
  /**
   * List of IP Extended Community IDs.
   */
  set?: IpExtendedCommunityIdList;
}

/**
 * The Route Policy patch resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RoutePolicyPatch extends TagsUpdate {
  /**
   * The RoutePolicy patchable properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: RoutePolicyPatchableProperties;
}

/**
 * The extended location.
 */
model ExtendedLocation {
  /**
   * The extended location type.
   */
  type?: string;

  /**
   * The extended location name.
   */
  name?: string;
}
