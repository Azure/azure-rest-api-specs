import "../Normalized Contract/StandardizedContracts/ProductSupportStatus.tsp";
import "../Common/CommonModels.tsp";
import "../Normalized Contract/StandardizedContracts/AssessedWorkloadProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Assessed SQL database web model class.")
@parentResource(SqlAssessmentV3)
model AssessedSqlDatabaseV3 is ProxyResource<AssessedSqlDatabaseV3Properties> {
  @doc("Sql assessment Assessed Databases ARM name.")
  @key("assessedSqlDatabaseName")
  @segment("assessedSqlDatabases")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "AvsAssessedMachine doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("Assessed SQL database properties web model.")
model AssessedSqlDatabaseV3Properties
  is AssessedWorkloadProperties<Linkages, SqlEntityRecommendations> {
  @doc("The sql db extended details.")
  @visibility(Lifecycle.Read)
  extendedDetails?: SqlDbExtendedDetails;

  @doc("When was assessed SQL database first created.")
  @visibility(Lifecycle.Read)
  createdTimestamp?: utcDateTime;

  @doc("When was assessed SQL database last updated.")
  @visibility(Lifecycle.Read)
  updatedTimestamp?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to mention MegaBytes and hence used GB, Mb would give Gigabits"
@doc("The sql db source information")
model SqlDbExtendedDetails {
  @doc("The linked availability group overview.")
  @visibility(Lifecycle.Read)
  linkedAvailabilityGroupOverview?: SqlAvailabilityGroupDataOverview;

  @doc("The product support status.")
  @visibility(Lifecycle.Read)
  productSupportStatus?: ProductSupportStatus;

  @doc("the aggregated cache size of this database.")
  @visibility(Lifecycle.Read)
  bufferCacheSizeInMB?: float32;

  @doc("The product support status.")
  @visibility(Lifecycle.Read)
  isDatabaseHighlyAvailable?: boolean;

  @doc("The product support status.")
  @visibility(Lifecycle.Read)
  databaseSizeInMB?: float32;

  @doc("Database compatibility level.")
  @visibility(Lifecycle.Read)
  compatibilityLevel?: CompatibilityLevel;

  @doc("The percentage of the total number of cores being utilized by the SQL database.")
  @visibility(Lifecycle.Read)
  percentageCoresUtilization?: float32;

  @doc("The read throughput of the SQL database.")
  @visibility(Lifecycle.Read)
  megabytesPerSecondOfRead?: float32;

  @doc("The write throughput of the SQL database.")
  @visibility(Lifecycle.Read)
  megabytesPerSecondOfWrite?: float32;

  @doc("The read operations per second of the SQL database.")
  @visibility(Lifecycle.Read)
  numberOfReadOperationsPerSecond?: float32;

  @doc("The write operations per second of the SQL database.")
  @visibility(Lifecycle.Read)
  numberOfWriteOperationsPerSecond?: float32;

  @doc("Gets or sets the SQL version.")
  sqlVersion: string;

  @doc("Gets or sets the SQL edition.")
  sqlEdition: string;

  @doc("Gets or sets a value indicating whether the parent SQL instance is clustered or not.")
  isClustered?: boolean;

  @doc("Gets or sets a value indicating whether the high availability is enabled or not.")
  isHighAvailabilityEnabled?: boolean;
}
