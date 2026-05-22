import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.ManagedNetworkFabric;

@@clientName(AccessControlList, "NetworkFabricAccessControlList", "csharp");
@@clientName(ExternalNetwork, "NetworkFabricExternalNetwork", "csharp");
@@clientName(InternalNetwork, "NetworkFabricInternalNetwork", "csharp");
@@clientName(InternetGateway, "NetworkFabricInternetGateway", "csharp");
@@clientName(InternetGatewayRule, "NetworkFabricInternetGatewayRule", "csharp");
@@clientName(IpCommunity, "NetworkFabricIPCommunity", "csharp");
@@clientName(IpExtendedCommunity, "NetworkFabricIPExtendedCommunity", "csharp");
@@clientName(IpPrefix, "NetworkFabricIPPrefix", "csharp");
@@clientName(L2IsolationDomain, "NetworkFabricL2IsolationDomain", "csharp");
@@clientName(L3IsolationDomain, "NetworkFabricL3IsolationDomain", "csharp");
@@clientName(NeighborGroup, "NetworkFabricNeighborGroup", "csharp");
@@clientName(NetworkInterface, "NetworkDeviceInterface", "csharp");
@@clientName(RoutePolicy, "NetworkFabricRoutePolicy", "csharp");
@@clientName(AdministrativeState, "NetworkFabricAdministrativeState", "csharp");
@@clientName(BooleanEnumProperty, "NetworkFabricBooleanValue", "csharp");
@@clientName(CommunityActionTypes, "CommunityActionType", "csharp");
@@clientName(ConfigurationState, "NetworkFabricConfigurationState", "csharp");
@@clientName(ConfigurationType, "NetworkFabricConfigurationType", "csharp");
@@clientName(ControllerServices, "NetworkFabricControllerServices", "csharp");
@@clientName(
  DestinationProperties,
  "NetworkTapDestinationProperties",
  "csharp"
);
@@clientName(Encapsulation, "IsolationDomainEncapsulationType", "csharp");
@@clientName(EncapsulationType, "NetworkTapEncapsulationType", "csharp");
@@clientName(Extension, "StaticRouteConfigurationExtension", "csharp");
@@clientName(
  ExternalNetworkPropertiesOptionAProperties,
  "ExternalNetworkOptionAProperties",
  "csharp"
);
@@clientName(FabricSkuType, "NetworkFabricSkuType", "csharp");
@@clientName(GatewayType, "InternetGatewayType", "csharp");
@@clientName(Action, "InternetGatewayRuleAction", "csharp");
@@clientName(IpCommunityRule, "IPCommunityRule", "csharp");
@@clientName(IpExtendedCommunityRule, "IPExtendedCommunityRule", "csharp");
@@clientName(IpPrefixRule, "IPPrefixRule", "csharp");
@@clientName(Condition, "IPPrefixRuleCondition", "csharp");
@@clientName(WellKnownCommunities, "WellKnownCommunity", "csharp");
@@clientName(InterfaceType, "NetworkDeviceInterfaceType", "csharp");
@@clientName(NfcSku, "NetworkFabricControllerSKU", "csharp");
@@clientName(PollingIntervalInSeconds, "PollingIntervalInSecond", "csharp");
@@clientName(PollingType, "NetworkTapPollingType", "csharp");
@@clientName(PortCondition, "NetworkFabricPortCondition", "csharp");
@@clientName(PortType, "NetworkFabricPortType", "csharp");
@@clientName(ProvisioningState, "NetworkFabricProvisioningState", "csharp");
@@clientName(
  RedistributeConnectedSubnets,
  "RedistributeConnectedSubnet",
  "csharp"
);
@@clientName(RedistributeStaticRoutes, "RedistributeStaticRoute", "csharp");
@@clientName(RuleProperties, "InternetGatewayRules", "csharp");
@@clientName(StaticRouteConfiguration, "StaticRouteConfiguration", "csharp");
@@clientName(VpnOptionAProperties, "OptionAProperties", "csharp");
@@clientName(VpnOptionBProperties, "OptionBProperties", "csharp");
@@clientName(ControlPlaneAclPortMatchType.Equals, "EqualTo", "csharp");
@@clientName(ControlPlaneAclTtlMatchType.Equals, "EqualTo", "csharp");
@@clientName(
  ActionIpCommunityProperties,
  "ActionIPCommunityProperties",
  "csharp"
);
@@clientName(
  ActionIpExtendedCommunityProperties,
  "ActionIPExtendedCommunityProperties",
  "csharp"
);
@@clientName(AnnotationResource, "AnnotationResourceProperties", "csharp");
@@clientName(BgpConfiguration, "BgpConfiguration", "csharp");
@@clientName(
  CommonPostActionResponseForDeviceUpdate,
  "DeviceUpdateCommonPostActionResult",
  "csharp"
);
@@clientName(
  CommonPostActionResponseForStateUpdate,
  "StateUpdateCommonPostActionResult",
  "csharp"
);
@@clientName(DestinationType, "NetworkTapDestinationType", "csharp");
@@clientName(
  EnableDisableOnResources,
  "UpdateAdministrativeStateOnResources",
  "csharp"
);
@@clientName(EnableDisableState, "AdministrativeEnableState", "csharp");
@@clientName(
  ExternalNetworkPatchPropertiesOptionAProperties,
  "ExternalNetworkPatchOptionAProperties",
  "csharp"
);
@@clientName(IPAddressType, "NetworkFabricIPAddressType", "csharp");
@@clientName(IpCommunityIdList, "IPCommunityIdList", "csharp");
@@clientName(IpExtendedCommunityIdList, "IPExtendedCommunityIdList", "csharp");
@@clientName(
  IpGroupProperties,
  "MatchConfigurationIPGroupProperties",
  "csharp"
);
@@clientName(IpMatchCondition, "IPMatchCondition", "csharp");
@@clientName(PrefixType, "IPMatchConditionPrefixType", "csharp");
@@clientName(Layer3IpPrefixProperties, "Layer3IPPrefixProperties", "csharp");
@@clientName(
  Layer3IpPrefixPatchProperties,
  "Layer3IPPrefixPatchProperties",
  "csharp"
);
@@clientName(
  ManagementNetworkPatchConfiguration,
  "ManagementNetworkConfigurationPatchableProperties",
  "csharp"
);
@@clientName(
  DeviceAdministrativeState,
  "NetworkDeviceAdministrativeState",
  "csharp"
);
@@clientName(
  DeviceInterfaceProperties,
  "NetworkDeviceInterfaceProperties",
  "csharp"
);
@@clientName(RebootProperties, "NetworkDeviceRebootContent", "csharp");
@@clientName(RebootType, "NetworkDeviceRebootType", "csharp");
@@clientName(
  TerminalServerConfiguration,
  "TerminalServerConfigurationTemp",
  "csharp"
);
@@clientName(
  TerminalServerPatchConfiguration,
  "TerminalServerPatchableProperties",
  "csharp"
);
@@clientName(
  UpdateAdministrativeState,
  "UpdateAdministrativeStateContent",
  "csharp"
);
@@clientName(
  UpdateDeviceAdministrativeState,
  "UpdateDeviceAdministrativeStateContent",
  "csharp"
);
@@clientName(UpdateVersion, "NetworkFabricUpdateVersionContent", "csharp");
@@clientName(ValidateAction, "NetworkFabricValidateAction", "csharp");
@@clientName(
  ValidateConfigurationProperties,
  "ValidateConfigurationContent",
  "csharp"
);

