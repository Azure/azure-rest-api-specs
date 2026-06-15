import "./Network/main.tsp";
import "./Vmss/main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.Core;
using Microsoft.Network;
using Microsoft.Compute;
using Common;

// Define WritableSubResource in the ARM namespace for C# collection compatibility.
namespace Azure.ResourceManager.Models {
  model WritableSubResource {
    id?: armResourceIdentifier;
  }
}

namespace Common {
  /**
   * Common writable subresource representation used by the previous C# AutoRest projection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility with the previous Network AutoRest C# hierarchy."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Back compatibility with the previous Network AutoRest C# hierarchy."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "Back compatibility with the previous Network AutoRest C# hierarchy."
  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Back compatibility with the previous Network AutoRest C# hierarchy."
  @Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
  model WritableSubResourceModel extends SubResource {
    /**
     * Resource name.
     */
    name?: string;

    /**
     * Resource type.
     */
    type?: string;
  }
}

namespace CombineClient {
  // C# customizations for Azure.ResourceManager.Network MPG migration.
  // C# naming mitigations for brownfield Network acronyms and shared model names.
  @@clientName(Common.ProvisioningState, "NetworkProvisioningState", "csharp");

  @@clientName(
    Common.IPAllocationMethod,
    "NetworkIPAllocationMethod",
    "csharp"
  );

  @@clientName(Common.IPVersion, "NetworkIPVersion", "csharp");

  @@clientName(
    Common.ServiceEndpointPropertiesFormat,
    "ServiceEndpointProperties",
    "csharp"
  );

  @@clientName(Common.IPConfiguration, "NetworkIPConfiguration", "csharp");

  @@clientName(
    Common.IPConfigurationProfile,
    "NetworkIPConfigurationProfile",
    "csharp"
  );

  @@clientName(
    Common.PrivateLinkServiceConnection,
    "NetworkPrivateLinkServiceConnection",
    "csharp"
  );

  @@clientName(
    Common.CustomDnsConfigPropertiesFormat,
    "CustomDnsConfigProperties",
    "csharp"
  );

  @@clientName(
    Common.PrivateLinkServiceIpConfiguration,
    "PrivateLinkServiceIPConfiguration",
    "csharp"
  );

  @@clientName(Common.IpTag, "IPTag", "csharp");

  @@clientName(
    Common.LoadBalancingRulePropertiesFormat,
    "LoadBalancingRuleProperties",
    "csharp"
  );

  @@clientName(
    Common.ManagedServiceIdentity,
    "NetworkManagedServiceIdentity",
    "csharp"
  );

  @@clientName(
    Common.PublicIpAddressDnsSettingsDomainNameLabelScope,
    "PublicIPAddressDnsSettingsDomainNameLabelScope",
    "csharp"
  );

  @@clientName(Common.AddressSpace, "VirtualNetworkAddressSpace", "csharp");

  @@clientName(
    Common.TransportProtocol,
    "LoadBalancingTransportProtocol",
    "csharp"
  );

  @@clientName(Common.Delegation, "ServiceDelegation", "csharp");

  @@clientName(
    Common.VirtualNetworkPrivateEndpointNetworkPolicies,
    "VirtualNetworkPrivateEndpointNetworkPolicy",
    "csharp"
  );

  @@clientName(
    Common.VirtualNetworkPrivateLinkServiceNetworkPolicies,
    "VirtualNetworkPrivateLinkServiceNetworkPolicy",
    "csharp"
  );

  @@clientName(Common.AccessMode, "PrivateLinkServiceAccessMode", "csharp");

  @@clientName(Common.SyncMode, "BackendAddressSyncMode", "csharp");

  @@clientName(Common.InboundNatPool, "LoadBalancerInboundNatPool", "csharp");

  @@clientName(Microsoft.Network.CustomIpPrefix, "CustomIPPrefix", "csharp");

  @@clientName(
    Microsoft.Network.HubIpConfiguration,
    "HubIPConfiguration",
    "csharp"
  );

  @@clientName(Microsoft.Network.IpAllocation, "IPAllocation", "csharp");

  @@clientName(Microsoft.Network.IpGroup, "IPGroup", "csharp");

  @@clientName(Microsoft.Network.VirtualWAN, "VirtualWan", "csharp");

  @@clientName(
    Microsoft.Network.ActiveConfigurationParameter,
    "ActiveConfigurationContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ApplicationGatewayAvailableSslOptions,
    "ApplicationGatewayAvailableSslOptionsInfo",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.AzureFirewallPacketCaptureResponse,
    "AzureFirewallPacketCaptureResult",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.AzureFirewallPacketCaptureResponseCode,
    "AzureFirewallPacketCaptureResultCode",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.AvailableProvidersListParameters,
    "AvailableProvidersListContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.AzureReachabilityReportParameters,
    "AzureReachabilityReportContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.BastionShareableLinkTokenListRequest,
    "BastionShareableLinkTokenListContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ConnectionMonitorParameters,
    "ConnectionMonitorCreateOrUpdateContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ConnectionMonitorType,
    "ConnectionMonitorEndpointType",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ConnectivityParameters,
    "ConnectivityContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.CustomIpPrefixType,
    "CustomIPPrefixType",
    "csharp"
  );

  @@clientName(
    Common.DdosSettingsProtectionMode,
    "DdosSettingsProtectionCoverage",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.DdosTrafficType,
    "DdosCustomPolicyProtocol",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.DisassociateCloudServicePublicIpRequest,
    "DisassociateCloudServicePublicIPContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.EffectiveRoutesParameters,
    "EffectiveRoutesContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ExpressRouteFailoverStopApiParameters,
    "ExpressRouteFailoverStopApiContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.FirewallPacketCaptureParameters,
    "FirewallPacketCaptureContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.FirewallPolicyFilterRuleCollection,
    "FirewallPolicyFilterRuleCollectionInfo",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.FirewallPolicyNatRuleCollection,
    "FirewallPolicyNatRuleCollectionInfo",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.FlowLogStatusParameters,
    "FlowLogStatusContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.GenerateExpressRoutePortsLOARequest,
    "GenerateExpressRoutePortsLoaContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.GenerateExpressRoutePortsLOAResult,
    "GenerateExpressRoutePortsLoaResult",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.GetVpnSitesConfigurationRequest,
    "GetVpnSitesConfigurationContent",
    "csharp"
  );

