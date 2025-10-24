@doc("Sql FCI State")
union SqlFCIState {
  @doc("Unknown - Sql FCI State")
  Unknown: "Unknown",

  @doc("Active - Sql FCI State")
  Active: "Active",

  @doc("Passive - Sql FCI State")
  Passive: "Passive",

  @doc("NotApplicable - Sql FCI State")
  NotApplicable: "NotApplicable",

  string,
}

@doc("Sql Migration Guideline Category")
union SqlMigrationGuidelineCategory {
  @doc("Unknown - Sql Migration Guideline Category")
  Unknown: "Unknown",

  @doc("General - Sql Migration Guideline Category")
  General: "General",

  @doc("FailoverCluterInstanceGuideLine - Sql Migration Guideline Category")
  FailoverCluterInstanceGuideLine: "FailoverCluterInstanceGuideLine",

  @doc("AvailabilityGroupGuideline - Sql Migration Guideline Category")
  AvailabilityGroupGuideline: "AvailabilityGroupGuideline",

  string,
}

@doc("Sql Assessment Migration Issue Category")
union SqlAssessmentMigrationIssueCategory {
  @doc("Issue - Sql Assessment Migration Issue Category")
  Issue: "Issue",

  @doc("Warning - Sql Assessment Migration Issue Category")
  Warning: "Warning",

  @doc("Internal - Sql Assessment Migration Issue Category")
  Internal: "Internal",

  string,
}

@doc("Sku Replication Mode")
union SkuReplicationMode {
  @doc("NotApplicable Sku Replication Mode")
  NotApplicable: "NotApplicable",

  @doc("ActiveGeoReplication Sku Replication Mode")
  ActiveGeoReplication: "ActiveGeoReplication",

  @doc("FailoverGroupInstance Sku Replication Mode")
  FailoverGroupInstance: "FailoverGroupInstance",

  string,
}

@doc("Os License")
union OsLicense {
  @doc("Unknown Os License")
  Unknown: "Unknown",

  @doc("Yes Os License")
  Yes: "Yes",

  @doc("No Os License")
  No: "No",

  string,
}

@doc("Optimization Logic")
union OptimizationLogic {
  @doc("MinimizeCost - Optimization Logic")
  MinimizeCost: "MinimizeCost",

  @doc("ModernizeToPaaS - Optimization Logic")
  ModernizeToPaaS: "ModernizeToPaaS",

  @doc("ModernizeToAzureSqlMi - Optimization Logic")
  ModernizeToAzureSqlMi: "ModernizeToAzureSqlMi",

  @doc("ModernizeToAzureSqlDb - Optimization Logic")
  ModernizeToAzureSqlDb: "ModernizeToAzureSqlDb",

  string,
}

@doc("Azure Sql Instance Type")
union AzureSqlInstanceType {
  @doc("Unknown Azure Sql Instance Type")
  Unknown: "Unknown",

  @doc("Automatic Azure Sql Instance Type")
  Automatic: "Automatic",

  @doc("SingleInstance Azure Sql Instance Type")
  SingleInstance: "SingleInstance",

  @doc("InstancePools Azure Sql Instance Type")
  InstancePools: "InstancePools",

  string,
}

@doc("Azure Sql Service Tier")
union AzureSqlServiceTier {
  @doc("Unknown Azure Sql Service Tier")
  Unknown: "Unknown",

  @doc("Automatic Azure Sql Service Tier")
  Automatic: "Automatic",

  @doc("GeneralPurpose Azure Sql Service Tier")
  GeneralPurpose: "GeneralPurpose",

  @doc("BusinessCritical Azure Sql Service Tier")
  BusinessCritical: "BusinessCritical",

  @doc("HyperScale Azure Sql Service Tier")
  HyperScale: "HyperScale",

  string,
}

@doc("Azure Sql Service Tier V3")
union AzureSqlServiceTierV3 {
  @doc("SqlService_Unknown Sql Service Tier V3")
  SqlService_Unknown: "SqlService_Unknown",

