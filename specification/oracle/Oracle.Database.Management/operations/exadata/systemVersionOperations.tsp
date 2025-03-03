import "../../../models/exadata/systemVersions.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Oracle.Database;

@armResourceOperations
interface SystemVersions extends OracleLocationBasedResource<SystemVersion> {}

@@doc(SystemVersions.listByLocation,
  "List SystemVersion resources by Location"
);

#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(SystemVersions.listByLocation,
  "./examples/systemVersions_listByLocation.json",
  "List Exadata System Versions by the provided filter"
);

#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(SystemVersions.get,
  "./examples/systemVersions_get.json",
  "Get Exadata System Version"
);
