import "../../models/exadata/dnsPrivateViews.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Oracle.Database;

@armResourceOperations
interface DnsPrivateViews extends OracleLocationBasedResource<DnsPrivateView> {}
