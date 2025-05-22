import "../../../models/autonomousdatabase/autonomousDatabaseCharacterSet.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Oracle.Database;

@armResourceOperations
interface AutonomousDatabaseCharacterSets
  extends OracleLocationBasedResource<AutonomousDatabaseCharacterSet> {}

@@doc(AutonomousDatabaseCharacterSets.listByLocation,
  "List AutonomousDatabaseCharacterSet resources by Location"
);

@@Autorest.example(AutonomousDatabaseCharacterSets.listByLocation,
  "./examples/autonomousDatabaseCharacterSet_listByLocation.json",
  "List autonomous db character sets by location"
);
@@Autorest.example(AutonomousDatabaseCharacterSets.get,
  "./examples/autonomousDatabaseCharacterSet_get.json",
  "Get autonomous db character set"
);
