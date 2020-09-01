## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-network-2020-06-01
  - tag: schema-network-2020-05-01
  - tag: schema-network-2020-04-01
  - tag: schema-network-2020-03-01
  - tag: schema-network-2019-12-01
  - tag: schema-network-2019-11-01
  - tag: schema-network-2019-09-01
  - tag: schema-network-2019-08-01
  - tag: schema-network-2019-07-01
  - tag: schema-network-2019-06-01
  - tag: schema-network-2019-04-01
  - tag: schema-network-2019-02-01
  - tag: schema-network-2018-12-01
  - tag: schema-network-2018-11-01
  - tag: schema-network-2018-10-01
  - tag: schema-network-2018-08-01
  - tag: schema-network-2018-07-01
  - tag: schema-network-2018-06-01
  - tag: schema-network-2018-04-01
  - tag: schema-network-2018-02-01
  - tag: schema-network-2018-01-01
  - tag: schema-network-2017-11-01
  - tag: schema-network-2017-10-01
  - tag: schema-network-2017-09-01
  - tag: schema-network-2017-08-01
  - tag: schema-network-2017-06-01
  - tag: schema-network-2017-03-01
  - tag: schema-network-2016-12-01
  - tag: schema-network-2016-09-01
  - tag: schema-network-2016-06-01
  - tag: schema-network-2016-03-30
  - tag: schema-network-2015-06-15
  - tag: schema-network-2015-05-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-network-2020-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2020-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2020-06-01/applicationGateway.json
  - Microsoft.Network/stable/2020-06-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2020-06-01/availableDelegations.json
  - Microsoft.Network/stable/2020-06-01/availableServiceAliases.json
  - Microsoft.Network/stable/2020-06-01/azureFirewall.json
  - Microsoft.Network/stable/2020-06-01/azureFirewallFqdnTag.json
  - Microsoft.Network/stable/2020-06-01/bastionHost.json
  - Microsoft.Network/stable/2020-06-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2020-06-01/customIpPrefix.json
  - Microsoft.Network/stable/2020-06-01/ddosCustomPolicy.json
  - Microsoft.Network/stable/2020-06-01/ddosProtectionPlan.json
  - Microsoft.Network/stable/2020-06-01/dscpConfiguration.json
  - Microsoft.Network/stable/2020-06-01/endpointService.json
  - Microsoft.Network/stable/2020-06-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2020-06-01/expressRouteCrossConnection.json
  - Microsoft.Network/stable/2020-06-01/expressRoutePort.json
  - Microsoft.Network/stable/2020-06-01/firewallPolicy.json
  - Microsoft.Network/stable/2020-06-01/ipAllocation.json
  - Microsoft.Network/stable/2020-06-01/ipGroups.json
  - Microsoft.Network/stable/2020-06-01/loadBalancer.json
  - Microsoft.Network/stable/2020-06-01/natGateway.json
  - Microsoft.Network/stable/2020-06-01/network.json
  - Microsoft.Network/stable/2020-06-01/networkInterface.json
  - Microsoft.Network/stable/2020-06-01/networkProfile.json
  - Microsoft.Network/stable/2020-06-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2020-06-01/networkVirtualAppliance.json
  - Microsoft.Network/stable/2020-06-01/networkWatcher.json
  - Microsoft.Network/stable/2020-06-01/operation.json
  - Microsoft.Network/stable/2020-06-01/privateEndpoint.json
  - Microsoft.Network/stable/2020-06-01/privateLinkService.json
  - Microsoft.Network/stable/2020-06-01/publicIpAddress.json
  - Microsoft.Network/stable/2020-06-01/publicIpPrefix.json
  - Microsoft.Network/stable/2020-06-01/routeFilter.json
  - Microsoft.Network/stable/2020-06-01/routeTable.json
  - Microsoft.Network/stable/2020-06-01/securityPartnerProvider.json
  - Microsoft.Network/stable/2020-06-01/serviceCommunity.json
  - Microsoft.Network/stable/2020-06-01/serviceEndpointPolicy.json
  - Microsoft.Network/stable/2020-06-01/serviceTags.json
  - Microsoft.Network/stable/2020-06-01/usage.json
  - Microsoft.Network/stable/2020-06-01/virtualNetwork.json
  - Microsoft.Network/stable/2020-06-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2020-06-01/virtualNetworkTap.json
  - Microsoft.Network/stable/2020-06-01/virtualRouter.json
  - Microsoft.Network/stable/2020-06-01/virtualWan.json
  - Microsoft.Network/stable/2020-06-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2020-06-01/vmssPublicIpAddress.json
  - Microsoft.Network/stable/2020-06-01/webapplicationfirewall.json

```

### Tag: schema-network-2020-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2020-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2020-05-01/applicationGateway.json
  - Microsoft.Network/stable/2020-05-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2020-05-01/availableDelegations.json
  - Microsoft.Network/stable/2020-05-01/availableServiceAliases.json
  - Microsoft.Network/stable/2020-05-01/azureFirewall.json
  - Microsoft.Network/stable/2020-05-01/azureFirewallFqdnTag.json
  - Microsoft.Network/stable/2020-05-01/bastionHost.json
  - Microsoft.Network/stable/2020-05-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2020-05-01/ddosCustomPolicy.json
  - Microsoft.Network/stable/2020-05-01/ddosProtectionPlan.json
  - Microsoft.Network/stable/2020-05-01/endpointService.json
  - Microsoft.Network/stable/2020-05-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2020-05-01/expressRouteCrossConnection.json
  - Microsoft.Network/stable/2020-05-01/expressRoutePort.json
  - Microsoft.Network/stable/2020-05-01/firewallPolicy.json
  - Microsoft.Network/stable/2020-05-01/ipAllocation.json
  - Microsoft.Network/stable/2020-05-01/ipGroups.json
  - Microsoft.Network/stable/2020-05-01/loadBalancer.json
  - Microsoft.Network/stable/2020-05-01/natGateway.json
  - Microsoft.Network/stable/2020-05-01/network.json
  - Microsoft.Network/stable/2020-05-01/networkInterface.json
  - Microsoft.Network/stable/2020-05-01/networkProfile.json
  - Microsoft.Network/stable/2020-05-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2020-05-01/networkVirtualAppliance.json
  - Microsoft.Network/stable/2020-05-01/networkWatcher.json
  - Microsoft.Network/stable/2020-05-01/operation.json
  - Microsoft.Network/stable/2020-05-01/privateEndpoint.json
  - Microsoft.Network/stable/2020-05-01/privateLinkService.json
  - Microsoft.Network/stable/2020-05-01/publicIpAddress.json
  - Microsoft.Network/stable/2020-05-01/publicIpPrefix.json
  - Microsoft.Network/stable/2020-05-01/routeFilter.json
  - Microsoft.Network/stable/2020-05-01/routeTable.json
  - Microsoft.Network/stable/2020-05-01/securityPartnerProvider.json
  - Microsoft.Network/stable/2020-05-01/serviceCommunity.json
  - Microsoft.Network/stable/2020-05-01/serviceEndpointPolicy.json
  - Microsoft.Network/stable/2020-05-01/serviceTags.json
  - Microsoft.Network/stable/2020-05-01/usage.json
  - Microsoft.Network/stable/2020-05-01/virtualNetwork.json
  - Microsoft.Network/stable/2020-05-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2020-05-01/virtualNetworkTap.json
  - Microsoft.Network/stable/2020-05-01/virtualRouter.json
  - Microsoft.Network/stable/2020-05-01/virtualWan.json
  - Microsoft.Network/stable/2020-05-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2020-05-01/vmssPublicIpAddress.json

```