// Replacement models preserve paired base/derived C# model names from the shipped SDK.
model InternalNetworkBgpConfigurationReplacement extends BgpConfiguration {}
@@alternateType(
  InternalNetworkProperties.bgpConfiguration,
  InternalNetworkBgpConfigurationReplacement,
  "csharp"
);
@@clientName(
  InternalNetworkBgpConfigurationReplacement,
  "InternalNetworkBgpConfiguration",
  "csharp"
);

model InternalNetworkStaticRouteConfigurationReplacement
  extends StaticRouteConfiguration {}
@@alternateType(
  InternalNetworkProperties.staticRouteConfiguration,
  InternalNetworkStaticRouteConfigurationReplacement,
  "csharp"
);
@@clientName(
  InternalNetworkStaticRouteConfigurationReplacement,
  "InternalNetworkStaticRouteConfiguration",
  "csharp"
);

model NetworkToNetworkInterconnectOptionBLayer3ConfigurationReplacement
  extends OptionBLayer3Configuration {}
@@alternateType(
  NetworkToNetworkInterconnectProperties.optionBLayer3Configuration,
  NetworkToNetworkInterconnectOptionBLayer3ConfigurationReplacement,
  "csharp"
);
@@clientName(
  NetworkToNetworkInterconnectOptionBLayer3ConfigurationReplacement,
  "NetworkToNetworkInterconnectOptionBLayer3Configuration",
  "csharp"
);