  @@clientName(Microsoft.Network.IpFlowProtocol, "IPFlowProtocol", "csharp");

  @@clientName(Microsoft.Network.IdpsQueryObject, "IdpsQueryContent", "csharp");

  @@clientName(Microsoft.Network.FilterItems, "IdpsQueryFilterItems", "csharp");

  @@clientName(Microsoft.Network.OrderBy, "IdpsQueryOrderBy", "csharp");

  @@clientName(
    Microsoft.Network.QueryResults,
    "IdpsSignatureListResult",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.SingleQueryResult,
    "IdpsSignatureResult",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.PoolAssociation,
    "IpamPoolAssociation",
    "csharp"
  );

  @@clientName(Microsoft.Network.PoolUsage, "IpamPoolUsage", "csharp");

  @@clientName(
    Microsoft.Network.ResourceBasics,
    "IpamResourceBasics",
    "csharp"
  );

  @@clientName(Microsoft.Network.IpsecEncryption, "IPsecEncryption", "csharp");

  @@clientName(Microsoft.Network.IpsecIntegrity, "IPsecIntegrity", "csharp");

  @@clientName(
    Microsoft.Network.LoadBalancerVipSwapRequest,
    "LoadBalancerVipSwapContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.MigrateLoadBalancerToIpBasedRequest,
    "MigrateLoadBalancerToIPBasedContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.MigratedPools,
    "MigrateLoadBalancerToIPBasedResult",
    "csharp"
  );

  @@clientName(Microsoft.Network.AdminRule, "NetworkAdminRule", "csharp");

  @@clientName(
    Microsoft.Network.AuthenticationMethod,
    "NetworkAuthenticationMethod",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ConnectionState,
    "NetworkConnectionState",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.DefaultAdminRule,
    "NetworkDefaultAdminRule",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.HttpConfiguration,
    "NetworkHttpConfiguration",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.IpAllocationType,
    "NetworkIPAllocationType",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.IPPrefixesList,
    "LearnedIPPrefixesListResult",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.NetworkConfigurationDiagnosticParameters,
    "NetworkConfigurationDiagnosticContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.NetworkManagerDeploymentStatusParameter,
    "NetworkManagerDeploymentStatusContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.NetworkVirtualApplianceBootDiagnosticParameters,
    "NetworkVirtualApplianceBootDiagnosticContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.PerimeterAssociableResource,
    "NetworkSecurityPerimeterAssociableResourceType",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.NspServiceTagsResource,
    "NetworkSecurityPerimeterServiceTags",
    "csharp"
  );

  @@clientName(Microsoft.Network.TagsObject, "NetworkTagsObject", "csharp");

  @@clientName(Microsoft.Network.Topology, "NetworkTopology", "csharp");

  @@clientName(
    Microsoft.Network.HTTPMethod,
    "NetworkWatcherHttpMethod",
    "csharp"
  );

  @@clientName(Microsoft.Network.Protocol, "NetworkWatcherProtocol", "csharp");

  @@clientName(Microsoft.Network.NextHopParameters, "NextHopContent", "csharp");

  @@clientName(
    Microsoft.Network.PacketCaptureParameters,
    "PacketCaptureCreateOrUpdateContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.PacketCaptureTargetType.AzureVM,
    "AzureVm",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.PacketCaptureTargetType.AzureVMSS,
    "AzureVmss",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.P2SVpnProfileParameters,
    "P2SVpnProfileContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.P2SVpnConnectionHealthRequest,
    "P2SVpnConnectionHealthContent",
    "csharp"
  );

  @@clientName(Microsoft.Network.PeerRoute, "PeerRouteList", "csharp");

  @@clientName(
    Microsoft.Network.PublicIpDdosProtectionStatusResult,
    "PublicIPDdosProtectionStatusResult",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.QueryTroubleshootingParameters,
    "QueryTroubleshootingContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.QueryRequestOptions,
    "NetworkManagementQueryContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.QueryInboundNatRulePortMappingRequest,
    "QueryInboundNatRulePortMappingContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ReserveCloudServicePublicIpAddressRequest,
    "ReserveCloudServicePublicIPAddressContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.SecurityGroupViewParameters,
    "SecurityGroupViewContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ServiceGatewayUpdateAddressLocationsRequest,
    "ServiceGatewayUpdateAddressLocationsContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ServiceGatewayUpdateServicesRequest,
    "ServiceGatewayUpdateServicesContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.SignatureOverridesFilterValuesQuery,
    "SignatureOverridesFilterValuesQueryContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.SignatureOverridesFilterValuesResponse,
    "SignatureOverridesFilterValuesResult",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.TopologyParameters,
    "TopologyContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.TopologyResource,
    "TopologyResourceInfo",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.TroubleshootingParameters,
    "TroubleshootingContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.PrepareNetworkPoliciesRequest,
    "PrepareNetworkPoliciesContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.UnprepareNetworkPoliciesRequest,
    "UnprepareNetworkPoliciesContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.VerificationIPFlowParameters,
    "VerificationIPFlowContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.VirtualNetworkGatewayMigrationParameters,
    "VirtualNetworkGatewayMigrationContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.GetInboundRoutesParameters,
    "VirtualHubInboundRoutesContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.GetOutboundRoutesParameters,
    "VirtualHubOutboundRoutesContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.VirtualWanVpnProfileParameters,
    "VirtualWanVpnProfileContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.VpnClientParameters,
    "VpnClientContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.VpnConnectionPacketCaptureStartParameters,
    "VpnConnectionPacketCaptureStartContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.VpnConnectionPacketCaptureStopParameters,
    "VpnConnectionPacketCaptureStopContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.VpnDeviceScriptParameters,
    "VpnDeviceScriptContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.VpnGatewayPacketCaptureStartParameters,
    "VpnGatewayPacketCaptureStartContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.VpnGatewayPacketCaptureStopParameters,
    "VpnGatewayPacketCaptureStopContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.VpnPacketCaptureStartParameters,
    "VpnPacketCaptureStartContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.VpnPacketCaptureStopParameters,
    "VpnPacketCaptureStopContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.IsWorkloadProtected,
    "WorkloadProtectedFlag",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ApplicationGatewayEntraJWTValidationConfig,
    "ApplicationGatewayEntraJwtValidationConfig",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.VerifierWorkspaceProperties,
    "NetworkVerifierWorkspaceProperties",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.HTTPConfigurationMethod,
    "NetworkHttpConfigurationMethod",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ApplicationGatewayPrivateLinkIpConfiguration,
    "ApplicationGatewayPrivateLinkIPConfiguration",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.AzureFirewallIpGroups,
    "AzureFirewallIPGroups",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.Ipv6ExpressRouteCircuitPeeringConfig,
    "IPv6ExpressRouteCircuitPeeringConfig",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.Ipv6CircuitConnectionConfig,
    "IPv6CircuitConnectionConfig",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.FirewallPolicySnat,
    "FirewallPolicySnat",
    "csharp"
  );

