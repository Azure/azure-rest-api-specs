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
@client({
  name: "CombineClient",
  service: [Microsoft.Network, Microsoft.Compute],
  autoMergeService: true,
})
namespace CombineClient;

@@clientLocation(Microsoft.Compute.NetworkInterfaceIPConfigurations.getVirtualMachineScaleSetIpConfiguration,
  Microsoft.Network.NetworkInterfaces
);

@@clientLocation(Microsoft.Compute.NetworkInterfaceIPConfigurations.listVirtualMachineScaleSetIpConfigurations,
  Microsoft.Network.NetworkInterfaces
);

@@clientLocation(Microsoft.Compute.NetworkInterfacesOperationGroup.listVirtualMachineScaleSetNetworkInterfaces,
  Microsoft.Network.NetworkInterfaces
);

@@clientLocation(Microsoft.Compute.PublicIPAddressesOperationGroup.listVirtualMachineScaleSetPublicIPAddresses,
  Microsoft.Network.PublicIPAddresses
);

@@clientName(CombineClient, "NetworkManagementClient", "javascript,python");
@@clientName(Azure.ResourceManager.CommonTypes.ErrorResponse,
  "ArmErrorResponse",
  "javascript,python"
);

// Java naming mitigations
@@clientName(Microsoft.Network.ApplicationGatewayBackendHttpSettingsPropertiesFormat.hostName,
  "hostname",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayBackendSettingsPropertiesFormat.hostName,
  "hostname",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayHttpListenerPropertiesFormat.hostName,
  "hostname",
  "java"
);
@@clientName(Microsoft.Network.BastionActiveSession.userName,
  "username",
  "java"
);
@@clientName(Microsoft.Network.AzureReachabilityReportLatencyInfo.timeStamp,
  "timestamp",
  "java"
);
@@clientName(Microsoft.Network.QosIpRange.startIP, "startIp", "java");
@@clientName(Microsoft.Network.QosIpRange.endIP, "endIp", "java");
// Mitigate ProvisioningState split: create unified union with all values
@@clientName(Microsoft.Network.ProvisioningState,
  "CommonProvisioningState",
  "java"
);

