import "../../../models/exadata/dnsPrivateViews.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Oracle.Database;

@armResourceOperations
interface DnsPrivateViews extends OracleLocationBasedResource<DnsPrivateView> {}

@@doc(DnsPrivateViews.listByLocation,
  "List DnsPrivateView resources by Location"
);

#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(DnsPrivateViews.listByLocation,
  "./examples/dnsPrivateViews_listByLocation.json",
  "List DnsPrivateViews by location"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(DnsPrivateViews.get,
  "./examples/dnsPrivateViews_get.json",
  "Get a DnsPrivateView by name"
);
