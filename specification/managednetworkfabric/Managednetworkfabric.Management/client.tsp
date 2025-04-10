import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ManagedNetworkFabric;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AccessControlListPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(InternetGatewayPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IpCommunityPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IpExtendedCommunityPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IpPrefixPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(L2IsolationDomainPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(L3IsolationDomainPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(InternalNetworkPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ExternalNetworkPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NeighborGroupPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkDevicePatchParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkInterfacePatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkFabricControllerPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkFabricPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkToNetworkInterconnectPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkTapRulePatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkTapPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RoutePolicyPatch.properties);

@@clientName(AccessControlLists.create::parameters.resource, "body");
@@clientName(AccessControlLists.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AccessControlList.properties);

@@clientName(InternetGateways.create::parameters.resource, "body");
@@clientName(InternetGateways.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(InternetGateway.properties);

@@clientName(InternetGatewayRules.create::parameters.resource, "body");
@@clientName(InternetGatewayRules.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(InternetGatewayRule.properties);

@@clientName(IpCommunities.create::parameters.resource, "body");
@@clientName(IpCommunities.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IpCommunity.properties);

@@clientName(IpExtendedCommunities.create::parameters.resource, "body");
@@clientName(IpExtendedCommunities.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IpExtendedCommunity.properties);

@@clientName(IpPrefixes.create::parameters.resource, "body");
@@clientName(IpPrefixes.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IpPrefix.properties);

@@clientName(L2IsolationDomains.create::parameters.resource, "body");
@@clientName(L2IsolationDomains.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(L2IsolationDomain.properties);

@@clientName(L3IsolationDomains.create::parameters.resource, "body");
@@clientName(L3IsolationDomains.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(L3IsolationDomain.properties);

@@clientName(InternalNetworks.create::parameters.resource, "body");
@@clientName(InternalNetworks.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(InternalNetwork.properties);

@@clientName(ExternalNetworks.create::parameters.resource, "body");
@@clientName(ExternalNetworks.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ExternalNetwork.properties);

@@clientName(NeighborGroups.create::parameters.resource, "body");
@@clientName(NeighborGroups.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NeighborGroup.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkDeviceSku.properties);

@@clientName(NetworkDevices.create::parameters.resource, "body");
@@clientName(NetworkDevices.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkDevice.properties);

@@clientName(NetworkInterfaces.create::parameters.resource, "body");
@@clientName(NetworkInterfaces.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkInterface.properties);

@@clientName(NetworkFabricControllers.create::parameters.resource, "body");
@@clientName(NetworkFabricControllers.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkFabricController.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkFabricSku.properties);

@@clientName(NetworkFabrics.create::parameters.resource, "body");
@@clientName(NetworkFabrics.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkFabric.properties);

@@clientName(NetworkToNetworkInterconnects.create::parameters.resource, "body");
@@clientName(NetworkToNetworkInterconnects.update::parameters.properties,
  "body"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkToNetworkInterconnect.properties);

@@clientName(NetworkPacketBrokers.create::parameters.resource, "body");
@@clientName(NetworkPacketBrokers.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkPacketBroker.properties);

@@clientName(NetworkRacks.create::parameters.resource, "body");
@@clientName(NetworkRacks.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkRack.properties);

@@clientName(NetworkTapRules.create::parameters.resource, "body");
@@clientName(NetworkTapRules.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkTapRule.properties);

@@clientName(NetworkTaps.create::parameters.resource, "body");
@@clientName(NetworkTaps.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkTap.properties);

@@clientName(RoutePolicies.create::parameters.resource, "body");
@@clientName(RoutePolicies.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RoutePolicy.properties);
