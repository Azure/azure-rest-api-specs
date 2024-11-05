import "../../../models/exadata/dnsPrivateZones.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Oracle.Database;

@armResourceOperations
interface DnsPrivateZones extends OracleLocationBasedResource<DnsPrivateZone> {}

@@doc(DnsPrivateZones.listByLocation,
  "List DnsPrivateZone resources by Location"
);

@@Autorest.example(DnsPrivateZones.listByLocation,
  "./examples/dnsPrivateZones_listByLocation.json",
  "List DnsPrivateZones by location"
);
@@Autorest.example(DnsPrivateZones.get,
  "./examples/dnsPrivateZones_get.json",
  "Get a DnsPrivateZone by name"
);
