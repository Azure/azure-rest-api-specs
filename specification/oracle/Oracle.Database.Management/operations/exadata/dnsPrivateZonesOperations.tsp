import "../../models/exadata/dnsPrivateZones.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Oracle.Database;

@armResourceOperations
interface DnsPrivateZones extends OracleLocationBasedResource<DnsPrivateZone> {}