  @@clientName(Microsoft.Network.DhGroup, "DHGroup", "csharp");

  @@clientName(
    Microsoft.Network.GroupMemberType,
    "NetworkGroupMemberType",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ContainerNetworkInterfaceIpConfiguration,
    "ContainerNetworkInterfaceIPConfiguration",
    "csharp"
  );

  @@clientName(Microsoft.Network.Access, "NetworkAccess", "csharp");

  @@clientName(
    Microsoft.Network.ConnectionStatus,
    "NetworkConnectionStatus",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.IPConfigurationBgpPeeringAddress,
    "NetworkIPConfigurationBgpPeeringAddress",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.GatewayCustomBgpIpAddressIpConfiguration,
    "GatewayCustomBgpIPAddressIPConfiguration",
    "csharp"
  );

  @@clientName(Microsoft.Network.IpsecPolicy, "IPsecPolicy", "csharp");

  @@clientName(
    Microsoft.Network.VpnGatewayIpConfiguration,
    "VpnGatewayIPConfiguration",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.VirtualNetworkApplianceIpConfiguration,
    "VirtualNetworkApplianceIPConfiguration",
    "csharp"
  );

  @@clientName(Microsoft.Network.UsageUnit, "NetworkUsageUnit", "csharp");

  @@clientName(Microsoft.Network.UsageName, "NetworkUsageName", "csharp");

  @@clientName(Microsoft.Network.QosIpRange, "QosIPRange", "csharp");

  @@clientName(Microsoft.Network.BGPCommunity, "BgpCommunity", "csharp");

  @@clientName(
    Microsoft.Network.ConnectionSharedKeyResult,
    "VpnLinkConnectionSharedKey",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.SharedKeyProperties,
    "VpnLinkConnectionSharedKeyProperties",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ApplicationGatewayTierTypes,
    "ApplicationGatewayTierType",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ApplicationGatewayWafRuleStateTypes,
    "ApplicationGatewayWafRuleStateType",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ApplicationGatewayWafRuleActionTypes,
    "ApplicationGatewayWafRuleActionType",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ApplicationGatewayWafRuleSensitivityTypes,
    "ApplicationGatewayWafRuleSensitivityType",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ApplicationGatewayRuleSetStatusOptions,
    "ApplicationGatewayRuleSetStatusOption",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ApplicationGatewayClientRevocationOptions,
    "ApplicationGatewayClientRevocationOption",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ApplicationGatewayClientAuthVerificationModes,
    "ApplicationGatewayClientAuthVerificationMode",
    "csharp"
  );

  @@clientName(Microsoft.Network.IPRule, "BastionHostIPRule", "csharp");

  @@clientName(
    Microsoft.Network.ExplicitProxy,
    "FirewallPolicyExplicitProxy",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.IntentContent,
    "AnalysisRunIntentContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.NspProvisioningState,
    "NetworkSecurityPerimeterProvisioningState",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.NspLinkProvisioningState,
    "NetworkSecurityPerimeterLinkProvisioningState",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.NspLinkStatus,
    "NetworkSecurityPerimeterLinkStatus",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.HttpHeader,
    "NetworkWatcherHttpHeader",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.PreferredIPVersion,
    "TestEvalPreferredIPVersion",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.AdminState,
    "ExpressRouteGatewayAdminState",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ResiliencyModel,
    "ExpressRouteGatewayResiliencyModel",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.Direction,
    "NetworkTrafficDirection",
    "csharp"
  );

  @@clientName(Microsoft.Network.ActionType, "RuleMatchActionType", "csharp");

  @@clientName(
    Microsoft.Network.SensitivityType,
    "ManagedRuleSensitivityType",
    "csharp"
  );

  @@clientName(Common.DeleteOptions, "IPAddressDeleteOption", "csharp");

  @@clientName(
    Microsoft.Network.ConfigurationType,
    "NetworkConfigurationDeploymentType",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.DeploymentStatus,
    "NetworkManagerDeploymentState",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.UseHubGateway,
    "HubGatewayUsageFlag",
    "csharp"
  );

  @@clientName(Microsoft.Network.IsGlobal, "GlobalMeshSupportFlag", "csharp");

  @@clientName(
    Microsoft.Network.VnetLocalRouteOverrideCriteria,
    "VnetLocalRouteOverrideCriterion",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ConnectivityIssue,
    "ConnectivityIssueInfo",
    "csharp"
  );

  @@clientName(Microsoft.Network.Origin, "IssueOrigin", "csharp");

  @@clientName(Microsoft.Network.Severity, "IssueSeverity", "csharp");

  @@clientName(Microsoft.Network.IssueType, "ConnectivityIssueType", "csharp");

  @@clientName(Microsoft.Network.Hub, "ConnectivityHub", "csharp");

  @@clientName(Microsoft.Network.IpType, "IpamIPType", "csharp");

