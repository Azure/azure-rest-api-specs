  enum SqlFCIState {
    "Unknown",
    "Active",
    "Passive",
    "NotApplicable",
  }
  
  enum SqlMigrationGuidelineCategory {
    "Unknown",
    "General",
    "FailoverCluterInstanceGuideLine",
    "AvailabilityGroupGuideline",
  }
  
  enum AzureManagedDiskSkuDTODiskType {
    "Unknown",
    "Standard",
    "StandardSSD",
    "Premium",
    "StandardOrPremium",
    "Ultra",
  }
  
  enum AzureManagedDiskSkuDTODiskRedundancy {
    "Unknown",
    "LRS",
    "ZRS",
  }
  
  enum AzureQuorumWitnessDTOQuorumWitnessType {
    "Unknown",
    "Cloud",
    "Disk",
  }
  
  enum SqlAssessmentMigrationIssueCategory {
    "Issue",
    "Warning",
    "Internal",
  }
  
  enum SkuReplicationMode {
    "NotApplicable",
    "ActiveGeoReplication",
    "FailoverGroupInstance",
  }
  
  enum OsLicense {
    "Unknown",
    "Yes",
    "No",
  }
  
  enum OptimizationLogic {
    "MinimizeCost",
    "ModernizeToPaaS",
    "ModernizeToAzureSqlMi",
    "ModernizeToAzureSqlDb"
  }
  
  enum AzureSqlInstanceType {
    "Unknown",
    "Automatic",
    "SingleInstance",
    "InstancePools",
  }
  
  enum AzureSqlServiceTier {
    "Unknown",
    "Automatic",
    "GeneralPurpose",
    "BusinessCritical",
    "Hyperscale",
  }

  enum AzureSqlDataBaseType {
    "Unknown",
    "Automatic",
    "SingleDatabase",
    "ElasticPool",
  }
  
  enum AzureSqlPurchaseModel {
    "Unknown",
    "VCore",
    "DTU",
  }
  
  enum EnvironmentType {
    "Production",
    "Test",
  }
  
  enum MultiSubnetIntent {
    "None",
    "HighAvailability",
    "DisasterRecovery",
  }
  
  enum AsyncCommitModeIntent {
    "None",
    "HighAvailability",
    "DisasterRecovery",
  }
  
  enum SqlServerLicense {
    "Unknown",
    "Yes",
    "No",
  }

  enum VmFamilyCategoryItem {
    "Unknown",
    "GeneralPurpose",
    "ComputeOptimized",
    "MemoryOptimized",
    "StorageOptimized",
    "GpuOptimized",
    "HighPerformanceCompute",
    "SupportsPremiumStorage",
    "Confidential",
    "SupportsUltraDiskStorage",
  }

  enum ComputeTier {
    "Unknown",
    "Automatic",
    "Provisioned",
    "Serverless",
  }

  enum HardwareGeneration {
    "Unknown",
    "Automatic",
    "Gen5",
    Fsv2Series: "Fsv2_series",
    MSeries: "M_series",
    DCSeries: "DC_series",
  }

  enum TargetType {
    "Unknown",
    "Recommended",
    "AzureSqlDatabase",
    "AzureSqlManagedInstance",
    "AzureSqlVirtualMachine",
    "AzureVirtualMachine",
  }

  enum CompatibilityLevel {
    "Unknown",
    "CompatLevel80",
    "CompatLevel90",
    "CompatLevel100",
    "CompatLevel110",
    "CompatLevel120",
    "CompatLevel130",
    "CompatLevel140",
    "CompatLevel150",
  }

  enum RecommendedSuitability {
    "Unknown",
    "SuitableForSqlDB",
    "SuitableForSqlMI",
    "SuitableForVM",
    "PotentiallySuitableForVM",
    "ReadinessUnknown",
    "NotSuitable",
    "SuitableForSqlVM",
    "ConditionallySuitableForSqlDB",
    "ConditionallySuitableForSqlMI",
    "ConditionallySuitableForVM",
    "ConditionallySuitableForSqlVM",
  }

  enum SqlFCIMetadataState {
  "Unknown",
  "Inherited",
  "Initializing",
  "Online",
  "Offline",
  "Failed",
  "Pending",
  "OnlinePending",
  "OfflinePending",
}