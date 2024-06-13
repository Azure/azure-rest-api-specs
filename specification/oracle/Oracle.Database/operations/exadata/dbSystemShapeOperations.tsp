import "../../../models/exadata/dbSystemShapes.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Oracle.Database;

@armResourceOperations
interface DbSystemShapes extends OracleLocationBasedResource<DbSystemShape> {}

@@example(DbSystemShapes.listByLocation,
  "./examples/dbSystemShapes_listByLocation.json",
  "List DbSystemShapes by location"
);
@@example(DbSystemShapes.get,
  "./examples/dbSystemShapes_get.json",
  "Get a DbSystemShape by name"
);