  @doc("SqlService_Automatic Sql Service Tier V3")
  SqlService_Automatic: "SqlService_Automatic",

  @doc("SqlService_GeneralPurpose Sql Service Tier V3")
  SqlService_GeneralPurpose: "SqlService_GeneralPurpose",

  @doc("SqlService_BusinessCritical Sql Service Tier V3")
  SqlService_BusinessCritical: "SqlService_BusinessCritical",

  @doc("SqlService_HyperScale Sql Service Tier V3")
  SqlService_HyperScale: "SqlService_HyperScale",

  string,
}

@doc("Azure Sql Data Base Type")
union AzureSqlDataBaseType {
  @doc("Unknown Data Base Type")
  Unknown: "Unknown",

  @doc("Automatic Data Base Type")
  Automatic: "Automatic",

  @doc("SingleDatabase Data Base Type")
  SingleDatabase: "SingleDatabase",

  @doc("ElasticPool Data Base Type")
  ElasticPool: "ElasticPool",

  string,
}

@doc("Azure Sql Purchase Model")
union AzureSqlPurchaseModel {
  @doc("Unknown Purchase Model")
  Unknown: "Unknown",

  @doc("VCore Purchase Model")
  VCore: "VCore",

  @doc("DTU Purchase Model")
  DTU: "DTU",

  string,
}

@doc("Multi Subnet Intent")
union MultiSubnetIntent {
  @doc("None - Multi Subnet Intent")
  None: "None",

  @doc("HighAvailability - Multi Subnet Intent")
  HighAvailability: "HighAvailability",

  @doc("DisasterRecovery - Multi Subnet Intent")
  DisasterRecovery: "DisasterRecovery",

  string,
}

@doc("Async Commit Mode Intent")
union AsyncCommitModeIntent {
  @doc("None - Async Commit Mode Intent")
  None: "None",

  @doc("HighAvailability - Async Commit Mode Intent")
  HighAvailability: "HighAvailability",

  @doc("DisasterRecovery - Async Commit Mode Intent")
  DisasterRecovery: "DisasterRecovery",

  string,
}

@doc("Sql Server License")
union SqlServerLicense {
  @doc("Unknown - Sql Server License")
  Unknown: "Unknown",

  @doc("Has Sql Server License")
  Yes: "Yes",

  @doc("No Sql Server License")
  No: "No",

  string,
}

@doc("Compute Tier")
union ComputeTier {
  @doc("Unknown - Compute Tier")
  Unknown: "Unknown",

  @doc("Automatic - Compute Tier")
  Automatic: "Automatic",

  @doc("Provisioned - Compute Tier")
  Provisioned: "Provisioned",

  @doc("Serverless - Compute Tier")
  Serverless: "Serverless",

  string,
}

@doc("Hardware Generation")
union HardwareGeneration {
  @doc("Unknown - Hardware Generation")
  Unknown: "Unknown",

  @doc("Automatic - Hardware Generation")
  Automatic: "Automatic",

  @doc("Gen5- Hardware Generation")
  Gen5: "Gen5",

  @doc("Fsv2_series")
  Fsv2Series: "Fsv2_series",

  @doc("M_series")
  MSeries: "M_series",

  @doc("DC_series")
  DCSeries: "DC_series",

  string,
}

@doc("Target Type")
union TargetType {
  @doc("Unknown - Target Type")
  Unknown: "Unknown",

  @doc("Recommended - Target Type")
  Recommended: "Recommended",

  @doc("AzureSqlDatabase - Target Type")
  AzureSqlDatabase: "AzureSqlDatabase",

  @doc("AzureSqlManagedInstance - Target Type")
  AzureSqlManagedInstance: "AzureSqlManagedInstance",

  @doc("AzureSqlVirtualMachine - Target Type")
  AzureSqlVirtualMachine: "AzureSqlVirtualMachine",

