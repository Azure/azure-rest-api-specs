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

// This empty namespace is the merged SDK client target used by later client
// customizations such as @@clientName and @@clientLocation.
#suppress "@azure-tools/typespec-client-generator-core/inconsistent-multiple-service-dependency" "temporarily suppressing"
@client({
  name: "CombineClient",
  service: [Microsoft.Network, Microsoft.Compute],
  autoMergeService: true,
})
namespace CombineClient {

}

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

@@clientLocation(
  Microsoft.Compute.NetworkInterfaceIPConfigurations.getVirtualMachineScaleSetIpConfiguration,
  Microsoft.Network.NetworkInterfaces,
  "java,javascript,python,go"
);

@@clientLocation(
  Microsoft.Compute.NetworkInterfaceIPConfigurations.listVirtualMachineScaleSetIpConfigurations,
  Microsoft.Network.NetworkInterfaces,
  "java,javascript,python,go"
);

@@clientLocation(
  Microsoft.Compute.NetworkInterfacesOperationGroup.listVirtualMachineScaleSetNetworkInterfaces,
  Microsoft.Network.NetworkInterfaces,
  "java,javascript,python,go"
);

@@clientLocation(
  Microsoft.Compute.PublicIPAddressesOperationGroup.listVirtualMachineScaleSetPublicIPAddresses,
  Microsoft.Network.PublicIPAddresses,
  "java,javascript,python,go"
);

@@clientName(CombineClient, "NetworkManagementClient", "javascript,python");
@@clientName(
  Azure.ResourceManager.CommonTypes.ErrorResponse,
  "ArmErrorResponse",
  "javascript,python"
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
  Microsoft.Network.HTTPConfigurationMethod,
  "HttpConfigurationMethod",
  "java"
);
@@clientName(Microsoft.Network.HttpHeader, "HttpHeader", "java");
@@clientName(Microsoft.Network.HTTPMethod, "HttpMethod", "java");
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

@@clientName(FirewallPolicyIDPSSignatureDirection.`0`, "Zero", "go");
@@clientName(FirewallPolicyIDPSSignatureDirection.`1`, "One", "go");
@@clientName(FirewallPolicyIDPSSignatureDirection.`2`, "Two", "go");
@@clientName(FirewallPolicyIDPSSignatureDirection.`3`, "Three", "go");
@@clientName(FirewallPolicyIDPSSignatureDirection.`4`, "Four", "go");
@@clientName(FirewallPolicyIDPSSignatureDirection.`5`, "Five", "go");

@@clientName(FirewallPolicyIDPSSignatureMode.`0`, "Zero", "go");
@@clientName(FirewallPolicyIDPSSignatureMode.`1`, "One", "go");
@@clientName(FirewallPolicyIDPSSignatureMode.`2`, "Two", "go");

@@clientName(FirewallPolicyIDPSSignatureSeverity.`1`, "One", "go");
@@clientName(FirewallPolicyIDPSSignatureSeverity.`2`, "Two", "go");
@@clientName(FirewallPolicyIDPSSignatureSeverity.`3`, "Three", "go");

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

