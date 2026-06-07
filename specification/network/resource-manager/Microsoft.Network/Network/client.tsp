import "./Network/main.tsp";
import "./Vmss/main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.Core;
using Microsoft.Network;
using Microsoft.Compute;
using Common;

#suppress "@azure-tools/typespec-client-generator-core/inconsistent-multiple-service-dependency" "temporarily suppressing"
@client({
  name: "CombineClient",
  service: [Microsoft.Network, Microsoft.Compute],
  autoMergeService: true,
})
namespace CombineClient;

@@clientLocation(
  Microsoft.Compute.NetworkInterfaceIPConfigurations.getVirtualMachineScaleSetIpConfiguration,
  Microsoft.Network.NetworkInterfaces
);

@@clientLocation(
  Microsoft.Compute.NetworkInterfaceIPConfigurations.listVirtualMachineScaleSetIpConfigurations,
  Microsoft.Network.NetworkInterfaces
);

@@clientLocation(
  Microsoft.Compute.NetworkInterfacesOperationGroup.listVirtualMachineScaleSetNetworkInterfaces,
  Microsoft.Network.NetworkInterfaces
);

@@clientLocation(
  Microsoft.Compute.PublicIPAddressesOperationGroup.listVirtualMachineScaleSetPublicIPAddresses,
  Microsoft.Network.PublicIPAddresses
);

@@clientName(
  CombineClient,
  "NetworkManagementClient",
  "csharp,javascript,python"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.ErrorResponse,
  "ArmErrorResponse",
  "csharp,javascript,python"
);

// Java naming mitigations
@@clientName(
  Microsoft.Network.ApplicationGatewayBackendHttpSettingsPropertiesFormat.hostName,
  "hostname",
  "java"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayBackendSettingsPropertiesFormat.hostName,
  "hostname",
  "java"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayHttpListenerPropertiesFormat.hostName,
  "hostname",
  "java"
);
@@clientName(
  Microsoft.Network.BastionActiveSession.userName,
  "username",
  "java"
);
@@clientName(
  Microsoft.Network.AzureReachabilityReportLatencyInfo.timeStamp,
  "timestamp",
  "java"
);
@@clientName(Microsoft.Network.QosIpRange.startIP, "startIp", "java");
@@clientName(Microsoft.Network.QosIpRange.endIP, "endIp", "java");
// Mitigate ProvisioningState split: create unified union with all values
@@clientName(
  Common.ProvisioningState,
  "CommonProvisioningState",
  "java,javascript"
);

// Fix definition error on required property. Only "matchVariable" property is required.
@@alternateType(
  ApplicationGatewayFirewallExclusion,
  ApplicationGatewayFirewallExclusionRequireMatchVariable,
  "java"
);
@@clientName(
  ApplicationGatewayFirewallExclusion,
  "ApplicationGatewayFirewallExclusionRequireAll",
  "java"
);
/**
 * Allow to exclude some variable satisfy the condition for the WAF check.
 */
@clientName("ApplicationGatewayFirewallExclusion", "java")
model ApplicationGatewayFirewallExclusionRequireMatchVariable {
  /**
   * The variable to be excluded.
   */
  matchVariable: string;

  /**
   * When matchVariable is a collection, operate on the selector to specify which elements in the collection this exclusion applies to.
   */
  selectorMatchOperator?: string;

  /**
   * When matchVariable is a collection, operator used to specify which elements in the collection this exclusion applies to.
   */
  selector?: string;
}
// Fix ProvisioningState
#suppress "@azure-tools/typespec-azure-core/no-enum" "Backward compatibility for Java SDK by merging ProvisioningState values"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Mirror union for backward compatibility"
union ProvisioningStateUnion {
  string,
  Succeeded: "Succeeded",
  Updating: "Updating",
  Deleting: "Deleting",
  Failed: "Failed",
  Canceled: "Canceled",
  Creating: "Creating",
}

@@clientName(ProvisioningStateUnion, "ProvisioningState", "java");

