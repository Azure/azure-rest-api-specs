import "./common.tsp";
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;

@doc("Network Tap Rule Properties defines the resource properties.")
model NetworkTapRuleProperties {
  ...AnnotationResource;

  @doc("Input method to configure Network Tap Rule.")
  configurationType: ConfigurationType;

  @doc("Network Tap Rules file URL.")
  tapRulesUrl?: url;

  @doc("The selection of the managed identity to use with this storage account. The identity type must be either system assigned or user assigned.")
  @added(Versions.v2025_07_15)
  identitySelector?: IdentitySelector;

  @doc("List of match configurations.")
  @Azure.ResourceManager.identifiers(#[])
  @minItems(1)
  matchConfigurations?: NetworkTapRuleMatchConfiguration[];

  @doc("List of dynamic match configurations.")
  @Azure.ResourceManager.identifiers(#[])
  @minItems(1)
  dynamicMatchConfigurations?: CommonDynamicMatchConfiguration[];

  @doc("The ARM resource Id of the NetworkTap.")
  @visibility(Lifecycle.Read)
  @removed(Versions.v2025_07_15)
  networkTapId?: string;

  @doc("The ARM resource Id of the NetworkTap Rules.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_07_15)
  networkTapIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkTaps";
    }
  ]>[];

  @doc("Polling interval in seconds.")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "pollingIntervalInSeconds")
  pollingIntervalInSecondsDeprecated?: PollingIntervalInSeconds = PollingIntervalInSeconds.Thirty;

  @doc("Polling interval in seconds.")
  @added(Versions.v2025_07_15)
  pollingIntervalInSeconds?: int32 = 30;

  @doc("The last sync timestamp.")
  @visibility(Lifecycle.Read)
  lastSyncedTime?: utcDateTime;

  @doc("Global network tap rule actions")
  @added(Versions.v2024_06_15_preview)
  globalNetworkTapRuleActions?: GlobalNetworkTapRuleActionProperties;

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
model NetworkTapRuleMatchConfiguration {
  @doc("The name of the match configuration.")
  @minLength(1)
  matchConfigurationName?: string;

  @doc("Sequence Number of the match configuration..")
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber?: int64;

  @doc("Type of IP Address. IPv4 or IPv6")
  ipAddressType?: IPAddressType;

  @doc("List of the match conditions.")
  @Azure.ResourceManager.identifiers(#[])
  matchConditions?: NetworkTapRuleMatchCondition[];

  @doc("List of actions that need to be performed for the matched conditions.")
  @Azure.ResourceManager.identifiers(#[])
  actions?: NetworkTapRuleAction[];
}

@doc("Defines the match configuration that are supported to filter the traffic.")
model NetworkTapRuleMatchConfigurationPatch {
  @doc("The name of the match configuration.")
  @minLength(1)
  matchConfigurationName?: string;

  @doc("Sequence Number of the match configuration..")
  @maxValue(4294967295)
  @minValue(1)
  sequenceNumber?: int64;

  @doc("Type of IP Address. IPv4 or IPv6")
  ipAddressType?: IPAddressType;

  @doc("List of the match conditions.")
  @Azure.ResourceManager.identifiers(#[])
  matchConditions?: NetworkTapRuleMatchConditionPatch[];

  @doc("List of actions that need to be performed for the matched conditions.")
  @Azure.ResourceManager.identifiers(#[])
  actions?: NetworkTapRuleActionPatch[];
}

@doc("Defines the match condition that is supported to filter the traffic.")
model NetworkTapRuleMatchCondition {
  ...CommonMatchConditions;

  @doc("Encapsulation Type that needs to be matched.")
  encapsulationType?: EncapsulationType = EncapsulationType.None;

  @doc("Defines the port condition that needs to be matched.")
  portCondition?: PortCondition;
}

@doc("Defines the match condition that is supported to filter the traffic.")
model NetworkTapRuleMatchConditionPatch {
  ...CommonMatchConditionsPatch;

  @doc("Encapsulation Type that needs to be matched.")
  encapsulationType?: EncapsulationType;

  @doc("Defines the port condition that needs to be matched.")
  portCondition?: PortConditionPatch;
}

@doc("Action that need to performed.")
model NetworkTapRuleAction {
  @doc("Type of actions that can be performed.")
  type?: TapRuleActionType;

  @doc("Truncate. 0 indicates do not truncate.")
  @minLength(1)
  truncate?: string;

  @doc("The parameter to enable or disable the timestamp.")
  isTimestampEnabled?: BooleanEnumProperty;

  @doc("Destination Id. The ARM resource Id may be either Network To Network Interconnect or NeighborGroup.")
  destinationId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/neighborGroups";
    },
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics/networkToNetworkInterconnects";
    }
  ]>;

  // This is property is present in the older version of the API. However the description for this field is changed
  // Hence this property is removed and added with a same name but with a different description
  @doc("The name of the match configuration. This is used when Goto type is provided. If Goto type is selected and no match configuration name is provided. It goes to next configuration.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "matchConfigurationName")
  @minLength(1)
  matchConfigurationNameDeprecated?: string;

  @doc("The name of the match configuration. This is used when Goto type is provided.")
  @added(Versions.v2024_06_15_preview)
  @minLength(1)
  matchConfigurationName?: string;
}

@doc("Action that need to performed.")
model NetworkTapRuleActionPatch is NetworkTapRuleAction;

@doc("The NetworkTapRule resource definition.")
model NetworkTapRulePatch {
  ...TagsUpdate;

  @doc("Network Tap Rule Patch properties.")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "properties")
  propertiesDeprecated?: NetworkTapRulePatchProperties;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flattening"
  @doc("Network Tap Rule Patch properties.")
  @added(Versions.v2025_07_15)
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: NetworkTapRulePatchProperties;

  @added(Versions.v2025_07_15)
  @doc("The managed service identities assigned to this resource.")
  identity?: ManagedServiceIdentityPatch;
}

@doc("Network Tap Rule Patch properties.")
model NetworkTapRulePatchProperties {
  ...AnnotationResource;

  @doc("Input method to configure Network Tap Rule.")
  configurationType?: ConfigurationType;

  @doc("Network Tap Rules file URL.")
  tapRulesUrl?: url;

  @doc("The selection of the managed identity to use with this storage account. The identity type must be either system assigned or user assigned.")
  @added(Versions.v2025_07_15)
  identitySelector?: IdentitySelectorPatch;

  @doc("Global network tap rule actions")
  @added(Versions.v2024_06_15_preview)
  globalNetworkTapRuleActions?: GlobalNetworkTapRuleActionPatchProperties;

  @doc("List of match configurations.")
  @Azure.ResourceManager.identifiers(#[])
  @minItems(1)
  matchConfigurations?: NetworkTapRuleMatchConfigurationPatch[];

  @doc("List of dynamic match configurations.")
  @Azure.ResourceManager.identifiers(#[])
  @minItems(1)
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "dynamicMatchConfigurations")
  dynamicMatchConfigurationsDeprecated?: CommonDynamicMatchConfigurationPatch[];

  @doc("List of dynamic match configurations.")
  @Azure.ResourceManager.identifiers(#[])
  @added(Versions.v2025_07_15)
  dynamicMatchConfigurations?: CommonDynamicMatchConfigurationPatch[];
}

@doc("Polling interval in seconds.")
union PollingIntervalInSeconds {
  int32,

  @doc("30 PollingIntervalInSeconds")
  Thirty: 30,

  @doc("60 PollingIntervalInSeconds")
  sixty: 60,

  @doc("90 PollingIntervalInSeconds")
  Ninety: 90,

  @doc("120 PollingIntervalInSeconds")
  OneTwenty: 120,
}

@doc("Type of actions that can be performed.")
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

@doc("Encapsulation Type that needs to be matched.")
union EncapsulationType {
  @doc("None EncapsulationType")
  None: "None",

  @doc("GTPv1 EncapsulationType")
  GTPv1: "GTPv1",

  string,
}

@doc("Global network tap rule actions properties")
@added(Versions.v2024_06_15_preview)
model GlobalNetworkTapRuleActionProperties {
  @doc("Configuration to enable network tap rule counter.")
  enableCount?: BooleanEnumProperty = BooleanEnumProperty.False;

  @doc("Truncate. 0 indicates do not truncate.")
  @minLength(1)
  truncate?: string;
}

@doc("Global network tap rule actions patch properties")
@added(Versions.v2024_06_15_preview)
model GlobalNetworkTapRuleActionPatchProperties {
  @doc("Configuration to enable network tap rule counter.")
  enableCount?: BooleanEnumProperty;

  @doc("Truncate. 0 indicates do not truncate.")
  @minLength(1)
  truncate?: string;
}

@doc("Response for Network Tap Rule resync operation.")
model NetworkTapRuleResyncResponse {
  ...OperationStatusResult;
}