### Tag: schema-network-2020-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2020-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2020-04-01/applicationGateway.json
  - Microsoft.Network/stable/2020-04-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2020-04-01/availableDelegations.json
  - Microsoft.Network/stable/2020-04-01/availableServiceAliases.json
  - Microsoft.Network/stable/2020-04-01/azureFirewall.json
  - Microsoft.Network/stable/2020-04-01/azureFirewallFqdnTag.json
  - Microsoft.Network/stable/2020-04-01/bastionHost.json
  - Microsoft.Network/stable/2020-04-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2020-04-01/ddosCustomPolicy.json
  - Microsoft.Network/stable/2020-04-01/ddosProtectionPlan.json
  - Microsoft.Network/stable/2020-04-01/endpointService.json
  - Microsoft.Network/stable/2020-04-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2020-04-01/expressRouteCrossConnection.json
  - Microsoft.Network/stable/2020-04-01/expressRoutePort.json
  - Microsoft.Network/stable/2020-04-01/firewallPolicy.json
  - Microsoft.Network/stable/2020-04-01/ipAllocation.json
  - Microsoft.Network/stable/2020-04-01/ipGroups.json
  - Microsoft.Network/stable/2020-04-01/loadBalancer.json
  - Microsoft.Network/stable/2020-04-01/natGateway.json
  - Microsoft.Network/stable/2020-04-01/network.json
  - Microsoft.Network/stable/2020-04-01/networkInterface.json
  - Microsoft.Network/stable/2020-04-01/networkProfile.json
  - Microsoft.Network/stable/2020-04-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2020-04-01/networkVirtualAppliance.json
  - Microsoft.Network/stable/2020-04-01/networkWatcher.json
  - Microsoft.Network/stable/2020-04-01/operation.json
  - Microsoft.Network/stable/2020-04-01/privateEndpoint.json
  - Microsoft.Network/stable/2020-04-01/privateLinkService.json
  - Microsoft.Network/stable/2020-04-01/publicIpAddress.json
  - Microsoft.Network/stable/2020-04-01/publicIpPrefix.json
  - Microsoft.Network/stable/2020-04-01/routeFilter.json
  - Microsoft.Network/stable/2020-04-01/routeTable.json
  - Microsoft.Network/stable/2020-04-01/securityPartnerProvider.json
  - Microsoft.Network/stable/2020-04-01/serviceCommunity.json
  - Microsoft.Network/stable/2020-04-01/serviceEndpointPolicy.json
  - Microsoft.Network/stable/2020-04-01/serviceTags.json
  - Microsoft.Network/stable/2020-04-01/usage.json
  - Microsoft.Network/stable/2020-04-01/virtualNetwork.json
  - Microsoft.Network/stable/2020-04-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2020-04-01/virtualNetworkTap.json
  - Microsoft.Network/stable/2020-04-01/virtualRouter.json
  - Microsoft.Network/stable/2020-04-01/virtualWan.json
  - Microsoft.Network/stable/2020-04-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2020-04-01/vmssPublicIpAddress.json
  - Microsoft.Network/stable/2020-04-01/webapplicationfirewall.json

```

### Tag: schema-network-2020-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2020-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2020-03-01/applicationGateway.json
  - Microsoft.Network/stable/2020-03-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2020-03-01/availableDelegations.json
  - Microsoft.Network/stable/2020-03-01/availableServiceAliases.json
  - Microsoft.Network/stable/2020-03-01/azureFirewall.json
  - Microsoft.Network/stable/2020-03-01/azureFirewallFqdnTag.json
  - Microsoft.Network/stable/2020-03-01/bastionHost.json
  - Microsoft.Network/stable/2020-03-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2020-03-01/ddosCustomPolicy.json
  - Microsoft.Network/stable/2020-03-01/ddosProtectionPlan.json
  - Microsoft.Network/stable/2020-03-01/endpointService.json
  - Microsoft.Network/stable/2020-03-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2020-03-01/expressRouteCrossConnection.json
  - Microsoft.Network/stable/2020-03-01/expressRoutePort.json
  - Microsoft.Network/stable/2020-03-01/firewallPolicy.json
  - Microsoft.Network/stable/2020-03-01/ipAllocation.json
  - Microsoft.Network/stable/2020-03-01/ipGroups.json
  - Microsoft.Network/stable/2020-03-01/loadBalancer.json
  - Microsoft.Network/stable/2020-03-01/natGateway.json
  - Microsoft.Network/stable/2020-03-01/network.json
  - Microsoft.Network/stable/2020-03-01/networkInterface.json
  - Microsoft.Network/stable/2020-03-01/networkProfile.json
  - Microsoft.Network/stable/2020-03-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2020-03-01/networkVirtualAppliance.json
  - Microsoft.Network/stable/2020-03-01/networkWatcher.json
  - Microsoft.Network/stable/2020-03-01/operation.json
  - Microsoft.Network/stable/2020-03-01/privateEndpoint.json
  - Microsoft.Network/stable/2020-03-01/privateLinkService.json
  - Microsoft.Network/stable/2020-03-01/publicIpAddress.json
  - Microsoft.Network/stable/2020-03-01/publicIpPrefix.json
  - Microsoft.Network/stable/2020-03-01/routeFilter.json
  - Microsoft.Network/stable/2020-03-01/routeTable.json
  - Microsoft.Network/stable/2020-03-01/securityPartnerProvider.json
  - Microsoft.Network/stable/2020-03-01/serviceCommunity.json
  - Microsoft.Network/stable/2020-03-01/serviceEndpointPolicy.json
  - Microsoft.Network/stable/2020-03-01/serviceTags.json
  - Microsoft.Network/stable/2020-03-01/usage.json
  - Microsoft.Network/stable/2020-03-01/virtualNetwork.json
  - Microsoft.Network/stable/2020-03-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2020-03-01/virtualNetworkTap.json
  - Microsoft.Network/stable/2020-03-01/virtualRouter.json
  - Microsoft.Network/stable/2020-03-01/virtualWan.json
  - Microsoft.Network/stable/2020-03-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2020-03-01/vmssPublicIpAddress.json
  - Microsoft.Network/stable/2020-03-01/webapplicationfirewall.json

```

### Tag: schema-network-2019-12-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2019-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2019-12-01/applicationGateway.json
  - Microsoft.Network/stable/2019-12-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2019-12-01/availableDelegations.json
  - Microsoft.Network/stable/2019-12-01/availableServiceAliases.json
  - Microsoft.Network/stable/2019-12-01/azureFirewall.json
  - Microsoft.Network/stable/2019-12-01/azureFirewallFqdnTag.json
  - Microsoft.Network/stable/2019-12-01/bastionHost.json
  - Microsoft.Network/stable/2019-12-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2019-12-01/ddosCustomPolicy.json
  - Microsoft.Network/stable/2019-12-01/ddosProtectionPlan.json
  - Microsoft.Network/stable/2019-12-01/endpointService.json
  - Microsoft.Network/stable/2019-12-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2019-12-01/expressRouteCrossConnection.json
  - Microsoft.Network/stable/2019-12-01/expressRouteGateway.json
  - Microsoft.Network/stable/2019-12-01/expressRoutePort.json
  - Microsoft.Network/stable/2019-12-01/firewallPolicy.json
  - Microsoft.Network/stable/2019-12-01/ipGroups.json
  - Microsoft.Network/stable/2019-12-01/loadBalancer.json
  - Microsoft.Network/stable/2019-12-01/natGateway.json
  - Microsoft.Network/stable/2019-12-01/network.json
  - Microsoft.Network/stable/2019-12-01/networkInterface.json
  - Microsoft.Network/stable/2019-12-01/networkProfile.json
  - Microsoft.Network/stable/2019-12-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2019-12-01/networkVirtualAppliance.json
  - Microsoft.Network/stable/2019-12-01/networkWatcher.json
  - Microsoft.Network/stable/2019-12-01/operation.json
  - Microsoft.Network/stable/2019-12-01/privateEndpoint.json
  - Microsoft.Network/stable/2019-12-01/privateLinkService.json
  - Microsoft.Network/stable/2019-12-01/publicIpAddress.json
  - Microsoft.Network/stable/2019-12-01/publicIpPrefix.json
  - Microsoft.Network/stable/2019-12-01/routeFilter.json
  - Microsoft.Network/stable/2019-12-01/routeTable.json
  - Microsoft.Network/stable/2019-12-01/serviceCommunity.json
  - Microsoft.Network/stable/2019-12-01/serviceEndpointPolicy.json
  - Microsoft.Network/stable/2019-12-01/serviceTags.json
  - Microsoft.Network/stable/2019-12-01/usage.json
  - Microsoft.Network/stable/2019-12-01/virtualNetwork.json
  - Microsoft.Network/stable/2019-12-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2019-12-01/virtualNetworkTap.json
  - Microsoft.Network/stable/2019-12-01/virtualRouter.json
  - Microsoft.Network/stable/2019-12-01/virtualWan.json
  - Microsoft.Network/stable/2019-12-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2019-12-01/vmssPublicIpAddress.json
  - Microsoft.Network/stable/2019-12-01/webapplicationfirewall.json