  @doc("AzureVirtualMachine - Target Type")
  AzureVirtualMachine: "AzureVirtualMachine",

  string,
}

@doc("Compatibility Level")
union CompatibilityLevel {
  @doc("Unknown - Compatibility Level")
  Unknown: "Unknown",

  @doc("CompatLevel80 - Compatibility Level")
  CompatLevel80: "CompatLevel80",

  @doc("CompatLevel90 - Compatibility Level")
  CompatLevel90: "CompatLevel90",

  @doc("CompatLevel100 - Compatibility Level")
  CompatLevel100: "CompatLevel100",

  @doc("CompatLevel110 - Compatibility Level")
  CompatLevel110: "CompatLevel110",

  @doc("CompatLevel120 - Compatibility Level")
  CompatLevel120: "CompatLevel120",

  @doc("CompatLevel130 - Compatibility Level")
  CompatLevel130: "CompatLevel130",

  @doc("CompatLevel140 - Compatibility Level")
  CompatLevel140: "CompatLevel140",

  @doc("CompatLevel150 - Compatibility Level")
  CompatLevel150: "CompatLevel150",

  string,
}

@doc("Recommended Suitability")
union RecommendedSuitability {
  @doc("Unknown - Recommended Suitability")
  Unknown: "Unknown",

  @doc("SuitableForSqlDB - Recommended Suitability")
  SuitableForSqlDB: "SuitableForSqlDB",

  @doc("SuitableForSqlMI - Recommended Suitability")
  SuitableForSqlMI: "SuitableForSqlMI",

  @doc("SuitableForVM - Recommended Suitability")
  SuitableForVM: "SuitableForVM",

  @doc("PotentiallySuitableForVM - Recommended Suitability")
  PotentiallySuitableForVM: "PotentiallySuitableForVM",

  @doc("ReadinessUnknown - Recommended Suitability")
  ReadinessUnknown: "ReadinessUnknown",

  @doc("NotSuitable - Recommended Suitability")
  NotSuitable: "NotSuitable",

  @doc("SuitableForSqlVM - Recommended Suitability")
  SuitableForSqlVM: "SuitableForSqlVM",

  @doc("ConditionallySuitableForSqlDB - Recommended Suitability")
  ConditionallySuitableForSqlDB: "ConditionallySuitableForSqlDB",

  @doc("ConditionallySuitableForSqlMI - Recommended Suitability")
  ConditionallySuitableForSqlMI: "ConditionallySuitableForSqlMI",

  @doc("ConditionallySuitableForVM - Recommended Suitability")
  ConditionallySuitableForVM: "ConditionallySuitableForVM",

  @doc("ConditionallySuitableForSqlVM - Recommended Suitability")
  ConditionallySuitableForSqlVM: "ConditionallySuitableForSqlVM",

  string,
}

@doc("Sql FCI Metadata State")
union SqlFCIMetadataState {
  @doc("Unknown - Sql FCI Metadata State")
  Unknown: "Unknown",

  @doc("Inherited - Sql FCI Metadata State")
  Inherited: "Inherited",

  @doc("Initializing - Sql FCI Metadata State")
  Initializing: "Initializing",

  @doc("Online - Sql FCI Metadata State")
  Online: "Online",

  @doc("Offline - Sql FCI Metadata State")
  Offline: "Offline",

  @doc("Failed - Sql FCI Metadata State")
  Failed: "Failed",

  @doc("Pending - Sql FCI Metadata State")
  Pending: "Pending",

  @doc("OnlinePending - Sql FCI Metadata State")
  OnlinePending: "OnlinePending",

  @doc("OfflinePending - Sql FCI Metadata State")
  OfflinePending: "OfflinePending",

  string,
}

@doc("Azure Offer Code For Vm")
union AzureOfferCodeForVm {
  @doc("MSAZRUSGOV0003P - Offer code")
  Msazrusgov0003P: "MSAZRUSGOV0003P",

  string,
}
