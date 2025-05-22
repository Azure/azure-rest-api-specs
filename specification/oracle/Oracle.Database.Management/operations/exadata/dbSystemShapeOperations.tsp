import "../../../models/exadata/dbSystemShapes.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Oracle.Database;

@armResourceOperations
interface DbSystemShapes extends OracleLocationBasedResource<DbSystemShape> {}

@@doc(DbSystemShapes.listByLocation,
  "List DbSystemShape resources by Location"
);

@@Autorest.example(DbSystemShapes.listByLocation,
  "./examples/dbSystemShapes_listByLocation.json",
  "List DbSystemShapes by location"
);
@@Autorest.example(DbSystemShapes.get,
  "./examples/dbSystemShapes_get.json",
  "Get a DbSystemShape by name"
);