```

### Tag: schema-network-2019-11-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2019-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2019-11-01/applicationGateway.json
  - Microsoft.Network/stable/2019-11-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2019-11-01/availableDelegations.json
  - Microsoft.Network/stable/2019-11-01/availableServiceAliases.json
  - Microsoft.Network/stable/2019-11-01/azureFirewall.json
  - Microsoft.Network/stable/2019-11-01/azureFirewallFqdnTag.json
  - Microsoft.Network/stable/2019-11-01/bastionHost.json
  - Microsoft.Network/stable/2019-11-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2019-11-01/ddosCustomPolicy.json
  - Microsoft.Network/stable/2019-11-01/ddosProtectionPlan.json
  - Microsoft.Network/stable/2019-11-01/endpointService.json
  - Microsoft.Network/stable/2019-11-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2019-11-01/expressRouteCrossConnection.json
  - Microsoft.Network/stable/2019-11-01/expressRouteGateway.json
  - Microsoft.Network/stable/2019-11-01/expressRoutePort.json
  - Microsoft.Network/stable/2019-11-01/firewallPolicy.json
  - Microsoft.Network/stable/2019-11-01/ipGroups.json
  - Microsoft.Network/stable/2019-11-01/loadBalancer.json
  - Microsoft.Network/stable/2019-11-01/natGateway.json
  - Microsoft.Network/stable/2019-11-01/network.json
  - Microsoft.Network/stable/2019-11-01/networkInterface.json
  - Microsoft.Network/stable/2019-11-01/networkProfile.json
  - Microsoft.Network/stable/2019-11-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2019-11-01/networkWatcher.json
  - Microsoft.Network/stable/2019-11-01/operation.json
  - Microsoft.Network/stable/2019-11-01/privateEndpoint.json
  - Microsoft.Network/stable/2019-11-01/privateLinkService.json
  - Microsoft.Network/stable/2019-11-01/publicIpAddress.json
  - Microsoft.Network/stable/2019-11-01/publicIpPrefix.json
  - Microsoft.Network/stable/2019-11-01/routeFilter.json
  - Microsoft.Network/stable/2019-11-01/routeTable.json
  - Microsoft.Network/stable/2019-11-01/serviceCommunity.json
  - Microsoft.Network/stable/2019-11-01/serviceEndpointPolicy.json
  - Microsoft.Network/stable/2019-11-01/serviceTags.json
  - Microsoft.Network/stable/2019-11-01/usage.json
  - Microsoft.Network/stable/2019-11-01/virtualNetwork.json
  - Microsoft.Network/stable/2019-11-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2019-11-01/virtualNetworkTap.json
  - Microsoft.Network/stable/2019-11-01/virtualRouter.json
  - Microsoft.Network/stable/2019-11-01/virtualWan.json
  - Microsoft.Network/stable/2019-11-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2019-11-01/vmssPublicIpAddress.json
  - Microsoft.Network/stable/2019-11-01/webapplicationfirewall.json

```

### Tag: schema-network-2019-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2019-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2019-09-01/applicationGateway.json
  - Microsoft.Network/stable/2019-09-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2019-09-01/availableDelegations.json
  - Microsoft.Network/stable/2019-09-01/availableServiceAliases.json
  - Microsoft.Network/stable/2019-09-01/azureFirewall.json
  - Microsoft.Network/stable/2019-09-01/azureFirewallFqdnTag.json
  - Microsoft.Network/stable/2019-09-01/bastionHost.json
  - Microsoft.Network/stable/2019-09-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2019-09-01/ddosCustomPolicy.json
  - Microsoft.Network/stable/2019-09-01/ddosProtectionPlan.json
  - Microsoft.Network/stable/2019-09-01/endpointService.json
  - Microsoft.Network/stable/2019-09-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2019-09-01/expressRouteCrossConnection.json
  - Microsoft.Network/stable/2019-09-01/expressRouteGateway.json
  - Microsoft.Network/stable/2019-09-01/expressRoutePort.json
  - Microsoft.Network/stable/2019-09-01/firewallPolicy.json
  - Microsoft.Network/stable/2019-09-01/ipGroups.json
  - Microsoft.Network/stable/2019-09-01/loadBalancer.json
  - Microsoft.Network/stable/2019-09-01/natGateway.json
  - Microsoft.Network/stable/2019-09-01/network.json
  - Microsoft.Network/stable/2019-09-01/networkInterface.json
  - Microsoft.Network/stable/2019-09-01/networkProfile.json
  - Microsoft.Network/stable/2019-09-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2019-09-01/networkWatcher.json
  - Microsoft.Network/stable/2019-09-01/networkWatcherConnectionMonitorV1.json
  - Microsoft.Network/stable/2019-09-01/operation.json
  - Microsoft.Network/stable/2019-09-01/privateEndpoint.json
  - Microsoft.Network/stable/2019-09-01/privateLinkService.json
  - Microsoft.Network/stable/2019-09-01/publicIpAddress.json
  - Microsoft.Network/stable/2019-09-01/publicIpPrefix.json
  - Microsoft.Network/stable/2019-09-01/routeFilter.json
  - Microsoft.Network/stable/2019-09-01/routeTable.json
  - Microsoft.Network/stable/2019-09-01/serviceCommunity.json
  - Microsoft.Network/stable/2019-09-01/serviceEndpointPolicy.json
  - Microsoft.Network/stable/2019-09-01/serviceTags.json
  - Microsoft.Network/stable/2019-09-01/usage.json
  - Microsoft.Network/stable/2019-09-01/virtualNetwork.json
  - Microsoft.Network/stable/2019-09-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2019-09-01/virtualNetworkTap.json
  - Microsoft.Network/stable/2019-09-01/virtualRouter.json
  - Microsoft.Network/stable/2019-09-01/virtualWan.json
  - Microsoft.Network/stable/2019-09-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2019-09-01/vmssPublicIpAddress.json
  - Microsoft.Network/stable/2019-09-01/webapplicationfirewall.json

