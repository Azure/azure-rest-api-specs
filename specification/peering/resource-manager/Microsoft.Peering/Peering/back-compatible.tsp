import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Peering;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CdnPeeringPrefix.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Operation.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PeeringLocation.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PeeringServiceLocation.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PeeringServiceProvider.properties);

@@clientName(Peerings.createOrUpdate::parameters.resource, "peering");
@@clientName(Peerings.update::parameters.properties, "tags");
@@clientLocation(Peerings.listByPeering, "ReceivedRoutes");
@@clientLocation(Peerings.list, "RpUnbilledPrefixes");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Peering.properties);

@@clientName(PeerAsns.createOrUpdate::parameters.resource, "peerAsn");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PeerAsn.properties);

@@clientLocation(PeeringRegisteredAsns.get, "RegisteredAsns");
@@clientLocation(PeeringRegisteredAsns.createOrUpdate, "RegisteredAsns");
@@clientName(PeeringRegisteredAsns.createOrUpdate::parameters.resource,
  "registeredAsn"
);
@@clientLocation(PeeringRegisteredAsns.delete, "RegisteredAsns");
@@clientLocation(PeeringRegisteredAsns.listByPeering, "RegisteredAsns");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PeeringRegisteredAsn.properties);

@@clientLocation(PeeringRegisteredPrefixes.get, "RegisteredPrefixes");
@@clientLocation(PeeringRegisteredPrefixes.createOrUpdate,
  "RegisteredPrefixes"
);
@@clientName(PeeringRegisteredPrefixes.createOrUpdate::parameters.resource,
  "registeredPrefix"
);
@@clientLocation(PeeringRegisteredPrefixes.delete, "RegisteredPrefixes");
@@clientLocation(PeeringRegisteredPrefixes.listByPeering, "RegisteredPrefixes");
@@clientLocation(PeeringRegisteredPrefixes.validate, "RegisteredPrefixes");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PeeringRegisteredPrefix.properties);

@@clientName(ConnectionMonitorTests.createOrUpdate::parameters.resource,
  "connectionMonitorTest"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConnectionMonitorTest.properties);

@@clientLocation(PeeringServicePrefixes.get, "Prefixes");
@@clientLocation(PeeringServicePrefixes.createOrUpdate, "Prefixes");
@@clientName(PeeringServicePrefixes.createOrUpdate::parameters.resource,
  "peeringServicePrefix"
);
@@clientLocation(PeeringServicePrefixes.delete, "Prefixes");
@@clientLocation(PeeringServicePrefixes.listByPeeringService, "Prefixes");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PeeringServicePrefix.properties);

@@clientName(PeeringServices.createOrUpdate::parameters.resource,
  "peeringService"
);
@@clientName(PeeringServices.update::parameters.properties, "tags");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PeeringService.properties);

@@clientLocation(CdnPeeringPrefixesOperationGroup.list, "CdnPeeringPrefixes");

@@clientLocation(LegacyPeeringsOperationGroup.list, "LegacyPeerings");

@@clientLocation(LookingGlassOperationGroup.invoke, "LookingGlass");

@@clientLocation(PeeringLocationsOperationGroup.list, "PeeringLocations");

@@clientLocation(PeeringServiceCountriesOperationGroup.list,
  "PeeringServiceCountries"
);

@@clientLocation(PeeringServiceLocationsOperationGroup.list,
  "PeeringServiceLocations"
);

@@clientLocation(PeeringServiceProvidersOperationGroup.list,
  "PeeringServiceProviders"
);

@@clientLocation(PeeringServicesOperationGroup.initializeConnectionMonitor,
  PeeringServices
);
