import "./common.tsp";
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;

@doc("Access Control List Properties defines the resource properties.")
model AccessControlListProperties {
  ...AnnotationResource;

  @doc("Input method to configure Access Control List.")
  configurationType: ConfigurationType;

  @doc("Access Control List file URL.")
  aclsUrl?: url;

  @doc("Default action that needs to be applied when no condition is matched. Example: Permit | Deny.")
  defaultAction?: CommunityActionTypes = CommunityActionTypes.Permit;

  @Azure.ResourceManager.identifiers(#[])
  @doc("List of match configurations.")
  @minItems(1)
  matchConfigurations?: AccessControlListMatchConfiguration[];

  @Azure.ResourceManager.identifiers(#[])
  @doc("List of dynamic match configurations.")
  @minItems(1)
  dynamicMatchConfigurations?: CommonDynamicMatchConfiguration[];

  @doc("The last synced timestamp.")
  @visibility(Lifecycle.Read)
  lastSyncedTime?: utcDateTime;

  @doc("Access Control List (ACL) Type")
  @added(Versions.v2024_06_15_preview)
  aclType?: AclType;

  @doc("Device Role")
  @added(Versions.v2024_06_15_preview)
  deviceRole?: DeviceRole;

  @doc("Global Access Control List (ACL) actions")
  @added(Versions.v2024_06_15_preview)
  globalAccessControlListActions?: GlobalAccessControlListActionProperties;

  @doc("Details of the last operation performed on the resource")
  @visibility(Lifecycle.Read)
  @added(Versions.v2024_06_15_preview)
  lastOperation?: LastOperationProperties;

  @doc("Associated Network Fabric Resource IDs")
  @added(Versions.v2025_07_15)
  @visibility(Lifecycle.Read)
  networkFabricIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics";
    }
  ]>[];

  @doc("Access Control List (ACL) configurations.")
  @Azure.ResourceManager.identifiers(#[])
  @added(Versions.v2025_07_15)
  controlPlaneAclConfiguration?: ControlPlaneAclProperties[];

  @doc("Configuration state of the resource.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;
}

@doc("Defines the match configuration that are supported to filter the traffic.")
model AccessControlListMatchConfiguration {
  @doc("The name of the match configuration.")
  @minLength(1)
  matchConfigurationName?: string;

  @doc("Sequence Number of the match configuration.")
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber?: int64;

  @doc("Type of IP Address. IPv4 or IPv6")
  ipAddressType?: IPAddressType;

  @Azure.ResourceManager.identifiers(#[])
  @doc("List of the match conditions.")
  @minItems(1)
  matchConditions?: AccessControlListMatchCondition[];

  @Azure.ResourceManager.identifiers(#[])
  @doc("List of actions that need to be performed for the matched conditions.")
  @minItems(1)
  actions?: AccessControlListAction[];
}

@doc("Defines the match configuration that are supported to filter the traffic.")
model AccessControlListMatchConfigurationPatch {
  @doc("The name of the match configuration.")
  @minLength(1)
  matchConfigurationName?: string;

  @doc("Sequence Number of the match configuration.")
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber?: int64;

  @doc("Type of IP Address. IPv4 or IPv6")
  ipAddressType?: IPAddressType;

  @Azure.ResourceManager.identifiers(#[])
  @doc("List of the match conditions.")
  @minItems(1)
  matchConditions?: AccessControlListMatchConditionPatch[];

  @Azure.ResourceManager.identifiers(#[])
  @doc("List of actions that need to be performed for the matched conditions.")
  @minItems(1)
  actions?: AccessControlListActionPatch[];
}

@doc("Defines the match condition that is supported to filter the traffic.")
model AccessControlListMatchCondition {
  ...CommonMatchConditions;

  @doc("List of ether type values that need to be matched.")
  @minItems(1)
  etherTypes?: string[];

  @doc("List of IP fragment packets that need to be matched.")
  @minItems(1)
  fragments?: string[];

  @doc("List of IP Lengths that need to be matched.")
  @minItems(1)
  ipLengths?: string[];

  @doc("List of TTL [Time To Live] values that need to be matched.")
  @minItems(1)
  ttlValues?: string[];

  @doc("List of DSCP Markings that need to be matched.")
  @minItems(1)
  dscpMarkings?: string[];

  @doc("Protocol neighbors that need to be matched.")
  @added(Versions.v2024_06_15_preview)
  protocolNeighbors?: string[];

  @doc("Defines the port condition that needs to be matched.")
  portCondition?: AccessControlListPortCondition;

  @doc("Internet Control Message Protocol (ICMP) configuration")
  @added(Versions.v2024_06_15_preview)
  icmpConfiguration?: IcmpConfigurationProperties;
}

@doc("Defines the match condition that is supported to filter the traffic.")
model AccessControlListMatchConditionPatch {
  ...CommonMatchConditionsPatch;

  @doc("List of ether type values that need to be matched.")
  @minItems(1)
  etherTypes?: string[];

  @doc("List of IP fragment packets that need to be matched.")
  @minItems(1)
  fragments?: string[];

  @doc("List of IP Lengths that need to be matched.")
  @minItems(1)
  ipLengths?: string[];

  @doc("List of TTL [Time To Live] values that need to be matched.")
  @minItems(1)
  ttlValues?: string[];

  @doc("List of DSCP Markings that need to be matched.")
  @minItems(1)
  dscpMarkings?: string[];

  @doc("Defines the port condition that needs to be matched.")
  portCondition?: AccessControlListPortConditionPatch;

  @doc("Protocol neighbors that need to be matched.")
  @added(Versions.v2024_06_15_preview)
  protocolNeighbors?: string[];

  @doc("Internet Control Message Protocol (ICMP) configuration")
  @added(Versions.v2024_06_15_preview)
  icmpConfiguration?: IcmpConfigurationPatchProperties;
}

@doc("Defines the port condition that needs to be matched.")
model AccessControlListPortCondition {
  ...PortCondition;

  @doc("List of protocol flags that need to be matched. Example: established | initial | <List-of-TCP-flags>. List of eligible TCP Flags are ack, fin, not-ack, not-fin, not-psh, not-rst, not-syn, not-urg, psh, rst, syn, urg")
  flags?: string[];
}

@doc("Defines the port condition that needs to be matched.")
model AccessControlListPortConditionPatch {
  ...PortConditionPatch;

  @doc("List of protocol flags that need to be matched. Example: established | initial | <List-of-TCP-flags>. List of eligible TCP Flags are ack, fin, not-ack, not-fin, not-psh, not-rst, not-syn, not-urg, psh, rst, syn, urg")
  flags?: string[];
}

@doc("Action that need to performed.")
model AccessControlListAction {
  @doc("Type of actions that can be performed.")
  type?: AclActionType;

  @doc("Name of the counter block to get match count information.")
  @minLength(1)
  counterName?: string;

  @doc("Remark comment")
  @added(Versions.v2024_06_15_preview)
  remarkComment?: string;

  @doc("Police rate configuration")
  @added(Versions.v2024_06_15_preview)
  policeRateConfiguration?: PoliceRateConfigurationProperties;
}

@doc("Action that need to be performed")
model AccessControlListActionPatch is AccessControlListAction;

@doc("The Access Control Lists patch resource definition.")
model AccessControlListPatch {
  ...TagsUpdate;

  @doc("Access Control Lists patch properties.")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "properties")
  propertiesDeprecated?: AccessControlListPatchProperties;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flattening"
  @doc("Access Control Lists patch properties.")
  @added(Versions.v2025_07_15)
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: AccessControlListPatchProperties;
}

@doc("Access Control Lists patch properties.")
model AccessControlListPatchProperties {
  @doc("Input method to configure Access Control List.")
  configurationType?: ConfigurationType;

  @doc("Access Control List file URL.")
  aclsUrl?: url;

  @doc("Default action that needs to be applied when no condition is matched. Example: Permit | Deny.")
  defaultAction?: CommunityActionTypes;

  @Azure.ResourceManager.identifiers(#[])
  @doc("List of match configurations.")
  @minItems(1)
  matchConfigurations?: AccessControlListMatchConfigurationPatch[];

  @Azure.ResourceManager.identifiers(#[])
  @doc("List of dynamic match configurations.")
  @minItems(1)
  dynamicMatchConfigurations?: CommonDynamicMatchConfigurationPatch[];

  @doc("Access Control List (ACL) configurations.")
  @Azure.ResourceManager.identifiers(#[])
  @added(Versions.v2025_07_15)
  controlPlaneAclConfiguration?: ControlPlaneAclPatchProperties[];

  @doc("Access Control List (ACL) Type")
  @added(Versions.v2024_06_15_preview)
  aclType?: AclType;

  @doc("Device Role")
  @added(Versions.v2024_06_15_preview)
  deviceRole?: DeviceRole;

  @doc("Global Access Control List (ACL) actions")
  @added(Versions.v2024_06_15_preview)
  globalAccessControlListActions?: GlobalAccessControlListActionPatchProperties;

  ...AnnotationResource;
}

@doc("Type of actions that can be performed.")
union AclActionType {
  @doc("AclActionType Drop")
  Drop: "Drop",

  @doc("AclActionType Count")
  Count: "Count",

  @doc("AclActionType Log")
  Log: "Log",

  @doc("AclActionType Remark")
  @added(Versions.v2024_06_15_preview)
  Remark: "Remark",

  @doc("AclActionType PoliceRate")
  @added(Versions.v2024_06_15_preview)
  PoliceRate: "PoliceRate",

  string,
}

@doc("Access Control List (ACL) Type")
@added(Versions.v2024_06_15_preview)
union AclType {
  @doc("AclType Control Plane Traffic Policy")
  Cp: "ControlPlaneTrafficPolicy",

  @doc("AclType Tenant")
  Tenant: "Tenant",

  @doc("AclType Management")
  Management: "Management",

  @doc("Control Plane Access Control List (ACL)")
  @added(Versions.v2025_07_15)
  ControlPlaneAcl: "ControlPlaneAcl",

  string,
}

@doc("Device Role")
@added(Versions.v2024_06_15_preview)
union DeviceRole {
  @doc("DeviceRole - Customer Edge (CE)")
  CE: "CE",

  @doc("DeviceRole - Top of Rack (ToR)")
  ToR: "ToR",

  @doc("DeviceRole - Network Packet Broker (NPB)")
  NPB: "NPB",

  @doc("Device Role Management Switch")
  ManagementSwitch: "ManagementSwitch",

  string,
}

@doc("Global Access Control List actions properties")
@added(Versions.v2024_06_15_preview)
model GlobalAccessControlListActionProperties {
  @doc("Configuration to enable or disable ACL action count.")
  enableCount?: BooleanEnumProperty = BooleanEnumProperty.False;
}

@doc("Global Access Control List actions patch properties")
@added(Versions.v2024_06_15_preview)
@withoutDefaultValues
model GlobalAccessControlListActionPatchProperties
  is GlobalAccessControlListActionProperties;

@doc("Internet Control Message Protocol (ICMP) configuration")
@added(Versions.v2024_06_15_preview)
model IcmpConfigurationProperties {
  @doc("Internet Control Message Protocol (ICMP) types")
  @minItems(1)
  icmpTypes?: string[];
}

@doc("Internet Control Message Protocol (ICMP) configuration patch properties")
@added(Versions.v2024_06_15_preview)
model IcmpConfigurationPatchProperties {
  @doc("Internet Control Message Protocol (ICMP) types")
  @minItems(1)
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "icmpTypes")
  icmpTypesDeprecated?: string[];

  @doc("Internet Control Message Protocol (ICMP) types")
  @added(Versions.v2025_07_15)
  icmpTypes?: string[];
}

@doc("Police rate configuration properties")
@added(Versions.v2024_06_15_preview)
model PoliceRateConfigurationProperties {
  @doc("Rate limit in bits per second.")
  bitRate?: BitRate;

  @doc("Burst size in packets.")
  burstSize?: BurstSize;
}

@doc("Bit rate in bits per second.")
@added(Versions.v2024_06_15_preview)
model BitRate {
  @doc("Bitrate.")
  rate?: int64;

  @doc("Bitrate unit.")
  unit?: BitRateUnit;
}

@doc("Bit rate unit.")
@added(Versions.v2024_06_15_preview)
union BitRateUnit {
  @doc("Bit rate unit in bits per second.")
  bps: "bps",

  @doc("Bit rate unit in kilobits per second.")
  Kbps: "Kbps",

  @doc("Bit rate unit in megabits per second.")
  Mbps: "Mbps",

  @doc("Bit rate unit in gigabits per second.")
  Gbps: "Gbps",

  @doc("Bit rate unit in packets per second.")
  @added(Versions.v2025_07_15)
  Pps: "Pps",

  string,
}

@doc("Burst size in packets.")
@added(Versions.v2024_06_15_preview)
model BurstSize {
  @doc("Burst size.")
  size?: int64;

  @doc("Burst size unit.")
  unit?: BurstSizeUnit;
}

@doc("Burst size unit in packets.")
@added(Versions.v2024_06_15_preview)
union BurstSizeUnit {
  @doc("Burst size unit in bytes.")
  Bytes: "Bytes",

  @doc("Burst size unit in kilobytes.")
  KBytes: "KBytes",

  @doc("Burst size unit in megabytes.")
  MBytes: "MBytes",

  @doc("Burst size unit in gigabytes.")
  GBytes: "GBytes",

  @doc("Burst size unit in packets.")
  @added(Versions.v2025_07_15)
  Packets: "Packets",

  string,
}

@doc("Control Plane Access Control List (ACL) Port Match conditions properties")
@added(Versions.v2025_07_15)
model ControlPlaneAclPortCondition {
  @doc("List of the ports that need to be matched. Possible values: 1234, 1234-1235, 1234,1235,1236")
  ports?: string[];

  @doc("Port match type. Example: eq | neq | gt | lt | range")
  portMatchType?: ControlPlaneAclPortMatchType;
}

@doc("Control Plane Access Control List (ACL) Port Match conditions properties")
@added(Versions.v2025_07_15)
model ControlPlaneAclPortMatchCondition {
  @doc("List of the ports that need to be matched.")
  sourcePorts?: ControlPlaneAclPortCondition;

  @doc("List of the destination ports that need to be matched.")
  destinationPorts?: ControlPlaneAclPortCondition;
}

@doc("Control Plane Access Control List (ACL) Port Match conditions properties")
@added(Versions.v2025_07_15)
model ControlPlaneAclPortMatchConditionPatch
  is ControlPlaneAclPortMatchCondition;

@doc("Control Plane Access Control List (ACL) IP condition properties")
@added(Versions.v2025_07_15)
model ControlPlanAclIpMatchCondition {
  @doc("List of the source IP addresses that need to be matched.")
  sourceIpPrefix?: string;

  @doc("List of the destination IP addresses that need to be matched.")
  destinationIpPrefix?: string;
}

@doc("Control Plane Access Control List (ACL) IP condition patch properties")
@added(Versions.v2025_07_15)
model ControlPlaneAclIpMatchConditionPatch is ControlPlanAclIpMatchCondition;

@doc("Control Plane Access Control List (ACL) Time To Live (TTL) match conditions properties")
@added(Versions.v2025_07_15)
union ControlPlaneAclTtlMatchType {
  @doc("TTL-eq")
  Equals: "eq",

  @doc("TTL-neq")
  NotEquals: "neq",

  @doc("TTL-gt")
  GreaterThan: "gt",

  @doc("TTL-lt")
  LesserThan: "lt",

  string,
}

@doc("Control Plane Access Control List (ACL) port match types")
@added(Versions.v2025_07_15)
union ControlPlaneAclPortMatchType {
  @doc("Port-eq")
  Equals: "eq",

  @doc("Port-neq")
  NotEquals: "neq",

  @doc("Port-gt")
  GreaterThan: "gt",

  @doc("Port-lt")
  LesserThan: "lt",

  @doc("Port-gt-eq")
  range: "range",

  string,
}

@doc("TTL [Time To Live] match conditions properties")
@added(Versions.v2025_07_15)
model ControlPlaneAclTtlMatchCondition {
  @doc("TTL [Time To Live] values that need to be matched.")
  ttlValue?: string;

  @doc("TTL [Time To Live] match type. Example: eq | neq | gt | lt | range")
  ttlMatchType?: ControlPlaneAclTtlMatchType;
}

@doc("TTL [Time To Live] match conditions patch properties")
model ControlPlaneAclTtlMatchConditionPatch is ControlPlaneAclTtlMatchCondition;

@doc("Control Plane Access Control List (ACL) match conditions properties")
@added(Versions.v2025_07_15)
model ControlPlaneAclMatchCondition {
  @doc("Protocols that need to be matched.")
  protocolTypes?: string;

  @doc("IP condition that needs to be matched.")
  ipCondition?: ControlPlanAclIpMatchCondition;

  @doc("TTL [Time To Live] values that need to be matched.")
  ttlMatchCondition?: ControlPlaneAclTtlMatchCondition;

  @doc("Port condition that needs to be matched.")
  portCondition?: ControlPlaneAclPortMatchCondition;

  @doc("Flags that need to be matched. Example: established | initial | <List-of-TCP-flags>. List of eligible TCP Flags are ack, cwr, ece, fin, psh, rst, syn, urg, established")
  @minItems(1)
  flags?: string[];

  @doc("Internet Control Message Protocol (ICMP) configuration")
  icmpConfiguration?: IcmpConfigurationProperties;
}

@doc("Control Plane Access Control List (ACL) match conditions properties")
@added(Versions.v2025_07_15)
model ControlPlaneAclMatchConditionPatch {
  @doc("Protocols that need to be matched.")
  protocolTypes?: string;

  @doc("IP condition that needs to be matched.")
  ipCondition?: ControlPlaneAclIpMatchConditionPatch;

  @doc("TTL [Time To Live] values that need to be matched.")
  ttlMatchCondition?: ControlPlaneAclTtlMatchConditionPatch;

  @doc("Port condition that needs to be matched.")
  portCondition?: ControlPlaneAclPortMatchConditionPatch;

  @doc("Flags that need to be matched. Example: established | initial | <List-of-TCP-flags>. List of eligible TCP Flags are ack, cwr, ece, fin, psh, rst, syn, urg, established")
  flags?: string[];

  @doc("Internet Control Message Protocol (ICMP) configuration")
  icmpConfiguration?: IcmpConfigurationPatchProperties;
}

@doc("Control Plane Access Control List (ACL) Action Types")
@added(Versions.v2025_07_15)
union ControlPlaneAclActionType {
  @doc("AclActionType Permit")
  Permit: "Permit",

  @doc("AclActionType Deny")
  Deny: "Deny",

  @doc("AclActionType Remark")
  Remark: "Remark",

  string,
}

@doc("Control Plane Access Control List (ACL) Actions")
@added(Versions.v2025_07_15)
model ControlPlaneAclAction {
  @doc("Type of actions that can be performed.")
  type?: ControlPlaneAclActionType;

  @doc("Remark comment")
  remarkComment?: string;
}

@doc("Control Plane Access Control List (ACL) Actions")
@added(Versions.v2025_07_15)
model ControlPlaneAclActionPatch {
  @doc("Type of actions that can be performed.")
  type?: ControlPlaneAclActionType;

  @doc("Remark comment")
  remarkComment?: string;
}

@doc("Control Plane Access Control List (ACL) match configurations properties")
@added(Versions.v2025_07_15)
model ControlPlaneAclMatchConfigurationProperties {
  @doc("The name of the match configuration.")
  matchConfigurationName?: string;

  @doc("Sequence Number of the match configuration.")
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber?: int64;

  @doc("Match conditions")
  matchCondition?: ControlPlaneAclMatchCondition;

  @doc("Action that need to be performed for the matched conditions.")
  action?: ControlPlaneAclAction;
}

@doc("Control Plane Access Control List (ACL) match configurations properties")
@added(Versions.v2025_07_15)
model ControlPlaneAclMatchConfigurationPatchProperties {
  @doc("The name of the match configuration.")
  matchConfigurationName?: string;

  @doc("Sequence Number of the match configuration.")
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber?: int64;

  @doc("Match conditions")
  matchCondition?: ControlPlaneAclMatchConditionPatch;

  @doc("Action that need to be performed for the matched conditions.")
  action?: ControlPlaneAclActionPatch;
}

@doc("Access Control List (ACL) configurations properties")
@added(Versions.v2025_07_15)
model ControlPlaneAclProperties {
  @doc("IP Address Type. IPv4 or IPv6")
  ipAddressType?: IPAddressType;

  @doc("Access Control List (ACL) match configurations.")
  @Azure.ResourceManager.identifiers(#[])
  @minItems(1)
  matchConfigurations?: ControlPlaneAclMatchConfigurationProperties[];
}

@doc("Access Control List (ACL) configurations patch properties")
@added(Versions.v2025_07_15)
model ControlPlaneAclPatchProperties {
  @doc("IP Address Type. IPv4 or IPv6")
  ipAddressType?: IPAddressType;

  @doc("Access Control List (ACL) match configurations.")
  @Azure.ResourceManager.identifiers(#[])
  matchConfigurations?: ControlPlaneAclMatchConfigurationPatchProperties[];
}
