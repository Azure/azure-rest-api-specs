import "../Common/main.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager.Legacy;

namespace Common;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  AddressSpace,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.AddressSpace"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  ApplicationGatewayBackendAddress,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.ApplicationGatewayBackendAddress"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  ApplicationGatewayBackendAddressPool,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.ApplicationGatewayBackendAddressPool"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  ApplicationGatewayBackendAddressPoolPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.ApplicationGatewayBackendAddressPoolPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  ApplicationGatewayIPConfiguration,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.ApplicationGatewayIPConfiguration"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  ApplicationGatewayIPConfigurationPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.ApplicationGatewayIPConfigurationPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  ApplicationSecurityGroup,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.ApplicationSecurityGroup"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  ApplicationSecurityGroupPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.ApplicationSecurityGroupPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  BackendAddressPool,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.BackendAddressPool"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  BackendAddressPoolPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.BackendAddressPoolPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  CloudError,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.CloudError"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  CloudErrorBody,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.CloudErrorBody"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  Components1Jq1T4ISchemasManagedserviceidentityPropertiesUserassignedidentitiesAdditionalproperties,
  "../2018-10-01/vmssNetwork.json#/definitions/ManagedServiceIdentityUserAssignedIdentities"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  CustomDnsConfigPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.CustomDnsConfigPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  DdosFrontendIpConfigurationSettings,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.DdosFrontendIpConfigurationSettings"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  DdosSettings,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.DdosSettings"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  Delegation,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.Delegation"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  DhcpOptions,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.DhcpOptions"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  ExtendedLocation,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.ExtendedLocation"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  FlowLog,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.FlowLog"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  FlowLogFormatParameters,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.FlowLogFormatParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  FlowLogPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.FlowLogPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  FrontendIPConfiguration,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.FrontendIPConfiguration"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  FrontendIPConfigurationPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.FrontendIPConfigurationPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  GatewayLoadBalancerTunnelInterface,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.GatewayLoadBalancerTunnelInterface"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  InboundNatPool,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.InboundNatPool"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  InboundNatPoolPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.InboundNatPoolPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  InboundNatRule,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.InboundNatRule"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  InboundNatRulePropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.InboundNatRulePropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  IpamPoolPrefixAllocation,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.IpamPoolPrefixAllocation"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  IpamPoolPrefixAllocationPool,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.IpamPoolPrefixAllocationPool"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  IPConfiguration,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.IPConfiguration"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  IPConfigurationProfile,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.IPConfigurationProfile"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  IPConfigurationProfilePropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.IPConfigurationProfilePropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  IPConfigurationPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.IPConfigurationPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  IpTag,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.IpTag"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  LoadBalancer,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.LoadBalancer"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  LoadBalancerBackendAddress,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.LoadBalancerBackendAddress"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  LoadBalancerBackendAddressPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.LoadBalancerBackendAddressPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  LoadBalancerPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.LoadBalancerPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  LoadBalancerSku,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.LoadBalancerSku"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  LoadBalancingRule,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.LoadBalancingRule"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  LoadBalancingRulePropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.LoadBalancingRulePropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  ManagedServiceIdentity,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.ManagedServiceIdentity"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  NatGateway,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.NatGateway"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  NatGatewayPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.NatGatewayPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  NatGatewaySku,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.NatGatewaySku"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  NatRulePortMapping,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.NatRulePortMapping"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  NetworkInterface,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.NetworkInterface"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  NetworkInterfaceDnsSettings,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.NetworkInterfaceDnsSettings"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  NetworkInterfaceIPConfiguration,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.NetworkInterfaceIPConfiguration"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  NetworkInterfaceIPConfigurationPrivateLinkConnectionProperties,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.NetworkInterfaceIPConfigurationPrivateLinkConnectionProperties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  NetworkInterfaceIPConfigurationPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.NetworkInterfaceIPConfigurationPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  NetworkInterfacePropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.NetworkInterfacePropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  NetworkInterfaceTapConfiguration,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.NetworkInterfaceTapConfiguration"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  NetworkInterfaceTapConfigurationPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.NetworkInterfaceTapConfigurationPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  NetworkSecurityGroup,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.NetworkSecurityGroup"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  NetworkSecurityGroupPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.NetworkSecurityGroupPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  NetworkWatcher,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.NetworkWatcher"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  NetworkWatcherPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.NetworkWatcherPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  OutboundRule,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.OutboundRule"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  OutboundRulePropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.OutboundRulePropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  PrivateEndpoint,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.PrivateEndpoint"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  PrivateEndpointConnection,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.PrivateEndpointConnection"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  PrivateEndpointConnectionProperties,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.PrivateEndpointConnectionProperties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  PrivateEndpointIPConfiguration,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.PrivateEndpointIPConfiguration"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  PrivateEndpointIPConfigurationProperties,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.PrivateEndpointIPConfigurationProperties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  PrivateEndpointProperties,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.PrivateEndpointProperties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  PrivateLinkService,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.PrivateLinkService"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  PrivateLinkServiceConnection,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.PrivateLinkServiceConnection"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  PrivateLinkServiceConnectionProperties,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.PrivateLinkServiceConnectionProperties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  PrivateLinkServiceConnectionState,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.PrivateLinkServiceConnectionState"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  PrivateLinkServiceIpConfiguration,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.PrivateLinkServiceIpConfiguration"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  PrivateLinkServiceIpConfigurationProperties,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.PrivateLinkServiceIpConfigurationProperties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  PrivateLinkServiceProperties,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.PrivateLinkServiceProperties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  PrivateLinkServicePropertiesAutoApproval,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.PrivateLinkServicePropertiesAutoApproval"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  PrivateLinkServicePropertiesVisibility,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.PrivateLinkServicePropertiesVisibility"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  Probe,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.Probe"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  ProbePropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.ProbePropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  PublicIPAddress,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.PublicIPAddress"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  PublicIPAddressDnsSettings,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.PublicIPAddressDnsSettings"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  PublicIPAddressPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.PublicIPAddressPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  PublicIPAddressSku,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.PublicIPAddressSku"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  Resource,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.Resource"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  ResourceNavigationLink,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.ResourceNavigationLink"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  ResourceNavigationLinkFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.ResourceNavigationLinkFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  ResourceSet,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.ResourceSet"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  RetentionPolicyParameters,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.RetentionPolicyParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  Route,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.Route"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  RouteNextHopEcmp,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.RouteNextHopEcmp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  RoutePropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.RoutePropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  RouteTable,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.RouteTable"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  RouteTablePropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.RouteTablePropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  SecurityRule,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.SecurityRule"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  SecurityRulePropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.SecurityRulePropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  ServiceAssociationLink,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.ServiceAssociationLink"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  ServiceAssociationLinkPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.ServiceAssociationLinkPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  ServiceDelegationPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.ServiceDelegationPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  ServiceEndpointPolicy,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.ServiceEndpointPolicy"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  ServiceEndpointPolicyDefinition,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.ServiceEndpointPolicyDefinition"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  ServiceEndpointPolicyDefinitionPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.ServiceEndpointPolicyDefinitionPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  ServiceEndpointPolicyPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.ServiceEndpointPolicyPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  ServiceEndpointPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.ServiceEndpointPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  Subnet,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.Subnet"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  SubnetPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.SubnetPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  SubResource,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.SubResource"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  SubResourceModel,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.SubResourceModel"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  TrafficAnalyticsConfigurationProperties,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.TrafficAnalyticsConfigurationProperties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  TrafficAnalyticsProperties,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.TrafficAnalyticsProperties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  VirtualNetwork,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.VirtualNetwork"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  VirtualNetworkBgpCommunities,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.VirtualNetworkBgpCommunities"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  VirtualNetworkEncryption,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.VirtualNetworkEncryption"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  VirtualNetworkPeering,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.VirtualNetworkPeering"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  VirtualNetworkPeeringPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.VirtualNetworkPeeringPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  VirtualNetworkPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.VirtualNetworkPropertiesFormat"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  VirtualNetworkTap,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.VirtualNetworkTap"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@externalTypeRef(
  VirtualNetworkTapPropertiesFormat,
  "../2018-10-01/vmssNetwork.json#/definitions/Common.VirtualNetworkTapPropertiesFormat"
);
