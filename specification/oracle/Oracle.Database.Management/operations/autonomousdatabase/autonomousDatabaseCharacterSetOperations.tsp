import "../../../models/autonomousdatabase/autonomousDatabaseCharacterSet.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Oracle.Database;

@armResourceOperations
interface AutonomousDatabaseCharacterSets
  extends OracleLocationBasedResource<AutonomousDatabaseCharacterSet> {}

@@example(AutonomousDatabaseCharacterSets.listByLocation,
  "./examples/autonomousDatabaseCharacterSet_listByLocation.json",
  "List autonomous db character sets by location"
);
@@example(AutonomousDatabaseCharacterSets.get,
  "./examples/autonomousDatabaseCharacterSet_get.json",
  "Get autonomous db character set"
);