  @@clientName(
    Microsoft.Network.IPTraffic,
    "NetworkVerifierIPTraffic",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.RoutingConfiguration,
    "RoutingConfigurationNfv",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.PropagatedRouteTable,
    "PropagatedRouteTableNfv",
    "csharp"
  );

  @@clientName(
    Common.PrivateEndpointVNetPolicies,
    "PrivateEndpointVnetPolicy",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.AzureFirewallApplicationRuleCollection,
    "AzureFirewallApplicationRuleCollectionData",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.AzureFirewallNatRuleCollection,
    "AzureFirewallNatRuleCollectionData",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.AzureFirewallNetworkRuleCollection,
    "AzureFirewallNetworkRuleCollectionData",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.FirewallPolicyRuleCollection,
    "FirewallPolicyRuleCollectionInfo",
    "csharp"
  );

  @@clientName(Common.Resource, "NetworkTrackedResourceData", "csharp");

  @@clientName(Common.SubResource, "NetworkSubResource", "csharp");

  @@clientName(Common.SubResourceModel, "NetworkResourceData", "csharp");

  @@clientName(
    Common.WritableSubResourceModel,
    "NetworkWritableResourceData",
    "csharp"
  );

  @@clientName(Common.WritableSubResourceModel.type, "ResourceType", "csharp");

  @@clientName(
    Common.InboundNatPoolPropertiesFormat,
    "LoadBalancerInboundNatPoolProperties",
    "csharp"
  );

  @@access(
    Common.FlowLogPropertiesFormat,
    Azure.ClientGenerator.Core.Access.public,
    "csharp"
  );

  @@access(
    Microsoft.Network.FlowLogProperties,
    Azure.ClientGenerator.Core.Access.public,
    "csharp"
  );

  @@access(
    Microsoft.Network.ConnectionMonitorQueryResult,
    Azure.ClientGenerator.Core.Access.public,
    "csharp"
  );

  @@access(
    Microsoft.Network.ConnectionMonitorParameters,
    Azure.ClientGenerator.Core.Access.public,
    "csharp"
  );

  @@access(
    Microsoft.Network.ConnectionMonitorSourceStatus,
    Azure.ClientGenerator.Core.Access.public,
    "csharp"
  );

  @@access(
    Microsoft.Network.ConnectionStateSnapshot,
    Azure.ClientGenerator.Core.Access.public,
    "csharp"
  );

  @@access(
    Microsoft.Network.EvaluationState,
    Azure.ClientGenerator.Core.Access.public,
    "csharp"
  );

  @@access(
    Microsoft.Network.FirewallPolicyIDPSQuerySortOrder,
    Azure.ClientGenerator.Core.Access.public,
    "csharp"
  );

  @@access(
    Microsoft.Network.FirewallPolicyIDPSSignatureDirection,
    Azure.ClientGenerator.Core.Access.public,
    "csharp"
  );

  @@access(
    Microsoft.Network.FirewallPolicyIDPSSignatureMode,
    Azure.ClientGenerator.Core.Access.public,
    "csharp"
  );

  @@access(
    Microsoft.Network.FirewallPolicyIDPSSignatureSeverity,
    Azure.ClientGenerator.Core.Access.public,
    "csharp"
  );

  @@access(
    Microsoft.Network.Geo,
    Azure.ClientGenerator.Core.Access.public,
    "csharp"
  );

  @@access(
    Microsoft.Network.InboundSecurityRule,
    Azure.ClientGenerator.Core.Access.public,
    "csharp"
  );

  @@access(
    Microsoft.Network.PacketCaptureParameters,
    Azure.ClientGenerator.Core.Access.public,
    "csharp"
  );

  @@access(
    Microsoft.Network.PropagatedRouteTable,
    Azure.ClientGenerator.Core.Access.public,
    "csharp"
  );

  @@access(
    Microsoft.Network.ReferencedPublicIpAddress,
    Azure.ClientGenerator.Core.Access.public,
    "csharp"
  );

  @@access(
    Common.LoadBalancingRulePropertiesFormat,
    Azure.ClientGenerator.Core.Access.public,
    "csharp"
  );

  @@access(
    Common.InboundNatPoolPropertiesFormat,
    Azure.ClientGenerator.Core.Access.public,
    "csharp"
  );

  @@alternateType(Common.Resource.id, armResourceIdentifier, "csharp");

  @@alternateType(Common.SubResource.id, armResourceIdentifier, "csharp");

  @@alternateType(
    Common.WritableSubResourceModel.type,
    Azure.Core.armResourceType,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ProxyResource.id,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ProxyResourceWithReadOnlyID.id,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ProxyResourceWithSettableId.id,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ReadOnlySubResourceModel.id,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.TrackedResourceWithEtag.id,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.TrackedResourceWithOptionalLocation.id,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.TrackedResourceWithSettableIdOptionalLocation.id,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.TrackedResourceWithSettableName.id,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.WritableResource.id,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ChildResource.id,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.EffectiveBaseSecurityAdminRule.id,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.CustomIpPrefixPropertiesFormat.customIpPrefixParent,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ExpressRouteCircuitPeeringPropertiesFormat.expressRouteConnection,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ExpressRouteConnectionProperties.expressRouteCircuitPeering,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ExpressRouteCrossConnectionProperties.expressRouteCircuit,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ExpressRouteGatewayProperties.virtualHub,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Common.FlowLogPropertiesFormat.targetResourceId,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Common.FlowLogPropertiesFormat.storageId,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ApplicationGatewayRequestRoutingRulePropertiesFormat.entraJWTValidationConfig,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ConnectionMonitorWorkspaceSettings.workspaceResourceId,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.FlowLogInformation.targetResourceId,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.FlowLogProperties.storageId,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.LoadBalancerHealthPerRulePerBackendAddress.networkInterfaceIPConfigurationId,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Common.PrivateLinkServiceConnectionProperties.privateLinkServiceId,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.PublicIpDdosProtectionStatusResult.publicIpAddressId,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.QueryInboundNatRulePortMappingRequest.ipConfiguration,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Common.ResourceNavigationLinkFormat.link,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Common.ServiceAssociationLinkPropertiesFormat.link,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.TroubleshootingProperties.storageId,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VirtualNetworkConnectionGatewayReference.id,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.StaticMemberProperties.resourceId,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Common.LoadBalancerBackendAddressPropertiesFormat.loadBalancerFrontendIPConfiguration,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ScopeConnectionProperties.resourceId,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VirtualNetworkGatewayPropertiesFormat.vNetExtendedLocationResourceId,
    armResourceIdentifier,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.BgpPeerStatus.connectedDuration,
    duration,
    "csharp"
  );