@@alternateType(
  Microsoft.Network.AdminPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.AdminRuleCollectionPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewayAuthenticationCertificatePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.ApplicationGatewayBackendAddressPoolPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewayBackendHttpSettingsPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewayBackendSettingsPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewayEntraJWTValidationConfigPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewayFirewallRuleSetPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewayFrontendPortPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewayHttpListenerPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.ApplicationGatewayIPConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewayListenerPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewayLoadDistributionPolicyPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewayPathRulePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewayPrivateEndpointConnectionProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewayPrivateLinkConfigurationProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewayPrivateLinkIpConfigurationProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewayProbePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewayPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewayRequestRoutingRulePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewayRewriteRuleSetPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewayRoutingRulePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewaySslCertificatePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewaySslProfilePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewayTrustedClientCertificatePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewayTrustedRootCertificatePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ApplicationGatewayUrlPathMapPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.ApplicationSecurityGroupPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.AuthorizationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.AzureFirewallApplicationRuleCollectionPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.AzureFirewallFqdnTagPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.AzureFirewallIPConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.AzureFirewallNatRuleCollectionProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.AzureFirewallNetworkRuleCollectionPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.AzureFirewallPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.BackendAddressPoolPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.BastionHostIPConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.BastionHostPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.BgpConnectionProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ConnectionMonitorResultProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ConnectivityConfigurationProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ContainerNetworkInterfaceConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ContainerNetworkInterfaceIpConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ContainerNetworkInterfacePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.CustomIpPrefixPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.DdosCustomPolicyPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.DdosDetectionRulePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.DdosProtectionPlanPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.DefaultAdminPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.DelegationProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.DscpConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ExpressRouteCircuitConnectionPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ExpressRouteCircuitPeeringPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ExpressRouteCircuitPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ExpressRouteConnectionProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ExpressRouteCrossConnectionPeeringProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ExpressRouteCrossConnectionProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ExpressRouteGatewayProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ExpressRouteLinkPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ExpressRoutePortAuthorizationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ExpressRoutePortPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ExpressRoutePortsLocationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ExpressRouteServiceProviderPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.FirewallPolicyPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.FirewallPolicyRuleCollectionGroupProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.FlowLogPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.FrontendIPConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.HubIPConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.HubRouteTableProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.HubVirtualNetworkConnectionProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.InboundNatPoolPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.InboundNatRulePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.InboundSecurityRuleProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.IpamPoolProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.IPConfigurationProfilePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.IPConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.IpGroupPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.LoadBalancerPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.LoadBalancingRulePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.LocalNetworkGatewayPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.NatGatewayPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.NetworkGroupProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.NetworkInterfaceIPConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.NetworkInterfacePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.NetworkInterfaceTapConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.NetworkManagerProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.NetworkManagerRoutingConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.NetworkProfilePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.NetworkSecurityGroupPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.NetworkVirtualApplianceConnectionProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.NetworkVirtualAppliancePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.NetworkWatcherPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.OutboundRulePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.P2SConnectionConfigurationProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.P2SVpnGatewayProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.PacketCaptureResultProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.PeerExpressRouteCircuitConnectionPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.PrivateDnsZoneGroupPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.PrivateEndpointConnectionProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.PrivateEndpointProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.PrivateLinkServiceConnectionProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.PrivateLinkServiceIpConfigurationProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.PrivateLinkServiceProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.ProbePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.PublicIPAddressPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.PublicIPPrefixPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ReachabilityAnalysisIntentProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ReachabilityAnalysisRunProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.RecordSet.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.ResourceNavigationLinkFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.RouteFilterPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.RouteFilterRulePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.RouteMapProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.RoutePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.RouteTablePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.RoutingIntentProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.RoutingRuleCollectionPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.RoutingRulePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.SecurityAdminConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.SecurityPartnerProviderPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.SecurityRulePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.SecurityUserConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.SecurityUserRuleCollectionPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.SecurityUserRulePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.ServiceAssociationLinkPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.ServiceDelegationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.ServiceEndpointPolicyDefinitionPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.ServiceEndpointPolicyPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.ServiceEndpointPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.ServiceGatewayPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.SharedKeyProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.StaticCidrProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.StaticMemberProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.SubnetPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VerifierWorkspaceProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VirtualApplianceSiteProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VirtualHubProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VirtualHubRouteTableV2Properties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VirtualNetworkApplianceIpConfigurationProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VirtualNetworkAppliancePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VirtualNetworkGatewayConnectionPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VirtualNetworkGatewayIPConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VirtualNetworkGatewayNatRuleProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VirtualNetworkGatewayPolicyGroupProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VirtualNetworkGatewayPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.VirtualNetworkPeeringPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.VirtualNetworkPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Common.VirtualNetworkTapPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VirtualRouterPeeringProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VirtualRouterPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VirtualWanProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VngClientConnectionConfigurationProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VpnClientRevokedCertificatePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VpnClientRootCertificatePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VpnConnectionProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VpnGatewayNatRuleProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VpnGatewayProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VpnServerConfigurationPolicyGroupProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VpnSiteLinkConnectionProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VpnSiteLinkProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.VpnSiteProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(
  Microsoft.Network.WebApplicationFirewallPolicyPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);

@@clientName(Microsoft.Network.ErrorResponse, "NetworkErrorResponse", "java");

// IP → Ip naming mitigations for backward compatibility with hand-written wrapper code
@@clientName(Common.PublicIPAddress, "PublicIpAddress", "java");
@@clientName(Microsoft.Network.PublicIPPrefix, "PublicIpPrefix", "java");
@@clientName(Common.FrontendIPConfiguration, "FrontendIpConfiguration", "java");
@@clientName(Common.IPConfiguration, "IpConfiguration", "java");
@@clientName(Common.IPConfigurationProfile, "IpConfigurationProfile", "java");
@@clientName(
  Common.NetworkInterfaceIPConfiguration,
  "NetworkInterfaceIpConfiguration",
  "java"
);
@@clientName(
  Microsoft.Network.IPAddressAvailabilityResult,
  "IpAddressAvailabilityResult",
  "java"
);
@@clientName(
  Microsoft.Network.VerificationIPFlowResult,
  "VerificationIpFlowResult",
  "java"
);
@@clientName(
  Microsoft.Network.VerificationIPFlowParameters,
  "VerificationIpFlowParameters",
  "java"
);
@@clientName(
  Microsoft.Network.VirtualNetworkGatewayIPConfiguration,
  "VirtualNetworkGatewayIpConfiguration",
  "java"
);
@@clientName(
  Common.ApplicationGatewayIPConfiguration,
  "ApplicationGatewayIpConfiguration",
  "java"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayFrontendIPConfiguration,
  "ApplicationGatewayFrontendIpConfiguration",
  "java"
);
@@clientName(Common.IPAllocationMethod, "IpAllocationMethod", "java");
@@clientName(Common.IPVersion, "IpVersion", "java");
@@clientName(Common.PublicIPAddressSku, "PublicIpAddressSku", "java");
@@clientName(Common.PublicIPAddressSkuName, "PublicIpAddressSkuName", "java");
@@clientName(Microsoft.Network.PublicIPPrefixSku, "PublicIpPrefixSku", "java");
@@clientName(
  Common.PublicIPAddressDnsSettings,
  "PublicIpAddressDnsSettings",
  "java"
);

// Interface/client IP → Ip renames
@@clientName(Microsoft.Network.PublicIPAddresses, "PublicIpAddresses", "java");
@@clientName(Microsoft.Network.PublicIPPrefixes, "PublicIpPrefixes", "java");
@@clientName(
  Microsoft.Network.PublicIPAddressOperationGroup,
  "PublicIpAddressOperationGroup",
  "java"
);

// Property-level IP → Ip renames on PropertiesFormat models (Common)
@@clientName(
  Common.IPConfigurationPropertiesFormat.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(
  Common.IPConfigurationPropertiesFormat.publicIPAddress,
  "publicIpAddress",
  "java"
);
@@clientName(
  Common.NetworkInterfaceIPConfigurationPropertiesFormat.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(
  Common.NetworkInterfaceIPConfigurationPropertiesFormat.publicIPAddress,
  "publicIpAddress",
  "java"
);
@@clientName(
  Common.FrontendIPConfigurationPropertiesFormat.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(
  Common.FrontendIPConfigurationPropertiesFormat.publicIPAddress,
  "publicIpAddress",
  "java"
);
@@clientName(
  Common.ApplicationGatewayBackendAddressPoolPropertiesFormat.backendIPConfigurations,
  "backendIpConfigurations",
  "java"
);
@@clientName(
  Common.BackendAddressPoolPropertiesFormat.backendIPConfigurations,
  "backendIpConfigurations",
  "java"
);
@@clientName(
  Common.InboundNatRulePropertiesFormat.frontendIPConfiguration,
  "frontendIpConfiguration",
  "java"
);
@@clientName(
  Common.InboundNatPoolPropertiesFormat.frontendIPConfiguration,
  "frontendIpConfiguration",
  "java"
);
@@clientName(
  Common.LoadBalancingRulePropertiesFormat.frontendIPConfiguration,
  "frontendIpConfiguration",
  "java"
);
@@clientName(
  Common.OutboundRulePropertiesFormat.frontendIPConfigurations,
  "frontendIpConfigurations",
  "java"
);
@@clientName(
  Common.LoadBalancerPropertiesFormat.frontendIPConfigurations,
  "frontendIpConfigurations",
  "java"
);
@@clientName(
  Common.PrivateEndpointIPConfigurationProperties.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(
  Common.PrivateLinkServiceIpConfigurationProperties.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(
  Common.PrivateLinkServiceProperties.destinationIPAddress,
  "destinationIpAddress",
  "java"
);
@@clientName(
  Common.ApplicationGatewayIPConfigurationPropertiesFormat.subnet,
  "subnet",
  "java"
);

// Property-level IP → Ip renames on models (Network)
@@clientName(
  Microsoft.Network.ApplicationGatewayPropertiesFormat.gatewayIPConfigurations,
  "gatewayIpConfigurations",
  "java"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayPropertiesFormat.frontendIPConfigurations,
  "frontendIpConfigurations",
  "java"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.publicIPAddress,
  "publicIpAddress",
  "java"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayHttpListenerPropertiesFormat.frontendIPConfiguration,
  "frontendIpConfiguration",
  "java"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayListenerPropertiesFormat.frontendIPConfiguration,
  "frontendIpConfiguration",
  "java"
);
@@clientName(
  Microsoft.Network.AzureFirewallIPConfigurationPropertiesFormat.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(
  Microsoft.Network.AzureFirewallIPConfigurationPropertiesFormat.publicIPAddress,
  "publicIpAddress",
  "java"
);
@@clientName(
  Microsoft.Network.BastionHostIPConfigurationPropertiesFormat.publicIPAddress,
  "publicIpAddress",
  "java"
);
@@clientName(
  Microsoft.Network.HubIPAddresses.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(
  Microsoft.Network.HubIPConfigurationPropertiesFormat.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(
  Microsoft.Network.HubIPConfigurationPropertiesFormat.publicIPAddress,
  "publicIpAddress",
  "java"
);
@@clientName(
  Microsoft.Network.VirtualNetworkGatewayIPConfigurationPropertiesFormat.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(
  Microsoft.Network.VirtualNetworkGatewayIPConfigurationPropertiesFormat.publicIPAddress,
  "publicIpAddress",
  "java"
);
@@clientName(
  Microsoft.Network.PacketCaptureFilter.localIPAddress,
  "localIpAddress",
  "java"
);
@@clientName(
  Microsoft.Network.PacketCaptureFilter.remoteIPAddress,
  "remoteIpAddress",
  "java"
);
@@clientName(
  Microsoft.Network.VerificationIPFlowParameters.localIPAddress,
  "localIpAddress",
  "java"
);
@@clientName(
  Microsoft.Network.VerificationIPFlowParameters.remoteIPAddress,
  "remoteIpAddress",
  "java"
);
@@clientName(
  Microsoft.Network.NextHopParameters.destinationIPAddress,
  "destinationIpAddress",
  "java"
);
@@clientName(
  Microsoft.Network.NextHopParameters.sourceIPAddress,
  "sourceIpAddress",
  "java"
);
@@clientName(
  Microsoft.Network.LoadBalancerVipSwapRequest.frontendIPConfigurations,
  "frontendIpConfigurations",
  "java"
);
@@clientName(
  Microsoft.Network.LoadBalancerVipSwapRequestFrontendIPConfigurationProperties.publicIPAddress,
  "publicIpAddress",
  "java"
);
@@clientName(
  Common.PublicIPAddressPropertiesFormat.servicePublicIPAddress,
  "servicePublicIpAddress",
  "java"
);
@@clientName(
  Common.PublicIPAddressPropertiesFormat.linkedPublicIPAddress,
  "linkedPublicIpAddress",
  "java"
);

// pickHostName → pickHostname renames
@@clientName(
  Microsoft.Network.ApplicationGatewayProbePropertiesFormat.pickHostNameFromBackendHttpSettings,
  "pickHostnameFromBackendHttpSettings",
  "java"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayProbePropertiesFormat.pickHostNameFromBackendSettings,
  "pickHostnameFromBackendSettings",
  "java"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayBackendHttpSettingsPropertiesFormat.pickHostNameFromBackendAddress,
  "pickHostnameFromBackendAddress",
  "java"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayBackendSettingsPropertiesFormat.pickHostNameFromBackendAddress,
  "pickHostnameFromBackendAddress",
  "java"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayOnDemandProbe.pickHostNameFromBackendHttpSettings,
  "pickHostnameFromBackendHttpSettings",
  "java"
);

// ASN → Asn renames
@@clientName(
  Microsoft.Network.ExpressRouteCircuitPeeringPropertiesFormat.azureASN,
  "azureAsn",
  "java"
);
@@clientName(
  Microsoft.Network.ExpressRouteCircuitPeeringPropertiesFormat.peerASN,
  "peerAsn",
  "java"
);
@@clientName(
  Microsoft.Network.ExpressRouteCircuitPeeringConfig.customerASN,
  "customerAsn",
  "java"
);
@@clientName(
  Microsoft.Network.ExpressRouteCrossConnectionPeeringProperties.azureASN,
  "azureAsn",
  "java"
);
@@clientName(
  Microsoft.Network.ExpressRouteCrossConnectionPeeringProperties.peerASN,
  "peerAsn",
  "java"
);

// sTag → stag rename
@@clientName(
  Microsoft.Network.ExpressRouteCrossConnectionProperties.sTag,
  "stag",
  "java"
);

// Make read-only ExpressRoute models input for backward compat
@@usage(
  Microsoft.Network.ExpressRouteCrossConnectionPeeringProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "java"
);

// Make read-only models input for backward compat with hand-written wrapper code
@@usage(
  Microsoft.Network.PacketCaptureResult,
  Azure.ClientGenerator.Core.Usage.input,
  "java"
);
@@usage(
  Microsoft.Network.ConnectionMonitorResult,
  Azure.ClientGenerator.Core.Usage.input,
  "java"
);

// More property-level IP → Ip renames
@@clientName(
  Common.NetworkInterfacePropertiesFormat.enableIPForwarding,
  "enableIpForwarding",
  "java"
);
@@clientName(
  Common.InboundNatRulePropertiesFormat.enableFloatingIP,
  "enableFloatingIp",
  "java"
);
@@clientName(
  Common.InboundNatRulePropertiesFormat.backendIPConfiguration,
  "backendIpConfiguration",
  "java"
);
@@clientName(
  Common.LoadBalancingRulePropertiesFormat.enableFloatingIP,
  "enableFloatingIp",
  "java"
);
@@clientName(
  Common.InboundNatPoolPropertiesFormat.enableFloatingIP,
  "enableFloatingIp",
  "java"
);
@@clientName(
  Common.IPConfigurationPropertiesFormat.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
@@clientName(
  Common.PublicIPAddressPropertiesFormat.publicIPAllocationMethod,
  "publicIpAllocationMethod",
  "java"
);
@@clientName(
  Common.PublicIPAddressPropertiesFormat.publicIPAddressVersion,
  "publicIpAddressVersion",
  "java"
);
@@clientName(
  Common.NetworkInterfaceIPConfigurationPropertiesFormat.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
@@clientName(
  Common.NetworkInterfaceIPConfigurationPropertiesFormat.privateIPAddressVersion,
  "privateIpAddressVersion",
  "java"
);
@@clientName(
  Common.FrontendIPConfigurationPropertiesFormat.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
@@clientName(
  Common.FrontendIPConfigurationPropertiesFormat.privateIPAddressVersion,
  "privateIpAddressVersion",
  "java"
);
@@clientName(
  Common.PrivateLinkServiceIpConfigurationProperties.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
@@clientName(
  Common.PrivateLinkServiceIpConfigurationProperties.privateIPAddressVersion,
  "privateIpAddressVersion",
  "java"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayPrivateLinkIpConfigurationProperties.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
@@clientName(
  Microsoft.Network.BastionHostIPConfigurationPropertiesFormat.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
@@clientName(
  Microsoft.Network.HubIPConfigurationPropertiesFormat.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
@@clientName(
  Microsoft.Network.VirtualNetworkGatewayIPConfigurationPropertiesFormat.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
@@clientName(
  Microsoft.Network.RouteTargetAddressPropertiesFormat.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
@@clientName(
  Microsoft.Network.VirtualNetworkApplianceIpConfigurationProperties.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
@@clientName(
  Microsoft.Network.VirtualNetworkApplianceIpConfigurationProperties.privateIPAddressVersion,
  "privateIpAddressVersion",
  "java"
);
@@clientName(
  Microsoft.Network.PublicIPPrefixPropertiesFormat.publicIPAddressVersion,
  "publicIpAddressVersion",
  "java"
);
@@clientName(
  Microsoft.Network.IPAddressAvailabilityResult.availableIPAddresses,
  "availableIpAddresses",
  "java"
);
@@clientName(
  Microsoft.Network.DdosProtectionPlanPropertiesFormat.publicIPAddresses,
  "publicIpAddresses",
  "java"
);
@@clientName(
  Microsoft.Network.PublicIPPrefixPropertiesFormat.publicIPAddresses,
  "publicIpAddresses",
  "java"
);

// activeActive → active rename
@@clientName(
  Microsoft.Network.VirtualNetworkGatewayPropertiesFormat.activeActive,
  "active",
  "java,javascript,go"
);

// Operation renames IP → Ip
@@clientName(
  Microsoft.Network.NetworkWatchers.verifyIPFlow,
  "verifyIpFlow",
  "java"
);
@@clientName(
  Microsoft.Network.VirtualNetworks.checkIPAddressAvailability,
  "checkIpAddressAvailability",
  "java"
);

// HTTP → Http casing overrides for Java checkstyle compliance
@@clientName(Microsoft.Network.HttpConfiguration, "HttpConfiguration", "java");
@@clientName(
  Microsoft.Network.HttpConfigurationMethod,
  "HttpConfigurationMethod",
  "java"
);
@@clientName(Microsoft.Network.HttpHeader, "HttpHeader", "java");
@@clientName(Microsoft.Network.HttpMethod, "HttpMethod", "java");
@@clientName(
  Microsoft.Network.ConnectionMonitorHttpConfiguration.preferHTTPS,
  "preferHttps",
  "java"
);
@@clientName(
  Microsoft.Network.ProtocolConfiguration.HTTPConfiguration,
  "httpConfiguration",
  "java"
);
@@clientName(
  Microsoft.Network.BastionHostIPConfiguration,
  "BastionHostIpConfiguration",
  "java"
);

// Operation renames for Java (from readme.java.md)
@@clientLocation(
  Microsoft.Network.BgpConnections.get,
  "VirtualHubBgpConnections",
  "java"
);
@@clientLocation(
  Microsoft.Network.BgpConnections.createOrUpdate,
  "VirtualHubBgpConnections",
  "java"
);
@@clientLocation(
  Microsoft.Network.BgpConnections.delete,
  "VirtualHubBgpConnections",
  "java"
);
@@clientLocation(
  Microsoft.Network.InboundSecurityRuleOperationGroup.get,
  "InboundSecurityRuleOperation",
  "java"
);
@@clientLocation(
  Microsoft.Network.InboundSecurityRuleOperationGroup.createOrUpdate,
  "InboundSecurityRuleOperation",
  "java"
);

// Move operations back to top-level NetworkManagementClient for Java
@@clientLocation(BastionHosts.putBastionShareableLink, CombineClient, "java");
@@clientLocation(
  BastionHosts.deleteBastionShareableLink,
  CombineClient,
  "java"
);
@@clientLocation(
  BastionHosts.deleteBastionShareableLinkByToken,
  CombineClient,
  "java"
);
@@clientLocation(BastionHosts.getBastionShareableLink, CombineClient, "java");
@@clientLocation(BastionHosts.getActiveSessions, CombineClient, "java");
@@clientLocation(BastionHosts.disconnectActiveSessions, CombineClient, "java");
@@clientLocation(
  CheckDnsNameAvailability.checkDnsNameAvailability,
  CombineClient,
  "java"
);
@@clientLocation(
  ExpressRouteProviderPorts.expressRouteProviderPort,
  CombineClient,
  "java"
);
@@clientLocation(
  NetworkManagers.listActiveConnectivityConfigurations,
  CombineClient,
  "java"
);
@@clientLocation(
  NetworkManagers.listActiveSecurityAdminRules,
  CombineClient,
  "java"
);
@@clientLocation(
  EffectiveConfigurations.listNetworkManagerEffectiveConnectivityConfigurations,
  CombineClient,
  "java"
);
@@clientLocation(
  EffectiveConfigurations.listNetworkManagerEffectiveSecurityAdminRules,
  CombineClient,
  "java"
);
@@clientLocation(VirtualWans.supportedSecurityProviders, CombineClient, "java");
@@clientLocation(
  VirtualWans.generatevirtualwanvpnserverconfigurationvpnprofile,
  CombineClient,
  "java"
);

// Move VMSS listVirtualMachineScaleSetNetworkInterfaces to NetworkInterfaces client for Java
@@clientLocation(
  Microsoft.Compute.NetworkInterfacesOperationGroup.listVirtualMachineScaleSetNetworkInterfaces,
  Microsoft.Network.NetworkInterfaces,
  "java"
);

@@clientName(FirewallPolicyIdpsSignatureDirection.`0`, "Zero", "go");
@@clientName(FirewallPolicyIdpsSignatureDirection.`1`, "One", "go");
@@clientName(FirewallPolicyIdpsSignatureDirection.`2`, "Two", "go");
@@clientName(FirewallPolicyIdpsSignatureDirection.`3`, "Three", "go");
@@clientName(FirewallPolicyIdpsSignatureDirection.`4`, "Four", "go");
@@clientName(FirewallPolicyIdpsSignatureDirection.`5`, "Five", "go");

@@clientName(FirewallPolicyIdpsSignatureMode.`0`, "Zero", "go");
@@clientName(FirewallPolicyIdpsSignatureMode.`1`, "One", "go");
@@clientName(FirewallPolicyIdpsSignatureMode.`2`, "Two", "go");

@@clientName(FirewallPolicyIdpsSignatureSeverity.`1`, "One", "go");
@@clientName(FirewallPolicyIdpsSignatureSeverity.`2`, "Two", "go");
@@clientName(FirewallPolicyIdpsSignatureSeverity.`3`, "Three", "go");

@@clientLocation(
  BastionHosts.deleteBastionShareableLink,
  "ManagementClient",
  "go"
);
@@clientLocation(
  BastionHosts.deleteBastionShareableLinkByToken,
  "ManagementClient",
  "go"
);
@@clientLocation(
  BastionHosts.disconnectActiveSessions,
  "ManagementClient",
  "go"
);

@@clientLocation(
  ExpressRouteProviderPorts.expressRouteProviderPort,
  "ManagementClient",
  "go"
);
@@clientLocation(
  VirtualWans.generatevirtualwanvpnserverconfigurationvpnprofile,
  "ManagementClient",
  "go"
);
@@clientLocation(BastionHosts.getActiveSessions, "ManagementClient", "go");
@@clientLocation(
  BastionHosts.getBastionShareableLink,
  "ManagementClient",
  "go"
);
@@clientLocation(
  NetworkManagers.listActiveConnectivityConfigurations,
  "ManagementClient",
  "go"
);

@@clientLocation(
  NetworkManagers.listActiveSecurityAdminRules,
  "ManagementClient",
  "go"
);

@@clientLocation(
  EffectiveConfigurations.listNetworkManagerEffectiveConnectivityConfigurations,
  "ManagementClient",
  "go"
);
@@clientLocation(
  EffectiveConfigurations.listNetworkManagerEffectiveSecurityAdminRules,
  "ManagementClient",
  "go"
);
@@clientLocation(
  BastionHosts.putBastionShareableLink,
  "ManagementClient",
  "go"
);

@@clientLocation(
  BastionHosts.putBastionShareableLink,
  "ManagementClient",
  "go"
);
@@clientLocation(
  CheckDnsNameAvailability.checkDnsNameAvailability,
  "ManagementClient",
  "go"
);
@@clientLocation(
  VirtualWans.supportedSecurityProviders,
  "ManagementClient",
  "go"
);
@@clientName(AzureFirewallSkuName.AZFW_VNet, "AzfwVnet", "javascript");
@@clientName(VM, "Vm", "javascript");
@@clientName(AzureFirewallSkuName.AZFW_VNet, "AZFWVnet", "go");
@@clientName(
  FirewallPolicyPropertiesFormat.explicitProxy,
  "ExplicitProxySettings",
  "go"
);
@@clientName(ExplicitProxy, "ExplicitProxySettings", "go");

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op availablePrivateEndpointTypesOperationGroupListByResourceGroup(
  /**
   * The location of the domain name.
   */
  @path
  @segment("locations")
  location: string,

  /**
   * The name of the resource group.
   */
  @path
  @segment("resourceGroups")
  resourceGroupName: string,

  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  @body
  body: void,
): ArmResponse<AvailablePrivateEndpointTypesResult> | CloudError;

@@override(
  AvailablePrivateEndpointTypesOperationGroup.listByResourceGroup,
  availablePrivateEndpointTypesOperationGroupListByResourceGroup,
  "go,python,java"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op availablePrivateEndpointTypesOperationGroupList(
  /**
   * The location of the domain name.
   */
  @path
  @segment("locations")
  location: string,

  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...SubscriptionActionScope,
  ...Azure.ResourceManager.Legacy.Provider,

  @body
  body: void,
): ArmResponse<AvailablePrivateEndpointTypesResult> | CloudError;

@@override(
  AvailablePrivateEndpointTypesOperationGroup.list,
  availablePrivateEndpointTypesOperationGroupList,
  "go,java"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op privateLinkServicesCheckPrivateLinkServiceVisibilityByResourceGroup(
  /**
   * The location of the domain name.
   */
  @path
  @segment("locations")
  location: string,

  /**
   * The name of the resource group.
   */
  @path
  @segment("resourceGroups")
  resourceGroupName: string,

  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /**
   * The request body of CheckPrivateLinkService API call.
   */
  @body
  @clientName("parameters")
  body: CheckPrivateLinkServiceVisibilityRequest,
):
  | ArmResponse<AvailablePrivateEndpointTypesResult>
  | ArmAcceptedLroResponse<
      "Accepted and the operation will complete asynchronously.",
      ArmLroLocationHeader<FinalResult = PrivateLinkServiceVisibility>
    >
  | CloudError;

@@override(
  PrivateLinkServicesOperationGroup.checkPrivateLinkServiceVisibilityByResourceGroup,
  privateLinkServicesCheckPrivateLinkServiceVisibilityByResourceGroup,
  "go,python,java"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op privateLinkServicesOperationGrouplistAutoApprovedPrivateLinkServicesByResourceGroup(
  /**
   * The location of the domain name.
   */
  @path
  @segment("locations")
  location: string,

  /**
   * The name of the resource group.
   */
  @path
  @segment("resourceGroups")
  resourceGroupName: string,

  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  @body
  body: void,
): ArmResponse<AutoApprovedPrivateLinkServicesResult> | CloudError;

@@override(
  PrivateLinkServicesOperationGroup.listAutoApprovedPrivateLinkServicesByResourceGroup,
  privateLinkServicesOperationGrouplistAutoApprovedPrivateLinkServicesByResourceGroup,
  "go,python,java"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op replaceAvailableResourceGroupDelegationsOperationGroupList(
  /**
   * The location of the domain name.
   */
  @path
  @segment("locations")
  location: string,

  /**
   * The name of the resource group.
   */
  @path
  @segment("resourceGroups")
  resourceGroupName: string,

  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  @body
  body: void,
): Microsoft.Network.AvailableDelegationsResult | Common.CloudError;

@@override(
  AvailableResourceGroupDelegationsOperationGroup.list,
  replaceAvailableResourceGroupDelegationsOperationGroupList,
  "go,python,java"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op replaceprivateDnsZoneGroupsList(
  /**
   * The name of the private endpoint.
   */
  @path
  @segment("privateEndpoints")
  privateEndpointName: string,

  /**
   * The name of the resource group.
   */
  @path
  @segment("resourceGroups")
  resourceGroupName: string,

  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  @body
  body: void,
):
  | Azure.ResourceManager.ArmResponse<Microsoft.Network.PrivateDnsZoneGroupListResult>
  | Common.CloudError;

@@override(
  Microsoft.Network.PrivateEndpoints.privateDnsZoneGroupsList,
  replaceprivateDnsZoneGroupsList,
  "go,python,java"
);

// Java: restore Ip casing for model names (TypeSpec uses uppercase IP)
@@clientName(Microsoft.Network.HubIPAddresses, "HubIpAddresses", "java");
@@clientName(
  Microsoft.Network.HubPublicIPAddresses,
  "HubPublicIpAddresses",
  "java"
);
@@clientName(
  Microsoft.Network.IPConfigurationBgpPeeringAddress,
  "IpConfigurationBgpPeeringAddress",
  "java"
);
@@clientName(Microsoft.Network.IPRule, "IpRule", "java");
@@clientName(Microsoft.Network.IPTraffic, "IpTraffic", "java");
@@clientName(
  Microsoft.Network.AzureFirewallPublicIPAddress,
  "AzureFirewallPublicIpAddress",
  "java"
);
@@clientName(
  Microsoft.Network.AzureFirewallIPConfiguration,
  "AzureFirewallIpConfiguration",
  "java"
);
@@clientName(
  Common.PrivateEndpointIPConfiguration,
  "PrivateEndpointIpConfiguration",
  "java"
);
@@clientName(
  Common.PrivateEndpointIPVersionType,
  "PrivateEndpointIpVersionType",
  "java"
);
@@clientName(
  Microsoft.Network.LoadBalancerVipSwapRequestFrontendIPConfiguration,
  "LoadBalancerVipSwapRequestFrontendIpConfiguration",
  "java"
);
@@clientName(
  Common.NetworkInterfaceIPConfigurationPrivateLinkConnectionProperties,
  "NetworkInterfaceIpConfigurationPrivateLinkConnectionProperties",
  "java"
);
@@clientName(
  Microsoft.Network.VirtualApplianceIPConfiguration,
  "VirtualApplianceIpConfiguration",
  "java"
);
@@clientName(
  Microsoft.Network.VirtualApplianceIPConfigurationProperties,
  "VirtualApplianceIpConfigurationProperties",
  "java"
);
@@clientName(
  Microsoft.Network.PreferredIPVersion,
  "PreferredIpVersion",
  "java"
);
@@clientName(
  Common.PublicIPAddressMigrationPhase,
  "PublicIpAddressMigrationPhase",
  "java"
);
@@clientName(Common.PublicIPAddressSkuTier, "PublicIpAddressSkuTier", "java");
@@clientName(
  Microsoft.Network.PublicIPPrefixSkuName,
  "PublicIpPrefixSkuName",
  "java"
);
@@clientName(
  Microsoft.Network.PublicIPPrefixSkuTier,
  "PublicIpPrefixSkuTier",
  "java"
);

// Java: restore casing for BGP, JWT, IDPS, SNAT, SQL, LOA model names
@@clientName(Microsoft.Network.BGPCommunity, "BgpCommunity", "java");
@@clientName(
  Microsoft.Network.ApplicationGatewayEntraJWTValidationConfig,
  "ApplicationGatewayEntraJwtValidationConfig",
  "java"
);
@@clientName(
  FirewallPolicyIdpsQuerySortOrder,
  "FirewallPolicyIdpsQuerySortOrder",
  "java"
);
@@clientName(
  FirewallPolicyIdpsSignatureDirection,
  "FirewallPolicyIdpsSignatureDirection",
  "java"
);
@@clientName(
  FirewallPolicyIdpsSignatureMode,
  "FirewallPolicyIdpsSignatureMode",
  "java"
);
@@clientName(
  FirewallPolicyIdpsSignatureSeverity,
  "FirewallPolicyIdpsSignatureSeverity",
  "java"
);
@@clientName(Microsoft.Network.IdpsQueryObject, "IdpsQueryObject", "java");
@@clientName(
  Microsoft.Network.FirewallPolicySnat,
  "FirewallPolicySnat",
  "java"
);
@@clientName(Microsoft.Network.FirewallPolicySQL, "FirewallPolicySql", "java");
@@clientName(
  Microsoft.Network.GenerateExpressRoutePortsLOARequest,
  "GenerateExpressRoutePortsLoaRequest",
  "java"
);

// Java: restore property name casing
@@clientName(
  Microsoft.Network.StaticCidrProperties.numberOfIPAddressesToAllocate,
  "numberOfIpAddressesToAllocate",
  "java"
);
@@clientName(
  Microsoft.Network.StaticCidrProperties.totalNumberOfIPAddresses,
  "totalNumberOfIpAddresses",
  "java"
);
@@clientName(
  Microsoft.Network.VpnClientConnectionHealthDetail.vpnUserName,
  "vpnUsername",
  "java"
);
@@clientName(
  Microsoft.Network.ApplicationRule.terminateTLS,
  "terminateTls",
  "java"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayBackendHttpSettingsPropertiesFormat.validateSNI,
  "validateSni",
  "java"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayPrivateLinkIpConfigurationProperties.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(
  Microsoft.Network.ConnectionMonitorTestConfiguration.preferredIPVersion,
  "preferredIpVersion",
  "java"
);
@@clientName(
  Microsoft.Network.ConnectivityParameters.preferredIPVersion,
  "preferredIpVersion",
  "java"
);
@@clientName(
  Common.LoadBalancerBackendAddressPropertiesFormat.loadBalancerFrontendIPConfiguration,
  "loadBalancerFrontendIpConfiguration",
  "java"
);
@@clientName(
  Common.LoadBalancerBackendAddressPropertiesFormat.networkInterfaceIPConfiguration,
  "networkInterfaceIpConfiguration",
  "java"
);
@@clientName(
  Microsoft.Network.LoadBalancerHealthPerRulePerBackendAddress.networkInterfaceIPConfigurationId,
  "networkInterfaceIpConfigurationId",
  "java"
);
@@clientName(
  Microsoft.Network.VirtualNetworkApplianceIpConfigurationProperties.privateIPAddress,
  "privateIpAddress",
  "java"
);
// Fluent model renames (IP→Ip, JWT→Jwt, LOA→Loa)
@@clientName(
  Common.ApplicationGatewayIPConfigurationPropertiesFormat,
  "ApplicationGatewayIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayFrontendIPConfigurationPropertiesFormat,
  "ApplicationGatewayFrontendIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(
  Microsoft.Network.AzureFirewallIPConfigurationPropertiesFormat,
  "AzureFirewallIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(
  Microsoft.Network.BastionHostIPConfigurationPropertiesFormat,
  "BastionHostIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(
  Common.FrontendIPConfigurationPropertiesFormat,
  "FrontendIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(
  Microsoft.Network.HubIPConfigurationPropertiesFormat,
  "HubIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(
  Common.IPConfigurationProfilePropertiesFormat,
  "IpConfigurationProfilePropertiesFormat",
  "java"
);
@@clientName(
  Common.IPConfigurationPropertiesFormat,
  "IpConfigurationPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.IPPrefixesList, "IpPrefixesList", "java");
@@clientName(
  Microsoft.Network.LoadBalancerVipSwapRequestFrontendIPConfigurationProperties,
  "LoadBalancerVipSwapRequestFrontendIpConfigurationProperties",
  "java"
);
@@clientName(
  Common.NetworkInterfaceIPConfigurationPropertiesFormat,
  "NetworkInterfaceIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(
  Common.PrivateEndpointIPConfigurationProperties,
  "PrivateEndpointIpConfigurationProperties",
  "java"
);
@@clientName(
  Common.PublicIPAddressPropertiesFormat,
  "PublicIpAddressPropertiesFormat",
  "java"
);
@@clientName(
  Microsoft.Network.PublicIPPrefixPropertiesFormat,
  "PublicIpPrefixPropertiesFormat",
  "java"
);
@@clientName(
  Microsoft.Network.VirtualNetworkGatewayIPConfigurationPropertiesFormat,
  "VirtualNetworkGatewayIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayEntraJWTValidationConfigPropertiesFormat,
  "ApplicationGatewayEntraJwtValidationConfigPropertiesFormat",
  "java"
);
@@clientName(
  Microsoft.Network.GenerateExpressRoutePortsLOAResult,
  "GenerateExpressRoutePortsLoaResult",
  "java"
);
@@clientName(Microsoft.Network.VirtualWAN, "VirtualWan", "java");
// Interface/operation group renames
@@clientName(
  Microsoft.Network.FrontendIPConfigurations,
  "FrontendIpConfigurations",
  "java"
);
@@clientName(
  Microsoft.Network.NetworkInterfaceIPConfigurations,
  "NetworkInterfaceIpConfigurations",
  "java"
);
// etag header
@@clientName(NetworkGroupCreateOrUpdateEtagHeader.eTag, "etag", "java");

// python
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384,
  "TLS_ECDHE_RSA_WITH_AES256_CBC_SHA384",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA,
  "TLS_DHE_DSS_WITH3_DES_EDE_CBC_SHA",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_DHE_DSS_WITH_AES_128_CBC_SHA,
  "TLS_DHE_DSS_WITH_AES128_CBC_SHA",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_DHE_DSS_WITH_AES_128_CBC_SHA256,
  "TLS_DHE_DSS_WITH_AES128_CBC_SHA256",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_DHE_DSS_WITH_AES_256_CBC_SHA,
  "TLS_DHE_DSS_WITH_AES256_CBC_SHA",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_DHE_DSS_WITH_AES_256_CBC_SHA256,
  "TLS_DHE_DSS_WITH_AES256_CBC_SHA256",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_DHE_RSA_WITH_AES_128_CBC_SHA,
  "TLS_DHE_RSA_WITH_AES128_CBC_SHA",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_DHE_RSA_WITH_AES_128_GCM_SHA256,
  "TLS_DHE_RSA_WITH_AES128_GCM_SHA256",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_DHE_RSA_WITH_AES_256_CBC_SHA,
  "TLS_DHE_RSA_WITH_AES256_CBC_SHA",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_DHE_RSA_WITH_AES_256_GCM_SHA384,
  "TLS_DHE_RSA_WITH_AES256_GCM_SHA384",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,
  "TLS_ECDHE_ECDSA_WITH_AES128_CBC_SHA",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256,
  "TLS_ECDHE_ECDSA_WITH_AES128_CBC_SHA256",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,
  "TLS_ECDHE_ECDSA_WITH_AES128_GCM_SHA256",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA,
  "TLS_ECDHE_ECDSA_WITH_AES256_CBC_SHA",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384,
  "TLS_ECDHE_ECDSA_WITH_AES256_CBC_SHA384",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,
  "TLS_ECDHE_ECDSA_WITH_AES256_GCM_SHA384",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,
  "TLS_ECDHE_RSA_WITH_AES128_CBC_SHA",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,
  "TLS_ECDHE_RSA_WITH_AES128_CBC_SHA256",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,
  "TLS_ECDHE_RSA_WITH_AES128_GCM_SHA256",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA,
  "TLS_ECDHE_RSA_WITH_AES256_CBC_SHA",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,
  "TLS_ECDHE_RSA_WITH_AES256_GCM_SHA384",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_RSA_WITH_3DES_EDE_CBC_SHA,
  "TLS_RSA_WITH3_DES_EDE_CBC_SHA",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_RSA_WITH_AES_128_CBC_SHA,
  "TLS_RSA_WITH_AES128_CBC_SHA",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_RSA_WITH_AES_128_CBC_SHA256,
  "TLS_RSA_WITH_AES128_CBC_SHA256",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_RSA_WITH_AES_128_GCM_SHA256,
  "TLS_RSA_WITH_AES128_GCM_SHA256",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_RSA_WITH_AES_256_CBC_SHA,
  "TLS_RSA_WITH_AES256_CBC_SHA",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_RSA_WITH_AES_256_CBC_SHA256,
  "TLS_RSA_WITH_AES256_CBC_SHA256",
  "python"
);
@@clientName(
  ApplicationGatewaySslCipherSuite.TLS_RSA_WITH_AES_256_GCM_SHA384,
  "TLS_RSA_WITH_AES256_GCM_SHA384",
  "python"
);
@@clientName(FirewallPolicyIdpsSignatureDirection.`0`, "ZERO", "python");
@@clientName(FirewallPolicyIdpsSignatureDirection.`1`, "ONE", "python");
@@clientName(FirewallPolicyIdpsSignatureDirection.`2`, "TWO", "python");
@@clientName(FirewallPolicyIdpsSignatureDirection.`3`, "THREE", "python");
@@clientName(FirewallPolicyIdpsSignatureDirection.`4`, "FOUR", "python");
@@clientName(FirewallPolicyIdpsSignatureDirection.`5`, "FIVE", "python");
@@clientName(FirewallPolicyIdpsSignatureMode.`0`, "ZERO", "python");
@@clientName(FirewallPolicyIdpsSignatureMode.`1`, "ONE", "python");
@@clientName(FirewallPolicyIdpsSignatureMode.`2`, "TWO", "python");
@@clientName(FirewallPolicyIdpsSignatureSeverity.`1`, "ONE", "python");
@@clientName(FirewallPolicyIdpsSignatureSeverity.`2`, "TWO", "python");
@@clientName(FirewallPolicyIdpsSignatureSeverity.`3`, "THREE", "python");

@@clientLocation(
  VirtualHubs.virtualHubRouteTableV2sGet,
  "VirtualHubRouteTableV2S",
  "python"
);
@@clientLocation(
  VirtualHubs.virtualHubRouteTableV2sCreateOrUpdate,
  "VirtualHubRouteTableV2S",
  "python"
);
@@clientLocation(
  VirtualHubs.virtualHubRouteTableV2sDelete,
  "VirtualHubRouteTableV2S",
  "python"
);
@@clientLocation(
  VirtualHubs.virtualHubRouteTableV2sList,
  "VirtualHubRouteTableV2S",
  "python"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  IpamPoolsListParameters.skip,
  0,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  IpamPoolsListParameters.top,
  50,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  ReachabilityAnalysisIntentsListParameters.skip,
  0,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  ReachabilityAnalysisIntentsListParameters.top,
  50,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  ReachabilityAnalysisRunsListParameters.skip,
  0,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  ReachabilityAnalysisRunsListParameters.top,
  50,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  StaticCidrsListParameters.skip,
  0,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  StaticCidrsListParameters.top,
  50,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  VerifierWorkspacesListParameters.skip,
  0,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  VerifierWorkspacesListParameters.top,
  50,
  "python"
);
@@alternateType(
  Microsoft.Network.EffectiveNetworkSecurityGroup.tagMap,
  string,
  "javascript"
);
@@clientLocation(
  BastionHosts.putBastionShareableLink,
  CombineClient,
  "python,javascript"
);
@@clientLocation(
  BastionHosts.deleteBastionShareableLink,
  CombineClient,
  "python,javascript"
);
@@clientLocation(
  BastionHosts.deleteBastionShareableLinkByToken,
  CombineClient,
  "python,javascript"
);
@@clientLocation(
  BastionHosts.getBastionShareableLink,
  CombineClient,
  "python,javascript"
);
@@clientLocation(
  BastionHosts.getActiveSessions,
  CombineClient,
  "python,javascript"
);
@@clientLocation(
  BastionHosts.disconnectActiveSessions,
  CombineClient,
  "python,javascript"
);
@@clientLocation(
  CheckDnsNameAvailability.checkDnsNameAvailability,
  CombineClient,
  "python,javascript"
);
@@clientLocation(
  ExpressRouteProviderPorts.expressRouteProviderPort,
  CombineClient,
  "python,javascript"
);
@@clientLocation(
  NetworkManagers.listActiveConnectivityConfigurations,
  CombineClient,
  "python,javascript"
);
@@clientLocation(
  NetworkManagers.listActiveSecurityAdminRules,
  CombineClient,
  "python,javascript"
);
@@clientLocation(
  EffectiveConfigurations.listNetworkManagerEffectiveConnectivityConfigurations,
  CombineClient,
  "python,javascript"
);
@@clientLocation(
  EffectiveConfigurations.listNetworkManagerEffectiveSecurityAdminRules,
  CombineClient,
  "python,javascript"
);
@@clientLocation(
  VirtualWans.supportedSecurityProviders,
  CombineClient,
  "python,javascript"
);
@@clientLocation(
  VirtualWans.generatevirtualwanvpnserverconfigurationvpnprofile,
  CombineClient,
  "python,javascript"
);
@@clientName(
  ConnectionSharedKeyResults.getAllSharedKeys,
  "listAllSharedKeys",
  "javascript"
);
@@clientName(
  ServiceGateways.getAddressLocations,
  "listAddressLocations",
  "javascript"
);
@@clientName(ServiceGateways.getServices, "listServices", "javascript");
@@clientName(
  ApplicationGatewayWafDynamicManifestResults.applicationGatewayWafDynamicManifestsGet,
  "list",
  "javascript"
);
@@clientName(
  Azure.ResourceManager.ResourceProvisioningState,
  "ArmResourceProvisioningState",
  "python,javascript"
);

// Method renames to maintain backward compatibility for C# (from autorest.md.bak)
@@clientName(
  ApplicationGatewaysOperationGroup.listAvailableWafRuleSets,
  "GetAppGatewayAvailableWafRuleSets",
  "csharp"
);
@@clientName(
  ApplicationGatewayAvailableSslOptionsOperationGroup.listAvailableSslOptions,
  "GetApplicationGatewayAvailableSslOptions",
  "csharp"
);
@@clientName(
  ApplicationGatewayAvailableSslOptionsOperationGroup.listAvailableSslPredefinedPolicies,
  "GetApplicationGatewayAvailableSslPredefinedPolicies",
  "csharp"
);
@@clientName(
  ApplicationGatewayAvailableSslOptionsOperationGroup.getSslPredefinedPolicy,
  "GetApplicationGatewaySslPredefinedPolicy",
  "csharp"
);
@@clientName(
  VirtualNetworkGatewayConnections.vpnDeviceConfigurationScript,
  "VpnDeviceConfigurationScript",
  "csharp"
);
@@clientName(
  VirtualNetworkGateways.generatevpnclientpackage,
  "GenerateVpnClientPackage",
  "csharp"
);
@@clientName(
  BgpConnections.listLearnedRoutes,
  "GetVirtualHubBgpConnectionLearnedRoutes",
  "csharp"
);
@@clientName(
  BgpConnections.listAdvertisedRoutes,
  "GetVirtualHubBgpConnectionAdvertisedRoutes",
  "csharp"
);
@@clientName(
  VirtualHubs.getEffectiveVirtualHubRoutes,
  "GetVirtualHubEffectiveRoutes",
  "csharp"
);
@@clientName(
  VirtualHubs.getOutboundRoutes,
  "GetVirtualHubOutboundRoutes",
  "csharp"
);
@@clientName(
  VirtualHubs.getInboundRoutes,
  "GetVirtualHubInboundRoutes",
  "csharp"
);
@@clientName(
  Microsoft.Compute.NetworkInterfacesOperationGroup.listVirtualMachineScaleSetNetworkInterfaces,
  "GetNetworkInterfaces",
  "csharp"
);
@@clientName(
  Microsoft.Compute.PublicIPAddressesOperationGroup.listVirtualMachineScaleSetPublicIPAddresses,
  "GetPublicIPAddresses",
  "csharp"
);
@@clientName(
  Microsoft.Compute.PublicIPAddresses.getVirtualMachineScaleSetPublicIPAddress,
  "GetPublicIPAddress",
  "csharp"
);
@@clientName(
  Microsoft.Compute.NetworkInterfaces.getVirtualMachineScaleSetNetworkInterface,
  "GetNetworkInterface",
  "csharp"
);
@@clientName(
  Microsoft.Compute.NetworkInterfaces.listVirtualMachineScaleSetVMNetworkInterfaces,
  "GetNetworkInterfaces",
  "csharp"
);
@@clientName(
  Microsoft.Compute.PublicIPAddresses.listVirtualMachineScaleSetVMPublicIPAddresses,
  "GetPublicIPAddresses",
  "csharp"
);
@@clientName(
  VirtualWans.generatevirtualwanvpnserverconfigurationvpnprofile,
  "GenerateVirtualWanVpnServerConfigurationVpnProfile",
  "csharp"
);

// Type renames to maintain backward compatibility for C# (from autorest.md.bak rename-mapping)
@@clientName(
  Microsoft.Network.HttpConfiguration,
  "NetworkHttpConfiguration",
  "csharp"
);
@@clientName(
  Microsoft.Network.HttpConfigurationMethod,
  "NetworkHttpConfigurationMethod",
  "csharp"
);
@@clientName(
  Microsoft.Network.HttpHeader,
  "NetworkWatcherHttpHeader",
  "csharp"
);
@@clientName(
  Microsoft.Network.HttpMethod,
  "NetworkWatcherHttpMethod",
  "csharp"
);
@@clientName(Common.IPConfiguration, "NetworkIPConfiguration", "csharp");
@@clientName(
  Common.IPConfigurationProfile,
  "NetworkIPConfigurationProfile",
  "csharp"
);
@@clientName(Common.IPVersion, "NetworkIPVersion", "csharp");
@@clientName(Common.ProvisioningState, "NetworkProvisioningState", "csharp");
@@clientName(Common.SubResource, "NetworkSubResource", "csharp");
@@clientName(Common.Resource, "NetworkTrackedResourceData", "csharp");
@@clientName(Microsoft.Network.TagsObject, "NetworkTagsObject", "csharp");
@@clientName(
  Microsoft.Network.QueryRequestOptions,
  "NetworkManagementQueryContent",
  "csharp"
);
@@clientName(Microsoft.Network.Geo, "CidrAdvertisingGeoCode", "csharp");
@@clientName(Microsoft.Network.Geo.NAM, "Nam", "csharp");
@@clientName(
  Microsoft.Network.ApplicationGatewayTierTypes.WAF,
  "Waf",
  "csharp"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayTierTypes.WAF_v2,
  "WafV2",
  "csharp"
);
@@clientName(Microsoft.Network.VpnAuthenticationType.AAD, "Aad", "csharp");
@@clientName(
  Microsoft.Network.VpnPolicyMemberAttributeType.AADGroupId,
  "AadGroupId",
  "csharp"
);
@@clientName(Microsoft.Network.IpsecEncryption.DES, "Des", "csharp");
@@clientName(Microsoft.Network.IpsecEncryption.DES3, "Des3", "csharp");
@@clientName(Microsoft.Network.IpsecEncryption.AES128, "Aes128", "csharp");
@@clientName(Microsoft.Network.IpsecEncryption.AES192, "Aes192", "csharp");
@@clientName(Microsoft.Network.IpsecEncryption.AES256, "Aes256", "csharp");
@@clientName(
  Microsoft.Network.IpsecEncryption.GCMAES128,
  "GcmAes128",
  "csharp"
);
@@clientName(
  Microsoft.Network.IpsecEncryption.GCMAES192,
  "GcmAes192",
  "csharp"
);
@@clientName(
  Microsoft.Network.IpsecEncryption.GCMAES256,
  "GcmAes256",
  "csharp"
);
@@clientName(Microsoft.Network.IpsecIntegrity.SHA1, "Sha1", "csharp");
@@clientName(Microsoft.Network.IpsecIntegrity.SHA256, "Sha256", "csharp");
@@clientName(Microsoft.Network.IpsecIntegrity.GCMAES128, "GcmAes128", "csharp");
@@clientName(Microsoft.Network.IpsecIntegrity.GCMAES192, "GcmAes192", "csharp");
@@clientName(Microsoft.Network.IpsecIntegrity.GCMAES256, "GcmAes256", "csharp");
@@clientName(Microsoft.Network.IkeEncryption.DES, "Des", "csharp");
@@clientName(Microsoft.Network.IkeEncryption.DES3, "Des3", "csharp");
@@clientName(Microsoft.Network.IkeEncryption.AES128, "Aes128", "csharp");
@@clientName(Microsoft.Network.IkeEncryption.AES192, "Aes192", "csharp");
@@clientName(Microsoft.Network.IkeEncryption.AES256, "Aes256", "csharp");
@@clientName(Microsoft.Network.IkeEncryption.GCMAES256, "GcmAes256", "csharp");
@@clientName(Microsoft.Network.IkeEncryption.GCMAES128, "GcmAes128", "csharp");
@@clientName(Microsoft.Network.IkeIntegrity.SHA1, "Sha1", "csharp");
@@clientName(Microsoft.Network.IkeIntegrity.SHA256, "Sha256", "csharp");
@@clientName(Microsoft.Network.IkeIntegrity.SHA384, "Sha384", "csharp");
@@clientName(Microsoft.Network.IkeIntegrity.GCMAES256, "GcmAes256", "csharp");
@@clientName(Microsoft.Network.IkeIntegrity.GCMAES128, "GcmAes128", "csharp");
@@clientName(Microsoft.Network.DhGroup.DHGroup1, "DhGroup1", "csharp");
@@clientName(Microsoft.Network.DhGroup.DHGroup2, "DhGroup2", "csharp");
@@clientName(Microsoft.Network.DhGroup.DHGroup14, "DhGroup14", "csharp");
@@clientName(Microsoft.Network.DhGroup.DHGroup2048, "DhGroup2048", "csharp");
@@clientName(Microsoft.Network.DhGroup.ECP256, "Ecp256", "csharp");
@@clientName(Microsoft.Network.DhGroup.ECP384, "Ecp384", "csharp");
@@clientName(Microsoft.Network.DhGroup.DHGroup24, "DhGroup24", "csharp");
@@clientName(Microsoft.Network.PfsGroup.PFS1, "Pfs1", "csharp");
@@clientName(Microsoft.Network.PfsGroup.PFS2, "Pfs2", "csharp");
@@clientName(Microsoft.Network.PfsGroup.PFS2048, "Pfs2048", "csharp");
@@clientName(Microsoft.Network.PfsGroup.ECP256, "Ecp256", "csharp");
@@clientName(Microsoft.Network.PfsGroup.ECP384, "Ecp384", "csharp");
@@clientName(Microsoft.Network.PfsGroup.PFS24, "Pfs24", "csharp");
@@clientName(Microsoft.Network.PfsGroup.PFS14, "Pfs14", "csharp");
@@clientName(Microsoft.Network.PfsGroup.PFSMM, "Pfs", "csharp");

// Property renames to maintain backward compatibility for C# (from autorest.md.bak rename-mapping)
@@clientName(
  Microsoft.Network.ApplicationGatewayBackendHttpSettingsPropertiesFormat.dedicatedBackendConnection,
  "IsDedicatedBackendConnectionEnabled",
  "csharp"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayBackendHttpSettingsPropertiesFormat.requestTimeout,
  "RequestTimeoutInSeconds",
  "csharp"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayBackendHttpSettingsPropertiesFormat.validateCertChainAndExpiry,
  "IsValidateCertChainAndExpiryEnabled",
  "csharp"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayBackendHttpSettingsPropertiesFormat.validateSNI,
  "IsValidateSniEnabled",
  "csharp"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayBackendSettingsPropertiesFormat.enableL4ClientIpPreservation,
  "IsL4ClientIPPreservationEnabled",
  "csharp"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayBackendSettingsPropertiesFormat.timeout,
  "TimeoutInSeconds",
  "csharp"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayConnectionDraining.drainTimeoutInSec,
  "DrainTimeoutInSeconds",
  "csharp"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayOnDemandProbe.enableProbeProxyProtocolHeader,
  "IsProbeProxyProtocolHeaderEnabled",
  "csharp"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayProbePropertiesFormat.enableProbeProxyProtocolHeader,
  "IsProbeProxyProtocolHeaderEnabled",
  "csharp"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayProbePropertiesFormat.interval,
  "IntervalInSeconds",
  "csharp"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayProbePropertiesFormat.timeout,
  "TimeoutInSeconds",
  "csharp"
);
@@clientName(
  Microsoft.Network.PacketCaptureParameters.continuousCapture,
  "IsContinuousCapture",
  "csharp"
);
@@clientName(
  Common.TrafficAnalyticsConfigurationProperties.trafficAnalyticsInterval,
  "TrafficAnalyticsIntervalInMinutes",
  "csharp"
);
@@clientName(
  Microsoft.Network.VpnClientConnectionHealthDetail.vpnConnectionDuration,
  "VpnConnectionDurationInSeconds",
  "csharp"
);
@@clientName(
  Common.VirtualNetworkPeeringPropertiesFormat.peerCompleteVnets,
  "AreCompleteVnetsPeered",
  "csharp"
);
@@clientName(Common.VirtualNetworkEncryption.enabled, "IsEnabled", "csharp");

@@clientName(
  ApplicationGatewayAvailableSslOptions,
  "ApplicationGatewayAvailableSslOptionsInfo",
  "csharp"
);
@@clientName(CustomIpPrefix, "CustomIPPrefix", "csharp");
@@clientName(HubIpConfiguration, "HubIPConfiguration", "csharp");
@@clientName(VirtualWAN, "VirtualWan", "csharp");
@@clientName(
  ActiveConfigurationParameter,
  "ActiveConfigurationContent",
  "csharp"
);
@@clientName(Common.AddressSpace, "VirtualNetworkAddressSpace", "csharp");
@@clientName(AdminRule, "NetworkAdminRule", "csharp");
@@clientName(
  ApplicationGatewayEntraJWTValidationConfig,
  "ApplicationGatewayEntraJwtValidationConfig",
  "csharp"
);
@@clientName(
  ApplicationGatewayPrivateLinkIpConfiguration,
  "ApplicationGatewayPrivateLinkIPConfiguration",
  "csharp"
);
@@clientName(
  AvailableProvidersListParameters,
  "AvailableProvidersListContent",
  "csharp"
);
@@clientName(
  AzureFirewallApplicationRule,
  "AzureFirewallApplicationRuleCollectionData",
  "csharp"
);
@@clientName(AzureFirewallIPGroups, "AzureFirewallIPGroups", "csharp");
@@clientName(
  AzureFirewallNatRule,
  "AzureFirewallNatRuleCollectionData",
  "csharp"
);
@@clientName(
  AzureFirewallNetworkRule,
  "AzureFirewallNetworkRuleCollectionData",
  "csharp"
);
@@clientName(
  AzureFirewallPacketCaptureResponse,
  "AzureFirewallPacketCaptureResult",
  "csharp"
);
@@clientName(
  AzureReachabilityReportParameters,
  "AzureReachabilityReportContent",
  "csharp"
);
@@clientName(
  BastionShareableLinkTokenListRequest,
  "BastionShareableLinkTokenListContent",
  "csharp"
);
@@clientName(BGPCommunity, "BgpCommunity", "csharp");
@@clientName(
  ConnectionMonitor,
  "ConnectionMonitorCreateOrUpdateContent",
  "csharp"
);
@@clientName(ConnectivityParameters, "ConnectivityContent", "csharp");
@@clientName(
  ContainerNetworkInterfaceIpConfiguration,
  "ContainerNetworkInterfaceIPConfiguration",
  "csharp"
);
@@clientName(
  Common.CustomDnsConfigPropertiesFormat,
  "CustomDnsConfigProperties",
  "csharp"
);
@@clientName(DefaultAdminRule, "NetworkDefaultAdminRule", "csharp");
@@clientName(Common.Delegation, "ServiceDelegation", "csharp");
@@clientName(
  DelegationProperties,
  "VirtualApplianceDelegationProperties",
  "csharp"
);
@@clientName(
  DisassociateCloudServicePublicIpRequest,
  "DisassociateCloudServicePublicIPContent",
  "csharp"
);
@@clientName(EffectiveRoutesParameters, "EffectiveRoutesContent", "csharp");
@@clientName(ExplicitProxy, "FirewallPolicyExplicitProxy", "csharp");
@@clientName(
  ExpressRouteFailoverStopApiParameters,
  "ExpressRouteFailoverStopApiContent",
  "csharp"
);
@@clientName(FilterItems, "IdpsQueryFilterItems", "csharp");
@@clientName(
  FirewallPacketCaptureParameters,
  "FirewallPacketCaptureRequestContent",
  "csharp"
);
@@clientName(
  FirewallPolicyFilterRuleCollection,
  "FirewallPolicyFilterRuleCollectionInfo",
  "csharp"
);
@@clientName(
  FirewallPolicyIdpsSignatureDirection,
  "FirewallPolicyIdpsSignatureDirection",
  "csharp"
);
@@clientName(
  FirewallPolicyIdpsSignatureMode,
  "FirewallPolicyIdpsSignatureMode",
  "csharp"
);
@@clientName(
  FirewallPolicyIdpsSignatureSeverity,
  "FirewallPolicyIdpsSignatureSeverity",
  "csharp"
);
@@clientName(
  FirewallPolicyNatRuleCollection,
  "FirewallPolicyNatRuleCollectionInfo",
  "csharp"
);
@@clientName(FirewallPolicySnat, "FirewallPolicySnat", "csharp");
@@clientName(FlowLogProperties, "FlowLogInformationProperties", "csharp");
@@clientName(FlowLogFormatParameters, "FlowLogProperties", "csharp");
@@clientName(FlowLogStatusParameters, "FlowLogStatusContent", "csharp");
@@clientName(
  GatewayCustomBgpIpAddressIpConfiguration,
  "GatewayCustomBgpIPAddressIPConfiguration",
  "csharp"
);
@@clientName(
  GenerateExpressRoutePortsLOARequest,
  "GenerateExpressRoutePortsLoaContent",
  "csharp"
);
@@clientName(
  GenerateExpressRoutePortsLOAResult,
  "GenerateExpressRoutePortsLoaResult",
  "csharp"
);
@@clientName(
  GetInboundRoutesParameters,
  "VirtualHubInboundRoutesContent",
  "csharp"
);
@@clientName(
  GetOutboundRoutesParameters,
  "VirtualHubOutboundRoutesContent",
  "csharp"
);
@@clientName(
  GetVpnSitesConfigurationRequest,
  "GetVpnSitesConfigurationContent",
  "csharp"
);
@@clientName(Hub, "ConnectivityHub", "csharp");
@@clientName(IdpsQueryObject, "IdpsQueryContent", "csharp");
@@clientName(InboundNatPool, "LoadBalancerInboundNatPool", "csharp");
@@clientName(
  InboundNatPoolPropertiesFormat,
  "LoadBalancerInboundNatPoolProperties",
  "csharp"
);
@@clientName(IPPrefixesList, "LearnedIPPrefixesListResult", "csharp");
@@clientName(IpsecPolicy, "IPsecPolicy", "csharp");
@@clientName(IpTag, "IPTag", "csharp");
@@clientName(IPTraffic, "NetworkVerifierIPTraffic", "csharp");
@@clientName(
  Ipv6CircuitConnectionConfig,
  "IPv6CircuitConnectionConfig",
  "csharp"
);
@@clientName(
  Ipv6ExpressRouteCircuitPeeringConfig,
  "IPv6ExpressRouteCircuitPeeringConfig",
  "csharp"
);
@@clientName(
  ListVirtualHubIpConfigurationResults,
  "ListVirtualHubIPConfigurationResults",
  "csharp"
);
@@clientName(
  ListVirtualHubRouteTableV2SResult,
  "ListVirtualHubRouteTableV2SResult",
  "csharp"
);
@@clientName(
  LoadBalancerPropertiesFormat,
  "LoadBalancingRuleProperties",
  "csharp"
);
@@clientName(
  LoadBalancerVipSwapRequest,
  "LoadBalancerVipSwapContent",
  "csharp"
);
@@clientName(MigratedPools, "MigrateLoadBalancerToIPBasedResult", "csharp");
@@clientName(
  MigrateLoadBalancerToIpBasedRequest,
  "MigrateLoadBalancerToIPBasedContent",
  "csharp"
);
@@clientName(
  NetworkConfigurationDiagnosticParameters,
  "NetworkConfigurationDiagnosticContent",
  "csharp"
);
@@clientName(
  NetworkManagerDeploymentStatusParameter,
  "NetworkManagerDeploymentStatusContent",
  "csharp"
);
@@clientName(
  NetworkVirtualApplianceBootDiagnosticParameters,
  "NetworkVirtualApplianceBootDiagnosticContent",
  "csharp"
);
@@clientName(NextHopParameters, "NextHopContent", "csharp");
@@clientName(
  NspServiceTagsListResult,
  "NetworkSecurityPerimeterServiceTagsListResult",
  "csharp"
);
@@clientName(
  NspServiceTagsResource,
  "NetworkSecurityPerimeterServiceTags",
  "csharp"
);
@@clientName(OrderBy, "IdpsQueryOrderBy", "csharp");
@@clientName(
  P2SVpnConnectionHealthRequest,
  "P2SVpnConnectionHealthContent",
  "csharp"
);
@@clientName(P2SVpnProfileParameters, "P2SVpnProfileContent", "csharp");
@@clientName(PacketCapture, "PacketCaptureCreateOrUpdateContent", "csharp");
@@clientName(
  PerimeterAssociableResource,
  "NetworkSecurityPerimeterAssociableResourceType",
  "csharp"
);
@@clientName(PoolAssociation, "IpamPoolAssociation", "csharp");
@@clientName(PoolUsage, "IpamPoolUsage", "csharp");
@@clientName(
  PrepareNetworkPoliciesRequest,
  "PrepareNetworkPoliciesContent",
  "csharp"
);
@@clientName(
  PrivateLinkServiceConnection,
  "NetworkPrivateLinkServiceConnection",
  "csharp"
);
@@clientName(
  PrivateLinkServiceIpConfiguration,
  "PrivateLinkServiceIPConfiguration",
  "csharp"
);
@@clientName(
  PublicIpDdosProtectionStatusResult,
  "PublicIPDdosProtectionStatusResult",
  "csharp"
);
@@clientName(QosDefinition, "DscpQosDefinition", "csharp");
@@clientName(QosIpRange, "QosIPRange", "csharp");
@@clientName(
  QueryInboundNatRulePortMappingRequest,
  "QueryInboundNatRulePortMappingContent",
  "csharp"
);
@@clientName(QueryResults, "IdpsSignatureListResult", "csharp");
@@clientName(
  QueryTroubleshootingParameters,
  "QueryTroubleshootingContent",
  "csharp"
);
@@clientName(
  ReserveCloudServicePublicIpAddressRequest,
  "ReserveCloudServicePublicIPAddressContent",
  "csharp"
);
@@clientName(ResourceBasics, "IpamResourceBasics", "csharp");
@@clientName(SecurityGroupViewParameters, "SecurityGroupViewContent", "csharp");
@@clientName(
  ServiceEndpointPropertiesFormat,
  "ServiceEndpointProperties",
  "csharp"
);
@@clientName(
  ServiceGatewayUpdateAddressLocationsRequest,
  "ServiceGatewayUpdateAddressLocationsContent",
  "csharp"
);
@@clientName(
  ServiceGatewayUpdateServicesRequest,
  "ServiceGatewayUpdateServicesContent",
  "csharp"
);
@@clientName(
  SharedKeyProperties,
  "VpnLinkConnectionSharedKeyProperties",
  "csharp"
);
@@clientName(
  SignatureOverridesFilterValuesQuery,
  "SignatureOverridesFilterValuesQueryContent",
  "csharp"
);
@@clientName(
  SignatureOverridesFilterValuesResponse,
  "SignatureOverridesFilterValuesResult",
  "csharp"
);
@@clientName(
  SignaturesOverridesList,
  "PolicySignaturesOverridesForIdpsListResult",
  "csharp"
);
@@clientName(
  SignaturesOverridesProperties,
  "PolicySignaturesOverridesForIdpsProperties",
  "csharp"
);
@@clientName(SlotType, "SwapSlotType", "csharp");
@@clientName(SwapResourceListResult, "CloudServiceSwapListResult", "csharp");
@@clientName(SwapResourceProperties, "CloudServiceSwapProperties", "csharp");
@@clientName(Topology, "NetworkTopology", "csharp");
@@clientName(TopologyParameters, "TopologyContent", "csharp");
@@clientName(Topology, "TopologyResourceInfo", "csharp");
@@clientName(
  TrackedResourceWithOptionalLocation,
  "NetworkResourceData",
  "csharp"
);
@@clientName(
  TrackedResourceWithSettableIdOptionalLocation,
  "NetworkWritableResourceData",
  "csharp"
);
@@clientName(TroubleshootingParameters, "TroubleshootingContent", "csharp");
@@clientName(
  UnprepareNetworkPoliciesRequest,
  "UnprepareNetworkPoliciesContent",
  "csharp"
);
@@clientName(UsagesListResult, "NetworkUsagesListResult", "csharp");
@@clientName(
  VerificationIPFlowParameters,
  "VerificationIPFlowContent",
  "csharp"
);
@@clientName(
  VerifierWorkspaceUpdate,
  "NetworkVerifierWorkspacePatch",
  "csharp"
);
@@clientName(
  VerifierWorkspaceProperties,
  "NetworkVerifierWorkspaceProperties",
  "csharp"
);
@@clientName(
  VirtualNetworkApplianceIpConfiguration,
  "VirtualNetworkApplianceIPConfiguration",
  "csharp"
);
@@clientName(
  VirtualNetworkGatewayMigrationParameters,
  "VirtualNetworkGatewayMigrationContent",
  "csharp"
);
@@clientName(
  VirtualWanVpnProfileParameters,
  "VirtualWanVpnProfileContent",
  "csharp"
);
@@clientName(VpnClientParameters, "VpnClientContent", "csharp");
@@clientName(
  VpnConnectionPacketCaptureStartParameters,
  "VpnConnectionPacketCaptureStartContent",
  "csharp"
);
@@clientName(
  VpnConnectionPacketCaptureStopParameters,
  "VpnConnectionPacketCaptureStopContent",
  "csharp"
);
@@clientName(VpnDeviceScriptParameters, "VpnDeviceScriptContent", "csharp");
@@clientName(VpnGatewayIpConfiguration, "VpnGatewayIPConfiguration", "csharp");
@@clientName(
  VpnGatewayPacketCaptureStartParameters,
  "VpnGatewayPacketCaptureStartContent",
  "csharp"
);
@@clientName(
  VpnGatewayPacketCaptureStopParameters,
  "VpnGatewayPacketCaptureStopContent",
  "csharp"
);
@@clientName(
  VpnPacketCaptureStartParameters,
  "VpnPacketCaptureStartContent",
  "csharp"
);
@@clientName(
  VpnPacketCaptureStopParameters,
  "VpnPacketCaptureStopContent",
  "csharp"
);
@@clientName(ApplicationGateway.zones, "AvailabilityZones", "csharp");
@@clientName(ApplicationGatewayBackendAddress.ipAddress, "IPAddress", "csharp");
@@clientName(
  ApplicationGatewayBackendHealthServer.ipConfiguration,
  "IPConfiguration",
  "csharp"
);
@@clientName(ApplicationRule.sourceIpGroups, "SourceIPGroups", "csharp");
@@clientName(
  AzureFirewallApplicationRule.sourceIpGroups,
  "SourceIPGroups",
  "csharp"
);
@@clientName(AzureFirewallNatRule.sourceIpGroups, "SourceIPGroups", "csharp");
@@clientName(
  AzureFirewallNetworkRule.sourceIpGroups,
  "SourceIPGroups",
  "csharp"
);
@@clientName(
  AzureFirewallNetworkRule.destinationIpGroups,
  "DestinationIPGroups",
  "csharp"
);
@@clientName(ConnectionMonitorEndpoint.type, "EndpointType", "csharp");
@@clientName(
  ConnectionMonitorHttpConfiguration.preferHTTPS,
  "PreferHttps",
  "csharp"
);
@@clientName(
  ConnectivityInformation.connectionStatus,
  "NetworkConnectionStatus",
  "csharp"
);
@@clientName(
  ContainerNetworkInterfaceIpConfiguration.type,
  "ContainerNetworkInterfaceIpConfigurationType",
  "csharp"
);
@@clientName(
  CustomDnsConfigPropertiesFormat.ipAddresses,
  "IPAddresses",
  "csharp"
);
@@clientName(
  EffectiveNetworkSecurityGroup.tagMap,
  "TagToIPAddresses",
  "csharp"
);
@@clientName(EffectiveRoute.nextHopIpAddress, "NextHopIPAddress", "csharp");
@@clientName(EndpointServiceResult.type, "ResourceType", "csharp");
@@clientName(ExpressRouteCircuitArpTable.ipAddress, "IPAddress", "csharp");
@@clientName(
  ExpressRouteFailoverConnectionResourceDetails.lastUpdatedTime,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(ExpressRouteFailoverTestDetails.startTime, "StartOn", "csharp");
@@clientName(ExpressRouteFailoverTestDetails.endTime, "EndOn", "csharp");
@@clientName(
  FirewallPolicyIntrusionDetectionBypassTrafficSpecifications.sourceIpGroups,
  "SourceIPGroups",
  "csharp"
);
@@clientName(
  FirewallPolicyIntrusionDetectionBypassTrafficSpecifications.destinationIpGroups,
  "DestinationIPGroups",
  "csharp"
);
@@clientName(
  GatewayCustomBgpIpAddressIpConfiguration.customBgpIpAddress,
  "CustomBgpIPAddress",
  "csharp"
);
@@clientName(
  GatewayLoadBalancerTunnelInterface.type,
  "InterfaceType",
  "csharp"
);
@@clientName(IpamPoolProperties.ipAddressType, "IPAddressType", "csharp");
@@clientName(IpsecPolicy.ipsecEncryption, "IPsecEncryption", "csharp");
@@clientName(IpsecPolicy.ipsecIntegrity, "IPsecIntegrity", "csharp");
@@clientName(IPTraffic.destinationIps, "DestinationIPs", "csharp");
@@clientName(
  LoadBalancerHealthPerRulePerBackendAddress.networkInterfaceIPConfigurationId,
  "NetworkInterfaceIPConfigurationResourceId",
  "csharp"
);
@@clientName(NatRule.sourceIpGroups, "SourceIPGroups", "csharp");
@@clientName(
  NetworkManagerDeploymentStatus.deploymentStatus,
  "DeploymentState",
  "csharp"
);
@@clientName(NetworkRule.sourceIpGroups, "SourceIPGroups", "csharp");
@@clientName(NetworkRule.destinationIpGroups, "DestinationIPGroups", "csharp");
@@clientName(Common.Resource.type, "ResourceType", "csharp");
@@clientName(NextHopResult.nextHopIpAddress, "NextHopIPAddress", "csharp");
@@clientName(
  PolicySettings.captchaExpirationInMins,
  "CaptchaCookieExpirationInMins",
  "csharp"
);
@@clientName(
  PrivateEndpointIPConfiguration.type,
  "PrivateEndpointIPConfigurationType",
  "csharp"
);
@@clientName(
  PublicIpDdosProtectionStatusResult.publicIpAddress,
  "PublicIPAddress",
  "csharp"
);
@@clientName(QosDefinition.sourceIpRanges, "SourceIPRanges", "csharp");
@@clientName(
  QosDefinition.destinationIpRanges,
  "DestinationIPRanges",
  "csharp"
);
@@clientName(
  ReachabilityAnalysisIntentProperties.ipTraffic,
  "IPTraffic",
  "csharp"
);
@@clientName(RecordSet.ipAddresses, "IPAddresses", "csharp");
@@clientName(StaticRoute.nextHopIpAddress, "NextHopIPAddress", "csharp");
@@clientName(
  TrackedResourceWithOptionalLocation.type,
  "ResourceType",
  "csharp"
);
@@clientName(
  TrackedResourceWithSettableIdOptionalLocation.type,
  "ResourceType",
  "csharp"
);
@@clientName(
  TunnelConnectionHealth.lastConnectionEstablishedUtcTime,
  "LastConnectionEstablishedOn",
  "csharp"
);
@@clientName(
  VirtualApplianceAdditionalNicProperties.hasPublicIp,
  "HasPublicIP",
  "csharp"
);
@@clientName(
  VirtualApplianceNicProperties.publicIpAddress,
  "PublicIPAddress",
  "csharp"
);
@@clientName(
  VirtualApplianceNicProperties.privateIpAddress,
  "PrivateIPAddress",
  "csharp"
);
@@clientName(VirtualHubRoute.nextHopIpAddress, "NextHopIPAddress", "csharp");
@@clientName(VirtualWanSecurityProvider.type, "ProviderType", "csharp");
@@clientName(
  VpnClientConfiguration.vpnClientIpsecPolicies,
  "VpnClientIPsecPolicies",
  "csharp"
);
@@clientName(
  VpnClientConnectionHealth.allocatedIpAddresses,
  "AllocatedIPAddresses",
  "csharp"
);
@@clientName(
  VpnClientConnectionHealthDetail.vpnConnectionTime,
  "VpnConnectionOn",
  "csharp"
);
@@clientName(
  VpnClientConnectionHealthDetail.publicIpAddress,
  "PublicIPAddress",
  "csharp"
);
@@clientName(
  VpnClientConnectionHealthDetail.privateIpAddress,
  "PrivateIPAddress",
  "csharp"
);
@@clientName(
  VpnClientIPsecParameters.ipsecEncryption,
  "IPsecEncryption",
  "csharp"
);
@@clientName(
  VpnClientIPsecParameters.ipsecIntegrity,
  "IPsecIntegrity",
  "csharp"
);
@@clientName(
  VpnGatewayIpConfiguration.publicIpAddress,
  "PublicIPAddress",
  "csharp"
);
@@clientName(
  VpnGatewayIpConfiguration.privateIpAddress,
  "PrivateIPAddress",
  "csharp"
);
@@alternateType(ApplicationGateway.etag, eTag, "csharp");
@@alternateType(
  ApplicationGatewayPrivateEndpointConnection.etag,
  eTag,
  "csharp"
);
@@alternateType(ApplicationSecurityGroup.etag, eTag, "csharp");
@@alternateType(AzureFirewall.etag, eTag, "csharp");
@@alternateType(BackendAddressPool.etag, eTag, "csharp");
@@alternateType(BastionHost.etag, eTag, "csharp");
@@alternateType(BgpConnection.etag, eTag, "csharp");
@@alternateType(DdosCustomPolicy.etag, eTag, "csharp");
@@alternateType(DdosProtectionPlan.etag, eTag, "csharp");
@@alternateType(DscpConfiguration.etag, eTag, "csharp");
@@alternateType(ExpressRouteCircuitAuthorization.etag, eTag, "csharp");
@@alternateType(ExpressRouteCircuitConnection.etag, eTag, "csharp");
@@alternateType(ExpressRouteCircuit.etag, eTag, "csharp");
@@alternateType(ExpressRouteCircuitPeering.etag, eTag, "csharp");
@@alternateType(ExpressRouteCrossConnection.etag, eTag, "csharp");
@@alternateType(ExpressRouteGateway.etag, eTag, "csharp");
@@alternateType(ExpressRoutePortAuthorization.etag, eTag, "csharp");
@@alternateType(ExpressRoutePort.etag, eTag, "csharp");
@@alternateType(ExpressRouteProviderPort.etag, eTag, "csharp");
@@alternateType(FirewallPolicy.etag, eTag, "csharp");
@@alternateType(FirewallPolicyRuleCollectionGroup.etag, eTag, "csharp");
@@alternateType(FlowLog.etag, eTag, "csharp");
@@alternateType(FrontendIPConfiguration.etag, eTag, "csharp");
@@alternateType(HubRouteTable.etag, eTag, "csharp");
@@alternateType(InboundNatRule.etag, eTag, "csharp");
@@alternateType(InboundSecurityRule.etag, eTag, "csharp");
@@alternateType(IpamPool.etag, eTag, "csharp");
@@alternateType(LoadBalancer.etag, eTag, "csharp");
@@alternateType(LoadBalancingRule.etag, eTag, "csharp");
@@alternateType(LocalNetworkGateway.etag, eTag, "csharp");
@@alternateType(NatGateway.etag, eTag, "csharp");
@@alternateType(NetworkInterface.etag, eTag, "csharp");
@@alternateType(NetworkInterfaceIPConfiguration.etag, eTag, "csharp");
@@alternateType(NetworkInterfaceTapConfiguration.etag, eTag, "csharp");
@@alternateType(NetworkManager.etag, eTag, "csharp");
@@alternateType(Common.PrivateEndpointConnection.etag, eTag, "csharp");
@@alternateType(NetworkProfile.etag, eTag, "csharp");
@@alternateType(NetworkSecurityGroup.etag, eTag, "csharp");
@@alternateType(NetworkVirtualAppliance.etag, eTag, "csharp");
@@alternateType(NetworkVirtualApplianceSku.etag, eTag, "csharp");
@@alternateType(NetworkWatcher.etag, eTag, "csharp");
@@alternateType(OutboundRule.etag, eTag, "csharp");
@@alternateType(P2SVpnGateway.etag, eTag, "csharp");
@@alternateType(PeerExpressRouteCircuitConnection.etag, eTag, "csharp");
@@alternateType(Common.PrivateEndpoint.etag, eTag, "csharp");
@@alternateType(PrivateLinkService.etag, eTag, "csharp");
@@alternateType(Probe.etag, eTag, "csharp");
@@alternateType(PublicIPAddress.etag, eTag, "csharp");
@@alternateType(PublicIPPrefix.etag, eTag, "csharp");
@@alternateType(Route.etag, eTag, "csharp");
@@alternateType(RouteFilter.etag, eTag, "csharp");
@@alternateType(RouteMap.etag, eTag, "csharp");
@@alternateType(RouteTable.etag, eTag, "csharp");
@@alternateType(RoutingIntent.etag, eTag, "csharp");
@@alternateType(SecurityPartnerProvider.etag, eTag, "csharp");
@@alternateType(SecurityRule.etag, eTag, "csharp");
@@alternateType(ServiceEndpointPolicy.etag, eTag, "csharp");
@@alternateType(ServiceEndpointPolicyDefinition.etag, eTag, "csharp");
@@alternateType(ServiceGateway.etag, eTag, "csharp");
@@alternateType(Subnet.etag, eTag, "csharp");
@@alternateType(VirtualApplianceSite.etag, eTag, "csharp");
@@alternateType(VirtualHub.etag, eTag, "csharp");
@@alternateType(VirtualNetworkAppliance.etag, eTag, "csharp");
@@alternateType(VirtualNetwork.etag, eTag, "csharp");
@@alternateType(VirtualNetworkGatewayConnection.etag, eTag, "csharp");
@@alternateType(VirtualNetworkGateway.etag, eTag, "csharp");
@@alternateType(VirtualNetworkGatewayNatRule.etag, eTag, "csharp");
@@alternateType(VirtualNetworkPeering.etag, eTag, "csharp");
@@alternateType(VirtualNetworkTap.etag, eTag, "csharp");
@@alternateType(VirtualRouter.etag, eTag, "csharp");
@@alternateType(VirtualRouterPeering.etag, eTag, "csharp");
@@alternateType(VpnGateway.etag, eTag, "csharp");
@@alternateType(VpnGatewayNatRule.etag, eTag, "csharp");
@@alternateType(VpnServerConfiguration.etag, eTag, "csharp");
@@alternateType(VpnServerConfigurationPolicyGroup.etag, eTag, "csharp");
@@alternateType(VpnSite.etag, eTag, "csharp");
@@alternateType(VpnSiteLinkConnection.etag, eTag, "csharp");
@@alternateType(VpnSiteLink.etag, eTag, "csharp");
@@alternateType(WebApplicationFirewallPolicy.etag, eTag, "csharp");
@@alternateType(
  ApplicationGatewayEntraJWTValidationConfig.etag,
  eTag,
  "csharp"
);
@@alternateType(
  ApplicationGatewayPrivateLinkIpConfiguration.etag,
  eTag,
  "csharp"
);
@@alternateType(ContainerNetworkInterfaceIpConfiguration.etag, eTag, "csharp");
@@alternateType(Delegation.etag, eTag, "csharp");
@@alternateType(InboundNatPool.etag, eTag, "csharp");
@@alternateType(PrivateLinkServiceConnection.etag, eTag, "csharp");
@@alternateType(PrivateLinkServiceIpConfiguration.etag, eTag, "csharp");
@@alternateType(VirtualNetworkApplianceIpConfiguration.etag, eTag, "csharp");
@@alternateType(
  FlowLogStatusParameters.targetResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  NetworkConfigurationDiagnosticParameters.targetResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  NextHopParameters.targetResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  QueryTroubleshootingParameters.targetResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SecurityGroupViewParameters.targetResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  TroubleshootingParameters.targetResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  VerificationIPFlowParameters.targetResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  AzureFirewallIPGroups.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  TrackedResourceWithOptionalLocation.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  TrackedResourceWithSettableIdOptionalLocation.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  VpnGatewayIpConfiguration.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(EndpointServiceResult.type, armResourceType, "csharp");
@@alternateType(Common.Resource.type, armResourceType, "csharp");
@@alternateType(
  TrackedResourceWithOptionalLocation.type,
  armResourceType,
  "csharp"
);
@@alternateType(
  TrackedResourceWithSettableIdOptionalLocation.type,
  armResourceType,
  "csharp"
);
@@alternateType(FirewallPacketCaptureParameters.sasUrl, url, "csharp");
@@alternateType(VpnConnectionPacketCaptureStopParameters.sasUrl, url, "csharp");
@@alternateType(VpnGatewayPacketCaptureStopParameters.sasUrl, url, "csharp");
@@alternateType(VpnPacketCaptureStopParameters.sasUrl, url, "csharp");
@@alternateType(GetInboundRoutesParameters.resourceUri, url, "csharp");
@@alternateType(GetOutboundRoutesParameters.resourceUri, url, "csharp");
@@alternateType(
  VirtualNetworkGatewayMigrationParameters.resourceUrl,
  url,
  "csharp"
);
@@alternateType(
  AvailableProvidersListParameters.azureLocations,
  Azure.Core.azureLocation[],
  "csharp"
);
@@alternateType(
  AzureReachabilityReportParameters.azureLocations,
  Azure.Core.azureLocation[],
  "csharp"
);
@@alternateType(ConnectionMonitor.location, Azure.Core.azureLocation, "csharp");
@@alternateType(
  EffectiveRoutesParameters.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Hub.resourceId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(
  GetVpnSitesConfigurationRequest.outputBlobSasUrl,
  url,
  "csharp"
);
@@alternateType(P2SVpnConnectionHealthRequest.outputBlobSasUrl, url, "csharp");
@@alternateType(
  NextHopParameters.targetNicResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  VerificationIPFlowParameters.targetNicResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ActiveConfigurationParameter.regions,
  Azure.Core.azureLocation[],
  "csharp"
);
@@alternateType(
  ConnectionMonitorWorkspaceSettings.workspaceResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ExpressRouteFailoverConnectionResourceDetails.lastUpdatedTime,
  utcDateTime,
  "csharp"
);
@@alternateType(
  ExpressRouteFailoverTestDetails.startTime,
  utcDateTime,
  "csharp"
);
@@alternateType(ExpressRouteFailoverTestDetails.endTime, utcDateTime, "csharp");
@@alternateType(Hub.resourceType, armResourceType, "csharp");
@@alternateType(
  LoadBalancerHealthPerRulePerBackendAddress.networkInterfaceIPConfigurationId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PublicIpDdosProtectionStatusResult.publicIpAddress,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(
  PublicIpDdosProtectionStatusResult.ddosProtectionPlanId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ServiceEndpointPropertiesFormat.locations,
  Azure.Core.azureLocation[],
  "csharp"
);
@@alternateType(
  VirtualWanVpnProfileParameters.vpnServerConfigurationResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  VpnClientConnectionHealthDetail.vpnConnectionTime,
  utcDateTime,
  "csharp"
);

// Move Microsoft.Compute.PublicIPAddresses operations to Microsoft.Network.PublicIPAddresses for Java
@@clientLocation(
  Microsoft.Compute.PublicIPAddresses.getVirtualMachineScaleSetPublicIPAddress,
  Microsoft.Network.PublicIPAddresses,
  "java"
);
@@clientLocation(
  Microsoft.Compute.PublicIPAddresses.listVirtualMachineScaleSetVMPublicIPAddresses,
  Microsoft.Network.PublicIPAddresses,
  "java"
);

// Method renames to maintain backward compatibility for Java
@@clientName(ExpressRoutePorts.generateLOA, "generateLoa", "java");
@@clientName(
  P2SVpnGateways.getP2sVpnConnectionHealth,
  "getP2SVpnConnectionHealth",
  "java"
);
@@clientName(
  P2SVpnGateways.getP2sVpnConnectionHealthDetailed,
  "getP2SVpnConnectionHealthDetailed",
  "java"
);
@@clientName(
  P2SVpnGateways.disconnectP2sVpnConnections,
  "disconnectP2SVpnConnections",
  "java"
);

// PublicIPAddress → PublicIpAddress method renames for Java
@@clientName(
  Microsoft.Network.PublicIPAddresses.getCloudServicePublicIPAddress,
  "getCloudServicePublicIpAddress",
  "java"
);
@@clientName(
  Microsoft.Network.PublicIPAddresses.listCloudServiceRoleInstancePublicIPAddresses,
  "listCloudServiceRoleInstancePublicIpAddresses",
  "java"
);
@@clientName(
  Microsoft.Network.PublicIPAddressesOperationGroup.listCloudServicePublicIPAddresses,
  "listCloudServicePublicIpAddresses",
  "java"
);
@@clientName(
  Microsoft.Compute.PublicIPAddresses.getVirtualMachineScaleSetPublicIPAddress,
  "getVirtualMachineScaleSetPublicIpAddress",
  "java"
);
@@clientName(
  Microsoft.Compute.PublicIPAddresses.listVirtualMachineScaleSetVMPublicIPAddresses,
  "listVirtualMachineScaleSetVMPublicIpAddresses",
  "java"
);
@@clientName(
  Microsoft.Compute.PublicIPAddressesOperationGroup.listVirtualMachineScaleSetPublicIPAddresses,
  "listVirtualMachineScaleSetPublicIpAddresses",
  "java"
);

// Sub-client name fixes (override back-compatible.tsp for Java)
@@clientLocation(
  FrontendIPConfigurations.get,
  "LoadBalancerFrontendIpConfigurations",
  "java"
);
@@clientLocation(
  FrontendIPConfigurations.list,
  "LoadBalancerFrontendIpConfigurations",
  "java"
);
@@clientLocation(
  VirtualHubs.virtualHubRouteTableV2sGet,
  "VirtualHubRouteTableV2S",
  "java"
);
@@clientLocation(
  VirtualHubs.virtualHubRouteTableV2sCreateOrUpdate,
  "VirtualHubRouteTableV2S",
  "java"
);
@@clientLocation(
  VirtualHubs.virtualHubRouteTableV2sDelete,
  "VirtualHubRouteTableV2S",
  "java"
);
@@clientLocation(
  VirtualHubs.virtualHubRouteTableV2sList,
  "VirtualHubRouteTableV2S",
  "java"
);
@@clientName(CommonTypes.ProxyResource, "ProxyResourceAutoGenerated", "java");
@@clientName(CommonTypes.Resource, "ResourceAutoGenerated", "java");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  ChildResource,
  Microsoft.Network.ProxyResource,
  "java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  CommonResource,
  CommonTypes.ProxyResource,
  "java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  SecurityPerimeterResource,
  CommonTypes.ProxyResource,
  "java"
);