```

### Tag: schema-network-2019-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2019-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2019-08-01/applicationGateway.json
  - Microsoft.Network/stable/2019-08-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2019-08-01/availableDelegations.json
  - Microsoft.Network/stable/2019-08-01/availableServiceAliases.json
  - Microsoft.Network/stable/2019-08-01/azureFirewall.json
  - Microsoft.Network/stable/2019-08-01/azureFirewallFqdnTag.json
  - Microsoft.Network/stable/2019-08-01/bastionHost.json
  - Microsoft.Network/stable/2019-08-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2019-08-01/ddosCustomPolicy.json
  - Microsoft.Network/stable/2019-08-01/ddosProtectionPlan.json
  - Microsoft.Network/stable/2019-08-01/endpointService.json
  - Microsoft.Network/stable/2019-08-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2019-08-01/expressRouteCrossConnection.json
  - Microsoft.Network/stable/2019-08-01/expressRouteGateway.json
  - Microsoft.Network/stable/2019-08-01/expressRoutePort.json
  - Microsoft.Network/stable/2019-08-01/firewallPolicy.json
  - Microsoft.Network/stable/2019-08-01/loadBalancer.json
  - Microsoft.Network/stable/2019-08-01/natGateway.json
  - Microsoft.Network/stable/2019-08-01/network.json
  - Microsoft.Network/stable/2019-08-01/networkInterface.json
  - Microsoft.Network/stable/2019-08-01/networkProfile.json
  - Microsoft.Network/stable/2019-08-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2019-08-01/networkWatcher.json
  - Microsoft.Network/stable/2019-08-01/networkWatcherConnectionMonitorV1.json
  - Microsoft.Network/stable/2019-08-01/operation.json
  - Microsoft.Network/stable/2019-08-01/privateEndpoint.json
  - Microsoft.Network/stable/2019-08-01/privateLinkService.json
  - Microsoft.Network/stable/2019-08-01/publicIpAddress.json
  - Microsoft.Network/stable/2019-08-01/publicIpPrefix.json
  - Microsoft.Network/stable/2019-08-01/routeFilter.json
  - Microsoft.Network/stable/2019-08-01/routeTable.json
  - Microsoft.Network/stable/2019-08-01/serviceCommunity.json
  - Microsoft.Network/stable/2019-08-01/serviceEndpointPolicy.json
  - Microsoft.Network/stable/2019-08-01/serviceTags.json
  - Microsoft.Network/stable/2019-08-01/usage.json
  - Microsoft.Network/stable/2019-08-01/virtualNetwork.json
  - Microsoft.Network/stable/2019-08-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2019-08-01/virtualNetworkTap.json
  - Microsoft.Network/stable/2019-08-01/virtualRouter.json
  - Microsoft.Network/stable/2019-08-01/virtualWan.json
  - Microsoft.Network/stable/2019-08-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2019-08-01/vmssPublicIpAddress.json
  - Microsoft.Network/stable/2019-08-01/webapplicationfirewall.json

```

### Tag: schema-network-2019-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2019-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2019-07-01/applicationGateway.json
  - Microsoft.Network/stable/2019-07-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2019-07-01/availableDelegations.json
  - Microsoft.Network/stable/2019-07-01/azureFirewall.json
  - Microsoft.Network/stable/2019-07-01/azureFirewallFqdnTag.json
  - Microsoft.Network/stable/2019-07-01/bastionHost.json
  - Microsoft.Network/stable/2019-07-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2019-07-01/ddosCustomPolicy.json
  - Microsoft.Network/stable/2019-07-01/ddosProtectionPlan.json
  - Microsoft.Network/stable/2019-07-01/endpointService.json
  - Microsoft.Network/stable/2019-07-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2019-07-01/expressRouteCrossConnection.json
  - Microsoft.Network/stable/2019-07-01/expressRouteGateway.json
  - Microsoft.Network/stable/2019-07-01/expressRoutePort.json
  - Microsoft.Network/stable/2019-07-01/firewallPolicy.json
  - Microsoft.Network/stable/2019-07-01/loadBalancer.json
  - Microsoft.Network/stable/2019-07-01/natGateway.json
  - Microsoft.Network/stable/2019-07-01/network.json
  - Microsoft.Network/stable/2019-07-01/networkInterface.json
  - Microsoft.Network/stable/2019-07-01/networkProfile.json
  - Microsoft.Network/stable/2019-07-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2019-07-01/networkWatcher.json
  - Microsoft.Network/stable/2019-07-01/networkWatcherConnectionMonitorV1.json
  - Microsoft.Network/stable/2019-07-01/operation.json
  - Microsoft.Network/stable/2019-07-01/privateEndpoint.json
  - Microsoft.Network/stable/2019-07-01/privateLinkService.json
  - Microsoft.Network/stable/2019-07-01/publicIpAddress.json
  - Microsoft.Network/stable/2019-07-01/publicIpPrefix.json
  - Microsoft.Network/stable/2019-07-01/routeFilter.json
  - Microsoft.Network/stable/2019-07-01/routeTable.json
  - Microsoft.Network/stable/2019-07-01/serviceCommunity.json
  - Microsoft.Network/stable/2019-07-01/serviceEndpointPolicy.json
  - Microsoft.Network/stable/2019-07-01/serviceTags.json
  - Microsoft.Network/stable/2019-07-01/usage.json
  - Microsoft.Network/stable/2019-07-01/virtualNetwork.json
  - Microsoft.Network/stable/2019-07-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2019-07-01/virtualNetworkTap.json
  - Microsoft.Network/stable/2019-07-01/virtualRouter.json
  - Microsoft.Network/stable/2019-07-01/virtualWan.json
  - Microsoft.Network/stable/2019-07-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2019-07-01/vmssPublicIpAddress.json
  - Microsoft.Network/stable/2019-07-01/webapplicationfirewall.json

```

### Tag: schema-network-2019-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2019-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2019-06-01/applicationGateway.json
  - Microsoft.Network/stable/2019-06-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2019-06-01/availableDelegations.json
  - Microsoft.Network/stable/2019-06-01/azureFirewall.json
  - Microsoft.Network/stable/2019-06-01/azureFirewallFqdnTag.json
  - Microsoft.Network/stable/2019-06-01/bastionHost.json
  - Microsoft.Network/stable/2019-06-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2019-06-01/ddosCustomPolicy.json
  - Microsoft.Network/stable/2019-06-01/ddosProtectionPlan.json
  - Microsoft.Network/stable/2019-06-01/endpointService.json
  - Microsoft.Network/stable/2019-06-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2019-06-01/expressRouteCrossConnection.json
  - Microsoft.Network/stable/2019-06-01/expressRouteGateway.json
  - Microsoft.Network/stable/2019-06-01/expressRoutePort.json
  - Microsoft.Network/stable/2019-06-01/firewallPolicy.json
  - Microsoft.Network/stable/2019-06-01/loadBalancer.json
  - Microsoft.Network/stable/2019-06-01/natGateway.json
  - Microsoft.Network/stable/2019-06-01/network.json
  - Microsoft.Network/stable/2019-06-01/networkInterface.json
  - Microsoft.Network/stable/2019-06-01/networkProfile.json
  - Microsoft.Network/stable/2019-06-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2019-06-01/networkWatcher.json
  - Microsoft.Network/stable/2019-06-01/networkWatcherConnectionMonitorV1.json
  - Microsoft.Network/stable/2019-06-01/operation.json
  - Microsoft.Network/stable/2019-06-01/privateEndpoint.json
  - Microsoft.Network/stable/2019-06-01/privateLinkService.json
  - Microsoft.Network/stable/2019-06-01/publicIpAddress.json
  - Microsoft.Network/stable/2019-06-01/publicIpPrefix.json
  - Microsoft.Network/stable/2019-06-01/routeFilter.json
  - Microsoft.Network/stable/2019-06-01/routeTable.json
  - Microsoft.Network/stable/2019-06-01/serviceCommunity.json
  - Microsoft.Network/stable/2019-06-01/serviceEndpointPolicy.json
  - Microsoft.Network/stable/2019-06-01/serviceTags.json
  - Microsoft.Network/stable/2019-06-01/usage.json
  - Microsoft.Network/stable/2019-06-01/virtualNetwork.json
  - Microsoft.Network/stable/2019-06-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2019-06-01/virtualNetworkTap.json
  - Microsoft.Network/stable/2019-06-01/virtualWan.json
  - Microsoft.Network/stable/2019-06-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2019-06-01/vmssPublicIpAddress.json
  - Microsoft.Network/stable/2019-06-01/webapplicationfirewall.json

```

