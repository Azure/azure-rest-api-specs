import "../Common/SqlEnums.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Class representing Azure SQL PAAS suitability details.")
model SqlAssessmentV2PaasSuitabilityData {
    @doc("Gets the azure SQL PAAS SKU.")
    @visibility("read")
    azureSqlSku?: AzureSqlPaasSkuDTO;

    @doc("Gets the replica azure SQL PAAS SKU.")
    @visibility("read")
    @extension("x-ms-identifiers", [])
    replicaAzureSqlSku?: AzureSqlPaasSkuDTO[];

    @doc("Gets the shared resources.")
    @visibility("read")
    sharedResources?: SharedResourcesDTO;

    @doc("Gets the monthly compute cost.")
    @visibility("read")
    monthlyComputeCost?: float32;

    @doc("Gets the monthly storage cost.")
    @visibility("read")
    monthlyStorageCost?: float32;

    @doc("Gets a value indicating whether replicas should be provisioned.")
    @visibility("read")
    shouldProvisionReplicas?: boolean;

    @doc("Gets the replication mode.")
    @visibility("read")
    skuReplicationMode?: SkuReplicationMode;

    @doc("Gets the list of migration guidelines applicable to this target.")
    @visibility("read")
    @extension("x-ms-identifiers", [])
    migrationGuidelines?: SqlMigrationGuideline[];

    @doc("Gets the list of SQL recommendation Reasoning.")
    @visibility("read")
    @extension("x-ms-identifiers", [])
    recommendationReasonings?: SqlRecommendationReasoning[];

    @doc("Gets the migration target platform.")
    @visibility("read")
    migrationTargetPlatform?: TargetType;

    @doc("Gets the azure suitability.")
    @visibility("read")
    suitability?: CloudSuitability;

    @doc("Gets the list of migrations issues.")
    @visibility("read")
    @extension("x-ms-identifiers", [])
    migrationIssues?: SqlAssessmentMigrationIssue[];
}

#suppress "@azure-tools/cadl-azure-core/casing-style"
@doc("Class representing Azure SQL PAAS SKU.")
model AzureSqlPaasSkuDTO {
    @doc("Gets the service tier.")
    @visibility("read")
    azureSqlServiceTier?: AzureSqlServiceTier;

    @doc("Gets the compute tier.")
    @visibility("read")
    azureSqlComputeTier?: ComputeTier;

    @doc("Gets the hardware generation.")
    @visibility("read")
    azureSqlHardwareGeneration?: HardwareGeneration;

    #suppress "@azure-tools/cadl-azure-core/casing-style"
    @doc("Gets the storage maximum size in megabytes.")
    @visibility("read")
    storageMaxSizeInMB?: float32;

    #suppress "@azure-tools/cadl-azure-core/casing-style"
    @doc("""
    Gets the predicted data size in megabytes in the Azure SQL, will impact the
    billing cost.
    """)
    @visibility("read")
    predictedDataSizeInMB?: float32;

    #suppress "@azure-tools/cadl-azure-core/casing-style"
    @doc("""
    Gets the predicted log size in megabytes in the Azure SQL, will impact the
    billing cost.
    """)
    @visibility("read")
    predictedLogSizeInMB?: float32;

    @doc("Gets the number of cores.")
    @visibility("read")
    cores?: int32;

    @doc("Gets the target type.")
    @visibility("read")
    azureSqlTargetType?: TargetType;
}

#suppress "@azure-tools/cadl-azure-core/casing-style"
@doc("Shared Resources.")
model SharedResourcesDTO {
    @doc("Gets the list of shared data disks.")
    @visibility("read")
    @extension("x-ms-identifiers", [])
    sharedDataDisks?: AzureManagedDiskSkuDTO[];

    @doc("Gets the list of shared log disks.")
    @visibility("read")
    @extension("x-ms-identifiers", [])
    sharedLogDisks?: AzureManagedDiskSkuDTO[];

    @doc("Gets the list of shared Temporary database disks.")
    @visibility("read")
    @extension("x-ms-identifiers", [])
    sharedTempDbDisks?: AzureManagedDiskSkuDTO[];

    @doc("Gets number of mounts of shared disks.")
    @visibility("read")
    numberOfMounts?: int32;

    @doc("Gets quorum witness.")
    @visibility("read")
    quorumWitness?: AzureQuorumWitnessDTO;
}

