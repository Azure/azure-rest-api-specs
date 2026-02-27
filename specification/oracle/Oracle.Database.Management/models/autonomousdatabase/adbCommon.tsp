using OpenAPI;
using TypeSpec.Versioning;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;

namespace Oracle.Database;

scalar AutonomousDatabaseId
  extends armResourceIdentifier<[
    {
      type: "Oracle.Database/autonomousDatabases",
    }
  ]>;

@doc("Retention period, in days, for backups.")
@minValue(90)
@maxValue(2558)
scalar RetentionPeriod extends int32;

@doc("Retention period, in days, for long-term backups")
@minValue(90)
@maxValue(3650)
scalar LongTermBackUpRetentionPeriod extends int32;
