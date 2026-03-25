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
@useDependency(
  Microsoft.Network.Versions.v2025_05_01,
  Microsoft.Compute.Versions.v2018_10_01
)
namespace CombineClient;

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
  "java,javascript"
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
@@clientName(Microsoft.Network.NetworkProvisioningState,
  "ProvisioningState",
  "go"
);
@@clientName(Microsoft.Network.ProvisioningState,
  "BaseProvisioningState",
  "go"
);
@@clientName(Microsoft.Network.NetworkProtocol, "Protocol", "go");
@@clientName(Microsoft.Network.Protocol, "BaseProtocol", "go");

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
  "go,python"
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
  "go"
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
  body: CheckPrivateLinkServiceVisibilityRequest,
): ArmResponse<AvailablePrivateEndpointTypesResult> | ArmAcceptedLroResponse<
  "Accepted and the operation will complete asynchronously.",
  ArmLroLocationHeader<FinalResult = PrivateLinkServiceVisibility>
> | CloudError;

@@override(PrivateLinkServicesOperationGroup.checkPrivateLinkServiceVisibilityByResourceGroup,
  privateLinkServicesCheckPrivateLinkServiceVisibilityByResourceGroup,
  "go,python"
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
  "go,python"
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
  "go,python"
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
  "go,python"
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
@@alternateType(Microsoft.Network.EffectiveNetworkSecurityGroup,
  string,
  "javascript"
);
@@clientLocation(BastionHosts.putBastionShareableLink, CombineClient, "python");
@@clientLocation(BastionHosts.deleteBastionShareableLink,
  CombineClient,
  "python"
);
@@clientLocation(BastionHosts.deleteBastionShareableLinkByToken,
  CombineClient,
  "python"
);
@@clientLocation(BastionHosts.getBastionShareableLink, CombineClient, "python");
@@clientLocation(BastionHosts.getActiveSessions, CombineClient, "python");
@@clientLocation(BastionHosts.disconnectActiveSessions,
  CombineClient,
  "python"
);
@@clientLocation(CheckDnsNameAvailability.checkDnsNameAvailability,
  CombineClient,
  "python"
);
@@clientLocation(ExpressRouteProviderPorts.expressRouteProviderPort,
  CombineClient,
  "python"
);
@@clientLocation(NetworkManagers.listActiveConnectivityConfigurations,
  CombineClient,
  "python"
);
@@clientLocation(NetworkManagers.listActiveSecurityAdminRules,
  CombineClient,
  "python"
);
@@clientLocation(EffectiveConfigurations.listNetworkManagerEffectiveConnectivityConfigurations,
  CombineClient,
  "python"
);
@@clientLocation(EffectiveConfigurations.listNetworkManagerEffectiveSecurityAdminRules,
  CombineClient,
  "python"
);
