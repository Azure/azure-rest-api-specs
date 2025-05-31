import "@azure-tools/typespec-azure-resource-manager";
import "../../models/autonomousdatabase/autonomousDatabaseVersion.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Oracle.Database;

@armResourceOperations
interface AutonomousDatabaseVersions
  extends OracleLocationBasedResource<AutonomousDbVersion> {}