### Tag: schema-network-2019-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2019-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2019-04-01/applicationGateway.json
  - Microsoft.Network/stable/2019-04-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2019-04-01/availableDelegations.json
  - Microsoft.Network/stable/2019-04-01/azureFirewall.json
  - Microsoft.Network/stable/2019-04-01/azureFirewallFqdnTag.json
  - Microsoft.Network/stable/2019-04-01/bastionHost.json
  - Microsoft.Network/stable/2019-04-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2019-04-01/ddosCustomPolicy.json
  - Microsoft.Network/stable/2019-04-01/ddosProtectionPlan.json
  - Microsoft.Network/stable/2019-04-01/endpointService.json
  - Microsoft.Network/stable/2019-04-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2019-04-01/expressRouteCrossConnection.json
  - Microsoft.Network/stable/2019-04-01/expressRouteGateway.json
  - Microsoft.Network/stable/2019-04-01/expressRoutePort.json
  - Microsoft.Network/stable/2019-04-01/privateEndpoint.json
  - Microsoft.Network/stable/2019-04-01/privateLinkService.json
  - Microsoft.Network/stable/2019-04-01/loadBalancer.json
  - Microsoft.Network/stable/2019-04-01/natGateway.json
  - Microsoft.Network/stable/2019-04-01/network.json
  - Microsoft.Network/stable/2019-04-01/networkInterface.json
  - Microsoft.Network/stable/2019-04-01/networkProfile.json
  - Microsoft.Network/stable/2019-04-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2019-04-01/networkWatcher.json
  - Microsoft.Network/stable/2019-04-01/operation.json
  - Microsoft.Network/stable/2019-04-01/publicIpAddress.json
  - Microsoft.Network/stable/2019-04-01/publicIpPrefix.json
  - Microsoft.Network/stable/2019-04-01/routeFilter.json
  - Microsoft.Network/stable/2019-04-01/routeTable.json
  - Microsoft.Network/stable/2019-04-01/serviceCommunity.json
  - Microsoft.Network/stable/2019-04-01/serviceEndpointPolicy.json
  - Microsoft.Network/stable/2019-04-01/serviceTags.json
  - Microsoft.Network/stable/2019-04-01/usage.json
  - Microsoft.Network/stable/2019-04-01/virtualNetwork.json
  - Microsoft.Network/stable/2019-04-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2019-04-01/virtualNetworkTap.json
  - Microsoft.Network/stable/2019-04-01/virtualWan.json
  - Microsoft.Network/stable/2019-04-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2019-04-01/vmssPublicIpAddress.json
  - Microsoft.Network/stable/2019-04-01/webapplicationfirewall.json

```

### Tag: schema-network-2019-02-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2019-02-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2019-02-01/applicationGateway.json
  - Microsoft.Network/stable/2019-02-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2019-02-01/availableDelegations.json
  - Microsoft.Network/stable/2019-02-01/azureFirewall.json
  - Microsoft.Network/stable/2019-02-01/azureFirewallFqdnTag.json
  - Microsoft.Network/stable/2019-02-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2019-02-01/ddosCustomPolicy.json
  - Microsoft.Network/stable/2019-02-01/ddosProtectionPlan.json
  - Microsoft.Network/stable/2019-02-01/endpointService.json
  - Microsoft.Network/stable/2019-02-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2019-02-01/expressRouteCrossConnection.json
  - Microsoft.Network/stable/2019-02-01/expressRouteGateway.json
  - Microsoft.Network/stable/2019-02-01/expressRoutePort.json
  - Microsoft.Network/stable/2019-02-01/interfaceEndpoint.json
  - Microsoft.Network/stable/2019-02-01/loadBalancer.json
  - Microsoft.Network/stable/2019-02-01/natGateway.json
  - Microsoft.Network/stable/2019-02-01/network.json
  - Microsoft.Network/stable/2019-02-01/networkInterface.json
  - Microsoft.Network/stable/2019-02-01/networkProfile.json
  - Microsoft.Network/stable/2019-02-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2019-02-01/networkWatcher.json
  - Microsoft.Network/stable/2019-02-01/operation.json
  - Microsoft.Network/stable/2019-02-01/publicIpAddress.json
  - Microsoft.Network/stable/2019-02-01/publicIpPrefix.json
  - Microsoft.Network/stable/2019-02-01/routeFilter.json
  - Microsoft.Network/stable/2019-02-01/routeTable.json
  - Microsoft.Network/stable/2019-02-01/serviceCommunity.json
  - Microsoft.Network/stable/2019-02-01/serviceEndpointPolicy.json
  - Microsoft.Network/stable/2019-02-01/usage.json
  - Microsoft.Network/stable/2019-02-01/virtualNetwork.json
  - Microsoft.Network/stable/2019-02-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2019-02-01/virtualNetworkTap.json
  - Microsoft.Network/stable/2019-02-01/virtualWan.json
  - Microsoft.Network/stable/2019-02-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2019-02-01/vmssPublicIpAddress.json
  - Microsoft.Network/stable/2019-02-01/webapplicationfirewall.json

```

### Tag: schema-network-2018-12-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2018-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2018-12-01/applicationGateway.json
  - Microsoft.Network/stable/2018-12-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2018-12-01/availableDelegations.json
  - Microsoft.Network/stable/2018-12-01/azureFirewall.json
  - Microsoft.Network/stable/2018-12-01/azureFirewallFqdnTag.json
  - Microsoft.Network/stable/2018-12-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2018-12-01/ddosCustomPolicy.json
  - Microsoft.Network/stable/2018-12-01/ddosProtectionPlan.json
  - Microsoft.Network/stable/2018-12-01/endpointService.json
  - Microsoft.Network/stable/2018-12-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2018-12-01/expressRouteCrossConnection.json
  - Microsoft.Network/stable/2018-12-01/expressRouteGateway.json
  - Microsoft.Network/stable/2018-12-01/expressRoutePort.json
  - Microsoft.Network/stable/2018-12-01/interfaceEndpoint.json
  - Microsoft.Network/stable/2018-12-01/loadBalancer.json
  - Microsoft.Network/stable/2018-12-01/network.json
  - Microsoft.Network/stable/2018-12-01/networkInterface.json
  - Microsoft.Network/stable/2018-12-01/networkProfile.json
  - Microsoft.Network/stable/2018-12-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2018-12-01/networkWatcher.json
  - Microsoft.Network/stable/2018-12-01/operation.json
  - Microsoft.Network/stable/2018-12-01/publicIpAddress.json
  - Microsoft.Network/stable/2018-12-01/publicIpPrefix.json
  - Microsoft.Network/stable/2018-12-01/routeFilter.json
  - Microsoft.Network/stable/2018-12-01/routeTable.json
  - Microsoft.Network/stable/2018-12-01/serviceCommunity.json
  - Microsoft.Network/stable/2018-12-01/serviceEndpointPolicy.json
  - Microsoft.Network/stable/2018-12-01/usage.json
  - Microsoft.Network/stable/2018-12-01/virtualNetwork.json
  - Microsoft.Network/stable/2018-12-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2018-12-01/virtualNetworkTap.json
  - Microsoft.Network/stable/2018-12-01/virtualWan.json
  - Microsoft.Network/stable/2018-12-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2018-12-01/vmssPublicIpAddress.json
  - Microsoft.Network/stable/2018-12-01/webapplicationfirewall.json