#suppress "@azure-tools/cadl-azure-core/casing-style"
@doc("Class representing an Azure Managed Disk SKU.")
model AzureManagedDiskSkuDTO {
    @doc("Gets the Type (\"tier\") of disk - e.g. standard, premium, ultra.")
    @visibility("read")
    diskType?: AzureManagedDiskSkuDTODiskType;

    @doc("Gets the Size of the managed disk - e.g. P30, P40.")
    @visibility("read")
    diskSize?: AzureDiskSize;

    @doc("Gets disk redundancy - e.g. LRS, ZRS.")
    @visibility("read")
    diskRedundancy?: AzureManagedDiskSkuDTODiskRedundancy;

    @doc("Gets the managed disk storage cost.")
    @visibility("read")
    storageCost?: float32;
}

#suppress "@azure-tools/cadl-azure-core/casing-style"
@doc("Quorum Witness.")
model AzureQuorumWitnessDTO {
    @doc("Gets quorum witness type.")
    @visibility("read")
    quorumWitnessType?: AzureQuorumWitnessDTOQuorumWitnessType;
}

@doc("Class representing the SQL migration issues.")
model SqlAssessmentMigrationIssue {
    @doc("Gets the issue id.")
    @visibility("read")
    issueId?: string;

    @doc("Gets the issue category.")
    @visibility("read")
    issueCategory?: SqlAssessmentMigrationIssueCategory;

    @doc("Gets the list of impacted objects.")
    @visibility("read")
    @extension("x-ms-identifiers", [])
    impactedObjects?: ImpactedAssessmentObject[];
}

@doc("Class representing the impacted objects.")
model ImpactedAssessmentObject {
    @doc("Gets the object name.")
    @visibility("read")
    objectName?: string;

    @doc("Gets the object type.")
    @visibility("read")
    objectType?: string;
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
    @visibility("read")
    @extension("x-ms-identifiers", [])
    contextParameters?: SqlRecommendationReasoningContext[];
}

@doc("Class representing Azure SQL Recommendation Reasoning Context.")
model SqlRecommendationReasoningContext {

    @doc("Gets the reasoning context key.")
    contextKey?: string;

    @doc("Gets the reasoning context value.")
    contextValue?: string;
}

@doc("Class representing Azure SQL IAAS suitability details.")
model SqlAssessmentV2IaasSuitabilityData {
    @doc("Gets the azure SQL IAAS SKU.")
    @visibility("read")
    azureSqlSku?: AzureSqlIaasSkuDTO;

    @doc("Gets the replica azure SQL IAAS SKU.")
    @visibility("read")
    @extension("x-ms-identifiers", [])
    replicaAzureSqlSku?: AzureSqlIaasSkuDTO[];

    @doc("Gets the shared resources.")
    @visibility("read")
    sharedResources?: SharedResourcesDTO;

    @doc("Gets the monthly compute cost.")
    @visibility("read")
    monthlyComputeCost?: float32;

    @doc("Gets the monthly storage cost.")
    @visibility("read")
    monthlyStorageCost?: float32;

    @doc("Gets a value indicating whether replicas should be provisioned.")
    @visibility("read")
    shouldProvisionReplicas?: boolean;

    @doc("Gets the replication mode.")
    @visibility("read")
    skuReplicationMode?: SkuReplicationMode;

    @doc("Gets the list of migration guidelines applicable to this target.")
    @visibility("read")
    @extension("x-ms-identifiers", [])
    migrationGuidelines?: SqlMigrationGuideline[];

    @doc("Gets the list of SQL recommendation Reasoning.")
    @visibility("read")
    @extension("x-ms-identifiers", [])
    recommendationReasonings?: SqlRecommendationReasoning[];

    @doc("Gets the migration target platform.")
    @visibility("read")
    migrationTargetPlatform?: TargetType;

    @doc("Gets the azure suitability.")
    @visibility("read")
    suitability?: CloudSuitability;

    @doc("Gets the list of migrations issues.")
    @visibility("read")
    @extension("x-ms-identifiers", [])
    migrationIssues?: SqlAssessmentMigrationIssue[];
}

