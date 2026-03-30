import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ManagedNetworkFabric;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessControlListPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(InternetGatewayPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IpCommunityPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IpExtendedCommunityPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IpPrefixPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(L2IsolationDomainPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(L3IsolationDomainPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(InternalNetworkPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ExternalNetworkPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NeighborGroupPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkDevicePatchParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkInterfacePatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkFabricControllerPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkFabricPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkToNetworkInterconnectPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkTapRulePatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkTapPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RoutePolicyPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkBootstrapInterfacePatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkBootstrapDevicePatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkMonitorPatch.properties);

@@clientName(AccessControlLists.create::parameters.resource, "body");
@@clientName(AccessControlLists.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccessControlList.properties);

@@clientName(InternetGatewayRules.create::parameters.resource, "body");
@@clientName(InternetGatewayRules.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(InternetGatewayRule.properties);

@@clientName(InternetGateways.create::parameters.resource, "body");
@@clientName(InternetGateways.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(InternetGateway.properties);

@@clientName(IpCommunities.create::parameters.resource, "body");
@@clientName(IpCommunities.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IpCommunity.properties);

@@clientName(IpExtendedCommunities.create::parameters.resource, "body");
@@clientName(IpExtendedCommunities.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IpExtendedCommunity.properties);

@@clientName(IpPrefixes.create::parameters.resource, "body");
@@clientName(IpPrefixes.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IpPrefix.properties);

@@clientName(L2IsolationDomains.create::parameters.resource, "body");
@@clientName(L2IsolationDomains.update::parameters.properties, "body");
@@clientName(L2IsolationDomains.updateAdministrativeState,
  "updateAdministrativeState"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(L2IsolationDomain.properties);

@@clientName(L3IsolationDomains.create::parameters.resource, "body");
@@clientName(L3IsolationDomains.update::parameters.properties, "body");
@@clientName(L3IsolationDomains.updateAdministrativeState,
  "updateAdministrativeState"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(L3IsolationDomain.properties);

@@clientName(InternalNetworks.create::parameters.resource, "body");
@@clientName(InternalNetworks.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(InternalNetwork.properties);

@@clientName(ExternalNetworks.create::parameters.resource, "body");
@@clientName(ExternalNetworks.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ExternalNetwork.properties);

@@clientName(NeighborGroups.create::parameters.resource, "body");
@@clientName(NeighborGroups.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NeighborGroup.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkDeviceSku.properties);

@@clientName(NetworkDevices.create::parameters.resource, "body");
@@clientName(NetworkDevices.update::parameters.properties, "body");
@@clientName(NetworkDevices.runRoCommand, "runRoCommand");
@@clientName(NetworkDevices.runRwCommand, "runRwCommand");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkDevice.properties);

@@clientName(NetworkInterfaces.create::parameters.resource, "body");
@@clientName(NetworkInterfaces.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkInterface.properties);

@@clientName(NetworkFabricControllers.create::parameters.resource, "body");
@@clientName(NetworkFabricControllers.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkFabricController.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkFabricSku.properties);

@@clientName(NetworkFabrics.create::parameters.resource, "body");
@@clientName(NetworkFabrics.update::parameters.properties, "body");
@@clientName(NetworkFabrics.provision, "provision");
@@clientName(NetworkFabrics.deprovision, "deprovision");
@@clientName(NetworkFabrics.upgrade, "upgrade");
@@clientName(NetworkFabrics.refreshConfiguration, "refreshConfiguration");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkFabric.properties);

@@clientName(NetworkToNetworkInterconnects.create::parameters.resource, "body");
@@clientName(NetworkToNetworkInterconnects.update::parameters.properties,
  "body"
);
@@clientName(NetworkToNetworkInterconnects.updateNpbStaticRouteBfdAdministrativeState,
  "updateNpbStaticRouteBfdAdministrativeState"
);
@@clientName(NetworkToNetworkInterconnects.updateAdministrativeState,
  "updateAdministrativeState"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkToNetworkInterconnect.properties);

@@clientName(NetworkPacketBrokers.create::parameters.resource, "body");
@@clientName(NetworkPacketBrokers.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkPacketBroker.properties);

@@clientName(NetworkRacks.create::parameters.resource, "body");
@@clientName(NetworkRacks.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkRack.properties);

@@clientName(NetworkTapRules.create::parameters.resource, "body");
@@clientName(NetworkTapRules.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkTapRule.properties);

@@clientName(NetworkTaps.create::parameters.resource, "body");
@@clientName(NetworkTaps.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkTap.properties);

@@clientName(RoutePolicies.create::parameters.resource, "body");
@@clientName(RoutePolicies.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RoutePolicy.properties);

@@clientName(NetworkBootstrapDevices.create::parameters.resource, "body");
@@clientName(NetworkBootstrapDevices.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkBootstrapDevice.properties);

@@clientName(NetworkBootstrapInterfaces.create::parameters.resource, "body");
@@clientName(NetworkBootstrapInterfaces.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkBootstrapInterface.properties);

@@clientName(NetworkMonitors.create::parameters.resource, "body");
@@clientName(NetworkMonitors.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkMonitor.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetworkMonitor.properties);

// Backward compatibility models for list results
model InternetGatewayRulesListResult is Azure.Core.Page<InternetGatewayRule>;
model InternetGatewaysListResult is Azure.Core.Page<InternetGateway>;
model IpCommunitiesListResult is Azure.Core.Page<IpCommunity>;
model IpPrefixesListResult is Azure.Core.Page<IpPrefix>;
model L2IsolationDomainsListResult is Azure.Core.Page<L2IsolationDomain>;
model L3IsolationDomainsListResult is Azure.Core.Page<L3IsolationDomain>;
model NeighborGroupsListResult is Azure.Core.Page<NeighborGroup>;
model NetworkDeviceSkusListResult is Azure.Core.Page<NetworkDeviceSku>;
model NetworkDevicesListResult is Azure.Core.Page<NetworkDevice>;
model NetworkFabricControllersListResult
  is Azure.Core.Page<NetworkFabricController>;
model NetworkFabricSkusListResult is Azure.Core.Page<NetworkFabricSku>;
model NetworkFabricsListResult is Azure.Core.Page<NetworkFabric>;
model NetworkPacketBrokersListResult is Azure.Core.Page<NetworkPacketBroker>;
model NetworkRacksListResult is Azure.Core.Page<NetworkRack>;
model NetworkTapRulesListResult is Azure.Core.Page<NetworkTapRule>;
model NetworkTapsListResult is Azure.Core.Page<NetworkTap>;
model RoutePoliciesListResult is Azure.Core.Page<RoutePolicy>;
model AccessControlListsListResult is Azure.Core.Page<AccessControlList>;
model ExternalNetworksList is Azure.Core.Page<ExternalNetwork>;
model InternalNetworksList is Azure.Core.Page<InternalNetwork>;
model NetworkInterfacesList is Azure.Core.Page<NetworkInterface>;
model NetworkToNetworkInterconnectsList
  is Azure.Core.Page<NetworkToNetworkInterconnect>;
