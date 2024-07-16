import "../../../models/exadata/dbSystemShapes.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Oracle.Database;

@armResourceOperations
interface DbSystemShapes extends OracleLocationBasedResource<DbSystemShape> {}

@@Autorest.example(DbSystemShapes.listByLocation,
  "./examples/dbSystemShapes_listByLocation.json",
  "List DbSystemShapes by location"
);
@@Autorest.example(DbSystemShapes.get,
  "./examples/dbSystemShapes_get.json",
  "Get a DbSystemShape by name"
);
