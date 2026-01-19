import "../../models/exadata/dnsPrivateZones.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Oracle.Database;

@armResourceOperations
interface DnsPrivateZones extends OracleLocationBasedResource<DnsPrivateZone> {}

#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(DnsPrivateZones.listByLocation,
  "./examples/dnsPrivateZones_listByLocation.json",
  "List DnsPrivateZones by location"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(DnsPrivateZones.get,
  "./examples/dnsPrivateZones_get.json",
  "Get a DnsPrivateZone by name"
);