```

### Tag: schema-network-2018-11-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2018-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2018-11-01/applicationGateway.json
  - Microsoft.Network/stable/2018-11-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2018-11-01/availableDelegations.json
  - Microsoft.Network/stable/2018-11-01/azureFirewall.json
  - Microsoft.Network/stable/2018-11-01/azureFirewallFqdnTag.json
  - Microsoft.Network/stable/2018-11-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2018-11-01/ddosCustomPolicy.json
  - Microsoft.Network/stable/2018-11-01/ddosProtectionPlan.json
  - Microsoft.Network/stable/2018-11-01/endpointService.json
  - Microsoft.Network/stable/2018-11-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2018-11-01/expressRouteCrossConnection.json
  - Microsoft.Network/stable/2018-11-01/expressRouteGateway.json
  - Microsoft.Network/stable/2018-11-01/expressRoutePort.json
  - Microsoft.Network/stable/2018-11-01/interfaceEndpoint.json
  - Microsoft.Network/stable/2018-11-01/loadBalancer.json
  - Microsoft.Network/stable/2018-11-01/network.json
  - Microsoft.Network/stable/2018-11-01/networkInterface.json
  - Microsoft.Network/stable/2018-11-01/networkProfile.json
  - Microsoft.Network/stable/2018-11-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2018-11-01/networkWatcher.json
  - Microsoft.Network/stable/2018-11-01/operation.json
  - Microsoft.Network/stable/2018-11-01/publicIpAddress.json
  - Microsoft.Network/stable/2018-11-01/publicIpPrefix.json
  - Microsoft.Network/stable/2018-11-01/routeFilter.json
  - Microsoft.Network/stable/2018-11-01/routeTable.json
  - Microsoft.Network/stable/2018-11-01/serviceCommunity.json
  - Microsoft.Network/stable/2018-11-01/serviceEndpointPolicy.json
  - Microsoft.Network/stable/2018-11-01/usage.json
  - Microsoft.Network/stable/2018-11-01/virtualNetwork.json
  - Microsoft.Network/stable/2018-11-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2018-11-01/virtualNetworkTap.json
  - Microsoft.Network/stable/2018-11-01/virtualWan.json
  - Microsoft.Network/stable/2018-11-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2018-11-01/vmssPublicIpAddress.json

```

### Tag: schema-network-2018-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2018-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2018-10-01/applicationGateway.json
  - Microsoft.Network/stable/2018-10-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2018-10-01/availableDelegations.json
  - Microsoft.Network/stable/2018-10-01/azureFirewall.json
  - Microsoft.Network/stable/2018-10-01/azureFirewallFqdnTag.json
  - Microsoft.Network/stable/2018-10-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2018-10-01/ddosProtectionPlan.json
  - Microsoft.Network/stable/2018-10-01/endpointService.json
  - Microsoft.Network/stable/2018-10-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2018-10-01/expressRouteCrossConnection.json
  - Microsoft.Network/stable/2018-10-01/expressRouteGateway.json
  - Microsoft.Network/stable/2018-10-01/expressRoutePort.json
  - Microsoft.Network/stable/2018-10-01/interfaceEndpoint.json
  - Microsoft.Network/stable/2018-10-01/loadBalancer.json
  - Microsoft.Network/stable/2018-10-01/network.json
  - Microsoft.Network/stable/2018-10-01/networkInterface.json
  - Microsoft.Network/stable/2018-10-01/networkProfile.json
  - Microsoft.Network/stable/2018-10-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2018-10-01/networkWatcher.json
  - Microsoft.Network/stable/2018-10-01/operation.json
  - Microsoft.Network/stable/2018-10-01/publicIpAddress.json
  - Microsoft.Network/stable/2018-10-01/publicIpPrefix.json
  - Microsoft.Network/stable/2018-10-01/routeFilter.json
  - Microsoft.Network/stable/2018-10-01/routeTable.json
  - Microsoft.Network/stable/2018-10-01/serviceCommunity.json
  - Microsoft.Network/stable/2018-10-01/serviceEndpointPolicy.json
  - Microsoft.Network/stable/2018-10-01/usage.json
  - Microsoft.Network/stable/2018-10-01/virtualNetwork.json
  - Microsoft.Network/stable/2018-10-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2018-10-01/virtualNetworkTap.json
  - Microsoft.Network/stable/2018-10-01/virtualWan.json
  - Microsoft.Network/stable/2018-10-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2018-10-01/vmssPublicIpAddress.json

```

### Tag: schema-network-2018-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2018-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2018-08-01/applicationGateway.json
  - Microsoft.Network/stable/2018-08-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2018-08-01/availableDelegations.json
  - Microsoft.Network/stable/2018-08-01/azureFirewall.json
  - Microsoft.Network/stable/2018-08-01/azureFirewallFqdnTag.json
  - Microsoft.Network/stable/2018-08-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2018-08-01/ddosProtectionPlan.json
  - Microsoft.Network/stable/2018-08-01/endpointService.json
  - Microsoft.Network/stable/2018-08-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2018-08-01/expressRouteCrossConnection.json
  - Microsoft.Network/stable/2018-08-01/expressRouteGateway.json
  - Microsoft.Network/stable/2018-08-01/expressRoutePort.json
  - Microsoft.Network/stable/2018-08-01/interfaceEndpoint.json
  - Microsoft.Network/stable/2018-08-01/loadBalancer.json
  - Microsoft.Network/stable/2018-08-01/network.json
  - Microsoft.Network/stable/2018-08-01/networkInterface.json
  - Microsoft.Network/stable/2018-08-01/networkProfile.json
  - Microsoft.Network/stable/2018-08-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2018-08-01/networkWatcher.json
  - Microsoft.Network/stable/2018-08-01/operation.json
  - Microsoft.Network/stable/2018-08-01/publicIpAddress.json
  - Microsoft.Network/stable/2018-08-01/publicIpPrefix.json
  - Microsoft.Network/stable/2018-08-01/routeFilter.json
  - Microsoft.Network/stable/2018-08-01/routeTable.json
  - Microsoft.Network/stable/2018-08-01/serviceCommunity.json
  - Microsoft.Network/stable/2018-08-01/serviceEndpointPolicy.json
  - Microsoft.Network/stable/2018-08-01/usage.json
  - Microsoft.Network/stable/2018-08-01/virtualNetwork.json
  - Microsoft.Network/stable/2018-08-01/virtualNetworkTap.json
  - Microsoft.Network/stable/2018-08-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2018-08-01/virtualWan.json
  - Microsoft.Network/stable/2018-08-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2018-08-01/vmssPublicIpAddress.json

```

### Tag: schema-network-2018-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2018-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2018-07-01/azureFirewall.json
  - Microsoft.Network/stable/2018-07-01/applicationGateway.json
  - Microsoft.Network/stable/2018-07-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2018-07-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2018-07-01/ddosProtectionPlan.json
  - Microsoft.Network/stable/2018-07-01/endpointService.json
  - Microsoft.Network/stable/2018-07-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2018-07-01/expressRouteCrossConnection.json
  - Microsoft.Network/stable/2018-07-01/loadBalancer.json
  - Microsoft.Network/stable/2018-07-01/network.json
  - Microsoft.Network/stable/2018-07-01/networkInterface.json
  - Microsoft.Network/stable/2018-07-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2018-07-01/networkWatcher.json
  - Microsoft.Network/stable/2018-07-01/operation.json
  - Microsoft.Network/stable/2018-07-01/publicIpAddress.json
  - Microsoft.Network/stable/2018-07-01/publicIpPrefix.json
  - Microsoft.Network/stable/2018-07-01/routeFilter.json
  - Microsoft.Network/stable/2018-07-01/routeTable.json
  - Microsoft.Network/stable/2018-07-01/serviceCommunity.json
  - Microsoft.Network/stable/2018-07-01/usage.json
  - Microsoft.Network/stable/2018-07-01/virtualNetwork.json
  - Microsoft.Network/stable/2018-07-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2018-07-01/virtualWan.json
  - Microsoft.Network/stable/2018-07-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2018-07-01/vmssPublicIpAddress.json
  - Microsoft.Network/stable/2018-07-01/serviceEndpointPolicy.json

