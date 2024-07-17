import "../../../models/exadata/giVersions.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Oracle.Database;

@armResourceOperations
interface GiVersions extends OracleLocationBasedResource<GiVersion> {}

@@example(GiVersions.listByLocation,
  "./examples/giVersions_listByLocation.json",
  "List GiVersions by location"
);
@@example(GiVersions.get,
  "./examples/giVersions_get.json",
  "Get a GiVersion by name"
);
