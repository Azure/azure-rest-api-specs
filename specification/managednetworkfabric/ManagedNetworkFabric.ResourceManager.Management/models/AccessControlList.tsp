import "./common.tsp";

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

  @OpenAPI.extension("x-ms-identifiers", [])
  @doc("List of match configurations.")
  @minItems(1)
  matchConfigurations?: AccessControlListMatchConfiguration[];

  @OpenAPI.extension("x-ms-identifiers", [])
  @doc("List of dynamic match configurations.")
  @minItems(1)
  dynamicMatchConfigurations?: CommonDynamicMatchConfiguration[];

  @doc("The last synced timestamp.")
  @visibility("read")
  lastSyncedTime?: utcDateTime;

  @doc("Configuration state of the resource.")
  @visibility("read")
  configurationState?: ConfigurationState;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility("read")
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

  @OpenAPI.extension("x-ms-identifiers", [])
  @doc("List of the match conditions.")
  @minItems(1)
  matchConditions?: AccessControlListMatchCondition[];

  @OpenAPI.extension("x-ms-identifiers", [])
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

  @OpenAPI.extension("x-ms-identifiers", [])
  @doc("List of the match conditions.")
  @minItems(1)
  matchConditions?: AccessControlListMatchConditionPatch[];

  @OpenAPI.extension("x-ms-identifiers", [])
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

  @doc("Defines the port condition that needs to be matched.")
  portCondition?: AccessControlListPortCondition;
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

  @OpenAPI.extension("x-ms-identifiers", [])
  @doc("List of match configurations.")
  @minItems(1)
  matchConfigurations?: AccessControlListMatchConfigurationPatch[];

  @OpenAPI.extension("x-ms-identifiers", [])
  @doc("List of dynamic match configurations.")
  @minItems(1)
  dynamicMatchConfigurations?: CommonDynamicMatchConfigurationPatch[];

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

  string,
}