#suppress "@azure-tools/cadl-azure-core/casing-style"
@doc("Class representing Azure SQL IAAS SKU.")
model AzureSqlIaasSkuDTO {
    @doc("Gets the The Azure Compute Virtual Machine.")
    @visibility("read")
    virtualMachineSize?: AzureVirtualMachineSkuDTO;

    @doc("Gets the The list of data disk sizes.")
    @visibility("read")
    @extension("x-ms-identifiers", [])
    dataDiskSizes?: AzureManagedDiskSkuDTO[];

    @doc("Gets the The list of log disk sizes.")
    @visibility("read")
    @extension("x-ms-identifiers", [])
    logDiskSizes?: AzureManagedDiskSkuDTO[];

    @doc("Gets the target type.")
    @visibility("read")
    azureSqlTargetType?: TargetType;
}

#suppress "@azure-tools/cadl-azure-core/casing-style"
@doc("Azure Virtual Machine SKU.")
model AzureVirtualMachineSkuDTO {
    @doc("Gets the Virtual Machine Family, for example : standardMSFamily.")
    @visibility("read")
    azureVmFamily?: AzureVmFamily;

    @doc("Gets the Compute Size in vCores.")
    @visibility("read")
    cores?: int32;

    @doc("Gets the Virtual Machine SKU name,: E.g. : Standard_F16s.")
    @visibility("read")
    azureSkuName?: AzureVmSize;

    @doc("""
    Gets the Available vCores. This can be less than the vCores in the Constrained
    vCPU VM Sizes.
    """)
    @visibility("read")
    availableCores?: int32;

    @doc("Gets the Max network interfaces.")
    @visibility("read")
    maxNetworkInterfaces?: int32;
}

@doc("Assessed Sql Instance Summary.")
model AssessedSqlInstanceSummary {

    @doc("Gets the instance id.")
    instanceId?: string;

    @doc("Gets the instance name.")
    instanceName?: string;

    #suppress "@azure-tools/cadl-azure-core/casing-style"
    @doc("Gets the instance arm id.")
    sqlInstanceSDSArmId?: string;

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

    #suppress "@azure-tools/cadl-azure-core/casing-style"
    @doc("Gets the Sql Fci state.")
    sqlFCIState?: SqlFCIState;
}

@doc("Assessed Disk.")
model AssessedDisk {

    @doc("Gets the suitability.")
    suitability?: CloudSuitability;

    @doc("Gets the suitability explanation.")
    suitabilityExplanation?: AzureDiskSuitabilityExplanation;

    @doc("Gets the suitability detail.")
    suitabilityDetail?: AzureDiskSuitabilityDetail;

    @doc("Gets the recommended disk size.")
    recommendedDiskSize?: AzureDiskSize;

    @doc("Gets the recommended disk type.")
    recommendedDiskType?: AzureDiskType;

    @doc("Gets the recommended disk size.")
    recommendedDiskSizeGigabytes?: int32;

    @doc("Gets the recommended disk throughput.")
    recommendDiskThroughputInMbps?: float32;

    @doc("Gets the recommended disk iops.")
    recommendedDiskIops?: float32;

    @doc("Gets the monthly storage cost.")
    monthlyStorageCost?: float32;

    @doc("Gets the name.")
    name?: string;

    @doc("Gets the machine display name.")
    displayName?: string;

    @doc("Gets the gigabytes provisioned.")
    gigabytesProvisioned?: float32;

    @doc("Gets the megabytes per second of read.")
    megabytesPerSecondOfRead?: float32;

    @doc("Gets the megabytes per second of write.")
    megabytesPerSecondOfWrite?: float32;

    @doc("Gets the number of read operations per second.")
    numberOfReadOperationsPerSecond?: float32;

    @doc("Gets the number of write operations per second.")
    numberOfWriteOperationsPerSecond?: float32;
}

