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

@doc("Assessed SQL instance web model class.")
@parentResource(SqlAssessmentV2)
model AssessedSqlInstanceV2 is ProxyResource<AssessedSqlInstanceV2Properties>{
    @doc("Sql assessment Assessed Instance ARM name.")
    @key("assessedSqlInstanceName")
    @segment("assessedSqlInstances")
    @path
    name: string;
}

@doc("Assessed SQL instance properties web model.")
model AssessedSqlInstanceV2Properties extends AzureResourceProperties {

  #suppress "@azure-tools/cadl-azure-core/casing-style"
  @doc("Gets or sets the memory used by SQL instance in megabytes.")
  @visibility("read")
  memoryInUseInMB?: float32;

  @doc("Gets or sets a value indicating whether SQL instance has been deep discovered.")
  @visibility("read")
  hasScanOccurred?: boolean;

  @doc("Gets or sets the recommended azure SQL target type.")
  @visibility("read")
  recommendedAzureSqlTargetType?: TargetType;

  @doc("Gets or sets the recommended azure SQL suitability.")
  @visibility("read")
  recommendedSuitability?: RecommendedSuitability;

  #suppress "@azure-tools/cadl-azure-core/casing-style"
  @doc("SQL instance azure SQL MI suitability details.")
  @visibility("read")
  azureSqlMISuitabilityDetails?: SqlAssessmentV2PaasSuitabilityData;

  #suppress "@azure-tools/cadl-azure-core/casing-style"
  @doc("SQL instance azure SQL DB suitability details.")
  @visibility("read")
  azureSqlDBSuitabilityDetails?: SqlAssessmentV2PaasSuitabilityData;
  
  #suppress "@azure-tools/cadl-azure-core/casing-style"
  @doc("SQL instance azure SQL VM suitability details.")
  @visibility("read")
  azureSqlVMSuitabilityDetails?: SqlAssessmentV2IaasSuitabilityData;

  @doc("Gets the storage details.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  storageTypeBasedDetails?: AssessedSqlInstanceStorageDetails[];

  @doc("Gets the FCI metadata if this instance represents an FCI instance.")
  @visibility("read")
  fciMetadata?: SqlFCIMetadata;

  @doc("""
Gets the overview counts of availability replicas in the assessed instance, by
commit mode and read type.
""")
  @visibility("read")
  availabilityReplicaSummary?: SqlAvailabilityReplicaSummary;

  @doc("Gets a value indicating whether the SQL instance is clustered or not.")
  @visibility("read")
  isClustered?: boolean;

  @doc("Gets a value indicating whether the high availability is enabled or not.")
  @visibility("read")
  isHighAvailabilityEnabled?: boolean;

  @doc("Gets the list of recommended target reasoning.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  recommendedTargetReasonings?: SqlRecommendationReasoning[];

  @doc("Machine arm id.")
  @visibility("read")
  machineArmId?: string;

  @doc("Machine display name.")
  @visibility("read")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  machineName?: string;

  @doc("SQL instance name.")
  @visibility("read")
  instanceName?: string;

  #suppress "@azure-tools/cadl-azure-core/casing-style"
  @doc("SQL instance SDS arm id.")
  @visibility("read")
  sqlInstanceSDSArmId?: string;

  @doc("SQL instance edition.")
  @visibility("read")
  sqlEdition?: string;

  @doc("SQL instance version.")
  @visibility("read")
  sqlVersion?: string;

  @doc("Number of CPU cores assigned to the SQL instance.")
  @visibility("read")
  numberOfCoresAllocated?: int32;

  @doc("The percentage of the total number of cores being utilized by the SQL instance.")
  @visibility("read")
  percentageCoresUtilization?: float32;

  @doc("The logical disk details.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  logicalDisks?: AssessedSqlInstanceDiskDetails[];

  @doc("The databases summary.")
  @visibility("read")
  databaseSummary?: AssessedSqlInstanceDatabaseSummary;

  @doc("Confidence Rating in Percentage.")
  @visibility("read")
  confidenceRatingInPercentage?: float32;

  @doc("When was assessed SQL instance first created.")
  @visibility("read")
  createdTimestamp?: string;

  @doc("When was assessed SQL instance last updated.")
  @visibility("read")
  updatedTimestamp?: string;
}