import "../../../models/autonomousdatabase/autonomousDatabaseNationalCharacterSet.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Oracle.Database;

@armResourceOperations
interface AutonomousDatabaseNationalCharacterSets
  extends OracleLocationBasedResource<AutonomousDatabaseNationalCharacterSet> {}

@@doc(AutonomousDatabaseNationalCharacterSets.listByLocation,
  "List AutonomousDatabaseNationalCharacterSet resources by Location"
);

@@Autorest.example(AutonomousDatabaseNationalCharacterSets.listByLocation,
  "./examples/autonomousDatabaseNationalCharacterSet_listByLocation.json",
  "List autonomous db national character sets by location"
);
@@Autorest.example(AutonomousDatabaseNationalCharacterSets.get,
  "./examples/autonomousDatabaseNationalCharacterSet_get.json",
  "Get autonomous db national character set"
);