model NetworkTapPropertiesDestinationsItemReplacement
  extends DestinationProperties {}
@@alternateType(
  NetworkTapProperties.destinations,
  NetworkTapPropertiesDestinationsItemReplacement[],
  "csharp"
);
@@clientName(
  NetworkTapPropertiesDestinationsItemReplacement,
  "NetworkTapPropertiesDestinationsItem",
  "csharp"
);

model NetworkTapPatchableParametersDestinationsItemReplacement
  extends DestinationProperties {}
@@alternateType(
  NetworkTapPatchProperties.destinations,
  NetworkTapPatchableParametersDestinationsItemReplacement[],
  "csharp"
);
@@clientName(
  NetworkTapPatchableParametersDestinationsItemReplacement,
  "NetworkTapPatchableParametersDestinationsItem",
  "csharp"
);

model NetworkFabricPatchablePropertiesTerminalServerConfigurationReplacement
  extends TerminalServerPatchConfiguration {}
@@alternateType(
  NetworkFabricPatchableProperties.terminalServerConfiguration,
  NetworkFabricPatchablePropertiesTerminalServerConfigurationReplacement,
  "csharp"
);
@@clientName(
  NetworkFabricPatchablePropertiesTerminalServerConfigurationReplacement,
  "NetworkFabricPatchablePropertiesTerminalServerConfiguration",
  "csharp"
);

model TerminalServerConfigurationReplacement
  extends TerminalServerPatchConfiguration {
  ...OmitProperties<
    TerminalServerConfiguration,

      | "username"
      | "password"
      | "serialNumber"
      | "primaryIpv4Prefix"
      | "primaryIpv6PrefixDeprecated"
      | "primaryIpv6Prefix"
      | "secondaryIpv4Prefix"
      | "secondaryIpv6Prefix"
  >;
}
@@alternateType(
  TerminalServerConfiguration,
  TerminalServerConfigurationReplacement,
  "csharp"
);
@@clientName(
  TerminalServerConfigurationReplacement,
  "TerminalServerConfiguration",
  "csharp"
);

model VpnConfigurationOptionAPropertiesReplacement
  extends VpnOptionAProperties {}
@@alternateType(
  VpnConfigurationProperties.optionAProperties,
  VpnConfigurationOptionAPropertiesReplacement,
  "csharp"
);
@@clientName(
  VpnConfigurationOptionAPropertiesReplacement,
  "VpnConfigurationOptionAProperties",
  "csharp"
);

model VpnConfigurationPatchableOptionAPropertiesReplacement
  extends VpnOptionAProperties {}
@@alternateType(
  VpnConfigurationPatchableProperties.optionAProperties,
  VpnConfigurationPatchableOptionAPropertiesReplacement,
  "csharp"
);
@@clientName(
  VpnConfigurationPatchableOptionAPropertiesReplacement,
  "VpnConfigurationPatchableOptionAProperties",
  "csharp"
);