  @@alternateType(
    Common.ApplicationSecurityGroupPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Common.FlowLogPropertiesFormat.targetResourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Common.LoadBalancerPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Common.NatGatewayPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Common.NetworkInterfacePropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Common.NetworkSecurityGroupPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Common.PublicIPAddressPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Common.RouteTablePropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Common.ServiceEndpointPolicyPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Common.VirtualNetworkPeeringPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Common.VirtualNetworkPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Common.VirtualNetworkTapPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.AdminPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.AdminRuleCollectionPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ApplicationGatewayEntraJWTValidationConfigPropertiesFormat.tenantId,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ApplicationGatewayPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ConnectivityConfigurationProperties.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.CustomIpPrefixPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.DdosCustomPolicyPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.DdosProtectionPlanPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.DefaultAdminPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.DscpConfigurationPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ExpressRoutePortPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.LocalNetworkGatewayPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.NetworkGroupProperties.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.NetworkManagerProperties.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.NetworkManagerRoutingConfigurationPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.NetworkProfilePropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.NetworkSecurityPerimeterProperties.perimeterGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.NspLinkProperties.remotePerimeterGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.NspLinkReferenceProperties.remotePerimeterGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.PeerExpressRouteCircuitConnectionPropertiesFormat.authResourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.PublicIPPrefixPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.RoutingRuleCollectionPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.RoutingRulePropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ScopeConnectionProperties.tenantId,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.SecurityAdminConfigurationPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.SecurityUserConfigurationPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.SecurityUserRuleCollectionPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.SecurityUserRulePropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ServiceGatewayPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VirtualNetworkAppliancePropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VirtualNetworkGatewayConnectionPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VirtualNetworkGatewayPropertiesFormat.resourceGuid,
    uuid,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ApplicationGatewayAuthenticationCertificatePropertiesFormat.data,
    bytes,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ApplicationGatewaySslCertificatePropertiesFormat.data,
    bytes,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ApplicationGatewaySslCertificatePropertiesFormat.publicCertData,
    bytes,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ApplicationGatewayTrustedClientCertificatePropertiesFormat.data,
    bytes,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ApplicationGatewayTrustedClientCertificatePropertiesFormat.validatedCertData,
    bytes,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ApplicationGatewayTrustedRootCertificatePropertiesFormat.data,
    bytes,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VpnClientRootCertificatePropertiesFormat.publicCertData,
    bytes,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ApplicationGatewayRedirectConfigurationPropertiesFormat.targetUrl,
    url,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.AuthorizationPropertiesFormat.connectionResourceUri,
    url,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ExpressRoutePortAuthorizationPropertiesFormat.circuitResourceUri,
    url,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ApplicationGateway.identity,
    Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ExpressRoutePort.identity,
    Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.FirewallPolicy.identity,
    Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.FlowLogInformation.identity,
    Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.NetworkVirtualAppliance.identity,
    Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VirtualNetworkGateway.identity,
    Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
    "csharp"
  );

  @@alternateType(
    Common.LoadBalancer.extendedLocation,
    Azure.ResourceManager.CommonTypes.ExtendedLocation,
    "csharp"
  );

  @@alternateType(
    Common.NetworkInterface.extendedLocation,
    Azure.ResourceManager.CommonTypes.ExtendedLocation,
    "csharp"
  );

  @@alternateType(
    Common.PrivateEndpoint.extendedLocation,
    Azure.ResourceManager.CommonTypes.ExtendedLocation,
    "csharp"
  );

  @@alternateType(
    Common.PrivateLinkService.extendedLocation,
    Azure.ResourceManager.CommonTypes.ExtendedLocation,
    "csharp"
  );

  @@alternateType(
    Common.PublicIPAddress.extendedLocation,
    Azure.ResourceManager.CommonTypes.ExtendedLocation,
    "csharp"
  );

  @@alternateType(
    Common.VirtualNetwork.extendedLocation,
    Azure.ResourceManager.CommonTypes.ExtendedLocation,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.AzureFirewall.extendedLocation,
    Azure.ResourceManager.CommonTypes.ExtendedLocation,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.CustomIpPrefix.extendedLocation,
    Azure.ResourceManager.CommonTypes.ExtendedLocation,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.PublicIPPrefix.extendedLocation,
    Azure.ResourceManager.CommonTypes.ExtendedLocation,
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VirtualNetworkGateway.extendedLocation,
    Azure.ResourceManager.CommonTypes.ExtendedLocation,
    "csharp"
  );

