import "../Common/SqlEnums.tsp";
import "../Common/CommonModels.tsp";
import "../Common/AzureResourceProperties.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Assessed SQL database web model class.")
@parentResource(SqlAssessmentV2)
model AssessedSqlDatabaseV2 is ProxyResource<AssessedSqlDatabaseV2Properties>{
    @doc("Sql assessment Assessed Databases ARM name.")
    @key("assessedSqlDatabaseName")
    @segment("assessedSqlDatabases")
    @path
    name: string;
}

@doc("Assessed SQL database properties web model.")
model AssessedSqlDatabaseV2Properties extends AzureResourceProperties {
  @doc("Gets or sets the recommended azure SQL target type.")
  @visibility("read")
  recommendedAzureSqlTargetType?: TargetType;

  @doc("Gets or sets the recommended azure SQL suitability.")
  @visibility("read")
  recommendedSuitability?: RecommendedSuitability;

  #suppress "@azure-tools/cadl-azure-core/casing-style"
  @doc("""
Gets or sets the aggregated cache size of this database. This is a performance
data metric for this DB.
""")
  @visibility("read")
  bufferCacheSizeInMB?: float32;

  #suppress "@azure-tools/cadl-azure-core/casing-style"
  @doc("Gets or sets the azure SQL MI suitability details.")
  @visibility("read")
  azureSqlMISuitabilityDetails?: SqlAssessmentV2PaasSuitabilityData;

  #suppress "@azure-tools/cadl-azure-core/casing-style"
  @doc("Gets or sets the azure SQL DB suitability details.")
  @visibility("read")
  azureSqlDBSuitabilityDetails?: SqlAssessmentV2PaasSuitabilityData;

  @doc("""
Gets a value indicating whether the assessed SQL database is highly available
or not.
""")
  @visibility("read")
  isDatabaseHighlyAvailable?: boolean;

  @doc("""
Gets the linked availability group overview if the database being assessed is
highly available.
""")
  @visibility("read")
  linkedAvailabilityGroupOverview?: SqlAvailabilityGroupDataOverview;

  @doc("Machine arm id.")
  @visibility("read")
  machineArmId?: string;

  @doc("Assessed SQL instance arm id.")
  @visibility("read")
  assessedSqlInstanceArmId?: string;

  @doc("Machine display name.")
  @visibility("read")
  @pattern("^[a-zA-Z0-9-]{3,24}$")  
  machineName?: string;

  @doc("SQL instance name.")
  @visibility("read")
  instanceName?: string;

  @doc("SQL database name.")
  @visibility("read")
  databaseName?: string;

  #suppress "@azure-tools/cadl-azure-core/casing-style"
  @doc("SQL database size in megabytes.")
  @visibility("read")
  databaseSizeInMB?: float32;

  @doc("Database compatibility level.")
  @visibility("read")
  compatibilityLevel?: CompatibilityLevel;

  #suppress "@azure-tools/cadl-azure-core/casing-style"
  @doc("SQL database SDS arm id.")
  @visibility("read")
  sqlDatabaseSDSArmId?: string;

  @doc("The percentage of the total number of cores being utilized by the SQL database.")
  @visibility("read")
  percentageCoresUtilization?: float32;

  @doc("The read throughput of the SQL database.")
  @visibility("read")
  megabytesPerSecondOfRead?: float32;

  @doc("The write throughput of the SQL database.")
  @visibility("read")
  megabytesPerSecondOfWrite?: float32;

  @doc("The read operations per second of the SQL database.")
  @visibility("read")
  numberOfReadOperationsPerSecond?: float32;

  @doc("The write operations per second of the SQL database.")
  @visibility("read")
  numberOfWriteOperationsPerSecond?: float32;

  @doc("Confidence Rating in Percentage.")
  @visibility("read")
  confidenceRatingInPercentage?: float32;

  @doc("When was assessed SQL database first created.")
  @visibility("read")
  createdTimestamp?: string;

  @doc("When was assessed SQL database last updated.")
  @visibility("read")
  updatedTimestamp?: string;
}
