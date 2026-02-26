import "./SqlEnums.tsp";
import "../Normalized Contract/StandardizedContracts/CommonModels.tsp";
import "../Normalized Contract/StandardizedContracts/AssessedWorkloadProperties.tsp";
import "../Normalized Contract/StandardizedContracts/CostComponent.tsp";
import "../Normalized Contract/StandardizedContracts/ProductSupportStatus.tsp";

using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("Class representing Azure SQL PAAS suitability details.")
model SqlAssessmentV2PaasSuitabilityData {
  @doc("Gets the azure SQL PAAS SKU.")
  @visibility(Lifecycle.Read)
  azureSqlSku?: AzureSqlPaasSkuDto;

  @doc("Gets the replica azure SQL PAAS SKU.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  replicaAzureSqlSku?: AzureSqlPaasSkuDto[];

  @doc("Gets the shared resources.")
  @visibility(Lifecycle.Read)
  sharedResources?: SharedResourcesDto;

  @doc("Gets the monthly compute cost.")
  @visibility(Lifecycle.Read)
  monthlyComputeCost?: float32;

  @doc("Gets the monthly storage cost.")
  @visibility(Lifecycle.Read)
  monthlyStorageCost?: float32;

  @doc("Gets the collection of cost components.")
  @identifiers(#[])
  costComponents?: CostComponent[];

  @doc("Gets the suitability for Microsoft cloud defender.")
  @visibility(Lifecycle.Read)
  securitySuitability?: CloudSuitability;

  @doc("Gets a value indicating whether replicas should be provisioned.")
  @visibility(Lifecycle.Read)
  shouldProvisionReplicas?: boolean;

  @doc("Gets the replication mode.")
  @visibility(Lifecycle.Read)
  skuReplicationMode?: SkuReplicationMode;

  @doc("Gets the list of migration guidelines applicable to this target.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  migrationGuidelines?: SqlMigrationGuideline[];

  @doc("Gets the list of SQL recommendation Reasoning.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  recommendationReasonings?: SqlRecommendationReasoning[];

  @doc("Gets the migration target platform.")
  @visibility(Lifecycle.Read)
  migrationTargetPlatform?: TargetType;

  @doc("Gets the azure suitability.")
  @visibility(Lifecycle.Read)
  suitability?: CloudSuitability;

  @doc("Gets the list of migrations issues.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  migrationIssues?: SqlAssessmentMigrationIssue[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to mention MegaBytes and hence used MB, Mb would give Gigabits"
@doc("Class representing Azure SQL PAAS SKU.")
model AzureSqlPaasSkuDto {
  @doc("Gets the service tier.")
  @visibility(Lifecycle.Read)
  azureSqlServiceTier?: AzureSqlServiceTier;

  @doc("Gets the compute tier.")
  @visibility(Lifecycle.Read)
  azureSqlComputeTier?: ComputeTier;

  @doc("Gets the hardware generation.")
  @visibility(Lifecycle.Read)
  azureSqlHardwareGeneration?: HardwareGeneration;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Need to mention MegaBytes and hence used MB, Mb would give Gigabits"
  @doc("Gets the storage maximum size in megabytes.")
  @visibility(Lifecycle.Read)
  storageMaxSizeInMB?: float32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Need to mention MegaBytes and hence used MB, Mb would give Gigabits"
  @doc("""
    Gets the predicted data size in megabytes in the Azure SQL, will impact the
    billing cost.
    """)
  @visibility(Lifecycle.Read)
  predictedDataSizeInMB?: float32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Need to mention MegaBytes and hence used MB, Mb would give Gigabits"
  @doc("""
    Gets the predicted log size in megabytes in the Azure SQL, will impact the
    billing cost.
    """)
  @visibility(Lifecycle.Read)
  predictedLogSizeInMB?: float32;

  @doc("Gets the number of cores.")
  @visibility(Lifecycle.Read)
  cores?: int32;

  @doc("Gets the target type.")
  @visibility(Lifecycle.Read)
  azureSqlTargetType?: TargetType;
}

@doc("Class representing Azure SQL Recommendation Reasoning.")
model SqlRecommendationReasoning {
  @doc("Gets the reasoning id.")
  reasoningId?: string;

  @doc("Gets the reasoning status.")
  reasoningString?: string;

  @doc("Gets the reasoning category.")
  reasoningCategory?: string;

  @doc("Gets the Sql recommended reasoning parameters.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  contextParameters?: SqlRecommendationReasoningContext[];
}

@doc("Class representing Azure SQL Recommendation Reasoning Context.")
model SqlRecommendationReasoningContext {
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  @doc("Gets the reasoning context key.")
  contextKey?: string;

  @doc("Gets the reasoning context value.")
  contextValue?: string;
}

@doc("Class representing Azure SQL IAAS suitability details.")
model SqlAssessmentV2IaasSuitabilityData {
  @doc("Gets the azure SQL IAAS SKU.")
  @visibility(Lifecycle.Read)
  azureSqlSku?: AzureSqlIaasSkuDto;

  @doc("Gets the replica azure SQL IAAS SKU.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  replicaAzureSqlSku?: AzureSqlIaasSkuDto[];

  @doc("Gets the shared resources.")
  @visibility(Lifecycle.Read)
  sharedResources?: SharedResourcesDto;

  @doc("Gets the monthly compute cost.")
  @visibility(Lifecycle.Read)
  monthlyComputeCost?: float32;

  @doc("Gets the monthly storage cost.")
  @visibility(Lifecycle.Read)
  monthlyStorageCost?: float32;

  @doc("Gets the collection of cost components.")
  @identifiers(#[])
  costComponents?: CostComponent[];

  @doc("Gets the suitability for Microsoft cloud defender.")
  @visibility(Lifecycle.Read)
  securitySuitability?: CloudSuitability;

  @doc("Gets a value indicating whether replicas should be provisioned.")
  @visibility(Lifecycle.Read)
  shouldProvisionReplicas?: boolean;

  @doc("Gets the replication mode.")
  @visibility(Lifecycle.Read)
  skuReplicationMode?: SkuReplicationMode;

  @doc("Gets the list of migration guidelines applicable to this target.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  migrationGuidelines?: SqlMigrationGuideline[];

  @doc("Gets the list of SQL recommendation Reasoning.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  recommendationReasonings?: SqlRecommendationReasoning[];

  @doc("Gets the migration target platform.")
  @visibility(Lifecycle.Read)
  migrationTargetPlatform?: TargetType;

  @doc("Gets the azure suitability.")
  @visibility(Lifecycle.Read)
  suitability?: CloudSuitability;

  @doc("Gets the list of migrations issues.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  migrationIssues?: SqlAssessmentMigrationIssue[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Class representing Azure SQL IAAS SKU.")
model AzureSqlIaasSkuDto {
  @doc("Gets the The Azure Compute Virtual Machine.")
  @visibility(Lifecycle.Read)
  virtualMachineSize?: AzureVirtualMachineSkuDto;

  @doc("Gets the The list of data disk sizes.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  dataDiskSizes?: AzureManagedDiskSkuDto[];

  @doc("Gets the The list of log disk sizes.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  logDiskSizes?: AzureManagedDiskSkuDto[];

  @doc("Gets the target type.")
  @visibility(Lifecycle.Read)
  azureSqlTargetType?: TargetType;
}

@doc("Assessed Sql Instance Summary.")
model AssessedSqlInstanceSummary {
  @doc("Gets the instance id.")
  instanceId?: string;

  @doc("Gets the instance name.")
  instanceName?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @doc("Gets the instance arm id.")
  sqlInstanceSdsArmId?: string;

  @doc("Gets the instance entity id.")
  sqlInstanceEntityId?: string;

  @doc("Gets the Sql edition.")
  sqlEdition?: string;

  @doc("Gets the Sql version.")
  sqlVersion?: string;

  @doc("Gets whether Sql is clustered.")
  isClustered?: boolean;

  @doc("Gets whether Sql is highly available.")
  isHighAvailabilityEnabled?: boolean;

  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @doc("Gets the Sql Fci state.")
  sqlFciState?: SqlFCIState;
}

@doc("Sql Migration Guideline.")
model SqlMigrationGuideline {
  @doc("Gets the guideline id.")
  guidelineId?: string;

  @doc("Gets the migration guideline category.")
  migrationGuidelineCategory?: SqlMigrationGuidelineCategory;

  @doc("Gets the migration guideline context.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  migrationGuidelineContext?: MigrationGuidelineContext[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("SQL target options.")
model SqlPaaSTargetOptions {
  @doc("Gets or sets the Azure SQL compute tier.")
  computeTier?: ComputeTier;

  @doc("Gets or sets the Azure SQL hardware generation.")
  hardwareGeneration?: HardwareGeneration;

  @doc("Gets or sets the Azure SQL target type.")
  targetType?: TargetType;

  @doc("Gets or sets the Azure SQL service tier.")
  serviceTier?: AzureSqlServiceTier;

  @doc("Gets or sets the target location.")
  targetLocations?: AzureLocation[];
}

@doc("SQL managed instance assessment settings.")
model SqlMiSettings {
  @doc("Gets or sets the azure SQL service tier.")
  azureSqlServiceTier?: AzureSqlServiceTier;

  @doc("Gets or sets the azure PAAS SQL instance type.")
  azureSqlInstanceType?: AzureSqlInstanceType;
}

@doc("SQL database assessment settings.")
model SqlDbSettings {
  @doc("Gets or sets the azure SQL service tier.")
  azureSqlServiceTier?: AzureSqlServiceTier;

  @doc("Gets or sets the azure PAAS SQL instance type.")
  azureSqlDataBaseType?: AzureSqlDataBaseType;

  @doc("Gets or sets the azure SQL compute tier.")
  azureSqlComputeTier?: ComputeTier;

  @doc("Gets or sets the azure SQL purchase model.")
  azureSqlPurchaseModel?: AzureSqlPurchaseModel;
}

@doc("SQL managed instance assessment settings V3.")
model SqlMiSettingsV3 {
  @doc("Gets or sets the azure SQL service tier.")
  azureSqlServiceTier?: AzureSqlServiceTierV3;

  @doc("Gets or sets the azure PAAS SQL instance type.")
  azureSqlInstanceType?: AzureSqlInstanceType;
}

@doc("SQL database assessment settings V3.")
model SqlDbSettingsV3 {
  @doc("Gets or sets the azure SQL service tier.")
  azureSqlServiceTier?: AzureSqlServiceTierV3;

  @doc("Gets or sets the azure PAAS SQL instance type.")
  azureSqlDataBaseType?: AzureSqlDataBaseType;

  @doc("Gets or sets the azure SQL compute tier.")
  azureSqlComputeTier?: ComputeTier;

  @doc("Gets or sets the azure SQL purchase model.")
  azureSqlPurchaseModel?: AzureSqlPurchaseModel;
}

@doc("SQL VM assessment settings.")
model SqlVmSettings {
  @doc("""
    Gets or sets the Azure VM families (calling instance series to keep it
    consistent with other targets).
    """)
  instanceSeries?: AzureVmFamily[];
}

@doc("Assessed Sql Instance Disk Details.")
model AssessedSqlInstanceDiskDetails {
  @doc("Gets the disk id.")
  diskId?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Need to mention MegaBytes and hence used MB, Mb would give Gigabits"
  @doc("Gets the disk size in mb.")
  diskSizeInMB?: float32;

  @doc("Gets the megabytes per second of read.")
  megabytesPerSecondOfRead?: float32;

  @doc("Gets the megabytes per second of write.")
  megabytesPerSecondOfWrite?: float32;

  @doc("Gets the number of read operations per second.")
  numberOfReadOperationsPerSecond?: float32;

  @doc("Gets the number of write operations per second.")
  numberOfWriteOperationsPerSecond?: float32;
}

@doc("Assessed Sql Instance Database Summary.")
model AssessedSqlInstanceDatabaseSummary {
  @doc("Gets the number of user databases.")
  numberOfUserDatabases?: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Need to mention MegaBytes and hence used MB, Mb would give Gigabits"
  @doc("Gets the total database size in MB.")
  totalDatabaseSizeInMB?: float32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Need to mention MegaBytes and hence used MB, Mb would give Gigabits"
  @doc("Gets the largest database size in MB.")
  largestDatabaseSizeInMB?: float32;

  @doc("Gets the total discovered user databases.")
  totalDiscoveredUserDatabases?: int32;
}

@doc("Assessed Sql Instance Storage Details.")
model AssessedSqlInstanceStorageDetails {
  @doc("Gets the storage type.")
  storageType?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Need to mention MegaBytes and hence used MB, Mb would give Gigabits"
  @doc("Gets the disk size in mb.")
  diskSizeInMB?: float32;

  @doc("Gets the megabytes per second of read.")
  megabytesPerSecondOfRead?: float32;

  @doc("Gets the megabytes per second of read.")
  megabytesPerSecondOfWrite?: float32;

  @doc("Gets the number of read operations per second.")
  numberOfReadOperationsPerSecond?: float32;

  @doc("Gets the number of write operations per second.")
  numberOfWriteOperationsPerSecond?: float32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Need to mention MegaBytes and hence used MB, Mb would give Gigabits"
@doc("Sql fci meta data.")
model SqlFCIMetadata {
  @doc("Gets the Sql fci meta data state.")
  state?: SqlFCIMetadataState;

  @doc("Gets whether fci is multi subnet.")
  isMultiSubnet?: boolean;

  @doc("Gets the fci shared disk count.")
  fciSharedDiskCount?: int32;
}

@doc("Assessed Sql Availability Replica Summary.")
model SqlAvailabilityReplicaSummary {
  @doc("Gets the number Of synchronous read replicas.")
  numberOfSynchronousReadReplicas?: int32;

  @doc("Gets the number Of synchronous non read replicas.")
  numberOfSynchronousNonReadReplicas?: int32;

  @doc("Gets the number Of asynchronous read replicas.")
  numberOfAsynchronousReadReplicas?: int32;

  @doc("Gets the number Of asynchronous non read replicas.")
  numberOfAsynchronousNonReadReplicas?: int32;

  @doc("Gets the number Of primary replicas.")
  numberOfPrimaryReplicas?: int32;
}

@doc("Assessed Sql Availability Group Data Overview.")
model SqlAvailabilityGroupDataOverview {
  @doc("Gets the availability group id.")
  availabilityGroupId?: string;

  @doc("Gets the availability group name.")
  availabilityGroupName?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style"
  @doc("Gets the availability group arm id.")
  sqlAvailabilityGroupSdsArmId?: string;

  @doc("Gets the availability group entity id.")
  sqlAvailabilityGroupEntityId?: string;

  @doc("Gets the availability replica id.")
  sqlAvailabilityReplicaId?: string;
}

@doc("Recommendations for assessed sql entities.")
model SqlEntityRecommendations
  is Recommendations<
    SqlAssessmentMigrationIssue,
    MigrationSuitability,
    Skus<MigrationSuitability>
  > {
  @doc("Gets a value indicating whether replicas should be provisioned.")
  @visibility(Lifecycle.Read)
  shouldProvisionReplicas?: boolean;

  @doc("Gets the replication mode.")
  @visibility(Lifecycle.Read)
  skuReplicationMode?: SkuReplicationMode;

  @doc("Gets the list of migration guidelines applicable to this target.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  migrationGuidelines?: SqlMigrationGuideline[];

  @doc("The product support status.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  recommendationReasonings?: SqlRecommendationReasoning[];

  @doc("Gets the migration target platform.")
  @visibility(Lifecycle.Read)
  migrationTargetPlatform?: TargetType;

  @doc("Gets or sets the machine assessment ARM ID for VM fallback.")
  fallbackMachineAssessmentArmId?: string;
}

@doc("Class representing the SQL migration issues.")
model SqlAssessmentMigrationIssue is MigrationIssues {
  @doc("Gets the list of impacted objects.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  impactedObjects?: ImpactedAssessmentObject[];
}
