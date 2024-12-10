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

#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(AutonomousDatabaseNationalCharacterSets.listByLocation,
  "./examples/autonomousDatabaseNationalCharacterSet_listByLocation.json",
  "List autonomous db national character sets by location"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(AutonomousDatabaseNationalCharacterSets.get,
  "./examples/autonomousDatabaseNationalCharacterSet_get.json",
  "Get autonomous db national character set"
);