// C# management-plane migration naming compatibility.
@@clientName(Commit, "NetworkManagerConfigurationCommit", "csharp");
@@clientName(Subgroup, "InterconnectGroupSubgroup", "csharp");
@@clientName(VM, "BastionShareableLinkVirtualMachine", "csharp");
@@clientName(Geo, "CidrAdvertisingGeoCode", "csharp");
@@clientName(Geo.GLOBAL, "Global", "csharp");
@@clientName(Geo.AFRI, "Afri", "csharp");
@@clientName(Geo.APAC, "Apac", "csharp");
@@clientName(Geo.EURO, "Euro", "csharp");
@@clientName(Geo.LATAM, "Latam", "csharp");
@@clientName(Geo.NAM, "Nam", "csharp");
@@clientName(Geo.OCEANIA, "Oceania", "csharp");
@@clientName(
  BastionShareableLinkListRequest,
  "BastionShareableLinkListContent",
  "csharp"
);
@@clientName(
  ExpressRouteLinkFailoverStopApiParameters,
  "ExpressRouteLinkFailoverStopContent",
  "csharp"
);
@@clientName(ChildResource, "NetworkChildResource", "csharp");
@@clientName(Microsoft.Network.ProxyResource, "NetworkProxyResource", "csharp");
@@clientName(WritableResource, "NetworkWritableResource", "csharp");
@@clientName(
  Microsoft.Network.ApplicationGatewayBackendHttpSettingsPropertiesFormat.requestTimeout,
  "RequestTimeoutInSeconds",
  "csharp"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayBackendHttpSettingsPropertiesFormat.dedicatedBackendConnection,
  "IsDedicatedBackendConnectionEnabled",
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
  Microsoft.Network.ConnectionMonitorHttpConfiguration.preferHTTPS,
  "PreferHttps",
  "csharp"
);
@@clientName(
  Microsoft.Network.GatewayCustomBgpIpAddressIpConfiguration.customBgpIpAddress,
  "CustomBgpIPAddress",
  "csharp"
);
@@clientName(
  Microsoft.Network.GatewayCustomBgpIpAddressIpConfiguration.ipConfigurationId,
  "IPConfigurationId",
  "csharp"
);
@@clientName(
  Microsoft.Network.IPConfigurationBgpPeeringAddress.customBgpIpAddresses,
  "CustomBgpIPAddresses",
  "csharp"
);
@@clientName(
  Microsoft.Network.IPConfigurationBgpPeeringAddress.defaultBgpIpAddresses,
  "DefaultBgpIPAddresses",
  "csharp"
);
@@clientName(
  Microsoft.Network.IPConfigurationBgpPeeringAddress.ipconfigurationId,
  "IPConfigurationId",
  "csharp"
);
@@clientName(
  Microsoft.Network.IPConfigurationBgpPeeringAddress.tunnelIpAddresses,
  "TunnelIPAddresses",
  "csharp"
);
@@clientName(
  Microsoft.Network.ApplicationGatewayConnectionDraining.drainTimeoutInSec,
  "DrainTimeoutInSeconds",
  "csharp"
);
@@clientName(
  Common.TrafficAnalyticsConfigurationProperties.trafficAnalyticsInterval,
  "TrafficAnalyticsIntervalInMinutes",
  "csharp"
);
@@clientName(
  Microsoft.Network.VpnClientConnectionHealthDetail.privateIpAddress,
  "PrivateIPAddress",
  "csharp"
);
@@clientName(
  Microsoft.Network.VpnClientConnectionHealthDetail.publicIpAddress,
  "PublicIPAddress",
  "csharp"
);
@@clientName(
  Microsoft.Network.VpnClientConnectionHealthDetail.vpnConnectionDuration,
  "VpnConnectionDurationInSeconds",
  "csharp"
);
@@clientName(
  Microsoft.Network.VpnClientConnectionHealthDetail.vpnConnectionTime,
  "VpnConnectionOn",
  "csharp"
);
@@alternateType(
  Microsoft.Network.NetworkManagerConnectionProperties.networkManagerId,
  armResourceIdentifier,
  "csharp"
);
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
  FirewallPolicyIDPSQuerySortOrder,
  "FirewallPolicyIdpsQuerySortOrder",
  "java"
);
@@clientName(
  FirewallPolicyIDPSSignatureDirection,
  "FirewallPolicyIdpsSignatureDirection",
  "java"
);
@@clientName(
  FirewallPolicyIDPSSignatureMode,
  "FirewallPolicyIdpsSignatureMode",
  "java"
);
@@clientName(
  FirewallPolicyIDPSSignatureSeverity,
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
@@clientName(FirewallPolicyIDPSSignatureDirection.`0`, "ZERO", "python");
@@clientName(FirewallPolicyIDPSSignatureDirection.`1`, "ONE", "python");
@@clientName(FirewallPolicyIDPSSignatureDirection.`2`, "TWO", "python");
@@clientName(FirewallPolicyIDPSSignatureDirection.`3`, "THREE", "python");
@@clientName(FirewallPolicyIDPSSignatureDirection.`4`, "FOUR", "python");
@@clientName(FirewallPolicyIDPSSignatureDirection.`5`, "FIVE", "python");
@@clientName(FirewallPolicyIDPSSignatureMode.`0`, "ZERO", "python");
@@clientName(FirewallPolicyIDPSSignatureMode.`1`, "ONE", "python");
@@clientName(FirewallPolicyIDPSSignatureMode.`2`, "TWO", "python");
@@clientName(FirewallPolicyIDPSSignatureSeverity.`1`, "ONE", "python");
@@clientName(FirewallPolicyIDPSSignatureSeverity.`2`, "TWO", "python");
@@clientName(FirewallPolicyIDPSSignatureSeverity.`3`, "THREE", "python");

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

// C# customizations for Azure.ResourceManager.Network MPG migration.
// C# naming mitigations for brownfield Network acronyms and shared model names.
@@clientName(Common.ProvisioningState, "NetworkProvisioningState", "csharp");

@@clientName(Common.IPAllocationMethod, "NetworkIPAllocationMethod", "csharp");

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

@@clientName(Microsoft.Network.ResourceBasics, "IpamResourceBasics", "csharp");

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

@@clientName(Microsoft.Network.TopologyParameters, "TopologyContent", "csharp");

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

@@clientName(Microsoft.Network.Direction, "NetworkTrafficDirection", "csharp");

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

@@clientName(Microsoft.Network.UseHubGateway, "HubGatewayUsageFlag", "csharp");

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

@@clientName(Microsoft.Network.IPTraffic, "NetworkVerifierIPTraffic", "csharp");

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

// Keep the C# operation location parameters aligned with the GA AutoRest surface.
// The TypeSpec ARM location parameter is string, but these Network operations shipped as AzureLocation.
@@alternateType(
  Microsoft.Network.CheckDnsNameAvailability.checkDnsNameAvailability::parameters.location,
  Azure.Core.azureLocation,
  "csharp"
);

@@alternateType(
  Microsoft.Network.LoadBalancersOperationGroup.swapPublicIpAddresses::parameters.location,
  Azure.Core.azureLocation,
  "csharp"
);

@@alternateType(
  Microsoft.Network.PrivateLinkServicesOperationGroup.checkPrivateLinkServiceVisibility::parameters.location,
  Azure.Core.azureLocation,
  "csharp"
);

@@alternateType(
  Microsoft.Network.PrivateLinkServicesOperationGroup.checkPrivateLinkServiceVisibilityByResourceGroup::parameters.location,
  Azure.Core.azureLocation,
  "csharp"
);

@@alternateType(
  Microsoft.Network.ServiceTagsOperationGroup.list::parameters.location,
  Azure.Core.azureLocation,
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

@@alternateType(Common.NatGatewayPropertiesFormat.resourceGuid, uuid, "csharp");

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

@@alternateType(Common.RouteTablePropertiesFormat.resourceGuid, uuid, "csharp");

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

@@clientName(Microsoft.Network.Parameter, "RouteMapActionParameter", "csharp");

@@clientName(Microsoft.Network.Action.type, "ActionType", "csharp");

@@clientName(Microsoft.Network.Criterion, "RouteCriterion", "csharp");

@@clientName(Microsoft.Network.NextStep, "RouteMapNextStepBehavior", "csharp");

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
  "VirtualMachineScaleSetNetworkInterfaces",
  "csharp"
);

@@clientLocation(
  Microsoft.Compute.NetworkInterfaces.getVirtualMachineScaleSetNetworkInterface,
  "VirtualMachineScaleSetNetworkInterfaces",
  "csharp"
);

@@clientName(
  Microsoft.Compute.NetworkInterfaceIPConfigurations,
  "VirtualMachineScaleSetNetworkInterfaceIPConfigurations",
  "csharp"
);

@@clientName(
  Microsoft.Compute.PublicIPAddresses,
  "VirtualMachineScaleSetNetworkInterfaceIPConfigurationPublicIPAddresses",
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

@@clientName(RouteFilters.routeFilterRulesGet, "GetRouteFilterRule", "csharp");

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

@@clientName(ExpressRouteGateways.list, "GetExpressRouteConnections", "csharp");

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

@@clientName(Microsoft.Network.PacketCapture, "PacketCaptureContent", "csharp");

@@clientName(Microsoft.Network.PacketCaptureResult, "PacketCapture", "csharp");

@@clientName(Microsoft.Network.AdminRuleCollection, "AdminRuleGroup", "csharp");

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
