import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Peering;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CdnPeeringPrefix.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PeeringLocation.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PeeringServiceLocation.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PeeringServiceProvider.properties);

@@clientName(Peerings.createOrUpdate::parameters.resource, "peering");
@@clientName(Peerings.update::parameters.properties, "tags");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Peering.properties);

@@clientName(PeerAsns.createOrUpdate::parameters.resource, "peerAsn");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PeerAsn.properties);

@@clientName(PeeringRegisteredAsns.createOrUpdate::parameters.resource,
  "registeredAsn"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PeeringRegisteredAsn.properties);

@@clientName(PeeringRegisteredPrefixes.createOrUpdate::parameters.resource,
  "registeredPrefix"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PeeringRegisteredPrefix.properties);

@@clientName(ConnectionMonitorTests.createOrUpdate::parameters.resource,
  "connectionMonitorTest"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConnectionMonitorTest.properties);

@@clientName(PeeringServicePrefixes.createOrUpdate::parameters.resource,
  "peeringServicePrefix"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PeeringServicePrefix.properties);

@@clientName(PeeringServices.createOrUpdate::parameters.resource,
  "peeringService"
);
@@clientName(PeeringServices.update::parameters.properties, "tags");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PeeringService.properties);
