import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

/**
 * Network Tap Rule Properties defines the resource properties.
 */
model NetworkTapRuleProperties {
  ...AnnotationResource;

  /**
   * Input method to configure Network Tap Rule.
   */
  configurationType: ConfigurationType;

  /**
   * Network Tap Rules file URL.
   */
  tapRulesUrl?: url;

  /**
   * List of match configurations.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  @minItems(1)
  matchConfigurations?: NetworkTapRuleMatchConfiguration[];

  /**
   * List of dynamic match configurations.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  @minItems(1)
  dynamicMatchConfigurations?: CommonDynamicMatchConfiguration[];

  /**
   * The ARM resource Id of the NetworkTap.
   */
  @visibility("read")
  networkTapId?: string;

  /**
   * Polling interval in seconds.
   */
  pollingIntervalInSeconds?: PollingIntervalInSeconds = PollingIntervalInSeconds.Thirty;

  /**
   * The last sync timestamp.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncedTime?: utcDateTime;

  /**
   * Configuration state of the resource.
   */
  @visibility("read")
  configurationState?: ConfigurationState;

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Administrative state of the resource.
   */
  @visibility("read")
  administrativeState?: AdministrativeState;
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
  @OpenAPI.extension("x-ms-identifiers", [])
  matchConditions?: NetworkTapRuleMatchCondition[];

  /**
   * List of actions that need to be performed for the matched conditions.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  actions?: NetworkTapRuleAction[];
}

/**
 * Defines the match configuration that are supported to filter the traffic.
 */
model NetworkTapRuleMatchConfigurationPatch {
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
  @OpenAPI.extension("x-ms-identifiers", [])
  matchConditions?: NetworkTapRuleMatchConditionPatch[];

  /**
   * List of actions that need to be performed for the matched conditions.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  actions?: NetworkTapRuleActionPatch[];
}

/**
 * Defines the match condition that is supported to filter the traffic.
 */
model NetworkTapRuleMatchCondition {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...CommonMatchConditions;

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
 * Defines the match condition that is supported to filter the traffic.
 */
model NetworkTapRuleMatchConditionPatch {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...CommonMatchConditionsPatch;

  /**
   * Encapsulation Type that needs to be matched.
   */
  encapsulationType?: EncapsulationType;

  /**
   * Defines the port condition that needs to be matched.
   */
  portCondition?: PortConditionPatch;
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
 * Action that need to performed.
 */
model NetworkTapRuleActionPatch is NetworkTapRuleAction;

/**
 * The NetworkTapRule resource definition.
 */
model NetworkTapRulePatch {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...TagsUpdate;

  /**
   * Network Tap Rule Patch properties.
   */
  properties?: NetworkTapRulePatchProperties;
}

/**
 * Network Tap Rule Patch properties.
 */
model NetworkTapRulePatchProperties {
  ...AnnotationResource;

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
  @OpenAPI.extension("x-ms-identifiers", [])
  @minItems(1)
  matchConfigurations?: NetworkTapRuleMatchConfigurationPatch[];

  /**
   * List of dynamic match configurations.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  @minItems(1)
  dynamicMatchConfigurations?: CommonDynamicMatchConfigurationPatch[];
}

/**
 * Polling interval in seconds.
 */
union PollingIntervalInSeconds {
  @doc("30 PollingIntervalInSeconds")
  Thirty: 30,

  @doc("60 PollingIntervalInSeconds")
  sixty: 60,

  @doc("90 PollingIntervalInSeconds")
  Ninety: 90,

  @doc("120 PollingIntervalInSeconds")
  OneTwenty: 120,

  int32,
}

/**
 * Type of actions that can be performed.
 */
union TapRuleActionType {
  @doc("TapRuleActionType-Drop")
  Drop: "Drop",

  @doc("TapRuleActionType-Count")
  Count: "Count",

  @doc("TapRuleActionType-Log")
  Log: "Log",

  @doc("TapRuleActionType-Replicate")
  Replicate: "Replicate",

  @doc("TapRuleActionType-Goto")
  Goto: "Goto",

  @doc("TapRuleActionType-Redirect")
  Redirect: "Redirect",

  @doc("TapRuleActionType-Mirror")
  Mirror: "Mirror",

  string,
}

/**
 * Encapsulation Type that needs to be matched.
 */
union EncapsulationType {
  @doc("None EncapsulationType")
  None: "None",

  @doc("GTPv1 EncapsulationType")
  GTPv1: "GTPv1",

  string,
}
