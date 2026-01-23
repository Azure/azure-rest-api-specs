import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Network;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayIPConfiguration.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayAuthenticationCertificate.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayTrustedRootCertificate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayTrustedClientCertificate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewaySslCertificate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayFrontendIPConfiguration.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayFrontendPort.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayProbe.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayBackendAddressPool.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateLinkServiceConnection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateEndpointIPConfiguration.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateLinkServiceIpConfiguration.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IPConfiguration.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IPConfigurationProfile.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ResourceNavigationLink.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServiceAssociationLink.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Delegation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IpamPoolPrefixAllocation.pool);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LoadBalancerBackendAddress.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayBackendHttpSettings.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayBackendSettings.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayHttpListener.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayListener.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewaySslProfile.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayUrlPathMap.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayPathRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayRequestRoutingRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayRoutingRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayRewriteRuleSet.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayRedirectConfiguration.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayPrivateLinkConfiguration.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayPrivateLinkIpConfiguration.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayLoadDistributionPolicy.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayLoadDistributionTarget.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayEntraJWTValidationConfig.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayPrivateLinkResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayFirewallRuleSet.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewaySslPredefinedPolicy.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayWafDynamicManifestPropertiesResult.defaultRuleSet
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayWafDynamicManifestPropertiesResult.availableRuleSets
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AzureFirewallApplicationRuleCollection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AzureFirewallNatRuleCollection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AzureFirewallNetworkRuleCollection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AzureFirewallIPConfiguration.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AzureFirewallFqdnTag.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(BastionHostIPConfiguration.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DdosDetectionRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExpressRouteServiceProvider.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExpressRouteCrossConnectionPeering.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExpressRouteLink.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(InboundNatPool.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LoadBalancerVipSwapRequestFrontendIPConfiguration.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(EffectiveConnectivityConfiguration.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ConfigurationGroup.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NetworkManagerConnectionProperties.connectionState);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ScopeConnectionProperties.connectionState);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ContainerNetworkInterface.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ContainerNetworkInterfaceConfiguration.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ContainerNetworkInterfaceIpConfiguration.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PerimeterAssociableResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PacketCapture.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PacketCaptureResult.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(TroubleshootingParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FlowLogInformation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(HopLink.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ConnectionMonitor.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Operation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateDnsZoneGroup.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateDnsZoneConfig.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RouteFilterRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(BgpServiceCommunity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VirtualNetworkGatewayIPConfiguration.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VpnClientRootCertificate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VpnClientRevokedCertificate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VngClientConnectionConfiguration.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VirtualNetworkGatewayPolicyGroup.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VirtualNetworkGatewayConnectionListEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(P2SConnectionConfiguration.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VirtualHubRouteTableV2.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(HubVirtualNetworkConnection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VpnConnection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExpressRouteConnection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NetworkVirtualApplianceConnection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ActiveSecurityAdminRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ActiveDefaultSecurityAdminRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(EffectiveSecurityAdminRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(EffectiveDefaultSecurityAdminRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AdminRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DefaultAdminRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PatchRouteFilterRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PatchRouteFilter.properties);

@@clientName(ApplicationGateways.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ApplicationGateways.updateTags::parameters.properties,
  "parameters"
);
@@clientName(ApplicationGateways.backendHealthOnDemand::parameters.body,
  "probeRequest"
);
@@clientLocation(ApplicationGateways.applicationGatewayPrivateLinkResourcesList,
  "ApplicationGatewayPrivateLinkResources"
);
@@clientName(ApplicationGateways.applicationGatewayPrivateLinkResourcesList,
  "List"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGateway.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NetworkInterfaceIPConfiguration.properties);

@@clientName(VirtualNetworkTaps.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(VirtualNetworkTaps.updateTags::parameters.properties,
  "tapParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VirtualNetworkTap.properties);

@@clientName(NetworkInterfaceTapConfigurations.createOrUpdate::parameters.resource,
  "tapConfigurationParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NetworkInterfaceTapConfiguration.properties);

@@clientLocation(FrontendIPConfigurations.get,
  "LoadBalancerFrontendIPConfigurations"
);
@@clientLocation(FrontendIPConfigurations.list,
  "LoadBalancerFrontendIPConfigurations"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FrontendIPConfiguration.properties);

@@clientName(Subnets.createOrUpdate::parameters.resource, "subnetParameters");
@@clientName(Subnets.prepareNetworkPolicies::parameters.body,
  "prepareNetworkPoliciesRequestParameters"
);
@@clientName(Subnets.unprepareNetworkPolicies::parameters.body,
  "unprepareNetworkPoliciesRequestParameters"
);
@@clientLocation(Subnets.resourceNavigationLinksList,
  "ResourceNavigationLinks"
);
@@clientName(Subnets.resourceNavigationLinksList, "List");
@@clientLocation(Subnets.serviceAssociationLinksList,
  "ServiceAssociationLinks"
);
@@clientName(Subnets.serviceAssociationLinksList, "List");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Subnet.properties);

@@clientName(NetworkSecurityGroups.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(NetworkSecurityGroups.updateTags::parameters.properties,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NetworkSecurityGroup.properties);

@@clientName(SecurityRules.createOrUpdate::parameters.resource,
  "securityRuleParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecurityRule.properties);

@@clientName(ApplicationSecurityGroups.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ApplicationSecurityGroups.updateTags::parameters.properties,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationSecurityGroup.properties);

@@clientLocation(NetworkInterfaceOperationGroup.get, NetworkInterfaces);
@@clientLocation(NetworkInterfaceOperationGroup.createOrUpdate,
  NetworkInterfaces
);
@@clientName(NetworkInterfaceOperationGroup.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(NetworkInterfaceOperationGroup.updateTags, NetworkInterfaces);
@@clientName(NetworkInterfaceOperationGroup.updateTags::parameters.properties,
  "parameters"
);
@@clientLocation(NetworkInterfaceOperationGroup.delete, NetworkInterfaces);
@@clientLocation(NetworkInterfaceOperationGroup.list, NetworkInterfaces);
@@clientLocation(NetworkInterfaceOperationGroup.listAll, NetworkInterfaces);
@@clientLocation(NetworkInterfaceOperationGroup.getEffectiveRouteTable,
  NetworkInterfaces
);
@@clientLocation(NetworkInterfaceOperationGroup.listEffectiveNetworkSecurityGroups,
  NetworkInterfaces
);
@@clientLocation(NetworkInterfaceOperationGroup.networkInterfaceLoadBalancersList,
  "NetworkInterfaceLoadBalancers"
);
@@clientName(NetworkInterfaceOperationGroup.networkInterfaceLoadBalancersList,
  "List"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NetworkInterface.properties);

@@clientName(PrivateEndpoints.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(PrivateEndpoints.privateDnsZoneGroupsDelete,
  "PrivateDnsZoneGroups"
);
@@clientName(PrivateEndpoints.privateDnsZoneGroupsDelete, "Delete");
@@clientLocation(PrivateEndpoints.privateDnsZoneGroupsGet,
  "PrivateDnsZoneGroups"
);
@@clientName(PrivateEndpoints.privateDnsZoneGroupsGet, "Get");
@@clientLocation(PrivateEndpoints.privateDnsZoneGroupsCreateOrUpdate,
  "PrivateDnsZoneGroups"
);
@@clientName(PrivateEndpoints.privateDnsZoneGroupsCreateOrUpdate,
  "CreateOrUpdate"
);
@@clientName(PrivateEndpoints.privateDnsZoneGroupsCreateOrUpdate::parameters.body,
  "parameters"
);
@@clientLocation(PrivateEndpoints.privateDnsZoneGroupsList,
  "PrivateDnsZoneGroups"
);
@@clientName(PrivateEndpoints.privateDnsZoneGroupsList, "List");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateEndpoint.properties);

@@clientName(PrivateLinkServices.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateLinkService.properties);

@@clientLocation(PrivateEndpointConnections.getPrivateEndpointConnection,
  PrivateLinkServices
);
@@clientLocation(PrivateEndpointConnections.updatePrivateEndpointConnection,
  PrivateLinkServices
);
@@clientName(PrivateEndpointConnections.updatePrivateEndpointConnection::parameters.resource,
  "parameters"
);
@@clientLocation(PrivateEndpointConnections.deletePrivateEndpointConnection,
  PrivateLinkServices
);
@@clientLocation(PrivateEndpointConnections.listPrivateEndpointConnections,
  PrivateLinkServices
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

@@clientName(FlowLogs.createOrUpdate::parameters.resource, "parameters");
@@clientName(FlowLogs.updateTags::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FlowLog.properties);

@@clientName(RouteTables.createOrUpdate::parameters.resource, "parameters");
@@clientName(RouteTables.updateTags::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RouteTable.properties);

@@clientName(Routes.createOrUpdate::parameters.resource, "routeParameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Route.properties);

@@clientName(ServiceEndpointPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ServiceEndpointPolicies.updateTags::parameters.properties,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServiceEndpointPolicy.properties);

@@clientName(ServiceEndpointPolicyDefinitions.createOrUpdate::parameters.resource,
  "ServiceEndpointPolicyDefinitions"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServiceEndpointPolicyDefinition.properties);

@@clientLocation(PublicIPAddressOperationGroup.get, PublicIPAddresses);
@@clientLocation(PublicIPAddressOperationGroup.createOrUpdate,
  PublicIPAddresses
);
@@clientName(PublicIPAddressOperationGroup.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(PublicIPAddressOperationGroup.updateTags, PublicIPAddresses);
@@clientName(PublicIPAddressOperationGroup.updateTags::parameters.properties,
  "parameters"
);
@@clientLocation(PublicIPAddressOperationGroup.delete, PublicIPAddresses);
@@clientLocation(PublicIPAddressOperationGroup.list, PublicIPAddresses);
@@clientLocation(PublicIPAddressOperationGroup.listAll, PublicIPAddresses);
@@clientLocation(PublicIPAddressOperationGroup.ddosProtectionStatus,
  PublicIPAddresses
);
@@clientLocation(PublicIPAddressOperationGroup.reserveCloudServicePublicIpAddress,
  PublicIPAddresses
);
@@clientName(PublicIPAddressOperationGroup.reserveCloudServicePublicIpAddress::parameters.body,
  "parameters"
);
@@clientLocation(PublicIPAddressOperationGroup.disassociateCloudServiceReservedPublicIp,
  PublicIPAddresses
);
@@clientName(PublicIPAddressOperationGroup.disassociateCloudServiceReservedPublicIp::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PublicIPAddress.properties);

@@clientName(NatGateways.createOrUpdate::parameters.resource, "parameters");
@@clientName(NatGateways.updateTags::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NatGateway.properties);

@@clientLocation(BackendAddressPools.get, "LoadBalancerBackendAddressPools");
@@clientLocation(BackendAddressPools.createOrUpdate,
  "LoadBalancerBackendAddressPools"
);
@@clientName(BackendAddressPools.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(BackendAddressPools.delete, "LoadBalancerBackendAddressPools");
@@clientLocation(BackendAddressPools.list, "LoadBalancerBackendAddressPools");
@@clientLocation(BackendAddressPools.listInboundNatRulePortMappings,
  LoadBalancers
);
@@clientName(BackendAddressPools.listInboundNatRulePortMappings::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(BackendAddressPool.properties);

@@clientName(InboundNatRules.createOrUpdate::parameters.resource,
  "inboundNatRuleParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(InboundNatRule.properties);

@@clientName(ApplicationGatewayPrivateEndpointConnections.update::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayPrivateEndpointConnection.properties
);

@@clientLocation(ApplicationGatewayAvailableSslOptionsOperationGroup.listAvailableSslOptions,
  ApplicationGateways
);
@@clientLocation(ApplicationGatewayAvailableSslOptionsOperationGroup.listAvailableSslPredefinedPolicies,
  ApplicationGateways
);
@@clientLocation(ApplicationGatewayAvailableSslOptionsOperationGroup.getSslPredefinedPolicy,
  ApplicationGateways
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayAvailableSslOptions.properties);

@@clientLocation(ApplicationGatewayWafDynamicManifestResults.get,
  "ApplicationGatewayWafDynamicManifestsDefault"
);
@@clientLocation(ApplicationGatewayWafDynamicManifestResults.applicationGatewayWafDynamicManifestsGet,
  "ApplicationGatewayWafDynamicManifests"
);
@@clientName(ApplicationGatewayWafDynamicManifestResults.applicationGatewayWafDynamicManifestsGet,
  "Get"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationGatewayWafDynamicManifestResult.properties);

@@clientName(AzureFirewalls.createOrUpdate::parameters.resource, "parameters");
@@clientName(AzureFirewalls.updateTags::parameters.properties, "parameters");
@@clientName(AzureFirewalls.packetCapture::parameters.body, "parameters");
@@clientName(AzureFirewalls.packetCaptureOperation::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AzureFirewall.properties);

@@clientLocation(AzureWebCategories.get, "WebCategories");
@@clientLocation(AzureWebCategories.listBySubscription, "WebCategories");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AzureWebCategory.properties);

@@clientName(BastionHosts.createOrUpdate::parameters.resource, "parameters");
@@clientName(BastionHosts.updateTags::parameters.properties, "parameters");
@@clientLocation(BastionHosts.putBastionShareableLink, "");
@@clientName(BastionHosts.putBastionShareableLink::parameters.body,
  "bslRequest"
);
@@clientLocation(BastionHosts.deleteBastionShareableLink, "");
@@clientName(BastionHosts.deleteBastionShareableLink::parameters.body,
  "bslRequest"
);
@@clientLocation(BastionHosts.deleteBastionShareableLinkByToken, "");
@@clientName(BastionHosts.deleteBastionShareableLinkByToken::parameters.body,
  "bslTokenRequest"
);
@@clientLocation(BastionHosts.getBastionShareableLink, "");
@@clientName(BastionHosts.getBastionShareableLink::parameters.body,
  "bslRequest"
);
@@clientLocation(BastionHosts.getActiveSessions, "");
@@clientLocation(BastionHosts.disconnectActiveSessions, "");
@@clientName(BastionHosts.disconnectActiveSessions::parameters.body,
  "sessionIds"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(BastionHost.properties);

@@clientLocation(SwapResources.get, "VipSwap");
@@clientLocation(SwapResources.create, "VipSwap");
@@clientName(SwapResources.create::parameters.resource, "parameters");
@@clientLocation(SwapResources.list, "VipSwap");

@@clientLocation(CustomIpPrefixes.get, "CustomIPPrefixes");
@@clientLocation(CustomIpPrefixes.createOrUpdate, "CustomIPPrefixes");
@@clientName(CustomIpPrefixes.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(CustomIpPrefixes.updateTags, "CustomIPPrefixes");
@@clientName(CustomIpPrefixes.updateTags::parameters.properties, "parameters");
@@clientLocation(CustomIpPrefixes.delete, "CustomIPPrefixes");
@@clientLocation(CustomIpPrefixes.list, "CustomIPPrefixes");
@@clientLocation(CustomIpPrefixes.listAll, "CustomIPPrefixes");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CustomIpPrefix.properties);

@@clientName(DdosCustomPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(DdosCustomPolicies.updateTags::parameters.properties,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DdosCustomPolicy.properties);

@@clientName(DdosProtectionPlans.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(DdosProtectionPlans.updateTags::parameters.properties,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DdosProtectionPlan.properties);

@@clientLocation(DscpConfigurations.get, "DscpConfiguration");
@@clientLocation(DscpConfigurations.createOrUpdate, "DscpConfiguration");
@@clientName(DscpConfigurations.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(DscpConfigurations.delete, "DscpConfiguration");
@@clientLocation(DscpConfigurations.list, "DscpConfiguration");
@@clientLocation(DscpConfigurations.listAll, "DscpConfiguration");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DscpConfiguration.properties);

@@clientName(ExpressRouteCircuitAuthorizations.createOrUpdate::parameters.resource,
  "authorizationParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExpressRouteCircuitAuthorization.properties);

@@clientName(ExpressRouteCircuitPeerings.createOrUpdate::parameters.resource,
  "peeringParameters"
);
@@clientLocation(ExpressRouteCircuitPeerings.listArpTable,
  ExpressRouteCircuits
);
@@clientLocation(ExpressRouteCircuitPeerings.listRoutesTable,
  ExpressRouteCircuits
);
@@clientLocation(ExpressRouteCircuitPeerings.listRoutesTableSummary,
  ExpressRouteCircuits
);
@@clientLocation(ExpressRouteCircuitPeerings.getPeeringStats,
  ExpressRouteCircuits
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExpressRouteCircuitPeering.properties);

@@clientName(ExpressRouteCircuitConnections.createOrUpdate::parameters.resource,
  "expressRouteCircuitConnectionParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExpressRouteCircuitConnection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PeerExpressRouteCircuitConnection.properties);

@@clientName(ExpressRouteCircuits.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ExpressRouteCircuits.updateTags::parameters.properties,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExpressRouteCircuit.properties);

@@clientName(ExpressRouteCrossConnections.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ExpressRouteCrossConnections.updateTags::parameters.properties,
  "crossConnectionParameters"
);
@@clientLocation(ExpressRouteCrossConnections.expressRouteCrossConnectionPeeringsList,
  "ExpressRouteCrossConnectionPeerings"
);
@@clientName(ExpressRouteCrossConnections.expressRouteCrossConnectionPeeringsList,
  "List"
);
@@clientLocation(ExpressRouteCrossConnections.delete,
  "ExpressRouteCrossConnectionPeerings"
);
@@clientLocation(ExpressRouteCrossConnections.expressRouteCrossConnectionPeeringsGet,
  "ExpressRouteCrossConnectionPeerings"
);
@@clientName(ExpressRouteCrossConnections.expressRouteCrossConnectionPeeringsGet,
  "Get"
);
@@clientLocation(ExpressRouteCrossConnections.expressRouteCrossConnectionPeeringsCreateOrUpdate,
  "ExpressRouteCrossConnectionPeerings"
);
@@clientName(ExpressRouteCrossConnections.expressRouteCrossConnectionPeeringsCreateOrUpdate,
  "CreateOrUpdate"
);
@@clientName(ExpressRouteCrossConnections.expressRouteCrossConnectionPeeringsCreateOrUpdate::parameters.body,
  "peeringParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExpressRouteCrossConnection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExpressRoutePortsLocation.properties);

@@clientName(ExpressRoutePorts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ExpressRoutePorts.updateTags::parameters.properties, "parameters");
@@clientName(ExpressRoutePorts.generateLOA::parameters.body, "request");
@@clientLocation(ExpressRoutePorts.expressRouteLinksGet, "ExpressRouteLinks");
@@clientName(ExpressRoutePorts.expressRouteLinksGet, "Get");
@@clientLocation(ExpressRoutePorts.expressRouteLinksList, "ExpressRouteLinks");
@@clientName(ExpressRoutePorts.expressRouteLinksList, "List");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExpressRoutePort.properties);

@@clientName(ExpressRoutePortAuthorizations.createOrUpdate::parameters.resource,
  "authorizationParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExpressRoutePortAuthorization.properties);

@@clientLocation(ExpressRouteProviderPorts.expressRouteProviderPort, "");
@@clientLocation(ExpressRouteProviderPorts.list,
  "ExpressRouteProviderPortsLocation"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExpressRouteProviderPort.properties);

@@clientName(FirewallPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(FirewallPolicies.updateTags::parameters.properties, "parameters");
@@clientLocation(FirewallPolicies.firewallPolicyIdpsSignaturesList,
  "FirewallPolicyIdpsSignatures"
);
@@clientName(FirewallPolicies.firewallPolicyIdpsSignaturesList, "List");
@@clientName(FirewallPolicies.firewallPolicyIdpsSignaturesList::parameters.body,
  "parameters"
);
@@clientLocation(FirewallPolicies.firewallPolicyIdpsSignaturesFilterValuesList,
  "FirewallPolicyIdpsSignaturesFilterValues"
);
@@clientName(FirewallPolicies.firewallPolicyIdpsSignaturesFilterValuesList,
  "List"
);
@@clientName(FirewallPolicies.firewallPolicyIdpsSignaturesFilterValuesList::parameters.body,
  "parameters"
);
@@clientLocation(FirewallPolicies.deploy, "FirewallPolicyDeployments");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FirewallPolicy.properties);

@@clientName(FirewallPolicyRuleCollectionGroups.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FirewallPolicyRuleCollectionGroup.properties);

@@clientName(FirewallPolicyIdpsSignaturesOverrides.put::parameters.resource,
  "parameters"
);
@@clientName(FirewallPolicyIdpsSignaturesOverrides.patch::parameters.properties,
  "parameters"
);

@@clientName(FirewallPolicyDrafts.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FirewallPolicyDraft.properties);

@@clientName(FirewallPolicyRuleCollectionGroupDrafts.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FirewallPolicyRuleCollectionGroupDraft.properties);

@@clientName(IpamPools.create::parameters.resource, "body");
@@clientName(IpamPools.update::parameters.properties, "body");

@@clientName(StaticCidrs.create::parameters.resource, "body");

@@clientName(IpAllocations.createOrUpdate::parameters.resource, "parameters");
@@clientName(IpAllocations.updateTags::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IpAllocation.properties);

@@clientName(IpGroups.createOrUpdate::parameters.resource, "parameters");
@@clientName(IpGroups.updateGroups::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IpGroup.properties);

@@clientName(LoadBalancers.createOrUpdate::parameters.resource, "parameters");
@@clientName(LoadBalancers.updateTags::parameters.properties, "parameters");
@@clientName(LoadBalancers.migrateToIpBased::parameters.body, "parameters");
@@clientLocation(LoadBalancers.loadBalancerNetworkInterfacesList,
  "LoadBalancerNetworkInterfaces"
);
@@clientName(LoadBalancers.loadBalancerNetworkInterfacesList, "List");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LoadBalancer.properties);

@@clientLocation(LoadBalancingRules.get, "LoadBalancerLoadBalancingRules");
@@clientLocation(LoadBalancingRules.list, "LoadBalancerLoadBalancingRules");
@@clientLocation(LoadBalancingRules.health, "LoadBalancerLoadBalancingRules");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LoadBalancingRule.properties);

@@clientLocation(Probes.get, "LoadBalancerProbes");
@@clientLocation(Probes.list, "LoadBalancerProbes");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Probe.properties);

@@clientLocation(OutboundRules.get, "LoadBalancerOutboundRules");
@@clientLocation(OutboundRules.list, "LoadBalancerOutboundRules");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(OutboundRule.properties);

@@clientName(NetworkManagers.createOrUpdate::parameters.resource, "parameters");
@@clientName(NetworkManagers.patch::parameters.properties, "parameters");
@@clientLocation(NetworkManagers.listActiveConnectivityConfigurations, "");
@@clientName(NetworkManagers.listActiveConnectivityConfigurations::parameters.body,
  "parameters"
);
@@clientLocation(NetworkManagers.listActiveSecurityAdminRules, "");
@@clientName(NetworkManagers.listActiveSecurityAdminRules::parameters.body,
  "parameters"
);
@@clientLocation(NetworkManagers.post, "NetworkManagerCommits");
@@clientName(NetworkManagers.post::parameters.body, "parameters");
@@clientLocation(NetworkManagers.networkManagerDeploymentStatusList,
  "NetworkManagerDeploymentStatus"
);
@@clientName(NetworkManagers.networkManagerDeploymentStatusList, "List");
@@clientName(NetworkManagers.networkManagerDeploymentStatusList::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NetworkManager.properties);

@@clientLocation(NetworkManagerConnections.get,
  "SubscriptionNetworkManagerConnections"
);
@@clientLocation(NetworkManagerConnections.createOrUpdate,
  "SubscriptionNetworkManagerConnections"
);
@@clientName(NetworkManagerConnections.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(NetworkManagerConnections.delete,
  "SubscriptionNetworkManagerConnections"
);
@@clientLocation(NetworkManagerConnections.list,
  "SubscriptionNetworkManagerConnections"
);
@@clientName(ManagementGroupNetworkManagerConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NetworkManagerConnection.properties);

@@clientName(ConnectivityConfigurations.createOrUpdate::parameters.resource,
  "connectivityConfiguration"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ConnectivityConfiguration.properties);

@@clientName(NetworkGroups.createOrUpdate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NetworkGroup.properties);

@@clientName(StaticMembers.createOrUpdate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(StaticMember.properties);

@@clientName(NetworkManagerRoutingConfigurations.createOrUpdate::parameters.resource,
  "routingConfiguration"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NetworkManagerRoutingConfiguration.properties);

@@clientName(RoutingRuleCollections.createOrUpdate::parameters.resource,
  "ruleCollection"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RoutingRuleCollection.properties);

@@clientName(RoutingRules.createOrUpdate::parameters.resource, "routingRule");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RoutingRule.properties);

@@clientName(ScopeConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ScopeConnection.properties);

@@clientName(SecurityAdminConfigurations.createOrUpdate::parameters.resource,
  "securityAdminConfiguration"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecurityAdminConfiguration.properties);

@@clientName(AdminRuleCollections.createOrUpdate::parameters.resource,
  "ruleCollection"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AdminRuleCollection.properties);

@@clientLocation(BaseAdminRules.get, "AdminRules");
@@clientLocation(BaseAdminRules.createOrUpdate, "AdminRules");
@@clientName(BaseAdminRules.createOrUpdate::parameters.resource, "adminRule");
@@clientLocation(BaseAdminRules.delete, "AdminRules");
@@clientLocation(BaseAdminRules.list, "AdminRules");

@@clientName(SecurityUserConfigurations.createOrUpdate::parameters.resource,
  "securityUserConfiguration"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecurityUserConfiguration.properties);

@@clientName(SecurityUserRuleCollections.createOrUpdate::parameters.resource,
  "securityUserRuleCollection"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecurityUserRuleCollection.properties);

@@clientName(SecurityUserRules.createOrUpdate::parameters.resource,
  "securityUserRule"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecurityUserRule.properties);

@@clientName(NetworkProfiles.createOrUpdate::parameters.resource, "parameters");
@@clientName(NetworkProfiles.updateTags::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NetworkProfile.properties);

@@clientName(NetworkSecurityPerimeters.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(NetworkSecurityPerimeters.patch::parameters.properties,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NetworkSecurityPerimeter.properties);

@@clientLocation(NspProfiles.get, "NetworkSecurityPerimeterProfiles");
@@clientLocation(NspProfiles.createOrUpdate,
  "NetworkSecurityPerimeterProfiles"
);
@@clientName(NspProfiles.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(NspProfiles.delete, "NetworkSecurityPerimeterProfiles");
@@clientLocation(NspProfiles.list, "NetworkSecurityPerimeterProfiles");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NspProfile.properties);

@@clientLocation(NspAccessRules.get, "NetworkSecurityPerimeterAccessRules");
@@clientLocation(NspAccessRules.createOrUpdate,
  "NetworkSecurityPerimeterAccessRules"
);
@@clientName(NspAccessRules.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(NspAccessRules.delete, "NetworkSecurityPerimeterAccessRules");
@@clientLocation(NspAccessRules.list, "NetworkSecurityPerimeterAccessRules");
@@clientLocation(NspAccessRules.reconcile,
  "NetworkSecurityPerimeterAccessRules"
);
@@clientName(NspAccessRules.reconcile::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NspAccessRule.properties);

@@clientLocation(NspAssociations.get, "NetworkSecurityPerimeterAssociations");
@@clientLocation(NspAssociations.createOrUpdate,
  "NetworkSecurityPerimeterAssociations"
);
@@clientName(NspAssociations.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(NspAssociations.delete,
  "NetworkSecurityPerimeterAssociations"
);
@@clientLocation(NspAssociations.list, "NetworkSecurityPerimeterAssociations");
@@clientLocation(NspAssociations.reconcile,
  "NetworkSecurityPerimeterAssociations"
);
@@clientName(NspAssociations.reconcile::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NspAssociation.properties);

@@clientLocation(NspLinks.get, "NetworkSecurityPerimeterLinks");
@@clientLocation(NspLinks.createOrUpdate, "NetworkSecurityPerimeterLinks");
@@clientName(NspLinks.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(NspLinks.delete, "NetworkSecurityPerimeterLinks");
@@clientLocation(NspLinks.list, "NetworkSecurityPerimeterLinks");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NspLink.properties);

@@clientLocation(NspLinkReferences.get,
  "NetworkSecurityPerimeterLinkReferences"
);
@@clientLocation(NspLinkReferences.delete,
  "NetworkSecurityPerimeterLinkReferences"
);
@@clientLocation(NspLinkReferences.list,
  "NetworkSecurityPerimeterLinkReferences"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NspLinkReference.properties);

@@clientLocation(NspLoggingConfigurations.get,
  "NetworkSecurityPerimeterLoggingConfigurations"
);
@@clientLocation(NspLoggingConfigurations.createOrUpdate,
  "NetworkSecurityPerimeterLoggingConfigurations"
);
@@clientName(NspLoggingConfigurations.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(NspLoggingConfigurations.delete,
  "NetworkSecurityPerimeterLoggingConfigurations"
);
@@clientLocation(NspLoggingConfigurations.list,
  "NetworkSecurityPerimeterLoggingConfigurations"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NspLoggingConfiguration.properties);

@@clientName(ReachabilityAnalysisIntents.create::parameters.resource, "body");

@@clientName(ReachabilityAnalysisRuns.create::parameters.resource, "body");

@@clientName(VerifierWorkspaces.create::parameters.resource, "body");
@@clientName(VerifierWorkspaces.update::parameters.properties, "body");

@@clientName(NetworkVirtualAppliances.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(NetworkVirtualAppliances.updateTags::parameters.properties,
  "parameters"
);
@@clientName(NetworkVirtualAppliances.restart::parameters.body,
  "NetworkVirtualApplianceInstanceIds"
);
@@clientName(NetworkVirtualAppliances.reimage::parameters.body,
  "NetworkVirtualApplianceInstanceIds"
);
@@clientName(NetworkVirtualAppliances.getBootDiagnosticLogs::parameters.body,
  "request"
);
@@clientLocation(NetworkVirtualAppliances.networkVirtualApplianceConnectionsCreateOrUpdate,
  "NetworkVirtualApplianceConnections"
);
@@clientName(NetworkVirtualAppliances.networkVirtualApplianceConnectionsCreateOrUpdate,
  "CreateOrUpdate"
);
@@clientName(NetworkVirtualAppliances.networkVirtualApplianceConnectionsCreateOrUpdate::parameters.body,
  "NetworkVirtualApplianceConnectionParameters"
);
@@clientLocation(NetworkVirtualAppliances.networkVirtualApplianceConnectionsGet,
  "NetworkVirtualApplianceConnections"
);
@@clientName(NetworkVirtualAppliances.networkVirtualApplianceConnectionsGet,
  "Get"
);
@@clientLocation(NetworkVirtualAppliances.networkVirtualApplianceConnectionsDelete,
  "NetworkVirtualApplianceConnections"
);
@@clientName(NetworkVirtualAppliances.networkVirtualApplianceConnectionsDelete,
  "Delete"
);
@@clientLocation(NetworkVirtualAppliances.networkVirtualApplianceConnectionsList,
  "NetworkVirtualApplianceConnections"
);
@@clientName(NetworkVirtualAppliances.networkVirtualApplianceConnectionsList,
  "List"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NetworkVirtualAppliance.properties);

@@clientName(VirtualApplianceSites.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VirtualApplianceSite.properties);

@@clientLocation(NetworkVirtualApplianceSkus.get, "VirtualApplianceSkus");
@@clientLocation(NetworkVirtualApplianceSkus.list, "VirtualApplianceSkus");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NetworkVirtualApplianceSku.properties);

@@clientLocation(InboundSecurityRuleOperationGroup.get, "InboundSecurityRule");
@@clientLocation(InboundSecurityRuleOperationGroup.createOrUpdate,
  "InboundSecurityRule"
);
@@clientName(InboundSecurityRuleOperationGroup.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(InboundSecurityRule.properties);

@@clientName(NetworkWatchers.createOrUpdate::parameters.resource, "parameters");
@@clientName(NetworkWatchers.updateTags::parameters.properties, "parameters");
@@clientName(NetworkWatchers.getTopology::parameters.body, "parameters");
@@clientName(NetworkWatchers.verifyIPFlow::parameters.body, "parameters");
@@clientName(NetworkWatchers.getNextHop::parameters.body, "parameters");
@@clientName(NetworkWatchers.getVMSecurityRules::parameters.body, "parameters");
@@clientName(NetworkWatchers.getTroubleshooting::parameters.body, "parameters");
@@clientName(NetworkWatchers.getTroubleshootingResult::parameters.body,
  "parameters"
);
@@clientName(NetworkWatchers.setFlowLogConfiguration::parameters.body,
  "parameters"
);
@@clientName(NetworkWatchers.getFlowLogStatus::parameters.body, "parameters");
@@clientName(NetworkWatchers.checkConnectivity::parameters.body, "parameters");
@@clientName(NetworkWatchers.getAzureReachabilityReport::parameters.body,
  "parameters"
);
@@clientName(NetworkWatchers.listAvailableProviders::parameters.body,
  "parameters"
);
@@clientName(NetworkWatchers.getNetworkConfigurationDiagnostic::parameters.body,
  "parameters"
);
@@clientLocation(NetworkWatchers.create, "PacketCaptures");
@@clientName(NetworkWatchers.create::parameters.body, "parameters");
@@clientLocation(NetworkWatchers.packetCapturesGet, "PacketCaptures");
@@clientName(NetworkWatchers.packetCapturesGet, "Get");
@@clientLocation(NetworkWatchers.packetCapturesDelete, "PacketCaptures");
@@clientName(NetworkWatchers.packetCapturesDelete, "Delete");
@@clientLocation(NetworkWatchers.stop, "PacketCaptures");
@@clientLocation(NetworkWatchers.getStatus, "PacketCaptures");
@@clientLocation(NetworkWatchers.packetCapturesList, "PacketCaptures");
@@clientName(NetworkWatchers.packetCapturesList, "List");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NetworkWatcher.properties);

@@clientLocation(ConnectionMonitorResults.get, "ConnectionMonitors");
@@clientLocation(ConnectionMonitorResults.createOrUpdate, "ConnectionMonitors");
@@clientName(ConnectionMonitorResults.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ConnectionMonitorResults.updateTags, "ConnectionMonitors");
@@clientName(ConnectionMonitorResults.updateTags::parameters.properties,
  "parameters"
);
@@clientLocation(ConnectionMonitorResults.delete, "ConnectionMonitors");
@@clientLocation(ConnectionMonitorResults.list, "ConnectionMonitors");
@@clientLocation(ConnectionMonitorResults.stop, "ConnectionMonitors");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ConnectionMonitorResult.properties);

@@clientName(PublicIPPrefixes.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(PublicIPPrefixes.updateTags::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PublicIPPrefix.properties);

@@clientName(RouteFilters.createOrUpdate::parameters.resource,
  "routeFilterParameters"
);
@@clientName(RouteFilters.updateTags::parameters.properties, "parameters");
@@clientLocation(RouteFilters.routeFilterRulesDelete, "RouteFilterRules");
@@clientName(RouteFilters.routeFilterRulesDelete, "Delete");
@@clientLocation(RouteFilters.routeFilterRulesGet, "RouteFilterRules");
@@clientName(RouteFilters.routeFilterRulesGet, "Get");
@@clientLocation(RouteFilters.routeFilterRulesCreateOrUpdate,
  "RouteFilterRules"
);
@@clientName(RouteFilters.routeFilterRulesCreateOrUpdate, "CreateOrUpdate");
@@clientName(RouteFilters.routeFilterRulesCreateOrUpdate::parameters.body,
  "routeFilterRuleParameters"
);
@@clientLocation(RouteFilters.listByRouteFilter, "RouteFilterRules");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RouteFilter.properties);

@@clientName(SecurityPartnerProviders.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(SecurityPartnerProviders.updateTags::parameters.properties,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecurityPartnerProvider.properties);

@@clientName(VirtualNetworks.createOrUpdate::parameters.resource, "parameters");
@@clientName(VirtualNetworks.updateTags::parameters.properties, "parameters");
@@clientLocation(EffectiveConfigurations.listNetworkManagerEffectiveConnectivityConfigurations,
  ""
);
@@clientName(EffectiveConfigurations.listNetworkManagerEffectiveConnectivityConfigurations::parameters.body,
  "parameters"
);
@@clientLocation(EffectiveConfigurations.listNetworkManagerEffectiveSecurityAdminRules,
  ""
);
@@clientName(EffectiveConfigurations.listNetworkManagerEffectiveSecurityAdminRules::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VirtualNetwork.properties);

@@clientName(VirtualNetworkPeerings.createOrUpdate::parameters.resource,
  "VirtualNetworkPeeringParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VirtualNetworkPeering.properties);

@@clientName(VirtualNetworkGateways.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(VirtualNetworkGateways.updateTags::parameters.properties,
  "parameters"
);
@@clientName(VirtualNetworkGateways.generatevpnclientpackage::parameters.body,
  "parameters"
);
@@clientName(VirtualNetworkGateways.generateVpnProfile::parameters.body,
  "parameters"
);
@@clientName(VirtualNetworkGateways.setVpnclientIpsecParameters::parameters.body,
  "vpnclientIpsecParams"
);
@@clientName(VirtualNetworkGateways.startPacketCapture::parameters.body,
  "parameters"
);
@@clientName(VirtualNetworkGateways.stopPacketCapture::parameters.body,
  "parameters"
);
@@clientName(VirtualNetworkGateways.stopExpressRouteSiteFailoverSimulation::parameters.body,
  "stopParameters"
);
@@clientName(VirtualNetworkGateways.disconnectVirtualNetworkGatewayVpnConnections::parameters.body,
  "request"
);
@@clientName(VirtualNetworkGateways.invokePrepareMigration::parameters.body,
  "migrationParams"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VirtualNetworkGateway.properties);

@@clientName(VirtualNetworkGatewayNatRules.createOrUpdate::parameters.resource,
  "NatRuleParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VirtualNetworkGatewayNatRule.properties);

@@clientName(VirtualNetworkGatewayConnections.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(VirtualNetworkGatewayConnections.updateTags::parameters.properties,
  "parameters"
);
@@clientLocation(VirtualNetworkGatewayConnections.vpnDeviceConfigurationScript,
  VirtualNetworkGateways
);
@@clientName(VirtualNetworkGatewayConnections.vpnDeviceConfigurationScript::parameters.body,
  "parameters"
);
@@clientName(VirtualNetworkGatewayConnections.setSharedKey::parameters.body,
  "parameters"
);
@@clientName(VirtualNetworkGatewayConnections.resetSharedKey::parameters.body,
  "parameters"
);
@@clientName(VirtualNetworkGatewayConnections.startPacketCapture::parameters.body,
  "parameters"
);
@@clientName(VirtualNetworkGatewayConnections.stopPacketCapture::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VirtualNetworkGatewayConnection.properties);

@@clientName(LocalNetworkGateways.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(LocalNetworkGateways.updateTags::parameters.properties,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LocalNetworkGateway.properties);

@@clientName(VirtualRouters.createOrUpdate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VirtualRouter.properties);

@@clientName(VirtualRouterPeerings.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VirtualRouterPeering.properties);

@@clientLocation(VirtualWANS.get, "VirtualWans");
@@clientLocation(VirtualWANS.createOrUpdate, "VirtualWans");
@@clientName(VirtualWANS.createOrUpdate::parameters.resource, "WANParameters");
@@clientLocation(VirtualWANS.updateTags, "VirtualWans");
@@clientName(VirtualWANS.updateTags::parameters.properties, "WANParameters");
@@clientLocation(VirtualWANS.delete, "VirtualWans");
@@clientLocation(VirtualWANS.listByResourceGroup, "VirtualWans");
@@clientLocation(VirtualWANS.list, "VirtualWans");
@@clientLocation(VirtualWANS.supportedSecurityProviders, "");
@@clientLocation(VirtualWANS.generatevirtualwanvpnserverconfigurationvpnprofile,
  ""
);
@@clientName(VirtualWANS.generatevirtualwanvpnserverconfigurationvpnprofile,
  "generatevirtualwanvpnserverconfigurationvpnprofile"
);
@@clientName(VirtualWANS.generatevirtualwanvpnserverconfigurationvpnprofile::parameters.body,
  "vpnClientParams"
);
@@clientLocation(VirtualWANS.download, "VpnSitesConfiguration");
@@clientName(VirtualWANS.download::parameters.body, "request");
@@clientLocation(VirtualWANS.vpnServerConfigurationsAssociatedWithVirtualWanList,
  "VpnServerConfigurationsAssociatedWithVirtualWan"
);
@@clientName(VirtualWANS.vpnServerConfigurationsAssociatedWithVirtualWanList,
  "List"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VirtualWAN.properties);

@@clientName(VpnSites.createOrUpdate::parameters.resource, "VpnSiteParameters");
@@clientName(VpnSites.updateTags::parameters.properties, "VpnSiteParameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VpnSite.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VpnSiteLink.properties);

@@clientName(VpnServerConfigurations.createOrUpdate::parameters.resource,
  "VpnServerConfigurationParameters"
);
@@clientName(VpnServerConfigurations.updateTags::parameters.properties,
  "VpnServerConfigurationParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VpnServerConfiguration.properties);

@@clientLocation(P2SVpnGateways.get, "P2sVpnGateways");
@@clientLocation(P2SVpnGateways.createOrUpdate, "P2sVpnGateways");
@@clientName(P2SVpnGateways.createOrUpdate::parameters.resource,
  "p2SVpnGatewayParameters"
);
@@clientLocation(P2SVpnGateways.updateTags, "P2sVpnGateways");
@@clientName(P2SVpnGateways.updateTags::parameters.properties,
  "p2SVpnGatewayParameters"
);
@@clientLocation(P2SVpnGateways.delete, "P2sVpnGateways");
@@clientLocation(P2SVpnGateways.listByResourceGroup, "P2sVpnGateways");
@@clientLocation(P2SVpnGateways.list, "P2sVpnGateways");
@@clientLocation(P2SVpnGateways.generateVpnProfile, "P2sVpnGateways");
@@clientName(P2SVpnGateways.generateVpnProfile::parameters.body, "parameters");
@@clientLocation(P2SVpnGateways.getP2sVpnConnectionHealth, "P2sVpnGateways");
@@clientLocation(P2SVpnGateways.getP2sVpnConnectionHealthDetailed,
  "P2sVpnGateways"
);
@@clientName(P2SVpnGateways.getP2sVpnConnectionHealthDetailed::parameters.body,
  "request"
);
@@clientLocation(P2SVpnGateways.disconnectP2sVpnConnections, "P2sVpnGateways");
@@clientName(P2SVpnGateways.disconnectP2sVpnConnections::parameters.body,
  "request"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(P2SVpnGateway.properties);

@@clientLocation(VpnServerConfigurationPolicyGroups.get,
  "ConfigurationPolicyGroups"
);
@@clientLocation(VpnServerConfigurationPolicyGroups.createOrUpdate,
  "ConfigurationPolicyGroups"
);
@@clientName(VpnServerConfigurationPolicyGroups.createOrUpdate::parameters.resource,
  "VpnServerConfigurationPolicyGroupParameters"
);
@@clientLocation(VpnServerConfigurationPolicyGroups.delete,
  "ConfigurationPolicyGroups"
);
@@clientLocation(VpnServerConfigurationPolicyGroups.listByVpnServerConfiguration,
  "configurationPolicyGroups"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VpnServerConfigurationPolicyGroup.properties);

@@clientName(VirtualHubs.createOrUpdate::parameters.resource,
  "virtualHubParameters"
);
@@clientName(VirtualHubs.updateTags::parameters.properties,
  "virtualHubParameters"
);
@@clientName(VirtualHubs.getEffectiveVirtualHubRoutes::parameters.body,
  "effectiveRoutesParameters"
);
@@clientName(VirtualHubs.getInboundRoutes::parameters.body,
  "getInboundRoutesParameters"
);
@@clientName(VirtualHubs.getOutboundRoutes::parameters.body,
  "getOutboundRoutesParameters"
);
@@clientLocation(VirtualHubs.hubVirtualNetworkConnectionsCreateOrUpdate,
  "HubVirtualNetworkConnections"
);
@@clientName(VirtualHubs.hubVirtualNetworkConnectionsCreateOrUpdate,
  "CreateOrUpdate"
);
@@clientName(VirtualHubs.hubVirtualNetworkConnectionsCreateOrUpdate::parameters.body,
  "hubVirtualNetworkConnectionParameters"
);
@@clientLocation(VirtualHubs.hubVirtualNetworkConnectionsDelete,
  "HubVirtualNetworkConnections"
);
@@clientName(VirtualHubs.hubVirtualNetworkConnectionsDelete, "Delete");
@@clientLocation(VirtualHubs.hubVirtualNetworkConnectionsGet,
  "HubVirtualNetworkConnections"
);
@@clientName(VirtualHubs.hubVirtualNetworkConnectionsGet, "Get");
@@clientLocation(VirtualHubs.hubVirtualNetworkConnectionsList,
  "HubVirtualNetworkConnections"
);
@@clientName(VirtualHubs.hubVirtualNetworkConnectionsList, "List");
@@clientLocation(VirtualHubs.virtualHubRouteTableV2sGet,
  "VirtualHubRouteTableV2s"
);
@@clientName(VirtualHubs.virtualHubRouteTableV2sGet, "Get");
@@clientLocation(VirtualHubs.virtualHubRouteTableV2sCreateOrUpdate,
  "VirtualHubRouteTableV2s"
);
@@clientName(VirtualHubs.virtualHubRouteTableV2sCreateOrUpdate,
  "CreateOrUpdate"
);
@@clientName(VirtualHubs.virtualHubRouteTableV2sCreateOrUpdate::parameters.body,
  "virtualHubRouteTableV2Parameters"
);
@@clientLocation(VirtualHubs.virtualHubRouteTableV2sDelete,
  "VirtualHubRouteTableV2s"
);
@@clientName(VirtualHubs.virtualHubRouteTableV2sDelete, "Delete");
@@clientLocation(VirtualHubs.virtualHubRouteTableV2sList,
  "VirtualHubRouteTableV2s"
);
@@clientName(VirtualHubs.virtualHubRouteTableV2sList, "List");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VirtualHub.properties);

@@clientName(RouteMaps.createOrUpdate::parameters.resource,
  "routeMapParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RouteMap.properties);

@@clientName(VpnGateways.createOrUpdate::parameters.resource,
  "vpnGatewayParameters"
);
@@clientName(VpnGateways.updateTags::parameters.properties,
  "vpnGatewayParameters"
);
@@clientName(VpnGateways.startPacketCapture::parameters.body, "parameters");
@@clientName(VpnGateways.stopPacketCapture::parameters.body, "parameters");
@@clientLocation(VpnGateways.vpnConnectionsGet, "VpnConnections");
@@clientName(VpnGateways.vpnConnectionsGet, "Get");
@@clientLocation(VpnGateways.vpnConnectionsCreateOrUpdate, "VpnConnections");
@@clientName(VpnGateways.vpnConnectionsCreateOrUpdate, "CreateOrUpdate");
@@clientName(VpnGateways.vpnConnectionsCreateOrUpdate::parameters.body,
  "VpnConnectionParameters"
);
@@clientLocation(VpnGateways.vpnConnectionsDelete, "VpnConnections");
@@clientName(VpnGateways.vpnConnectionsDelete, "Delete");
@@clientLocation(VpnGateways.vpnConnectionsStartPacketCapture,
  "VpnConnections"
);
@@clientName(VpnGateways.vpnConnectionsStartPacketCapture,
  "StartPacketCapture"
);
@@clientName(VpnGateways.vpnConnectionsStartPacketCapture::parameters.body,
  "parameters"
);
@@clientLocation(VpnGateways.vpnConnectionsStopPacketCapture, "VpnConnections");
@@clientName(VpnGateways.vpnConnectionsStopPacketCapture, "StopPacketCapture");
@@clientName(VpnGateways.vpnConnectionsStopPacketCapture::parameters.body,
  "parameters"
);
@@clientLocation(VpnGateways.listByVpnGateway, "VpnConnections");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VpnGateway.properties);

@@clientLocation(VpnSiteLinkConnections.listByVpnConnection,
  "VpnLinkConnections"
);
@@clientLocation(VpnSiteLinkConnections.resetConnection, "VpnLinkConnections");
@@clientLocation(VpnSiteLinkConnections.getIkeSas, "VpnLinkConnections");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VpnSiteLinkConnection.properties);

@@clientLocation(VpnGatewayNatRules.get, "NatRules");
@@clientLocation(VpnGatewayNatRules.createOrUpdate, "NatRules");
@@clientName(VpnGatewayNatRules.createOrUpdate::parameters.resource,
  "NatRuleParameters"
);
@@clientLocation(VpnGatewayNatRules.delete, "NatRules");
@@clientLocation(VpnGatewayNatRules.listByVpnGateway, "NatRules");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VpnGatewayNatRule.properties);

@@clientLocation(ConnectionSharedKeyResults.getDefaultSharedKey,
  "VpnLinkConnections"
);
@@clientLocation(ConnectionSharedKeyResults.setOrInitDefaultSharedKey,
  "VpnLinkConnections"
);
@@clientName(ConnectionSharedKeyResults.setOrInitDefaultSharedKey::parameters.resource,
  "ConnectionSharedKeyParameters"
);
@@clientLocation(ConnectionSharedKeyResults.getAllSharedKeys,
  "VpnLinkConnections"
);
@@clientLocation(ConnectionSharedKeyResults.listDefaultSharedKey,
  "VpnLinkConnections"
);

@@clientName(ExpressRouteGateways.createOrUpdate::parameters.resource,
  "putExpressRouteGatewayParameters"
);
@@clientName(ExpressRouteGateways.updateTags::parameters.properties,
  "expressRouteGatewayParameters"
);
@@clientLocation(ExpressRouteGateways.expressRouteConnectionsCreateOrUpdate,
  "ExpressRouteConnections"
);
@@clientName(ExpressRouteGateways.expressRouteConnectionsCreateOrUpdate,
  "CreateOrUpdate"
);
@@clientName(ExpressRouteGateways.expressRouteConnectionsCreateOrUpdate::parameters.body,
  "putExpressRouteConnectionParameters"
);
@@clientLocation(ExpressRouteGateways.expressRouteConnectionsGet,
  "ExpressRouteConnections"
);
@@clientName(ExpressRouteGateways.expressRouteConnectionsGet, "Get");
@@clientLocation(ExpressRouteGateways.expressRouteConnectionsDelete,
  "ExpressRouteConnections"
);
@@clientName(ExpressRouteGateways.expressRouteConnectionsDelete, "Delete");
@@clientLocation(ExpressRouteGateways.list, "ExpressRouteConnections");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExpressRouteGateway.properties);

@@clientLocation(BgpConnections.get, "VirtualHubBgpConnection");
@@clientLocation(BgpConnections.createOrUpdate, "VirtualHubBgpConnection");
@@clientName(BgpConnections.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(BgpConnections.delete, "VirtualHubBgpConnection");
@@clientLocation(BgpConnections.list, "VirtualHubBgpConnections");
@@clientLocation(BgpConnections.listLearnedRoutes, "VirtualHubBgpConnections");
@@clientLocation(BgpConnections.listAdvertisedRoutes,
  "VirtualHubBgpConnections"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(BgpConnection.properties);

@@clientLocation(HubIpConfigurations.get, "VirtualHubIpConfiguration");
@@clientLocation(HubIpConfigurations.createOrUpdate,
  "VirtualHubIpConfiguration"
);
@@clientName(HubIpConfigurations.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(HubIpConfigurations.delete, "VirtualHubIpConfiguration");
@@clientLocation(HubIpConfigurations.list, "VirtualHubIpConfiguration");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(HubIpConfiguration.properties);

@@clientName(HubRouteTables.createOrUpdate::parameters.resource,
  "routeTableParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(HubRouteTable.properties);

@@clientLocation(RoutingIntents.get, "RoutingIntent");
@@clientLocation(RoutingIntents.createOrUpdate, "RoutingIntent");
@@clientName(RoutingIntents.createOrUpdate::parameters.resource,
  "routingIntentParameters"
);
@@clientLocation(RoutingIntents.delete, "RoutingIntent");
@@clientLocation(RoutingIntents.list, "RoutingIntent");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RoutingIntent.properties);

@@clientName(WebApplicationFirewallPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(WebApplicationFirewallPolicy.properties);

@@clientLocation(ApplicationGatewaysOperationGroup.listAvailableServerVariables,
  ApplicationGateways
);
@@clientLocation(ApplicationGatewaysOperationGroup.listAvailableRequestHeaders,
  ApplicationGateways
);
@@clientLocation(ApplicationGatewaysOperationGroup.listAvailableResponseHeaders,
  ApplicationGateways
);
@@clientLocation(ApplicationGatewaysOperationGroup.listAvailableWafRuleSets,
  ApplicationGateways
);

@@clientLocation(AvailableDelegationsOperationGroup.list,
  "AvailableDelegations"
);

@@clientLocation(AvailableResourceGroupDelegationsOperationGroup.list,
  "AvailableResourceGroupDelegations"
);

@@clientLocation(AvailableServiceAliasesOperationGroup.list,
  "AvailableServiceAliases"
);
@@clientLocation(AvailableServiceAliasesOperationGroup.listByResourceGroup,
  "AvailableServiceAliases"
);

@@clientLocation(AzureFirewallFqdnTagsOperationGroup.listAll,
  "AzureFirewallFqdnTags"
);

@@clientLocation(NetworkInterfacesOperationGroup.listCloudServiceNetworkInterfaces,
  NetworkInterfaces
);

@@clientLocation(PublicIPAddressesOperationGroup.listCloudServicePublicIPAddresses,
  PublicIPAddresses
);

@@clientLocation(AvailableEndpointServicesOperationGroup.list,
  "AvailableEndpointServices"
);

@@clientLocation(ExpressRouteServiceProvidersOperationGroup.list,
  "ExpressRouteServiceProviders"
);

@@clientLocation(LoadBalancersOperationGroup.swapPublicIpAddresses,
  LoadBalancers
);

@@clientLocation(NetworkSecurityPerimeterAssociableResourceTypesOperationGroup.list,
  "NetworkSecurityPerimeterAssociableResourceTypes"
);

@@clientLocation(NetworkSecurityPerimeterOperationStatusesOperationGroup.get,
  "NetworkSecurityPerimeterOperationStatuses"
);

@@clientLocation(NetworkSecurityPerimeterServiceTagsOperationGroup.list,
  "NetworkSecurityPerimeterServiceTags"
);

@@clientLocation(AvailablePrivateEndpointTypesOperationGroup.list,
  "AvailablePrivateEndpointTypes"
);
@@clientLocation(AvailablePrivateEndpointTypesOperationGroup.listByResourceGroup,
  "AvailablePrivateEndpointTypes"
);

@@clientLocation(PrivateLinkServicesOperationGroup.checkPrivateLinkServiceVisibility,
  PrivateLinkServices
);
@@clientLocation(PrivateLinkServicesOperationGroup.checkPrivateLinkServiceVisibilityByResourceGroup,
  PrivateLinkServices
);
@@clientLocation(PrivateLinkServicesOperationGroup.listAutoApprovedPrivateLinkServices,
  PrivateLinkServices
);
@@clientLocation(PrivateLinkServicesOperationGroup.listAutoApprovedPrivateLinkServicesByResourceGroup,
  PrivateLinkServices
);

@@clientLocation(BgpServiceCommunitiesOperationGroup.list,
  "BgpServiceCommunities"
);

@@clientLocation(ServiceTagsOperationGroup.list, "ServiceTags");

@@clientLocation(ServiceTagInformationOperationGroup.list,
  "ServiceTagInformation"
);

@@clientLocation(UsagesOperationGroup.list, "Usages");
@@clientName(LoadBalancersOperationGroup.swapPublicIpAddresses::parameters.body,
  "parameters"
);
@@clientName(IdpsQueryObject, "IDPSQueryObject");
