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

@doc("SQL Assessment REST resource.")
@parentResource(SqlAssessmentV2)
model AssessedSqlRecommendedEntity is ProxyResource<AssessedSqlRecommendedEntityProperties>{
    @doc("Sql assessment Assessed Recommended Entity ARM name.")
    @key("recommendedAssessedEntityName")
    @segment("recommendedAssessedEntities")
    @path
    name: string;
}

@doc("Assessed SQL recommended entity properties.")
model AssessedSqlRecommendedEntityProperties extends AzureResourceProperties {
  @doc("Gets or sets machine name.")
  @visibility("read")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  machineName?: string;

  @doc("Gets or sets SQL instance name.")
  @visibility("read")
  instanceName?: string;

  @doc("Gets or sets assessed database count.")
  @visibility("read")
  dbCount?: int32;

  #suppress "@azure-tools/cadl-azure-core/casing-style"
  @doc("Gets or sets the total discovered database count.")
  @visibility("read")
  discoveredDBCount?: int32;

  @doc("""
Gets or sets a value indicating whether instance deep discovery has occurred or
not.
""")
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

  @doc("Gets or sets Arm id of assessed entity.")
  assessedSqlEntityArmId?: string;

  @doc("Gets or sets a value indicating whether the SQL instance is clustered or not.")
  @visibility("read")
  isClustered?: boolean;

  @doc("Gets or sets a value indicating whether the high availability is enabled or not.")
  @visibility("read")
  isHighAvailabilityEnabled?: boolean;

  @doc("Gets the SQL edition from the recommended entity if applicable.")
  @visibility("read")
  sqlEdition?: string;

  @doc("Gets the SQL version from the recommended entity if applicable.")
  @visibility("read")
  sqlVersion?: string;
}