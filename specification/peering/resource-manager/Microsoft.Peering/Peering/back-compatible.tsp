import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ClientGenerator.Core;
using Microsoft.Peering;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CdnPeeringPrefix.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Operation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PeeringLocation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PeeringServiceLocation.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PeeringServiceProvider.properties
);

@@clientName(Peerings.createOrUpdate::parameters.resource, "peering");
@@clientName(Peerings.update::parameters.properties, "tags");
@@clientLocation(Peerings.listByPeering, "ReceivedRoutes");
@@clientLocation(Peerings.list, "RpUnbilledPrefixes");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Peering.properties);

@@clientName(PeerAsns.createOrUpdate::parameters.resource, "peerAsn");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PeerAsn.properties);

@@clientLocation(PeeringRegisteredAsns.get, "RegisteredAsns");
@@clientLocation(PeeringRegisteredAsns.createOrUpdate, "RegisteredAsns");
@@clientName(PeeringRegisteredAsns.createOrUpdate::parameters.resource,
  "registeredAsn"
);
@@clientLocation(PeeringRegisteredAsns.delete, "RegisteredAsns");
@@clientLocation(PeeringRegisteredAsns.listByPeering, "RegisteredAsns");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PeeringRegisteredAsn.properties
);

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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PeeringRegisteredPrefix.properties
);

@@clientName(ConnectionMonitorTests.createOrUpdate::parameters.resource,
  "connectionMonitorTest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ConnectionMonitorTest.properties
);

@@clientLocation(PeeringServicePrefixes.get, "Prefixes");
@@clientLocation(PeeringServicePrefixes.createOrUpdate, "Prefixes");
@@clientName(PeeringServicePrefixes.createOrUpdate::parameters.resource,
  "peeringServicePrefix"
);
@@clientLocation(PeeringServicePrefixes.delete, "Prefixes");
@@clientLocation(PeeringServicePrefixes.listByPeeringService, "Prefixes");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PeeringServicePrefix.properties
);

@@clientName(PeeringServices.createOrUpdate::parameters.resource,
  "peeringService"
);
@@clientName(PeeringServices.update::parameters.properties, "tags");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PeeringService.properties);

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

@@clientName(checkServiceProviderAvailability::parameters.body,
  "checkServiceProviderAvailabilityInput"
);

@@clientLocation(Microsoft.Peering.checkServiceProviderAvailability,
  "Management",
  "go"
);