```

### Tag: schema-network-2018-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2018-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2018-06-01/azureFirewall.json
  - Microsoft.Network/stable/2018-06-01/applicationGateway.json
  - Microsoft.Network/stable/2018-06-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2018-06-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2018-06-01/ddosProtectionPlan.json
  - Microsoft.Network/stable/2018-06-01/endpointService.json
  - Microsoft.Network/stable/2018-06-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2018-06-01/expressRouteCrossConnection.json
  - Microsoft.Network/stable/2018-06-01/loadBalancer.json
  - Microsoft.Network/stable/2018-06-01/network.json
  - Microsoft.Network/stable/2018-06-01/networkInterface.json
  - Microsoft.Network/stable/2018-06-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2018-06-01/networkWatcher.json
  - Microsoft.Network/stable/2018-06-01/operation.json
  - Microsoft.Network/stable/2018-06-01/publicIpAddress.json
  - Microsoft.Network/stable/2018-06-01/routeFilter.json
  - Microsoft.Network/stable/2018-06-01/routeTable.json
  - Microsoft.Network/stable/2018-06-01/serviceCommunity.json
  - Microsoft.Network/stable/2018-06-01/usage.json
  - Microsoft.Network/stable/2018-06-01/virtualNetwork.json
  - Microsoft.Network/stable/2018-06-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2018-06-01/virtualWan.json
  - Microsoft.Network/stable/2018-06-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2018-06-01/vmssPublicIpAddress.json

```

### Tag: schema-network-2018-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2018-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2018-04-01/azureFirewall.json
  - Microsoft.Network/stable/2018-04-01/applicationGateway.json
  - Microsoft.Network/stable/2018-04-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2018-04-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2018-04-01/ddosProtectionPlan.json
  - Microsoft.Network/stable/2018-04-01/endpointService.json
  - Microsoft.Network/stable/2018-04-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2018-04-01/expressRouteCrossConnection.json
  - Microsoft.Network/stable/2018-04-01/loadBalancer.json
  - Microsoft.Network/stable/2018-04-01/network.json
  - Microsoft.Network/stable/2018-04-01/networkInterface.json
  - Microsoft.Network/stable/2018-04-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2018-04-01/networkWatcher.json
  - Microsoft.Network/stable/2018-04-01/operation.json
  - Microsoft.Network/stable/2018-04-01/publicIpAddress.json
  - Microsoft.Network/stable/2018-04-01/routeFilter.json
  - Microsoft.Network/stable/2018-04-01/routeTable.json
  - Microsoft.Network/stable/2018-04-01/serviceCommunity.json
  - Microsoft.Network/stable/2018-04-01/usage.json
  - Microsoft.Network/stable/2018-04-01/virtualNetwork.json
  - Microsoft.Network/stable/2018-04-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2018-04-01/virtualWan.json
  - Microsoft.Network/stable/2018-04-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2018-04-01/vmssPublicIpAddress.json

```

### Tag: schema-network-2018-02-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2018-02-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2018-02-01/applicationGateway.json
  - Microsoft.Network/stable/2018-02-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2018-02-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2018-02-01/ddosProtectionPlan.json
  - Microsoft.Network/stable/2018-02-01/endpointService.json
  - Microsoft.Network/stable/2018-02-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2018-02-01/expressRouteCrossConnection.json
  - Microsoft.Network/stable/2018-02-01/loadBalancer.json
  - Microsoft.Network/stable/2018-02-01/network.json
  - Microsoft.Network/stable/2018-02-01/networkInterface.json
  - Microsoft.Network/stable/2018-02-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2018-02-01/networkWatcher.json
  - Microsoft.Network/stable/2018-02-01/operation.json
  - Microsoft.Network/stable/2018-02-01/publicIpAddress.json
  - Microsoft.Network/stable/2018-02-01/routeFilter.json
  - Microsoft.Network/stable/2018-02-01/routeTable.json
  - Microsoft.Network/stable/2018-02-01/serviceCommunity.json
  - Microsoft.Network/stable/2018-02-01/usage.json
  - Microsoft.Network/stable/2018-02-01/virtualNetwork.json
  - Microsoft.Network/stable/2018-02-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2018-02-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2018-02-01/vmssPublicIpAddress.json

```

### Tag: schema-network-2018-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2018-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2018-01-01/applicationGateway.json
  - Microsoft.Network/stable/2018-01-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2018-01-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2018-01-01/endpointService.json
  - Microsoft.Network/stable/2018-01-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2018-01-01/loadBalancer.json
  - Microsoft.Network/stable/2018-01-01/network.json
  - Microsoft.Network/stable/2018-01-01/networkInterface.json
  - Microsoft.Network/stable/2018-01-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2018-01-01/networkWatcher.json
  - Microsoft.Network/stable/2018-01-01/operation.json
  - Microsoft.Network/stable/2018-01-01/publicIpAddress.json
  - Microsoft.Network/stable/2018-01-01/routeFilter.json
  - Microsoft.Network/stable/2018-01-01/routeTable.json
  - Microsoft.Network/stable/2018-01-01/serviceCommunity.json
  - Microsoft.Network/stable/2018-01-01/usage.json
  - Microsoft.Network/stable/2018-01-01/virtualNetwork.json
  - Microsoft.Network/stable/2018-01-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2018-01-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2018-01-01/vmssPublicIpAddress.json

```

### Tag: schema-network-2017-11-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2017-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2017-11-01/applicationGateway.json
  - Microsoft.Network/stable/2017-11-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2017-11-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2017-11-01/endpointService.json
  - Microsoft.Network/stable/2017-11-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2017-11-01/loadBalancer.json
  - Microsoft.Network/stable/2017-11-01/network.json
  - Microsoft.Network/stable/2017-11-01/networkInterface.json
  - Microsoft.Network/stable/2017-11-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2017-11-01/networkWatcher.json
  - Microsoft.Network/stable/2017-11-01/operation.json
  - Microsoft.Network/stable/2017-11-01/publicIpAddress.json
  - Microsoft.Network/stable/2017-11-01/routeFilter.json
  - Microsoft.Network/stable/2017-11-01/routeTable.json
  - Microsoft.Network/stable/2017-11-01/serviceCommunity.json
  - Microsoft.Network/stable/2017-11-01/usage.json
  - Microsoft.Network/stable/2017-11-01/virtualNetwork.json
  - Microsoft.Network/stable/2017-11-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2017-11-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2017-11-01/vmssPublicIpAddress.json

```

### Tag: schema-network-2017-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2017-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2017-10-01/applicationGateway.json
  - Microsoft.Network/stable/2017-10-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2017-10-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2017-10-01/endpointService.json
  - Microsoft.Network/stable/2017-10-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2017-10-01/loadBalancer.json
  - Microsoft.Network/stable/2017-10-01/network.json
  - Microsoft.Network/stable/2017-10-01/networkInterface.json
  - Microsoft.Network/stable/2017-10-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2017-10-01/networkWatcher.json
  - Microsoft.Network/stable/2017-10-01/operation.json
  - Microsoft.Network/stable/2017-10-01/publicIpAddress.json
  - Microsoft.Network/stable/2017-10-01/routeFilter.json
  - Microsoft.Network/stable/2017-10-01/routeTable.json
  - Microsoft.Network/stable/2017-10-01/serviceCommunity.json
  - Microsoft.Network/stable/2017-10-01/usage.json
  - Microsoft.Network/stable/2017-10-01/virtualNetwork.json
  - Microsoft.Network/stable/2017-10-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2017-10-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2017-10-01/vmssPublicIpAddress.json

