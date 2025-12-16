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
model IcmpConfigurationPatchProperties is IcmpConfigurationProperties;

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

  string,
}