@doc("Assessed Network Adapter.")
model AssessedNetworkAdapter {

    @doc("Gets the suitability.")
    suitability?: CloudSuitability;

    @doc("Gets the suitability detail.")
    suitabilityDetail?: AzureNetworkAdapterSuitabilityDetail;

    @doc("Gets the suitability explanation.")
    suitabilityExplanation?: AzureNetworkAdapterSuitabilityExplanation;

    @doc("Gets the monthly bandwidth costs.")
    monthlyBandwidthCosts?: float32;

    @doc("Gets the net gigabytes transmitted per month.")
    netGigabytesTransmittedPerMonth?: float32;

    @doc("Gets the name.")
    name?: string;

    @doc("Gets the display name.")
    displayName?: string;

    @doc("Gets the mac address.")
    macAddress?: string;

    @doc("Gets the ip addresses.")
    @visibility("read")
    @extension("x-ms-identifiers", [])
    ipAddresses?: string[];

    @doc("Gets the megabytes per second received.")
    megabytesPerSecondReceived?: float32;

    @doc("Gets the megabytes per second transmitted.")
    megabytesPerSecondTransmitted?: float32;
}

@doc("Sql Migration Guideline.")
model SqlMigrationGuideline {

    @doc("Gets the guideline id.")
    guidelineId?: string;

    @doc("Gets the migration guideline category.")
    migrationGuidelineCategory?: SqlMigrationGuidelineCategory;

    @doc("Gets the migration guideline context.")
    @visibility("read")
    @extension("x-ms-identifiers", [])
    migrationGuidelineContext?: MigrationGuidelineContext[];
}

@doc("Migration Guideline Context.")
model MigrationGuidelineContext {

    @doc("Gets the reasoning context key.")
    contextKey?: string;

    @doc("Gets the reasoning context value.")
    contextValue?: string;
}

#suppress "@azure-tools/cadl-azure-core/casing-style"
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
    @extension("x-ms-identifiers", [])
    targetLocations?: AzureLocation[];
}

@doc("Entity Uptime.")
model EntityUptime {

    @doc("Gets the days per month.")
    daysPerMonth?: int32;

    @doc("Gets the hours per day.")
    hoursPerDay?: int32;
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

@doc("SQL VM assessment settings.")
model SqlVmSettings {
    @doc("""
    Gets or sets the Azure VM families (calling instance series to keep it
    consistent with other targets).
    """)
    @extension("x-ms-identifiers", [])
    instanceSeries?: AzureVmFamily[];
}

@doc("Assessed Sql Instance Disk Details.")
model AssessedSqlInstanceDiskDetails {

    @doc("Gets the disk id.")
    diskId?: string;

    #suppress "@azure-tools/cadl-azure-core/casing-style"
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

    #suppress "@azure-tools/cadl-azure-core/casing-style"
    @doc("Gets the total database size in MB.")
    totalDatabaseSizeInMB?: float32;

    #suppress "@azure-tools/cadl-azure-core/casing-style"
    @doc("Gets the largest database size in MB.")
    largestDatabaseSizeInMB?: float32;

    @doc("Gets the total discovered user databases.")
    totalDiscoveredUserDatabases?: int32;
}

@doc("Assessed Sql Instance Storage Details.")
model AssessedSqlInstanceStorageDetails {

    @doc("Gets the storage type.")
    storageType?: string;

    #suppress "@azure-tools/cadl-azure-core/casing-style"
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
  
  #suppress "@azure-tools/cadl-azure-core/casing-style"
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

    #suppress "@azure-tools/cadl-azure-core/casing-style"
    @doc("Gets the availability group arm id.")
    sqlAvailabilityGroupSDSArmId?: string;

    @doc("Gets the availability group entity id.")
    sqlAvailabilityGroupEntityId?: string;

    @doc("Gets the availability replica id.")
    sqlAvailabilityReplicaId?: string;
  }