```

### Tag: schema-network-2017-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2017-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2017-09-01/applicationGateway.json
  - Microsoft.Network/stable/2017-09-01/applicationSecurityGroup.json
  - Microsoft.Network/stable/2017-09-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2017-09-01/endpointService.json
  - Microsoft.Network/stable/2017-09-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2017-09-01/loadBalancer.json
  - Microsoft.Network/stable/2017-09-01/network.json
  - Microsoft.Network/stable/2017-09-01/networkInterface.json
  - Microsoft.Network/stable/2017-09-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2017-09-01/networkWatcher.json
  - Microsoft.Network/stable/2017-09-01/operation.json
  - Microsoft.Network/stable/2017-09-01/publicIpAddress.json
  - Microsoft.Network/stable/2017-09-01/routeFilter.json
  - Microsoft.Network/stable/2017-09-01/routeTable.json
  - Microsoft.Network/stable/2017-09-01/serviceCommunity.json
  - Microsoft.Network/stable/2017-09-01/usage.json
  - Microsoft.Network/stable/2017-09-01/virtualNetwork.json
  - Microsoft.Network/stable/2017-09-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2017-09-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2017-09-01/vmssPublicIpAddress.json

```

### Tag: schema-network-2017-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2017-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2017-08-01/applicationGateway.json
  - Microsoft.Network/stable/2017-08-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2017-08-01/endpointService.json
  - Microsoft.Network/stable/2017-08-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2017-08-01/loadBalancer.json
  - Microsoft.Network/stable/2017-08-01/network.json
  - Microsoft.Network/stable/2017-08-01/networkInterface.json
  - Microsoft.Network/stable/2017-08-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2017-08-01/networkWatcher.json
  - Microsoft.Network/stable/2017-08-01/publicIpAddress.json
  - Microsoft.Network/stable/2017-08-01/routeFilter.json
  - Microsoft.Network/stable/2017-08-01/routeTable.json
  - Microsoft.Network/stable/2017-08-01/serviceCommunity.json
  - Microsoft.Network/stable/2017-08-01/usage.json
  - Microsoft.Network/stable/2017-08-01/virtualNetwork.json
  - Microsoft.Network/stable/2017-08-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2017-08-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2017-08-01/vmssPublicIpAddress.json

```

### Tag: schema-network-2017-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2017-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2017-06-01/applicationGateway.json
  - Microsoft.Network/stable/2017-06-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2017-06-01/endpointService.json
  - Microsoft.Network/stable/2017-06-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2017-06-01/loadBalancer.json
  - Microsoft.Network/stable/2017-06-01/network.json
  - Microsoft.Network/stable/2017-06-01/networkInterface.json
  - Microsoft.Network/stable/2017-06-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2017-06-01/networkWatcher.json
  - Microsoft.Network/stable/2017-06-01/publicIpAddress.json
  - Microsoft.Network/stable/2017-06-01/routeFilter.json
  - Microsoft.Network/stable/2017-06-01/routeTable.json
  - Microsoft.Network/stable/2017-06-01/serviceCommunity.json
  - Microsoft.Network/stable/2017-06-01/usage.json
  - Microsoft.Network/stable/2017-06-01/virtualNetwork.json
  - Microsoft.Network/stable/2017-06-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2017-06-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2017-06-01/vmssPublicIpAddress.json

```

### Tag: schema-network-2017-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2017-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2017-03-01/applicationGateway.json
  - Microsoft.Network/stable/2017-03-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2017-03-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2017-03-01/loadBalancer.json
  - Microsoft.Network/stable/2017-03-01/network.json
  - Microsoft.Network/stable/2017-03-01/networkInterface.json
  - Microsoft.Network/stable/2017-03-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2017-03-01/networkWatcher.json
  - Microsoft.Network/stable/2017-03-01/publicIpAddress.json
  - Microsoft.Network/stable/2017-03-01/routeFilter.json
  - Microsoft.Network/stable/2017-03-01/routeTable.json
  - Microsoft.Network/stable/2017-03-01/serviceCommunity.json
  - Microsoft.Network/stable/2017-03-01/usage.json
  - Microsoft.Network/stable/2017-03-01/virtualNetwork.json
  - Microsoft.Network/stable/2017-03-01/virtualNetworkGateway.json
  - Microsoft.Network/stable/2017-03-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2017-03-01/vmssPublicIpAddress.json

```

### Tag: schema-network-2016-12-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2016-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2016-12-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2016-12-01/applicationGateway.json
  - Microsoft.Network/stable/2016-12-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2016-12-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2016-12-01/loadBalancer.json
  - Microsoft.Network/stable/2016-12-01/network.json
  - Microsoft.Network/stable/2016-12-01/networkInterface.json
  - Microsoft.Network/stable/2016-12-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2016-12-01/networkWatcher.json
  - Microsoft.Network/stable/2016-12-01/publicIpAddress.json
  - Microsoft.Network/stable/2016-12-01/routeFilter.json
  - Microsoft.Network/stable/2016-12-01/routeTable.json
  - Microsoft.Network/stable/2016-12-01/serviceCommunity.json
  - Microsoft.Network/stable/2016-12-01/usage.json
  - Microsoft.Network/stable/2016-12-01/virtualNetwork.json
  - Microsoft.Network/stable/2016-12-01/virtualNetworkGateway.json

```

### Tag: schema-network-2016-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2016-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2016-09-01/vmssNetworkInterface.json
  - Microsoft.Network/stable/2016-09-01/applicationGateway.json
  - Microsoft.Network/stable/2016-09-01/checkDnsAvailability.json
  - Microsoft.Network/stable/2016-09-01/expressRouteCircuit.json
  - Microsoft.Network/stable/2016-09-01/loadBalancer.json
  - Microsoft.Network/stable/2016-09-01/network.json
  - Microsoft.Network/stable/2016-09-01/networkInterface.json
  - Microsoft.Network/stable/2016-09-01/networkSecurityGroup.json
  - Microsoft.Network/stable/2016-09-01/networkWatcher.json
  - Microsoft.Network/stable/2016-09-01/publicIpAddress.json
  - Microsoft.Network/stable/2016-09-01/routeTable.json
  - Microsoft.Network/stable/2016-09-01/usage.json
  - Microsoft.Network/stable/2016-09-01/virtualNetwork.json
  - Microsoft.Network/stable/2016-09-01/virtualNetworkGateway.json

```

### Tag: schema-network-2016-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2016-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2016-06-01/network.json

```

### Tag: schema-network-2016-03-30 and azureresourceschema

``` yaml $(tag) == 'schema-network-2016-03-30' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2016-03-30/network.json

```

### Tag: schema-network-2015-06-15 and azureresourceschema

``` yaml $(tag) == 'schema-network-2015-06-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2015-06-15/applicationGateway.json
  - Microsoft.Network/stable/2015-06-15/checkDnsAvailability.json
  - Microsoft.Network/stable/2015-06-15/expressRouteCircuit.json
  - Microsoft.Network/stable/2015-06-15/loadBalancer.json
  - Microsoft.Network/stable/2015-06-15/network.json
  - Microsoft.Network/stable/2015-06-15/networkInterface.json
  - Microsoft.Network/stable/2015-06-15/networkSecurityGroup.json
  - Microsoft.Network/stable/2015-06-15/publicIpAddress.json
  - Microsoft.Network/stable/2015-06-15/routeTable.json
  - Microsoft.Network/stable/2015-06-15/usage.json
  - Microsoft.Network/stable/2015-06-15/virtualNetwork.json
  - Microsoft.Network/stable/2015-06-15/virtualNetworkGateway.json
  - Microsoft.Network/stable/2015-06-15/vmssNetworkInterface.json

```

### Tag: schema-network-2015-05-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-network-2015-05-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/preview/2015-05-01-preview/network.json

```
