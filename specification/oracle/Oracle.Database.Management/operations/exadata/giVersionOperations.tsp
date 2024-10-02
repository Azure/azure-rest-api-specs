import "../../models/exadata/giVersions.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Oracle.Database;

@armResourceOperations
interface GiVersions extends OracleLocationBasedResource<GiVersion> {}

#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(GiVersions.listByLocation,
  "./examples/giVersions_listByLocation.json",
  "List GiVersions by location"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(GiVersions.get,
  "./examples/giVersions_get.json",
  "Get a GiVersion by name"
);
