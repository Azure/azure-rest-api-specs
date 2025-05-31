import "../../models/autonomousdatabase/autonomousDatabaseNationalCharacterSet.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Oracle.Database;

@armResourceOperations
interface AutonomousDatabaseNationalCharacterSets
  extends OracleLocationBasedResource<AutonomousDatabaseNationalCharacterSet> {}