// Fix definition error on required property. Only "matchVariable" property is required.
@@alternateType(ApplicationGatewayFirewallExclusion,
  ApplicationGatewayFirewallExclusionRequireMatchVariable,
  "java"
);
@@clientName(ApplicationGatewayFirewallExclusion,
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

@@alternateType(Microsoft.Network.AdminPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.AdminRuleCollectionPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayAuthenticationCertificatePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayBackendAddressPoolPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayBackendHttpSettingsPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayBackendSettingsPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayEntraJWTValidationConfigPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayFirewallRuleSetPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayFrontendPortPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayHttpListenerPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayIPConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayListenerPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayLoadDistributionPolicyPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayPathRulePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayPrivateEndpointConnectionProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayPrivateLinkConfigurationProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayPrivateLinkIpConfigurationProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayProbePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayRequestRoutingRulePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayRewriteRuleSetPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayRoutingRulePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewaySslCertificatePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewaySslProfilePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayTrustedClientCertificatePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayTrustedRootCertificatePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationGatewayUrlPathMapPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ApplicationSecurityGroupPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.AuthorizationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.AzureFirewallApplicationRuleCollectionPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.AzureFirewallFqdnTagPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.AzureFirewallIPConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.AzureFirewallNatRuleCollectionProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.AzureFirewallNetworkRuleCollectionPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.AzureFirewallPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.BackendAddressPoolPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.BastionHostIPConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.BastionHostPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.BgpConnectionProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ConnectionMonitorResultProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ConnectivityConfigurationProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ContainerNetworkInterfaceConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ContainerNetworkInterfaceIpConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ContainerNetworkInterfacePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.CustomIpPrefixPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.DdosCustomPolicyPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.DdosDetectionRulePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.DdosProtectionPlanPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.DefaultAdminPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.DelegationProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.DscpConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ExpressRouteCircuitConnectionPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ExpressRouteCircuitPeeringPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ExpressRouteCircuitPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ExpressRouteConnectionProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ExpressRouteCrossConnectionPeeringProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ExpressRouteCrossConnectionProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ExpressRouteGatewayProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ExpressRouteLinkPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ExpressRoutePortAuthorizationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ExpressRoutePortPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ExpressRoutePortsLocationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ExpressRouteServiceProviderPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.FirewallPolicyPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.FirewallPolicyRuleCollectionGroupProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.FlowLogPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.FrontendIPConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.HubIPConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.HubRouteTableProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.HubVirtualNetworkConnectionProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.InboundNatPoolPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.InboundNatRulePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.InboundSecurityRuleProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.IpamPoolProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.IPConfigurationProfilePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.IPConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.IpGroupPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.LoadBalancerPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.LoadBalancingRulePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.LocalNetworkGatewayPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.NatGatewayPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.NetworkGroupProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.NetworkInterfaceIPConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.NetworkInterfacePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.NetworkInterfaceTapConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.NetworkManagerProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.NetworkManagerRoutingConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.NetworkProfilePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.NetworkSecurityGroupPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.NetworkVirtualApplianceConnectionProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.NetworkVirtualAppliancePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.NetworkWatcherPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.OutboundRulePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.P2SConnectionConfigurationProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.P2SVpnGatewayProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.PacketCaptureResultProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.PeerExpressRouteCircuitConnectionPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.PrivateDnsZoneGroupPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.PrivateEndpointConnectionProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.PrivateEndpointProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.PrivateLinkServiceConnectionProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.PrivateLinkServiceIpConfigurationProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.PrivateLinkServiceProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ProbePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.PublicIPAddressPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.PublicIPPrefixPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ReachabilityAnalysisIntentProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ReachabilityAnalysisRunProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.RecordSet.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ResourceNavigationLinkFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.RouteFilterPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.RouteFilterRulePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.RouteMapProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.RoutePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.RouteTablePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.RoutingIntentProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.RoutingRuleCollectionPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.RoutingRulePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.SecurityAdminConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.SecurityPartnerProviderPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.SecurityRulePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.SecurityUserConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.SecurityUserRuleCollectionPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.SecurityUserRulePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ServiceAssociationLinkPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ServiceDelegationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ServiceEndpointPolicyDefinitionPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ServiceEndpointPolicyPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ServiceEndpointPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.ServiceGatewayPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.SharedKeyProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.StaticCidrProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.StaticMemberProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.SubnetPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VerifierWorkspaceProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VirtualApplianceSiteProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VirtualHubProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VirtualHubRouteTableV2Properties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VirtualNetworkApplianceIpConfigurationProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VirtualNetworkAppliancePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VirtualNetworkGatewayConnectionPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VirtualNetworkGatewayIPConfigurationPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VirtualNetworkGatewayNatRuleProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VirtualNetworkGatewayPolicyGroupProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VirtualNetworkGatewayPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VirtualNetworkPeeringPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VirtualNetworkPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VirtualNetworkTapPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VirtualRouterPeeringProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VirtualRouterPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VirtualWanProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VngClientConnectionConfigurationProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VpnClientRevokedCertificatePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VpnClientRootCertificatePropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VpnConnectionProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VpnGatewayNatRuleProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VpnGatewayProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VpnServerConfigurationPolicyGroupProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VpnSiteLinkConnectionProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VpnSiteLinkProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.VpnSiteProperties.provisioningState,
  ProvisioningStateUnion,
  "java"
);
@@alternateType(Microsoft.Network.WebApplicationFirewallPolicyPropertiesFormat.provisioningState,
  ProvisioningStateUnion,
  "java"
);

@@clientName(Microsoft.Network.ErrorResponse, "NetworkErrorResponse", "java");

// IP → Ip naming mitigations for backward compatibility with hand-written wrapper code
@@clientName(Microsoft.Network.PublicIPAddress, "PublicIpAddress", "java");
@@clientName(Microsoft.Network.PublicIPPrefix, "PublicIpPrefix", "java");
@@clientName(Microsoft.Network.FrontendIPConfiguration,
  "FrontendIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.IPConfiguration, "IpConfiguration", "java");
@@clientName(Microsoft.Network.IPConfigurationProfile,
  "IpConfigurationProfile",
  "java"
);
@@clientName(Microsoft.Network.NetworkInterfaceIPConfiguration,
  "NetworkInterfaceIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.IPAddressAvailabilityResult,
  "IpAddressAvailabilityResult",
  "java"
);
@@clientName(Microsoft.Network.VerificationIPFlowResult,
  "VerificationIpFlowResult",
  "java"
);
@@clientName(Microsoft.Network.VerificationIPFlowParameters,
  "VerificationIpFlowParameters",
  "java"
);
@@clientName(Microsoft.Network.VirtualNetworkGatewayIPConfiguration,
  "VirtualNetworkGatewayIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayIPConfiguration,
  "ApplicationGatewayIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayFrontendIPConfiguration,
  "ApplicationGatewayFrontendIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.IPAllocationMethod,
  "IpAllocationMethod",
  "java"
);
@@clientName(Microsoft.Network.IPVersion, "IpVersion", "java");
@@clientName(Microsoft.Network.PublicIPAddressSku,
  "PublicIpAddressSku",
  "java"
);
@@clientName(Microsoft.Network.PublicIPAddressSkuName,
  "PublicIpAddressSkuName",
  "java"
);
@@clientName(Microsoft.Network.PublicIPPrefixSku, "PublicIpPrefixSku", "java");
@@clientName(Microsoft.Network.PublicIPAddressDnsSettings,
  "PublicIpAddressDnsSettings",
  "java"
);

// Interface/client IP → Ip renames
@@clientName(Microsoft.Network.PublicIPAddresses, "PublicIpAddresses", "java");
@@clientName(Microsoft.Network.PublicIPPrefixes, "PublicIpPrefixes", "java");
@@clientName(Microsoft.Network.PublicIPAddressOperationGroup,
  "PublicIpAddressOperationGroup",
  "java"
);

// Property-level IP → Ip renames on PropertiesFormat models (Common)
@@clientName(Microsoft.Network.IPConfigurationPropertiesFormat.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(Microsoft.Network.IPConfigurationPropertiesFormat.publicIPAddress,
  "publicIpAddress",
  "java"
);
@@clientName(Microsoft.Network.NetworkInterfaceIPConfigurationPropertiesFormat.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(Microsoft.Network.NetworkInterfaceIPConfigurationPropertiesFormat.publicIPAddress,
  "publicIpAddress",
  "java"
);
@@clientName(Microsoft.Network.FrontendIPConfigurationPropertiesFormat.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(Microsoft.Network.FrontendIPConfigurationPropertiesFormat.publicIPAddress,
  "publicIpAddress",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayBackendAddressPoolPropertiesFormat.backendIPConfigurations,
  "backendIpConfigurations",
  "java"
);
@@clientName(Microsoft.Network.BackendAddressPoolPropertiesFormat.backendIPConfigurations,
  "backendIpConfigurations",
  "java"
);
@@clientName(Microsoft.Network.InboundNatRulePropertiesFormat.frontendIPConfiguration,
  "frontendIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.InboundNatPoolPropertiesFormat.frontendIPConfiguration,
  "frontendIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.LoadBalancingRulePropertiesFormat.frontendIPConfiguration,
  "frontendIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.OutboundRulePropertiesFormat.frontendIPConfigurations,
  "frontendIpConfigurations",
  "java"
);
@@clientName(Microsoft.Network.LoadBalancerPropertiesFormat.frontendIPConfigurations,
  "frontendIpConfigurations",
  "java"
);
@@clientName(Microsoft.Network.PrivateEndpointIPConfigurationProperties.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(Microsoft.Network.PrivateLinkServiceIpConfigurationProperties.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(Microsoft.Network.PrivateLinkServiceProperties.destinationIPAddress,
  "destinationIpAddress",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayIPConfigurationPropertiesFormat.subnet,
  "subnet",
  "java"
);

// Property-level IP → Ip renames on models (Network)
@@clientName(Microsoft.Network.ApplicationGatewayPropertiesFormat.gatewayIPConfigurations,
  "gatewayIpConfigurations",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayPropertiesFormat.frontendIPConfigurations,
  "frontendIpConfigurations",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.publicIPAddress,
  "publicIpAddress",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayHttpListenerPropertiesFormat.frontendIPConfiguration,
  "frontendIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayListenerPropertiesFormat.frontendIPConfiguration,
  "frontendIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.AzureFirewallIPConfigurationPropertiesFormat.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(Microsoft.Network.AzureFirewallIPConfigurationPropertiesFormat.publicIPAddress,
  "publicIpAddress",
  "java"
);
@@clientName(Microsoft.Network.BastionHostIPConfigurationPropertiesFormat.publicIPAddress,
  "publicIpAddress",
  "java"
);
@@clientName(Microsoft.Network.HubIPAddresses.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(Microsoft.Network.HubIPConfigurationPropertiesFormat.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(Microsoft.Network.HubIPConfigurationPropertiesFormat.publicIPAddress,
  "publicIpAddress",
  "java"
);
@@clientName(Microsoft.Network.VirtualNetworkGatewayIPConfigurationPropertiesFormat.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(Microsoft.Network.VirtualNetworkGatewayIPConfigurationPropertiesFormat.publicIPAddress,
  "publicIpAddress",
  "java"
);
@@clientName(Microsoft.Network.PacketCaptureFilter.localIPAddress,
  "localIpAddress",
  "java"
);
@@clientName(Microsoft.Network.PacketCaptureFilter.remoteIPAddress,
  "remoteIpAddress",
  "java"
);
@@clientName(Microsoft.Network.VerificationIPFlowParameters.localIPAddress,
  "localIpAddress",
  "java"
);
@@clientName(Microsoft.Network.VerificationIPFlowParameters.remoteIPAddress,
  "remoteIpAddress",
  "java"
);
@@clientName(Microsoft.Network.NextHopParameters.destinationIPAddress,
  "destinationIpAddress",
  "java"
);
@@clientName(Microsoft.Network.NextHopParameters.sourceIPAddress,
  "sourceIpAddress",
  "java"
);
@@clientName(Microsoft.Network.LoadBalancerVipSwapRequest.frontendIPConfigurations,
  "frontendIpConfigurations",
  "java"
);
@@clientName(Microsoft.Network.LoadBalancerVipSwapRequestFrontendIPConfigurationProperties.publicIPAddress,
  "publicIpAddress",
  "java"
);
@@clientName(Microsoft.Network.PublicIPAddressPropertiesFormat.servicePublicIPAddress,
  "servicePublicIpAddress",
  "java"
);
@@clientName(Microsoft.Network.PublicIPAddressPropertiesFormat.linkedPublicIPAddress,
  "linkedPublicIpAddress",
  "java"
);

// pickHostName → pickHostname renames
@@clientName(Microsoft.Network.ApplicationGatewayProbePropertiesFormat.pickHostNameFromBackendHttpSettings,
  "pickHostnameFromBackendHttpSettings",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayProbePropertiesFormat.pickHostNameFromBackendSettings,
  "pickHostnameFromBackendSettings",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayBackendHttpSettingsPropertiesFormat.pickHostNameFromBackendAddress,
  "pickHostnameFromBackendAddress",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayBackendSettingsPropertiesFormat.pickHostNameFromBackendAddress,
  "pickHostnameFromBackendAddress",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayOnDemandProbe.pickHostNameFromBackendHttpSettings,
  "pickHostnameFromBackendHttpSettings",
  "java"
);

// ASN → Asn renames
@@clientName(Microsoft.Network.ExpressRouteCircuitPeeringPropertiesFormat.azureASN,
  "azureAsn",
  "java"
);
@@clientName(Microsoft.Network.ExpressRouteCircuitPeeringPropertiesFormat.peerASN,
  "peerAsn",
  "java"
);
@@clientName(Microsoft.Network.ExpressRouteCircuitPeeringConfig.customerASN,
  "customerAsn",
  "java"
);
@@clientName(Microsoft.Network.ExpressRouteCrossConnectionPeeringProperties.azureASN,
  "azureAsn",
  "java"
);
@@clientName(Microsoft.Network.ExpressRouteCrossConnectionPeeringProperties.peerASN,
  "peerAsn",
  "java"
);

// sTag → stag rename
@@clientName(Microsoft.Network.ExpressRouteCrossConnectionProperties.sTag,
  "stag",
  "java"
);

// Make read-only ExpressRoute models input for backward compat
@@usage(Microsoft.Network.ExpressRouteCrossConnectionPeeringProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "java"
);

// Make read-only models input for backward compat with hand-written wrapper code
@@usage(Microsoft.Network.PacketCaptureResult,
  Azure.ClientGenerator.Core.Usage.input,
  "java"
);
@@usage(Microsoft.Network.ConnectionMonitorResult,
  Azure.ClientGenerator.Core.Usage.input,
  "java"
);

// More property-level IP → Ip renames
@@clientName(Microsoft.Network.NetworkInterfacePropertiesFormat.enableIPForwarding,
  "enableIpForwarding",
  "java"
);
@@clientName(Microsoft.Network.InboundNatRulePropertiesFormat.enableFloatingIP,
  "enableFloatingIp",
  "java"
);
@@clientName(Microsoft.Network.InboundNatRulePropertiesFormat.backendIPConfiguration,
  "backendIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.LoadBalancingRulePropertiesFormat.enableFloatingIP,
  "enableFloatingIp",
  "java"
);
@@clientName(Microsoft.Network.InboundNatPoolPropertiesFormat.enableFloatingIP,
  "enableFloatingIp",
  "java"
);
@@clientName(Microsoft.Network.IPConfigurationPropertiesFormat.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
@@clientName(Microsoft.Network.PublicIPAddressPropertiesFormat.publicIPAllocationMethod,
  "publicIpAllocationMethod",
  "java"
);
@@clientName(Microsoft.Network.PublicIPAddressPropertiesFormat.publicIPAddressVersion,
  "publicIpAddressVersion",
  "java"
);
@@clientName(Microsoft.Network.NetworkInterfaceIPConfigurationPropertiesFormat.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
@@clientName(Microsoft.Network.NetworkInterfaceIPConfigurationPropertiesFormat.privateIPAddressVersion,
  "privateIpAddressVersion",
  "java"
);
@@clientName(Microsoft.Network.FrontendIPConfigurationPropertiesFormat.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
@@clientName(Microsoft.Network.FrontendIPConfigurationPropertiesFormat.privateIPAddressVersion,
  "privateIpAddressVersion",
  "java"
);
@@clientName(Microsoft.Network.PrivateLinkServiceIpConfigurationProperties.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
@@clientName(Microsoft.Network.PrivateLinkServiceIpConfigurationProperties.privateIPAddressVersion,
  "privateIpAddressVersion",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayPrivateLinkIpConfigurationProperties.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
@@clientName(Microsoft.Network.BastionHostIPConfigurationPropertiesFormat.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
@@clientName(Microsoft.Network.HubIPConfigurationPropertiesFormat.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
@@clientName(Microsoft.Network.VirtualNetworkGatewayIPConfigurationPropertiesFormat.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
@@clientName(Microsoft.Network.RouteTargetAddressPropertiesFormat.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
@@clientName(Microsoft.Network.VirtualNetworkApplianceIpConfigurationProperties.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
@@clientName(Microsoft.Network.VirtualNetworkApplianceIpConfigurationProperties.privateIPAddressVersion,
  "privateIpAddressVersion",
  "java"
);
@@clientName(Microsoft.Network.PublicIPPrefixPropertiesFormat.publicIPAddressVersion,
  "publicIpAddressVersion",
  "java"
);
@@clientName(Microsoft.Network.IPAddressAvailabilityResult.availableIPAddresses,
  "availableIpAddresses",
  "java"
);
@@clientName(Microsoft.Network.DdosProtectionPlanPropertiesFormat.publicIPAddresses,
  "publicIpAddresses",
  "java"
);
@@clientName(Microsoft.Network.PublicIPPrefixPropertiesFormat.publicIPAddresses,
  "publicIpAddresses",
  "java"
);

// activeActive → active rename
@@clientName(Microsoft.Network.VirtualNetworkGatewayPropertiesFormat.activeActive,
  "active",
  "java,javascript,go"
);

// Operation renames IP → Ip
@@clientName(Microsoft.Network.NetworkWatchers.verifyIPFlow,
  "verifyIpFlow",
  "java"
);
@@clientName(Microsoft.Network.VirtualNetworks.checkIPAddressAvailability,
  "checkIpAddressAvailability",
  "java"
);

// HTTP → Http casing overrides for Java checkstyle compliance
@@clientName(Microsoft.Network.HttpConfiguration, "HttpConfiguration", "java");
@@clientName(Microsoft.Network.HttpConfigurationMethod,
  "HttpConfigurationMethod",
  "java"
);
@@clientName(Microsoft.Network.HttpHeader, "HttpHeader", "java");
@@clientName(Microsoft.Network.HttpMethod, "HttpMethod", "java");
@@clientName(Microsoft.Network.ConnectionMonitorHttpConfiguration.preferHTTPS,
  "preferHttps",
  "java"
);
@@clientName(Microsoft.Network.ProtocolConfiguration.HTTPConfiguration,
  "httpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.BastionHostIPConfiguration,
  "BastionHostIpConfiguration",
  "java"
);

// Operation renames for Java (from readme.java.md)
@@clientLocation(Microsoft.Network.BgpConnections.get,
  "VirtualHubBgpConnections",
  "java"
);
@@clientLocation(Microsoft.Network.BgpConnections.createOrUpdate,
  "VirtualHubBgpConnections",
  "java"
);
@@clientLocation(Microsoft.Network.BgpConnections.delete,
  "VirtualHubBgpConnections",
  "java"
);
@@clientLocation(Microsoft.Network.InboundSecurityRuleOperationGroup.get,
  "InboundSecurityRuleOperation",
  "java"
);
@@clientLocation(Microsoft.Network.InboundSecurityRuleOperationGroup.createOrUpdate,
  "InboundSecurityRuleOperation",
  "java"
);

// Move operations back to top-level NetworkManagementClient for Java
@@clientLocation(BastionHosts.putBastionShareableLink, CombineClient, "java");
@@clientLocation(BastionHosts.deleteBastionShareableLink,
  CombineClient,
  "java"
);
@@clientLocation(BastionHosts.deleteBastionShareableLinkByToken,
  CombineClient,
  "java"
);
@@clientLocation(BastionHosts.getBastionShareableLink, CombineClient, "java");
@@clientLocation(BastionHosts.getActiveSessions, CombineClient, "java");
@@clientLocation(BastionHosts.disconnectActiveSessions, CombineClient, "java");
@@clientLocation(CheckDnsNameAvailability.checkDnsNameAvailability,
  CombineClient,
  "java"
);
@@clientLocation(ExpressRouteProviderPorts.expressRouteProviderPort,
  CombineClient,
  "java"
);
@@clientLocation(NetworkManagers.listActiveConnectivityConfigurations,
  CombineClient,
  "java"
);
@@clientLocation(NetworkManagers.listActiveSecurityAdminRules,
  CombineClient,
  "java"
);
@@clientLocation(EffectiveConfigurations.listNetworkManagerEffectiveConnectivityConfigurations,
  CombineClient,
  "java"
);
@@clientLocation(EffectiveConfigurations.listNetworkManagerEffectiveSecurityAdminRules,
  CombineClient,
  "java"
);
@@clientLocation(VirtualWans.supportedSecurityProviders, CombineClient, "java");
@@clientLocation(VirtualWans.generatevirtualwanvpnserverconfigurationvpnprofile,
  CombineClient,
  "java"
);

// Move VMSS listVirtualMachineScaleSetNetworkInterfaces to NetworkInterfaces client for Java
@@clientLocation(Microsoft.Compute.NetworkInterfacesOperationGroup.listVirtualMachineScaleSetNetworkInterfaces,
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

@@clientLocation(BastionHosts.deleteBastionShareableLink,
  "ManagementClient",
  "go"
);
@@clientLocation(BastionHosts.deleteBastionShareableLinkByToken,
  "ManagementClient",
  "go"
);
@@clientLocation(BastionHosts.disconnectActiveSessions,
  "ManagementClient",
  "go"
);

@@clientLocation(ExpressRouteProviderPorts.expressRouteProviderPort,
  "ManagementClient",
  "go"
);
@@clientLocation(VirtualWans.generatevirtualwanvpnserverconfigurationvpnprofile,
  "ManagementClient",
  "go"
);
@@clientLocation(BastionHosts.getActiveSessions, "ManagementClient", "go");
@@clientLocation(BastionHosts.getBastionShareableLink,
  "ManagementClient",
  "go"
);
@@clientLocation(NetworkManagers.listActiveConnectivityConfigurations,
  "ManagementClient",
  "go"
);

@@clientLocation(NetworkManagers.listActiveSecurityAdminRules,
  "ManagementClient",
  "go"
);

@@clientLocation(EffectiveConfigurations.listNetworkManagerEffectiveConnectivityConfigurations,
  "ManagementClient",
  "go"
);
@@clientLocation(EffectiveConfigurations.listNetworkManagerEffectiveSecurityAdminRules,
  "ManagementClient",
  "go"
);
@@clientLocation(BastionHosts.putBastionShareableLink,
  "ManagementClient",
  "go"
);

@@clientLocation(BastionHosts.putBastionShareableLink,
  "ManagementClient",
  "go"
);
@@clientLocation(CheckDnsNameAvailability.checkDnsNameAvailability,
  "ManagementClient",
  "go"
);
@@clientLocation(VirtualWans.supportedSecurityProviders,
  "ManagementClient",
  "go"
);
@@clientName(AzureFirewallSkuName.AZFW_VNet, "AzfwVnet", "javascript");
@@clientName(VM, "Vm", "javascript");
@@clientName(AzureFirewallSkuName.AZFW_VNet, "AZFWVnet", "go");
@@clientName(FirewallPolicyPropertiesFormat.explicitProxy,
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

@@override(AvailablePrivateEndpointTypesOperationGroup.listByResourceGroup,
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

@@override(AvailablePrivateEndpointTypesOperationGroup.list,
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
): ArmResponse<AvailablePrivateEndpointTypesResult> | ArmAcceptedLroResponse<
  "Accepted and the operation will complete asynchronously.",
  ArmLroLocationHeader<FinalResult = PrivateLinkServiceVisibility>
> | CloudError;

@@override(PrivateLinkServicesOperationGroup.checkPrivateLinkServiceVisibilityByResourceGroup,
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

@@override(PrivateLinkServicesOperationGroup.listAutoApprovedPrivateLinkServicesByResourceGroup,
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
): Microsoft.Network.AvailableDelegationsResult | Microsoft.Network.CloudError;

@@override(AvailableResourceGroupDelegationsOperationGroup.list,
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
): Azure.ResourceManager.ArmResponse<Microsoft.Network.PrivateDnsZoneGroupListResult> | Microsoft.Network.CloudError;

@@override(Microsoft.Network.PrivateEndpoints.privateDnsZoneGroupsList,
  replaceprivateDnsZoneGroupsList,
  "go,python,java"
);

// Java: restore Ip casing for model names (TypeSpec uses uppercase IP)
@@clientName(Microsoft.Network.HubIPAddresses, "HubIpAddresses", "java");
@@clientName(Microsoft.Network.HubPublicIPAddresses,
  "HubPublicIpAddresses",
  "java"
);
@@clientName(Microsoft.Network.IPConfigurationBgpPeeringAddress,
  "IpConfigurationBgpPeeringAddress",
  "java"
);
@@clientName(Microsoft.Network.IPRule, "IpRule", "java");
@@clientName(Microsoft.Network.IPTraffic, "IpTraffic", "java");
@@clientName(Microsoft.Network.AzureFirewallPublicIPAddress,
  "AzureFirewallPublicIpAddress",
  "java"
);
@@clientName(Microsoft.Network.AzureFirewallIPConfiguration,
  "AzureFirewallIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.PrivateEndpointIPConfiguration,
  "PrivateEndpointIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.PrivateEndpointIPVersionType,
  "PrivateEndpointIpVersionType",
  "java"
);
@@clientName(Microsoft.Network.LoadBalancerVipSwapRequestFrontendIPConfiguration,
  "LoadBalancerVipSwapRequestFrontendIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.NetworkInterfaceIPConfigurationPrivateLinkConnectionProperties,
  "NetworkInterfaceIpConfigurationPrivateLinkConnectionProperties",
  "java"
);
@@clientName(Microsoft.Network.VirtualApplianceIPConfiguration,
  "VirtualApplianceIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.VirtualApplianceIPConfigurationProperties,
  "VirtualApplianceIpConfigurationProperties",
  "java"
);
@@clientName(Microsoft.Network.PreferredIPVersion,
  "PreferredIpVersion",
  "java"
);
@@clientName(Microsoft.Network.PublicIPAddressMigrationPhase,
  "PublicIpAddressMigrationPhase",
  "java"
);
@@clientName(Microsoft.Network.PublicIPAddressSkuTier,
  "PublicIpAddressSkuTier",
  "java"
);
@@clientName(Microsoft.Network.PublicIPPrefixSkuName,
  "PublicIpPrefixSkuName",
  "java"
);
@@clientName(Microsoft.Network.PublicIPPrefixSkuTier,
  "PublicIpPrefixSkuTier",
  "java"
);

// Java: restore casing for BGP, JWT, IDPS, SNAT, SQL, LOA model names
@@clientName(Microsoft.Network.BGPCommunity, "BgpCommunity", "java");
@@clientName(Microsoft.Network.ApplicationGatewayEntraJWTValidationConfig,
  "ApplicationGatewayEntraJwtValidationConfig",
  "java"
);
@@clientName(FirewallPolicyIdpsQuerySortOrder,
  "FirewallPolicyIdpsQuerySortOrder",
  "java"
);
@@clientName(FirewallPolicyIdpsSignatureDirection,
  "FirewallPolicyIdpsSignatureDirection",
  "java"
);
@@clientName(FirewallPolicyIdpsSignatureMode,
  "FirewallPolicyIdpsSignatureMode",
  "java"
);
@@clientName(FirewallPolicyIdpsSignatureSeverity,
  "FirewallPolicyIdpsSignatureSeverity",
  "java"
);
@@clientName(Microsoft.Network.IdpsQueryObject, "IdpsQueryObject", "java");
@@clientName(Microsoft.Network.FirewallPolicySnat,
  "FirewallPolicySnat",
  "java"
);
@@clientName(Microsoft.Network.FirewallPolicySQL, "FirewallPolicySql", "java");
@@clientName(Microsoft.Network.GenerateExpressRoutePortsLOARequest,
  "GenerateExpressRoutePortsLoaRequest",
  "java"
);

// Java: restore property name casing
@@clientName(Microsoft.Network.StaticCidrProperties.numberOfIPAddressesToAllocate,
  "numberOfIpAddressesToAllocate",
  "java"
);
@@clientName(Microsoft.Network.StaticCidrProperties.totalNumberOfIPAddresses,
  "totalNumberOfIpAddresses",
  "java"
);
@@clientName(Microsoft.Network.VpnClientConnectionHealthDetail.vpnUserName,
  "vpnUsername",
  "java"
);
@@clientName(Microsoft.Network.ApplicationRule.terminateTLS,
  "terminateTls",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayBackendHttpSettingsPropertiesFormat.validateSNI,
  "validateSni",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayPrivateLinkIpConfigurationProperties.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(Microsoft.Network.ConnectionMonitorTestConfiguration.preferredIPVersion,
  "preferredIpVersion",
  "java"
);
@@clientName(Microsoft.Network.ConnectivityParameters.preferredIPVersion,
  "preferredIpVersion",
  "java"
);
@@clientName(Microsoft.Network.LoadBalancerBackendAddressPropertiesFormat.loadBalancerFrontendIPConfiguration,
  "loadBalancerFrontendIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.LoadBalancerBackendAddressPropertiesFormat.networkInterfaceIPConfiguration,
  "networkInterfaceIpConfiguration",
  "java"
);
@@clientName(Microsoft.Network.LoadBalancerHealthPerRulePerBackendAddress.networkInterfaceIPConfigurationId,
  "networkInterfaceIpConfigurationId",
  "java"
);
@@clientName(Microsoft.Network.VirtualNetworkApplianceIpConfigurationProperties.privateIPAddress,
  "privateIpAddress",
  "java"
);
// Fluent model renames (IP→Ip, JWT→Jwt, LOA→Loa)
@@clientName(Microsoft.Network.ApplicationGatewayIPConfigurationPropertiesFormat,
  "ApplicationGatewayIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayFrontendIPConfigurationPropertiesFormat,
  "ApplicationGatewayFrontendIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.AzureFirewallIPConfigurationPropertiesFormat,
  "AzureFirewallIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.BastionHostIPConfigurationPropertiesFormat,
  "BastionHostIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.FrontendIPConfigurationPropertiesFormat,
  "FrontendIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.HubIPConfigurationPropertiesFormat,
  "HubIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.IPConfigurationProfilePropertiesFormat,
  "IpConfigurationProfilePropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.IPConfigurationPropertiesFormat,
  "IpConfigurationPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.IPPrefixesList, "IpPrefixesList", "java");
@@clientName(Microsoft.Network.LoadBalancerVipSwapRequestFrontendIPConfigurationProperties,
  "LoadBalancerVipSwapRequestFrontendIpConfigurationProperties",
  "java"
);
@@clientName(Microsoft.Network.NetworkInterfaceIPConfigurationPropertiesFormat,
  "NetworkInterfaceIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.PrivateEndpointIPConfigurationProperties,
  "PrivateEndpointIpConfigurationProperties",
  "java"
);
@@clientName(Microsoft.Network.PublicIPAddressPropertiesFormat,
  "PublicIpAddressPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.PublicIPPrefixPropertiesFormat,
  "PublicIpPrefixPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.VirtualNetworkGatewayIPConfigurationPropertiesFormat,
  "VirtualNetworkGatewayIpConfigurationPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.ApplicationGatewayEntraJWTValidationConfigPropertiesFormat,
  "ApplicationGatewayEntraJwtValidationConfigPropertiesFormat",
  "java"
);
@@clientName(Microsoft.Network.GenerateExpressRoutePortsLOAResult,
  "GenerateExpressRoutePortsLoaResult",
  "java"
);
@@clientName(Microsoft.Network.VirtualWAN, "VirtualWan", "java");
// Interface/operation group renames
@@clientName(Microsoft.Network.FrontendIPConfigurations,
  "FrontendIpConfigurations",
  "java"
);
@@clientName(Microsoft.Network.NetworkInterfaceIPConfigurations,
  "NetworkInterfaceIpConfigurations",
  "java"
);
// etag header
@@clientName(NetworkGroupCreateOrUpdateEtagHeader.eTag, "etag", "java");

// python
@@clientName(ApplicationGatewaySslCipherSuite.TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384,
  "TLS_ECDHE_RSA_WITH_AES256_CBC_SHA384",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA,
  "TLS_DHE_DSS_WITH3_DES_EDE_CBC_SHA",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_DHE_DSS_WITH_AES_128_CBC_SHA,
  "TLS_DHE_DSS_WITH_AES128_CBC_SHA",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_DHE_DSS_WITH_AES_128_CBC_SHA256,
  "TLS_DHE_DSS_WITH_AES128_CBC_SHA256",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_DHE_DSS_WITH_AES_256_CBC_SHA,
  "TLS_DHE_DSS_WITH_AES256_CBC_SHA",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_DHE_DSS_WITH_AES_256_CBC_SHA256,
  "TLS_DHE_DSS_WITH_AES256_CBC_SHA256",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_DHE_RSA_WITH_AES_128_CBC_SHA,
  "TLS_DHE_RSA_WITH_AES128_CBC_SHA",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_DHE_RSA_WITH_AES_128_GCM_SHA256,
  "TLS_DHE_RSA_WITH_AES128_GCM_SHA256",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_DHE_RSA_WITH_AES_256_CBC_SHA,
  "TLS_DHE_RSA_WITH_AES256_CBC_SHA",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_DHE_RSA_WITH_AES_256_GCM_SHA384,
  "TLS_DHE_RSA_WITH_AES256_GCM_SHA384",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,
  "TLS_ECDHE_ECDSA_WITH_AES128_CBC_SHA",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256,
  "TLS_ECDHE_ECDSA_WITH_AES128_CBC_SHA256",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,
  "TLS_ECDHE_ECDSA_WITH_AES128_GCM_SHA256",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA,
  "TLS_ECDHE_ECDSA_WITH_AES256_CBC_SHA",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384,
  "TLS_ECDHE_ECDSA_WITH_AES256_CBC_SHA384",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,
  "TLS_ECDHE_ECDSA_WITH_AES256_GCM_SHA384",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,
  "TLS_ECDHE_RSA_WITH_AES128_CBC_SHA",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,
  "TLS_ECDHE_RSA_WITH_AES128_CBC_SHA256",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,
  "TLS_ECDHE_RSA_WITH_AES128_GCM_SHA256",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA,
  "TLS_ECDHE_RSA_WITH_AES256_CBC_SHA",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,
  "TLS_ECDHE_RSA_WITH_AES256_GCM_SHA384",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_RSA_WITH_3DES_EDE_CBC_SHA,
  "TLS_RSA_WITH3_DES_EDE_CBC_SHA",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_RSA_WITH_AES_128_CBC_SHA,
  "TLS_RSA_WITH_AES128_CBC_SHA",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_RSA_WITH_AES_128_CBC_SHA256,
  "TLS_RSA_WITH_AES128_CBC_SHA256",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_RSA_WITH_AES_128_GCM_SHA256,
  "TLS_RSA_WITH_AES128_GCM_SHA256",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_RSA_WITH_AES_256_CBC_SHA,
  "TLS_RSA_WITH_AES256_CBC_SHA",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_RSA_WITH_AES_256_CBC_SHA256,
  "TLS_RSA_WITH_AES256_CBC_SHA256",
  "python"
);
@@clientName(ApplicationGatewaySslCipherSuite.TLS_RSA_WITH_AES_256_GCM_SHA384,
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

@@clientLocation(P2SVpnGateways.get, "P2SVpnGateways", "python");
@@clientLocation(P2SVpnGateways.createOrUpdate, "P2SVpnGateways", "python");
@@clientLocation(P2SVpnGateways.updateTags, "P2SVpnGateways", "python");
@@clientLocation(P2SVpnGateways.delete, "P2SVpnGateways", "python");
@@clientLocation(P2SVpnGateways.listByResourceGroup,
  "P2SVpnGateways",
  "python"
);
@@clientLocation(P2SVpnGateways.list, "P2SVpnGateways", "python");
@@clientLocation(P2SVpnGateways.generateVpnProfile, "P2SVpnGateways", "python");
@@clientLocation(P2SVpnGateways.getP2sVpnConnectionHealth,
  "P2SVpnGateways",
  "python"
);
@@clientLocation(P2SVpnGateways.getP2sVpnConnectionHealthDetailed,
  "P2SVpnGateways",
  "python"
);
@@clientLocation(P2SVpnGateways.disconnectP2sVpnConnections,
  "P2SVpnGateways",
  "python"
);
@@clientLocation(VirtualHubs.virtualHubRouteTableV2sGet,
  "VirtualHubRouteTableV2S",
  "python"
);
@@clientLocation(VirtualHubs.virtualHubRouteTableV2sCreateOrUpdate,
  "VirtualHubRouteTableV2S",
  "python"
);
@@clientLocation(VirtualHubs.virtualHubRouteTableV2sDelete,
  "VirtualHubRouteTableV2S",
  "python"
);
@@clientLocation(VirtualHubs.virtualHubRouteTableV2sList,
  "VirtualHubRouteTableV2S",
  "python"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(IpamPoolsListParameters.skip,
  0,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(IpamPoolsListParameters.top,
  50,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(ReachabilityAnalysisIntentsListParameters.skip,
  0,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(ReachabilityAnalysisIntentsListParameters.top,
  50,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(ReachabilityAnalysisRunsListParameters.skip,
  0,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(ReachabilityAnalysisRunsListParameters.top,
  50,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(StaticCidrsListParameters.skip,
  0,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(StaticCidrsListParameters.top,
  50,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(VerifierWorkspacesListParameters.skip,
  0,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(VerifierWorkspacesListParameters.top,
  50,
  "python"
);
@@alternateType(Microsoft.Network.EffectiveNetworkSecurityGroup.tagMap,
  string,
  "javascript"
);
@@clientLocation(BastionHosts.putBastionShareableLink,
  CombineClient,
  "python,javascript"
);
@@clientLocation(BastionHosts.deleteBastionShareableLink,
  CombineClient,
  "python,javascript"
);
@@clientLocation(BastionHosts.deleteBastionShareableLinkByToken,
  CombineClient,
  "python,javascript"
);
@@clientLocation(BastionHosts.getBastionShareableLink,
  CombineClient,
  "python,javascript"
);
@@clientLocation(BastionHosts.getActiveSessions,
  CombineClient,
  "python,javascript"
);
@@clientLocation(BastionHosts.disconnectActiveSessions,
  CombineClient,
  "python,javascript"
);
@@clientLocation(CheckDnsNameAvailability.checkDnsNameAvailability,
  CombineClient,
  "python,javascript"
);
@@clientLocation(ExpressRouteProviderPorts.expressRouteProviderPort,
  CombineClient,
  "python,javascript"
);
@@clientLocation(NetworkManagers.listActiveConnectivityConfigurations,
  CombineClient,
  "python,javascript"
);
@@clientLocation(NetworkManagers.listActiveSecurityAdminRules,
  CombineClient,
  "python,javascript"
);
@@clientLocation(EffectiveConfigurations.listNetworkManagerEffectiveConnectivityConfigurations,
  CombineClient,
  "python,javascript"
);
@@clientLocation(EffectiveConfigurations.listNetworkManagerEffectiveSecurityAdminRules,
  CombineClient,
  "python,javascript"
);
@@clientLocation(VirtualWans.supportedSecurityProviders,
  CombineClient,
  "python,javascript"
);
@@clientLocation(VirtualWans.generatevirtualwanvpnserverconfigurationvpnprofile,
  CombineClient,
  "python,javascript"
);
@@clientName(ConnectionSharedKeyResults.getAllSharedKeys,
  "listAllSharedKeys",
  "javascript"
);
@@clientName(ServiceGateways.getAddressLocations,
  "listAddressLocations",
  "javascript"
);
@@clientName(ServiceGateways.getServices, "listServices", "javascript");
@@clientName(ApplicationGatewayWafDynamicManifestResults.applicationGatewayWafDynamicManifestsGet,
  "list",
  "javascript"
);
@@clientName(Azure.ResourceManager.ResourceProvisioningState,
  "ArmResourceProvisioningState",
  "python,javascript"
);

// Move Microsoft.Compute.PublicIPAddresses operations to Microsoft.Network.PublicIPAddresses for Java
@@clientLocation(Microsoft.Compute.PublicIPAddresses.getVirtualMachineScaleSetPublicIPAddress,
  Microsoft.Network.PublicIPAddresses,
  "java"
);
@@clientLocation(Microsoft.Compute.PublicIPAddresses.listVirtualMachineScaleSetVMPublicIPAddresses,
  Microsoft.Network.PublicIPAddresses,
  "java"
);

// Method renames to maintain backward compatibility for Java
@@clientName(ExpressRoutePorts.generateLOA, "generateLoa", "java");
@@clientName(P2SVpnGateways.getP2sVpnConnectionHealth,
  "getP2SVpnConnectionHealth",
  "java"
);
@@clientName(P2SVpnGateways.getP2sVpnConnectionHealthDetailed,
  "getP2SVpnConnectionHealthDetailed",
  "java"
);
@@clientName(P2SVpnGateways.disconnectP2sVpnConnections,
  "disconnectP2SVpnConnections",
  "java"
);

// PublicIPAddress → PublicIpAddress method renames for Java
@@clientName(Microsoft.Network.PublicIPAddresses.getCloudServicePublicIPAddress,
  "getCloudServicePublicIpAddress",
  "java"
);
@@clientName(Microsoft.Network.PublicIPAddresses.listCloudServiceRoleInstancePublicIPAddresses,
  "listCloudServiceRoleInstancePublicIpAddresses",
  "java"
);
@@clientName(Microsoft.Network.PublicIPAddressesOperationGroup.listCloudServicePublicIPAddresses,
  "listCloudServicePublicIpAddresses",
  "java"
);
@@clientName(Microsoft.Compute.PublicIPAddresses.getVirtualMachineScaleSetPublicIPAddress,
  "getVirtualMachineScaleSetPublicIpAddress",
  "java"
);
@@clientName(Microsoft.Compute.PublicIPAddresses.listVirtualMachineScaleSetVMPublicIPAddresses,
  "listVirtualMachineScaleSetVMPublicIpAddresses",
  "java"
);
@@clientName(Microsoft.Compute.PublicIPAddressesOperationGroup.listVirtualMachineScaleSetPublicIPAddresses,
  "listVirtualMachineScaleSetPublicIpAddresses",
  "java"
);

// Sub-client name fixes (override back-compatible.tsp for Java)
@@clientLocation(FrontendIPConfigurations.get,
  "LoadBalancerFrontendIpConfigurations",
  "java"
);
@@clientLocation(FrontendIPConfigurations.list,
  "LoadBalancerFrontendIpConfigurations",
  "java"
);
@@clientLocation(VirtualHubs.virtualHubRouteTableV2sGet,
  "VirtualHubRouteTableV2S",
  "java"
);
@@clientLocation(VirtualHubs.virtualHubRouteTableV2sCreateOrUpdate,
  "VirtualHubRouteTableV2S",
  "java"
);
@@clientLocation(VirtualHubs.virtualHubRouteTableV2sDelete,
  "VirtualHubRouteTableV2S",
  "java"
);
@@clientLocation(VirtualHubs.virtualHubRouteTableV2sList,
  "VirtualHubRouteTableV2S",
  "java"
);
@@clientName(CommonTypes.ProxyResource, "ProxyResourceAutoGenerated", "java");
@@clientName(CommonTypes.Resource, "ResourceAutoGenerated", "java");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ChildResource,
  Microsoft.Network.ProxyResource,
  "java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(CommonResource,
  CommonTypes.ProxyResource,
  "java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(SecurityPerimeterResource,
  CommonTypes.ProxyResource,
  "java"
);
