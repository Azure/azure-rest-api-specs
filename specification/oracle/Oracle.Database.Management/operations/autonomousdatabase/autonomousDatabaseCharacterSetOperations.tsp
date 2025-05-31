import "../../models/autonomousdatabase/autonomousDatabaseCharacterSet.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Oracle.Database;

@armResourceOperations
interface AutonomousDatabaseCharacterSets
  extends OracleLocationBasedResource<AutonomousDatabaseCharacterSet> {}
