import "./Network/main.tsp";
import "./Vmss/main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;
using Microsoft.Network;
using Microsoft.Compute;
@client({
  name: "CombineClient",
  service: [Microsoft.Network, Microsoft.Compute],
  autoMergeService: true,
})
@useDependency(
  Microsoft.Network.Versions.v2025_05_01,
  Microsoft.Compute.Versions.v2018_10_01
)
namespace CombineClient;

@@clientName(CombineClient, "NetworkManagementClient", "javascript");
@@clientName(Azure.ResourceManager.CommonTypes.ErrorResponse,
  "ArmErrorResponse",
  "javascript"
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
@@clientName(Microsoft.Network.NetworkProvisioningState,
  "ProvisioningState",
  "java"
);
@@clientName(Microsoft.Network.ProvisioningState,
  "BaseProvisioningState",
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
  "java"
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
@@clientLocation(VirtualWans.supportedSecurityProviders,
  "ManagementClient",
  "go"
);
@@clientName(Microsoft.Network.NetworkProvisioningState,
  "ArmProvisioningState",
  "go"
);
@@clientName(Microsoft.Network.NetworkProtocol, "ArmNetworkProtocol", "go");
