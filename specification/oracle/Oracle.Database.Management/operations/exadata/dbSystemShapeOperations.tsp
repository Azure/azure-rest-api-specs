import "../../../models/exadata/dbSystemShapes.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Oracle.Database;

@armResourceOperations
interface DbSystemShapes extends OracleLocationBasedResource<DbSystemShape> {}

@@doc(DbSystemShapes.listByLocation,
  "List DbSystemShape resources by Location"
);

#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(DbSystemShapes.listByLocation,
  "./examples/dbSystemShapes_listByLocation.json",
  "List DbSystemShapes by location"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(DbSystemShapes.get,
  "./examples/dbSystemShapes_get.json",
  "Get a DbSystemShape by name"
);