@@alternateType(
  InternalNetworkPatchProperties.bgpConfiguration,
  BgpConfiguration,
  "csharp"
);
@@alternateType(
  InternalNetworkPatchProperties.staticRouteConfiguration,
  StaticRouteConfiguration,
  "csharp"
);
@@alternateType(
  InternalNetworkPatchProperties.connectedIPv4Subnets,
  ConnectedSubnet[],
  "csharp"
);
@@alternateType(
  InternalNetworkPatchProperties.connectedIPv6Subnets,
  ConnectedSubnet[],
  "csharp"
);
@@alternateType(
  NetworkToNetworkInterconnectPatchProperties.layer2Configuration,
  Layer2Configuration,
  "csharp"
);
@@alternateType(
  NetworkToNetworkInterconnectPatchProperties.optionBLayer3Configuration,
  OptionBLayer3Configuration,
  "csharp"
);
@@alternateType(
  NetworkToNetworkInterconnectPatchProperties.npbStaticRouteConfiguration,
  NpbStaticRouteConfiguration,
  "csharp"
);
@@alternateType(
  NetworkToNetworkInterconnectPatchProperties.importRoutePolicy,
  ImportRoutePolicyInformation,
  "csharp"
);
@@alternateType(
  NetworkToNetworkInterconnectPatchProperties.exportRoutePolicy,
  ExportRoutePolicyInformation,
  "csharp"
);
@@alternateType(
  ExternalNetworkPatchProperties.optionBProperties,
  L3OptionBProperties,
  "csharp"
);
@@alternateType(
  L3IsolationDomainPatchProperties.aggregateRouteConfiguration,
  AggregateRouteConfiguration,
  "csharp"
);
@@alternateType(
  L3IsolationDomainPatchProperties.connectedSubnetRoutePolicy,
  ConnectedSubnetRoutePolicy,
  "csharp"
);
@@alternateType(
  NeighborGroupPatchProperties.destination,
  NeighborGroupDestination,
  "csharp"
);
@@alternateType(
  AccessControlListPatchProperties.matchConfigurations,
  AccessControlListMatchConfiguration[],
  "csharp"
);
@@alternateType(
  AccessControlListPatchProperties.dynamicMatchConfigurations,
  CommonDynamicMatchConfiguration[],
  "csharp"
);
@@alternateType(
  NetworkTapRulePatchProperties.matchConfigurations,
  NetworkTapRuleMatchConfiguration[],
  "csharp"
);
@@alternateType(
  NetworkTapRulePatchProperties.dynamicMatchConfigurations,
  CommonDynamicMatchConfiguration[],
  "csharp"
);
@@alternateType(
  RoutePolicyPatchableProperties.statements,
  RoutePolicyStatementProperties[],
  "csharp"
);
@@alternateType(
  NpbStaticRouteConfigurationPatch.ipv4Routes,
  StaticRouteProperties[],
  "csharp"
);
@@alternateType(
  NpbStaticRouteConfigurationPatch.ipv6Routes,
  StaticRouteProperties[],
  "csharp"
);
@@alternateType(
  TerminalServerConfiguration.networkDeviceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  IpCommunityIdList.ipCommunityIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@alternateType(
  IpExtendedCommunityIdList.ipExtendedCommunityIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@alternateType(
  StatementConditionProperties.ipPrefixId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  StatementConditionProperties.ipExtendedCommunityIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@clientName(
  StatementActionProperties.ipCommunityProperties,
  "IPCommunityProperties",
  "csharp"
);
@@clientName(
  StatementActionProperties.ipExtendedCommunityProperties,
  "IPExtendedCommunityProperties",
  "csharp"
);
@@clientName(
  StatementConditionProperties.type,
  "RoutePolicyConditionType",
  "csharp"
);
@@clientName(NniType.NPB, "Npb", "csharp");
@@clientName(Extension.NPB, "Npb", "csharp");
@@clientName(
  SupportedVersionProperties.vendorOsVersion,
  "VendorOSVersion",
  "csharp"
);
@@clientName(
  BgpConfiguration.ipv4ListenRangePrefixes,
  "IPv4ListenRangePrefixes",
  "csharp"
);
@@clientName(
  BgpConfiguration.ipv6ListenRangePrefixes,
  "IPv6ListenRangePrefixes",
  "csharp"
);
@@clientName(
  BgpConfiguration.ipv4NeighborAddress,
  "IPv4NeighborAddress",
  "csharp"
);
@@clientName(
  BgpConfiguration.ipv6NeighborAddress,
  "IPv6NeighborAddress",
  "csharp"
);
@@clientName(StaticRouteConfiguration.ipv4Routes, "IPv4Routes", "csharp");
@@clientName(StaticRouteConfiguration.ipv6Routes, "IPv6Routes", "csharp");
@@clientName(NpbStaticRouteConfiguration.ipv4Routes, "IPv4Routes", "csharp");
@@clientName(NpbStaticRouteConfiguration.ipv6Routes, "IPv6Routes", "csharp");
@@clientName(
  RouteTargetInformation.exportIpv4RouteTargets,
  "ExportIPv4RouteTargets",
  "csharp"
);
@@clientName(
  RouteTargetInformation.exportIpv6RouteTargets,
  "ExportIPv6RouteTargets",
  "csharp"
);
@@clientName(
  RouteTargetInformation.importIpv4RouteTargets,
  "ImportIPv4RouteTargets",
  "csharp"
);
@@clientName(
  RouteTargetInformation.importIpv6RouteTargets,
  "ImportIPv6RouteTargets",
  "csharp"
);
@@clientName(
  NetworkTapRuleMatchConfiguration.ipAddressType,
  "IPAddressType",
  "csharp"
);
@@clientName(NetworkTapRuleAction.type, "TapRuleActionType", "csharp");
@@usage(DeviceInterfaceProperties, Usage.input, "csharp");
@@usage(SupportedConnectorProperties, Usage.input, "csharp");
@@usage(SupportedVersionProperties, Usage.input, "csharp");
@@usage(BgpConfiguration, Usage.input | Usage.output | Usage.json, "csharp");
@@usage(
  StaticRouteConfiguration,
  Usage.input | Usage.output | Usage.json,
  "csharp"
);
@@usage(
  DestinationProperties,
  Usage.input | Usage.output | Usage.json,
  "csharp"
);
@@usage(
  VpnOptionAProperties,
  Usage.input | Usage.output | Usage.json,
  "csharp"
);
@@usage(
  VpnConfigurationProperties,
  Usage.input | Usage.output | Usage.json,
  "csharp"
);
@@usage(
  TerminalServerPatchConfiguration,
  Usage.input | Usage.output | Usage.json,
  "csharp"
);
@@usage(IpCommunityIdList, Usage.input | Usage.output | Usage.json, "csharp");
@@usage(
  IpExtendedCommunityIdList,
  Usage.input | Usage.output | Usage.json,
  "csharp"
);
@@usage(
  InternalNetworkBgpConfigurationReplacement,
  Usage.input | Usage.output | Usage.json,
  "csharp"
);
@@usage(
  InternalNetworkStaticRouteConfigurationReplacement,
  Usage.input | Usage.output | Usage.json,
  "csharp"
);
@@usage(
  NetworkToNetworkInterconnectOptionBLayer3ConfigurationReplacement,
  Usage.input | Usage.output | Usage.json,
  "csharp"
);
@@usage(
  NetworkTapPropertiesDestinationsItemReplacement,
  Usage.input | Usage.output | Usage.json,
  "csharp"
);
@@usage(
  NetworkTapPatchableParametersDestinationsItemReplacement,
  Usage.input | Usage.output | Usage.json,
  "csharp"
);
@@usage(
  NetworkFabricPatchablePropertiesTerminalServerConfigurationReplacement,
  Usage.input | Usage.output | Usage.json,
  "csharp"
);
@@usage(
  TerminalServerConfigurationReplacement,
  Usage.input | Usage.output | Usage.json,
  "csharp"
);
@@usage(
  VpnConfigurationOptionAPropertiesReplacement,
  Usage.input | Usage.output | Usage.json,
  "csharp"
);
@@usage(
  VpnConfigurationPatchableOptionAPropertiesReplacement,
  Usage.input | Usage.output | Usage.json,
  "csharp"
);
@@access(BgpConfiguration, Access.public, "csharp");
@@access(StaticRouteConfiguration, Access.public, "csharp");
@@access(DestinationProperties, Access.public, "csharp");
@@access(VpnOptionAProperties, Access.public, "csharp");
@@access(VpnConfigurationProperties, Access.public, "csharp");
@@access(TerminalServerPatchConfiguration, Access.public, "csharp");
@@access(VpnConfigurationProperties, Access.public, "csharp");
@@access(ManagementNetworkConfigurationProperties, Access.public, "csharp");
@@access(InternalNetworkBgpConfigurationReplacement, Access.public, "csharp");
@@access(
  InternalNetworkStaticRouteConfigurationReplacement,
  Access.public,
  "csharp"
);
@@access(
  NetworkToNetworkInterconnectOptionBLayer3ConfigurationReplacement,
  Access.public,
  "csharp"
);
@@access(
  NetworkTapPropertiesDestinationsItemReplacement,
  Access.public,
  "csharp"
);
@@access(
  NetworkTapPatchableParametersDestinationsItemReplacement,
  Access.public,
  "csharp"
);
@@access(
  NetworkFabricPatchablePropertiesTerminalServerConfigurationReplacement,
  Access.public,
  "csharp"
);
@@access(TerminalServerConfigurationReplacement, Access.public, "csharp");
@@access(VpnConfigurationOptionAPropertiesReplacement, Access.public, "csharp");
@@access(
  VpnConfigurationPatchableOptionAPropertiesReplacement,
  Access.public,
  "csharp"
);

// Preserve the shipped C# inheritance hierarchy from the swagger-generated SDK.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  StatementConditionProperties,
  IpCommunityIdList,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  InternalNetworkBgpConfigurationReplacement,
  BgpConfiguration,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  InternalNetworkStaticRouteConfigurationReplacement,
  StaticRouteConfiguration,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  NetworkToNetworkInterconnectOptionBLayer3ConfigurationReplacement,
  OptionBLayer3Configuration,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  NetworkTapPropertiesDestinationsItemReplacement,
  DestinationProperties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  NetworkTapPatchableParametersDestinationsItemReplacement,
  DestinationProperties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  NetworkFabricPatchablePropertiesTerminalServerConfigurationReplacement,
  TerminalServerPatchConfiguration,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  TerminalServerConfigurationReplacement,
  NetworkFabricPatchablePropertiesTerminalServerConfigurationReplacement,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  ManagementNetworkConfigurationProperties,
  ManagementNetworkPatchConfiguration,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  VpnConfigurationOptionAPropertiesReplacement,
  VpnOptionAProperties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  VpnConfigurationPatchableOptionAPropertiesReplacement,
  VpnOptionAProperties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  NetworkDevicePatchParameters,
  NetworkRackPatch,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  AccessControlListPatch,
  NetworkRackPatch,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  NetworkFabricControllerPatch,
  NetworkRackPatch,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  InternetGatewayPatch,
  NetworkRackPatch,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  InternetGatewayRulePatch,
  NetworkRackPatch,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  IpCommunityPatch,
  NetworkRackPatch,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  IpExtendedCommunityPatch,
  NetworkRackPatch,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  IpPrefixPatch,
  NetworkRackPatch,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  L2IsolationDomainPatch,
  NetworkRackPatch,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  L3IsolationDomainPatch,
  NetworkRackPatch,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  NeighborGroupPatch,
  NetworkRackPatch,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  NetworkFabricPatch,
  NetworkRackPatch,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  RoutePolicyPatch,
  NetworkRackPatch,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  NetworkPacketBrokerPatch,
  NetworkRackPatch,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  NetworkTapPatch,
  NetworkRackPatch,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  NetworkTapRulePatch,
  NetworkRackPatch,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve ResourceData base type for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  NetworkToNetworkInterconnectPatch,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  ExternalNetworkPropertiesOptionAProperties,
  Layer3IpPrefixProperties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the shipped C# inheritance hierarchy for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  ExternalNetworkPatchPropertiesOptionAProperties,
  Layer3IpPrefixProperties,
  "csharp"
);
@@access(ConnectedSubnetRoutePolicy, Access.public, "csharp");
@@access(IpCommunityIdList, Access.public, "csharp");
@@access(IpExtendedCommunityIdList, Access.public, "csharp");
@@access(ManagementNetworkPatchConfiguration, Access.public, "csharp");
@@access(PollingIntervalInSeconds, Access.public, "csharp");
@@access(TerminalServerPatchConfiguration, Access.public, "csharp");
@@clientName(
  ArmConfigurationDiffOperationResponse,
  "ArmConfigurationDiffOperationResult",
  "csharp"
);
@@clientName(
  CommitBatchStatusOperationResponse,
  "CommitBatchStatusOperationResult",
  "csharp"
);
@@clientName(CommitBatchStatusRequest, "CommitBatchStatusContent", "csharp");
@@clientName(
  CommitConfigurationRequest,
  "CommitConfigurationContent",
  "csharp"
);
@@clientName(
  CommitConfigurationResponse,
  "CommitConfigurationResult",
  "csharp"
);
@@clientName(CommonErrorResponse, "NetworkFabricErrorResult", "csharp");
@@clientName(
  DiscardCommitBatchOperationResponse,
  "DiscardCommitBatchOperationResult",
  "csharp"
);
@@clientName(DiscardCommitBatchRequest, "DiscardCommitBatchContent", "csharp");
@@clientName(
  ExternalNetworkUpdateBfdAdministrativeStateRequest,
  "ExternalNetworkUpdateBfdAdministrativeStateContent",
  "csharp"
);
@@clientName(
  ExternalNetworkUpdateBfdAdministrativeStateResponse,
  "ExternalNetworkUpdateBfdAdministrativeStateResult",
  "csharp"
);
@@clientName(GetTopologyResponse, "GetTopologyResult", "csharp");
@@clientName(
  InternalNetworkUpdateBfdAdministrativeStateRequest,
  "InternalNetworkUpdateBfdAdministrativeStateContent",
  "csharp"
);
@@clientName(
  InternalNetworkUpdateBfdAdministrativeStateResponse,
  "InternalNetworkUpdateBfdAdministrativeStateResult",
  "csharp"
);
@@clientName(
  InternalNetworkUpdateBgpAdministrativeStateRequest,
  "InternalNetworkUpdateBgpAdministrativeStateContent",
  "csharp"
);
@@clientName(
  InternalNetworkUpdateBgpAdministrativeStateResponse,
  "InternalNetworkUpdateBgpAdministrativeStateResult",
  "csharp"
);
@@clientName(
  NeighborGroupResyncResponse,
  "NeighborGroupResyncResult",
  "csharp"
);
@@clientName(
  NetworkBootstrapDeviceRebootResponse,
  "NetworkBootstrapDeviceRebootResult",
  "csharp"
);
@@clientName(
  NetworkBootstrapDeviceRefreshConfigurationResponse,
  "NetworkBootstrapDeviceRefreshConfigurationResult",
  "csharp"
);
@@clientName(
  NetworkBootstrapDeviceResyncPasswordsResponse,
  "NetworkBootstrapDeviceResyncPasswordsResult",
  "csharp"
);
@@clientName(
  NetworkBootstrapDeviceUpdateAdministrativeStateResponse,
  "NetworkBootstrapDeviceUpdateAdministrativeStateResult",
  "csharp"
);
@@clientName(
  NetworkBootstrapDeviceUpgradeResponse,
  "NetworkBootstrapDeviceUpgradeResult",
  "csharp"
);
@@clientName(
  NetworkDeviceRefreshConfigurationResponse,
  "NetworkDeviceRefreshConfigurationResult",
  "csharp"
);
@@clientName(
  NetworkDeviceResyncPasswordsResponse,
  "NetworkDeviceResyncPasswordsResult",
  "csharp"
);
@@clientName(
  NetworkDeviceRunRwCommandResponse,
  "NetworkDeviceRunRwCommandResult",
  "csharp"
);
@@clientName(
  NetworkDeviceUpdateAdministrativeStateResponse,
  "NetworkDeviceUpdateAdministrativeStateResult",
  "csharp"
);
@@clientName(
  NetworkDeviceUpgradeRequest,
  "NetworkDeviceUpgradeContent",
  "csharp"
);
@@clientName(
  NetworkDeviceUpgradeResponse,
  "NetworkDeviceUpgradeResult",
  "csharp"
);
@@clientName(NetworkFabricLockRequest, "NetworkFabricLockContent", "csharp");
@@clientName(
  NetworkFabricResyncCertificatesResponse,
  "NetworkFabricResyncCertificatesResult",
  "csharp"
);
@@clientName(
  NetworkFabricResyncPasswordsResponse,
  "NetworkFabricResyncPasswordsResult",
  "csharp"
);
@@clientName(
  NetworkFabricRotateCertificatesResponse,
  "NetworkFabricRotateCertificatesResult",
  "csharp"
);
@@clientName(
  NetworkFabricRotatePasswordsResponse,
  "NetworkFabricRotatePasswordsResult",
  "csharp"
);
@@clientName(NetworkTapResyncResponse, "NetworkTapResyncResult", "csharp");
@@clientName(
  NetworkTapRuleResyncResponse,
  "NetworkTapRuleResyncResult",
  "csharp"
);
@@clientName(
  NniUpdateBfdAdministrativeStateRequest,
  "NniUpdateBfdAdministrativeStateContent",
  "csharp"
);
@@clientName(
  NniUpdateBfdAdministrativeStateResponse,
  "NniUpdateBfdAdministrativeStateResult",
  "csharp"
);
@@clientName(
  UpdateAdministrativeStateResponse,
  "UpdateAdministrativeStateResult",
  "csharp"
);
@@clientName(
  ValidateConfigurationResponse,
  "ValidateConfigurationResult",
  "csharp"
);
@@clientName(
  ViewDeviceConfigurationOperationResponse,
  "ViewDeviceConfigurationOperationResult",
  "csharp"
);

// Rename generated C# operations whose response types changed so SDK customizations can
// preserve the shipped operation method names with compatibility return types.
@@clientName(
  NetworkInterfaces.updateAdministrativeState,
  "SetAdministrativeState"
);
@@clientName(
  NetworkDevices.updateAdministrativeState,
  "SetAdministrativeState"
);
@@clientName(NetworkDevices.reboot, "Restart");
@@clientName(NetworkDevices.refreshConfiguration, "ReloadConfiguration");
@@clientName(
  AccessControlLists.updateAdministrativeState,
  "SetAdministrativeState"
);
@@clientName(
  ExternalNetworks.updateAdministrativeState,
  "SetAdministrativeState"
);
@@clientName(
  ExternalNetworks.updateStaticRouteBfdAdministrativeState,
  "SetStaticRouteBfdAdministrativeState"
);
@@clientName(
  InternalNetworks.updateAdministrativeState,
  "SetAdministrativeState"
);
@@clientName(
  InternalNetworks.updateStaticRouteBfdAdministrativeState,
  "SetStaticRouteBfdAdministrativeState"
);
@@clientName(
  L2IsolationDomains.updateAdministrativeState,
  "SetAdministrativeState"
);
@@clientName(
  L3IsolationDomains.updateAdministrativeState,
  "SetAdministrativeState"
);
@@clientName(NetworkFabrics.commitConfiguration, "ApplyConfiguration");
@@clientName(NetworkFabrics.deprovision, "Deactivate");
@@clientName(NetworkFabrics.provision, "Activate");
@@clientName(NetworkFabrics.refreshConfiguration, "ReloadConfiguration");
@@clientName(
  NetworkFabrics.updateInfraManagementBfdConfiguration,
  "SetInfraManagementBfdConfiguration"
);
@@clientName(
  NetworkFabrics.updateWorkloadManagementBfdConfiguration,
  "SetWorkloadManagementBfdConfiguration"
);
@@clientName(NetworkFabrics.getTopology, "RetrieveTopology");
@@clientName(RoutePolicies.updateAdministrativeState, "SetAdministrativeState");
@@clientName(NetworkTaps.resync, "Synchronize");
@@clientName(NetworkTaps.updateAdministrativeState, "SetAdministrativeState");

@@clientName(
  Microsoft.ManagedNetworkFabric.IPAddressType,
  "IpAddressType",
  "java"
);

@@clientName(
  Microsoft.ManagedNetworkFabric.NetworkFabricProperties.fabricASN,
  "fabricAsn",
  "java"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.NetworkFabricPatchProperties.fabricASN,
  "fabricAsn",
  "java"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.BgpConfiguration.fabricASN,
  "fabricAsn",
  "java"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.BgpPatchConfiguration.fabricASN,
  "fabricAsn",
  "java"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.ExternalNetworkPropertiesOptionAProperties.fabricASN,
  "fabricAsn",
  "java"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.ExternalNetworkPatchPropertiesOptionAProperties.fabricASN,
  "fabricAsn",
  "java"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.OptionBLayer3Configuration.fabricASN,
  "fabricAsn",
  "java"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.OptionBLayer3ConfigurationPatchProperties.fabricASN,
  "fabricAsn",
  "java"
);

@@clientName(
  Microsoft.ManagedNetworkFabric.BgpConfiguration.peerASN,
  "peerAsn",
  "java"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.BgpPatchConfiguration.peerASN,
  "peerAsn",
  "java"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.ExternalNetworkPropertiesOptionAProperties.peerASN,
  "peerAsn",
  "java"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.ExternalNetworkPatchPropertiesOptionAProperties.peerASN,
  "peerAsn",
  "java"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.OptionBLayer3Configuration.peerASN,
  "peerAsn",
  "java"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.OptionBLayer3ConfigurationPatchProperties.peerASN,
  "peerAsn",
  "java"
);
