using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Assessed SQL instance web model class.")
@parentResource(SqlAssessmentV3)
model AssessedSqlInstanceV3 is ProxyResource<AssessedSqlInstanceV3Properties> {
  @doc("Sql assessment Assessed Instance ARM name.")
  @key("assessedSqlInstanceName")
  @segment("assessedSqlInstances")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "AvsAssessedMachine doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("Assessed SQL instance properties web model.")
model AssessedSqlInstanceV3Properties
  is AssessedWorkloadProperties<Linkages, SqlEntityRecommendations> {
  @doc("The sql instance extended details.")
  @visibility(Lifecycle.Read)
  extendedDetails?: SqlInstanceExtendedDetails;

  @doc("When was assessed SQL instance first created.")
  @visibility(Lifecycle.Read)
  createdTimestamp?: utcDateTime;

  @doc("When was assessed SQL instance last updated.")
  @visibility(Lifecycle.Read)
  updatedTimestamp?: utcDateTime;
}

@doc("The sql instance extended details.")
model SqlInstanceExtendedDetails {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Need to mention MegaBytes and hence used MB, Mb would give Gigabits"
  @doc("Gets or sets the memory used by SQL instance in megabytes.")
  @visibility(Lifecycle.Read)
  memoryInUseInMB?: float32;

  @doc("Gets or sets a value indicating whether SQL instance has been deep discovered.")
  @visibility(Lifecycle.Read)
  hasScanOccurred?: boolean;

  @doc("Gets the storage details.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  storageTypeBasedDetails?: AssessedSqlInstanceStorageDetails[];

  @doc("Gets the product support status related details.")
  @visibility(Lifecycle.Read)
  productSupportStatus?: ProductSupportStatus;

  @doc("Gets the FCI metadata if this instance represents an FCI instance.")
  @visibility(Lifecycle.Read)
  fciMetadata?: SqlFCIMetadata;

  @doc("""
    Gets the overview counts of availability replicas in the assessed instance, by
    commit mode and read type.
    """)
  @visibility(Lifecycle.Read)
  availabilityReplicaSummary?: SqlAvailabilityReplicaSummary;

  @doc("Gets a value indicating whether the SQL instance is clustered or not.")
  @visibility(Lifecycle.Read)
  isClustered?: boolean;

  @doc("Gets a value indicating whether the high availability is enabled or not.")
  @visibility(Lifecycle.Read)
  isHighAvailabilityEnabled?: boolean;

  @doc("Gets the list of recommended target reasoning.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  recommendedTargetReasonings?: SqlRecommendationReasoning[];

  @doc("SQL instance edition.")
  @visibility(Lifecycle.Read)
  sqlEdition?: string;

  @doc("SQL instance version.")
  @visibility(Lifecycle.Read)
  sqlVersion?: string;

  @doc("Number of CPU cores assigned to the SQL instance.")
  @visibility(Lifecycle.Read)
  numberOfCoresAllocated?: int32;

  @doc("The percentage of the total number of cores being utilized by the SQL instance.")
  @visibility(Lifecycle.Read)
  percentageCoresUtilization?: float32;

  @doc("The logical disk details.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  logicalDisks?: AssessedSqlInstanceDiskDetails[];

  @doc("The databases summary.")
  @visibility(Lifecycle.Read)
  databaseSummary?: AssessedSqlInstanceDatabaseSummary;
}
