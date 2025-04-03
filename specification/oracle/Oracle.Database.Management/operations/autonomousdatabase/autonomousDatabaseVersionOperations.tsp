import "@azure-tools/typespec-azure-resource-manager";
import "../../../models/autonomousdatabase/autonomousDatabaseVersion.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Oracle.Database;

@armResourceOperations
interface AutonomousDatabaseVersions
  extends OracleLocationBasedResource<AutonomousDbVersion> {}

@@doc(AutonomousDatabaseVersions.listByLocation,
  "List AutonomousDbVersion resources by Location"
);

#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(AutonomousDatabaseVersions.listByLocation,
  "./examples/autonomousDatabaseVersion_listByLocation.json",
  "List an autonomous versions by location"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(AutonomousDatabaseVersions.get,
  "./examples/autonomousDatabaseVersion_get.json",
  "Get an autonomous version"
);
