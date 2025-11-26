## Swagger Changes

### Changes for `minLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[0].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].put.parameters[0].minLength__deleted` | deleted | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/packetCapture'].post.parameters[0].minLength__deleted` | deleted | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/disassociateCloudServiceReservedPublicIp'].post.parameters[0].minLength__deleted` | deleted | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/reserveCloudServicePublicIpAddress'].post.parameters[0].minLength__deleted` | deleted | `1` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAuthenticationCertificatePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayBackendAddressPoolPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayBackendHttpSettingsPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayBackendSettingsPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayEntraJWTValidationConfigPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayFirewallRuleSetPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.$ref__deleted` | deleted | `./network.json#/definitions/IPAllocationMethod` |
| `definitions.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayFrontendPortPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayHttpListenerPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayIPConfigurationPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayListenerPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayLoadDistributionPolicyPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayPathRulePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayPrivateEndpointConnectionProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayPrivateLinkConfigurationProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayPrivateLinkIpConfigurationProperties.properties.privateIPAllocationMethod.$ref__deleted` | deleted | `./network.json#/definitions/IPAllocationMethod` |
| `definitions.ApplicationGatewayPrivateLinkIpConfigurationProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayProbePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayRewriteRuleSetPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayRoutingRulePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewaySslCertificatePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewaySslProfilePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayTrustedClientCertificatePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayTrustedRootCertificatePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationGatewayUrlPathMapPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ApplicationSecurityGroupPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.AuthorizationPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.AzureFirewallApplicationRuleCollectionPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.AzureFirewallFqdnTagPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.AzureFirewallIPConfigurationPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.AzureFirewallNatRuleCollectionProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.AzureFirewallNetworkRuleCollectionPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.AzureFirewallPropertiesFormat.properties.additionalProperties.$ref__deleted` | deleted | `#/definitions/AzureFirewallAdditionalProperties` |
| `definitions.AzureFirewallPropertiesFormat.properties.ipGroups.$ref__deleted` | deleted | `#/definitions/IpGroups` |
| `definitions.AzureFirewallPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.BastionHostIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.$ref__deleted` | deleted | `./network.json#/definitions/IPAllocationMethod` |
| `definitions.BastionHostIPConfigurationPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.BastionHostPropertiesFormat.properties.networkAcls.$ref__added` | added | `#/definitions/BastionHostPropertiesFormatNetworkAcls` |
| `definitions.BastionHostPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.BgpConnectionProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ConnectionMonitorResultProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ConnectivityConfigurationProperties.properties.connectivityCapabilities.$ref__added` | added | `#/definitions/ConnectivityConfigurationPropertiesConnectivityCapabilities` |
| `definitions.ConnectivityConfigurationProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ConnectivityIssue.properties.context.items.$ref__deleted` | deleted | `#/definitions/IssueContext` |
| `definitions.ConnectivityParameters.properties.preferredIPVersion.$ref__deleted` | deleted | `./network.json#/definitions/IPVersion` |
| `definitions.ContainerNetworkInterfaceConfigurationPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ContainerNetworkInterfaceIpConfigurationPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ContainerNetworkInterfacePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.DdosCustomPolicyPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.DdosDetectionRulePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.DdosProtectionPlanPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.DelegationProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.DscpConfigurationPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.EffectiveNetworkSecurityRule.properties.access.$ref__deleted` | deleted | `./networkSecurityGroup.json#/definitions/SecurityRuleAccess` |
| `definitions.EffectiveNetworkSecurityRule.properties.direction.$ref__deleted` | deleted | `./networkSecurityGroup.json#/definitions/SecurityRuleDirection` |
| `definitions.EffectiveRoute.properties.nextHopType.$ref__deleted` | deleted | `./routeTable.json#/definitions/RouteNextHopType` |
| `definitions.ExpressRouteCircuitConnectionPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ExpressRouteCircuitPeeringPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ExpressRouteCircuitPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ExpressRouteConnectionProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ExpressRouteCrossConnectionPeeringProperties.properties.peeringType.$ref__deleted` | deleted | `./expressRouteCircuit.json#/definitions/ExpressRoutePeeringType` |
| `definitions.ExpressRouteCrossConnectionPeeringProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ExpressRouteCrossConnectionPeeringProperties.properties.state.$ref__deleted` | deleted | `./expressRouteCircuit.json#/definitions/ExpressRoutePeeringState` |
| `definitions.ExpressRouteCrossConnectionProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ExpressRouteCrossConnectionProperties.properties.serviceProviderProvisioningState.$ref__deleted` | deleted | `./expressRouteCircuit.json#/definitions/ServiceProviderProvisioningState` |
| `definitions.ExpressRouteGatewayProperties.properties.autoScaleConfiguration.$ref__added` | added | `#/definitions/ExpressRouteGatewayPropertiesAutoScaleConfiguration` |
| `definitions.ExpressRouteGatewayProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ExpressRouteLinkPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ExpressRoutePortAuthorizationPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ExpressRoutePortsLocationPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ExpressRouteServiceProviderPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.FirewallPolicyDraftProperties.properties.threatIntelMode.$ref__deleted` | deleted | `./azureFirewall.json#/definitions/AzureFirewallThreatIntelMode` |
| `definitions.FirewallPolicyPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.FirewallPolicyPropertiesFormat.properties.threatIntelMode.$ref__deleted` | deleted | `./azureFirewall.json#/definitions/AzureFirewallThreatIntelMode` |
| `definitions.FirewallPolicyRuleCollectionGroupProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.FlowLogPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.privateIPAddressVersion.$ref__deleted` | deleted | `./network.json#/definitions/IPVersion` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.$ref__deleted` | deleted | `./network.json#/definitions/IPAllocationMethod` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.HubIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.$ref__deleted` | deleted | `./network.json#/definitions/IPAllocationMethod` |
| `definitions.HubIPConfigurationPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.HubRouteTableProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.HubVirtualNetworkConnectionProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.IDPSQueryObject.properties.filters.$ref__deleted` | deleted | `#/definitions/Filters` |
| `definitions.InboundNatPoolPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.InboundNatRulePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.InboundSecurityRuleProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.IpAllocationPropertiesFormat.properties.prefixType.$ref__deleted` | deleted | `./network.json#/definitions/IPVersion` |
| `definitions.IpamPoolPrefixAllocation.properties.pool.$ref__added` | added | `#/definitions/IpamPoolPrefixAllocationPool` |
| `definitions.IPConfigurationProfilePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.IPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.$ref__deleted` | deleted | `./network.json#/definitions/IPAllocationMethod` |
| `definitions.IPConfigurationPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.IpGroupPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.LoadBalancerPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.LocalNetworkGatewayPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ManagedServiceIdentity.properties.userAssignedIdentities.additionalProperties.$ref__added` | added | `#/definitions/Components1Jq1T4ISchemasManagedserviceidentityPropertiesUserassignedidentitiesAdditionalproperties` |
| `definitions.NatGatewayPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.NetworkGroupProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.privateIPAddressVersion.$ref__deleted` | deleted | `./network.json#/definitions/IPVersion` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.$ref__deleted` | deleted | `./network.json#/definitions/IPAllocationMethod` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.NetworkInterfacePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.NetworkInterfaceTapConfigurationPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.NetworkManagerConnectionProperties.properties.connectionState.$ref__deleted` | deleted | `./networkManagerScopeConnection.json#/definitions/ConnectionState` |
| `definitions.NetworkManagerProperties.properties.networkManagerScopes.$ref__added` | added | `#/definitions/NetworkManagerPropertiesNetworkManagerScopes` |
| `definitions.NetworkManagerProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.NetworkManagerRoutingConfigurationPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.NetworkProfilePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.NetworkSecurityGroupPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.NetworkSecurityGroupResult.properties.securityRuleAccessResult.$ref__deleted` | deleted | `./networkSecurityGroup.json#/definitions/SecurityRuleAccess` |
| `definitions.NetworkVirtualApplianceConnectionProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.networkProfile.$ref__added` | added | `#/definitions/NetworkVirtualAppliancePropertiesFormatNetworkProfile` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.nvaInterfaceConfigurations.$ref__deleted` | deleted | `#/definitions/NvaInterfaceConfigurations` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.NetworkWatcherPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.OutboundRulePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.P2SConnectionConfigurationProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.P2SVpnGatewayProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.P2SVpnProfileParameters.properties.authenticationMethod.$ref__deleted` | deleted | `./network.json#/definitions/AuthenticationMethod` |
| `definitions.PacketCaptureResultProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.PeerExpressRouteCircuitConnectionPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.PolicySettings.properties.logScrubbing.$ref__added` | added | `#/definitions/PolicySettingsLogScrubbing` |
| `definitions.PrivateDnsZoneGroupPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.PrivateEndpointConnectionProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.PrivateEndpointProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.PrivateLinkServiceConnectionProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.PrivateLinkServiceIpConfigurationProperties.properties.privateIPAddressVersion.$ref__deleted` | deleted | `./network.json#/definitions/IPVersion` |
| `definitions.PrivateLinkServiceIpConfigurationProperties.properties.privateIPAllocationMethod.$ref__deleted` | deleted | `./network.json#/definitions/IPAllocationMethod` |
| `definitions.PrivateLinkServiceIpConfigurationProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.PrivateLinkServiceProperties.properties.autoApproval.$ref__added` | added | `#/definitions/PrivateLinkServicePropertiesAutoApproval` |
| `definitions.PrivateLinkServiceProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.PrivateLinkServiceProperties.properties.visibility.$ref__added` | added | `#/definitions/PrivateLinkServicePropertiesVisibility` |
| `definitions.ProbePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.PublicIPAddressPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.PublicIPAddressPropertiesFormat.properties.publicIPAddressVersion.$ref__deleted` | deleted | `./network.json#/definitions/IPVersion` |
| `definitions.PublicIPAddressPropertiesFormat.properties.publicIPAllocationMethod.$ref__deleted` | deleted | `./network.json#/definitions/IPAllocationMethod` |
| `definitions.PublicIPPrefixPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.PublicIPPrefixPropertiesFormat.properties.publicIPAddressVersion.$ref__deleted` | deleted | `./network.json#/definitions/IPVersion` |
| `definitions.RecordSet.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ResourceNavigationLinkFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.RouteFilterPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.RouteFilterRulePropertiesFormat.properties.access.$ref__deleted` | deleted | `./network.json#/definitions/Access` |
| `definitions.RouteFilterRulePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.RouteMapProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.RoutePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.RouteTablePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.RoutingIntentProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.RoutingRuleCollectionPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.RoutingRulePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.SecurityPartnerProviderPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.SecurityRulePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.SecurityUserConfigurationPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.SecurityUserRuleCollectionPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.SecurityUserRulePropertiesFormat.properties.direction.$ref__deleted` | deleted | `./networkManagerSecurityAdminConfiguration.json#/definitions/SecurityConfigurationRuleDirection` |
| `definitions.SecurityUserRulePropertiesFormat.properties.protocol.$ref__deleted` | deleted | `./networkManagerSecurityAdminConfiguration.json#/definitions/RuleProtocol` |
| `definitions.SecurityUserRulePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ServiceAssociationLinkPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ServiceDelegationPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ServiceEndpointPolicyDefinitionPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ServiceEndpointPolicyPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.ServiceEndpointPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.SharedKeyProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.SignaturesOverrides.properties.properties.$ref__added` | added | `#/definitions/SignaturesOverridesProperties` |
| `definitions.SingleQueryResult.properties.destinationPorts.items.$ref__deleted` | deleted | `#/definitions/PortsList` |
| `definitions.SingleQueryResult.properties.sourcePorts.items.$ref__deleted` | deleted | `#/definitions/PortsList` |
| `definitions.StaticMemberProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.SubnetPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VerificationIPFlowResult.properties.access.$ref__deleted` | deleted | `./network.json#/definitions/Access` |
| `definitions.VirtualApplianceSiteProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VirtualHubProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VirtualHubRouteTableV2Properties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VirtualNetworkGatewayIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.$ref__deleted` | deleted | `./network.json#/definitions/IPAllocationMethod` |
| `definitions.VirtualNetworkGatewayIPConfigurationPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VirtualNetworkGatewayPolicyGroupProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VirtualNetworkPeeringPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VirtualNetworkPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VirtualNetworkTapPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VirtualRouterPeeringProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VirtualRouterPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VirtualWanProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VirtualWanVpnProfileParameters.properties.authenticationMethod.$ref__deleted` | deleted | `./network.json#/definitions/AuthenticationMethod` |
| `definitions.VngClientConnectionConfigurationProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VpnClientParameters.properties.authenticationMethod.$ref__deleted` | deleted | `./network.json#/definitions/AuthenticationMethod` |
| `definitions.VpnClientRevokedCertificatePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VpnClientRootCertificatePropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VpnConnectionProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VpnConnectionProperties.properties.vpnConnectionProtocolType.$ref__deleted` | deleted | `./virtualNetworkGateway.json#/definitions/ConnectionProtocol` |
| `definitions.VpnGatewayNatRuleProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VpnGatewayProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VpnServerConfigurationPolicyGroupProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VpnSiteLinkConnectionProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VpnSiteLinkConnectionProperties.properties.vpnConnectionProtocolType.$ref__deleted` | deleted | `./virtualNetworkGateway.json#/definitions/ConnectionProtocol` |
| `definitions.VpnSiteLinkProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.VpnSiteProperties.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `definitions.WebApplicationFirewallPolicyPropertiesFormat.properties.provisioningState.$ref__deleted` | deleted | `./network.json#/definitions/ProvisioningState` |
| `paths['/providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[1].$ref__deleted` | deleted | `./networkManager.json#/parameters/ListTopParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availablePrivateEndpointTypes'].get.parameters[0].$ref__added` | added | `../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkDnsNameAvailability'].get.parameters[0].$ref__added` | added | `../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.parameters[0].$ref__added` | added | `../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/serviceTags'].get.parameters[0].$ref__added` | added | `../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/setLoadBalancerFrontendPublicIpAddresses'].post.parameters[0].$ref__added` | added | `../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[0].$ref__deleted` | deleted | `./networkManager.json#/parameters/ListTopParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[1].$ref__deleted` | deleted | `./networkManager.json#/parameters/ListSkipTokenParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/getikesas'].post.responses.200.schema.$ref__added` | added | `#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/startPacketCapture'].post.responses.200.schema.$ref__added` | added | `#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/stopPacketCapture'].post.responses.200.schema.$ref__added` | added | `#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/vpndeviceconfigurationscript'].post.responses.200.schema.$ref__added` | added | `#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.parameters[0].$ref__added` | added | `../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[0].$ref__deleted` | deleted | `./networkManager.json#/parameters/NetworkManagerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[1].$ref__deleted` | deleted | `./networkManager.json#/parameters/ListTopParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[2].$ref__deleted` | deleted | `./networkManager.json#/parameters/ListSkipTokenParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}/reconcile'].post.parameters[3].schema.$ref__deleted` | deleted | `#/definitions/NspAccessRuleReconcile` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}/reconcile'].post.responses.200.schema.$ref__deleted` | deleted | `#/definitions/NspAccessRuleReconcile` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}/reconcile'].post.parameters[2].schema.$ref__deleted` | deleted | `#/definitions/NspAssociationReconcile` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}/reconcile'].post.responses.200.schema.$ref__deleted` | deleted | `#/definitions/NspAssociationReconcile` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{hubName}/bgpConnections/{connectionName}/advertisedRoutes'].post.responses.200.schema.$ref__deleted` | deleted | `#/definitions/PeerRouteList` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{hubName}/bgpConnections/{connectionName}/learnedRoutes'].post.responses.200.schema.$ref__deleted` | deleted | `#/definitions/PeerRouteList` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/generatevpnclientpackage'].post.responses.200.schema.$ref__added` | added | `#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/generatevpnprofile'].post.responses.200.schema.$ref__added` | added | `#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getvpnprofilepackageurl'].post.responses.200.schema.$ref__added` | added | `#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startPacketCapture'].post.responses.200.schema.$ref__added` | added | `#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startSiteFailoverTest'].post.responses.200.schema.$ref__added` | added | `#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopPacketCapture'].post.responses.200.schema.$ref__added` | added | `#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopSiteFailoverTest'].post.responses.200.schema.$ref__added` | added | `#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/supportedvpndevices'].post.responses.200.schema.$ref__added` | added | `#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/startpacketcapture'].post.responses.200.schema.$ref__added` | added | `#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/stoppacketcapture'].post.responses.200.schema.$ref__added` | added | `#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}/getikesas'].post.responses.200.schema.$ref__added` | added | `#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{vpnConnectionName}/startpacketcapture'].post.responses.200.schema.$ref__added` | added | `#/definitions/stringApplicationJson` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{vpnConnectionName}/stoppacketcapture'].post.responses.200.schema.$ref__added` | added | `#/definitions/stringApplicationJson` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayPrivateEndpointConnection.properties.name__deleted` | deleted | `{"type":"string","description":"Name of the private endpoint connection on an application gateway."}` |
| `definitions.ApplicationGatewayWafDynamicManifestResult.properties.name__deleted` | deleted | `{"type":"string","description":"Resource name.","readOnly":true}` |
| `definitions.AzureWebCategory.properties.name__deleted` | deleted | `{"type":"string","description":"Resource name.","readOnly":true}` |
| `definitions.BackendAddressPool.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within the set of backend ad...` |
| `definitions.BgpConnection.properties.name__deleted` | deleted | `{"type":"string","description":"Name of the connection."}` |
| `definitions.ConnectionMonitorResult.properties.name__deleted` | deleted | `{"type":"string","description":"Name of the connection monitor.","readOnly":true}` |
| `definitions.ConnectionSharedKeyResult.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.DdosProtectionPlan.properties.name__deleted` | deleted | `{"type":"string","description":"Resource name.","readOnly":true}` |
| `definitions.ExpressRouteCircuitAuthorization.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.ExpressRouteCircuitConnection.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.ExpressRouteCircuitPeering.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.ExpressRoutePortAuthorization.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.ExpressRouteProviderPort.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource","readOnly":true}` |
| `definitions.FirewallPolicyRuleCollectionGroup.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.FirewallPolicyRuleCollectionGroupDraft.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.FrontendIPConfiguration.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within the set of frontend I...` |
| `definitions.HubIpConfiguration.properties.name__deleted` | deleted | `{"type":"string","description":"Name of the Ip Configuration."}` |
| `definitions.HubRouteTable.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.InboundNatRule.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within the set of inbound NA...` |
| `definitions.InboundSecurityRule.properties.name__deleted` | deleted | `{"type":"string","description":"Name of security rule collection."}` |
| `definitions.LoadBalancingRule.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within the set of load balan...` |
| `definitions.NetworkInterfaceIPConfiguration.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.NetworkInterfaceTapConfiguration.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.OutboundRule.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within the set of outbound r...` |
| `definitions.PeerExpressRouteCircuitConnection.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.PrivateEndpointConnection.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.Probe.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within the set of probes use...` |
| `definitions.Route.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.RouteMap.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.RoutingIntent.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.SecurityRule.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.ServiceEndpointPolicyDefinition.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.SignaturesOverrides.properties.name__deleted` | deleted | `{"type":"string","description":"Contains the name of the resource (default)"}` |
| `definitions.Subnet.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.SwapResource.properties.name__deleted` | deleted | `{"type":"string","description":"Resource name.","readOnly":true}` |
| `definitions.VirtualApplianceSite.properties.name__deleted` | deleted | `{"type":"string","description":"Name of the virtual appliance site."}` |
| `definitions.VirtualNetworkGatewayNatRule.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.VirtualNetworkPeering.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.VirtualRouterPeering.properties.name__deleted` | deleted | `{"type":"string","description":"Name of the virtual router peering that is unique within a virtual r...` |
| `definitions.VpnGatewayNatRule.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.VpnServerConfiguration.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.VpnServerConfigurationPolicyGroup.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.VpnSiteLink.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `definitions.VpnSiteLinkConnection.properties.name__deleted` | deleted | `{"type":"string","description":"The name of the resource that is unique within a resource group. Thi...` |
| `paths['/providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[1].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availablePrivateEndpointTypes'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkDnsNameAvailability'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/serviceTags'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/setLoadBalancerFrontendPublicIpAddresses'].post.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[0].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[1].name__added` | added | `$skipToken` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[0].name__added` | added | `networkManagerName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[1].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[2].name__added` | added | `$skipToken` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availablePrivateEndpointTypes'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkDnsNameAvailability'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/serviceTags'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/setLoadBalancerFrontendPublicIpAddresses'].post.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[0].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[2].in__added` | added | `query` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAuthenticationCertificatePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayBackendAddressPoolPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayBackendHttpSettingsPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayBackendSettingsPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayEntraJWTValidationConfigPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayFirewallRuleSetPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.type__added` | added | `string` |
| `definitions.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayFrontendPortPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayHeaderConfiguration.properties.headerValueMatcher.type__deleted` | deleted | `object` |
| `definitions.ApplicationGatewayHttpListenerPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayIPConfigurationPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayListenerPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayLoadDistributionPolicyPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayPathRulePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayPrivateEndpointConnection.properties.type__deleted` | deleted | `{"type":"string","description":"Type of the resource.","readOnly":true}` |
| `definitions.ApplicationGatewayPrivateEndpointConnectionProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayPrivateLinkConfigurationProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayPrivateLinkIpConfigurationProperties.properties.privateIPAllocationMethod.type__added` | added | `string` |
| `definitions.ApplicationGatewayPrivateLinkIpConfigurationProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayProbePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayRewriteRule.properties.actionSet.type__deleted` | deleted | `object` |
| `definitions.ApplicationGatewayRewriteRuleSetPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayRoutingRulePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewaySslCertificatePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewaySslProfilePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayTrustedClientCertificatePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayTrustedRootCertificatePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayUrlPathMapPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ApplicationGatewayWafDynamicManifestResult.properties.type__deleted` | deleted | `{"type":"string","description":"Resource type.","readOnly":true}` |
| `definitions.ApplicationSecurityGroupPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.AuthorizationPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.AzureFirewallApplicationRuleCollectionPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.AzureFirewallFqdnTagPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.AzureFirewallIPConfigurationPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.AzureFirewallNatRuleCollectionProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.AzureFirewallNetworkRuleCollectionPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.AzureFirewallPropertiesFormat.properties.additionalProperties.type__added` | added | `object` |
| `definitions.AzureFirewallPropertiesFormat.properties.ipGroups.type__added` | added | `array` |
| `definitions.AzureFirewallPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.AzureWebCategory.properties.type__deleted` | deleted | `{"type":"string","description":"Resource type.","readOnly":true}` |
| `definitions.BackendAddressPool.properties.type__deleted` | deleted | `{"type":"string","description":"Type of the resource.","readOnly":true}` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.BastionActiveSession.properties.startTime.type__deleted` | deleted | `object` |
| `definitions.BastionHostIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.type__added` | added | `string` |
| `definitions.BastionHostIPConfigurationPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.BastionHostPropertiesFormat.properties.networkAcls.type__deleted` | deleted | `object` |
| `definitions.BastionHostPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.BgpConnection.properties.type__deleted` | deleted | `{"type":"string","description":"Connection type.","readOnly":true}` |
| `definitions.BgpConnectionProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.CommonErrorAdditionalInfo.properties.info.type__deleted` | deleted | `object` |
| `definitions.ConnectionMonitorResult.properties.type__deleted` | deleted | `{"type":"string","description":"Connection monitor type.","readOnly":true}` |
| `definitions.ConnectionMonitorResultProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.ConnectionSharedKeyResult.properties.type__deleted` | deleted | `{"type":"string","description":"Resource type.","readOnly":true}` |
| `definitions.ConnectivityConfigurationProperties.properties.connectivityCapabilities.type__deleted` | deleted | `object` |
| `definitions.ConnectivityConfigurationProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.ConnectivityIssue.properties.context.items.type__added` | added | `object` |
| `definitions.ConnectivityParameters.properties.preferredIPVersion.type__added` | added | `string` |
| `definitions.ContainerNetworkInterfaceConfigurationPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ContainerNetworkInterfaceIpConfigurationPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ContainerNetworkInterfacePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.DdosCustomPolicyPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.DdosDetectionRulePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.DdosProtectionPlan.properties.type__deleted` | deleted | `{"type":"string","description":"Resource type.","readOnly":true}` |
| `definitions.DdosProtectionPlanPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.DelegationProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.DscpConfigurationPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.EffectiveNetworkSecurityRule.properties.access.type__added` | added | `string` |
| `definitions.EffectiveNetworkSecurityRule.properties.direction.type__added` | added | `string` |
| `definitions.EffectiveRoute.properties.nextHopType.type__added` | added | `string` |
| `definitions.ExpressRouteCircuitAuthorization.properties.type__deleted` | deleted | `{"type":"string","description":"Type of the resource.","readOnly":true}` |
| `definitions.ExpressRouteCircuitConnection.properties.type__deleted` | deleted | `{"type":"string","description":"Type of the resource.","readOnly":true}` |
| `definitions.ExpressRouteCircuitConnectionPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ExpressRouteCircuitPeering.properties.type__deleted` | deleted | `{"type":"string","description":"Type of the resource.","readOnly":true}` |
| `definitions.ExpressRouteCircuitPeeringPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ExpressRouteCircuitPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ExpressRouteConnectionProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.ExpressRouteCrossConnectionPeeringProperties.properties.peeringType.type__added` | added | `string` |
| `definitions.ExpressRouteCrossConnectionPeeringProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.ExpressRouteCrossConnectionPeeringProperties.properties.state.type__added` | added | `string` |
| `definitions.ExpressRouteCrossConnectionProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.ExpressRouteCrossConnectionProperties.properties.serviceProviderProvisioningState.type__added` | added | `string` |
| `definitions.ExpressRouteGatewayProperties.properties.autoScaleConfiguration.type__deleted` | deleted | `object` |
| `definitions.ExpressRouteGatewayProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.ExpressRouteLinkPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ExpressRoutePortAuthorization.properties.type__deleted` | deleted | `{"type":"string","description":"Type of the resource.","readOnly":true}` |
| `definitions.ExpressRoutePortAuthorizationPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ExpressRoutePortsLocationPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ExpressRouteProviderPort.properties.type__deleted` | deleted | `{"type":"string","description":"The type of the resource. E.g. \\"Microsoft.Compute/virtualMachines\\"...` |
| `definitions.ExpressRouteServiceProviderPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.FirewallPolicyDraftProperties.properties.threatIntelMode.type__added` | added | `string` |
| `definitions.FirewallPolicyPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.FirewallPolicyPropertiesFormat.properties.threatIntelMode.type__added` | added | `string` |
| `definitions.FirewallPolicyRuleCollectionGroup.properties.type__deleted` | deleted | `{"type":"string","description":"Rule Group type.","readOnly":true}` |
| `definitions.FirewallPolicyRuleCollectionGroupDraft.properties.type__deleted` | deleted | `{"type":"string","description":"Rule Group type.","readOnly":true}` |
| `definitions.FirewallPolicyRuleCollectionGroupProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.FlowLogPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.FrontendIPConfiguration.properties.type__deleted` | deleted | `{"type":"string","description":"Type of the resource.","readOnly":true}` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.privateIPAddressVersion.type__added` | added | `string` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.type__added` | added | `string` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.HubIpConfiguration.properties.type__deleted` | deleted | `{"type":"string","description":"Ipconfiguration type.","readOnly":true}` |
| `definitions.HubIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.type__added` | added | `string` |
| `definitions.HubIPConfigurationPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.HubRouteTable.properties.type__deleted` | deleted | `{"type":"string","description":"Resource type.","readOnly":true}` |
| `definitions.HubRouteTableProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.HubVirtualNetworkConnectionProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.IDPSQueryObject.properties.orderBy.type__deleted` | deleted | `object` |
| `definitions.InboundNatPoolPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.InboundNatRule.properties.type__deleted` | deleted | `{"type":"string","description":"Type of the resource.","readOnly":true}` |
| `definitions.InboundNatRulePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.InboundSecurityRule.properties.type__deleted` | deleted | `{"type":"string","description":"NVA inbound security rule type.","readOnly":true}` |
| `definitions.InboundSecurityRuleProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.IpAllocationPropertiesFormat.properties.prefixType.type__added` | added | `string` |
| `definitions.IpamPoolPrefixAllocation.properties.pool.type__deleted` | deleted | `object` |
| `definitions.IPConfigurationProfilePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.IPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.type__added` | added | `string` |
| `definitions.IPConfigurationPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.IpGroupPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.LoadBalancerPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.LoadBalancingRule.properties.type__deleted` | deleted | `{"type":"string","description":"Type of the resource.","readOnly":true}` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.LocalNetworkGatewayPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ManagedServiceIdentity.properties.userAssignedIdentities.additionalProperties.type__deleted` | deleted | `object` |
| `definitions.NatGatewayPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.NetworkGroupProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.NetworkInterfaceIPConfiguration.properties.type__deleted` | deleted | `{"type":"string","description":"Resource type."}` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.privateIPAddressVersion.type__added` | added | `string` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.type__added` | added | `string` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.NetworkInterfacePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.NetworkInterfaceTapConfiguration.properties.type__deleted` | deleted | `{"type":"string","description":"Sub Resource type.","readOnly":true}` |
| `definitions.NetworkInterfaceTapConfigurationPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.NetworkManagerConnectionProperties.properties.connectionState.type__added` | added | `string` |
| `definitions.NetworkManagerProperties.properties.networkManagerScopes.type__deleted` | deleted | `object` |
| `definitions.NetworkManagerProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.NetworkManagerRoutingConfigurationPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.NetworkProfilePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.NetworkSecurityGroupPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.NetworkSecurityGroupResult.properties.securityRuleAccessResult.type__added` | added | `string` |
| `definitions.NetworkVirtualApplianceConnectionProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.networkProfile.type__deleted` | deleted | `object` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.nvaInterfaceConfigurations.type__added` | added | `array` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.NetworkWatcherPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.OutboundRule.properties.type__deleted` | deleted | `{"type":"string","description":"Type of the resource.","readOnly":true}` |
| `definitions.OutboundRulePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.P2SConnectionConfigurationProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.P2SVpnGatewayProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.P2SVpnProfileParameters.properties.authenticationMethod.type__added` | added | `string` |
| `definitions.PacketCaptureParameters.properties.captureSettings.type__deleted` | deleted | `object` |
| `definitions.PacketCaptureResultProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.PeerExpressRouteCircuitConnection.properties.type__deleted` | deleted | `{"type":"string","description":"Type of the resource.","readOnly":true}` |
| `definitions.PeerExpressRouteCircuitConnectionPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.PolicySettings.properties.logScrubbing.type__deleted` | deleted | `object` |
| `definitions.PrivateDnsZoneGroupPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.PrivateEndpointConnection.properties.type__deleted` | deleted | `{"type":"string","description":"The resource type.","readOnly":true}` |
| `definitions.PrivateEndpointConnectionProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.PrivateEndpointProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.PrivateLinkServiceConnectionProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.PrivateLinkServiceIpConfigurationProperties.properties.privateIPAddressVersion.type__added` | added | `string` |
| `definitions.PrivateLinkServiceIpConfigurationProperties.properties.privateIPAllocationMethod.type__added` | added | `string` |
| `definitions.PrivateLinkServiceIpConfigurationProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.PrivateLinkServiceProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.Probe.properties.type__deleted` | deleted | `{"type":"string","description":"Type of the resource.","readOnly":true}` |
| `definitions.ProbePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.PublicIPAddressPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.PublicIPAddressPropertiesFormat.properties.publicIPAddressVersion.type__added` | added | `string` |
| `definitions.PublicIPAddressPropertiesFormat.properties.publicIPAllocationMethod.type__added` | added | `string` |
| `definitions.PublicIPPrefixPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.PublicIPPrefixPropertiesFormat.properties.publicIPAddressVersion.type__added` | added | `string` |
| `definitions.RecordSet.properties.provisioningState.type__added` | added | `string` |
| `definitions.ResourceNavigationLinkFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.Route.properties.type__deleted` | deleted | `{"type":"string","description":"The type of the resource."}` |
| `definitions.RouteFilterPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.RouteFilterRulePropertiesFormat.properties.access.type__added` | added | `string` |
| `definitions.RouteFilterRulePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.RouteMap.properties.type__deleted` | deleted | `{"type":"string","description":"Resource type.","readOnly":true}` |
| `definitions.RouteMapProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.RoutePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.RouteTablePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.RoutingIntent.properties.type__deleted` | deleted | `{"type":"string","description":"Resource type.","readOnly":true}` |
| `definitions.RoutingIntentProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.RoutingRuleCollectionPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.RoutingRulePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.SecurityPartnerProviderPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.SecurityRule.properties.type__deleted` | deleted | `{"type":"string","description":"The type of the resource."}` |
| `definitions.SecurityRulePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.SecurityUserConfigurationPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.SecurityUserRuleCollectionPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.SecurityUserRulePropertiesFormat.properties.direction.type__added` | added | `string` |
| `definitions.SecurityUserRulePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ServiceAssociationLinkPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ServiceDelegationPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ServiceEndpointPolicyDefinition.properties.type__deleted` | deleted | `{"type":"string","description":"The type of the resource."}` |
| `definitions.ServiceEndpointPolicyDefinitionPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ServiceEndpointPolicyPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.ServiceEndpointPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.SharedKeyProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.SignaturesOverrides.properties.properties.type__deleted` | deleted | `object` |
| `definitions.SignaturesOverrides.properties.type__deleted` | deleted | `{"type":"string","description":"Will contain the type of the resource: Microsoft.Network/firewallPol...` |
| `definitions.SingleQueryResult.properties.destinationPorts.items.type__added` | added | `string` |
| `definitions.SingleQueryResult.properties.sourcePorts.items.type__added` | added | `string` |
| `definitions.StaticMemberProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.Subnet.properties.type__deleted` | deleted | `{"type":"string","description":"Resource type."}` |
| `definitions.SubnetPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.SwapResource.properties.type__deleted` | deleted | `{"type":"string","description":"Resource type.","readOnly":true}` |
| `definitions.VerificationIPFlowResult.properties.access.type__added` | added | `string` |
| `definitions.VirtualApplianceSite.properties.type__deleted` | deleted | `{"type":"string","description":"Site type.","readOnly":true}` |
| `definitions.VirtualApplianceSiteProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.VirtualHubProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.VirtualHubRouteTableV2Properties.properties.provisioningState.type__added` | added | `string` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.VirtualNetworkGatewayIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.type__added` | added | `string` |
| `definitions.VirtualNetworkGatewayIPConfigurationPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.VirtualNetworkGatewayNatRule.properties.type__deleted` | deleted | `{"type":"string","description":"Resource type.","readOnly":true}` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.VirtualNetworkGatewayPolicyGroupProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.VirtualNetworkPeering.properties.type__deleted` | deleted | `{"type":"string","description":"Resource type."}` |
| `definitions.VirtualNetworkPeeringPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.VirtualNetworkPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.VirtualNetworkTapPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.VirtualRouterPeering.properties.type__deleted` | deleted | `{"type":"string","description":"Peering type.","readOnly":true}` |
| `definitions.VirtualRouterPeeringProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.VirtualRouterPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.VirtualWanProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.VirtualWanVpnProfileParameters.properties.authenticationMethod.type__added` | added | `string` |
| `definitions.VM.type__added` | added | `object` |
| `definitions.VngClientConnectionConfigurationProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.VpnClientParameters.properties.authenticationMethod.type__added` | added | `string` |
| `definitions.VpnClientRevokedCertificatePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.VpnClientRootCertificatePropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `definitions.VpnConnectionProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.VpnConnectionProperties.properties.vpnConnectionProtocolType.type__added` | added | `string` |
| `definitions.VpnGatewayNatRule.properties.type__deleted` | deleted | `{"type":"string","description":"Resource type.","readOnly":true}` |
| `definitions.VpnGatewayNatRuleProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.VpnGatewayProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.VpnServerConfigurationPolicyGroup.properties.type__deleted` | deleted | `{"type":"string","description":"Resource type.","readOnly":true}` |
| `definitions.VpnServerConfigurationPolicyGroupProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.VpnSiteLink.properties.type__deleted` | deleted | `{"type":"string","description":"Resource type.","readOnly":true}` |
| `definitions.VpnSiteLinkConnection.properties.type__deleted` | deleted | `{"type":"string","description":"Resource type.","readOnly":true}` |
| `definitions.VpnSiteLinkConnectionProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.VpnSiteLinkConnectionProperties.properties.vpnConnectionProtocolType.type__added` | added | `string` |
| `definitions.VpnSiteLinkProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.VpnSiteProperties.properties.provisioningState.type__added` | added | `string` |
| `definitions.WebApplicationFirewallPolicyPropertiesFormat.properties.provisioningState.type__added` | added | `string` |
| `paths['/providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[1].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availablePrivateEndpointTypes'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkDnsNameAvailability'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/serviceTags'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/setLoadBalancerFrontendPublicIpAddresses'].post.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[0].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/getikesas'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/startPacketCapture'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/stopPacketCapture'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/vpndeviceconfigurationscript'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[1].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[2].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{hubName}/bgpConnections/{connectionName}/advertisedRoutes'].post.responses.200.schema.type__added` | added | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{hubName}/bgpConnections/{connectionName}/learnedRoutes'].post.responses.200.schema.type__added` | added | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/generatevpnclientpackage'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/generatevpnprofile'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getvpnprofilepackageurl'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startPacketCapture'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startSiteFailoverTest'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopPacketCapture'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopSiteFailoverTest'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/supportedvpndevices'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/startpacketcapture'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/stoppacketcapture'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}/getikesas'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{vpnConnectionName}/startpacketcapture'].post.responses.200.schema.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{vpnConnectionName}/stoppacketcapture'].post.responses.200.schema.type__deleted` | deleted | `string` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayRewriteRule.properties.ruleSequence.format__added` | added | `int32` |
| `definitions.BastionActiveSession.properties.sessionDurationInMins.format__added` | added | `float` |
| `definitions.ConnectionMonitorSuccessThreshold.properties.roundTripTimeMs.format__added` | added | `float` |
| `definitions.ExpressRouteCircuitPropertiesFormat.properties.bandwidthInGbps.format__added` | added | `float` |
| `definitions.ExpressRouteConnectionProperties.properties.routingWeight.format__added` | added | `int32` |
| `definitions.ExpressRouteCrossConnectionProperties.properties.sTag.format__added` | added | `int32` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.bandwidthInGbps.format__added` | added | `int32` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.provisionedBandwidthInGbps.format__added` | added | `float` |
| `definitions.ExpressRoutePortsLocationBandwidths.properties.valueInGbps.format__added` | added | `int32` |
| `definitions.IpAllocationPropertiesFormat.properties.prefixLength.format__added` | added | `int32` |
| `definitions.OutboundRulePropertiesFormat.properties.idleTimeoutInMinutes.format__added` | added | `int32` |
| `definitions.RecordSet.properties.ttl.format__added` | added | `int32` |
| `definitions.SingleQueryResult.properties.direction.format__deleted` | deleted | `int32` |
| `definitions.SingleQueryResult.properties.mode.format__deleted` | deleted | `int32` |
| `definitions.SingleQueryResult.properties.severity.format__deleted` | deleted | `int32` |
| `definitions.VirtualNetworkGatewayAutoScaleBounds.properties.max.format__added` | added | `int32` |
| `definitions.VirtualNetworkGatewayAutoScaleBounds.properties.min.format__added` | added | `int32` |
| `definitions.VirtualNetworkTapPropertiesFormat.properties.destinationPort.format__added` | added | `int32` |
| `definitions.WebApplicationFirewallCustomRule.properties.priority.format__added` | added | `int32` |
| `paths['/providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[1].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[0].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}'].delete.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations/{authorizationName}'].delete.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/deploy'].post.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[1].format__added` | added | `int32` |

