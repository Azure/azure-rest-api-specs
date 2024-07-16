import "../../../models/exadata/dnsPrivateViews.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Oracle.Database;

@armResourceOperations
interface DnsPrivateViews extends OracleLocationBasedResource<DnsPrivateView> {}

@@Autorest.example(DnsPrivateViews.listByLocation,
  "./examples/dnsPrivateViews_listByLocation.json",
  "List DnsPrivateViews by location"
);
@@Autorest.example(DnsPrivateViews.get,
  "./examples/dnsPrivateViews_get.json",
  "Get a DnsPrivateView by name"
);
