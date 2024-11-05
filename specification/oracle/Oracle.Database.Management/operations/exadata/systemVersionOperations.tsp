import "../../../models/exadata/systemVersions.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Oracle.Database;

@armResourceOperations
interface SystemVersions extends OracleLocationBasedResource<SystemVersion> {}

@@doc(SystemVersions.listByLocation,
  "List SystemVersion resources by Location"
);

@@Autorest.example(SystemVersions.listByLocation,
  "./examples/systemVersions_listByLocation.json",
  "List Exadata System Versions by the provided filter"
);

@@Autorest.example(SystemVersions.get,
  "./examples/systemVersions_get.json",
  "Get Exadata System Version"
);
