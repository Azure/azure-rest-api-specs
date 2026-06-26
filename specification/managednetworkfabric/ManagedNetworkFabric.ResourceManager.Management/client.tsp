import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Azure.ResourceManager.Foundations;
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
@@clientName(
  DestinationPatchProperties,
  "NetworkTapDestinationPatchProperties",
  "csharp"
);
@@clientName(Encapsulation, "IsolationDomainEncapsulationType", "csharp");
@@clientName(Encapsulation.GRE, "Gre", "csharp");
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
@@clientName(IpGroupPatchProperties, "IPGroupPatchProperties", "csharp");
@@clientName(IpMatchConditionPatch, "IPMatchConditionPatch", "csharp");
@@clientName(
  ActionIpCommunityPatchProperties,
  "ActionIPCommunityPatchProperties",
  "csharp"
);
@@clientName(
  ActionIpExtendedCommunityPatchProperties,
  "ActionIPExtendedCommunityPatchProperties",
  "csharp"
);
@@clientName(Condition, "IPPrefixRuleCondition", "csharp");
@@clientName(WellKnownCommunities, "WellKnownCommunity", "csharp");
@@clientName(InterfaceType, "NetworkDeviceInterfaceType", "csharp");
@@clientName(NfcSku, "NetworkFabricControllerSKU", "csharp");
@@clientName(PollingIntervalInSeconds, "PollingIntervalInSecond", "csharp");
@@clientName(PollingType, "NetworkTapPollingType", "csharp");
@@clientName(PortCondition, "NetworkFabricPortCondition", "csharp");
@@clientName(PortConditionPatch, "NetworkFabricPortConditionPatch", "csharp");
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
@@clientName(TagsUpdate, "ManagedNetworkFabricResourcePatch", "csharp");
@@clientName(VpnOptionBProperties, "OptionBProperties", "csharp");
@@clientName(AdministrativeState.MAT, "Mat", "csharp");
@@clientName(AdministrativeState.RMA, "Rma", "csharp");
@@clientName(BfdAdministrativeState.MAT, "Mat", "csharp");
@@clientName(BfdAdministrativeState.RMA, "Rma", "csharp");
@@clientName(DeviceAdministrativeState.RMA, "Rma", "csharp");
@@clientName(
  DeviceAdministrativeState.UngracefulRMA,
  "UngracefulRma",
  "csharp"
);
@@clientName(
  RebootType.GracefulRebootWithZTP,
  "GracefulRebootWithZtp",
  "csharp"
);
@@clientName(
  RebootType.GracefulRebootWithoutZTP,
  "GracefulRebootWithoutZtp",
  "csharp"
);
@@clientName(
  RebootType.UngracefulRebootWithZTP,
  "UngracefulRebootWithZtp",
  "csharp"
);
@@clientName(
  RebootType.UngracefulRebootWithoutZTP,
  "UngracefulRebootWithoutZtp",
  "csharp"
);
@@clientName(NetworkDeviceRole.NPB, "Npb", "csharp");
@@clientName(NetworkDeviceRoleName.NPB, "Npb", "csharp");
@@clientName(DeviceRole.NPB, "Npb", "csharp");
@@clientName(PollingIntervalInSeconds.OneTwenty, "OneHundredTwenty", "csharp");
@@clientName(BmpMonitoredAddressFamily.ipv4Unicast, "IPv4Unicast", "csharp");
@@clientName(BmpMonitoredAddressFamily.ipv6Unicast, "IPv6Unicast", "csharp");
@@clientName(BmpMonitoredAddressFamily.vpnIpv4, "VpnIPv4", "csharp");
@@clientName(BmpMonitoredAddressFamily.vpnIpv6, "VpnIPv6", "csharp");
@@clientName(Layer4Protocol.TCP, "Tcp", "csharp");
@@clientName(Layer4Protocol.UDP, "Udp", "csharp");
@@clientName(Layer4Protocol.SCTP, "Sctp", "csharp");
@@clientName(
  Microsoft.ManagedNetworkFabric.AclType,
  "NetworkFabricAclType",
  "csharp"
);
@@clientName(BitRate, "NetworkFabricBitRate", "csharp");
@@clientName(BitRateUnit, "NetworkFabricBitRateUnit", "csharp");
@@clientName(BurstSize, "NetworkFabricBurstSize", "csharp");
@@clientName(BurstSizeUnit, "NetworkFabricBurstSizeUnit", "csharp");
@@clientName(
  ControlPlaneAclTtlMatchCondition,
  "ControlPlaneAclTimeToLiveMatchCondition",
  "csharp"
);
@@clientName(
  ControlPlaneAclTtlMatchConditionPatch,
  "ControlPlaneAclTimeToLiveMatchConditionPatch",
  "csharp"
);
@@clientName(
  ControlPlaneAclTtlMatchType,
  "ControlPlaneAclTimeToLiveMatchType",
  "csharp"
);
@@clientName(ControlPlaneAclPortMatchType.Equals, "EqualsValue", "csharp");
@@clientName(ControlPlaneAclTtlMatchType.Equals, "EqualsValue", "csharp");
@@clientName(CommitBatchState, "NetworkFabricCommitBatchState", "csharp");
@@clientName(
  CommitConfigurationPolicy,
  "NetworkFabricCommitConfigurationPolicy",
  "csharp"
);
@@clientName(CommitStage, "NetworkFabricCommitStage", "csharp");
@@clientName(
  Microsoft.ManagedNetworkFabric.DeviceRole,
  "NetworkFabricDeviceRole",
  "csharp"
);
@@clientName(DeviceRoCommand, "NetworkFabricDeviceReadOnlyCommand", "csharp");
@@clientName(DeviceRwCommand, "NetworkFabricDeviceReadWriteCommand", "csharp");
@@clientName(ExtendedVlan, "NetworkFabricExtendedVlan", "csharp");
@@clientName(FabricLockProperties, "NetworkFabricLock", "csharp");
@@clientName(FeatureFlagProperties, "NetworkFabricFeatureFlag", "csharp");
@@clientName(HeaderAddressProperties, "NetworkFabricHeaderAddress", "csharp");
@@clientName(
  Microsoft.ManagedNetworkFabric.IdentitySelector,
  "NetworkFabricIdentitySelector",
  "csharp"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.IdentitySelectorPatch,
  "NetworkFabricIdentitySelectorPatch",
  "csharp"
);
@@clientName(
  LockConfigurationState,
  "NetworkFabricLockConfigurationState",
  "csharp"
);
@@clientName(
  ManagedServiceIdentityPatch,
  "NetworkFabricManagedServiceIdentityPatch",
  "csharp"
);
@@clientName(ManagedServiceIdentity.type, "IdentityType", "csharp");
@@clientName(
  ManagedServiceIdentitySelectorType,
  "NetworkFabricManagedIdentitySelectorType",
  "csharp"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.MicroBfdState,
  "NetworkFabricMicroBfdState",
  "csharp"
);
@@clientName(
  QosConfigurationState,
  "NetworkFabricQosConfigurationState",
  "csharp"
);
@@clientName(RouteType, "NetworkFabricRouteType", "csharp");
@@clientName(RuleCondition, "NetworkFabricRuleCondition", "csharp");
@@clientName(
  NNIDerivedUniqueRouteDistinguisherConfigurationState,
  "NniDerivedUniqueRouteDistinguisherConfigurationState",
  "csharp"
);
@@clientName(
  StationConfigurationState,
  "NetworkFabricStationConfigurationState",
  "csharp"
);
@@clientName(
  StationConnectionMode,
  "NetworkFabricStationConnectionMode",
  "csharp"
);
@@clientName(
  SynchronizationStatus,
  "NetworkFabricSynchronizationStatus",
  "csharp"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.SecretRotationStatus,
  "NetworkFabricSecretRotationStatus",
  "csharp"
);
@@clientName(
  SecretArchiveReference,
  "NetworkFabricSecretArchiveReference",
  "csharp"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.CertificateRotationStatus,
  "NetworkFabricCertificateRotationStatus",
  "csharp"
);
@@clientName(
  CertificateArchiveReference,
  "NetworkFabricCertificateArchiveReference",
  "csharp"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.V4OverV6BgpSessionState,
  "NetworkFabricV4OverV6BgpSessionState",
  "csharp"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.V6OverV4BgpSessionState,
  "NetworkFabricV6OverV4BgpSessionState",
  "csharp"
);
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
@@clientName(IpMatchCondition.type, "SourceDestinationType", "csharp");
@@clientName(PrefixType, "IPMatchConditionPrefixType", "csharp");
@@clientName(AccessControlListAction.type, "AclActionType", "csharp");
@@clientName(
  AccessControlListPatch,
  "NetworkFabricAccessControlListPatchContent",
  "csharp"
);
@@clientName(
  InternetGatewayPatch,
  "NetworkFabricInternetGatewayPatchContent",
  "csharp"
);
@@clientName(
  InternetGatewayRulePatch,
  "NetworkFabricInternetGatewayRulePatchContent",
  "csharp"
);
@@clientName(
  IpCommunityPatch,
  "NetworkFabricIPCommunityPatchContent",
  "csharp"
);
@@clientName(
  IpExtendedCommunityPatch,
  "NetworkFabricIPExtendedCommunityPatchContent",
  "csharp"
);
@@clientName(IpPrefixPatch, "NetworkFabricIPPrefixPatchContent", "csharp");
@@clientName(
  L2IsolationDomainPatch,
  "NetworkFabricL2IsolationDomainPatchContent",
  "csharp"
);
@@clientName(
  L3IsolationDomainPatch,
  "NetworkFabricL3IsolationDomainPatchContent",
  "csharp"
);
@@clientName(
  NeighborGroupPatch,
  "NetworkFabricNeighborGroupPatchContent",
  "csharp"
);
@@clientName(
  NetworkDevicePatchParameters,
  "NetworkDevicePatchContent",
  "csharp"
);
@@clientName(
  NetworkBootstrapDevicePatch,
  "NetworkBootstrapDevicePatchContent",
  "csharp"
);
@@clientName(NetworkFabricPatch, "NetworkFabricPatchContent", "csharp");
@@clientName(
  NetworkFabricControllerPatch,
  "NetworkFabricControllerPatchContent",
  "csharp"
);
@@clientName(NetworkMonitorPatch, "NetworkMonitorPatchContent", "csharp");
@@clientName(
  NetworkPacketBrokerPatch,
  "NetworkPacketBrokerPatchContent",
  "csharp"
);
@@clientName(NetworkTapPatch, "NetworkTapPatchContent", "csharp");
@@clientName(NetworkTapRulePatch, "NetworkTapRulePatchContent", "csharp");
@@clientName(
  RoutePolicyPatch,
  "NetworkFabricRoutePolicyPatchContent",
  "csharp"
);
@@clientName(Layer3IpPrefixProperties, "Layer3IPPrefixProperties", "csharp");
@@clientName(
  Layer3IpPrefixProperties.primaryIpv4Prefix,
  "PrimaryIPv4Prefix",
  "csharp"
);
@@clientName(
  Layer3IpPrefixProperties.primaryIpv6Prefix,
  "PrimaryIPv6Prefix",
  "csharp"
);
@@clientName(
  Layer3IpPrefixProperties.secondaryIpv4Prefix,
  "SecondaryIPv4Prefix",
  "csharp"
);
@@clientName(
  Layer3IpPrefixProperties.secondaryIpv6Prefix,
  "SecondaryIPv6Prefix",
  "csharp"
);
@@clientName(
  Layer3IpPrefixPatchProperties,
  "Layer3IPPrefixPatchProperties",
  "csharp"
);
@@clientName(
  Layer3IpPrefixPatchProperties.primaryIpv4Prefix,
  "PrimaryIPv4Prefix",
  "csharp"
);
@@clientName(
  Layer3IpPrefixPatchProperties.primaryIpv6Prefix,
  "PrimaryIPv6Prefix",
  "csharp"
);
@@clientName(
  Layer3IpPrefixPatchProperties.secondaryIpv4Prefix,
  "SecondaryIPv4Prefix",
  "csharp"
);
@@clientName(
  Layer3IpPrefixPatchProperties.secondaryIpv6Prefix,
  "SecondaryIPv6Prefix",
  "csharp"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.ManagementNetworkConfigurationProperties,
  "ManagementNetworkConfigurationProperties",
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
  "NetworkFabricTerminalServerConfiguration",
  "csharp"
);
@@clientName(
  TerminalServerPatchConfiguration,
  "NetworkFabricTerminalServerPatchConfiguration",
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
@@clientName(
  InternalNetworkProperties.bgpConfiguration,
  "BgpSettings",
  "csharp"
);

@@clientName(
  InternalNetworkProperties.staticRouteConfiguration,
  "StaticRouteSettings",
  "csharp"
);

@@clientName(
  NetworkToNetworkInterconnectProperties.optionBLayer3Configuration,
  "OptionBLayer3Settings",
  "csharp"
);

@@clientName(
  NetworkFabricProperties.terminalServerConfiguration,
  "TerminalServerSettings",
  "csharp"
);

@@clientName(
  NetworkTapProperties.destinations,
  "DestinationSettings",
  "csharp"
);

@@clientName(
  NetworkTapPatchProperties.destinations,
  "DestinationSettings",
  "csharp"
);

@@clientName(
  NetworkFabricPatchableProperties.terminalServerConfiguration,
  "TerminalServerSettings",
  "csharp"
);

@@clientName(
  VpnConfigurationProperties.optionAProperties,
  "OptionASettings",
  "csharp"
);

@@clientName(
  VpnConfigurationPatchableProperties.optionAProperties,
  "OptionASettings",
  "csharp"
);

@@clientName(
  InternalNetworkPatchProperties.bgpConfiguration,
  "BgpSettings",
  "csharp"
);
@@clientName(
  InternalNetworkPatchProperties.staticRouteConfiguration,
  "StaticRouteSettings",
  "csharp"
);
@@clientName(
  InternalNetworkPatchProperties.connectedIPv4Subnets,
  "ConnectedIPv4SubnetSettings",
  "csharp"
);
@@clientName(
  InternalNetworkPatchProperties.connectedIPv6Subnets,
  "ConnectedIPv6SubnetSettings",
  "csharp"
);
@@clientName(
  ConnectedSubnetPatch,
  "NetworkFabricConnectedSubnetPatch",
  "csharp"
);
@@clientName(
  NetworkToNetworkInterconnectPatchProperties.layer2Configuration,
  "Layer2Settings",
  "csharp"
);
@@clientName(
  NetworkToNetworkInterconnectPatchProperties.optionBLayer3Configuration,
  "OptionBLayer3Settings",
  "csharp"
);
@@clientName(
  NetworkToNetworkInterconnectPatchProperties.npbStaticRouteConfiguration,
  "NpbStaticRouteSettings",
  "csharp"
);
@@clientName(
  NetworkToNetworkInterconnectPatchProperties.importRoutePolicy,
  "ImportRoutePolicySettings",
  "csharp"
);
@@clientName(
  NetworkToNetworkInterconnectPatchProperties.exportRoutePolicy,
  "ExportRoutePolicySettings",
  "csharp"
);
@@clientName(
  ExternalNetworkPatchProperties.optionBProperties,
  "OptionBSettings",
  "csharp"
);
@@clientName(
  ExternalNetworkPatchProperties.importRoutePolicy,
  "ImportRoutePolicySettings",
  "csharp"
);
@@clientName(
  ExternalNetworkPatchProperties.exportRoutePolicy,
  "ExportRoutePolicySettings",
  "csharp"
);
@@clientName(
  L3IsolationDomainPatchProperties.aggregateRouteConfiguration,
  "AggregateRouteSettings",
  "csharp"
);
@@clientName(
  L3IsolationDomainPatchProperties.connectedSubnetRoutePolicy,
  "ConnectedSubnetRoutePolicySettings",
  "csharp"
);
@@clientName(
  NeighborGroupPatchProperties.destination,
  "DestinationSettings",
  "csharp"
);
@@clientName(
  AccessControlListPatchProperties.matchConfigurations,
  "MatchConfigurationSettings",
  "csharp"
);
@@clientName(
  AccessControlListPatchProperties.dynamicMatchConfigurations,
  "DynamicMatchConfigurationSettings",
  "csharp"
);
@@clientName(
  NetworkTapRulePatchProperties.matchConfigurations,
  "MatchConfigurationSettings",
  "csharp"
);
@@clientName(
  NetworkTapRulePatchProperties.dynamicMatchConfigurations,
  "DynamicMatchConfigurationSettings",
  "csharp"
);
@@alternateType(
  NetworkTapRuleProperties.networkTapId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(
  NetworkTapRuleProperties.pollingIntervalInSeconds,
  "PollingIntervalInSecond",
  "csharp"
);
@@clientName(
  RoutePolicyPatchableProperties.statements,
  "StatementSettings",
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
  StatementConditionProperties.ipCommunityIds,
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
@@alternateType(
  NetworkDeviceProperties.managementIpv4Address,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(
  NetworkDeviceProperties.networkRackId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  NetworkInterfaceProperties.ipv4Address,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(
  NeighborGroupDestination.ipv4Addresses,
  Azure.Core.ipV4Address[],
  "csharp"
);
@@alternateType(
  CommonPostActionResponseForDeviceROCommands.outputUrl,
  url,
  "csharp"
);
@@alternateType(
  CommonPostActionResponseForDeviceRWCommands.outputUrl,
  url,
  "csharp"
);
@@alternateType(
  ArmConfigurationDiffResponseProperties.configurationDiffUrl,
  url,
  "csharp"
);
@@alternateType(
  ViewDeviceConfigurationResponseProperties.deviceConfigurationUrl,
  url,
  "csharp"
);
@@clientName(
  CommonPostActionResponseForDeviceROCommands.outputUrl,
  "OutputUri",
  "csharp"
);
@@clientName(
  CommonPostActionResponseForDeviceRWCommands.outputUrl,
  "OutputUri",
  "csharp"
);
@@clientName(
  ArmConfigurationDiffResponseProperties.configurationDiffUrl,
  "ConfigurationDiffUri",
  "csharp"
);
@@clientName(
  ViewDeviceConfigurationResponseProperties.deviceConfigurationUrl,
  "DeviceConfigurationUri",
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
@@clientName(ControlPlaneAclAction.type, "ActionType", "csharp");
@@clientName(ControlPlaneAclActionPatch.type, "ActionType", "csharp");
@@clientName(
  ControlPlaneAclMatchCondition.ttlMatchCondition,
  "TimeToLiveMatchCondition",
  "csharp"
);
@@clientName(
  ControlPlaneAclMatchConditionPatch.ttlMatchCondition,
  "TimeToLiveMatchCondition",
  "csharp"
);
@@clientName(
  ControlPlaneAclTtlMatchCondition.ttlValue,
  "TimeToLiveInHops",
  "csharp"
);
@@clientName(
  ControlPlaneAclTtlMatchCondition.ttlMatchType,
  "TimeToLiveMatchType",
  "csharp"
);
@@clientName(
  ControlPlaneAclTtlMatchConditionPatch.ttlValue,
  "TimeToLiveInHops",
  "csharp"
);
@@clientName(
  ControlPlaneAclTtlMatchConditionPatch.ttlMatchType,
  "TimeToLiveMatchType",
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
  NpbStaticRouteConfigurationPatch.ipv4Routes,
  "IPv4Routes",
  "csharp"
);
@@clientName(
  NpbStaticRouteConfigurationPatch.ipv6Routes,
  "IPv6Routes",
  "csharp"
);
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
  RouteTargetPatchInformation.exportIpv4RouteTargets,
  "ExportIPv4RouteTargets",
  "csharp"
);
@@clientName(
  RouteTargetPatchInformation.exportIpv6RouteTargets,
  "ExportIPv6RouteTargets",
  "csharp"
);
@@clientName(
  RouteTargetPatchInformation.importIpv4RouteTargets,
  "ImportIPv4RouteTargets",
  "csharp"
);
@@clientName(
  RouteTargetPatchInformation.importIpv6RouteTargets,
  "ImportIPv6RouteTargets",
  "csharp"
);
@@clientName(
  NetworkTapRuleMatchConfiguration.ipAddressType,
  "IPAddressType",
  "csharp"
);
@@clientName(NetworkTapRuleAction.type, "TapRuleActionType", "csharp");
@@clientName(BgpConfiguration.fabricASN, "FabricAsn", "csharp");
@@clientName(BgpConfiguration.peerASN, "PeerAsn", "csharp");
@@clientName(BgpPatchConfiguration.fabricASN, "FabricAsn", "csharp");
@@clientName(BgpPatchConfiguration.peerASN, "PeerAsn", "csharp");
@@clientName(
  ConditionalDefaultRouteProperties.ipv4Routes,
  "IPv4Routes",
  "csharp"
);
@@clientName(
  ConditionalDefaultRouteProperties.ipv6Routes,
  "IPv6Routes",
  "csharp"
);
@@clientName(AggregateRouteConfiguration.ipv4Routes, "IPv4Routes", "csharp");
@@clientName(AggregateRouteConfiguration.ipv6Routes, "IPv6Routes", "csharp");
@@clientName(
  AggregateRoutePatchConfiguration.ipv4Routes,
  "IPv4Routes",
  "csharp"
);
@@clientName(
  AggregateRoutePatchConfiguration.ipv6Routes,
  "IPv6Routes",
  "csharp"
);
@@clientName(
  ControllerServices.ipv4AddressSpaces,
  "IPv4AddressSpaces",
  "csharp"
);
@@clientName(
  ControllerServices.ipv6AddressSpaces,
  "IPv6AddressSpaces",
  "csharp"
);
@@clientName(
  NetworkFabricControllerProperties.ipv4AddressSpace,
  "IPv4AddressSpace",
  "csharp"
);
@@clientName(
  NetworkFabricControllerProperties.ipv6AddressSpace,
  "IPv6AddressSpace",
  "csharp"
);
@@clientName(
  NetworkFabricControllerProperties.workloadManagementNetwork,
  "IsWorkloadManagementNetwork",
  "csharp"
);
@@clientName(NniStaticRouteConfiguration.ipv4Routes, "IPv4Routes", "csharp");
@@clientName(NniStaticRouteConfiguration.ipv6Routes, "IPv6Routes", "csharp");
@@clientName(
  NniStaticRoutePatchConfiguration.ipv4Routes,
  "IPv4Routes",
  "csharp"
);
@@clientName(
  NniStaticRoutePatchConfiguration.ipv6Routes,
  "IPv6Routes",
  "csharp"
);
@@clientName(StaticRoutePatchConfiguration.ipv4Routes, "IPv4Routes", "csharp");
@@clientName(StaticRoutePatchConfiguration.ipv6Routes, "IPv6Routes", "csharp");
@@clientName(
  ExternalNetworkStaticRouteConfiguration.ipv4Routes,
  "IPv4Routes",
  "csharp"
);
@@clientName(
  ExternalNetworkStaticRouteConfiguration.ipv6Routes,
  "IPv6Routes",
  "csharp"
);
@@clientName(
  ExternalNetworkStaticRoutePatchConfiguration.ipv4Routes,
  "IPv4Routes",
  "csharp"
);
@@clientName(
  ExternalNetworkStaticRoutePatchConfiguration.ipv6Routes,
  "IPv6Routes",
  "csharp"
);
@@clientName(
  ExternalNetworkPropertiesOptionAProperties.fabricASN,
  "FabricAsn",
  "csharp"
);
@@clientName(
  ExternalNetworkPropertiesOptionAProperties.peerASN,
  "PeerAsn",
  "csharp"
);
@@clientName(
  ExternalNetworkPropertiesOptionAProperties.nativeIpv4PrefixLimit,
  "NativeIPv4PrefixLimit",
  "csharp"
);
@@clientName(
  ExternalNetworkPropertiesOptionAProperties.nativeIpv6PrefixLimit,
  "NativeIPv6PrefixLimit",
  "csharp"
);
@@clientName(
  ExternalNetworkPatchPropertiesOptionAProperties.fabricASN,
  "FabricAsn",
  "csharp"
);
@@clientName(
  ExternalNetworkPatchPropertiesOptionAProperties.peerASN,
  "PeerAsn",
  "csharp"
);
@@clientName(
  ExternalNetworkPatchPropertiesOptionAProperties.nativeIpv4PrefixLimit,
  "NativeIPv4PrefixLimit",
  "csharp"
);
@@clientName(
  ExternalNetworkPatchPropertiesOptionAProperties.nativeIpv6PrefixLimit,
  "NativeIPv6PrefixLimit",
  "csharp"
);
@@clientName(L3OptionAProperties.peerASN, "PeerAsn", "csharp");
@@clientName(VpnOptionAProperties.peerASN, "PeerAsn", "csharp");
@@clientName(VpnOptionAPatchProperties.peerASN, "PeerAsn", "csharp");
@@clientName(OptionBLayer3Configuration.fabricASN, "FabricAsn", "csharp");
@@clientName(OptionBLayer3Configuration.peerASN, "PeerAsn", "csharp");
@@clientName(
  OptionBLayer3ConfigurationPatchProperties.fabricASN,
  "FabricAsn",
  "csharp"
);
@@clientName(
  OptionBLayer3ConfigurationPatchProperties.peerASN,
  "PeerAsn",
  "csharp"
);
@@clientName(
  OptionBLayer3Configuration.peLoopbackIpAddress,
  "PeLoopbackIPAddress",
  "csharp"
);
@@clientName(
  OptionBLayer3ConfigurationPatchProperties.peLoopbackIpAddress,
  "PeLoopbackIPAddress",
  "csharp"
);
@@clientName(
  ImportRoutePolicy.importIpv4RoutePolicyId,
  "ImportIPv4RoutePolicyId",
  "csharp"
);
@@clientName(
  ImportRoutePolicy.importIpv6RoutePolicyId,
  "ImportIPv6RoutePolicyId",
  "csharp"
);
@@clientName(
  ImportRoutePolicyInformation.importIpv4RoutePolicyId,
  "ImportIPv4RoutePolicyId",
  "csharp"
);
@@clientName(
  ImportRoutePolicyInformation.importIpv6RoutePolicyId,
  "ImportIPv6RoutePolicyId",
  "csharp"
);
@@clientName(
  ImportRoutePolicyPatch.importIpv4RoutePolicyId,
  "ImportIPv4RoutePolicyId",
  "csharp"
);
@@clientName(
  ImportRoutePolicyPatch.importIpv6RoutePolicyId,
  "ImportIPv6RoutePolicyId",
  "csharp"
);
@@clientName(
  ImportRoutePolicyInformationPatch.importIpv4RoutePolicyId,
  "ImportIPv4RoutePolicyId",
  "csharp"
);
@@clientName(
  ImportRoutePolicyInformationPatch.importIpv6RoutePolicyId,
  "ImportIPv6RoutePolicyId",
  "csharp"
);
@@clientName(
  ExportRoutePolicy.exportIpv4RoutePolicyId,
  "ExportIPv4RoutePolicyId",
  "csharp"
);
@@clientName(
  ExportRoutePolicy.exportIpv6RoutePolicyId,
  "ExportIPv6RoutePolicyId",
  "csharp"
);
@@clientName(
  ExportRoutePolicyInformation.exportIpv4RoutePolicyId,
  "ExportIPv4RoutePolicyId",
  "csharp"
);
@@clientName(
  ExportRoutePolicyInformation.exportIpv6RoutePolicyId,
  "ExportIPv6RoutePolicyId",
  "csharp"
);
@@clientName(
  ExportRoutePolicyPatch.exportIpv4RoutePolicyId,
  "ExportIPv4RoutePolicyId",
  "csharp"
);
@@clientName(
  ExportRoutePolicyPatch.exportIpv6RoutePolicyId,
  "ExportIPv6RoutePolicyId",
  "csharp"
);
@@clientName(
  ExportRoutePolicyInformationPatch.exportIpv4RoutePolicyId,
  "ExportIPv4RoutePolicyId",
  "csharp"
);
@@clientName(
  ExportRoutePolicyInformationPatch.exportIpv6RoutePolicyId,
  "ExportIPv6RoutePolicyId",
  "csharp"
);
@@clientName(
  L3ExportRoutePolicy.exportIpv4RoutePolicyId,
  "ExportIPv4RoutePolicyId",
  "csharp"
);
@@clientName(
  L3ExportRoutePolicy.exportIpv6RoutePolicyId,
  "ExportIPv6RoutePolicyId",
  "csharp"
);
@@clientName(
  L3ExportRoutePolicyPatch.exportIpv4RoutePolicyId,
  "ExportIPv4RoutePolicyId",
  "csharp"
);
@@clientName(
  L3ExportRoutePolicyPatch.exportIpv6RoutePolicyId,
  "ExportIPv6RoutePolicyId",
  "csharp"
);
@@clientName(
  L3IsolationDomainProperties.v4routePrefixLimit,
  "V4RoutePrefixLimit",
  "csharp"
);
@@clientName(
  L3IsolationDomainProperties.v6routePrefixLimit,
  "V6RoutePrefixLimit",
  "csharp"
);
@@clientName(
  L3IsolationDomainPatchProperties.v4routePrefixLimit,
  "V4RoutePrefixLimit",
  "csharp"
);
@@clientName(
  L3IsolationDomainPatchProperties.v6routePrefixLimit,
  "V6RoutePrefixLimit",
  "csharp"
);
@@clientName(
  StaticRouteRoutePolicy.exportRoutePolicy,
  "StaticRouteExportRoutePolicy",
  "csharp"
);
@@clientName(
  StaticRouteRoutePolicyPatch.exportRoutePolicy,
  "StaticRouteExportRoutePolicy",
  "csharp"
);
@@clientName(
  StatementConditionProperties.ipCommunityIds,
  "IPCommunityIds",
  "csharp"
);
@@clientName(
  StatementConditionProperties.ipExtendedCommunityIds,
  "IPExtendedCommunityIds",
  "csharp"
);
@@clientName(StatementConditionProperties.ipPrefixId, "IPPrefixId", "csharp");
@@clientName(
  StatementConditionPatchProperties.ipPrefixId,
  "IPPrefixId",
  "csharp"
);
@@clientName(
  StatementConditionPatchProperties.ipCommunityIds,
  "IPCommunityIds",
  "csharp"
);
@@clientName(
  StatementConditionPatchProperties.ipExtendedCommunityIds,
  "IPExtendedCommunityIds",
  "csharp"
);
@@clientName(IpCommunityIdList.ipCommunityIds, "IPCommunityIds", "csharp");
@@clientName(
  IpExtendedCommunityIdList.ipExtendedCommunityIds,
  "IPExtendedCommunityIds",
  "csharp"
);
@@clientName(IpMatchCondition.ipGroupNames, "IPGroupNames", "csharp");
@@clientName(IpMatchCondition.ipPrefixValues, "IPPrefixValues", "csharp");
@@clientName(IpMatchConditionPatch.ipGroupNames, "IPGroupNames", "csharp");
@@clientName(IpMatchConditionPatch.ipPrefixValues, "IPPrefixValues", "csharp");
@@clientName(CommonDynamicMatchConfiguration.ipGroups, "IPGroups", "csharp");
@@clientName(
  CommonDynamicMatchConfigurationPatch.ipGroups,
  "IPGroups",
  "csharp"
);
@@clientName(CommonMatchConditions.ipCondition, "IPCondition", "csharp");
@@clientName(CommonMatchConditionsPatch.ipCondition, "IPCondition", "csharp");
@@clientName(
  AccessControlListMatchConfiguration.ipAddressType,
  "IPAddressType",
  "csharp"
);
@@clientName(
  AccessControlListMatchConfigurationPatch.ipAddressType,
  "IPAddressType",
  "csharp"
);
@@clientName(AccessControlListMatchCondition.ipLengths, "IPLengths", "csharp");
@@clientName(
  AccessControlListMatchConditionPatch.ipLengths,
  "IPLengths",
  "csharp"
);
@@clientName(
  ControlPlaneAclProperties.ipAddressType,
  "IPAddressType",
  "csharp"
);
@@clientName(
  ControlPlaneAclPatchProperties.ipAddressType,
  "IPAddressType",
  "csharp"
);
@@clientName(
  ControlPlaneAclMatchCondition.ipCondition,
  "IPCondition",
  "csharp"
);
@@clientName(
  ControlPlaneAclMatchConditionPatch.ipCondition,
  "IPCondition",
  "csharp"
);
@@clientName(
  ControlPlanAclIpMatchCondition,
  "ControlPlanAclIPMatchCondition",
  "csharp"
);
@@clientName(
  ControlPlaneAclIpMatchConditionPatch,
  "ControlPlaneAclIPMatchConditionPatch",
  "csharp"
);
@@clientName(
  ControlPlanAclIpMatchCondition.sourceIpPrefix,
  "SourceIPPrefix",
  "csharp"
);
@@clientName(
  ControlPlanAclIpMatchCondition.destinationIpPrefix,
  "DestinationIPPrefix",
  "csharp"
);
@@clientName(
  ControlPlaneAclIpMatchConditionPatch.sourceIpPrefix,
  "SourceIPPrefix",
  "csharp"
);
@@clientName(
  ControlPlaneAclIpMatchConditionPatch.destinationIpPrefix,
  "DestinationIPPrefix",
  "csharp"
);
@@clientName(IpGroupProperties.ipAddressType, "IPAddressType", "csharp");
@@clientName(IpGroupProperties.ipPrefixes, "IPPrefixes", "csharp");
@@clientName(IpGroupPatchProperties.ipAddressType, "IPAddressType", "csharp");
@@clientName(IpGroupPatchProperties.ipPrefixes, "IPPrefixes", "csharp");
@@clientName(NetworkFabricProperties.fabricASN, "FabricAsn", "csharp");
@@clientName(NetworkFabricProperties.ipv4Prefix, "IPv4Prefix", "csharp");
@@clientName(NetworkFabricProperties.ipv6Prefix, "IPv6Prefix", "csharp");
@@clientName(
  NetworkFabricProperties.trustedIpPrefixes,
  "TrustedIPPrefixes",
  "csharp"
);
@@clientName(NetworkFabricPatchableProperties.fabricASN, "FabricAsn", "csharp");
@@clientName(
  NetworkFabricPatchableProperties.ipv4Prefix,
  "IPv4Prefix",
  "csharp"
);
@@clientName(
  NetworkFabricPatchableProperties.ipv6Prefix,
  "IPv6Prefix",
  "csharp"
);
@@clientName(
  NetworkFabricPatchProperties.trustedIpPrefixes,
  "TrustedIPPrefixes",
  "csharp"
);
@@clientName(
  TerminalServerConfiguration.primaryIpv4Prefix,
  "PrimaryIPv4Prefix",
  "csharp"
);
@@clientName(
  TerminalServerConfiguration.primaryIpv6Prefix,
  "PrimaryIPv6Prefix",
  "csharp"
);
@@clientName(
  TerminalServerConfiguration.secondaryIpv4Prefix,
  "SecondaryIPv4Prefix",
  "csharp"
);
@@clientName(
  TerminalServerConfiguration.secondaryIpv6Prefix,
  "SecondaryIPv6Prefix",
  "csharp"
);
@@clientName(
  TerminalServerPatchConfiguration.primaryIpv4Prefix,
  "PrimaryIPv4Prefix",
  "csharp"
);
@@clientName(
  TerminalServerPatchConfiguration.primaryIpv6Prefix,
  "PrimaryIPv6Prefix",
  "csharp"
);
@@clientName(
  TerminalServerPatchConfiguration.secondaryIpv4Prefix,
  "SecondaryIPv4Prefix",
  "csharp"
);
@@clientName(
  TerminalServerPatchConfiguration.secondaryIpv6Prefix,
  "SecondaryIPv6Prefix",
  "csharp"
);
@@clientName(
  IpCommunityProperties.ipCommunityRules,
  "IPCommunityRules",
  "csharp"
);
@@clientName(
  IpCommunityPatchableProperties.ipCommunityRules,
  "IPCommunityRules",
  "csharp"
);
@@clientName(NetworkFabricSkuProperties.type, "TypePropertiesType", "csharp");
@@clientName(
  IpExtendedCommunityPatchableProperties.ipExtendedCommunityRules,
  "IPExtendedCommunityRules",
  "csharp"
);
@@clientName(
  IpExtendedCommunityPatchProperties.ipExtendedCommunityRules,
  "IPExtendedCommunityRules",
  "csharp"
);
@@clientName(
  StatementActionPatchProperties.ipCommunityProperties,
  "IPCommunityProperties",
  "csharp"
);
@@clientName(
  StatementActionPatchProperties.ipExtendedCommunityProperties,
  "IPExtendedCommunityProperties",
  "csharp"
);
@@clientName(IpPrefixProperties.ipPrefixRules, "IPPrefixRules", "csharp");
@@clientName(
  IpPrefixPatchableProperties.ipPrefixRules,
  "IPPrefixRules",
  "csharp"
);
@@clientName(
  NetworkTapRuleMatchConfigurationPatch.ipAddressType,
  "IPAddressType",
  "csharp"
);
@@clientName(
  InternalNetworkProperties.nativeIpv4PrefixLimit,
  "NativeIPv4PrefixLimit",
  "csharp"
);
@@clientName(
  InternalNetworkProperties.nativeIpv6PrefixLimit,
  "NativeIPv6PrefixLimit",
  "csharp"
);
@@clientName(
  InternalNetworkPatchProperties.nativeIpv4PrefixLimit,
  "NativeIPv4PrefixLimit",
  "csharp"
);
@@clientName(
  InternalNetworkPatchProperties.nativeIpv6PrefixLimit,
  "NativeIPv6PrefixLimit",
  "csharp"
);
@@clientName(
  InternalNetworkBmpProperties.neighborIpExclusions,
  "NeighborIPExclusions",
  "csharp"
);
@@clientName(
  InternalNetworkBmpPatchProperties.neighborIpExclusions,
  "NeighborIPExclusions",
  "csharp"
);
@@clientName(
  NetworkBootstrapDeviceProperties.dhcpV4ServerIpAddress,
  "DhcpV4ServerIPAddress",
  "csharp"
);
@@clientName(
  NetworkBootstrapDeviceProperties.primaryManagementIpv4Address,
  "PrimaryManagementIPv4Address",
  "csharp"
);
@@clientName(
  NetworkBootstrapDeviceProperties.primaryManagementIpv6Address,
  "PrimaryManagementIPv6Address",
  "csharp"
);
@@clientName(
  NetworkBootstrapDeviceProperties.secondaryManagementIpv4Address,
  "SecondaryManagementIPv4Address",
  "csharp"
);
@@clientName(
  NetworkBootstrapDeviceProperties.secondaryManagementIpv6Address,
  "SecondaryManagementIPv6Address",
  "csharp"
);
@@clientName(
  NetworkBootstrapInterfaceProperties.ipv4Address,
  "IPv4Address",
  "csharp"
);
@@clientName(
  NetworkBootstrapInterfaceProperties.ipv6Address,
  "IPv6Address",
  "csharp"
);
@@clientName(
  NetworkDeviceProperties.managementIpv4Address,
  "ManagementIPv4Address",
  "csharp"
);
@@clientName(
  NetworkDeviceProperties.managementIpv6Address,
  "ManagementIPv6Address",
  "csharp"
);
@@clientName(NetworkInterfaceProperties.ipv4Address, "IPv4Address", "csharp");
@@clientName(NetworkInterfaceProperties.ipv6Address, "IPv6Address", "csharp");
@@clientName(InternetGatewayProperties.ipv4Address, "IPV4Address", "csharp");
@@clientName(NeighborGroupDestination.ipv4Addresses, "IPv4Addresses", "csharp");
@@clientName(NeighborGroupDestination.ipv6Addresses, "IPv6Addresses", "csharp");
@@clientName(BmpConfigurationProperties.stationIp, "StationIP", "csharp");
@@clientName(BmpConfigurationPatchProperties.stationIp, "StationIP", "csharp");
@@usage(DeviceInterfaceProperties, Usage.input, "csharp");
@@usage(NetworkFabricSku, Usage.input, "csharp");
@@usage(NetworkDeviceSku, Usage.input, "csharp");
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
  VpnConfigurationProperties,
  Usage.input | Usage.output | Usage.json,
  "csharp"
);
@@usage(IpCommunityIdList, Usage.input | Usage.output | Usage.json, "csharp");
// These compatibility base models preserve the shipped C# hierarchy where the
// action models derive from add-operation models exposing Add*CommunityIds.
@doc("IP community add operation properties.")
model IpCommunityAddOperationProperties {
  @doc("List of IP community resource IDs to add.")
  add?: IpCommunityIdList;
}
@doc("IP extended community add operation properties.")
model IpExtendedCommunityAddOperationProperties {
  @doc("List of IP extended community resource IDs to add.")
  add?: IpExtendedCommunityIdList;
}
@@usage(
  IpCommunityAddOperationProperties,
  Usage.input | Usage.output | Usage.json,
  "csharp"
);
@@usage(
  IpExtendedCommunityAddOperationProperties,
  Usage.input | Usage.output | Usage.json,
  "csharp"
);
@@clientName(
  IpCommunityAddOperationProperties,
  "IPCommunityAddOperationProperties",
  "csharp"
);
@@clientName(
  IpExtendedCommunityAddOperationProperties,
  "IPExtendedCommunityAddOperationProperties",
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
  NetworkDevicePatchParameters,
  NetworkRackPatch,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve shipped base type for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  ActionIpCommunityProperties,
  IpCommunityAddOperationProperties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve shipped base type for migration compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  ActionIpExtendedCommunityProperties,
  IpExtendedCommunityAddOperationProperties,
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
@@clientName(GetTopologyResponse, "NetworkFabricTopologyResult", "csharp");
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

// Preserve shipped C# operation method names and compatibility return types.
@@clientName(
  NetworkInterfaces.updateAdministrativeState,
  "SetAdministrativeState",
  "csharp"
);
@@clientName(
  NetworkDevices.updateAdministrativeState,
  "SetAdministrativeState",
  "csharp"
);
@@clientName(NetworkDevices.reboot, "Restart", "csharp");
@@clientName(
  NetworkDevices.refreshConfiguration,
  "ReloadConfiguration",
  "csharp"
);
@@clientName(NetworkDevices.upgrade, "Upgrade", "csharp");
@@clientName(
  AccessControlLists.updateAdministrativeState,
  "SetAdministrativeState",
  "csharp"
);
@@clientName(
  ExternalNetworks.updateAdministrativeState,
  "SetAdministrativeState",
  "csharp"
);
@@clientName(
  ExternalNetworks.updateStaticRouteBfdAdministrativeState,
  "SetStaticRouteBfdAdministrativeState",
  "csharp"
);
@@clientName(
  InternalNetworks.updateAdministrativeState,
  "SetAdministrativeState",
  "csharp"
);
@@clientName(
  InternalNetworks.updateBgpAdministrativeState,
  "SetBgpAdministrativeState",
  "csharp"
);
@@clientName(
  InternalNetworks.updateStaticRouteBfdAdministrativeState,
  "SetStaticRouteBfdAdministrativeState",
  "csharp"
);
@@clientName(
  L2IsolationDomains.updateAdministrativeState,
  "SetAdministrativeState",
  "csharp"
);
@@clientName(
  L3IsolationDomains.updateAdministrativeState,
  "SetAdministrativeState",
  "csharp"
);
@@clientName(
  NetworkToNetworkInterconnects.updateNpbStaticRouteBfdAdministrativeState,
  "SetNpbStaticRouteBfdAdministrativeState",
  "csharp"
);
@@clientName(
  NetworkToNetworkInterconnects.updateAdministrativeState,
  "SetAdministrativeState",
  "csharp"
);
@@clientName(
  NetworkFabrics.commitConfiguration,
  "ApplyConfiguration",
  "csharp"
);
@@clientName(NetworkFabrics.deprovision, "Deactivate", "csharp");
@@clientName(NetworkFabrics.provision, "Activate", "csharp");
@@clientName(
  NetworkFabrics.refreshConfiguration,
  "ReloadConfiguration",
  "csharp"
);
@@clientName(NetworkFabrics.upgrade, "Upgrade", "csharp");
@@clientName(
  NetworkFabrics.updateInfraManagementBfdConfiguration,
  "SetInfraManagementBfdConfiguration",
  "csharp"
);
@@clientName(
  NetworkFabrics.updateWorkloadManagementBfdConfiguration,
  "SetWorkloadManagementBfdConfiguration",
  "csharp"
);
@@clientName(NetworkFabrics.getTopology, "RetrieveTopology", "csharp");
@@clientName(GetTopologyResponse, "NetworkFabricTopologyResult", "csharp");
@@clientName(
  RoutePolicies.updateAdministrativeState,
  "SetAdministrativeState",
  "csharp"
);
@@clientName(NetworkTapRules.resync, "StartResync", "csharp");
@@clientName(NetworkTaps.resync, "StartResync", "csharp");
@@clientName(
  NetworkTaps.updateAdministrativeState,
  "SetAdministrativeState",
  "csharp"
);

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

@@clientName(
  Microsoft.ManagedNetworkFabric.NetworkDeviceProperties.hostName,
  "hostname",
  "java"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.NetworkDevicePatchableProperties.hostName,
  "hostname",
  "java"
);

@@clientName(
  Microsoft.ManagedNetworkFabric,
  "ManagedNetworkFabricMgmtClient",
  "python"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.StaticRouteRoutePolicy,
  "StaticRoutePolicy",
  "python"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.StaticRouteRoutePolicyPatch,
  "StaticRoutePolicyPatch",
  "python"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.L3IsolationDomainProperties.staticRouteRoutePolicy,
  "staticRoutePolicy",
  "python"
);
@@clientName(
  Microsoft.ManagedNetworkFabric.L3IsolationDomainPatchProperties.staticRouteRoutePolicy,
  "staticRoutePolicy",
  "python"
);