  // Preserve the old AutoRest-created writable subresource base for C#.
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility with the previous Network AutoRest C# hierarchy."
  @@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
    Common.NetworkInterfaceIPConfiguration,
    Common.WritableSubResourceModel,
    "csharp"
  );

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility with the previous Network AutoRest C# hierarchy."
  @@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
    Common.Route,
    Common.WritableSubResourceModel,
    "csharp"
  );

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility with the previous Network AutoRest C# hierarchy."
  @@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
    Common.SecurityRule,
    Common.WritableSubResourceModel,
    "csharp"
  );

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility with the previous Network AutoRest C# hierarchy."
  @@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
    Common.Subnet,
    Common.WritableSubResourceModel,
    "csharp"
  );

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility with the previous Network AutoRest C# hierarchy."
  @@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
    Common.VirtualNetworkPeering,
    Common.WritableSubResourceModel,
    "csharp"
  );

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility with the previous Network AutoRest C# hierarchy."
  @@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
    Common.Delegation,
    Common.WritableSubResourceModel,
    "csharp"
  );

  // Preserve WritableSubResource-based collections from the old AutoRest API surface.
  @@alternateType(
    Common.BackendAddressPoolPropertiesFormat.inboundNatRules,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Common.BackendAddressPoolPropertiesFormat.loadBalancingRules,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Common.BackendAddressPoolPropertiesFormat.outboundRules,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Common.FrontendIPConfigurationPropertiesFormat.inboundNatPools,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Common.FrontendIPConfigurationPropertiesFormat.inboundNatRules,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Common.FrontendIPConfigurationPropertiesFormat.loadBalancingRules,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Common.FrontendIPConfigurationPropertiesFormat.outboundRules,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Common.NatGatewayPropertiesFormat.subnets,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Common.OutboundRulePropertiesFormat.frontendIPConfigurations,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Common.ProbePropertiesFormat.loadBalancingRules,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ApplicationGatewayBackendHttpSettingsPropertiesFormat.authenticationCertificates,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ApplicationGatewayBackendHttpSettingsPropertiesFormat.trustedRootCertificates,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ApplicationGatewayBackendSettingsPropertiesFormat.trustedRootCertificates,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ApplicationGatewayRedirectConfigurationPropertiesFormat.pathRules,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ApplicationGatewayRedirectConfigurationPropertiesFormat.requestRoutingRules,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ApplicationGatewayRedirectConfigurationPropertiesFormat.urlPathMaps,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ApplicationGatewaySslProfilePropertiesFormat.trustedClientCertificates,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ContainerNetworkInterfaceConfigurationPropertiesFormat.containerNetworkInterfaces,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.DdosCustomPolicyPropertiesFormat.publicIPAddresses,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.DdosProtectionPlanPropertiesFormat.publicIPAddresses,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.DdosProtectionPlanPropertiesFormat.virtualNetworks,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.ExpressRoutePortPropertiesFormat.circuits,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.FirewallPolicyPropertiesFormat.childPolicies,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.FirewallPolicyPropertiesFormat.firewalls,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.FirewallPolicyPropertiesFormat.ruleCollectionGroups,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.IpGroupPropertiesFormat.firewallPolicies,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.IpGroupPropertiesFormat.firewalls,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.NetworkVirtualAppliancePropertiesFormat.inboundSecurityRules,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.NetworkVirtualAppliancePropertiesFormat.virtualApplianceConnections,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.NetworkVirtualAppliancePropertiesFormat.virtualApplianceSites,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.NspAccessRuleProperties.subscriptions,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.P2SConnectionConfigurationProperties.configurationPolicyGroupAssociations,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VirtualHubProperties.bgpConnections,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VirtualHubProperties.routeMaps,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VirtualNetworkGatewayConnectionPropertiesFormat.egressNatRules,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VirtualNetworkGatewayConnectionPropertiesFormat.ingressNatRules,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VirtualNetworkGatewayPolicyGroupProperties.vngClientConnectionConfigurations,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VirtualRouterPropertiesFormat.peerings,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VirtualWanProperties.virtualHubs,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VirtualWanProperties.vpnSites,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VngClientConnectionConfigurationProperties.virtualNetworkGatewayPolicyGroups,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VpnGatewayNatRuleProperties.egressVpnSiteLinkConnections,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VpnGatewayNatRuleProperties.ingressVpnSiteLinkConnections,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VpnServerConfigurationPolicyGroupProperties.p2SConnectionConfigurations,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VpnSiteLinkConnectionProperties.egressNatRules,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.VpnSiteLinkConnectionProperties.ingressNatRules,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.WebApplicationFirewallPolicyPropertiesFormat.httpListeners,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@alternateType(
    Microsoft.Network.WebApplicationFirewallPolicyPropertiesFormat.pathBasedRules,
    Azure.ResourceManager.Models.WritableSubResource[],
    "csharp"
  );

  @@clientName(Microsoft.Network.Action, "RouteMapAction", "csharp");

  @@clientName(
    Microsoft.Network.Parameter,
    "RouteMapActionParameter",
    "csharp"
  );

  @@clientName(Microsoft.Network.Action.type, "ActionType", "csharp");

  @@clientName(Microsoft.Network.Criterion, "RouteCriterion", "csharp");

  @@clientName(
    Microsoft.Network.NextStep,
    "RouteMapNextStepBehavior",
    "csharp"
  );

  @@clientName(Microsoft.Network.SlotType, "SwapSlotType", "csharp");

  @@clientName(Microsoft.Network.QosDefinition, "DscpQosDefinition", "csharp");

  @@clientName(
    Microsoft.Network.AccessRuleDirection,
    "NetworkSecurityPerimeterAccessRuleDirection",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.PerimeterBasedAccessRule,
    "NetworkSecurityPerimeterBasedAccessRule",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.AssociationAccessMode,
    "NetworkSecurityPerimeterAssociationAccessMode",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.DelegationProperties,
    "VirtualApplianceDelegationProperties",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ConnectivityHop,
    "ConnectivityHopInfo",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ConfigurationGroup,
    "NetworkConfigurationGroup",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.VirtualNetworkGatewayNatRuleProperties.type,
    "VpnNatRuleType",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.VpnGatewayNatRuleProperties.type,
    "VpnNatRuleType",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.IpAllocationPropertiesFormat.type,
    "IPAllocationType",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.VirtualWanProperties.type,
    "VirtualWanType",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.VpnServerConfigurationProperties.name,
    "NamePropertiesName",
    "csharp"
  );

  @@access(
    Microsoft.Network.VpnServerConfigurationProperties.name,
    Azure.ClientGenerator.Core.Access.internal,
    "csharp"
  );

  @@clientName(
    Microsoft.Network.VpnServerConfigurationProperties.etag,
    "PropertiesETag",
    "csharp"
  );

  @@access(
    Microsoft.Network.VpnServerConfigurationProperties.etag,
    Azure.ClientGenerator.Core.Access.internal,
    "csharp"
  );

  @@clientName(
    Microsoft.Network.NetworkVirtualApplianceConnectionProperties.name,
    "NamePropertiesName",
    "csharp"
  );

  // C# API compatibility: previous GA exposed these ETag fields as Azure.ETag.
  @@alternateType(
    Common.NetworkInterfaceIPConfiguration.etag,
    Azure.Core.eTag,
    "csharp"
  );

  @@alternateType(Common.SecurityRule.etag, Azure.Core.eTag, "csharp");

  // C# naming mitigations for MPG migration hierarchy parity.
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Brownfield C# SDK resource hierarchy compatibility without generated Swagger changes."
  @@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
    Microsoft.Network.ExpressRouteConnection,
    Common.SubResourceModel,
    "csharp"
  );

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Brownfield C# SDK resource hierarchy compatibility without generated Swagger changes."
  @@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
    Microsoft.Network.ExpressRouteCrossConnectionPeering,
    Common.SubResourceModel,
    "csharp"
  );

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Brownfield C# SDK resource hierarchy compatibility without generated Swagger changes."
  @@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
    Microsoft.Network.ExpressRouteLink,
    Common.SubResourceModel,
    "csharp"
  );

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Brownfield C# SDK resource hierarchy compatibility without generated Swagger changes."
  @@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
    Microsoft.Network.HubVirtualNetworkConnection,
    Common.SubResourceModel,
    "csharp"
  );

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Brownfield C# SDK resource hierarchy compatibility without generated Swagger changes."
  @@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
    Microsoft.Network.NetworkVirtualApplianceConnection,
    Common.SubResourceModel,
    "csharp"
  );

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Brownfield C# SDK resource hierarchy compatibility without generated Swagger changes."
  @@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
    Microsoft.Network.PacketCaptureResult,
    Common.SubResourceModel,
    "csharp"
  );

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Brownfield C# SDK resource hierarchy compatibility without generated Swagger changes."
  @@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
    Microsoft.Network.PrivateDnsZoneGroup,
    Common.SubResourceModel,
    "csharp"
  );

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Brownfield C# SDK resource hierarchy compatibility without generated Swagger changes."
  @@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
    Microsoft.Network.RouteFilterRule,
    Common.SubResourceModel,
    "csharp"
  );

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Brownfield C# SDK resource hierarchy compatibility without generated Swagger changes."
  @@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
    Microsoft.Network.VirtualHubRouteTableV2,
    Common.SubResourceModel,
    "csharp"
  );

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Brownfield C# SDK resource hierarchy compatibility without generated Swagger changes."
  @@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
    Microsoft.Network.VpnConnection,
    Common.SubResourceModel,
    "csharp"
  );

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Brownfield C# SDK resource hierarchy compatibility without generated Swagger changes."
  @@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
    Microsoft.Network.ApplicationGatewayWafDynamicManifestResult,
    Common.SubResourceModel,
    "csharp"
  );

  @@clientLocation(
    Microsoft.Compute.NetworkInterfacesOperationGroup.listVirtualMachineScaleSetNetworkInterfaces,
    "VirtualMachineScaleSetNetwork",
    "csharp"
  );

  @@clientLocation(
    Microsoft.Compute.NetworkInterfaces.listVirtualMachineScaleSetVMNetworkInterfaces,
    "VirtualMachineScaleSetVmNetwork",
    "csharp"
  );

  @@clientLocation(
    Microsoft.Compute.NetworkInterfaces.getVirtualMachineScaleSetNetworkInterface,
    "VirtualMachineScaleSetVmNetwork",
    "csharp"
  );

  @@clientName(
    Microsoft.Compute.NetworkInterfaceIPConfigurations,
    "VirtualMachineScaleSetNetworkInterfaceIPConfigurations",
    "csharp"
  );

  @@clientLocation(P2SVpnGateways.reset, "P2sVpnGateways", "csharp");

  @@clientName(
    Microsoft.Network.PrivateEndpoints.privateDnsZoneGroupsDelete,
    "DeletePrivateDnsZoneGroup",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.PrivateEndpoints.privateDnsZoneGroupsGet,
    "GetPrivateDnsZoneGroup",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.PrivateEndpoints.privateDnsZoneGroupsCreateOrUpdate,
    "CreateOrUpdatePrivateDnsZoneGroup",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.PrivateEndpoints.privateDnsZoneGroupsList,
    "GetPrivateDnsZoneGroups",
    "csharp"
  );

  @@clientName(
    RouteFilters.routeFilterRulesDelete,
    "DeleteRouteFilterRule",
    "csharp"
  );

  @@clientName(
    RouteFilters.routeFilterRulesGet,
    "GetRouteFilterRule",
    "csharp"
  );

  @@clientName(
    RouteFilters.routeFilterRulesCreateOrUpdate,
    "CreateOrUpdateRouteFilterRule",
    "csharp"
  );

  @@clientName(RouteFilters.listByRouteFilter, "GetRouteFilterRules", "csharp");

  @@clientName(
    NetworkVirtualApplianceConnections.networkVirtualApplianceConnectionsDelete,
    "DeleteNetworkVirtualApplianceConnection",
    "csharp"
  );

  @@clientName(
    NetworkVirtualApplianceConnections.networkVirtualApplianceConnectionsGet,
    "GetNetworkVirtualApplianceConnection",
    "csharp"
  );

  @@clientName(
    NetworkVirtualApplianceConnections.networkVirtualApplianceConnectionsCreateOrUpdate,
    "CreateOrUpdateNetworkVirtualApplianceConnection",
    "csharp"
  );

  @@clientName(
    NetworkVirtualApplianceConnections.networkVirtualApplianceConnectionsList,
    "GetNetworkVirtualApplianceConnections",
    "csharp"
  );

  @@clientName(
    VirtualHubs.hubVirtualNetworkConnectionsDelete,
    "DeleteHubVirtualNetworkConnection",
    "csharp"
  );

  @@clientName(
    VirtualHubs.hubVirtualNetworkConnectionsGet,
    "GetHubVirtualNetworkConnection",
    "csharp"
  );

  @@clientName(
    VirtualHubs.hubVirtualNetworkConnectionsCreateOrUpdate,
    "CreateOrUpdateHubVirtualNetworkConnection",
    "csharp"
  );

  @@clientName(
    VirtualHubs.hubVirtualNetworkConnectionsList,
    "GetHubVirtualNetworkConnections",
    "csharp"
  );

  @@clientName(
    VirtualHubs.virtualHubRouteTableV2sDelete,
    "DeleteVirtualHubRouteTableV2",
    "csharp"
  );

  @@clientName(
    VirtualHubs.virtualHubRouteTableV2sGet,
    "GetVirtualHubRouteTableV2",
    "csharp"
  );

  @@clientName(
    VirtualHubs.virtualHubRouteTableV2sCreateOrUpdate,
    "CreateOrUpdateVirtualHubRouteTableV2",
    "csharp"
  );

  @@clientName(
    VirtualHubs.virtualHubRouteTableV2sList,
    "GetVirtualHubRouteTableV2s",
    "csharp"
  );

  @@clientName(
    ExpressRouteGateways.expressRouteConnectionsDelete,
    "DeleteExpressRouteConnection",
    "csharp"
  );

  @@clientName(
    ExpressRouteGateways.expressRouteConnectionsGet,
    "GetExpressRouteConnection",
    "csharp"
  );

  @@clientName(
    ExpressRouteGateways.expressRouteConnectionsCreateOrUpdate,
    "CreateOrUpdateExpressRouteConnection",
    "csharp"
  );

  @@clientName(
    ExpressRouteGateways.list,
    "GetExpressRouteConnections",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ConnectionMonitor,
    "ConnectionMonitorContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ConnectionMonitorResult,
    "ConnectionMonitor",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.PacketCapture,
    "PacketCaptureContent",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.PacketCaptureResult,
    "PacketCapture",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.AdminRuleCollection,
    "AdminRuleGroup",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ApplicationGatewayWafDynamicManifestResult,
    "ApplicationGatewayWafDynamicManifest",
    "csharp"
  );

  @@clientName(Microsoft.Network.SwapResource, "CloudServiceSwap", "csharp");

  @@clientName(
    Microsoft.Network.StaticMember,
    "NetworkGroupStaticMember",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.RoutingRuleCollection,
    "NetworkManagerRoutingRules",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.RoutingRule,
    "NetworkManagerRoutingRule",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.SecurityUserConfiguration,
    "NetworkManagerSecurityUserConfiguration",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.SecurityUserRuleCollection,
    "NetworkManagerSecurityUserRules",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.SecurityUserRule,
    "NetworkManagerSecurityUserRule",
    "csharp"
  );

  @@clientName(
    Common.PrivateEndpointConnection,
    "NetworkPrivateEndpointConnection",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.NspAssociation,
    "NetworkSecurityPerimeterAssociation",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.NspLinkReference,
    "NetworkSecurityPerimeterLinkReference",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.NspLink,
    "NetworkSecurityPerimeterLink",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.NspLoggingConfiguration,
    "NetworkSecurityPerimeterLoggingConfiguration",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.NspProfile,
    "NetworkSecurityPerimeterProfile",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.NspAccessRule,
    "NetworkSecurityPerimeterAccessRule",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.VerifierWorkspace,
    "NetworkVerifierWorkspace",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.SignaturesOverrides,
    "PolicySignaturesOverridesForIdps",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ConnectionSharedKeyResult,
    "VpnLinkConnectionSharedKey",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.NetworkManagerConnection,
    "SubscriptionNetworkManagerConnection",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ManagementGroupNetworkManagerConnections,
    "ManagementGroupNetworkManagerConnections",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ScrubbingRuleEntryMatchOperator.Equals,
    "EqualsValue",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ExceptionEntrySelectorMatchOperator.Equals,
    "EqualsValue",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ExceptionEntryValueMatchOperator.Equals,
    "EqualsValue",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.RouteMapMatchCondition.Equals,
    "EqualsValue",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.OwaspCrsExclusionEntrySelectorMatchOperator.Equals,
    "EqualsValue",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.Subnets.resourceNavigationLinksList,
    "GetResourceNavigationLinks",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.Subnets.serviceAssociationLinksList,
    "GetServiceAssociationLinks",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.AvailableDelegationsOperationGroup.list,
    "GetAvailableDelegations",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.AvailableResourceGroupDelegationsOperationGroup.list,
    "GetAvailableResourceGroupDelegations",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.AvailableServiceAliasesOperationGroup.list,
    "GetAvailableServiceAliases",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.AvailableServiceAliasesOperationGroup.listByResourceGroup,
    "GetAvailableServiceAliasesByResourceGroup",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.AvailablePrivateEndpointTypesOperationGroup.list,
    "GetAvailablePrivateEndpointTypes",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.AvailablePrivateEndpointTypesOperationGroup.listByResourceGroup,
    "GetAvailablePrivateEndpointTypesByResourceGroup",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ExpressRouteProviderPorts.list,
    "GetExpressRouteProviderPorts",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.AzureFirewallFqdnTagsOperationGroup.listAll,
    "GetAzureFirewallFqdnTags",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.AvailableEndpointServicesOperationGroup.list,
    "GetAvailableEndpointServices",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ExpressRouteServiceProvidersOperationGroup.list,
    "GetExpressRouteServiceProviders",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.NetworkSecurityPerimeterAssociableResourceTypesOperationGroup.list,
    "GetNetworkSecurityPerimeterAssociableResourceTypes",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.NetworkSecurityPerimeterServiceTagsOperationGroup.list,
    "GetNetworkSecurityPerimeterServiceTags",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.BgpServiceCommunitiesOperationGroup.list,
    "GetBgpServiceCommunities",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ServiceTagsOperationGroup.list,
    "GetServiceTag",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ServiceTagInformationOperationGroup.list,
    "GetAllServiceTagInformation",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.UsagesOperationGroup.list,
    "GetUsages",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ConnectionSharedKeyResults.getDefaultSharedKey,
    "GetSharedKey",
    "csharp"
  );

  @@clientName(
    Microsoft.Network.ConnectionSharedKeyResults.listDefaultSharedKey,
    "GetDefaultSharedKey",
    "csharp"
  );
}