### Changes for `minimum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAutoscaleConfiguration.properties.minCapacity.minimum__deleted` | deleted | `0` |
| `definitions.ApplicationGatewayWebApplicationFirewallConfiguration.properties.fileUploadLimitInMb.minimum__deleted` | deleted | `0` |
| `definitions.AzureFirewallApplicationRuleProtocol.properties.port.minimum__deleted` | deleted | `0` |
| `definitions.BgpConnectionProperties.properties.peerAsn.minimum__deleted` | deleted | `0` |
| `definitions.BgpPeerStatus.properties.asn.minimum__deleted` | deleted | `0` |
| `definitions.BgpSettings.properties.asn.minimum__deleted` | deleted | `0` |
| `definitions.ConnectionMonitorDestination.properties.port.minimum__deleted` | deleted | `0` |
| `definitions.ConnectionMonitorHttpConfiguration.properties.port.minimum__deleted` | deleted | `0` |
| `definitions.ConnectionMonitorSource.properties.port.minimum__deleted` | deleted | `0` |
| `definitions.ConnectionMonitorTcpConfiguration.properties.port.minimum__deleted` | deleted | `0` |
| `definitions.ConnectivityDestination.properties.port.minimum__deleted` | deleted | `0` |
| `definitions.ConnectivitySource.properties.port.minimum__deleted` | deleted | `0` |
| `definitions.ExplicitProxy.properties.httpPort.minimum__deleted` | deleted | `0` |
| `definitions.ExplicitProxy.properties.httpsPort.minimum__deleted` | deleted | `0` |
| `definitions.ExplicitProxy.properties.pacFilePort.minimum__deleted` | deleted | `0` |
| `definitions.FirewallPolicyRuleApplicationProtocol.properties.port.minimum__deleted` | deleted | `0` |
| `definitions.HopLinkProperties.properties.roundTripTimeAvg.minimum__deleted` | deleted | `0` |
| `definitions.HopLinkProperties.properties.roundTripTimeMax.minimum__deleted` | deleted | `0` |
| `definitions.HopLinkProperties.properties.roundTripTimeMin.minimum__deleted` | deleted | `0` |
| `definitions.InboundSecurityRules.properties.destinationPortRange.minimum__deleted` | deleted | `0` |
| `definitions.NetworkVirtualApplianceConnectionProperties.properties.asn.minimum__deleted` | deleted | `0` |
| `definitions.NetworkVirtualApplianceConnectionProperties.properties.tunnelIdentifier.minimum__deleted` | deleted | `0` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.virtualApplianceAsn.minimum__deleted` | deleted | `0` |
| `definitions.PacketCaptureParameters.properties.bytesToCapturePerPacket.minimum__deleted` | deleted | `0` |
| `definitions.PacketCaptureParameters.properties.timeLimitInSeconds.minimum__deleted` | deleted | `0` |
| `definitions.PacketCaptureParameters.properties.totalBytesPerSession.minimum__deleted` | deleted | `0` |
| `definitions.PacketCaptureSettings.properties.fileCount.minimum__deleted` | deleted | `0` |
| `definitions.PacketCaptureSettings.properties.fileSizeInBytes.minimum__deleted` | deleted | `0` |
| `definitions.PacketCaptureSettings.properties.sessionTimeLimitInSeconds.minimum__deleted` | deleted | `0` |
| `definitions.PolicySettings.properties.customBlockResponseStatusCode.minimum__deleted` | deleted | `0` |
| `definitions.PolicySettings.properties.fileUploadLimitInMb.minimum__deleted` | deleted | `0` |
| `definitions.VirtualHubProperties.properties.virtualRouterAsn.minimum__deleted` | deleted | `0` |
| `definitions.VirtualRouterAutoScaleConfiguration.properties.minCapacity.minimum__deleted` | deleted | `0` |
| `definitions.VirtualRouterPeeringProperties.properties.peerAsn.minimum__deleted` | deleted | `0` |
| `definitions.VirtualRouterPropertiesFormat.properties.virtualRouterAsn.minimum__deleted` | deleted | `0` |
| `paths['/providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[1].minimum__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[0].minimum__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[1].minimum__added` | added | `1` |

### Changes for `maximum`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[1].maximum__added` | added | `20` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[0].maximum__added` | added | `20` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[1].maximum__added` | added | `20` |

### Changes for `parameters`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections/{networkManagerConnectionName}'].parameters__deleted` | deleted | `[{"$ref":"#/parameters/ManagementGroupIdParameter"},{"$ref":"#/parameters/NetworkManagerConnectionNa...` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/networkSecurityPerimeterOperationStatuses/{operationId}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/LocationParamet...` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections/{networkManagerConnectionName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/NetworkManagerC...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/commit'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/connectivityConfigurations/{configurationName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/ApiVersionParameter"},{"$ref":"./network.json#/parameters/Subsc...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/listActiveConnectivityConfigurations'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/ApiVersionParameter"},{"$ref":"./network.json#/parameters/Subsc...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/listActiveSecurityAdminRules'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/ApiVersionParameter"},{"$ref":"./network.json#/parameters/Subsc...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/listDeploymentStatus'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}/staticMembers/{staticMemberName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections/{scopeConnectionName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"./networkManager.json#/param...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/ApiVersionParameter"},{"$ref":"./network.json#/parameters/Subsc...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/ApiVersionParameter"},{"$ref":"./network.json#/parameters/Subsc...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/ApiVersionParameter"},{"$ref":"./network.json#/parameters/Subsc...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/ApiVersionParameter"},{"$ref":"./network.json#/parameters/Subsc...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/linkReferences/{linkReferenceName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links/{linkName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/loggingConfigurations'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/loggingConfigurations/{loggingConfigurationName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}/reconcile'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}/reconcile'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/listNetworkManagerEffectiveConnectivityConfigurations'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/listNetworkManagerEffectiveSecurityAdminRules'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |

### Changes for `x-ms-pageable`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/bgpServiceCommunities'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteProviderPorts'].get['x-ms-pageable__added']` | added | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availablePrivateEndpointTypes'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/listRadiusSecrets'].post['x-ms-pageable__added']` | added | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/resourceNavigationLinks'].get['x-ms-pageable__added']` | added | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/serviceAssociationLinks'].get['x-ms-pageable__added']` | added | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/listRadiusSecrets'].post['x-ms-pageable__added']` | added | `{"nextLinkName":"nextLink"}` |

### Changes for `get`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteServiceProviders'].get__deleted` | deleted | `{"operationId":"ExpressRouteServiceProviders_List","description":"Gets all the available express rou...` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/autoApprovedPrivateLinkServices'].get__deleted` | deleted | `{"operationId":"PrivateLinkServices_ListAutoApprovedPrivateLinkServices","description":"Returns all ...` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availableDelegations'].get__deleted` | deleted | `{"operationId":"AvailableDelegations_List","description":"Gets all of the available subnet delegatio...` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availableServiceAliases'].get__deleted` | deleted | `{"operationId":"AvailableServiceAliases_List","description":"Gets all available service aliases for ...` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/nspServiceTags'].get__deleted` | deleted | `{"operationId":"NetworkSecurityPerimeterServiceTags_List","description":"Gets the list of service ta...` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/perimeterAssociableResourceTypes'].get__deleted` | deleted | `{"operationId":"NetworkSecurityPerimeterAssociableResourceTypes_List","description":"Gets the list o...` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/serviceTagDetails'].get__deleted` | deleted | `{"operationId":"ServiceTagInformation_List","description":"Gets a list of service tag information re...` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/usages'].get__deleted` | deleted | `{"operationId":"Usages_List","description":"List network usages for a subscription.","parameters":[{...` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/virtualNetworkAvailableEndpointServices'].get__deleted` | deleted | `{"operationId":"AvailableEndpointServices_List","description":"List what values of endpoint services...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/autoApprovedPrivateLinkServices'].get__deleted` | deleted | `{"operationId":"PrivateLinkServices_ListAutoApprovedPrivateLinkServicesByResourceGroup","description...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availableDelegations'].get__deleted` | deleted | `{"operationId":"AvailableResourceGroupDelegations_List","description":"Gets all of the available sub...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availablePrivateEndpointTypes'].get__deleted` | deleted | `{"operationId":"AvailablePrivateEndpointTypes_ListByResourceGroup","description":"Returns all of the...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availableServiceAliases'].get__deleted` | deleted | `{"operationId":"AvailableServiceAliases_ListByResourceGroup","description":"Gets all available servi...` |

### Changes for `post`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteServiceProviders'].post__added` | added | `{"operationId":"ExpressRouteServiceProviders_List","description":"Gets all the available express rou...` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/autoApprovedPrivateLinkServices'].post__added` | added | `{"operationId":"PrivateLinkServices_ListAutoApprovedPrivateLinkServices","description":"Returns all ...` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availableDelegations'].post__added` | added | `{"operationId":"AvailableDelegations_List","description":"Gets all of the available subnet delegatio...` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availableServiceAliases'].post__added` | added | `{"operationId":"AvailableServiceAliases_List","description":"Gets all available service aliases for ...` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/nspServiceTags'].post__added` | added | `{"operationId":"NetworkSecurityPerimeterServiceTags_List","description":"Gets the list of service ta...` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/perimeterAssociableResourceTypes'].post__added` | added | `{"operationId":"NetworkSecurityPerimeterAssociableResourceTypes_List","description":"Gets the list o...` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/serviceTagDetails'].post__added` | added | `{"operationId":"ServiceTagInformation_List","description":"Gets a list of service tag information re...` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/usages'].post__added` | added | `{"operationId":"Usages_List","description":"List network usages for a subscription.","parameters":[{...` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/virtualNetworkAvailableEndpointServices'].post__added` | added | `{"operationId":"AvailableEndpointServices_List","description":"List what values of endpoint services...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/autoApprovedPrivateLinkServices'].post__added` | added | `{"operationId":"PrivateLinkServices_ListAutoApprovedPrivateLinkServicesByResourceGroup","description...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availableDelegations'].post__added` | added | `{"operationId":"AvailableResourceGroupDelegations_List","description":"Gets all of the available sub...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availablePrivateEndpointTypes'].post__added` | added | `{"operationId":"AvailablePrivateEndpointTypes_ListByResourceGroup","description":"Returns all of the...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availableServiceAliases'].post__added` | added | `{"operationId":"AvailableServiceAliases_ListByResourceGroup","description":"Gets all available servi...` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdminRule.required__added` | added | `["kind"]` |
| `definitions.AdminRuleCollectionListResult.required__added` | added | `["value"]` |
| `definitions.AdminRuleListResult.required__added` | added | `["value"]` |
| `definitions.ApplicationGatewayAvailableSslPredefinedPolicies.required__added` | added | `["value"]` |
| `definitions.ApplicationGatewayListResult.required__added` | added | `["value"]` |
| `definitions.ApplicationGatewayPrivateEndpointConnectionListResult.required__added` | added | `["value"]` |
| `definitions.ApplicationGatewayPrivateLinkResourceListResult.required__added` | added | `["value"]` |
| `definitions.ApplicationGatewayWafDynamicManifestResultList.required__added` | added | `["value"]` |
| `definitions.ApplicationSecurityGroupListResult.required__added` | added | `["value"]` |
| `definitions.AuthorizationListResult.required__added` | added | `["value"]` |
| `definitions.AutoApprovedPrivateLinkServicesResult.required__added` | added | `["value"]` |
| `definitions.AvailableDelegationsResult.required__added` | added | `["value"]` |
| `definitions.AvailablePrivateEndpointTypesResult.required__added` | added | `["value"]` |
| `definitions.AvailableServiceAliasesResult.required__added` | added | `["value"]` |
| `definitions.AzureFirewallFqdnTagListResult.required__added` | added | `["value"]` |
| `definitions.AzureFirewallListResult.required__added` | added | `["value"]` |
| `definitions.AzureWebCategoryListResult.required__added` | added | `["value"]` |
| `definitions.BastionActiveSessionListResult.required__added` | added | `["value"]` |
| `definitions.BastionHostListResult.required__added` | added | `["value"]` |
| `definitions.BastionSessionDeleteResult.required__added` | added | `["value"]` |
| `definitions.BastionShareableLinkListResult.required__added` | added | `["value"]` |
| `definitions.BgpServiceCommunityListResult.required__added` | added | `["value"]` |
| `definitions.ConnectionSharedKeyResultList.required__added` | added | `["value"]` |
| `definitions.ConnectivityConfigurationListResult.required__added` | added | `["value"]` |
| `definitions.ConnectivityConfigurationProperties.properties.connectivityCapabilities.required__deleted` | deleted | `["connectedGroupPrivateEndpointsScale","connectedGroupAddressOverlap","peeringEnforcement"]` |
| `definitions.CustomIpPrefixListResult.required__added` | added | `["value"]` |
| `definitions.DdosProtectionPlanListResult.required__added` | added | `["value"]` |
| `definitions.DefaultAdminRule.required__added` | added | `["kind"]` |
| `definitions.DscpConfigurationListResult.required__added` | added | `["value"]` |
| `definitions.EffectiveNetworkSecurityGroupListResult.required__added` | added | `["value"]` |
| `definitions.EffectiveRouteListResult.required__added` | added | `["value"]` |
| `definitions.EndpointServicesListResult.required__added` | added | `["value"]` |
| `definitions.ExpressRouteCircuitConnectionListResult.required__added` | added | `["value"]` |
| `definitions.ExpressRouteCircuitListResult.required__added` | added | `["value"]` |
| `definitions.ExpressRouteCircuitPeeringListResult.required__added` | added | `["value"]` |
| `definitions.ExpressRouteCircuitsArpTableListResult.required__added` | added | `["value"]` |
| `definitions.ExpressRouteCircuitsRoutesTableListResult.required__added` | added | `["value"]` |
| `definitions.ExpressRouteCircuitsRoutesTableSummaryListResult.required__added` | added | `["value"]` |
| `definitions.ExpressRouteCrossConnectionListResult.required__added` | added | `["value"]` |
| `definitions.ExpressRouteCrossConnectionPeeringList.required__added` | added | `["value"]` |
| `definitions.ExpressRouteCrossConnectionsRoutesTableSummaryListResult.required__added` | added | `["value"]` |
| `definitions.ExpressRouteLinkListResult.required__added` | added | `["value"]` |
| `definitions.ExpressRoutePortAuthorizationListResult.required__added` | added | `["value"]` |
| `definitions.ExpressRoutePortListResult.required__added` | added | `["value"]` |
| `definitions.ExpressRoutePortsLocationListResult.required__added` | added | `["value"]` |
| `definitions.ExpressRouteProviderPortListResult.required__added` | added | `["value"]` |
| `definitions.ExpressRouteServiceProviderListResult.required__added` | added | `["value"]` |
| `definitions.FirewallPolicyListResult.required__added` | added | `["value"]` |
| `definitions.FirewallPolicyRuleCollectionGroupListResult.required__added` | added | `["value"]` |
| `definitions.FlowLogListResult.required__added` | added | `["value"]` |
| `definitions.InboundNatRuleListResult.required__added` | added | `["value"]` |
| `definitions.IpAllocationListResult.required__added` | added | `["value"]` |
| `definitions.IpamPoolList.required__added` | added | `["value"]` |
| `definitions.IpGroupListResult.required__added` | added | `["value"]` |
| `definitions.ListHubRouteTablesResult.required__added` | added | `["value"]` |
| `definitions.ListHubVirtualNetworkConnectionsResult.required__added` | added | `["value"]` |
| `definitions.ListP2SVpnGatewaysResult.required__added` | added | `["value"]` |
| `definitions.ListRouteMapsResult.required__added` | added | `["value"]` |
| `definitions.ListRoutingIntentResult.required__added` | added | `["value"]` |
| `definitions.ListVirtualHubBgpConnectionResults.required__added` | added | `["value"]` |
| `definitions.ListVirtualHubIpConfigurationResults.required__added` | added | `["value"]` |
| `definitions.ListVirtualHubsResult.required__added` | added | `["value"]` |
| `definitions.ListVirtualNetworkGatewayNatRulesResult.required__added` | added | `["value"]` |
| `definitions.ListVirtualWANsResult.required__added` | added | `["value"]` |
| `definitions.ListVpnConnectionsResult.required__added` | added | `["value"]` |
| `definitions.ListVpnGatewayNatRulesResult.required__added` | added | `["value"]` |
| `definitions.ListVpnGatewaysResult.required__added` | added | `["value"]` |
| `definitions.ListVpnServerConfigurationPolicyGroupsResult.required__added` | added | `["value"]` |
| `definitions.ListVpnServerConfigurationsResult.required__added` | added | `["value"]` |
| `definitions.ListVpnSiteLinkConnectionsResult.required__added` | added | `["value"]` |
| `definitions.ListVpnSiteLinksResult.required__added` | added | `["value"]` |
| `definitions.ListVpnSitesResult.required__added` | added | `["value"]` |
| `definitions.LoadBalancerFrontendIPConfigurationListResult.required__added` | added | `["value"]` |
| `definitions.LoadBalancerListResult.required__added` | added | `["value"]` |
| `definitions.LoadBalancerLoadBalancingRuleListResult.required__added` | added | `["value"]` |
| `definitions.LoadBalancerOutboundRuleListResult.required__added` | added | `["value"]` |
| `definitions.LoadBalancerProbeListResult.required__added` | added | `["value"]` |
| `definitions.LocalNetworkGatewayListResult.required__added` | added | `["value"]` |
| `definitions.NatGatewayListResult.required__added` | added | `["value"]` |
| `definitions.NetworkGroupListResult.required__added` | added | `["value"]` |
| `definitions.NetworkInterfaceIPConfigurationListResult.required__added` | added | `["value"]` |
| `definitions.NetworkInterfaceListResult.required__added` | added | `["value"]` |
| `definitions.NetworkInterfaceTapConfigurationListResult.required__added` | added | `["value"]` |
| `definitions.NetworkManagerConnectionListResult.required__added` | added | `["value"]` |
| `definitions.NetworkManagerListResult.required__added` | added | `["value"]` |
| `definitions.NetworkManagerRoutingConfigurationListResult.required__added` | added | `["value"]` |
| `definitions.NetworkProfileListResult.required__added` | added | `["value"]` |
| `definitions.NetworkSecurityGroupListResult.required__added` | added | `["value"]` |
| `definitions.NetworkSecurityPerimeterListResult.required__added` | added | `["value"]` |
| `definitions.NetworkVirtualApplianceConnectionList.required__added` | added | `["value"]` |
| `definitions.NetworkVirtualApplianceListResult.required__added` | added | `["value"]` |
| `definitions.NetworkVirtualApplianceSkuListResult.required__added` | added | `["value"]` |
| `definitions.NspAccessRuleListResult.required__added` | added | `["value"]` |
| `definitions.NspLinkListResult.required__added` | added | `["value"]` |
| `definitions.NspLinkReferenceListResult.required__added` | added | `["value"]` |
| `definitions.NspLoggingConfigurationListResult.required__added` | added | `["value"]` |
| `definitions.NspProfileListResult.required__added` | added | `["value"]` |
| `definitions.NspServiceTagsListResult.required__added` | added | `["value"]` |
| `definitions.P2SVpnGateway.required__deleted` | deleted | `["location"]` |
| `definitions.PeerExpressRouteCircuitConnectionListResult.required__added` | added | `["value"]` |
| `definitions.PerimeterAssociableResourcesListResult.required__added` | added | `["value"]` |
| `definitions.PoolAssociationList.required__added` | added | `["value"]` |
| `definitions.PrivateDnsZoneGroupListResult.required__added` | added | `["value"]` |
| `definitions.PrivateEndpointConnectionListResult.required__added` | added | `["value"]` |
| `definitions.PrivateEndpointListResult.required__added` | added | `["value"]` |
| `definitions.PrivateLinkServiceListResult.required__added` | added | `["value"]` |
| `definitions.PublicIPAddressListResult.required__added` | added | `["value"]` |
| `definitions.PublicIPPrefixListResult.required__added` | added | `["value"]` |
| `definitions.RadiusAuthServerListResult.required__added` | added | `["value"]` |
| `definitions.ReachabilityAnalysisIntentListResult.required__added` | added | `["value"]` |
| `definitions.ReachabilityAnalysisRunListResult.required__added` | added | `["value"]` |
| `definitions.RouteFilter.required__deleted` | deleted | `["location"]` |
| `definitions.RouteFilterListResult.required__added` | added | `["value"]` |
| `definitions.RouteFilterRuleListResult.required__added` | added | `["value"]` |
| `definitions.RouteListResult.required__added` | added | `["value"]` |
| `definitions.RouteTableListResult.required__added` | added | `["value"]` |
| `definitions.RoutingRuleCollectionListResult.required__added` | added | `["value"]` |
| `definitions.RoutingRuleListResult.required__added` | added | `["value"]` |
| `definitions.ScopeConnectionListResult.required__added` | added | `["value"]` |
| `definitions.SecurityAdminConfigurationListResult.required__added` | added | `["value"]` |
| `definitions.SecurityPartnerProviderListResult.required__added` | added | `["value"]` |
| `definitions.SecurityRuleListResult.required__added` | added | `["value"]` |
| `definitions.SecurityUserConfigurationListResult.required__added` | added | `["value"]` |
| `definitions.SecurityUserRuleCollectionListResult.required__added` | added | `["value"]` |
| `definitions.SecurityUserRuleListResult.required__added` | added | `["value"]` |
| `definitions.ServiceEndpointPolicyDefinitionListResult.required__added` | added | `["value"]` |
| `definitions.ServiceEndpointPolicyListResult.required__added` | added | `["value"]` |
| `definitions.ServiceTagInformationListResult.required__added` | added | `["value"]` |
| `definitions.StaticCidrList.required__added` | added | `["value"]` |
| `definitions.StaticMemberListResult.required__added` | added | `["value"]` |
| `definitions.SubnetListResult.required__added` | added | `["value"]` |
| `definitions.UsagesListResult.required__added` | added | `["value"]` |
| `definitions.VerifierWorkspaceListResult.required__added` | added | `["value"]` |
| `definitions.VirtualHub.required__deleted` | deleted | `["location"]` |
| `definitions.VirtualNetworkDdosProtectionStatusResult.required__added` | added | `["value"]` |
| `definitions.VirtualNetworkGatewayConnectionListResult.required__added` | added | `["value"]` |
| `definitions.VirtualNetworkGatewayListConnectionsResult.required__added` | added | `["value"]` |
| `definitions.VirtualNetworkGatewayListResult.required__added` | added | `["value"]` |
| `definitions.VirtualNetworkListResult.required__added` | added | `["value"]` |
| `definitions.VirtualNetworkListUsageResult.required__added` | added | `["value"]` |
| `definitions.VirtualNetworkPeeringListResult.required__added` | added | `["value"]` |
| `definitions.VirtualNetworkTapListResult.required__added` | added | `["value"]` |
| `definitions.VirtualRouterListResult.required__added` | added | `["value"]` |
| `definitions.VirtualRouterPeeringListResult.required__added` | added | `["value"]` |
| `definitions.VirtualWAN.required__deleted` | deleted | `["location"]` |
| `definitions.VpnGateway.required__deleted` | deleted | `["location"]` |
| `definitions.VpnSite.required__deleted` | deleted | `["location"]` |
| `definitions.WebApplicationFirewallPolicyListResult.required__added` | added | `["value"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availablePrivateEndpointTypes'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkDnsNameAvailability'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/serviceTags'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/setLoadBalancerFrontendPublicIpAddresses'].post.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[0].required__added` | added | `true` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/setLoadBalancerFrontendPublicIpAddresses'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Compute/cloudServices/{resourceName}/providers/microsoft.Network/cloudServiceSlots/{singletonResource}'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendPoolName}/queryInboundNatRulePortMapping'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/backendhealth'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/getBackendHealthOnDemand'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/privateEndpointConnections/{connectionName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/privateEndpointConnections/{connectionName}'].put.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/start'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/stop'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/{policyName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationSecurityGroups/{applicationSecurityGroupName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationSecurityGroups/{applicationSecurityGroupName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].patch.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/learnedIPPrefixes'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}'].patch.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}/createShareableLinks'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}/deleteShareableLinks'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}/getActiveSessions'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}'].patch.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/getikesas'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/resetconnection'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/sharedkey'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/sharedkey/reset'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/startPacketCapture'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/stopPacketCapture'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/customIpPrefixes/{customIpPrefixName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/customIpPrefixes/{customIpPrefixName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosCustomPolicies/{ddosCustomPolicyName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosProtectionPlans/{ddosProtectionPlanName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/dscpConfigurations/{dscpConfigurationName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/dscpConfigurations/{dscpConfigurationName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/authorizations/{authorizationName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/authorizations/{authorizationName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/arpTables/{devicePath}'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/connections/{connectionName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/connections/{connectionName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/routeTables/{devicePath}'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/routeTablesSummary/{devicePath}'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}'].put.responses.200.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/arpTables/{devicePath}'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/routeTables/{devicePath}'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/routeTablesSummary/{devicePath}'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}'].patch.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections/{connectionName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations/{authorizationName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/ruleCollectionGroups/{ruleCollectionGroupName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/ruleCollectionGroups/{ruleCollectionGroupName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipAllocations/{ipAllocationName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipGroups/{ipGroupsName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipGroups/{ipGroupsName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendAddressPoolName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendAddressPoolName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways/{localNetworkGatewayName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways/{localNetworkGatewayName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/natGateways/{natGatewayName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/natGateways/{natGatewayName}'].put.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/effectiveNetworkSecurityGroups'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/effectiveRouteTable'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/tapConfigurations/{tapConfigurationName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/tapConfigurations/{tapConfigurationName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkProfiles/{networkProfileName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/securityRules/{securityRuleName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/securityRules/{securityRuleName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/inboundSecurityRules/{ruleCollectionName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/virtualApplianceSites/{siteName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/virtualApplianceSites/{siteName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/availableProvidersList'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/azureReachabilityReport'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/configureFlowLog'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}/stop'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectivityCheck'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs/{flowLogName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs/{flowLogName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/ipFlowVerify'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/networkConfigurationDiagnostic'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/nextHop'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}/queryStatus'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}/stop'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/queryFlowLogStatus'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/queryTroubleshootResult'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/securityGroupView'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/troubleshoot'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}'].patch.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}/generatevpnprofile'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}/getP2sVpnConnectionHealth'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}/getP2sVpnConnectionHealthDetailed'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}/reset'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{p2sVpnGatewayName}/disconnectP2sVpnConnections'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices/{serviceName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices/{serviceName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices/{serviceName}/privateEndpointConnections/{peConnectionName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPPrefixes/{publicIpPrefixName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPPrefixes/{publicIpPrefixName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}/routes/{routeName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}/routes/{routeName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/securityPartnerProviders/{securityPartnerProviderName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/securityPartnerProviders/{securityPartnerProviderName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions/{serviceEndpointPolicyDefinitionName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions/{serviceEndpointPolicyDefinitionName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{hubName}/bgpConnections/{connectionName}/advertisedRoutes'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{hubName}/bgpConnections/{connectionName}/learnedRoutes'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/bgpConnections/{connectionName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/bgpConnections/{connectionName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/effectiveRoutes'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubRouteTables/{routeTableName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubRouteTables/{routeTableName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/inboundRoutes'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/ipConfigurations/{ipConfigName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/ipConfigurations/{ipConfigName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/outboundRoutes'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeMaps/{routeMapName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeMaps/{routeMapName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routingIntent/{routingIntentName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routingIntent/{routingIntentName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].patch.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/disconnectVirtualNetworkGatewayVpnConnections'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/generatevpnclientpackage'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/generatevpnprofile'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getAdvertisedRoutes'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getBgpPeerStatus'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getLearnedRoutes'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getVpnClientConnectionHealth'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getvpnprofilepackageurl'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules/{natRuleName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules/{natRuleName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/reset'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/resetvpnclientsharedkey'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/setvpnclientipsecparameters'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startPacketCapture'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopPacketCapture'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/ddosProtectionStatus'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/prepareNetworkPolicies'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/unprepareNetworkPolicies'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/virtualNetworkPeerings/{virtualNetworkPeeringName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/virtualNetworkPeerings/{virtualNetworkPeeringName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}/peerings/{peeringName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}/peerings/{peeringName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{VirtualWANName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{VirtualWANName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{virtualWANName}/generateVpnProfile'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{virtualWANName}/vpnConfiguration'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{virtualWANName}/vpnServerConfigurations'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}'].patch.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/natRules/{natRuleName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/natRules/{natRuleName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/reset'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/startpacketcapture'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/stoppacketcapture'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}/getikesas'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}/resetconnection'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}/sharedKeys/default'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{vpnConnectionName}/startpacketcapture'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{vpnConnectionName}/stoppacketcapture'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/configurationPolicyGroups/{configurationPolicyGroupName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/configurationPolicyGroups/{configurationPolicyGroupName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnSites/{vpnSiteName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnSites/{vpnSiteName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ApplicationGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/privateEndpointConnections/{connectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ApplicationGatewayPrivateEndpointConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationSecurityGroups/{applicationSecurityGroupName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ApplicationSecurityGroup` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/AzureFirewall` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/AzureFirewall` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/BastionHost` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/BastionHost` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualNetworkGatewayConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualNetworkGatewayConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosCustomPolicies/{ddosCustomPolicyName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/DdosCustomPolicy` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosProtectionPlans/{ddosProtectionPlanName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/DdosProtectionPlan` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ExpressRouteCircuit` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/authorizations/{authorizationName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ExpressRouteCircuitAuthorization` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ExpressRouteCircuitPeering` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/connections/{connectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ExpressRouteCircuitConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ExpressRouteCrossConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ExpressRouteCrossConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ExpressRouteGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ExpressRouteGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections/{connectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ExpressRouteGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ExpressRoutePort` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations/{authorizationName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ExpressRoutePortAuthorization` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/FirewallPolicy` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/ruleCollectionGroups/{ruleCollectionGroupName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/FirewallPolicyRuleCollectionGroup` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipAllocations/{ipAllocationName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/IpAllocation` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipGroups/{ipGroupsName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/IpGroup` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/LoadBalancer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendAddressPoolName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/BackendAddressPool` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/InboundNatRule` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways/{localNetworkGatewayName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/LocalNetworkGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/natGateways/{natGatewayName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/NatGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/NetworkInterface` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/tapConfigurations/{tapConfigurationName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/NetworkInterfaceTapConfiguration` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/IpamPool` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/NetworkSecurityGroup` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/securityRules/{securityRuleName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/SecurityRule` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/NetworkVirtualAppliance` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/inboundSecurityRules/{ruleCollectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/InboundSecurityRule` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/networkVirtualApplianceConnections/{connectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/NetworkVirtualAppliance` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/virtualApplianceSites/{siteName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualApplianceSite` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ConnectionMonitorResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs/{flowLogName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/FlowLog` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/NetworkWatcher` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/P2SVpnGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/P2SVpnGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/PrivateEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups/{privateDnsZoneGroupName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/PrivateEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices/{serviceName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/PrivateLinkService` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/PublicIPAddress` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/RouteFilter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/RouteFilter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/RouteTable` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}/routes/{routeName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Route` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/securityPartnerProviders/{securityPartnerProviderName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/SecurityPartnerProvider` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ServiceEndpointPolicy` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions/{serviceEndpointPolicyDefinitionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ServiceEndpointPolicyDefinition` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualHub` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/bgpConnections/{connectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/BgpConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubRouteTables/{routeTableName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/HubRouteTable` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections/{connectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualHub` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/ipConfigurations/{ipConfigName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/HubIpConfiguration` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeMaps/{routeMapName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/RouteMap` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeTables/{routeTableName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualHub` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routingIntent/{routingIntentName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/RoutingIntent` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualNetworkGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualNetworkGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules/{natRuleName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualNetworkGatewayNatRule` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualNetwork` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Subnet` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/virtualNetworkPeerings/{virtualNetworkPeeringName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualNetworkPeering` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualNetworkTap` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualRouter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}/peerings/{peeringName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualRouterPeering` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{VirtualWANName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualWAN` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VpnGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VpnGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/natRules/{natRuleName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VpnGatewayNatRule` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VpnGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}/sharedKeys/default'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ConnectionSharedKeyResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VpnServerConfiguration` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/configurationPolicyGroups/{configurationPolicyGroupName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VpnServerConfigurationPolicyGroup` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnSites/{vpnSiteName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VpnSite` |

### Changes for `maxLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].put.parameters[0].maxLength__deleted` | deleted | `56` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/packetCapture'].post.parameters[0].maxLength__deleted` | deleted | `56` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/disassociateCloudServiceReservedPublicIp'].post.parameters[0].maxLength__deleted` | deleted | `80` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/reserveCloudServicePublicIpAddress'].post.parameters[0].maxLength__deleted` | deleted | `80` |

### Changes for `pattern`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/packetCapture'].post.parameters[0].pattern__deleted` | deleted | `^[a-zA-Z0-9]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/packetCaptureOperation'].post.parameters[0].pattern__deleted` | deleted | `^[A-Za-z0-9][\\w\\-._]{0,54}[A-Za-z0-9_]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/deploy'].post.parameters[0].pattern__deleted` | deleted | `^[^_\\W][\\w-._]{0,79}(?<![-.])$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/firewallPolicyDrafts/default'].delete.parameters[0].pattern__deleted` | deleted | `^[^_\\W][\\w-._]{0,79}(?<![-.])$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/firewallPolicyDrafts/default'].get.parameters[0].pattern__deleted` | deleted | `^[^_\\W][\\w-._]{0,79}(?<![-.])$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/firewallPolicyDrafts/default'].put.parameters[0].pattern__deleted` | deleted | `^[^_\\W][\\w-._]{0,79}(?<![-.])$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/ruleCollectionGroups/{ruleCollectionGroupName}/ruleCollectionGroupDrafts/default'].delete.parameters[0].pattern__deleted` | deleted | `^[^_\\W][\\w-._]{0,79}(?<![-.])$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/ruleCollectionGroups/{ruleCollectionGroupName}/ruleCollectionGroupDrafts/default'].delete.parameters[1].pattern__deleted` | deleted | `^[^_\\W][\\w-._]{0,79}(?<![-.])$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/ruleCollectionGroups/{ruleCollectionGroupName}/ruleCollectionGroupDrafts/default'].get.parameters[0].pattern__deleted` | deleted | `^[^_\\W][\\w-._]{0,79}(?<![-.])$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/ruleCollectionGroups/{ruleCollectionGroupName}/ruleCollectionGroupDrafts/default'].get.parameters[1].pattern__deleted` | deleted | `^[^_\\W][\\w-._]{0,79}(?<![-.])$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/ruleCollectionGroups/{ruleCollectionGroupName}/ruleCollectionGroupDrafts/default'].put.parameters[0].pattern__deleted` | deleted | `^[^_\\W][\\w-._]{0,79}(?<![-.])$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/ruleCollectionGroups/{ruleCollectionGroupName}/ruleCollectionGroupDrafts/default'].put.parameters[1].pattern__deleted` | deleted | `^[^_\\W][\\w-._]{0,79}(?<![-.])$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[0].pattern__added` | added | `^[0-9a-zA-Z]([0-9a-zA-Z_.-]{0,62}[0-9a-zA-Z_])?$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/getBootDiagnosticLogs'].post.parameters[0].pattern__deleted` | deleted | `^[A-Za-z0-9_]+` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/networkVirtualApplianceConnections'].get.parameters[0].pattern__deleted` | deleted | `^[A-Za-z0-9_]+` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/networkVirtualApplianceConnections/{connectionName}'].put.parameters[0].pattern__deleted` | deleted | `^[A-Za-z0-9_]+` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/networkVirtualApplianceConnections/{connectionName}'].put.parameters[1].pattern__deleted` | deleted | `^[A-Za-z0-9_]+` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/reimage'].post.parameters[0].pattern__deleted` | deleted | `^[A-Za-z0-9_]+` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/disassociateCloudServiceReservedPublicIp'].post.parameters[0].pattern__deleted` | deleted | `^[A-Za-z0-9][A-Za-z0-9_\\.-]*[A-Za-z0-9_]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/reserveCloudServicePublicIpAddress'].post.parameters[0].pattern__deleted` | deleted | `^[A-Za-z0-9][A-Za-z0-9_\\.-]*[A-Za-z0-9_]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/listRadiusSecrets'].post.parameters[0].pattern__deleted` | deleted | `^[A-Za-z0-9_]+` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActiveConfigurationParameter.properties.regions.items.description__deleted` | deleted | `region Name.` |
| `definitions.AdminPropertiesFormat.properties.destinationPortRanges.items.description__deleted` | deleted | `The destination port.` |
| `definitions.AdminPropertiesFormat.properties.sourcePortRanges.items.description__deleted` | deleted | `The source port.` |
| `definitions.DefaultAdminPropertiesFormat.properties.destinationPortRanges.items.description__deleted` | deleted | `The destination port.` |
| `definitions.DefaultAdminPropertiesFormat.properties.sourcePortRanges.items.description__deleted` | deleted | `The source port.` |
| `definitions.DelegationProperties.properties.provisioningState.description__added` | added | `Provisioning states of a resource.` |
| `definitions.FilterItems.properties.values.items.description__deleted` | deleted | `Value of the field to filter by` |
| `definitions.IpamPool.properties.properties.description__added` | added | `Properties of IpamPool resource properties which are specific to the Pool resource.` |
| `definitions.IpamPoolUpdate.properties.properties.description__added` | added | `Represents the IpamPool update properties.` |
| `definitions.IpamPoolUpdate.properties.tags.description__added` | added | `Dictionary of <string>` |
| `definitions.IPTraffic.properties.destinationIps.items.description__deleted` | deleted | `Destination IP address of the traffic..` |
| `definitions.IPTraffic.properties.destinationPorts.items.description__deleted` | deleted | `The destination port.` |
| `definitions.IPTraffic.properties.sourceIps.items.description__deleted` | deleted | `Source IP address of the traffic..` |
| `definitions.IPTraffic.properties.sourcePorts.items.description__deleted` | deleted | `The source port.` |
| `definitions.P2SVpnConnectionHealthRequest.properties.vpnUserNamesFilter.items.description__deleted` | deleted | `P2S vpn user name.` |
| `definitions.ReachabilityAnalysisIntent.properties.properties.description__added` | added | `Represents the Reachability Analysis Intent properties.` |
| `definitions.ReachabilityAnalysisRun.properties.properties.description__added` | added | `Represents the Reachability Analysis Run properties.` |
| `definitions.SecurityRulePropertiesFormat.properties.destinationPortRanges.items.description__deleted` | deleted | `The destination port.` |
| `definitions.SecurityRulePropertiesFormat.properties.sourcePortRanges.items.description__deleted` | deleted | `The source port.` |
| `definitions.SecurityUserRulePropertiesFormat.properties.destinationPortRanges.items.description__deleted` | deleted | `The destination port.` |
| `definitions.SecurityUserRulePropertiesFormat.properties.sourcePortRanges.items.description__deleted` | deleted | `The source port.` |
| `definitions.SignatureOverridesFilterValuesResponse.properties.filterValues.items.description__deleted` | deleted | `Describes a single value of the filter` |
| `definitions.SignaturesOverridesList.properties.value.items.description__deleted` | deleted | `Describes the single signatures overrides object related to that policy.` |
| `definitions.StaticCidr.properties.properties.description__added` | added | `Properties of static CIDR resource.` |
| `definitions.SwapResource.properties.properties.description__added` | added | `Swap resource properties` |
| `definitions.VerifierWorkspace.properties.properties.description__added` | added | `Properties of Verifier Workspace resource.` |
| `definitions.VerifierWorkspaceUpdate.properties.properties.description__added` | added | `Represents the VerifierWorkspace update properties.` |
| `definitions.VerifierWorkspaceUpdate.properties.tags.description__added` | added | `Dictionary of <string>` |
| `definitions.VirtualApplianceIPConfiguration.properties.properties.description__added` | added | `Represents a single IP configuration properties.` |
| `definitions.VirtualApplianceNetworkInterfaceConfiguration.properties.properties.description__added` | added | `Represents a single NIC configuration properties.` |
| `definitions.VirtualNetworkTapPropertiesFormat.properties.networkInterfaceTapConfigurations.items.description__deleted` | deleted | `The reference to the Network Interface.` |
| `definitions.VpnServerConfigurationsResponse.properties.vpnServerConfigurationResourceIds.items.description__deleted` | deleted | `VpnServerConfiguration partial resource uri.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/packetCapture'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/packetCaptureOperation'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}/deleteShareableLinksByToken'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools'].get.description__added` | added | `Gets list of Pool resources at Network Manager level.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].delete.description__added` | added | `Delete the Pool resource.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].get.description__added` | added | `Gets the specific Pool resource.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].patch.description__added` | added | `Updates the specific Pool resource.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].put.description__added` | added | `Creates/Updates the Pool resource.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].put.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}/getPoolUsage'].post.description__added` | added | `Get the Pool Usage.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}/listAssociatedResources'].post.description__added` | added | `List Associated Resource in the Pool.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}/staticCidrs'].get.description__added` | added | `Gets list of Static CIDR resources at Network Manager level.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}/staticCidrs/{staticCidrName}'].delete.description__added` | added | `Delete the Static CIDR resource.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}/staticCidrs/{staticCidrName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}/staticCidrs/{staticCidrName}'].get.description__added` | added | `Gets the specific Static CIDR resource.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}/staticCidrs/{staticCidrName}'].put.description__added` | added | `Creates/Updates the Static CIDR resource.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces'].get.description__added` | added | `Gets list of Verifier Workspaces.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}'].delete.description__added` | added | `Deletes Verifier Workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}'].get.description__added` | added | `Gets Verifier Workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}'].patch.description__added` | added | `Updates Verifier Workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}'].put.description__added` | added | `Creates Verifier Workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisIntents'].get.description__added` | added | `Gets list of Reachability Analysis Intents .` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisIntents/{reachabilityAnalysisIntentName}'].delete.description__added` | added | `Deletes Reachability Analysis Intent.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisIntents/{reachabilityAnalysisIntentName}'].get.description__added` | added | `Get the Reachability Analysis Intent.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisIntents/{reachabilityAnalysisIntentName}'].put.description__added` | added | `Creates Reachability Analysis Intent.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisRuns'].get.description__added` | added | `Gets list of Reachability Analysis Runs.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisRuns/{reachabilityAnalysisRunName}'].delete.description__added` | added | `Deletes Reachability Analysis Run.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisRuns/{reachabilityAnalysisRunName}'].get.description__added` | added | `Gets Reachability Analysis Run.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisRuns/{reachabilityAnalysisRunName}'].put.description__added` | added | `Creates Reachability Analysis Runs.` |

### Changes for `schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendPoolName}/queryInboundNatRulePortMapping'].post.responses.202.schema__deleted` | deleted | `{"$ref":"#/definitions/BackendAddressInboundNatRulePortMappings"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/availableProvidersList'].post.responses.202.schema__deleted` | deleted | `{"$ref":"#/definitions/AvailableProvidersList"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/azureReachabilityReport'].post.responses.202.schema__deleted` | deleted | `{"$ref":"#/definitions/AzureReachabilityReport"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/configureFlowLog'].post.responses.202.schema__deleted` | deleted | `{"$ref":"#/definitions/FlowLogInformation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectivityCheck'].post.responses.202.schema__deleted` | deleted | `{"$ref":"#/definitions/ConnectivityInformation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/ipFlowVerify'].post.responses.202.schema__deleted` | deleted | `{"$ref":"#/definitions/VerificationIPFlowResult"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/networkConfigurationDiagnostic'].post.responses.202.schema__deleted` | deleted | `{"$ref":"#/definitions/NetworkConfigurationDiagnosticResponse"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/nextHop'].post.responses.202.schema__deleted` | deleted | `{"$ref":"#/definitions/NextHopResult"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}/queryStatus'].post.responses.202.schema__deleted` | deleted | `{"$ref":"#/definitions/PacketCaptureQueryStatusResult"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/queryFlowLogStatus'].post.responses.202.schema__deleted` | deleted | `{"$ref":"#/definitions/FlowLogInformation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/queryTroubleshootResult'].post.responses.202.schema__deleted` | deleted | `{"$ref":"#/definitions/TroubleshootingResult"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/securityGroupView'].post.responses.202.schema__deleted` | deleted | `{"$ref":"#/definitions/SecurityGroupViewResult"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/troubleshoot'].post.responses.202.schema__deleted` | deleted | `{"$ref":"#/definitions/TroubleshootingResult"}` |

### Changes for `summary`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools'].get.summary__deleted` | deleted | `Gets list of Pool resources at Network Manager level.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].delete.summary__deleted` | deleted | `Delete the Pool resource.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].get.summary__deleted` | deleted | `Gets the specific Pool resource.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].patch.summary__deleted` | deleted | `Updates the specific Pool resource.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].put.summary__deleted` | deleted | `Creates/Updates the Pool resource.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}/getPoolUsage'].post.summary__deleted` | deleted | `Get the Pool Usage.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}/listAssociatedResources'].post.summary__deleted` | deleted | `List Associated Resource in the Pool.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}'].delete.summary__deleted` | deleted | `Deletes Verifier Workspace.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisIntents'].get.summary__deleted` | deleted | `Gets list of Reachability Analysis Intents .` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisIntents/{reachabilityAnalysisIntentName}'].delete.summary__deleted` | deleted | `Deletes Reachability Analysis Intent.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisIntents/{reachabilityAnalysisIntentName}'].get.summary__deleted` | deleted | `Get the Reachability Analysis Intent.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisIntents/{reachabilityAnalysisIntentName}'].put.summary__deleted` | deleted | `Creates Reachability Analysis Intent.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisRuns'].get.summary__deleted` | deleted | `Gets list of Reachability Analysis Runs.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisRuns/{reachabilityAnalysisRunName}'].delete.summary__deleted` | deleted | `Deletes Reachability Analysis Run.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisRuns/{reachabilityAnalysisRunName}'].get.summary__deleted` | deleted | `Gets Reachability Analysis Run.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisRuns/{reachabilityAnalysisRunName}'].put.summary__deleted` | deleted | `Creates Reachability Analysis Runs.` |

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BastionHostPropertiesFormat.properties.disableCopyPaste.default__deleted` | deleted | `false` |
| `definitions.BastionHostPropertiesFormat.properties.enableFileCopy.default__deleted` | deleted | `false` |
| `definitions.BastionHostPropertiesFormat.properties.enableIpConnect.default__deleted` | deleted | `false` |
| `definitions.BastionHostPropertiesFormat.properties.enableKerberos.default__deleted` | deleted | `false` |
| `definitions.BastionHostPropertiesFormat.properties.enablePrivateOnlyBastion.default__deleted` | deleted | `false` |
| `definitions.BastionHostPropertiesFormat.properties.enableSessionRecording.default__deleted` | deleted | `false` |
| `definitions.BastionHostPropertiesFormat.properties.enableShareableLink.default__deleted` | deleted | `false` |
| `definitions.BastionHostPropertiesFormat.properties.enableTunneling.default__deleted` | deleted | `false` |
| `definitions.FlowLogFormatParameters.properties.version.default__deleted` | deleted | `0` |
| `definitions.IpAllocationPropertiesFormat.properties.prefixLength.default__deleted` | deleted | `0` |
| `definitions.IpAllocationPropertiesFormat.properties.prefixType.default__deleted` | deleted | `null` |
| `definitions.IPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.default__deleted` | deleted | `Dynamic` |
| `definitions.PacketCaptureParameters.properties.bytesToCapturePerPacket.default__deleted` | deleted | `0` |
| `definitions.RetentionPolicyParameters.properties.days.default__deleted` | deleted | `0` |
| `definitions.RetentionPolicyParameters.properties.enabled.default__deleted` | deleted | `false` |
| `definitions.SubnetPropertiesFormat.properties.sharingScope.default__deleted` | deleted | `null` |
| `definitions.VirtualNetworkPeeringPropertiesFormat.properties.remoteBgpCommunities.default__deleted` | deleted | `null` |
| `definitions.VirtualNetworkPeeringPropertiesFormat.properties.remoteVirtualNetworkEncryption.default__deleted` | deleted | `null` |
| `definitions.VirtualNetworkPropertiesFormat.properties.bgpCommunities.default__deleted` | deleted | `null` |
| `definitions.VirtualNetworkPropertiesFormat.properties.ddosProtectionPlan.default__deleted` | deleted | `null` |
| `definitions.VirtualNetworkPropertiesFormat.properties.enableDdosProtection.default__deleted` | deleted | `false` |
| `definitions.VirtualNetworkPropertiesFormat.properties.enableVmProtection.default__deleted` | deleted | `false` |
| `definitions.VirtualNetworkPropertiesFormat.properties.encryption.default__deleted` | deleted | `null` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools'].get.parameters[3].default__deleted` | deleted | `0` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisIntents'].get.parameters[4].default__deleted` | deleted | `0` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisRuns'].get.parameters[4].default__deleted` | deleted | `0` |

### Changes for `x-ms-client-name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorHttpConfiguration.properties.preferHTTPS['x-ms-client-name__added']` | added | `preferHttps` |
| `definitions.ProtocolConfiguration.properties.HTTPConfiguration['x-ms-client-name__added']` | added | `httpConfiguration` |
| `definitions.VirtualHubProperties.properties.virtualHubRouteTableV2s['x-ms-client-name__added']` | added | `virtualHubRouteTableV2S` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].delete.parameters[3]['x-ms-client-name__added']` | added | `If-Match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}'].delete.parameters[3]['x-ms-client-name__added']` | added | `If-Match` |

### Changes for `Create a default routing rule`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}'].put['x-ms-examples']['Create a default routing rule__deleted']` | deleted | `{"$ref":"./examples/NetworkManagerRoutingRulePut.json"}` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGateway.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.ApplicationGatewayAvailableSslOptions.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.ApplicationSecurityGroup.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.AzureFirewall.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.BastionHost.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.CustomIpPrefix.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.DdosCustomPolicy.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.DscpConfiguration.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.ExpressRouteCircuit.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.ExpressRouteCrossConnection.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.ExpressRouteGateway.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.ExpressRoutePort.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.ExpressRoutePortsLocation.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.ExpressRouteProviderPort.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.FirewallPolicy.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.FirewallPolicyDraft.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.FlowLog.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.IpAllocation.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.IpGroup.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.LoadBalancer.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.LocalNetworkGateway.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.NatGateway.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.NetworkInterface.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.NetworkManager.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.NetworkProfile.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.NetworkSecurityGroup.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.NetworkVirtualAppliance.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.NetworkVirtualApplianceSku.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.NetworkWatcher.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.P2SVpnGateway.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.PrivateEndpoint.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.PrivateLinkService.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.PublicIPAddress.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.PublicIPPrefix.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.RouteFilter.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.RouteTable.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.SecurityPartnerProvider.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.ServiceEndpointPolicy.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.VirtualHub.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.VirtualNetwork.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.VirtualNetworkGateway.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.VirtualNetworkGatewayConnection.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.VirtualNetworkTap.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.VirtualRouter.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.VirtualWAN.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.VpnGateway.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.VpnServerConfiguration.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.VpnSite.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `definitions.WebApplicationFirewallPolicy.properties.location__added` | added | `{"type":"string","description":"The geo-location where the resource lives","x-ms-mutability":["creat...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/linkReferences/{linkReferenceName}'].delete.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"location header"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links/{linkName}'].delete.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"location header"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/abortMigration'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/commitMigration'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/executeMigration'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverAllTestsDetails'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverSingleTestDetails'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getResiliencyInformation'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getRoutesInformation'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/prepareMigration'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startSiteFailoverTest'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopSiteFailoverTest'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string"}` |

### Changes for `Location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/linkReferences/{linkReferenceName}'].delete.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links/{linkName}'].delete.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}'].put.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}'].put.responses.201.headers.Location__deleted` | deleted | `{"type":"string","description":"The URL of the resource used to check the status of the asynchronous...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}'].delete.responses.202.headers.Location__deleted` | deleted | `{"type":"string","description":"URL for determining when an operation has completed. Send a GET requ...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/abortMigration'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/commitMigration'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/executeMigration'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverAllTestsDetails'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverSingleTestDetails'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getResiliencyInformation'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getRoutesInformation'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/prepareMigration'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startSiteFailoverTest'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopSiteFailoverTest'].post.responses.202.headers.Location__added` | added | `{"type":"string","description":"The Location header contains the URL where the status of the long ru...` |

### Changes for `x-ms-long-running-operation-options`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}'].put['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}'].delete['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |

### Changes for `Azure-AsyncOperation`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}'].put.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"Azure async operation header"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}'].put.responses.201.headers['Azure-AsyncOperation__added']` | added | `{"type":"string","description":"A link to the status monitor"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/disassociateCloudServiceReservedPublicIp'].post.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"URL for checking the ongoing status of the operation.\\nTo get the st...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/reserveCloudServicePublicIpAddress'].post.responses.202.headers['Azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"URL for checking the ongoing status of the operation.\\nTo get the st...` |

### Changes for `x-ms-long-running-operation`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/networkVirtualApplianceConnections/{connectionName}'].delete['x-ms-long-running-operation__deleted']` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}'].delete['x-ms-long-running-operation__deleted']` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups/{privateDnsZoneGroupName}'].delete['x-ms-long-running-operation__deleted']` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}'].delete['x-ms-long-running-operation__deleted']` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections/{connectionName}'].delete['x-ms-long-running-operation__deleted']` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeTables/{routeTableName}'].delete['x-ms-long-running-operation__deleted']` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getvpnclientipsecparameters'].post['x-ms-long-running-operation__deleted']` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}'].delete['x-ms-long-running-operation__deleted']` | deleted | `true` |

### Changes for `202`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/networkVirtualApplianceConnections/{connectionName}'].delete.responses.202__deleted` | deleted | `{"description":"ignore","headers":{"location":{"type":"string","description":"The URL of the resourc...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}'].delete.responses.202__deleted` | deleted | `{"description":"ignore"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups/{privateDnsZoneGroupName}'].delete.responses.202__deleted` | deleted | `{"description":"ignore"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}'].delete.responses.202__deleted` | deleted | `{"description":"ignore","headers":{"Azure-AsyncOperation":{"type":"string","description":"URL for ch...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections/{connectionName}'].delete.responses.202__deleted` | deleted | `{"description":"ignore"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeTables/{routeTableName}'].delete.responses.202__deleted` | deleted | `{"description":"ignore"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}'].delete.responses.202__deleted` | deleted | `{"description":"ignore"}` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallPropertiesFormat.properties.additionalProperties.additionalProperties__added` | added | `{"type":"string"}` |
| `definitions.ConnectivityIssue.properties.context.items.additionalProperties__added` | added | `{"type":"string"}` |
| `definitions.EffectiveNetworkSecurityGroup.properties.tagMap.additionalProperties__deleted` | deleted | `{"description":"List of IP Addresses within the tag (key).","items":{"type":"string"},"type":"array"...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{hubName}/bgpConnections/{connectionName}/advertisedRoutes'].post.responses.200.schema.additionalProperties__added` | added | `{"items":{"$ref":"#/definitions/PeerRoute"},"type":"array"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{hubName}/bgpConnections/{connectionName}/learnedRoutes'].post.responses.200.schema.additionalProperties__added` | added | `{"items":{"$ref":"#/definitions/PeerRoute"},"type":"array"}` |

### Changes for `Availability`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Availability__deleted` | deleted | `{"type":"object","description":"Availability of the metric.","properties":{"timeGrain":{"type":"stri...` |

### Changes for `AzureAsyncOperationResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureAsyncOperationResult__deleted` | deleted | `{"type":"object","description":"The response body contains the status of the specified asynchronous ...` |

### Changes for `AzureFirewallAdditionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureFirewallAdditionalProperties__deleted` | deleted | `{"type":"object","description":"The additional properties of azure firewall.","additionalProperties"...` |

### Changes for `ChildResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ChildResource__deleted` | deleted | `{"type":"object","description":"Proxy resource representation.","properties":{"id":{"type":"string",...` |

### Changes for `CommonProxyResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CommonProxyResource__deleted` | deleted | `{"type":"object","title":"Proxy Resource","description":"The resource model definition for a Azure R...` |

### Changes for `CommonResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CommonResource__deleted` | deleted | `{"type":"object","title":"Resource","description":"Common fields that are returned in the response f...` |

### Changes for `CommonTrackedResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CommonTrackedResource__deleted` | deleted | `{"type":"object","title":"Tracked Resource","description":"The resource model definition for an Azur...` |

### Changes for `ConnectionMonitorQueryResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorQueryResult__deleted` | deleted | `{"type":"object","description":"List of connection states snapshots.","properties":{"sourceStatus":{...` |

### Changes for `ConnectionStateSnapshot`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionStateSnapshot__deleted` | deleted | `{"type":"object","description":"Connection state snapshot.","properties":{"connectionState":{"type":...` |

### Changes for `Dimension`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Dimension__deleted` | deleted | `{"type":"object","description":"Dimension of the metric.","properties":{"name":{"type":"string","des...` |

### Changes for `Filters`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Filters__deleted` | deleted | `{"type":"array","description":"Describers the filters to filter response by","items":{"$ref":"#/defi...` |

### Changes for `FirewallPolicySNAT`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FirewallPolicySNAT__deleted` | deleted | `{"type":"object","description":"The private IP addresses/IP ranges to which traffic will not be SNAT...` |

### Changes for `HTTPConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HTTPConfiguration__deleted` | deleted | `{"type":"object","description":"HTTP configuration of the connectivity check.","properties":{"method...` |

### Changes for `HTTPHeader`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HTTPHeader__deleted` | deleted | `{"type":"object","description":"The HTTP header.","properties":{"name":{"type":"string","description...` |

### Changes for `IpGroups`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IpGroups__deleted` | deleted | `{"type":"array","description":"List of IpGroups associated with azure firewall.","items":{"$ref":"#/...` |

### Changes for `IssueContext`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IssueContext__deleted` | deleted | `{"type":"object","description":"A key-value pair that provides additional context on the issue.","ad...` |

### Changes for `ListVirtualHubRouteTableV2sResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ListVirtualHubRouteTableV2sResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `LoadBalancerBackendAddressPoolListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerBackendAddressPoolListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `LogSpecification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogSpecification__deleted` | deleted | `{"type":"object","description":"Description of logging specification.","properties":{"name":{"type":...` |

### Changes for `MetricSpecification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MetricSpecification__deleted` | deleted | `{"type":"object","description":"Description of metrics specification.","properties":{"name":{"type":...` |

### Changes for `NetworkInterfaceLoadBalancerListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkInterfaceLoadBalancerListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `NetworkVirtualApplianceSiteListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkVirtualApplianceSiteListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `NspAccessRuleReconcile`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspAccessRuleReconcile__deleted` | deleted | `{"type":"object","description":"Request object for NSP reconcile.","properties":{}}` |

### Changes for `NspAssociationReconcile`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspAssociationReconcile__deleted` | deleted | `{"type":"object","description":"Request object for NSP association.","properties":{}}` |

### Changes for `NspAssociationsListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspAssociationsListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `NvaInterfaceConfigurations`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NvaInterfaceConfigurations__deleted` | deleted | `{"type":"array","description":"The NVA in VNet interface configurations details","maxItems":3,"items...` |

### Changes for `Operation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation__deleted` | deleted | `{"type":"object","description":"Network REST API operation definition.","properties":{"name":{"type"...` |

### Changes for `OperationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `OperationPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationPropertiesFormat__deleted` | deleted | `{"type":"object","description":"Description of operation properties format.","properties":{"serviceS...` |

### Changes for `PeerRouteList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PeerRouteList__deleted` | deleted | `{"type":"object","description":"Map from virtual router instance to list of peer routes.","additiona...` |

### Changes for `PortsList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PortsList__deleted` | deleted | `{"type":"string","description":"Describes a port, port range, or negation of a port"}` |

### Changes for `ProxyResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ProxyResource__deleted` | deleted | `{"type":"object","description":"Proxy resource representation.","properties":{"id":{"type":"string",...` |

### Changes for `Resource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Resource__deleted` | deleted | `{"type":"object","description":"Common resource representation.","properties":{"id":{"type":"string"...` |

### Changes for `ResourceNavigationLinksListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ResourceNavigationLinksListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ServiceAssociationLinksListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceAssociationLinksListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `Signatures`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Signatures__deleted` | deleted | `{"type":"object","additionalProperties":{"type":"string"}}` |

### Changes for `SystemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SystemData__deleted` | deleted | `{"type":"object","description":"Metadata pertaining to creation and last modification of the resourc...` |

### Changes for `VpnSiteId`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VpnSiteId__deleted` | deleted | `{"type":"object","description":"VpnSite Resource.","properties":{"vpnSite":{"type":"string","descrip...` |

### Changes for `connectivityGroupItem`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.connectivityGroupItem__deleted` | deleted | `{"type":"object","description":"Connectivity group item.","properties":{"networkGroupId":{"type":"st...` |

### Changes for `Azure.ResourceManager.ArmAcceptedLroResponse<"Resource operation accepted.", Azure.ResourceManager.Legacy.{ location: string, retryAfter: int32 }>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmAcceptedLroResponse<"Resource operation accepted.", Azure.ResourceManager.Legacy.{ location: string, retryAfter: int32 }>__added']` | added | `{"type":"object","description":"Resource operation accepted."}` |

### Changes for `Azure.ResourceManager.ArmAcceptedLroResponse<"Resource operation accepted.", Azure.ResourceManager.{ location: string, retryAfter: int32 }>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmAcceptedLroResponse<"Resource operation accepted.", Azure.ResourceManager.{ location: string, retryAfter: int32 }>__added']` | added | `{"type":"object","description":"Resource operation accepted."}` |

### Changes for `Azure.ResourceManager.ArmResponse<ApplicationGatewayBackendHealth>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<ApplicationGatewayBackendHealth>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<ApplicationGatewayBackendHealthOnDemand>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<ApplicationGatewayBackendHealthOnDemand>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<AvailableProvidersList>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<AvailableProvidersList>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<AzureFirewallPacketCaptureResponse>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<AzureFirewallPacketCaptureResponse>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<AzureReachabilityReport>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<AzureReachabilityReport>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<BastionActiveSessionListResult>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<BastionActiveSessionListResult>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<BastionShareableLinkListResult>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<BastionShareableLinkListResult>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<BgpPeerStatusListResult>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<BgpPeerStatusListResult>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<ConnectionResetSharedKey>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<ConnectionResetSharedKey>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<ConnectivityInformation>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<ConnectivityInformation>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<EffectiveNetworkSecurityGroupListResult>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<EffectiveNetworkSecurityGroupListResult>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<EffectiveRouteListResult>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<EffectiveRouteListResult>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<EffectiveRouteMapRouteList>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<EffectiveRouteMapRouteList>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<ExpressRouteFailoverAllTestDetails>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<ExpressRouteFailoverAllTestDetails>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<ExpressRouteFailoverSingleTestDetailsObject>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<ExpressRouteFailoverSingleTestDetailsObject>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<FlowLogInformation>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<FlowLogInformation>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<GatewayResiliencyInformation>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<GatewayResiliencyInformation>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<GatewayRouteListResult>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<GatewayRouteListResult>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<GatewayRouteSetsInformation>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<GatewayRouteSetsInformation>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<IPPrefixesList>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<IPPrefixesList>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<LoadBalancerHealthPerRule>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<LoadBalancerHealthPerRule>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<NetworkConfigurationDiagnosticResponse>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<NetworkConfigurationDiagnosticResponse>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<NetworkVirtualApplianceInstanceId>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<NetworkVirtualApplianceInstanceId>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<NetworkVirtualApplianceInstanceIds>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<NetworkVirtualApplianceInstanceIds>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<NextHopResult>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<NextHopResult>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<P2SVpnConnectionHealth>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<P2SVpnConnectionHealth>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<P2SVpnGateway>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<P2SVpnGateway>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<PacketCaptureQueryStatusResult>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<PacketCaptureQueryStatusResult>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<PublicIPAddress>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<PublicIPAddress>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<PublicIpDdosProtectionStatusResult>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<PublicIpDdosProtectionStatusResult>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<Record<PeerRoute[]>>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<Record<PeerRoute[]>>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"type...` |

### Changes for `Azure.ResourceManager.ArmResponse<SecurityGroupViewResult>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<SecurityGroupViewResult>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<TroubleshootingResult>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<TroubleshootingResult>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<VerificationIPFlowResult>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<VerificationIPFlowResult>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<VirtualHubEffectiveRouteList>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<VirtualHubEffectiveRouteList>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<VirtualNetworkDdosProtectionStatusResult>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<VirtualNetworkDdosProtectionStatusResult>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<VirtualNetworkGateway>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<VirtualNetworkGateway>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<VpnClientConnectionHealthDetailListResult>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<VpnClientConnectionHealthDetailListResult>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<VpnClientIPsecParameters>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<VpnClientIPsecParameters>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<VpnGateway>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<VpnGateway>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<VpnProfileResponse>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<VpnProfileResponse>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<VpnServerConfigurationsResponse>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<VpnServerConfigurationsResponse>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"$ref...` |

### Changes for `Azure.ResourceManager.ArmResponse<stringApplicationJson>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<stringApplicationJson>__added']` | added | `{"type":"object","description":"Azure operation completed successfully.","properties":{"body":{"type...` |

### Changes for `BackendAddressPoolListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BackendAddressPoolListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `BastionHostPropertiesFormatNetworkAcls`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BastionHostPropertiesFormatNetworkAcls__added` | added | `{"type":"object","properties":{"ipRules":{"type":"array","description":"Sets the IP ACL rules for De...` |

### Changes for `Components1Jq1T4ISchemasManagedserviceidentityPropertiesUserassignedidentitiesAdditionalproperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Components1Jq1T4ISchemasManagedserviceidentityPropertiesUserassignedidentitiesAdditionalproperties__added` | added | `{"type":"object","properties":{"principalId":{"type":"string","description":"The principal id of use...` |

### Changes for `ConnectivityConfigurationPropertiesConnectivityCapabilities`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectivityConfigurationPropertiesConnectivityCapabilities__added` | added | `{"type":"object","description":"Collection of additional settings to enhance specific topology behav...` |

### Changes for `ConnectivityGroupItem`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectivityGroupItem__added` | added | `{"type":"object","description":"Connectivity group item.","properties":{"networkGroupId":{"type":"st...` |

### Changes for `ExpressRouteGatewayPropertiesAutoScaleConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteGatewayPropertiesAutoScaleConfiguration__added` | added | `{"type":"object","description":"Configuration for auto scaling.","properties":{"bounds":{"$ref":"#/d...` |

### Changes for `ExpressRouteGatewayPropertiesAutoScaleConfigurationBounds`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ExpressRouteGatewayPropertiesAutoScaleConfigurationBounds__added` | added | `{"type":"object","description":"Minimum and maximum number of scale units to deploy.","properties":{...` |

### Changes for `FirewallPolicySnat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FirewallPolicySnat__added` | added | `{"type":"object","description":"The private IP addresses/IP ranges to which traffic will not be SNAT...` |

### Changes for `HttpConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HttpConfiguration__added` | added | `{"type":"object","description":"HTTP configuration of the connectivity check.","properties":{"method...` |

### Changes for `HttpHeader`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.HttpHeader__added` | added | `{"type":"object","description":"The HTTP header.","properties":{"name":{"type":"string","description...` |

### Changes for `IpamPoolPrefixAllocationPool`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IpamPoolPrefixAllocationPool__added` | added | `{"type":"object","properties":{"id":{"type":"string","format":"arm-id","description":"Resource id of...` |

### Changes for `ListVirtualHubRouteTableV2SResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ListVirtualHubRouteTableV2SResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `NetworkManagerPropertiesNetworkManagerScopes`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkManagerPropertiesNetworkManagerScopes__added` | added | `{"type":"object","description":"Scope of Network Manager.","properties":{"managementGroups":{"type":...` |

### Changes for `NetworkVirtualAppliancePropertiesFormatNetworkProfile`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkVirtualAppliancePropertiesFormatNetworkProfile__added` | added | `{"type":"object","description":"Network Profile containing configurations for Public and Private NIC...` |

### Changes for `NspAssociationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspAssociationListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `PolicySettingsLogScrubbing`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PolicySettingsLogScrubbing__added` | added | `{"type":"object","description":"To scrub sensitive log fields","properties":{"state":{"type":"string...` |

### Changes for `PrivateLinkServicePropertiesAutoApproval`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateLinkServicePropertiesAutoApproval__added` | added | `{"type":"object","description":"The auto-approval list of the private link service.","allOf":[{"$ref...` |

### Changes for `PrivateLinkServicePropertiesVisibility`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateLinkServicePropertiesVisibility__added` | added | `{"type":"object","description":"The visibility list of the private link service.","allOf":[{"$ref":"...` |

### Changes for `ResourceNavigationLinkListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ResourceNavigationLinkListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ServiceAssociationLinkListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceAssociationLinkListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `SignaturesOverridesProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SignaturesOverridesProperties__added` | added | `{"type":"object","description":"Will contain the properties of the resource (the actual signature ov...` |

### Changes for `TypeSpec.Http.OkResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['TypeSpec.Http.OkResponse__added']` | added | `{"type":"object","description":"The request has succeeded."}` |

### Changes for `VirtualApplianceSiteListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualApplianceSiteListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `stringApplicationJson`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.stringApplicationJson__added` | added | `{"type":"string"}` |

### Changes for `x-ms-discriminator-value`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdminRule['x-ms-discriminator-value__deleted']` | deleted | `Custom` |
| `definitions.DefaultAdminRule['x-ms-discriminator-value__deleted']` | deleted | `Default` |

### Changes for `kind`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdminRule.properties.kind__added` | added | `{"type":"string","description":"Whether the rule is custom or default.","enum":["Custom"],"x-ms-enum...` |
| `definitions.DefaultAdminRule.properties.kind__added` | added | `{"type":"string","description":"Whether the rule is custom or default.","enum":["Default"],"x-ms-enu...` |

### Changes for `systemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdminRuleCollection.properties.systemData__deleted` | deleted | `{"$ref":"./network.json#/definitions/SystemData","description":"The system metadata related to this ...` |
| `definitions.BaseAdminRule.properties.systemData__deleted` | deleted | `{"$ref":"./network.json#/definitions/SystemData","description":"The system metadata related to this ...` |
| `definitions.ConnectivityConfiguration.properties.systemData__deleted` | deleted | `{"$ref":"./network.json#/definitions/SystemData","description":"The system metadata related to this ...` |
| `definitions.NetworkGroup.properties.systemData__deleted` | deleted | `{"$ref":"./network.json#/definitions/SystemData","description":"The system metadata related to this ...` |
| `definitions.NetworkManager.properties.systemData__deleted` | deleted | `{"$ref":"./network.json#/definitions/SystemData","description":"The system metadata related to this ...` |
| `definitions.NetworkManagerConnection.properties.systemData__deleted` | deleted | `{"$ref":"./network.json#/definitions/SystemData","description":"The system metadata related to this ...` |
| `definitions.NetworkManagerRoutingConfiguration.properties.systemData__deleted` | deleted | `{"$ref":"./network.json#/definitions/SystemData","description":"The system metadata related to this ...` |
| `definitions.ReachabilityAnalysisIntent.properties.systemData__deleted` | deleted | `{"$ref":"./network.json#/definitions/SystemData","description":"The system metadata related to this ...` |
| `definitions.ReachabilityAnalysisRun.properties.systemData__deleted` | deleted | `{"$ref":"./network.json#/definitions/SystemData","description":"The system metadata related to this ...` |
| `definitions.RoutingRule.properties.systemData__deleted` | deleted | `{"$ref":"./network.json#/definitions/SystemData","description":"The system metadata related to this ...` |
| `definitions.RoutingRuleCollection.properties.systemData__deleted` | deleted | `{"$ref":"./network.json#/definitions/SystemData","description":"The system metadata related to this ...` |
| `definitions.ScopeConnection.properties.systemData__deleted` | deleted | `{"$ref":"./network.json#/definitions/SystemData","description":"The system metadata related to this ...` |
| `definitions.SecurityAdminConfiguration.properties.systemData__deleted` | deleted | `{"$ref":"./network.json#/definitions/SystemData","description":"The system metadata related to this ...` |
| `definitions.SecurityUserConfiguration.properties.systemData__deleted` | deleted | `{"$ref":"./network.json#/definitions/SystemData","description":"The system metadata related to this ...` |
| `definitions.SecurityUserRule.properties.systemData__deleted` | deleted | `{"$ref":"./network.json#/definitions/SystemData","description":"The system metadata related to this ...` |
| `definitions.SecurityUserRuleCollection.properties.systemData__deleted` | deleted | `{"$ref":"./network.json#/definitions/SystemData","description":"The system metadata related to this ...` |
| `definitions.StaticMember.properties.systemData__deleted` | deleted | `{"$ref":"./network.json#/definitions/SystemData","description":"The system metadata related to this ...` |
| `definitions.VerifierWorkspace.properties.systemData__deleted` | deleted | `{"$ref":"./network.json#/definitions/SystemData","description":"The system metadata related to this ...` |

### Changes for `etag`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdminRuleCollection.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |
| `definitions.BaseAdminRule.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |
| `definitions.ConnectivityConfiguration.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |
| `definitions.NetworkGroup.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |
| `definitions.NetworkManagerRoutingConfiguration.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |
| `definitions.RoutingRule.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |
| `definitions.RoutingRuleCollection.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |
| `definitions.SecurityAdminConfiguration.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |
| `definitions.SecurityUserConfiguration.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |
| `definitions.SecurityUserRule.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |
| `definitions.SecurityUserRuleCollection.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |
| `definitions.StaticMember.properties.etag__added` | added | `{"type":"string","description":"\\"If etag is provided in the response body, it may also be provided ...` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGateway.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.ApplicationGatewayAvailableSslOptions.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.ApplicationSecurityGroup.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.AzureFirewall.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.BastionHost.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.CustomIpPrefix.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.DdosCustomPolicy.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.DscpConfiguration.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.ExpressRouteCircuit.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.ExpressRouteCrossConnection.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.ExpressRouteGateway.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.ExpressRoutePort.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.ExpressRoutePortsLocation.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.ExpressRouteProviderPort.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.FirewallPolicy.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.FirewallPolicyDraft.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.FlowLog.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.IpAllocation.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.IpGroup.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.LoadBalancer.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.LocalNetworkGateway.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.NatGateway.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.NetworkInterface.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.NetworkManager.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.NetworkProfile.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.NetworkSecurityGroup.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.NetworkVirtualAppliance.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.NetworkVirtualApplianceSku.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.NetworkWatcher.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.P2SVpnGateway.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.PrivateEndpoint.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.PrivateLinkService.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.PublicIPAddress.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.PublicIPPrefix.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.RouteFilter.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.RouteTable.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.SecurityPartnerProvider.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.ServiceEndpointPolicy.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.VirtualHub.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.VirtualNetwork.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.VirtualNetworkGateway.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.VirtualNetworkGatewayConnection.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.VirtualNetworkTap.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.VirtualRouter.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.VirtualWAN.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.VpnGateway.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.VpnServerConfiguration.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.VpnSite.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |
| `definitions.WebApplicationFirewallPolicy.properties.tags__added` | added | `{"type":"object","description":"Resource tags.","additionalProperties":{"type":"string"}}` |

### Changes for `enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAuthenticationCertificatePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayBackendAddressPoolPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayBackendHttpSettingsPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayBackendSettingsPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayEntraJWTValidationConfigPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayFirewallRuleSetPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.enum__added` | added | `["Static","Dynamic"]` |
| `definitions.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayFrontendPortPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayHttpListenerPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayIPConfigurationPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayListenerPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayLoadDistributionPolicyPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayPathRulePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayPrivateEndpointConnectionProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayPrivateLinkConfigurationProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayPrivateLinkIpConfigurationProperties.properties.privateIPAllocationMethod.enum__added` | added | `["Static","Dynamic"]` |
| `definitions.ApplicationGatewayPrivateLinkIpConfigurationProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayProbePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayRewriteRuleSetPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayRoutingRulePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewaySslCertificatePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewaySslProfilePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayTrustedClientCertificatePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayTrustedRootCertificatePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationGatewayUrlPathMapPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ApplicationSecurityGroupPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.AuthorizationPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.AzureFirewallApplicationRuleCollectionPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.AzureFirewallFqdnTagPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.AzureFirewallIPConfigurationPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.AzureFirewallNatRuleCollectionProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.AzureFirewallNetworkRuleCollectionPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.AzureFirewallPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.BastionHostIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.enum__added` | added | `["Static","Dynamic"]` |
| `definitions.BastionHostIPConfigurationPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.BastionHostPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.BgpConnectionProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ConnectionMonitorResultProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ConnectivityConfigurationProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ConnectivityParameters.properties.preferredIPVersion.enum__added` | added | `["IPv4","IPv6"]` |
| `definitions.ContainerNetworkInterfaceConfigurationPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ContainerNetworkInterfaceIpConfigurationPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ContainerNetworkInterfacePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.DdosCustomPolicyPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.DdosDetectionRulePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.DdosProtectionPlanPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.DelegationProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.DscpConfigurationPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.EffectiveNetworkSecurityRule.properties.access.enum__added` | added | `["Allow","Deny"]` |
| `definitions.EffectiveNetworkSecurityRule.properties.direction.enum__added` | added | `["Inbound","Outbound"]` |
| `definitions.EffectiveRoute.properties.nextHopType.enum__added` | added | `["VirtualNetworkGateway","VnetLocal","Internet","VirtualAppliance","None"]` |
| `definitions.ExpressRouteCircuitConnectionPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ExpressRouteCircuitPeeringPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ExpressRouteCircuitPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ExpressRouteConnectionProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ExpressRouteCrossConnectionPeeringProperties.properties.peeringType.enum__added` | added | `["AzurePublicPeering","AzurePrivatePeering","MicrosoftPeering"]` |
| `definitions.ExpressRouteCrossConnectionPeeringProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ExpressRouteCrossConnectionPeeringProperties.properties.state.enum__added` | added | `["Disabled","Enabled"]` |
| `definitions.ExpressRouteCrossConnectionProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ExpressRouteCrossConnectionProperties.properties.serviceProviderProvisioningState.enum__added` | added | `["NotProvisioned","Provisioning","Provisioned","Deprovisioning"]` |
| `definitions.ExpressRouteGatewayProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ExpressRouteLinkPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ExpressRoutePortAuthorizationPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ExpressRoutePortsLocationPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ExpressRouteServiceProviderPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.FirewallPolicyDraftProperties.properties.threatIntelMode.enum__added` | added | `["Alert","Deny","Off"]` |
| `definitions.FirewallPolicyPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.FirewallPolicyPropertiesFormat.properties.threatIntelMode.enum__added` | added | `["Alert","Deny","Off"]` |
| `definitions.FirewallPolicyRuleCollectionGroupProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.FlowLogPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.privateIPAddressVersion.enum__added` | added | `["IPv4","IPv6"]` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.enum__added` | added | `["Static","Dynamic"]` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.HubIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.enum__added` | added | `["Static","Dynamic"]` |
| `definitions.HubIPConfigurationPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.HubRouteTableProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.HubVirtualNetworkConnectionProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.InboundNatPoolPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.InboundNatRulePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.InboundSecurityRuleProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.IpAllocationPropertiesFormat.properties.prefixType.enum__added` | added | `["IPv4","IPv6"]` |
| `definitions.IPConfigurationProfilePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.IPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.enum__added` | added | `["Static","Dynamic"]` |
| `definitions.IPConfigurationPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.IpGroupPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.LoadBalancerPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.LocalNetworkGatewayPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.NatGatewayPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.NetworkGroupProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.privateIPAddressVersion.enum__added` | added | `["IPv4","IPv6"]` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.enum__added` | added | `["Static","Dynamic"]` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.NetworkInterfacePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.NetworkInterfaceTapConfigurationPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.NetworkManagerConnectionProperties.properties.connectionState.enum__added` | added | `["Connected","Pending","Conflict","Revoked","Rejected"]` |
| `definitions.NetworkManagerProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.NetworkManagerRoutingConfigurationPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.NetworkProfilePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.NetworkSecurityGroupPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.NetworkSecurityGroupResult.properties.securityRuleAccessResult.enum__added` | added | `["Allow","Deny"]` |
| `definitions.NetworkVirtualApplianceConnectionProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.NetworkWatcherPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.OutboundRulePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.P2SConnectionConfigurationProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.P2SVpnGatewayProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.P2SVpnProfileParameters.properties.authenticationMethod.enum__added` | added | `["EAPTLS","EAPMSCHAPv2"]` |
| `definitions.PacketCaptureResultProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.PeerExpressRouteCircuitConnectionPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.PrivateDnsZoneGroupPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.PrivateEndpointConnectionProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.PrivateEndpointProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.PrivateLinkServiceConnectionProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.PrivateLinkServiceIpConfigurationProperties.properties.privateIPAddressVersion.enum__added` | added | `["IPv4","IPv6"]` |
| `definitions.PrivateLinkServiceIpConfigurationProperties.properties.privateIPAllocationMethod.enum__added` | added | `["Static","Dynamic"]` |
| `definitions.PrivateLinkServiceIpConfigurationProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.PrivateLinkServiceProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ProbePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.PublicIPAddressPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.PublicIPAddressPropertiesFormat.properties.publicIPAddressVersion.enum__added` | added | `["IPv4","IPv6"]` |
| `definitions.PublicIPAddressPropertiesFormat.properties.publicIPAllocationMethod.enum__added` | added | `["Static","Dynamic"]` |
| `definitions.PublicIPPrefixPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.PublicIPPrefixPropertiesFormat.properties.publicIPAddressVersion.enum__added` | added | `["IPv4","IPv6"]` |
| `definitions.RecordSet.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ResourceNavigationLinkFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.RouteFilterPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.RouteFilterRulePropertiesFormat.properties.access.enum__added` | added | `["Allow","Deny"]` |
| `definitions.RouteFilterRulePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.RouteMapProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.RoutePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.RouteTablePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.RoutingIntentProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.RoutingRuleCollectionPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.RoutingRulePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.SecurityPartnerProviderPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.SecurityRulePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.SecurityUserConfigurationPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.SecurityUserRuleCollectionPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.SecurityUserRulePropertiesFormat.properties.direction.enum__added` | added | `["Inbound","Outbound"]` |
| `definitions.SecurityUserRulePropertiesFormat.properties.protocol.enum__added` | added | `["Tcp","Udp","Icmp","Esp","Any","Ah"]` |
| `definitions.SecurityUserRulePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ServiceAssociationLinkPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ServiceDelegationPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ServiceEndpointPolicyDefinitionPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ServiceEndpointPolicyPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ServiceEndpointPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.SharedKeyProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.StaticMemberProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.SubnetPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VerificationIPFlowResult.properties.access.enum__added` | added | `["Allow","Deny"]` |
| `definitions.VirtualApplianceSiteProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VirtualHubProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VirtualHubRouteTableV2Properties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VirtualNetworkGatewayIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.enum__added` | added | `["Static","Dynamic"]` |
| `definitions.VirtualNetworkGatewayIPConfigurationPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VirtualNetworkGatewayPolicyGroupProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VirtualNetworkPeeringPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VirtualNetworkPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VirtualNetworkTapPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VirtualRouterPeeringProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VirtualRouterPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VirtualWanProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VirtualWanVpnProfileParameters.properties.authenticationMethod.enum__added` | added | `["EAPTLS","EAPMSCHAPv2"]` |
| `definitions.VngClientConnectionConfigurationProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VpnClientParameters.properties.authenticationMethod.enum__added` | added | `["EAPTLS","EAPMSCHAPv2"]` |
| `definitions.VpnClientRevokedCertificatePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VpnClientRootCertificatePropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VpnConnectionProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VpnConnectionProperties.properties.vpnConnectionProtocolType.enum__added` | added | `["IKEv2","IKEv1"]` |
| `definitions.VpnGatewayNatRuleProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VpnGatewayProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VpnServerConfigurationPolicyGroupProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VpnSiteLinkConnectionProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VpnSiteLinkConnectionProperties.properties.vpnConnectionProtocolType.enum__added` | added | `["IKEv2","IKEv1"]` |
| `definitions.VpnSiteLinkProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VpnSiteProperties.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.WebApplicationFirewallPolicyPropertiesFormat.properties.provisioningState.enum__added` | added | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAuthenticationCertificatePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayBackendAddressPoolPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayBackendHttpSettingsPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayBackendSettingsPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayEntraJWTValidationConfigPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayFirewallRuleSetPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod['x-ms-enum__added']` | added | `{"name":"IPAllocationMethod","modelAsString":true}` |
| `definitions.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayFrontendPortPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayHttpListenerPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayIPConfigurationPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayListenerPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayLoadDistributionPolicyPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayPathRulePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayPrivateEndpointConnectionProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayPrivateLinkConfigurationProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayPrivateLinkIpConfigurationProperties.properties.privateIPAllocationMethod['x-ms-enum__added']` | added | `{"name":"IPAllocationMethod","modelAsString":true}` |
| `definitions.ApplicationGatewayPrivateLinkIpConfigurationProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayProbePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayRewriteRuleSetPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayRoutingRulePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewaySslCertificatePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewaySslProfilePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayTrustedClientCertificatePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayTrustedRootCertificatePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationGatewayUrlPathMapPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ApplicationSecurityGroupPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.AuthorizationPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.AzureFirewallApplicationRuleCollectionPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.AzureFirewallFqdnTagPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.AzureFirewallIPConfigurationPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.AzureFirewallNatRuleCollectionProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.AzureFirewallNetworkRuleCollectionPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.AzureFirewallPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.BastionHostIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod['x-ms-enum__added']` | added | `{"name":"IPAllocationMethod","modelAsString":true}` |
| `definitions.BastionHostIPConfigurationPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.BastionHostPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.BgpConnectionProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ConnectionMonitorResultProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ConnectivityConfigurationProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ConnectivityParameters.properties.preferredIPVersion['x-ms-enum__added']` | added | `{"name":"IPVersion","modelAsString":true}` |
| `definitions.ContainerNetworkInterfaceConfigurationPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ContainerNetworkInterfaceIpConfigurationPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ContainerNetworkInterfacePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.DdosCustomPolicyPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.DdosDetectionRulePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.DdosProtectionPlanPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.DelegationProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.DscpConfigurationPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.EffectiveNetworkSecurityRule.properties.access['x-ms-enum__added']` | added | `{"name":"SecurityRuleAccess","modelAsString":true}` |
| `definitions.EffectiveNetworkSecurityRule.properties.direction['x-ms-enum__added']` | added | `{"name":"SecurityRuleDirection","modelAsString":true}` |
| `definitions.EffectiveRoute.properties.nextHopType['x-ms-enum__added']` | added | `{"name":"RouteNextHopType","modelAsString":true}` |
| `definitions.ExpressRouteCircuitConnectionPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ExpressRouteCircuitPeeringPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ExpressRouteCircuitPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ExpressRouteConnectionProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ExpressRouteCrossConnectionPeeringProperties.properties.peeringType['x-ms-enum__added']` | added | `{"name":"ExpressRoutePeeringType","modelAsString":true}` |
| `definitions.ExpressRouteCrossConnectionPeeringProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ExpressRouteCrossConnectionPeeringProperties.properties.state['x-ms-enum__added']` | added | `{"name":"ExpressRoutePeeringState","modelAsString":true}` |
| `definitions.ExpressRouteCrossConnectionProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ExpressRouteCrossConnectionProperties.properties.serviceProviderProvisioningState['x-ms-enum__added']` | added | `{"name":"ServiceProviderProvisioningState","modelAsString":true}` |
| `definitions.ExpressRouteGatewayProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ExpressRouteLinkPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ExpressRoutePortAuthorizationPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ExpressRoutePortsLocationPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ExpressRouteServiceProviderPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.FirewallPolicyDraftProperties.properties.threatIntelMode['x-ms-enum__added']` | added | `{"name":"AzureFirewallThreatIntelMode","modelAsString":true}` |
| `definitions.FirewallPolicyPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.FirewallPolicyPropertiesFormat.properties.threatIntelMode['x-ms-enum__added']` | added | `{"name":"AzureFirewallThreatIntelMode","modelAsString":true}` |
| `definitions.FirewallPolicyRuleCollectionGroupProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.FlowLogPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.privateIPAddressVersion['x-ms-enum__added']` | added | `{"name":"IPVersion","modelAsString":true}` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod['x-ms-enum__added']` | added | `{"name":"IPAllocationMethod","modelAsString":true}` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.HubIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod['x-ms-enum__added']` | added | `{"name":"IPAllocationMethod","modelAsString":true}` |
| `definitions.HubIPConfigurationPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.HubRouteTableProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.HubVirtualNetworkConnectionProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.InboundNatPoolPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.InboundNatRulePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.InboundSecurityRuleProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.IpAllocationPropertiesFormat.properties.prefixType['x-ms-enum__added']` | added | `{"name":"IPVersion","modelAsString":true}` |
| `definitions.IPConfigurationProfilePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.IPConfigurationPropertiesFormat.properties.privateIPAllocationMethod['x-ms-enum__added']` | added | `{"name":"IPAllocationMethod","modelAsString":true}` |
| `definitions.IPConfigurationPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.IpGroupPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.LoadBalancerPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.LocalNetworkGatewayPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.NatGatewayPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.NetworkGroupProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.privateIPAddressVersion['x-ms-enum__added']` | added | `{"name":"IPVersion","modelAsString":true}` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod['x-ms-enum__added']` | added | `{"name":"IPAllocationMethod","modelAsString":true}` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.NetworkInterfacePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.NetworkInterfaceTapConfigurationPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.NetworkManagerConnectionProperties.properties.connectionState['x-ms-enum__added']` | added | `{"name":"ScopeConnectionState","modelAsString":true}` |
| `definitions.NetworkManagerProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.NetworkManagerRoutingConfigurationPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.NetworkProfilePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.NetworkSecurityGroupPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.NetworkSecurityGroupResult.properties.securityRuleAccessResult['x-ms-enum__added']` | added | `{"name":"SecurityRuleAccess","modelAsString":true}` |
| `definitions.NetworkVirtualApplianceConnectionProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.NetworkWatcherPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.OutboundRulePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.P2SConnectionConfigurationProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.P2SVpnGatewayProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.P2SVpnProfileParameters.properties.authenticationMethod['x-ms-enum__added']` | added | `{"name":"AuthenticationMethod","modelAsString":true}` |
| `definitions.PacketCaptureResultProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.PeerExpressRouteCircuitConnectionPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.PrivateDnsZoneGroupPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.PrivateEndpointConnectionProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.PrivateEndpointProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.PrivateLinkServiceConnectionProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.PrivateLinkServiceIpConfigurationProperties.properties.privateIPAddressVersion['x-ms-enum__added']` | added | `{"name":"IPVersion","modelAsString":true}` |
| `definitions.PrivateLinkServiceIpConfigurationProperties.properties.privateIPAllocationMethod['x-ms-enum__added']` | added | `{"name":"IPAllocationMethod","modelAsString":true}` |
| `definitions.PrivateLinkServiceIpConfigurationProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.PrivateLinkServiceProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ProbePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.PublicIPAddressPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.PublicIPAddressPropertiesFormat.properties.publicIPAddressVersion['x-ms-enum__added']` | added | `{"name":"IPVersion","modelAsString":true}` |
| `definitions.PublicIPAddressPropertiesFormat.properties.publicIPAllocationMethod['x-ms-enum__added']` | added | `{"name":"IPAllocationMethod","modelAsString":true}` |
| `definitions.PublicIPPrefixPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.PublicIPPrefixPropertiesFormat.properties.publicIPAddressVersion['x-ms-enum__added']` | added | `{"name":"IPVersion","modelAsString":true}` |
| `definitions.RecordSet.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ResourceNavigationLinkFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.RouteFilterPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.RouteFilterRulePropertiesFormat.properties.access['x-ms-enum__added']` | added | `{"name":"Access","modelAsString":true}` |
| `definitions.RouteFilterRulePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.RouteMapProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.RoutePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.RouteTablePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.RoutingIntentProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.RoutingRuleCollectionPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.RoutingRulePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.SecurityPartnerProviderPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.SecurityRulePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.SecurityUserConfigurationPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.SecurityUserRuleCollectionPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.SecurityUserRulePropertiesFormat.properties.direction['x-ms-enum__added']` | added | `{"name":"SecurityConfigurationRuleDirection","modelAsString":true}` |
| `definitions.SecurityUserRulePropertiesFormat.properties.protocol['x-ms-enum__added']` | added | `{"name":"SecurityConfigurationRuleProtocol","modelAsString":true}` |
| `definitions.SecurityUserRulePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ServiceAssociationLinkPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ServiceDelegationPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ServiceEndpointPolicyDefinitionPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ServiceEndpointPolicyPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ServiceEndpointPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.SharedKeyProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.StaticMemberProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.SubnetPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VerificationIPFlowResult.properties.access['x-ms-enum__added']` | added | `{"name":"Access","modelAsString":true}` |
| `definitions.VirtualApplianceSiteProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VirtualHubProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VirtualHubRouteTableV2Properties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod['x-ms-enum__added']` | added | `{"name":"IPAllocationMethod","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayIPConfigurationPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayPolicyGroupProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VirtualNetworkPeeringPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VirtualNetworkPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VirtualNetworkTapPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VirtualRouterPeeringProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VirtualRouterPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VirtualWanProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VirtualWanVpnProfileParameters.properties.authenticationMethod['x-ms-enum__added']` | added | `{"name":"AuthenticationMethod","modelAsString":true}` |
| `definitions.VngClientConnectionConfigurationProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VpnClientParameters.properties.authenticationMethod['x-ms-enum__added']` | added | `{"name":"AuthenticationMethod","modelAsString":true}` |
| `definitions.VpnClientRevokedCertificatePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VpnClientRootCertificatePropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VpnConnectionProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VpnConnectionProperties.properties.vpnConnectionProtocolType['x-ms-enum__added']` | added | `{"name":"VirtualNetworkGatewayConnectionProtocol","modelAsString":true}` |
| `definitions.VpnGatewayNatRuleProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VpnGatewayProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VpnServerConfigurationPolicyGroupProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VpnSiteLinkConnectionProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VpnSiteLinkConnectionProperties.properties.vpnConnectionProtocolType['x-ms-enum__added']` | added | `{"name":"VirtualNetworkGatewayConnectionProtocol","modelAsString":true}` |
| `definitions.VpnSiteLinkProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VpnSiteProperties.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.WebApplicationFirewallPolicyPropertiesFormat.properties.provisioningState['x-ms-enum__added']` | added | `{"name":"ProvisioningState","modelAsString":true}` |

### Changes for `exclusiveMinimum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAutoscaleConfiguration.properties.maxCapacity.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayAutoscaleConfiguration.properties.minCapacity.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayConnectionDraining.properties.drainTimeoutInSec.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayLoadDistributionTargetPropertiesFormat.properties.weightPerServer.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.priority.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayRoutingRulePropertiesFormat.properties.priority.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayWebApplicationFirewallConfiguration.properties.fileUploadLimitInMb.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayWebApplicationFirewallConfiguration.properties.maxRequestBodySize.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayWebApplicationFirewallConfiguration.properties.maxRequestBodySizeInKb.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.AzureFirewallApplicationRuleCollectionPropertiesFormat.properties.priority.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.AzureFirewallApplicationRuleProtocol.properties.port.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.AzureFirewallNatRuleCollectionProperties.properties.priority.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.AzureFirewallNetworkRuleCollectionPropertiesFormat.properties.priority.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.ExplicitProxy.properties.httpPort.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.ExplicitProxy.properties.httpsPort.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.ExplicitProxy.properties.pacFilePort.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.FirewallPacketCaptureParameters.properties.durationInSeconds.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.FirewallPacketCaptureParameters.properties.numberOfPacketsToCapture.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.FirewallPolicyRuleApplicationProtocol.properties.port.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.FirewallPolicyRuleCollection.properties.priority.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.FirewallPolicyRuleCollectionGroupDraftProperties.properties.priority.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.FirewallPolicyRuleCollectionGroupProperties.properties.priority.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.PolicySettings.properties.fileUploadLimitInMb.exclusiveMinimum__deleted` | deleted | `false` |
| `definitions.PolicySettings.properties.maxRequestBodySizeInKb.exclusiveMinimum__deleted` | deleted | `false` |

### Changes for `items`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAvailableRequestHeadersResult.items__deleted` | deleted | `{"type":"string"}` |
| `definitions.ApplicationGatewayAvailableResponseHeadersResult.items__deleted` | deleted | `{"type":"string"}` |
| `definitions.ApplicationGatewayAvailableServerVariablesResult.items__deleted` | deleted | `{"type":"string"}` |
| `definitions.AzureFirewallPropertiesFormat.properties.ipGroups.items__added` | added | `{"$ref":"#/definitions/AzureFirewallIpGroups"}` |
| `definitions.ExpressRouteFailoverAllTestDetails.items__deleted` | deleted | `{"$ref":"#/definitions/ExpressRouteFailoverTestDetails"}` |
| `definitions.ExpressRouteFailoverSingleTestDetailsObject.items__deleted` | deleted | `{"$ref":"#/definitions/ExpressRouteFailoverSingleTestDetails"}` |
| `definitions.IDPSQueryObject.properties.filters.items__added` | added | `{"$ref":"#/definitions/FilterItems"}` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.nvaInterfaceConfigurations.items__added` | added | `{"$ref":"#/definitions/NvaInterfaceConfigurationsProperties"}` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayAvailableRequestHeadersResult.properties__added` | added | `{"value":{"type":"array","items":{"type":"string"}}}` |
| `definitions.ApplicationGatewayAvailableResponseHeadersResult.properties__added` | added | `{"value":{"type":"array","items":{"type":"string"}}}` |
| `definitions.ApplicationGatewayAvailableServerVariablesResult.properties__added` | added | `{"value":{"type":"array","items":{"type":"string"}}}` |
| `definitions.BaseAdminRule.properties.properties__added` | added | `{"type":"object","description":"The resource-specific properties for this resource."}` |
| `definitions.BastionHostPropertiesFormat.properties.networkAcls.properties__deleted` | deleted | `{"ipRules":{"type":"array","description":"Sets the IP ACL rules for Developer Bastion Host.","items"...` |
| `definitions.ConnectivityConfigurationProperties.properties.connectivityCapabilities.properties__deleted` | deleted | `{"connectedGroupPrivateEndpointsScale":{"type":"string","description":"Option indicating the scale o...` |
| `definitions.Container.properties__deleted` | deleted | `{}` |
| `definitions.ExpressRouteFailoverAllTestDetails.properties__added` | added | `{"value":{"type":"array","items":{"$ref":"#/definitions/ExpressRouteFailoverTestDetails"}}}` |
| `definitions.ExpressRouteFailoverSingleTestDetailsObject.properties__added` | added | `{"value":{"type":"array","items":{"$ref":"#/definitions/ExpressRouteFailoverSingleTestDetails"}}}` |
| `definitions.ExpressRouteGatewayProperties.properties.autoScaleConfiguration.properties__deleted` | deleted | `{"bounds":{"description":"Minimum and maximum number of scale units to deploy.","properties":{"min":...` |
| `definitions.IpamPoolPrefixAllocation.properties.pool.properties__deleted` | deleted | `{"id":{"type":"string","format":"arm-id","description":"Resource id of the associated Azure IpamPool...` |
| `definitions.ManagedServiceIdentity.properties.userAssignedIdentities.additionalProperties.properties__deleted` | deleted | `{"principalId":{"readOnly":true,"type":"string","description":"The principal id of user assigned ide...` |
| `definitions.NetworkManagerProperties.properties.networkManagerScopes.properties__deleted` | deleted | `{"managementGroups":{"type":"array","description":"List of management groups.","items":{"type":"stri...` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.networkProfile.properties__deleted` | deleted | `{"networkInterfaceConfigurations":{"type":"array","items":{"$ref":"#/definitions/VirtualApplianceNet...` |
| `definitions.PolicySettings.properties.logScrubbing.properties__deleted` | deleted | `{"state":{"type":"string","description":"State of the log scrubbing config. Default value is Enabled...` |
| `definitions.SignaturesOverrides.properties.properties.properties__deleted` | deleted | `{"signatures":{"$ref":"#/definitions/Signatures","type":"object"}}` |

### Changes for `exclusiveMaximum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayConnectionDraining.properties.drainTimeoutInSec.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayLoadDistributionTargetPropertiesFormat.properties.weightPerServer.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.priority.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayRoutingRulePropertiesFormat.properties.priority.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayWebApplicationFirewallConfiguration.properties.maxRequestBodySize.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.ApplicationGatewayWebApplicationFirewallConfiguration.properties.maxRequestBodySizeInKb.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.AzureFirewallApplicationRuleCollectionPropertiesFormat.properties.priority.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.AzureFirewallApplicationRuleProtocol.properties.port.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.AzureFirewallNatRuleCollectionProperties.properties.priority.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.AzureFirewallNetworkRuleCollectionPropertiesFormat.properties.priority.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.ExplicitProxy.properties.httpPort.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.ExplicitProxy.properties.httpsPort.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.ExplicitProxy.properties.pacFilePort.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.FirewallPacketCaptureParameters.properties.durationInSeconds.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.FirewallPacketCaptureParameters.properties.numberOfPacketsToCapture.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.FirewallPolicyRuleApplicationProtocol.properties.port.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.FirewallPolicyRuleCollection.properties.priority.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.FirewallPolicyRuleCollectionGroupDraftProperties.properties.priority.exclusiveMaximum__deleted` | deleted | `false` |
| `definitions.FirewallPolicyRuleCollectionGroupProperties.properties.priority.exclusiveMaximum__deleted` | deleted | `false` |

### Changes for `x-nullable`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayFirewallDisabledRuleGroup.properties.rules.items['x-nullable__deleted']` | deleted | `false` |
| `definitions.AzureFirewallAutoscaleConfiguration.properties.maxCapacity['x-nullable__deleted']` | deleted | `true` |
| `definitions.AzureFirewallAutoscaleConfiguration.properties.minCapacity['x-nullable__deleted']` | deleted | `true` |
| `definitions.DnsSettings.properties.requireProxyForNetworkRules['x-nullable__deleted']` | deleted | `true` |
| `definitions.ExplicitProxy.properties.enableExplicitProxy['x-nullable__deleted']` | deleted | `true` |
| `definitions.ExplicitProxy.properties.enablePacFile['x-nullable__deleted']` | deleted | `true` |
| `definitions.IpAllocationPropertiesFormat.properties.prefixLength['x-nullable__deleted']` | deleted | `true` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.privateIPAddressPrefixLength['x-nullable__deleted']` | deleted | `true` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayWafDynamicManifestResult.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource"}...` |
| `definitions.AzureWebCategory.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource"}...` |
| `definitions.ConnectionMonitorResult.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/Resource"}]` |
| `definitions.DdosProtectionPlan.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/Resource"}]` |
| `definitions.PrivateLinkServiceProperties.properties.autoApproval.allOf__deleted` | deleted | `[{"$ref":"#/definitions/ResourceSet"}]` |
| `definitions.PrivateLinkServiceProperties.properties.visibility.allOf__deleted` | deleted | `[{"$ref":"#/definitions/ResourceSet"}]` |
| `definitions.SignaturesOverrides.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource"}...` |
| `definitions.SwapResource.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource"}...` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGatewayWafDynamicManifestResult.properties.id__deleted` | deleted | `{"type":"string","description":"Resource ID."}` |
| `definitions.AzureWebCategory.properties.id__deleted` | deleted | `{"type":"string","description":"Resource ID."}` |
| `definitions.ConnectionMonitorResult.properties.id__deleted` | deleted | `{"type":"string","description":"ID of the connection monitor.","readOnly":true}` |
| `definitions.ConnectionSharedKeyResult.properties.id__deleted` | deleted | `{"type":"string","description":"The identifier of the shared key for a vpn link connection."}` |
| `definitions.DdosDetectionRule.properties.id__deleted` | deleted | `{"type":"string","description":"The resource ID of the DDoS detection rule.","readOnly":true}` |
| `definitions.DdosProtectionPlan.properties.id__deleted` | deleted | `{"type":"string","description":"Resource ID.","readOnly":true}` |
| `definitions.ExpressRouteProviderPort.properties.id__deleted` | deleted | `{"type":"string","description":"Fully qualified resource ID for the resource.","readOnly":true}` |
| `definitions.ResourceNavigationLink.properties.id__deleted` | deleted | `{"type":"string","description":"Resource navigation link identifier.","readOnly":true}` |
| `definitions.RouteMap.properties.id__deleted` | deleted | `{"type":"string","description":"Resource id.","readOnly":true}` |
| `definitions.SignaturesOverrides.properties.id__deleted` | deleted | `{"type":"string","description":"Will contain the resource id of the signature override resource"}` |
| `definitions.SwapResource.properties.id__deleted` | deleted | `{"type":"string","description":"Resource Id.","readOnly":true}` |

### Changes for `discriminator`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BaseAdminRule.discriminator__deleted` | deleted | `kind` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BgpConnectionProperties.properties.hubVirtualNetworkConnection.readOnly__deleted` | deleted | `false` |
| `definitions.BgpConnectionProperties.properties.peerAsn.readOnly__deleted` | deleted | `false` |
| `definitions.BgpConnectionProperties.properties.peerIp.readOnly__deleted` | deleted | `false` |
| `definitions.BreakOutCategoryPolicies.properties.allow.readOnly__deleted` | deleted | `false` |
| `definitions.BreakOutCategoryPolicies.properties.default.readOnly__deleted` | deleted | `false` |
| `definitions.BreakOutCategoryPolicies.properties.optimize.readOnly__deleted` | deleted | `false` |
| `definitions.DdosSettings.properties.ddosProtectionPlan.readOnly__deleted` | deleted | `false` |
| `definitions.DdosSettings.properties.protectionMode.readOnly__deleted` | deleted | `false` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.links.readOnly__deleted` | deleted | `false` |
| `definitions.FirewallPolicyDraftProperties.properties.basePolicy.readOnly__deleted` | deleted | `false` |
| `definitions.FirewallPolicyPropertiesFormat.properties.basePolicy.readOnly__deleted` | deleted | `false` |
| `definitions.InboundSecurityRuleProperties.properties.rules.readOnly__deleted` | deleted | `false` |
| `definitions.InboundSecurityRules.properties.appliesOn.readOnly__deleted` | deleted | `false` |
| `definitions.InboundSecurityRules.properties.destinationPortRanges.readOnly__deleted` | deleted | `false` |
| `definitions.InternetIngressPublicIpsProperties.properties.id.readOnly__deleted` | deleted | `false` |
| `definitions.IpamPoolProperties.properties.provisioningState.readOnly__deleted` | deleted | `true` |
| `definitions.LoadBalancerBackendAddressPropertiesFormat.properties.loadBalancerFrontendIPConfiguration.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkManagerConnectionProperties.properties.connectionState.readOnly__added` | added | `true` |
| `definitions.NetworkVirtualApplianceConnectionProperties.properties.asn.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualApplianceConnectionProperties.properties.tunnelIdentifier.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.additionalNics.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.bootStrapConfigurationBlobs.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.cloudInitConfiguration.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.cloudInitConfigurationBlobs.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.internetIngressPublicIps.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.networkProfile.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.nvaSku.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.sshPublicKey.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.virtualApplianceAsn.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.virtualHub.readOnly__deleted` | deleted | `false` |
| `definitions.NvaInterfaceConfigurationsProperties.properties.subnet.readOnly__deleted` | deleted | `false` |
| `definitions.NvaInVnetSubnetReferenceProperties.properties.id.readOnly__deleted` | deleted | `false` |
| `definitions.O365BreakOutCategoryPolicies.properties.allow.readOnly__deleted` | deleted | `false` |
| `definitions.O365BreakOutCategoryPolicies.properties.default.readOnly__deleted` | deleted | `false` |
| `definitions.O365BreakOutCategoryPolicies.properties.optimize.readOnly__deleted` | deleted | `false` |
| `definitions.O365PolicyProperties.properties.breakOutCategories.readOnly__deleted` | deleted | `false` |
| `definitions.Office365PolicyProperties.properties.breakOutCategories.readOnly__deleted` | deleted | `false` |
| `definitions.P2SConnectionConfigurationProperties.properties.configurationPolicyGroupAssociations.readOnly__deleted` | deleted | `false` |
| `definitions.PrivateLinkServiceProperties.properties.destinationIPAddress.readOnly__deleted` | deleted | `false` |
| `definitions.ReachabilityAnalysisIntentProperties.properties.provisioningState.readOnly__deleted` | deleted | `true` |
| `definitions.ReachabilityAnalysisRunProperties.properties.provisioningState.readOnly__deleted` | deleted | `true` |
| `definitions.RoutingIntentProperties.properties.routingPolicies.readOnly__deleted` | deleted | `false` |
| `definitions.StaticCidrProperties.properties.provisioningState.readOnly__deleted` | deleted | `true` |
| `definitions.VerifierWorkspaceProperties.properties.provisioningState.readOnly__deleted` | deleted | `true` |
| `definitions.VirtualApplianceAdditionalNicProperties.properties.hasPublicIp.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualApplianceAdditionalNicProperties.properties.name.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualApplianceIPConfiguration.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualApplianceIPConfigurationProperties.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualApplianceNetworkInterfaceConfiguration.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualApplianceNetworkInterfaceConfigurationProperties.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualApplianceSiteProperties.properties.addressPrefix.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualApplianceSiteProperties.properties.o365Policy.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualApplianceSkuProperties.properties.bundledScaleUnit.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualApplianceSkuProperties.properties.marketPlaceVersion.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualApplianceSkuProperties.properties.vendor.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualHubProperties.properties.allowBranchToBranchTraffic.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualHubProperties.properties.virtualRouterAsn.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualHubProperties.properties.virtualRouterIps.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualNetworkListUsageResult.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.VirtualNetworkPropertiesFormat.properties.privateEndpointVNetPolicies.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualRouterPeeringProperties.properties.peerAsn.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualRouterPeeringProperties.properties.peerIp.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualRouterPropertiesFormat.properties.hostedGateway.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualRouterPropertiesFormat.properties.hostedSubnet.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualRouterPropertiesFormat.properties.virtualRouterAsn.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualRouterPropertiesFormat.properties.virtualRouterIps.readOnly__deleted` | deleted | `false` |
| `definitions.VpnSiteProperties.properties.o365Policy.readOnly__deleted` | deleted | `false` |
| `definitions.WebApplicationFirewallPolicyListResult.properties.value.readOnly__deleted` | deleted | `true` |

### Changes for `x-ms-external`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudError['x-ms-external__deleted']` | deleted | `true` |
| `definitions.CloudErrorBody['x-ms-external__deleted']` | deleted | `true` |

### Changes for `title`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CommonErrorResponse.title__deleted` | deleted | `Error response` |
| `definitions.ErrorResponse.properties.error.title__deleted` | deleted | `Error` |
| `definitions.ExpressRouteLink.title__deleted` | deleted | `ExpressRouteLink` |
| `definitions.ExpressRouteLinkListResult.title__deleted` | deleted | `ExpressRouteLink List Result` |
| `definitions.ExpressRouteLinkMacSecConfig.title__deleted` | deleted | `Definition of ExpressRouteLink Mac Security configuration.` |
| `definitions.ExpressRouteLinkPropertiesFormat.title__deleted` | deleted | `ExpressRouteLink Resource Properties` |
| `definitions.ExpressRoutePort.title__deleted` | deleted | `ExpressRoute Port` |
| `definitions.ExpressRoutePortAuthorization.title__deleted` | deleted | `ExpressRoute Port Authorization` |
| `definitions.ExpressRoutePortAuthorizationListResult.title__deleted` | deleted | `ExpressRoute Port Authorization List Result` |
| `definitions.ExpressRoutePortAuthorizationPropertiesFormat.title__deleted` | deleted | `ExpressRoute Port Authorization Properties` |
| `definitions.ExpressRoutePortListResult.title__deleted` | deleted | `ExpressRoute Port List Result` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.links.title__deleted` | deleted | `ExpressRouteLink Sub-Resources` |
| `definitions.ExpressRoutePortPropertiesFormat.title__deleted` | deleted | `ExpressRoutePort Properties` |
| `definitions.ExpressRoutePortsLocation.title__deleted` | deleted | `ExpressRoutePorts Peering Location` |
| `definitions.ExpressRoutePortsLocationBandwidths.title__deleted` | deleted | `ExpressRoutePorts Location Bandwidths` |
| `definitions.ExpressRoutePortsLocationListResult.title__deleted` | deleted | `ExpressRoutePorts Location List Result` |
| `definitions.ExpressRoutePortsLocationPropertiesFormat.title__deleted` | deleted | `ExpressRoutePorts Location Properties` |
| `definitions.InternetIngressPublicIpsProperties.title__deleted` | deleted | `Internet Ingress Public Ip Properties` |
| `definitions.NetworkVirtualApplianceSku.title__deleted` | deleted | `Available NetworkVirtualApplianceSkus` |
| `definitions.NetworkVirtualApplianceSkuInstances.title__deleted` | deleted | `Network Virtual Appliance Sku Instances` |
| `definitions.NetworkVirtualApplianceSkuPropertiesFormat.title__deleted` | deleted | `Network Virtual Appliance Sku Properties` |
| `definitions.NvaInVnetSubnetReferenceProperties.title__deleted` | deleted | `Subnet references where the NVA NICS will be deployed` |
| `definitions.VirtualApplianceAdditionalNicProperties.title__deleted` | deleted | `Network Virtual Appliance Additional Nic Properties` |
| `definitions.WebApplicationFirewallPolicyPropertiesFormat.properties.resourceState.title__deleted` | deleted | `Resource status of the policy.` |

### Changes for `x-ms-mutability`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectionMonitorResult.properties.location['x-ms-mutability__added']` | added | `["create","read"]` |
| `definitions.DdosProtectionPlan.properties.location['x-ms-mutability__added']` | added | `["create","read"]` |

### Changes for `x-ms-azure-resource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerBackendAddressPropertiesFormat.properties.ipAddress['x-ms-azure-resource__deleted']` | deleted | `false` |

### Changes for `nextLink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkWatcherListResult.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |

### Changes for `x-ms-client-flatten`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspAccessRuleProperties.properties.networkSecurityPerimeters.items['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.NspAccessRuleProperties.properties.subscriptions.items['x-ms-client-flatten__deleted']` | deleted | `true` |

### Changes for `uniqueItems`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspLinkProperties.properties.localInboundProfiles.uniqueItems__deleted` | deleted | `true` |
| `definitions.NspLinkProperties.properties.localOutboundProfiles.uniqueItems__deleted` | deleted | `true` |
| `definitions.NspLinkProperties.properties.remoteInboundProfiles.uniqueItems__deleted` | deleted | `true` |
| `definitions.NspLinkProperties.properties.remoteOutboundProfiles.uniqueItems__deleted` | deleted | `true` |
| `definitions.NspLinkReferenceProperties.properties.localInboundProfiles.uniqueItems__deleted` | deleted | `true` |
| `definitions.NspLinkReferenceProperties.properties.localOutboundProfiles.uniqueItems__deleted` | deleted | `true` |

### Changes for `x-ms-secret`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RadiusAuthServer.properties.radiusServerSecret['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.RadiusServer.properties.radiusServerSecret['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.SharedKeyProperties.properties.sharedKey['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.sharedKey['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.VpnClientConfiguration.properties.radiusServerSecret['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.VpnServerConfigurationProperties.properties.radiusServerSecret['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.VpnSiteLinkConnectionProperties.properties.sharedKey['x-ms-secret__deleted']` | deleted | `true` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.ActiveBaseSecurityAdminRule.properties.ruleCollectionAppliesToGroups.items.$ref` | `./networkManagerSecurityAdminConfiguration.json#/definitions/NetworkManagerSecurityGroupItem` | `#/definitions/NetworkManagerSecurityGroupItem` |
| `definitions.ActiveBaseSecurityAdminRule.properties.ruleGroups.items.$ref` | `./networkManagerEffectiveConfiguration.json#/definitions/ConfigurationGroup` | `#/definitions/ConfigurationGroup` |
| `definitions.ActiveConnectivityConfiguration.allOf[0].$ref` | `./networkManagerEffectiveConfiguration.json#/definitions/EffectiveConnectivityConfiguration` | `#/definitions/EffectiveConnectivityConfiguration` |
| `definitions.ActiveDefaultSecurityAdminRule.properties.properties.$ref` | `./networkManagerSecurityAdminConfiguration.json#/definitions/DefaultAdminPropertiesFormat` | `#/definitions/DefaultAdminPropertiesFormat` |
| `definitions.ActiveSecurityAdminRule.properties.properties.$ref` | `./networkManagerSecurityAdminConfiguration.json#/definitions/AdminPropertiesFormat` | `#/definitions/AdminPropertiesFormat` |
| `definitions.AdminRuleCollection.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.ApplicationGateway.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.ApplicationGateway.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.ApplicationGateway.properties.identity.$ref` | `./network.json#/definitions/ManagedServiceIdentity` | `#/definitions/ManagedServiceIdentity` |
| `definitions.ApplicationGateway.properties.zones.description` | `A list of availability zones denoting where the resource needs to come from.` | `The availability zones.` |
| `definitions.ApplicationGatewayAuthenticationCertificate.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayAuthenticationCertificatePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the authentication certificate resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewayAvailableRequestHeadersResult.type` | `array` | `object` |
| `definitions.ApplicationGatewayAvailableResponseHeadersResult.type` | `array` | `object` |
| `definitions.ApplicationGatewayAvailableServerVariablesResult.type` | `array` | `object` |
| `definitions.ApplicationGatewayAvailableSslOptions.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.ApplicationGatewayAvailableSslOptionsPropertiesFormat.properties.predefinedPolicies.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayBackendAddressPool.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayBackendAddressPoolPropertiesFormat.properties.backendIPConfigurations.items.$ref` | `./networkInterface.json#/definitions/NetworkInterfaceIPConfiguration` | `#/definitions/NetworkInterfaceIPConfiguration` |
| `definitions.ApplicationGatewayBackendAddressPoolPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the backend address pool resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewayBackendHealthServer.properties.ipConfiguration.$ref` | `./networkInterface.json#/definitions/NetworkInterfaceIPConfiguration` | `#/definitions/NetworkInterfaceIPConfiguration` |
| `definitions.ApplicationGatewayBackendHttpSettings.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayBackendHttpSettingsPropertiesFormat.properties.authenticationCertificates.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayBackendHttpSettingsPropertiesFormat.properties.probe.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayBackendHttpSettingsPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the backend HTTP settings resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewayBackendHttpSettingsPropertiesFormat.properties.trustedRootCertificates.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayBackendSettings.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayBackendSettingsPropertiesFormat.properties.probe.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayBackendSettingsPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the backend HTTP settings resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewayBackendSettingsPropertiesFormat.properties.trustedRootCertificates.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayEntraJWTValidationConfig.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayEntraJWTValidationConfigPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the entra jwt validation configuration resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewayFirewallManifestRuleSet.properties.ruleGroups.items.$ref` | `applicationGateway.json#/definitions/ApplicationGatewayFirewallRuleGroup` | `#/definitions/ApplicationGatewayFirewallRuleGroup` |
| `definitions.ApplicationGatewayFirewallRuleSet.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.ApplicationGatewayFirewallRuleSetPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the web application firewall rule set.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewayFrontendIPConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.description` | `The private IP address allocation method.` | `IP address allocation method.` |
| `definitions.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.properties.privateLinkConfiguration.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the frontend IP configuration resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.properties.publicIPAddress.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayFrontendIPConfigurationPropertiesFormat.properties.subnet.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayFrontendPort.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayFrontendPortPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the frontend port resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewayHttpListener.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayHttpListenerPropertiesFormat.properties.firewallPolicy.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayHttpListenerPropertiesFormat.properties.frontendIPConfiguration.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayHttpListenerPropertiesFormat.properties.frontendPort.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayHttpListenerPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the HTTP listener resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewayHttpListenerPropertiesFormat.properties.sslCertificate.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayHttpListenerPropertiesFormat.properties.sslProfile.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayIPConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayIPConfigurationPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the application gateway IP configuration resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewayIPConfigurationPropertiesFormat.properties.subnet.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayListener.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayListenerPropertiesFormat.properties.frontendIPConfiguration.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayListenerPropertiesFormat.properties.frontendPort.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayListenerPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the listener resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewayListenerPropertiesFormat.properties.sslCertificate.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayListenerPropertiesFormat.properties.sslProfile.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayLoadDistributionPolicy.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayLoadDistributionPolicyPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the Load Distribution Policy resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewayLoadDistributionTarget.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayLoadDistributionTargetPropertiesFormat.properties.backendAddressPool.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayOnDemandProbe.properties.backendAddressPool.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayOnDemandProbe.properties.backendHttpSettings.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayPathRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayPathRulePropertiesFormat.properties.backendAddressPool.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayPathRulePropertiesFormat.properties.backendHttpSettings.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayPathRulePropertiesFormat.properties.firewallPolicy.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayPathRulePropertiesFormat.properties.loadDistributionPolicy.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayPathRulePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the path rule resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewayPathRulePropertiesFormat.properties.redirectConfiguration.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayPathRulePropertiesFormat.properties.rewriteRuleSet.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayPrivateEndpointConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.ApplicationGatewayPrivateEndpointConnection.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.ApplicationGatewayPrivateEndpointConnectionProperties.properties.privateEndpoint.$ref` | `./privateEndpoint.json#/definitions/PrivateEndpoint` | `#/definitions/PrivateEndpoint` |
| `definitions.ApplicationGatewayPrivateEndpointConnectionProperties.properties.privateLinkServiceConnectionState.$ref` | `./privateLinkService.json#/definitions/PrivateLinkServiceConnectionState` | `#/definitions/PrivateLinkServiceConnectionState` |
| `definitions.ApplicationGatewayPrivateEndpointConnectionProperties.properties.provisioningState.description` | `The provisioning state of the application gateway private endpoint connection resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewayPrivateLinkConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayPrivateLinkConfigurationProperties.properties.provisioningState.description` | `The provisioning state of the application gateway private link configuration.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewayPrivateLinkIpConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayPrivateLinkIpConfigurationProperties.properties.privateIPAllocationMethod.description` | `The private IP address allocation method.` | `IP address allocation method.` |
| `definitions.ApplicationGatewayPrivateLinkIpConfigurationProperties.properties.provisioningState.description` | `The provisioning state of the application gateway private link IP configuration.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewayPrivateLinkIpConfigurationProperties.properties.subnet.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayPrivateLinkResource.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayProbe.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayProbePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the probe resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewayPropertiesFormat.properties.firewallPolicy.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the application gateway resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewayRedirectConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayRedirectConfigurationPropertiesFormat.properties.pathRules.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayRedirectConfigurationPropertiesFormat.properties.requestRoutingRules.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayRedirectConfigurationPropertiesFormat.properties.targetListener.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayRedirectConfigurationPropertiesFormat.properties.urlPathMaps.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayRequestRoutingRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.backendAddressPool.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.backendHttpSettings.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.entraJWTValidationConfig.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.httpListener.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.loadDistributionPolicy.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the request routing rule resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.redirectConfiguration.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.rewriteRuleSet.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayRequestRoutingRulePropertiesFormat.properties.urlPathMap.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayRewriteRuleSet.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayRewriteRuleSetPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the rewrite rule set resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewayRoutingRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayRoutingRulePropertiesFormat.properties.backendAddressPool.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayRoutingRulePropertiesFormat.properties.backendSettings.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayRoutingRulePropertiesFormat.properties.listener.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayRoutingRulePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the request routing rule resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewaySslCertificate.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewaySslCertificatePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the SSL certificate resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewaySslPredefinedPolicy.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewaySslProfile.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewaySslProfilePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the HTTP listener resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewaySslProfilePropertiesFormat.properties.trustedClientCertificates.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayTrustedClientCertificate.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayTrustedClientCertificatePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the trusted client certificate resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewayTrustedRootCertificate.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayTrustedRootCertificatePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the trusted root certificate resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationGatewayUrlPathMap.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayUrlPathMapPropertiesFormat.properties.defaultBackendAddressPool.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayUrlPathMapPropertiesFormat.properties.defaultBackendHttpSettings.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayUrlPathMapPropertiesFormat.properties.defaultLoadDistributionPolicy.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayUrlPathMapPropertiesFormat.properties.defaultRedirectConfiguration.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayUrlPathMapPropertiesFormat.properties.defaultRewriteRuleSet.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ApplicationGatewayUrlPathMapPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the URL path map resource.` | `Provisioning states of a resource.` |
| `definitions.ApplicationSecurityGroup.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.ApplicationSecurityGroup.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.ApplicationSecurityGroupPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the application security group resource.` | `Provisioning states of a resource.` |
| `definitions.AuthorizationPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the authorization resource.` | `Provisioning states of a resource.` |
| `definitions.AzureFirewall.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.AzureFirewall.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.AzureFirewall.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `#/definitions/ExtendedLocation` |
| `definitions.AzureFirewall.properties.zones.description` | `A list of availability zones denoting where the resource needs to come from.` | `The availability zones.` |
| `definitions.AzureFirewallApplicationRuleCollection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.AzureFirewallApplicationRuleCollectionPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the application rule collection resource.` | `Provisioning states of a resource.` |
| `definitions.AzureFirewallFqdnTag.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.AzureFirewallFqdnTagPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the Azure firewall FQDN tag resource.` | `Provisioning states of a resource.` |
| `definitions.AzureFirewallIPConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.AzureFirewallIPConfigurationPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the Azure firewall IP configuration resource.` | `Provisioning states of a resource.` |
| `definitions.AzureFirewallIPConfigurationPropertiesFormat.properties.publicIPAddress.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.AzureFirewallIPConfigurationPropertiesFormat.properties.subnet.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.AzureFirewallNatRuleCollection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.AzureFirewallNatRuleCollectionProperties.properties.provisioningState.description` | `The provisioning state of the NAT rule collection resource.` | `Provisioning states of a resource.` |
| `definitions.AzureFirewallNetworkRuleCollection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.AzureFirewallNetworkRuleCollectionPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the network rule collection resource.` | `Provisioning states of a resource.` |
| `definitions.AzureFirewallPropertiesFormat.properties.firewallPolicy.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.AzureFirewallPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the Azure firewall resource.` | `Provisioning states of a resource.` |
| `definitions.AzureFirewallPropertiesFormat.properties.virtualHub.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.AzureWebCategory.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.BackendAddressPool.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.BackendAddressPool.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.backendIPConfigurations.items.$ref` | `./networkInterface.json#/definitions/NetworkInterfaceIPConfiguration` | `#/definitions/NetworkInterfaceIPConfiguration` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.inboundNatRules.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.loadBalancingRules.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.outboundRule.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.outboundRules.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the backend address pool resource.` | `Provisioning states of a resource.` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.virtualNetwork.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.BaseAdminRule.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.BastionHost.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.BastionHost.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.BastionHost.properties.zones.description` | `A list of availability zones denoting where the resource needs to come from.` | `The availability zones.` |
| `definitions.BastionHostIPConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.BastionHostIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.description` | `Private IP allocation method.` | `IP address allocation method.` |
| `definitions.BastionHostIPConfigurationPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the bastion host IP configuration resource.` | `Provisioning states of a resource.` |
| `definitions.BastionHostIPConfigurationPropertiesFormat.properties.publicIPAddress.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.BastionHostIPConfigurationPropertiesFormat.properties.subnet.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.BastionHostPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the bastion host resource.` | `Provisioning states of a resource.` |
| `definitions.BastionHostPropertiesFormat.properties.virtualNetwork.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.BgpConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.BgpConnection.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.BgpConnectionProperties.properties.hubVirtualNetworkConnection.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.BgpConnectionProperties.properties.provisioningState.description` | `The provisioning state of the resource.` | `Provisioning states of a resource.` |
| `definitions.BgpServiceCommunity.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.ConfigurationGroup.properties.properties.$ref` | `./networkManagerGroup.json#/definitions/NetworkGroupProperties` | `#/definitions/NetworkGroupProperties` |
| `definitions.ConnectionMonitorHttpConfiguration.properties.method['x-ms-enum'].name` | `HTTPConfigurationMethod` | `HttpConfigurationMethod` |
| `definitions.ConnectionMonitorHttpConfiguration.properties.requestHeaders.items.$ref` | `#/definitions/HTTPHeader` | `#/definitions/HttpHeader` |
| `definitions.ConnectionMonitorResult.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.ConnectionMonitorResult.properties.location.description` | `Connection monitor location.` | `The geo-location where the resource lives` |
| `definitions.ConnectionMonitorResult.properties.tags.description` | `Connection monitor tags.` | `Resource tags.` |
| `definitions.ConnectionMonitorResultProperties.properties.provisioningState.description` | `The provisioning state of the connection monitor.` | `Provisioning states of a resource.` |
| `definitions.ConnectionSharedKey.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ConnectionSharedKeyResult.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.ConnectivityConfiguration.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.ConnectivityConfigurationProperties.properties.appliesToGroups.items.$ref` | `#/definitions/connectivityGroupItem` | `#/definitions/ConnectivityGroupItem` |
| `definitions.ConnectivityConfigurationProperties.properties.provisioningState.description` | `The provisioning state of the connectivity configuration resource.` | `Provisioning states of a resource.` |
| `definitions.ConnectivityParameters.properties.preferredIPVersion.description` | `Preferred IP version of the connection.` | `IP address version.` |
| `definitions.Container.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ContainerNetworkInterface.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ContainerNetworkInterfaceConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ContainerNetworkInterfaceConfigurationPropertiesFormat.properties.containerNetworkInterfaces.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ContainerNetworkInterfaceConfigurationPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the container network interface configuration resource.` | `Provisioning states of a resource.` |
| `definitions.ContainerNetworkInterfaceIpConfigurationPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the container network interface IP configuration resource.` | `Provisioning states of a resource.` |
| `definitions.ContainerNetworkInterfacePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the container network interface resource.` | `Provisioning states of a resource.` |
| `definitions.CustomIpPrefix.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.CustomIpPrefix.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.CustomIpPrefix.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `#/definitions/ExtendedLocation` |
| `definitions.CustomIpPrefix.properties.zones.description` | `A list of availability zones denoting the IP allocated for the resource needs to come from.` | `The availability zones.` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.childCustomIpPrefixes.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.customIpPrefixParent.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the custom IP prefix resource.` | `Provisioning states of a resource.` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.publicIpPrefixes.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.DdosCustomPolicy.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.DdosCustomPolicy.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.DdosCustomPolicyPropertiesFormat.properties.frontEndIpConfiguration.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.DdosCustomPolicyPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the DDoS custom policy resource.` | `Provisioning states of a resource.` |
| `definitions.DdosDetectionRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.DdosDetectionRulePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the DDoS detection rule.` | `Provisioning states of a resource.` |
| `definitions.DdosProtectionPlan.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.DdosProtectionPlan.properties.location.description` | `Resource location.` | `The geo-location where the resource lives` |
| `definitions.DdosProtectionPlanPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the DDoS protection plan resource.` | `Provisioning states of a resource.` |
| `definitions.DdosProtectionPlanPropertiesFormat.properties.publicIPAddresses.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.DdosProtectionPlanPropertiesFormat.properties.virtualNetworks.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.DdosSettings.properties.ddosProtectionPlan.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.Delegation.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.DscpConfiguration.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.DscpConfiguration.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.DscpConfigurationPropertiesFormat.properties.associatedNetworkInterfaces.items.$ref` | `./networkInterface.json#/definitions/NetworkInterface` | `#/definitions/NetworkInterface` |
| `definitions.DscpConfigurationPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the DSCP Configuration resource.` | `Provisioning states of a resource.` |
| `definitions.EffectiveBaseSecurityAdminRule.properties.ruleCollectionAppliesToGroups.items.$ref` | `./networkManagerSecurityAdminConfiguration.json#/definitions/NetworkManagerSecurityGroupItem` | `#/definitions/NetworkManagerSecurityGroupItem` |
| `definitions.EffectiveConnectivityConfiguration.properties.properties.$ref` | `./networkManagerConnectivityConfiguration.json#/definitions/ConnectivityConfigurationProperties` | `#/definitions/ConnectivityConfigurationProperties` |
| `definitions.EffectiveDefaultSecurityAdminRule.properties.properties.$ref` | `./networkManagerSecurityAdminConfiguration.json#/definitions/DefaultAdminPropertiesFormat` | `#/definitions/DefaultAdminPropertiesFormat` |
| `definitions.EffectiveNetworkSecurityGroup.properties.networkSecurityGroup.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.EffectiveNetworkSecurityGroupAssociation.properties.networkInterface.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.EffectiveNetworkSecurityGroupAssociation.properties.networkManager.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.EffectiveNetworkSecurityGroupAssociation.properties.subnet.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.EffectiveNetworkSecurityRule.properties.direction.description` | `The direction of the rule.` | `The direction of the rule. The direction specifies if rule will be evaluated on incoming or outgoing traffic.` |
| `definitions.EffectiveSecurityAdminRule.properties.properties.$ref` | `./networkManagerSecurityAdminConfiguration.json#/definitions/AdminPropertiesFormat` | `#/definitions/AdminPropertiesFormat` |
| `definitions.EndpointServiceResult.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ErrorResponse.properties.error.$ref` | `./network.json#/definitions/ErrorDetails` | `#/definitions/ErrorDetails` |
| `definitions.ExpressRouteCircuit.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.ExpressRouteCircuit.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.ExpressRouteCircuitAuthorization.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.ExpressRouteCircuitAuthorization.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.ExpressRouteCircuitConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.ExpressRouteCircuitConnection.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.ExpressRouteCircuitConnectionPropertiesFormat.properties.expressRouteCircuitPeering.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ExpressRouteCircuitConnectionPropertiesFormat.properties.peerExpressRouteCircuitPeering.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ExpressRouteCircuitConnectionPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the express route circuit connection resource.` | `Provisioning states of a resource.` |
| `definitions.ExpressRouteCircuitPeering.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.ExpressRouteCircuitPeering.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.ExpressRouteCircuitPeeringPropertiesFormat.properties.expressRouteConnection.$ref` | `./virtualWan.json#/definitions/ExpressRouteConnectionId` | `#/definitions/ExpressRouteConnectionId` |
| `definitions.ExpressRouteCircuitPeeringPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the express route circuit peering resource.` | `Provisioning states of a resource.` |
| `definitions.ExpressRouteCircuitPeeringPropertiesFormat.properties.routeFilter.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ExpressRouteCircuitPropertiesFormat.properties.expressRoutePort.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ExpressRouteCircuitPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the express route circuit resource.` | `Provisioning states of a resource.` |
| `definitions.ExpressRouteConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ExpressRouteConnectionProperties.properties.provisioningState.description` | `The provisioning state of the express route connection resource.` | `Provisioning states of a resource.` |
| `definitions.ExpressRouteCrossConnection.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.ExpressRouteCrossConnection.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.ExpressRouteCrossConnectionPeering.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ExpressRouteCrossConnectionPeeringProperties.properties.ipv6PeeringConfig.$ref` | `./expressRouteCircuit.json#/definitions/Ipv6ExpressRouteCircuitPeeringConfig` | `#/definitions/Ipv6ExpressRouteCircuitPeeringConfig` |
| `definitions.ExpressRouteCrossConnectionPeeringProperties.properties.microsoftPeeringConfig.$ref` | `./expressRouteCircuit.json#/definitions/ExpressRouteCircuitPeeringConfig` | `#/definitions/ExpressRouteCircuitPeeringConfig` |
| `definitions.ExpressRouteCrossConnectionPeeringProperties.properties.provisioningState.description` | `The provisioning state of the express route cross connection peering resource.` | `Provisioning states of a resource.` |
| `definitions.ExpressRouteCrossConnectionPeeringProperties.properties.state.description` | `The peering state.` | `The state of peering.` |
| `definitions.ExpressRouteCrossConnectionProperties.properties.provisioningState.description` | `The provisioning state of the express route cross connection resource.` | `Provisioning states of a resource.` |
| `definitions.ExpressRouteCrossConnectionProperties.properties.serviceProviderProvisioningState.description` | `The provisioning state of the circuit in the connectivity provider system.` | `The ServiceProviderProvisioningState state of the resource.` |
| `definitions.ExpressRouteFailoverAllTestDetails.type` | `array` | `object` |
| `definitions.ExpressRouteFailoverSingleTestDetailsObject.type` | `array` | `object` |
| `definitions.ExpressRouteGateway.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.ExpressRouteGateway.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.ExpressRouteGatewayProperties.properties.provisioningState.description` | `The provisioning state of the express route gateway resource.` | `Provisioning states of a resource.` |
| `definitions.ExpressRouteLink.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ExpressRouteLinkPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the express route link resource.` | `Provisioning states of a resource.` |
| `definitions.ExpressRoutePort.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.ExpressRoutePort.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.ExpressRoutePort.properties.identity.$ref` | `./network.json#/definitions/ManagedServiceIdentity` | `#/definitions/ManagedServiceIdentity` |
| `definitions.ExpressRoutePortAuthorization.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.ExpressRoutePortAuthorization.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.ExpressRoutePortAuthorizationPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the authorization resource.` | `Provisioning states of a resource.` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.circuits.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ExpressRoutePortPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the express route port resource.` | `Provisioning states of a resource.` |
| `definitions.ExpressRoutePortsLocation.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.ExpressRoutePortsLocationPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the express route port location resource.` | `Provisioning states of a resource.` |
| `definitions.ExpressRouteProviderPort.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.ExpressRouteProviderPort.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.ExpressRouteServiceProvider.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.ExpressRouteServiceProviderPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the express route service provider resource.` | `Provisioning states of a resource.` |
| `definitions.FirewallPacketCaptureParameters.properties.operation.description` | `The packet capture operation to perform. If the Start operation is selected, please provide all the fields in the firewallPacketCaptureParameters to successfully initiate the packet capture. If the Status or Stop operation is selected, only the operation field is required; all other fields in the firewallPacketCaptureParameters can be omitted to successfully retrieve the capture status or stop the capture.` | `The Azure Firewall packet capture operation to perform` |
| `definitions.FirewallPolicy.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.FirewallPolicy.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.FirewallPolicy.properties.identity.$ref` | `./network.json#/definitions/ManagedServiceIdentity` | `#/definitions/ManagedServiceIdentity` |
| `definitions.FirewallPolicyDraft.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.FirewallPolicyDraftProperties.properties.basePolicy.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.FirewallPolicyDraftProperties.properties.snat.$ref` | `#/definitions/FirewallPolicySNAT` | `#/definitions/FirewallPolicySnat` |
| `definitions.FirewallPolicyDraftProperties.properties.threatIntelMode.description` | `The operation mode for Threat Intelligence.` | `The operation mode for Threat Intel.` |
| `definitions.FirewallPolicyLogAnalyticsResources.properties.defaultWorkspaceId.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.FirewallPolicyLogAnalyticsWorkspace.properties.workspaceId.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.FirewallPolicyPropertiesFormat.properties.basePolicy.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.FirewallPolicyPropertiesFormat.properties.childPolicies.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.FirewallPolicyPropertiesFormat.properties.firewalls.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.FirewallPolicyPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the firewall policy resource.` | `Provisioning states of a resource.` |
| `definitions.FirewallPolicyPropertiesFormat.properties.ruleCollectionGroups.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.FirewallPolicyPropertiesFormat.properties.snat.$ref` | `#/definitions/FirewallPolicySNAT` | `#/definitions/FirewallPolicySnat` |
| `definitions.FirewallPolicyPropertiesFormat.properties.threatIntelMode.description` | `The operation mode for Threat Intelligence.` | `The operation mode for Threat Intel.` |
| `definitions.FirewallPolicyRuleCollectionGroup.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.FirewallPolicyRuleCollectionGroup.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.FirewallPolicyRuleCollectionGroupDraft.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.FirewallPolicyRuleCollectionGroupProperties.properties.provisioningState.description` | `The provisioning state of the firewall policy rule collection group resource.` | `Provisioning states of a resource.` |
| `definitions.FlowLog.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.FlowLog.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.FlowLog.properties.identity.$ref` | `./network.json#/definitions/ManagedServiceIdentity` | `#/definitions/ManagedServiceIdentity` |
| `definitions.FlowLogInformation.properties.identity.$ref` | `./network.json#/definitions/ManagedServiceIdentity` | `#/definitions/ManagedServiceIdentity` |
| `definitions.FlowLogPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the flow log.` | `Provisioning states of a resource.` |
| `definitions.FrontendIPConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.FrontendIPConfiguration.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.FrontendIPConfiguration.properties.zones.description` | `A list of availability zones denoting the IP allocated for the resource needs to come from.` | `The availability zones.` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.gatewayLoadBalancer.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.inboundNatPools.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.inboundNatRules.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.loadBalancingRules.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.outboundRules.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.privateIPAddressVersion.description` | `Whether the specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4.` | `IP address version.` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.description` | `The Private IP allocation method.` | `IP address allocation method.` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the frontend IP configuration resource.` | `Provisioning states of a resource.` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.publicIPAddress.$ref` | `./publicIpAddress.json#/definitions/PublicIPAddress` | `#/definitions/PublicIPAddress` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.publicIPPrefix.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.subnet.$ref` | `./virtualNetwork.json#/definitions/Subnet` | `#/definitions/Subnet` |
| `definitions.HubIpConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.HubIpConfiguration.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.HubIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.description` | `The private IP address allocation method.` | `IP address allocation method.` |
| `definitions.HubIPConfigurationPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the IP configuration resource.` | `Provisioning states of a resource.` |
| `definitions.HubIPConfigurationPropertiesFormat.properties.publicIPAddress.$ref` | `./publicIpAddress.json#/definitions/PublicIPAddress` | `#/definitions/PublicIPAddress` |
| `definitions.HubIPConfigurationPropertiesFormat.properties.subnet.$ref` | `./virtualNetwork.json#/definitions/Subnet` | `#/definitions/Subnet` |
| `definitions.HubRouteTable.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.HubRouteTable.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.HubRouteTableProperties.properties.provisioningState.description` | `The provisioning state of the RouteTable resource.` | `Provisioning states of a resource.` |
| `definitions.HubVirtualNetworkConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.HubVirtualNetworkConnectionProperties.properties.provisioningState.description` | `The provisioning state of the hub virtual network connection resource.` | `Provisioning states of a resource.` |
| `definitions.HubVirtualNetworkConnectionProperties.properties.remoteVirtualNetwork.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.IDPSQueryObject.properties.filters.type` | `object` | `array` |
| `definitions.InboundNatPool.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.InboundNatPoolPropertiesFormat.properties.frontendIPConfiguration.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.InboundNatPoolPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the inbound NAT pool resource.` | `Provisioning states of a resource.` |
| `definitions.InboundNatRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.InboundNatRule.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.InboundNatRulePropertiesFormat.properties.backendAddressPool.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.InboundNatRulePropertiesFormat.properties.backendIPConfiguration.$ref` | `./networkInterface.json#/definitions/NetworkInterfaceIPConfiguration` | `#/definitions/NetworkInterfaceIPConfiguration` |
| `definitions.InboundNatRulePropertiesFormat.properties.frontendIPConfiguration.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.InboundNatRulePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the inbound NAT rule resource.` | `Provisioning states of a resource.` |
| `definitions.InboundSecurityRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.InboundSecurityRule.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.InboundSecurityRuleProperties.properties.provisioningState.description` | `The provisioning state of the resource.` | `Provisioning states of a resource.` |
| `definitions.IpAllocation.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.IpAllocation.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.IpAllocationPropertiesFormat.properties.prefixType.description` | `The address prefix Type for the IpAllocation.` | `IP address version.` |
| `definitions.IpAllocationPropertiesFormat.properties.subnet.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.IpAllocationPropertiesFormat.properties.virtualNetwork.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.IpamPool.allOf[0].$ref` | `./network.json#/definitions/CommonTrackedResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/TrackedResource` |
| `definitions.IpamPool.properties.etag.description` | `String representing unique etag for the resource document.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.IPConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.IPConfigurationProfile.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.IPConfigurationProfilePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the IP configuration profile resource.` | `Provisioning states of a resource.` |
| `definitions.IPConfigurationProfilePropertiesFormat.properties.subnet.$ref` | `./virtualNetwork.json#/definitions/Subnet` | `#/definitions/Subnet` |
| `definitions.IPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.description` | `The private IP address allocation method.` | `IP address allocation method.` |
| `definitions.IPConfigurationPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the IP configuration resource.` | `Provisioning states of a resource.` |
| `definitions.IPConfigurationPropertiesFormat.properties.publicIPAddress.$ref` | `./publicIpAddress.json#/definitions/PublicIPAddress` | `#/definitions/PublicIPAddress` |
| `definitions.IPConfigurationPropertiesFormat.properties.subnet.$ref` | `./virtualNetwork.json#/definitions/Subnet` | `#/definitions/Subnet` |
| `definitions.IpGroup.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.IpGroup.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.IpGroupPropertiesFormat.properties.firewallPolicies.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.IpGroupPropertiesFormat.properties.firewalls.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.IpGroupPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the IpGroups resource.` | `Provisioning states of a resource.` |
| `definitions.Ipv6ExpressRouteCircuitPeeringConfig.properties.routeFilter.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.LoadBalancer.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.LoadBalancer.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.LoadBalancer.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `#/definitions/ExtendedLocation` |
| `definitions.LoadBalancerBackendAddressPropertiesFormat.properties.loadBalancerFrontendIPConfiguration.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.LoadBalancerBackendAddressPropertiesFormat.properties.networkInterfaceIPConfiguration.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.LoadBalancerBackendAddressPropertiesFormat.properties.subnet.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.LoadBalancerBackendAddressPropertiesFormat.properties.virtualNetwork.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.LoadBalancerPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the load balancer resource.` | `Provisioning states of a resource.` |
| `definitions.LoadBalancerVipSwapRequestFrontendIPConfigurationProperties.properties.publicIPAddress.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.LoadBalancingRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.LoadBalancingRule.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.backendAddressPool.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.backendAddressPools.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.frontendIPConfiguration.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.probe.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the load balancing rule resource.` | `Provisioning states of a resource.` |
| `definitions.LocalNetworkGateway.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.LocalNetworkGateway.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.LocalNetworkGatewayPropertiesFormat.properties.localNetworkAddressSpace.$ref` | `./virtualNetwork.json#/definitions/AddressSpace` | `#/definitions/AddressSpace` |
| `definitions.LocalNetworkGatewayPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the local network gateway resource.` | `Provisioning states of a resource.` |
| `definitions.NatGateway.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.NatGateway.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.NatGateway.properties.zones.description` | `A list of availability zones denoting the zone in which Nat Gateway should be deployed.` | `The availability zones.` |
| `definitions.NatGatewayPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the NAT gateway resource.` | `Provisioning states of a resource.` |
| `definitions.NatGatewayPropertiesFormat.properties.publicIpAddresses.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.NatGatewayPropertiesFormat.properties.publicIpAddressesV6.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.NatGatewayPropertiesFormat.properties.publicIpPrefixes.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.NatGatewayPropertiesFormat.properties.publicIpPrefixesV6.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.NatGatewayPropertiesFormat.properties.sourceVirtualNetwork.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.NatGatewayPropertiesFormat.properties.subnets.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.NetworkGroup.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.NetworkGroupProperties.properties.provisioningState.description` | `The provisioning state of the scope assignment resource.` | `Provisioning states of a resource.` |
| `definitions.NetworkIntentPolicy.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.NetworkInterface.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.NetworkInterface.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.NetworkInterface.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `#/definitions/ExtendedLocation` |
| `definitions.NetworkInterfaceAssociation.properties.securityRules.items.$ref` | `./networkSecurityGroup.json#/definitions/SecurityRule` | `#/definitions/SecurityRule` |
| `definitions.NetworkInterfaceIPConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.NetworkInterfaceIPConfiguration.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.applicationGatewayBackendAddressPools.items.$ref` | `./applicationGateway.json#/definitions/ApplicationGatewayBackendAddressPool` | `#/definitions/ApplicationGatewayBackendAddressPool` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.applicationSecurityGroups.items.$ref` | `./applicationSecurityGroup.json#/definitions/ApplicationSecurityGroup` | `#/definitions/ApplicationSecurityGroup` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.gatewayLoadBalancer.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.loadBalancerBackendAddressPools.items.$ref` | `./loadBalancer.json#/definitions/BackendAddressPool` | `#/definitions/BackendAddressPool` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.loadBalancerInboundNatRules.items.$ref` | `./loadBalancer.json#/definitions/InboundNatRule` | `#/definitions/InboundNatRule` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.privateIPAddressVersion.description` | `Whether the specific IP configuration is IPv4 or IPv6. Default is IPv4.` | `IP address version.` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.description` | `The private IP address allocation method.` | `IP address allocation method.` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the network interface IP configuration.` | `Provisioning states of a resource.` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.publicIPAddress.$ref` | `./publicIpAddress.json#/definitions/PublicIPAddress` | `#/definitions/PublicIPAddress` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.subnet.$ref` | `./virtualNetwork.json#/definitions/Subnet` | `#/definitions/Subnet` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.virtualNetworkTaps.items.$ref` | `./virtualNetworkTap.json#/definitions/VirtualNetworkTap` | `#/definitions/VirtualNetworkTap` |
| `definitions.NetworkInterfacePropertiesFormat.properties.dscpConfiguration.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.NetworkInterfacePropertiesFormat.properties.networkSecurityGroup.$ref` | `./networkSecurityGroup.json#/definitions/NetworkSecurityGroup` | `#/definitions/NetworkSecurityGroup` |
| `definitions.NetworkInterfacePropertiesFormat.properties.privateEndpoint.$ref` | `./privateEndpoint.json#/definitions/PrivateEndpoint` | `#/definitions/PrivateEndpoint` |
| `definitions.NetworkInterfacePropertiesFormat.properties.privateLinkService.$ref` | `./privateLinkService.json#/definitions/PrivateLinkService` | `#/definitions/PrivateLinkService` |
| `definitions.NetworkInterfacePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the network interface resource.` | `Provisioning states of a resource.` |
| `definitions.NetworkInterfacePropertiesFormat.properties.virtualMachine.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.NetworkInterfaceTapConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.NetworkInterfaceTapConfiguration.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.NetworkInterfaceTapConfigurationPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the network interface tap configuration resource.` | `Provisioning states of a resource.` |
| `definitions.NetworkInterfaceTapConfigurationPropertiesFormat.properties.virtualNetworkTap.$ref` | `./virtualNetworkTap.json#/definitions/VirtualNetworkTap` | `#/definitions/VirtualNetworkTap` |
| `definitions.NetworkManager.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.NetworkManager.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.NetworkManagerConnection.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.NetworkManagerConnection.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.NetworkManagerConnectionProperties.properties.connectionState.description` | `Connection state.` | `The current scope connection state.` |
| `definitions.NetworkManagerProperties.properties.provisioningState.description` | `The provisioning state of the network manager resource.` | `Provisioning states of a resource.` |
| `definitions.NetworkManagerRoutingConfiguration.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.NetworkManagerRoutingConfigurationPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the resource.` | `Provisioning states of a resource.` |
| `definitions.NetworkProfile.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.NetworkProfile.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.NetworkProfilePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the network profile resource.` | `Provisioning states of a resource.` |
| `definitions.NetworkSecurityGroup.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.NetworkSecurityGroup.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.NetworkSecurityGroupPropertiesFormat.properties.flowLogs.items.$ref` | `./networkWatcher.json#/definitions/FlowLog` | `#/definitions/FlowLog` |
| `definitions.NetworkSecurityGroupPropertiesFormat.properties.networkInterfaces.items.$ref` | `./networkInterface.json#/definitions/NetworkInterface` | `#/definitions/NetworkInterface` |
| `definitions.NetworkSecurityGroupPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the network security group resource.` | `Provisioning states of a resource.` |
| `definitions.NetworkSecurityGroupPropertiesFormat.properties.subnets.items.$ref` | `./virtualNetwork.json#/definitions/Subnet` | `#/definitions/Subnet` |
| `definitions.NetworkSecurityGroupResult.properties.securityRuleAccessResult.description` | `The network traffic is allowed or denied.` | `Whether network traffic is allowed or denied.` |
| `definitions.NetworkSecurityPerimeter.allOf[0].$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/TrackedResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/TrackedResource` |
| `definitions.NetworkVirtualAppliance.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.NetworkVirtualAppliance.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.NetworkVirtualAppliance.properties.identity.$ref` | `./network.json#/definitions/ManagedServiceIdentity` | `#/definitions/ManagedServiceIdentity` |
| `definitions.NetworkVirtualApplianceConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.NetworkVirtualApplianceConnectionProperties.properties.provisioningState.description` | `The provisioning state of the NetworkVirtualApplianceConnection resource.` | `Provisioning states of a resource.` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.inboundSecurityRules.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the resource.` | `Provisioning states of a resource.` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.virtualApplianceConnections.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.virtualApplianceSites.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.virtualHub.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.NetworkVirtualApplianceSku.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.NetworkVirtualApplianceSku.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.NetworkWatcher.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.NetworkWatcher.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.NetworkWatcherListResult.description` | `Response for ListNetworkWatchers API service call.` | `[Placeholder] Discription for page model` |
| `definitions.NetworkWatcherListResult.properties.value.description` | `List of network watcher resources.` | `[Placeholder] Discription for value property` |
| `definitions.NetworkWatcherPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the network watcher resource.` | `Provisioning states of a resource.` |
| `definitions.NspAccessRule.allOf[0].$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.NspAssociation.allOf[0].$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.NspAssociationProperties.properties.privateLinkResource.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.NspAssociationProperties.properties.profile.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.NspLink.allOf[0].$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.NspLinkReference.allOf[0].$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.NspLinkReferenceProperties.properties.status.description` | `The NSP linkReference state. It cannot be changed if link is created in auto-approval mode.` | `The NSP link state.` |
| `definitions.NspLoggingConfiguration.allOf[0].$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.NspProfile.allOf[0].$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.OrderBy.properties.order['x-ms-enum'].name` | `FirewallPolicyIDPSQuerySortOrder` | `FirewallPolicyIdpsQuerySortOrder` |
| `definitions.OutboundRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.OutboundRule.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.OutboundRulePropertiesFormat.properties.backendAddressPool.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.OutboundRulePropertiesFormat.properties.frontendIPConfigurations.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.OutboundRulePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the outbound rule resource.` | `Provisioning states of a resource.` |
| `definitions.P2SConnectionConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.P2SConnectionConfigurationProperties.properties.configurationPolicyGroupAssociations.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.P2SConnectionConfigurationProperties.properties.provisioningState.description` | `The provisioning state of the P2SConnectionConfiguration resource.` | `Provisioning states of a resource.` |
| `definitions.P2SConnectionConfigurationProperties.properties.vpnClientAddressPool.$ref` | `./virtualNetwork.json#/definitions/AddressSpace` | `#/definitions/AddressSpace` |
| `definitions.P2SVpnGateway.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.P2SVpnGateway.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.P2SVpnGatewayProperties.properties.provisioningState.description` | `The provisioning state of the P2S VPN gateway resource.` | `Provisioning states of a resource.` |
| `definitions.P2SVpnGatewayProperties.properties.virtualHub.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.P2SVpnGatewayProperties.properties.vpnServerConfiguration.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.PacketCaptureResultProperties.properties.provisioningState.description` | `The provisioning state of the packet capture session.` | `Provisioning states of a resource.` |
| `definitions.PatchRouteFilter.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.PatchRouteFilterRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.PeerExpressRouteCircuitConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.PeerExpressRouteCircuitConnection.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.PeerExpressRouteCircuitConnectionPropertiesFormat.properties.expressRouteCircuitPeering.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.PeerExpressRouteCircuitConnectionPropertiesFormat.properties.peerExpressRouteCircuitPeering.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.PeerExpressRouteCircuitConnectionPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the peer express route circuit connection resource.` | `Provisioning states of a resource.` |
| `definitions.PrivateDnsZoneGroup.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.PrivateDnsZoneGroupPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the private dns zone group resource.` | `Provisioning states of a resource.` |
| `definitions.PrivateEndpoint.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.PrivateEndpoint.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.PrivateEndpoint.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `#/definitions/ExtendedLocation` |
| `definitions.PrivateEndpointConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.PrivateEndpointConnection.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.PrivateEndpointConnectionProperties.properties.privateEndpoint.$ref` | `./privateEndpoint.json#/definitions/PrivateEndpoint` | `#/definitions/PrivateEndpoint` |
| `definitions.PrivateEndpointConnectionProperties.properties.provisioningState.description` | `The provisioning state of the private endpoint connection resource.` | `Provisioning states of a resource.` |
| `definitions.PrivateEndpointProperties.properties.applicationSecurityGroups.items.$ref` | `./applicationSecurityGroup.json#/definitions/ApplicationSecurityGroup` | `#/definitions/ApplicationSecurityGroup` |
| `definitions.PrivateEndpointProperties.properties.networkInterfaces.items.$ref` | `./networkInterface.json#/definitions/NetworkInterface` | `#/definitions/NetworkInterface` |
| `definitions.PrivateEndpointProperties.properties.provisioningState.description` | `The provisioning state of the private endpoint resource.` | `Provisioning states of a resource.` |
| `definitions.PrivateEndpointProperties.properties.subnet.$ref` | `./virtualNetwork.json#/definitions/Subnet` | `#/definitions/Subnet` |
| `definitions.PrivateLinkService.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.PrivateLinkService.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.PrivateLinkService.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `#/definitions/ExtendedLocation` |
| `definitions.PrivateLinkServiceConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.PrivateLinkServiceConnectionProperties.properties.privateLinkServiceConnectionState.$ref` | `./privateLinkService.json#/definitions/PrivateLinkServiceConnectionState` | `#/definitions/PrivateLinkServiceConnectionState` |
| `definitions.PrivateLinkServiceConnectionProperties.properties.provisioningState.description` | `The provisioning state of the private link service connection resource.` | `Provisioning states of a resource.` |
| `definitions.PrivateLinkServiceIpConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.PrivateLinkServiceIpConfigurationProperties.properties.privateIPAddressVersion.description` | `Whether the specific IP configuration is IPv4 or IPv6. Default is IPv4.` | `IP address version.` |
| `definitions.PrivateLinkServiceIpConfigurationProperties.properties.privateIPAllocationMethod.description` | `The private IP address allocation method.` | `IP address allocation method.` |
| `definitions.PrivateLinkServiceIpConfigurationProperties.properties.provisioningState.description` | `The provisioning state of the private link service IP configuration resource.` | `Provisioning states of a resource.` |
| `definitions.PrivateLinkServiceIpConfigurationProperties.properties.subnet.$ref` | `./virtualNetwork.json#/definitions/Subnet` | `#/definitions/Subnet` |
| `definitions.PrivateLinkServiceProperties.properties.loadBalancerFrontendIpConfigurations.items.$ref` | `./loadBalancer.json#/definitions/FrontendIPConfiguration` | `#/definitions/FrontendIPConfiguration` |
| `definitions.PrivateLinkServiceProperties.properties.networkInterfaces.items.$ref` | `./networkInterface.json#/definitions/NetworkInterface` | `#/definitions/NetworkInterface` |
| `definitions.PrivateLinkServiceProperties.properties.provisioningState.description` | `The provisioning state of the private link service resource.` | `Provisioning states of a resource.` |
| `definitions.Probe.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.Probe.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.ProbePropertiesFormat.properties.loadBalancingRules.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ProbePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the probe resource.` | `Provisioning states of a resource.` |
| `definitions.PropagatedRouteTable.properties.ids.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ProtocolConfiguration.properties.HTTPConfiguration.$ref` | `#/definitions/HTTPConfiguration` | `#/definitions/HttpConfiguration` |
| `definitions.PublicIPAddress.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.PublicIPAddress.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.PublicIPAddress.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `#/definitions/ExtendedLocation` |
| `definitions.PublicIPAddress.properties.zones.description` | `A list of availability zones denoting the IP allocated for the resource needs to come from.` | `The availability zones.` |
| `definitions.PublicIPAddressPropertiesFormat.properties.ipConfiguration.$ref` | `./networkInterface.json#/definitions/IPConfiguration` | `#/definitions/IPConfiguration` |
| `definitions.PublicIPAddressPropertiesFormat.properties.natGateway.$ref` | `./natGateway.json#/definitions/NatGateway` | `#/definitions/NatGateway` |
| `definitions.PublicIPAddressPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the public IP address resource.` | `Provisioning states of a resource.` |
| `definitions.PublicIPAddressPropertiesFormat.properties.publicIPAddressVersion.description` | `The public IP address version.` | `IP address version.` |
| `definitions.PublicIPAddressPropertiesFormat.properties.publicIPAllocationMethod.description` | `The public IP address allocation method.` | `IP address allocation method.` |
| `definitions.PublicIPAddressPropertiesFormat.properties.publicIPPrefix.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.PublicIpDdosProtectionStatusResult.properties.ddosProtectionPlanId.description` | ` DDoS protection plan Resource Id of a if IP address is protected through a plan.` | `DDoS protection plan Resource Id of a if IP address is protected through a plan.` |
| `definitions.PublicIPPrefix.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.PublicIPPrefix.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.PublicIPPrefix.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `#/definitions/ExtendedLocation` |
| `definitions.PublicIPPrefix.properties.zones.description` | `A list of availability zones denoting the IP allocated for the resource needs to come from.` | `The availability zones.` |
| `definitions.PublicIPPrefixPropertiesFormat.properties.customIPPrefix.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.PublicIPPrefixPropertiesFormat.properties.ipTags.items.$ref` | `./publicIpAddress.json#/definitions/IpTag` | `#/definitions/IpTag` |
| `definitions.PublicIPPrefixPropertiesFormat.properties.loadBalancerFrontendIpConfiguration.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.PublicIPPrefixPropertiesFormat.properties.natGateway.$ref` | `./natGateway.json#/definitions/NatGateway` | `#/definitions/NatGateway` |
| `definitions.PublicIPPrefixPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the public IP prefix resource.` | `Provisioning states of a resource.` |
| `definitions.PublicIPPrefixPropertiesFormat.properties.publicIPAddressVersion.description` | `The public IP address version.` | `IP address version.` |
| `definitions.QueryInboundNatRulePortMappingRequest.properties.ipConfiguration.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ReachabilityAnalysisIntent.allOf[0].$ref` | `./network.json#/definitions/CommonProxyResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.ReachabilityAnalysisRun.allOf[0].$ref` | `./network.json#/definitions/CommonProxyResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.RecordSet.properties.provisioningState.description` | `The provisioning state of the recordset.` | `Provisioning states of a resource.` |
| `definitions.ResourceNavigationLink.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ResourceNavigationLinkFormat.properties.provisioningState.description` | `The provisioning state of the resource navigation link resource.` | `Provisioning states of a resource.` |
| `definitions.Route.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.Route.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.RouteFilter.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.RouteFilter.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.RouteFilterPropertiesFormat.properties.ipv6Peerings.items.$ref` | `./expressRouteCircuit.json#/definitions/ExpressRouteCircuitPeering` | `#/definitions/ExpressRouteCircuitPeering` |
| `definitions.RouteFilterPropertiesFormat.properties.peerings.items.$ref` | `./expressRouteCircuit.json#/definitions/ExpressRouteCircuitPeering` | `#/definitions/ExpressRouteCircuitPeering` |
| `definitions.RouteFilterPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the route filter resource.` | `Provisioning states of a resource.` |
| `definitions.RouteFilterRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.RouteFilterRulePropertiesFormat.properties.access.description` | `The access type of the rule.` | `Access to be allowed or denied.` |
| `definitions.RouteFilterRulePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the route filter rule resource.` | `Provisioning states of a resource.` |
| `definitions.RouteMap.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.RouteMap.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.RouteMapProperties.properties.provisioningState.description` | `The provisioning state of the RouteMap resource.` | `Provisioning states of a resource.` |
| `definitions.RoutePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the route resource.` | `Provisioning states of a resource.` |
| `definitions.RouteTable.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.RouteTable.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.RouteTablePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the route table resource.` | `Provisioning states of a resource.` |
| `definitions.RouteTablePropertiesFormat.properties.subnets.items.$ref` | `./virtualNetwork.json#/definitions/Subnet` | `#/definitions/Subnet` |
| `definitions.RoutingConfiguration.properties.associatedRouteTable.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.RoutingConfiguration.properties.inboundRouteMap.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.RoutingConfiguration.properties.outboundRouteMap.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.RoutingIntent.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.RoutingIntent.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.RoutingIntentProperties.properties.provisioningState.description` | `The provisioning state of the RoutingIntent resource.` | `Provisioning states of a resource.` |
| `definitions.RoutingRule.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.RoutingRuleCollection.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.RoutingRuleCollectionPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the resource.` | `Provisioning states of a resource.` |
| `definitions.RoutingRulePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the resource.` | `Provisioning states of a resource.` |
| `definitions.ScopeConnection.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.ScopeConnection.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.SecurityAdminConfiguration.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.SecurityPartnerProvider.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.SecurityPartnerProvider.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.SecurityPartnerProviderPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the Security Partner Provider resource.` | `Provisioning states of a resource.` |
| `definitions.SecurityPartnerProviderPropertiesFormat.properties.virtualHub.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.SecurityRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.SecurityRule.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.SecurityRuleAssociations.properties.defaultSecurityRules.items.$ref` | `./networkSecurityGroup.json#/definitions/SecurityRule` | `#/definitions/SecurityRule` |
| `definitions.SecurityRuleAssociations.properties.effectiveSecurityRules.items.$ref` | `./networkInterface.json#/definitions/EffectiveNetworkSecurityRule` | `#/definitions/EffectiveNetworkSecurityRule` |
| `definitions.SecurityRulePropertiesFormat.properties.destinationApplicationSecurityGroups.items.$ref` | `./applicationSecurityGroup.json#/definitions/ApplicationSecurityGroup` | `#/definitions/ApplicationSecurityGroup` |
| `definitions.SecurityRulePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the security rule resource.` | `Provisioning states of a resource.` |
| `definitions.SecurityRulePropertiesFormat.properties.sourceApplicationSecurityGroups.items.$ref` | `./applicationSecurityGroup.json#/definitions/ApplicationSecurityGroup` | `#/definitions/ApplicationSecurityGroup` |
| `definitions.SecurityUserConfiguration.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.SecurityUserConfigurationPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the resource.` | `Provisioning states of a resource.` |
| `definitions.SecurityUserRule.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.SecurityUserRuleCollection.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.SecurityUserRuleCollectionPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the resource.` | `Provisioning states of a resource.` |
| `definitions.SecurityUserRulePropertiesFormat.properties.destinations.items.$ref` | `./networkManagerSecurityAdminConfiguration.json#/definitions/AddressPrefixItem` | `#/definitions/AddressPrefixItem` |
| `definitions.SecurityUserRulePropertiesFormat.properties.direction.description` | `Indicates if the traffic matched against the rule in inbound or outbound.` | `The direction of the rule. The direction specifies if the rule will be evaluated on incoming or outgoing traffic.` |
| `definitions.SecurityUserRulePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the security configuration user rule resource.` | `Provisioning states of a resource.` |
| `definitions.SecurityUserRulePropertiesFormat.properties.sources.items.$ref` | `./networkManagerSecurityAdminConfiguration.json#/definitions/AddressPrefixItem` | `#/definitions/AddressPrefixItem` |
| `definitions.ServiceAssociationLink.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ServiceAssociationLinkPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the service association link resource.` | `Provisioning states of a resource.` |
| `definitions.ServiceDelegationPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the service delegation resource.` | `Provisioning states of a resource.` |
| `definitions.ServiceEndpointPolicy.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.ServiceEndpointPolicy.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.ServiceEndpointPolicyDefinition.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.ServiceEndpointPolicyDefinition.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.ServiceEndpointPolicyDefinitionPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the service endpoint policy definition resource.` | `Provisioning states of a resource.` |
| `definitions.ServiceEndpointPolicyPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the service endpoint policy resource.` | `Provisioning states of a resource.` |
| `definitions.ServiceEndpointPolicyPropertiesFormat.properties.subnets.items.$ref` | `./virtualNetwork.json#/definitions/Subnet` | `#/definitions/Subnet` |
| `definitions.ServiceEndpointPropertiesFormat.properties.networkIdentifier.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.ServiceEndpointPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the service endpoint resource.` | `Provisioning states of a resource.` |
| `definitions.SharedKeyProperties.properties.provisioningState.description` | `The provisioning state of the SharedKey resource.` | `Provisioning states of a resource.` |
| `definitions.SingleQueryResult.properties.direction.type` | `integer` | `number` |
| `definitions.SingleQueryResult.properties.direction['x-ms-enum'].name` | `FirewallPolicyIDPSSignatureDirection` | `FirewallPolicyIdpsSignatureDirection` |
| `definitions.SingleQueryResult.properties.mode.type` | `integer` | `number` |
| `definitions.SingleQueryResult.properties.mode['x-ms-enum'].name` | `FirewallPolicyIDPSSignatureMode` | `FirewallPolicyIdpsSignatureMode` |
| `definitions.SingleQueryResult.properties.severity.type` | `integer` | `number` |
| `definitions.SingleQueryResult.properties.severity['x-ms-enum'].name` | `FirewallPolicyIDPSSignatureSeverity` | `FirewallPolicyIdpsSignatureSeverity` |
| `definitions.StaticCidr.allOf[0].$ref` | `./network.json#/definitions/CommonProxyResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.StaticMember.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.StaticMemberProperties.properties.provisioningState.description` | `The provisioning state of the scope assignment resource.` | `Provisioning states of a resource.` |
| `definitions.Subnet.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.Subnet.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.SubnetAssociation.properties.securityRules.items.$ref` | `./networkSecurityGroup.json#/definitions/SecurityRule` | `#/definitions/SecurityRule` |
| `definitions.SubnetPropertiesFormat.properties.applicationGatewayIPConfigurations.items.$ref` | `./applicationGateway.json#/definitions/ApplicationGatewayIPConfiguration` | `#/definitions/ApplicationGatewayIPConfiguration` |
| `definitions.SubnetPropertiesFormat.properties.ipAllocations.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.SubnetPropertiesFormat.properties.ipConfigurationProfiles.items.$ref` | `./networkProfile.json#/definitions/IPConfigurationProfile` | `#/definitions/IPConfigurationProfile` |
| `definitions.SubnetPropertiesFormat.properties.ipConfigurations.items.$ref` | `./networkInterface.json#/definitions/IPConfiguration` | `#/definitions/IPConfiguration` |
| `definitions.SubnetPropertiesFormat.properties.natGateway.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.SubnetPropertiesFormat.properties.networkSecurityGroup.$ref` | `./networkSecurityGroup.json#/definitions/NetworkSecurityGroup` | `#/definitions/NetworkSecurityGroup` |
| `definitions.SubnetPropertiesFormat.properties.privateEndpoints.items.$ref` | `./privateEndpoint.json#/definitions/PrivateEndpoint` | `#/definitions/PrivateEndpoint` |
| `definitions.SubnetPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the subnet resource.` | `Provisioning states of a resource.` |
| `definitions.SubnetPropertiesFormat.properties.routeTable.$ref` | `./routeTable.json#/definitions/RouteTable` | `#/definitions/RouteTable` |
| `definitions.SubnetPropertiesFormat.properties.serviceEndpointPolicies.items.$ref` | `./serviceEndpointPolicy.json#/definitions/ServiceEndpointPolicy` | `#/definitions/ServiceEndpointPolicy` |
| `definitions.TopologyParameters.properties.targetSubnet.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.TopologyParameters.properties.targetVirtualNetwork.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VerificationIPFlowResult.properties.access.description` | `Indicates whether the traffic is allowed or denied.` | `Access to be allowed or denied.` |
| `definitions.VerifierWorkspace.allOf[0].$ref` | `./network.json#/definitions/CommonTrackedResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/TrackedResource` |
| `definitions.VerifierWorkspace.properties.etag.description` | `String representing unique etag for the resource document.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.VirtualApplianceNetworkInterfaceConfiguration.properties.type['x-ms-client-name']` | `NicType` | `nicType` |
| `definitions.VirtualApplianceSite.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.VirtualApplianceSite.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.VirtualApplianceSiteProperties.properties.provisioningState.description` | `The provisioning state of the resource.` | `Provisioning states of a resource.` |
| `definitions.VirtualHub.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.VirtualHub.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.VirtualHubProperties.properties.azureFirewall.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualHubProperties.properties.bgpConnections.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualHubProperties.properties.expressRouteGateway.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualHubProperties.properties.ipConfigurations.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualHubProperties.properties.p2SVpnGateway.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualHubProperties.properties.provisioningState.description` | `The provisioning state of the virtual hub resource.` | `Provisioning states of a resource.` |
| `definitions.VirtualHubProperties.properties.routeMaps.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualHubProperties.properties.securityPartnerProvider.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualHubProperties.properties.virtualWan.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualHubProperties.properties.vpnGateway.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualHubRouteTableV2.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualHubRouteTableV2Properties.properties.provisioningState.description` | `The provisioning state of the virtual hub route table v2 resource.` | `Provisioning states of a resource.` |
| `definitions.VirtualNetwork.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.VirtualNetwork.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.VirtualNetwork.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `#/definitions/ExtendedLocation` |
| `definitions.VirtualNetworkDdosProtectionStatusResult.properties.value.items.$ref` | `./publicIpAddress.json#/definitions/PublicIpDdosProtectionStatusResult` | `#/definitions/PublicIpDdosProtectionStatusResult` |
| `definitions.VirtualNetworkGateway.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.VirtualNetworkGateway.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.VirtualNetworkGateway.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `#/definitions/ExtendedLocation` |
| `definitions.VirtualNetworkGateway.properties.identity.$ref` | `./network.json#/definitions/ManagedServiceIdentity` | `#/definitions/ManagedServiceIdentity` |
| `definitions.VirtualNetworkGatewayConnection.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.VirtualNetworkGatewayConnection.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.VirtualNetworkGatewayConnectionListEntity.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.peer.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayConnectionListEntityPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the virtual network gateway connection resource.` | `Provisioning states of a resource.` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.egressNatRules.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.ingressNatRules.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.peer.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayConnectionPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the virtual network gateway connection resource.` | `Provisioning states of a resource.` |
| `definitions.VirtualNetworkGatewayIPConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.description` | `The private IP address allocation method.` | `IP address allocation method.` |
| `definitions.VirtualNetworkGatewayIPConfigurationPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the virtual network gateway IP configuration resource.` | `Provisioning states of a resource.` |
| `definitions.VirtualNetworkGatewayIPConfigurationPropertiesFormat.properties.publicIPAddress.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayIPConfigurationPropertiesFormat.properties.subnet.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayNatRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.VirtualNetworkGatewayNatRule.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.externalMappings.items.$ref` | `./virtualWan.json#/definitions/VpnNatRuleMapping` | `#/definitions/VpnNatRuleMapping` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.internalMappings.items.$ref` | `./virtualWan.json#/definitions/VpnNatRuleMapping` | `#/definitions/VpnNatRuleMapping` |
| `definitions.VirtualNetworkGatewayNatRuleProperties.properties.provisioningState.description` | `The provisioning state of the NAT Rule resource.` | `Provisioning states of a resource.` |
| `definitions.VirtualNetworkGatewayPolicyGroup.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayPolicyGroupProperties.properties.provisioningState.description` | `The provisioning state of the VirtualNetworkGatewayPolicyGroup resource.` | `Provisioning states of a resource.` |
| `definitions.VirtualNetworkGatewayPolicyGroupProperties.properties.vngClientConnectionConfigurations.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.customRoutes.$ref` | `./virtualNetwork.json#/definitions/AddressSpace` | `#/definitions/AddressSpace` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.gatewayDefaultSite.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualNetworkGatewayPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the virtual network gateway resource.` | `Provisioning states of a resource.` |
| `definitions.VirtualNetworkPeering.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.VirtualNetworkPeering.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.VirtualNetworkPeeringPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the virtual network peering resource.` | `Provisioning states of a resource.` |
| `definitions.VirtualNetworkPeeringPropertiesFormat.properties.remoteVirtualNetwork.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualNetworkPropertiesFormat.properties.ddosProtectionPlan.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualNetworkPropertiesFormat.properties.defaultPublicNatGateway.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualNetworkPropertiesFormat.properties.flowLogs.items.$ref` | `./networkWatcher.json#/definitions/FlowLog` | `#/definitions/FlowLog` |
| `definitions.VirtualNetworkPropertiesFormat.properties.ipAllocations.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualNetworkPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the virtual network resource.` | `Provisioning states of a resource.` |
| `definitions.VirtualNetworkTap.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.VirtualNetworkTap.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.VirtualNetworkTapPropertiesFormat.properties.destinationLoadBalancerFrontEndIPConfiguration.$ref` | `./loadBalancer.json#/definitions/FrontendIPConfiguration` | `#/definitions/FrontendIPConfiguration` |
| `definitions.VirtualNetworkTapPropertiesFormat.properties.destinationNetworkInterfaceIPConfiguration.$ref` | `./networkInterface.json#/definitions/NetworkInterfaceIPConfiguration` | `#/definitions/NetworkInterfaceIPConfiguration` |
| `definitions.VirtualNetworkTapPropertiesFormat.properties.networkInterfaceTapConfigurations.items.$ref` | `./networkInterface.json#/definitions/NetworkInterfaceTapConfiguration` | `#/definitions/NetworkInterfaceTapConfiguration` |
| `definitions.VirtualNetworkTapPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the virtual network tap resource.` | `Provisioning states of a resource.` |
| `definitions.VirtualRouter.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.VirtualRouter.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.VirtualRouterPeering.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.VirtualRouterPeering.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.VirtualRouterPeeringProperties.properties.provisioningState.description` | `The provisioning state of the resource.` | `Provisioning states of a resource.` |
| `definitions.VirtualRouterPropertiesFormat.properties.hostedGateway.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualRouterPropertiesFormat.properties.hostedSubnet.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualRouterPropertiesFormat.properties.peerings.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualRouterPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the resource.` | `Provisioning states of a resource.` |
| `definitions.VirtualWAN.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.VirtualWAN.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.VirtualWanProperties.properties.provisioningState.description` | `The provisioning state of the virtual WAN resource.` | `Provisioning states of a resource.` |
| `definitions.VirtualWanProperties.properties.virtualHubs.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VirtualWanProperties.properties.vpnSites.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VM.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.VnetRoute.properties.bgpConnections.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VngClientConnectionConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VngClientConnectionConfigurationProperties.properties.provisioningState.description` | `The provisioning state of the VngClientConnectionConfiguration resource.` | `Provisioning states of a resource.` |
| `definitions.VngClientConnectionConfigurationProperties.properties.virtualNetworkGatewayPolicyGroups.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VngClientConnectionConfigurationProperties.properties.vpnClientAddressPool.$ref` | `./virtualNetwork.json#/definitions/AddressSpace` | `#/definitions/AddressSpace` |
| `definitions.VpnClientConfiguration.properties.vpnClientAddressPool.$ref` | `./virtualNetwork.json#/definitions/AddressSpace` | `#/definitions/AddressSpace` |
| `definitions.VpnClientRevokedCertificate.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VpnClientRevokedCertificatePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the VPN client revoked certificate resource.` | `Provisioning states of a resource.` |
| `definitions.VpnClientRootCertificate.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VpnClientRootCertificatePropertiesFormat.properties.provisioningState.description` | `The provisioning state of the VPN client root certificate resource.` | `Provisioning states of a resource.` |
| `definitions.VpnConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VpnConnectionProperties.properties.ipsecPolicies.items.$ref` | `./virtualNetworkGateway.json#/definitions/IpsecPolicy` | `#/definitions/IpsecPolicy` |
| `definitions.VpnConnectionProperties.properties.provisioningState.description` | `The provisioning state of the VPN connection resource.` | `Provisioning states of a resource.` |
| `definitions.VpnConnectionProperties.properties.remoteVpnSite.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VpnConnectionProperties.properties.trafficSelectorPolicies.items.$ref` | `./virtualNetworkGateway.json#/definitions/TrafficSelectorPolicy` | `#/definitions/TrafficSelectorPolicy` |
| `definitions.VpnConnectionProperties.properties.vpnConnectionProtocolType.description` | `Connection protocol used for this connection.` | `Gateway connection protocol.` |
| `definitions.VpnGateway.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.VpnGateway.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.VpnGatewayNatRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.VpnGatewayNatRule.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.VpnGatewayNatRuleProperties.properties.egressVpnSiteLinkConnections.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VpnGatewayNatRuleProperties.properties.ingressVpnSiteLinkConnections.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VpnGatewayNatRuleProperties.properties.provisioningState.description` | `The provisioning state of the NAT Rule resource.` | `Provisioning states of a resource.` |
| `definitions.VpnGatewayProperties.properties.bgpSettings.$ref` | `./virtualNetworkGateway.json#/definitions/BgpSettings` | `#/definitions/BgpSettings` |
| `definitions.VpnGatewayProperties.properties.provisioningState.description` | `The provisioning state of the VPN gateway resource.` | `Provisioning states of a resource.` |
| `definitions.VpnGatewayProperties.properties.virtualHub.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VpnServerConfiguration.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.VpnServerConfiguration.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.VpnServerConfigurationPolicyGroup.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.VpnServerConfigurationPolicyGroup.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.VpnServerConfigurationPolicyGroupProperties.properties.p2SConnectionConfigurations.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VpnServerConfigurationPolicyGroupProperties.properties.provisioningState.description` | `The provisioning state of the VpnServerConfigurationPolicyGroup resource.` | `Provisioning states of a resource.` |
| `definitions.VpnServerConfigurationProperties.properties.radiusServers.items.$ref` | `./virtualNetworkGateway.json#/definitions/RadiusServer` | `#/definitions/RadiusServer` |
| `definitions.VpnServerConfigurationProperties.properties.vpnAuthenticationTypes.items.description` | `VPN authentication types enabled for the VpnServerConfiguration.` | `VPN authentication types enabled for the virtual network gateway.` |
| `definitions.VpnServerConfigurationProperties.properties.vpnClientIpsecPolicies.items.$ref` | `./virtualNetworkGateway.json#/definitions/IpsecPolicy` | `#/definitions/IpsecPolicy` |
| `definitions.VpnSite.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.VpnSite.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.VpnSiteLink.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.VpnSiteLink.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.VpnSiteLinkConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.VpnSiteLinkConnection.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.VpnSiteLinkConnectionProperties.properties.egressNatRules.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VpnSiteLinkConnectionProperties.properties.ingressNatRules.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VpnSiteLinkConnectionProperties.properties.ipsecPolicies.items.$ref` | `./virtualNetworkGateway.json#/definitions/IpsecPolicy` | `#/definitions/IpsecPolicy` |
| `definitions.VpnSiteLinkConnectionProperties.properties.provisioningState.description` | `The provisioning state of the VPN site link connection resource.` | `Provisioning states of a resource.` |
| `definitions.VpnSiteLinkConnectionProperties.properties.vpnConnectionProtocolType.description` | `Connection protocol used for this connection.` | `Gateway connection protocol.` |
| `definitions.VpnSiteLinkConnectionProperties.properties.vpnGatewayCustomBgpAddresses.items.$ref` | `./virtualNetworkGateway.json#/definitions/GatewayCustomBgpIpAddressIpConfiguration` | `#/definitions/GatewayCustomBgpIpAddressIpConfiguration` |
| `definitions.VpnSiteLinkConnectionProperties.properties.vpnSiteLink.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.VpnSiteLinkProperties.properties.provisioningState.description` | `The provisioning state of the VPN site link resource.` | `Provisioning states of a resource.` |
| `definitions.VpnSiteProperties.properties.addressSpace.$ref` | `./virtualNetwork.json#/definitions/AddressSpace` | `#/definitions/AddressSpace` |
| `definitions.VpnSiteProperties.properties.bgpProperties.$ref` | `./virtualNetworkGateway.json#/definitions/BgpSettings` | `#/definitions/BgpSettings` |
| `definitions.VpnSiteProperties.properties.provisioningState.description` | `The provisioning state of the VPN site resource.` | `Provisioning states of a resource.` |
| `definitions.VpnSiteProperties.properties.virtualWan.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.WebApplicationFirewallPolicy.allOf[0].$ref` | `./network.json#/definitions/Resource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/Resource` |
| `definitions.WebApplicationFirewallPolicy.properties.etag.description` | `A unique read-only string that changes whenever the resource is updated.` | `"If etag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.")` |
| `definitions.WebApplicationFirewallPolicyPropertiesFormat.properties.applicationGateways.items.$ref` | `./applicationGateway.json#/definitions/ApplicationGateway` | `#/definitions/ApplicationGateway` |
| `definitions.WebApplicationFirewallPolicyPropertiesFormat.properties.httpListeners.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.WebApplicationFirewallPolicyPropertiesFormat.properties.pathBasedRules.items.$ref` | `./network.json#/definitions/SubResource` | `#/definitions/SubResource` |
| `definitions.WebApplicationFirewallPolicyPropertiesFormat.properties.provisioningState.description` | `The provisioning state of the web application firewall policy resource.` | `Provisioning states of a resource.` |
| `definitions.WebApplicationFirewallScrubbingRules.properties.selectorMatchOperator['x-ms-enum'].name` | ` scrubbingRuleEntryMatchOperator` | `ScrubbingRuleEntryMatchOperator` |
| `definitions.WebApplicationFirewallScrubbingRules.properties.state['x-ms-enum'].name` | ` scrubbingRuleEntryState` | `ScrubbingRuleEntryState` |
| `paths['/providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections/{networkManagerConnectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections/{networkManagerConnectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections/{networkManagerConnectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/providers/microsoft.Network/operations'].get.responses.200.schema.$ref` | `#/definitions/OperationListResult` | `../../../../../common-types/resource-management/v5/types.json#/definitions/OperationListResult` |
| `paths['/providers/microsoft.Network/operations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableRequestHeaders'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableResponseHeaders'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableServerVariables'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableSslOptions/default'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableSslOptions/default/predefinedPolicies'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableSslOptions/default/predefinedPolicies/{predefinedPolicyName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayAvailableWafRuleSets'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationGatewayWebApplicationFirewallPolicies'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationSecurityGroups'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/azureFirewallFqdnTags'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/azureFirewalls'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/azureWebCategories'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/azureWebCategories/{name}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/bastionHosts'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/bgpServiceCommunities'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/customIpPrefixes'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/ddosProtectionPlans'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/dscpConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteCircuits'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteCrossConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRoutePorts'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRoutePortsLocations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRoutePortsLocations/{locationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteProviderPorts'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/expressRouteProviderPorts/{providerport}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/firewallPolicies'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/ipAllocations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/ipGroups'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/loadBalancers'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/applicationGatewayWafDynamicManifests'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/applicationGatewayWafDynamicManifests/dafault'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availablePrivateEndpointTypes'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkDnsNameAvailability'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.parameters[1].name` | `parameters` | `body` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/networkSecurityPerimeterOperationStatuses/{operationId}'].get.responses.200.schema.$ref` | `../../../../../common-types/resource-management/v6/types.json#/definitions/OperationStatusResult` | `../../../../../common-types/resource-management/v5/types.json#/definitions/OperationStatusResult` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/networkSecurityPerimeterOperationStatuses/{operationId}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/serviceTags'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/setLoadBalancerFrontendPublicIpAddresses'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/natGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkInterfaces'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections/{networkManagerConnectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections/{networkManagerConnectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections/{networkManagerConnectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagers'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkProfiles'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkSecurityGroups'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkSecurityPerimeters'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkVirtualAppliances'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkVirtualApplianceSkus'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkVirtualApplianceSkus/{skuName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkWatchers'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/p2svpnGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/privateEndpoints'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/privateLinkServices'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/publicIPAddresses'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/publicIPPrefixes'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/routeFilters'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/routeTables'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/securityPartnerProviders'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/serviceEndpointPolicies'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/virtualHubs'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/virtualNetworks'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/virtualNetworkTaps'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/virtualRouters'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/virtualWans'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/vpnGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/vpnServerConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/vpnSites'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Compute/cloudServices/{resourceName}/providers/microsoft.Network/cloudServiceSlots'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Compute/cloudServices/{resourceName}/providers/microsoft.Network/cloudServiceSlots/{singletonResource}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Compute/cloudServices/{resourceName}/providers/microsoft.Network/cloudServiceSlots/{singletonResource}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendPoolName}/queryInboundNatRulePortMapping'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules/{loadBalancingRuleName}/health'].post.responses.202.headers.Location.description` | `URI to query the status of the long-running operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules/{loadBalancingRuleName}/health'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/migrateToIpBased'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/networkInterfaces'].get.responses.200.schema.$ref` | `./networkInterface.json#/definitions/NetworkInterfaceListResult` | `#/definitions/NetworkInterfaceListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/networkInterfaces'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/publicipaddresses'].get.responses.200.schema.$ref` | `./publicIpAddress.json#/definitions/PublicIPAddressListResult` | `#/definitions/PublicIPAddressListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/publicipaddresses'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/roleInstances/{roleInstanceName}/networkInterfaces'].get.responses.200.schema.$ref` | `./networkInterface.json#/definitions/NetworkInterfaceListResult` | `#/definitions/NetworkInterfaceListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/roleInstances/{roleInstanceName}/networkInterfaces'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/roleInstances/{roleInstanceName}/networkInterfaces/{networkInterfaceName}'].get.responses.200.schema.$ref` | `./networkInterface.json#/definitions/NetworkInterface` | `#/definitions/NetworkInterface` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/roleInstances/{roleInstanceName}/networkInterfaces/{networkInterfaceName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/roleInstances/{roleInstanceName}/networkInterfaces/{networkInterfaceName}/ipconfigurations/{ipConfigurationName}/publicipaddresses'].get.responses.200.schema.$ref` | `./publicIpAddress.json#/definitions/PublicIPAddressListResult` | `#/definitions/PublicIPAddressListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/roleInstances/{roleInstanceName}/networkInterfaces/{networkInterfaceName}/ipconfigurations/{ipConfigurationName}/publicipaddresses'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/roleInstances/{roleInstanceName}/networkInterfaces/{networkInterfaceName}/ipconfigurations/{ipConfigurationName}/publicipaddresses/{publicIpAddressName}'].get.responses.200.schema.$ref` | `./publicIpAddress.json#/definitions/PublicIPAddress` | `#/definitions/PublicIPAddress` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/roleInstances/{roleInstanceName}/networkInterfaces/{networkInterfaceName}/ipconfigurations/{ipConfigurationName}/publicipaddresses/{publicIpAddressName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/backendhealth'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/getBackendHealthOnDemand'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/privateEndpointConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/privateEndpointConnections/{connectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/privateEndpointConnections/{connectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/privateEndpointConnections/{connectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/privateLinkResources'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/start'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGateways/{applicationGatewayName}/stop'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGatewayWebApplicationFirewallPolicies'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/{policyName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/{policyName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/{policyName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationSecurityGroups'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationSecurityGroups/{applicationSecurityGroupName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationSecurityGroups/{applicationSecurityGroupName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationSecurityGroups/{applicationSecurityGroupName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationSecurityGroups/{applicationSecurityGroupName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationSecurityGroups/{applicationSecurityGroupName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/learnedIPPrefixes'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/packetCapture'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/azureFirewalls/{azureFirewallName}/packetCaptureOperation'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}/createShareableLinks'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}/deleteShareableLinks'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}/deleteShareableLinksByToken'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}/disconnectActiveSessions'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}/getActiveSessions'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}/getShareableLinks'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/getikesas'].post.responses.default.schema.$ref` | `./networkWatcher.json#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/resetconnection'].post.responses.default.schema.$ref` | `./networkWatcher.json#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/sharedkey'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/sharedkey'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/sharedkey/reset'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/startPacketCapture'].post.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/stopPacketCapture'].post.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/vpndeviceconfigurationscript'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/customIpPrefixes'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/customIpPrefixes/{customIpPrefixName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/customIpPrefixes/{customIpPrefixName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/customIpPrefixes/{customIpPrefixName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/customIpPrefixes/{customIpPrefixName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/customIpPrefixes/{customIpPrefixName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosCustomPolicies/{ddosCustomPolicyName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosCustomPolicies/{ddosCustomPolicyName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosCustomPolicies/{ddosCustomPolicyName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosCustomPolicies/{ddosCustomPolicyName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosCustomPolicies/{ddosCustomPolicyName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosCustomPolicies/{ddosCustomPolicyName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosProtectionPlans'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosProtectionPlans/{ddosProtectionPlanName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosProtectionPlans/{ddosProtectionPlanName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosProtectionPlans/{ddosProtectionPlanName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosProtectionPlans/{ddosProtectionPlanName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosProtectionPlans/{ddosProtectionPlanName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosProtectionPlans/{ddosProtectionPlanName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/dscpConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/dscpConfigurations/{dscpConfigurationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/dscpConfigurations/{dscpConfigurationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/dscpConfigurations/{dscpConfigurationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/authorizations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/authorizations/{authorizationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/authorizations/{authorizationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/authorizations/{authorizationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/arpTables/{devicePath}'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/connections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/connections/{connectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/connections/{connectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/connections/{connectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/peerConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/peerConnections/{connectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/routeTables/{devicePath}'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/routeTablesSummary/{devicePath}'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/stats'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCircuits/{circuitName}/stats'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/arpTables/{devicePath}'].post.responses.200.schema.$ref` | `./expressRouteCircuit.json#/definitions/ExpressRouteCircuitsArpTableListResult` | `#/definitions/ExpressRouteCircuitsArpTableListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/arpTables/{devicePath}'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/routeTables/{devicePath}'].post.responses.200.schema.$ref` | `./expressRouteCircuit.json#/definitions/ExpressRouteCircuitsRoutesTableListResult` | `#/definitions/ExpressRouteCircuitsRoutesTableListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/routeTables/{devicePath}'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/routeTablesSummary/{devicePath}'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections/{connectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections/{connectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRouteGateways/{expressRouteGatewayName}/expressRouteConnections/{connectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}'].delete.responses.202.headers.Location.description` | `URL for determining when an operation has completed. Send a GET request to the URL in Location header.
The URI should return a 202 until the operation reaches a terminal state and 200 once it reaches a terminal state.

For more info: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#202-accepted-and-location-headers` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}'].delete.responses.202.headers['Azure-AsyncOperation'].description` | `URL for checking the ongoing status of the operation.
To get the status of the asynchronous operation, send a GET request to the URL in Azure-AsyncOperation header value.

For more info: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#asynchronous-operations` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations/{authorizationName}'].delete.responses.202.headers.Location.description` | `URL for determining when an operation has completed. Send a GET request to the URL in Location header.
The URI should return a 202 until the operation reaches a terminal state and 200 once it reaches a terminal state.

For more info: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#202-accepted-and-location-headers` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations/{authorizationName}'].delete.responses.202.headers['Azure-AsyncOperation'].description` | `URL for checking the ongoing status of the operation.
To get the status of the asynchronous operation, send a GET request to the URL in Azure-AsyncOperation header value.

For more info: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#asynchronous-operations` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations/{authorizationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations/{authorizationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations/{authorizationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/generateLoa'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/links'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/expressRoutePorts/{expressRoutePortName}/links/{linkName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/deploy'].post.responses.202.headers.Location.description` | `URL to get the status of the operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/deploy'].post.responses.202.headers['Azure-AsyncOperation'].description` | `URL to get the status of the operation.` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/deploy'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/firewallPolicyDrafts/default'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/firewallPolicyDrafts/default'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/firewallPolicyDrafts/default'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/listIdpsFilterOptions'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/listIdpsSignatures'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/ruleCollectionGroups'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/ruleCollectionGroups/{ruleCollectionGroupName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/ruleCollectionGroups/{ruleCollectionGroupName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/ruleCollectionGroups/{ruleCollectionGroupName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/ruleCollectionGroups/{ruleCollectionGroupName}/ruleCollectionGroupDrafts/default'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/ruleCollectionGroups/{ruleCollectionGroupName}/ruleCollectionGroupDrafts/default'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/ruleCollectionGroups/{ruleCollectionGroupName}/ruleCollectionGroupDrafts/default'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/signatureOverrides'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/signatureOverrides/default'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/signatureOverrides/default'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/firewallPolicies/{firewallPolicyName}/signatureOverrides/default'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipAllocations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipAllocations/{ipAllocationName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipAllocations/{ipAllocationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipAllocations/{ipAllocationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipAllocations/{ipAllocationName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipAllocations/{ipAllocationName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipAllocations/{ipAllocationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipGroups'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipGroups/{ipGroupsName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipGroups/{ipGroupsName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipGroups/{ipGroupsName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipGroups/{ipGroupsName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipGroups/{ipGroupsName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools'].get.responses.200.schema.$ref` | `#/definitions/LoadBalancerBackendAddressPoolListResult` | `#/definitions/BackendAddressPoolListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendAddressPoolName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendAddressPoolName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendAddressPoolName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/frontendIPConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/frontendIPConfigurations/{frontendIPConfigurationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules/{loadBalancingRuleName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/networkInterfaces'].get.responses.200.schema.$ref` | `./networkInterface.json#/definitions/NetworkInterfaceListResult` | `#/definitions/NetworkInterfaceListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/networkInterfaces'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/outboundRules'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/outboundRules/{outboundRuleName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/probes'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/probes/{probeName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways/{localNetworkGatewayName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways/{localNetworkGatewayName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways/{localNetworkGatewayName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways/{localNetworkGatewayName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/localNetworkGateways/{localNetworkGatewayName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/natGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/natGateways/{natGatewayName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/natGateways/{natGatewayName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/natGateways/{natGatewayName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/natGateways/{natGatewayName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/natGateways/{natGatewayName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/effectiveNetworkSecurityGroups'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/effectiveRouteTable'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/ipConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/ipConfigurations/{ipConfigurationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/loadBalancers'].get.responses.200.schema.$ref` | `#/definitions/NetworkInterfaceLoadBalancerListResult` | `#/definitions/LoadBalancerListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/loadBalancers'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/tapConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/tapConfigurations/{tapConfigurationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/tapConfigurations/{tapConfigurationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/tapConfigurations/{tapConfigurationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/commit'].post.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/commit'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/connectivityConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/connectivityConfigurations/{configurationName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/connectivityConfigurations/{configurationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/connectivityConfigurations/{configurationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/connectivityConfigurations/{configurationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].delete.parameters[3].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}/getPoolUsage'].post.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}/listAssociatedResources'].post.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}/staticCidrs'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}/staticCidrs/{staticCidrName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}/staticCidrs/{staticCidrName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}/staticCidrs/{staticCidrName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/listActiveConnectivityConfigurations'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/listActiveSecurityAdminRules'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/listDeploymentStatus'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}/staticMembers'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}/staticMembers/{staticMemberName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}/staticMembers/{staticMemberName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}/staticMembers/{staticMemberName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections/{scopeConnectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections/{scopeConnectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections/{scopeConnectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}'].delete.parameters[3].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisIntents'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisIntents/{reachabilityAnalysisIntentName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisIntents/{reachabilityAnalysisIntentName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisIntents/{reachabilityAnalysisIntentName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisRuns'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisRuns/{reachabilityAnalysisRunName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisRuns/{reachabilityAnalysisRunName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisRuns/{reachabilityAnalysisRunName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisRuns/{reachabilityAnalysisRunName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkProfiles'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkProfiles/{networkProfileName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkProfiles/{networkProfileName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkProfiles/{networkProfileName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkProfiles/{networkProfileName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkProfiles/{networkProfileName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/defaultSecurityRules'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/defaultSecurityRules/{defaultSecurityRuleName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/securityRules'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/securityRules/{securityRuleName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/securityRules/{securityRuleName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/securityRules/{securityRuleName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}'].delete.parameters[1].name` | `force` | `forceDeletion` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}'].delete.responses.202.headers['Azure-AsyncOperation'].description` | `Azure async operation header` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/linkReferences'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/linkReferences/{linkReferenceName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/linkReferences/{linkReferenceName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links/{linkName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links/{linkName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links/{linkName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/loggingConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/loggingConfigurations/{loggingConfigurationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/loggingConfigurations/{loggingConfigurationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/loggingConfigurations/{loggingConfigurationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/profiles/{profileName}/accessRules/{accessRuleName}/reconcile'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations'].get.responses.200.schema.$ref` | `#/definitions/NspAssociationsListResult` | `#/definitions/NspAssociationListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}'].delete.responses.202.headers['Azure-AsyncOperation'].description` | `Azure async operation header` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}/reconcile'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/getBootDiagnosticLogs'].post.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/getBootDiagnosticLogs'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/inboundSecurityRules/{ruleCollectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/inboundSecurityRules/{ruleCollectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/networkVirtualApplianceConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/networkVirtualApplianceConnections/{connectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/networkVirtualApplianceConnections/{connectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/networkVirtualApplianceConnections/{connectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/networkVirtualApplianceConnections/{connectionName}'].put['x-ms-long-running-operation-options']['final-state-via']` | `azure-async-operation` | `original-uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/reimage'].post.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/reimage'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/restart'].post.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/restart'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/virtualApplianceSites'].get.responses.200.schema.$ref` | `#/definitions/NetworkVirtualApplianceSiteListResult` | `#/definitions/VirtualApplianceSiteListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/virtualApplianceSites'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/virtualApplianceSites/{siteName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/virtualApplianceSites/{siteName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/virtualApplianceSites/{siteName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}'].delete.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}'].patch.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}'].put.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/availableProvidersList'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/azureReachabilityReport'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/configureFlowLog'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors'].get.responses.default.schema.$ref` | `./networkWatcher.json#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}'].delete.responses.default.schema.$ref` | `./networkWatcher.json#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}'].get.responses.default.schema.$ref` | `./networkWatcher.json#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}'].patch.parameters[2].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}'].patch.responses.default.schema.$ref` | `./networkWatcher.json#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}'].put.responses.default.schema.$ref` | `./networkWatcher.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}/stop'].post.responses.default.schema.$ref` | `./networkWatcher.json#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/connectivityCheck'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs'].get.responses.default.schema.$ref` | `./networkWatcher.json#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs/{flowLogName}'].delete.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs/{flowLogName}'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs/{flowLogName}'].patch.parameters[2].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs/{flowLogName}'].patch.responses.default.schema.$ref` | `./networkWatcher.json#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs/{flowLogName}'].put.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/ipFlowVerify'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/networkConfigurationDiagnostic'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/nextHop'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}'].delete.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}'].get.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}'].put.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}'].put['x-ms-long-running-operation-options']['final-state-via']` | `azure-async-operation` | `original-uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}/queryStatus'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}/stop'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/queryFlowLogStatus'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/queryTroubleshootResult'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/securityGroupView'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/topology'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkWatchers/{networkWatcherName}/troubleshoot'].post.responses.default.schema.$ref` | `#/definitions/ErrorResponse` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}/generatevpnprofile'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}/getP2sVpnConnectionHealth'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}/getP2sVpnConnectionHealthDetailed'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{gatewayName}/reset'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/p2svpnGateways/{p2sVpnGatewayName}/disconnectP2sVpnConnections'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups/{privateDnsZoneGroupName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups/{privateDnsZoneGroupName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups/{privateDnsZoneGroupName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups/{privateDnsZoneGroupName}'].put['x-ms-long-running-operation-options']['final-state-via']` | `azure-async-operation` | `original-uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices/{serviceName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices/{serviceName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices/{serviceName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices/{serviceName}/privateEndpointConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices/{serviceName}/privateEndpointConnections/{peConnectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices/{serviceName}/privateEndpointConnections/{peConnectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices/{serviceName}/privateEndpointConnections/{peConnectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/ddosProtectionStatus'].post.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/ddosProtectionStatus'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/disassociateCloudServiceReservedPublicIp'].post.responses.202.headers.Location.description` | `URL for determining when an operation has completed. Send a GET request to the URL in Location header.
The URI should return a 202 until the operation reaches a terminal state and 200 once it reaches a terminal state.

For more info: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#202-accepted-and-location-headers` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/disassociateCloudServiceReservedPublicIp'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/reserveCloudServicePublicIpAddress'].post.responses.202.headers.Location.description` | `URL for determining when an operation has completed. Send a GET request to the URL in Location header.
The URI should return a 202 until the operation reaches a terminal state and 200 once it reaches a terminal state.

For more info: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#202-accepted-and-location-headers` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/reserveCloudServicePublicIpAddress'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPPrefixes'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPPrefixes/{publicIpPrefixName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPPrefixes/{publicIpPrefixName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPPrefixes/{publicIpPrefixName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPPrefixes/{publicIpPrefixName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPPrefixes/{publicIpPrefixName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}'].delete.responses.202.headers['Azure-AsyncOperation'].description` | `URL for checking the ongoing status of the operation.
To get the status of the asynchronous operation, send a GET request to the URL in Azure-AsyncOperation header value.

For more info: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#asynchronous-operations` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}'].put['x-ms-long-running-operation-options']['final-state-via']` | `azure-async-operation` | `original-uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}/routes'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}/routes/{routeName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}/routes/{routeName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}/routes/{routeName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/securityPartnerProviders'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/securityPartnerProviders/{securityPartnerProviderName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/securityPartnerProviders/{securityPartnerProviderName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/securityPartnerProviders/{securityPartnerProviderName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/securityPartnerProviders/{securityPartnerProviderName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/securityPartnerProviders/{securityPartnerProviderName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions/{serviceEndpointPolicyDefinitionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions/{serviceEndpointPolicyDefinitionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions/{serviceEndpointPolicyDefinitionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{hubName}/bgpConnections/{connectionName}/advertisedRoutes'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{hubName}/bgpConnections/{connectionName}/learnedRoutes'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/bgpConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/bgpConnections/{connectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/bgpConnections/{connectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/bgpConnections/{connectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/effectiveRoutes'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubRouteTables'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubRouteTables/{routeTableName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubRouteTables/{routeTableName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubRouteTables/{routeTableName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections/{connectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections/{connectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections/{connectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections/{connectionName}'].put['x-ms-long-running-operation-options']['final-state-via']` | `azure-async-operation` | `original-uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/inboundRoutes'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/ipConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/ipConfigurations/{ipConfigName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/ipConfigurations/{ipConfigName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/ipConfigurations/{ipConfigName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/outboundRoutes'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeMaps'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeMaps/{routeMapName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeMaps/{routeMapName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeMaps/{routeMapName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeTables'].get.responses.200.schema.$ref` | `#/definitions/ListVirtualHubRouteTableV2sResult` | `#/definitions/ListVirtualHubRouteTableV2SResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeTables'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeTables/{routeTableName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeTables/{routeTableName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeTables/{routeTableName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routeTables/{routeTableName}'].put['x-ms-long-running-operation-options']['final-state-via']` | `azure-async-operation` | `original-uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routingIntent'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routingIntent/{routingIntentName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routingIntent/{routingIntentName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualHubs/{virtualHubName}/routingIntent/{routingIntentName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/abortMigration'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/commitMigration'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/connections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/disconnectVirtualNetworkGatewayVpnConnections'].post.parameters[1].schema.$ref` | `./virtualWan.json#/definitions/P2SVpnConnectionRequest` | `#/definitions/P2SVpnConnectionRequest` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/disconnectVirtualNetworkGatewayVpnConnections'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/executeMigration'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/generatevpnclientpackage'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/generatevpnprofile'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getAdvertisedRoutes'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getBgpPeerStatus'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverAllTestsDetails'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getFailoverSingleTestDetails'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getLearnedRoutes'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getResiliencyInformation'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getRoutesInformation'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getVpnClientConnectionHealth'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getvpnclientipsecparameters'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getvpnprofilepackageurl'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/listRadiusSecrets'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules/{natRuleName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules/{natRuleName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules/{natRuleName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/prepareMigration'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/reset'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/resetvpnclientsharedkey'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/setvpnclientipsecparameters'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startPacketCapture'].post.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startSiteFailoverTest'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopPacketCapture'].post.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopSiteFailoverTest'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/supportedvpndevices'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/checkIPAddressAvailability'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/ddosProtectionStatus'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/listNetworkManagerEffectiveConnectivityConfigurations'].post.parameters[2].schema.$ref` | `./networkManagerGroup.json#/definitions/QueryRequestOptions` | `#/definitions/QueryRequestOptions` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/listNetworkManagerEffectiveConnectivityConfigurations'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/listNetworkManagerEffectiveSecurityAdminRules'].post.parameters[2].schema.$ref` | `./networkManagerGroup.json#/definitions/QueryRequestOptions` | `#/definitions/QueryRequestOptions` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/listNetworkManagerEffectiveSecurityAdminRules'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/prepareNetworkPolicies'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/resourceNavigationLinks'].get.responses.200.schema.$ref` | `#/definitions/ResourceNavigationLinksListResult` | `#/definitions/ResourceNavigationLinkListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/resourceNavigationLinks'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/serviceAssociationLinks'].get.responses.200.schema.$ref` | `#/definitions/ServiceAssociationLinksListResult` | `#/definitions/ServiceAssociationLinkListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/serviceAssociationLinks'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/unprepareNetworkPolicies'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/usages'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/virtualNetworkPeerings'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/virtualNetworkPeerings/{virtualNetworkPeeringName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/virtualNetworkPeerings/{virtualNetworkPeeringName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/virtualNetworkPeerings/{virtualNetworkPeeringName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}/peerings'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}/peerings/{peeringName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}/peerings/{peeringName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}/peerings/{peeringName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{VirtualWANName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{VirtualWANName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{VirtualWANName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{VirtualWANName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{VirtualWANName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{virtualWANName}/generateVpnProfile'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{virtualWANName}/supportedSecurityProviders'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{virtualWANName}/vpnConfiguration'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualWans/{virtualWANName}/vpnServerConfigurations'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/natRules'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/natRules/{natRuleName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/natRules/{natRuleName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/natRules/{natRuleName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/reset'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/startpacketcapture'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/stoppacketcapture'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}'].put['x-ms-long-running-operation-options']['final-state-via']` | `azure-async-operation` | `original-uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}/getikesas'].post.responses.default.schema.$ref` | `./networkWatcher.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}/resetconnection'].post.responses.default.schema.$ref` | `./networkWatcher.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}/sharedKeys'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}/sharedKeys/default'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}/sharedKeys/default'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}/sharedKeys/default/listSharedKey'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{vpnConnectionName}/startpacketcapture'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{vpnConnectionName}/stoppacketcapture'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/configurationPolicyGroups'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/configurationPolicyGroups/{configurationPolicyGroupName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/configurationPolicyGroups/{configurationPolicyGroupName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/configurationPolicyGroups/{configurationPolicyGroupName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/listRadiusSecrets'].post.responses.200.schema.$ref` | `./virtualNetworkGateway.json#/definitions/RadiusAuthServerListResult` | `#/definitions/RadiusAuthServerListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/listRadiusSecrets'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnSites'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnSites/{vpnSiteName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnSites/{vpnSiteName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnSites/{vpnSiteName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnSites/{vpnSiteName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnSites/{vpnSiteName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnSites/{vpnSiteName}/vpnSiteLinks'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/vpnSites/{vpnSiteName}/vpnSiteLinks/{vpnSiteLinkName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `#/definitions/CloudError` |

