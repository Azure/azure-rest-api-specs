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

#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(AutonomousDatabaseCharacterSets.listByLocation,
  "./examples/autonomousDatabaseCharacterSet_listByLocation.json",
  "List autonomous db character sets by location"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(AutonomousDatabaseCharacterSets.get,
  "./examples/autonomousDatabaseCharacterSet_get.json",
  "Get autonomous db character set"
);
