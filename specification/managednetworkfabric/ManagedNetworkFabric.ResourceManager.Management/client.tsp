import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
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
@@clientName(DestinationProperties, "NetworkTapPropertiesDestinationsItem", "csharp");
@@clientName(Encapsulation, "IsolationDomainEncapsulationType", "csharp");
@@clientName(EncapsulationType, "NetworkTapEncapsulationType", "csharp");
@@clientName(Extension, "StaticRouteConfigurationExtension", "csharp");
@@clientName(ExternalNetworkPropertiesOptionAProperties, "ExternalNetworkOptionAProperties", "csharp");
@@clientName(FabricSkuType, "NetworkFabricSkuType", "csharp");
@@clientName(GatewayType, "InternetGatewayType", "csharp");
@@clientName(Action, "InternetGatewayRuleAction", "csharp");
@@clientName(IpCommunityRule, "IPCommunityRule", "csharp");
@@clientName(IpExtendedCommunityRule, "IPExtendedCommunityRule", "csharp");
@@clientName(IpPrefixRule, "IPPrefixRule", "csharp");
@@clientName(Condition, "IPPrefixRuleCondition", "csharp");
@@clientName(WellKnownCommunities, "WellKnownCommunity", "csharp");
@@clientName(InterfaceType, "NetworkDeviceInterfaceType", "csharp");
@@clientName(BgpConfiguration, "InternalNetworkBgpConfiguration", "csharp");
@@clientName(StaticRouteConfiguration, "InternalNetworkStaticRouteConfiguration", "csharp");
@@clientName(OptionBLayer3Configuration, "NetworkToNetworkInterconnectOptionBLayer3Configuration", "csharp");
@@clientName(NfcSku, "NetworkFabricControllerSKU", "csharp");
@@clientName(PollingIntervalInSeconds, "PollingIntervalInSecond", "csharp");
@@clientName(PollingType, "NetworkTapPollingType", "csharp");
@@clientName(PortCondition, "NetworkFabricPortCondition", "csharp");
@@clientName(PortType, "NetworkFabricPortType", "csharp");
@@clientName(ProvisioningState, "NetworkFabricProvisioningState", "csharp");
@@clientName(RedistributeConnectedSubnets, "RedistributeConnectedSubnet", "csharp");
@@clientName(RedistributeStaticRoutes, "RedistributeStaticRoute", "csharp");
@@clientName(RuleProperties, "InternetGatewayRules", "csharp");
@@clientName(VpnOptionAProperties, "VpnConfigurationOptionAProperties", "csharp");
@@clientName(VpnOptionAPatchProperties, "VpnConfigurationPatchableOptionAProperties", "csharp");
@@clientName(VpnOptionBProperties, "OptionBProperties", "csharp");
@@clientName(ControlPlaneAclPortMatchType.Equals, "EqualTo", "csharp");
@@clientName(ControlPlaneAclTtlMatchType.Equals, "EqualTo", "csharp");
@@clientName(ActionIpCommunityProperties, "ActionIPCommunityProperties", "csharp");
@@clientName(ActionIpExtendedCommunityProperties, "ActionIPExtendedCommunityProperties", "csharp");
@@clientName(AnnotationResource, "AnnotationResourceProperties", "csharp");
@@clientName(CommonPostActionResponseForDeviceUpdate, "DeviceUpdateCommonPostActionResult", "csharp");
@@clientName(CommonPostActionResponseForStateUpdate, "StateUpdateCommonPostActionResult", "csharp");
@@clientName(DestinationPatchProperties, "NetworkTapPatchableParametersDestinationsItem", "csharp");
@@clientName(DestinationType, "NetworkTapDestinationType", "csharp");
@@clientName(EnableDisableOnResources, "UpdateAdministrativeStateOnResources", "csharp");
@@clientName(EnableDisableState, "AdministrativeEnableState", "csharp");
@@clientName(ExternalNetworkPatchPropertiesOptionAProperties, "ExternalNetworkPatchOptionAProperties", "csharp");
@@clientName(IPAddressType, "NetworkFabricIPAddressType", "csharp");
@@clientName(IpCommunityIdList, "IPCommunityIdList", "csharp");
@@clientName(IpExtendedCommunityIdList, "IPExtendedCommunityIdList", "csharp");
@@clientName(IpGroupProperties, "MatchConfigurationIPGroupProperties", "csharp");
@@clientName(IpMatchCondition, "IPMatchCondition", "csharp");
@@clientName(PrefixType, "IPMatchConditionPrefixType", "csharp");
@@clientName(Layer3IpPrefixProperties, "Layer3IPPrefixProperties", "csharp");
@@clientName(Layer3IpPrefixPatchProperties, "Layer3IPPrefixPatchProperties", "csharp");
@@clientName(ManagementNetworkConfigurationProperties, "ManagementNetworkConfigurationPatchableProperties", "csharp");
@@clientName(DeviceAdministrativeState, "NetworkDeviceAdministrativeState", "csharp");
@@clientName(DeviceInterfaceProperties, "NetworkDeviceInterfaceProperties", "csharp");
@@clientName(RebootProperties, "NetworkDeviceRebootContent", "csharp");
@@clientName(RebootType, "NetworkDeviceRebootType", "csharp");
@@clientName(TerminalServerConfiguration, "NetworkFabricPatchablePropertiesTerminalServerConfiguration", "csharp");
@@clientName(TerminalServerPatchConfiguration, "TerminalServerPatchableProperties", "csharp");
@@clientName(UpdateAdministrativeState, "UpdateAdministrativeStateContent", "csharp");
@@clientName(UpdateDeviceAdministrativeState, "UpdateDeviceAdministrativeStateContent", "csharp");
@@clientName(UpdateVersion, "NetworkFabricUpdateVersionContent", "csharp");
@@clientName(ValidateAction, "NetworkFabricValidateAction", "csharp");
@@clientName(ValidateConfigurationProperties, "ValidateConfigurationContent", "csharp");
@@access(ConnectedSubnetRoutePolicy, Access.public, "csharp");
@@access(PollingIntervalInSeconds, Access.public, "csharp");
@@clientName(ArmConfigurationDiffOperationResponse, "ArmConfigurationDiffOperationResult", "csharp");
@@clientName(CommitBatchStatusOperationResponse, "CommitBatchStatusOperationResult", "csharp");
@@clientName(CommitBatchStatusRequest, "CommitBatchStatusContent", "csharp");
@@clientName(CommitConfigurationRequest, "CommitConfigurationContent", "csharp");
@@clientName(CommitConfigurationResponse, "CommitConfigurationResult", "csharp");
@@clientName(CommonErrorResponse, "NetworkFabricErrorResult", "csharp");
@@clientName(DiscardCommitBatchOperationResponse, "DiscardCommitBatchOperationResult", "csharp");
@@clientName(DiscardCommitBatchRequest, "DiscardCommitBatchContent", "csharp");
@@clientName(ExternalNetworkUpdateBfdAdministrativeStateRequest, "ExternalNetworkUpdateBfdAdministrativeStateContent", "csharp");
@@clientName(ExternalNetworkUpdateBfdAdministrativeStateResponse, "ExternalNetworkUpdateBfdAdministrativeStateResult", "csharp");
@@clientName(GetTopologyResponse, "GetTopologyResult", "csharp");
@@clientName(InternalNetworkUpdateBfdAdministrativeStateRequest, "InternalNetworkUpdateBfdAdministrativeStateContent", "csharp");
@@clientName(InternalNetworkUpdateBfdAdministrativeStateResponse, "InternalNetworkUpdateBfdAdministrativeStateResult", "csharp");
@@clientName(InternalNetworkUpdateBgpAdministrativeStateRequest, "InternalNetworkUpdateBgpAdministrativeStateContent", "csharp");
@@clientName(InternalNetworkUpdateBgpAdministrativeStateResponse, "InternalNetworkUpdateBgpAdministrativeStateResult", "csharp");
@@clientName(NeighborGroupResyncResponse, "NeighborGroupResyncResult", "csharp");
@@clientName(NetworkBootstrapDeviceRebootResponse, "NetworkBootstrapDeviceRebootResult", "csharp");
@@clientName(NetworkBootstrapDeviceRefreshConfigurationResponse, "NetworkBootstrapDeviceRefreshConfigurationResult", "csharp");
@@clientName(NetworkBootstrapDeviceResyncPasswordsResponse, "NetworkBootstrapDeviceResyncPasswordsResult", "csharp");
@@clientName(NetworkBootstrapDeviceUpdateAdministrativeStateResponse, "NetworkBootstrapDeviceUpdateAdministrativeStateResult", "csharp");
@@clientName(NetworkBootstrapDeviceUpgradeResponse, "NetworkBootstrapDeviceUpgradeResult", "csharp");
@@clientName(NetworkDeviceRefreshConfigurationResponse, "NetworkDeviceRefreshConfigurationResult", "csharp");
@@clientName(NetworkDeviceResyncPasswordsResponse, "NetworkDeviceResyncPasswordsResult", "csharp");
@@clientName(NetworkDeviceRunRwCommandResponse, "NetworkDeviceRunRwCommandResult", "csharp");
@@clientName(NetworkDeviceUpdateAdministrativeStateResponse, "NetworkDeviceUpdateAdministrativeStateResult", "csharp");
@@clientName(NetworkDeviceUpgradeRequest, "NetworkDeviceUpgradeContent", "csharp");
@@clientName(NetworkDeviceUpgradeResponse, "NetworkDeviceUpgradeResult", "csharp");
@@clientName(NetworkFabricLockRequest, "NetworkFabricLockContent", "csharp");
@@clientName(NetworkFabricResyncCertificatesResponse, "NetworkFabricResyncCertificatesResult", "csharp");
@@clientName(NetworkFabricResyncPasswordsResponse, "NetworkFabricResyncPasswordsResult", "csharp");
@@clientName(NetworkFabricRotateCertificatesResponse, "NetworkFabricRotateCertificatesResult", "csharp");
@@clientName(NetworkFabricRotatePasswordsResponse, "NetworkFabricRotatePasswordsResult", "csharp");
@@clientName(NetworkTapResyncResponse, "NetworkTapResyncResult", "csharp");
@@clientName(NetworkTapRuleResyncResponse, "NetworkTapRuleResyncResult", "csharp");
@@clientName(NniUpdateBfdAdministrativeStateRequest, "NniUpdateBfdAdministrativeStateContent", "csharp");
@@clientName(NniUpdateBfdAdministrativeStateResponse, "NniUpdateBfdAdministrativeStateResult", "csharp");
@@clientName(UpdateAdministrativeStateResponse, "UpdateAdministrativeStateResult", "csharp");
@@clientName(ValidateConfigurationResponse, "ValidateConfigurationResult", "csharp");
@@clientName(ViewDeviceConfigurationOperationResponse, "ViewDeviceConfigurationOperationResult", "csharp");

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

