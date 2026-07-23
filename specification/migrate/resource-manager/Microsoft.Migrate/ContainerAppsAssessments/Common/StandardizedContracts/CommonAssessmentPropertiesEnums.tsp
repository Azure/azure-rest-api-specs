@doc("Group type")
union GroupType {
  @doc("Default Group type")
  Default: "Default",

  @doc("Import Group type")
  Import: "Import",

  string,
}

@doc("Azure Offer")
union AzureOffer {
  @doc("Unknown - Azure Offer")
  Unknown: "Unknown",

  @doc("MSAZR0003P Azure Offer")
  Msazr0003P: "MSAZR0003P",

  @doc("MSAZR0023P Azure Offer")
  Msazr0023P: "MSAZR0023P",

  @doc("MSMCAZR0044P Azure Offer")
  Msmcazr0044P: "MSMCAZR0044P",

  @doc("MSMCAZR0059P Azure Offer")
  Msmcazr0059P: "MSMCAZR0059P",

  @doc("MSMCAZR0060P Azure Offer")
  Msmcazr0060P: "MSMCAZR0060P",

  @doc("MSMCAZR0063P Azure Offer")
  Msmcazr0063P: "MSMCAZR0063P",

  @doc("MSAZRUSGOV0003P Azure Offer")
  Msazrusgov0003P: "MSAZRUSGOV0003P",

  @doc("EA Azure Offer")
  EA: "EA",

  @doc("SavingsPlan1Year Azure Offer")
  SavingsPlan1Year: "SavingsPlan1Year",

  @doc("SavingsPlan3Year Azure Offer")
  SavingsPlan3Year: "SavingsPlan3Year",

  string,
}

@doc("Licensing Program")
union LicensingProgram {
  @doc("Pay-As-You-Go Licensing Program")
  PayG: "Pay-As-You-Go",

  @doc("Enterprise Agreement Licensing Program")
  EA: "Enterprise Agreement",

  string,
}

@doc("Azure Pricing Tier")
union AzurePricingTier {
  @doc("Standard Azure Pricing Tier")
  Standard: "Standard",

  @doc("Basic Azure Pricing Tier")
  Basic: "Basic",

  string,
}

@doc("Azure Storage Redundancy")
union AzureStorageRedundancy {
  @doc("Unknown Azure Storage Redundancy")
  Unknown: "Unknown",

  @doc("LocallyRedundant Azure Storage Redundancy")
  LocallyRedundant: "LocallyRedundant",

  @doc("ZoneRedundant Azure Storage Redundancy")
  ZoneRedundant: "ZoneRedundant",

  @doc("GeoRedundant Azure Storage Redundancy")
  GeoRedundant: "GeoRedundant",

  @doc("ReadAccessGeoRedundant Azure Storage Redundancy")
  ReadAccessGeoRedundant: "ReadAccessGeoRedundant",

  string,
}

@doc("Assessment Stage")
union AssessmentStage {
  @doc("InProgress Assessment Stage")
  InProgress: "InProgress",

  @doc("UnderReview Assessment Stage")
  UnderReview: "UnderReview",

  @doc("Approved Assessment Stage")
  Approved: "Approved",

  string,
}

@doc("Azure Hybrid Use Benefit")
union AzureHybridUseBenefit {
  @doc("Unknown Azure Hybrid Use Benefit")
  Unknown: "Unknown",

  @doc("Yes Azure Hybrid Use Benefit")
  Yes: "Yes",

  @doc("No Azure Hybrid Use Benefit")
  No: "No",

  string,
}

@doc("Azure reserved Instance")
union AzureReservedInstance {
  @doc("None Azure reserved Instance")
  None: "None",

  @doc("RI1Year Azure reserved Instance")
  RI1Year: "RI1Year",

  @doc("RI3Year Azure reserved Instance")
  RI3Year: "RI3Year",

  string,
}

@doc("Azure Vm Security Suitability Detail")
union AzureVmSecuritySuitabilityDetail {
  @doc("Unknown - Azure Vm Security Suitability Detail")
  Unknown: "Unknown",

  @doc("NotApplicable - Azure Vm Security Suitability Detail")
  NotApplicable: "NotApplicable",

  @doc("GuestOperatingSystemNotSupported Azure Vm Security Suitability Detail")
  GuestOperatingSystemNotSupported: "GuestOperatingSystemNotSupported",

  @doc("BootTypeNotSupported Azure Vm Security Suitability Detail")
  BootTypeNotSupported: "BootTypeNotSupported",

  @doc("DiskSizeLarge Azure Vm Security Suitability Detail")
  DiskSizeLarge: "DiskSizeLarge",

  @doc("Azure does not support VM with OS disk size greater than 4TB.")
  AllDiskSizeExceeds4TB: "AllDiskSizeExceeds4TB",

  @doc("Azure does not support VM with OS disk size greater than 4TB. If OS disk size is less than 4TB, proceed with migration.")
  AnyDiskSizeExceeds4TB: "AnyDiskSizeExceeds4TB",

  @doc("Azure does not support VM with any disk size greater than 4TB. Please proceed only if you know the OS disk size is less than 4TB.")
  AnyDiskSizeExceeds4TBConditional: "AnyDiskSizeExceeds4TBConditional",

  @doc("The VM is not ready to be migrated to Azure because the OS is not supported.")
  OSNotSupported: "OSNotSupported",

  @doc("The VM is ready to be migrated to Azure with standard VM security type.")
  StandardReady: "StandardReady",

  @doc("The VM is ready to be migrated to Azure with Trusted launch VM security type.")
  TVMReady: "TVMReady",

  @doc("The VM is not ready to be migrated to Azure with standard VM security type because the OS is not supported.")
  StandardNotReadyOSNotSupported: "StandardNotReadyOSNotSupported",

  @doc("The VM is not ready to be migrated to Azure with Trusted launch VM security type because the OS is not supported for Trusted launch VM. Get more information [here].")
  TVMNotReadyOSNotSupported: "TVMNotReadyOSNotSupported",

  @doc("The VM is not ready to be migrated to Azure with standard VM security type. Azure does not support OS disk size greater than 2TB for VMs with BIOS boot type.")
  StandardNotReady2TBBiosBoot: "StandardNotReady2TBBiosBoot",

  @doc("The VM is not ready to be migrated to Azure with Trusted launch VM security type. Azure does not support OS disk size greater than 2TB for VMs with BIOS boot type.")
  AllDiskSizeExceeds2TB: "AllDiskSizeExceeds2TB",

  @doc("The VM readiness is unknown. Azure does not support OS disk size greater than 2TB for VMs with BIOS boot type. Please proceed with migration only if OS disk size is less than 2TB.")
  DiskSize2TBConditionalReadyBiosBoot: "DiskSize2TBConditionalReadyBiosBoot",

  @doc("The VM cannot be migrated to Trusted launch VM because the OS is not supported. Learn more [here].")
  TVMCannotMigrateOSNotSupported: "TVMCannotMigrateOSNotSupported",

  @doc("The VM cannot be migrated to Azure because the OS is not supported.")
  StandardCannotMigrateOSNotSupported: "StandardCannotMigrateOSNotSupported",

  @doc("The VM can be migrated to Azure with standard VM security type.")
  StandardCanMigrate: "StandardCanMigrate",

  @doc("The VM can be migrated to Trusted launch VM. Currently, Azure Migrate does not support migration to Trusted launch for VM with BIOS boot type. You can convert the VM post-migration to Trusted Launch VM. The steps are mentioned in this documentation.")
  TVMCanMigrateConditional: "TVMCanMigrateConditional",

  @doc("Readiness is marked as unknown because the OS name cannot be read.")
  OSNameCannotBeRead: "OSNameCannotBeRead",

  @doc("Migration to Trusted Launch VM is not supported for BIOS boot type VMs at this time.")
  TVMNotSupportedForBiosBoot: "TVMNotSupportedForBiosBoot",

  string,
}

@doc("Vm Family Category Item")
union VmFamilyCategoryItem {
  @doc("Unknown - Vm Family Category Item")
  Unknown: "Unknown",

  @doc("GeneralPurpose Vm Family Category Item")
  GeneralPurpose: "GeneralPurpose",

  @doc("ComputeOptimized Vm Family Category Item")
  ComputeOptimized: "ComputeOptimized",

  @doc("MemoryOptimized Vm Family Category Item")
  MemoryOptimized: "MemoryOptimized",

  @doc("StorageOptimized Vm Family Category Item")
  StorageOptimized: "StorageOptimized",

  @doc("GpuOptimized Vm Family Category Item")
  GpuOptimized: "GpuOptimized",

  @doc("HighPerformanceCompute Vm Family Category Item")
  HighPerformanceCompute: "HighPerformanceCompute",

  @doc("SupportsPremiumStorage Vm Family Category Item")
  SupportsPremiumStorage: "SupportsPremiumStorage",

  @doc("Confidential Vm Family Category Item")
  Confidential: "Confidential",

  @doc("SupportsUltraDiskStorage Vm Family Category Item")
  SupportsUltraDiskStorage: "SupportsUltraDiskStorage",

  string,
}

@doc("Azure Vm Security Type")
union AzureVmSecurityType {
  @doc("Unknown - Azure Vm Security Type")
  Unknown: "Unknown",

  @doc("Standard Azure Vm Security Type")
  Standard: "Standard",

  @doc("TVM Azure Vm Security Type")
  TVM: "TVM",

  @doc("CVM Azure Vm Security Type")
  CVM: "CVM",

  string,
}

@doc("VM Security Suitability")
model VmSecuritySuitability {
  @doc("Gets and sets the security type for this secure VM.")
  @visibility(Lifecycle.Read)
  vmSecurityType: AzureVmSecurityType;

  @doc("Gets the suitability for this secure VM.")
  @visibility(Lifecycle.Read)
  securitySuitability: CloudSuitabilityCommon;

  @doc("Gets the security suitability details for this VM.")
  @visibility(Lifecycle.Read)
  securitySuitabilityDetails: AzureVmSecuritySuitabilityDetail[];
}

@doc("Azure Disk Type")
union AzureDiskType {
  @doc("Unknown Azure Disk Type")
  Unknown: "Unknown",

  @doc("Standard Azure Disk Type")
  Standard: "Standard",

  @doc("StandardSSD Azure Disk Type")
  StandardSSD: "StandardSSD",

  @doc("Premium Azure Disk Type")
  Premium: "Premium",

  @doc("StandardOrPremium Azure Disk Type")
  StandardOrPremium: "StandardOrPremium",

  @doc("Ultra Azure Disk Type")
  Ultra: "Ultra",

  @doc("PremiumV2 Azure Disk Type")
  PremiumV2: "PremiumV2",

  string,
}

@doc("Azure Disk Suitability Explanation")
union AzureDiskSuitabilityExplanation {
  @doc("Unknown - Azure Disk Suitability Explanation")
  Unknown: "Unknown",

  @doc("NotApplicable - Azure Disk Suitability Explanation")
  NotApplicable: "NotApplicable",

  @doc("DiskSizeGreaterThanSupported - Azure Disk Suitability Explanation")
  DiskSizeGreaterThanSupported: "DiskSizeGreaterThanSupported",

  @doc("NoSuitableDiskSizeForIops - Azure Disk Suitability Explanation")
  NoSuitableDiskSizeForIops: "NoSuitableDiskSizeForIops",

  @doc("NoSuitableDiskSizeForThroughput - Azure Disk Suitability Explanation")
  NoSuitableDiskSizeForThroughput: "NoSuitableDiskSizeForThroughput",

  @doc("NoDiskSizeFoundInSelectedLocation - Azure Disk Suitability Explanation")
  NoDiskSizeFoundInSelectedLocation: "NoDiskSizeFoundInSelectedLocation",

  @doc("NoDiskSizeFoundForSelectedRedundancy - Azure Disk Suitability Explanation")
  NoDiskSizeFoundForSelectedRedundancy: "NoDiskSizeFoundForSelectedRedundancy",

  @doc("InternalErrorOccurredForDiskEvaluation - Azure Disk Suitability Explanation")
  InternalErrorOccurredForDiskEvaluation: "InternalErrorOccurredForDiskEvaluation",

  @doc("NoEaPriceFoundForDiskSize - Azure Disk Suitability Explanation")
  NoEaPriceFoundForDiskSize: "NoEaPriceFoundForDiskSize",

  string,
}

@doc("Azure Disk Suitability Detail")
union AzureDiskSuitabilityDetail {
  @doc("None - Azure Disk Suitability Detail")
  None: "None",

  @doc("NumberOfReadOperationsPerSecondMissing - Azure Disk Suitability Detail")
  NumberOfReadOperationsPerSecondMissing: "NumberOfReadOperationsPerSecondMissing",

  @doc("NumberOfWriteOperationsPerSecondMissing - Azure Disk Suitability Detail")
  NumberOfWriteOperationsPerSecondMissing: "NumberOfWriteOperationsPerSecondMissing",

  @doc("MegabytesPerSecondOfReadMissing - Azure Disk Suitability Detail")
  MegabytesPerSecondOfReadMissing: "MegabytesPerSecondOfReadMissing",

  @doc("MegabytesPerSecondOfWriteMissing - Azure Disk Suitability Detail")
  MegabytesPerSecondOfWriteMissing: "MegabytesPerSecondOfWriteMissing",

  @doc("DiskGigabytesConsumedMissing - Azure Disk Suitability Detail")
  DiskGigabytesConsumedMissing: "DiskGigabytesConsumedMissing",

  @doc("DiskGigabytesProvisionedMissing - Azure Disk Suitability Detail")
  DiskGigabytesProvisionedMissing: "DiskGigabytesProvisionedMissing",

  @doc("NumberOfReadOperationsPerSecondOutOfRange - Azure Disk Suitability Detail")
  NumberOfReadOperationsPerSecondOutOfRange: "NumberOfReadOperationsPerSecondOutOfRange",

  @doc("NumberOfWriteOperationsPerSecondOutOfRange - Azure Disk Suitability Detail")
  NumberOfWriteOperationsPerSecondOutOfRange: "NumberOfWriteOperationsPerSecondOutOfRange",

  @doc("MegabytesPerSecondOfReadOutOfRange - Azure Disk Suitability Detail")
  MegabytesPerSecondOfReadOutOfRange: "MegabytesPerSecondOfReadOutOfRange",

  @doc("MegabytesPerSecondOfWriteOutOfRange - Azure Disk Suitability Detail")
  MegabytesPerSecondOfWriteOutOfRange: "MegabytesPerSecondOfWriteOutOfRange",

  @doc("DiskGigabytesConsumedOutOfRange - Azure Disk Suitability Detail")
  DiskGigabytesConsumedOutOfRange: "DiskGigabytesConsumedOutOfRange",

  @doc("DiskGigabytesProvisionedOutOfRange - Azure Disk Suitability Detail")
  DiskGigabytesProvisionedOutOfRange: "DiskGigabytesProvisionedOutOfRange",

  string,
}

@doc("Azure Network Adapter Suitability Explanation")
union AzureNetworkAdapterSuitabilityExplanation {
  @doc("Unknown - Azure Network Adapter Suitability Explanation")
  Unknown: "Unknown",

  @doc("NotApplicable - Azure Network Adapter Suitability Explanation")
  NotApplicable: "NotApplicable",

  @doc("InternalErrorOccurred - Azure Network Adapter Suitability Explanation")
  InternalErrorOccurred: "InternalErrorOccurred",

  string,
}

@doc("Azure Network Adapter Suitability Detail")
union AzureNetworkAdapterSuitabilityDetail {
  @doc("None - Azure Network Adapter Suitability Detail")
  None: "None",

  @doc("MegabytesOfDataTransmittedMissing - Azure Network Adapter Suitability Detail")
  MegabytesOfDataTransmittedMissing: "MegabytesOfDataTransmittedMissing",

  @doc("MegabytesOfDataTransmittedOutOfRange - Azure Network Adapter Suitability Detail")
  MegabytesOfDataTransmittedOutOfRange: "MegabytesOfDataTransmittedOutOfRange",

  @doc("MegabytesOfDataRecievedMissing - Azure Network Adapter Suitability Detail")
  MegabytesOfDataRecievedMissing: "MegabytesOfDataRecievedMissing",

  @doc("MegabytesOfDataRecievedOutOfRange - Azure Network Adapter Suitability Detail")
  MegabytesOfDataRecievedOutOfRange: "MegabytesOfDataRecievedOutOfRange",

  string,
}

@doc("Azure Vm Suitability Explanation")
union AzureVmSuitabilityExplanation {
  @doc("Unknown - Azure Vm Suitability Explanation")
  Unknown: "Unknown",

  @doc("NotApplicable - Azure Vm Suitability Explanation")
  NotApplicable: "NotApplicable",

  @doc("GuestOperatingSystemArchitectureNotSupported - Azure Vm Suitability Explanation")
  GuestOperatingSystemArchitectureNotSupported: "GuestOperatingSystemArchitectureNotSupported",

  @doc("GuestOperatingSystemNotSupported - Azure Vm Suitability Explanation")
  GuestOperatingSystemNotSupported: "GuestOperatingSystemNotSupported",

  @doc("BootTypeNotSupported - Azure Vm Suitability Explanation")
  BootTypeNotSupported: "BootTypeNotSupported",

  @doc("MoreDisksThanSupported - Azure Vm Suitability Explanation")
  MoreDisksThanSupported: "MoreDisksThanSupported",

  @doc("NoSuitableVmSizeFound - Azure Vm Suitability Explanation")
  NoSuitableVmSizeFound: "NoSuitableVmSizeFound",

  @doc("OneOrMoreDisksNotSuitable - Azure Vm Suitability Explanation")
  OneOrMoreDisksNotSuitable: "OneOrMoreDisksNotSuitable",

  @doc("OneOrMoreAdaptersNotSuitable - Azure Vm Suitability Explanation")
  OneOrMoreAdaptersNotSuitable: "OneOrMoreAdaptersNotSuitable",

  @doc("InternalErrorOccurredDuringComputeEvaluation - Azure Vm Suitability Explanation")
  InternalErrorOccurredDuringComputeEvaluation: "InternalErrorOccurredDuringComputeEvaluation",

  @doc("InternalErrorOccurredDuringStorageEvaluation - Azure Vm Suitability Explanation")
  InternalErrorOccurredDuringStorageEvaluation: "InternalErrorOccurredDuringStorageEvaluation",

  @doc("InternalErrorOccurredDuringNetworkEvaluation - Azure Vm Suitability Explanation")
  InternalErrorOccurredDuringNetworkEvaluation: "InternalErrorOccurredDuringNetworkEvaluation",

  @doc("NoVmSizeSupportsStoragePerformance - Azure Vm Suitability Explanation")
  NoVmSizeSupportsStoragePerformance: "NoVmSizeSupportsStoragePerformance",

  @doc("NoVmSizeSupportsNetworkPerformance - Azure Vm Suitability Explanation")
  NoVmSizeSupportsNetworkPerformance: "NoVmSizeSupportsNetworkPerformance",

  @doc("NoVmSizeForSelectedPricingTier - Azure Vm Suitability Explanation")
  NoVmSizeForSelectedPricingTier: "NoVmSizeForSelectedPricingTier",

  @doc("NoVmSizeForSelectedAzureLocation - Azure Vm Suitability Explanation")
  NoVmSizeForSelectedAzureLocation: "NoVmSizeForSelectedAzureLocation",

  @doc("CheckRedHatLinuxVersion - Azure Vm Suitability Explanation")
  CheckRedHatLinuxVersion: "CheckRedHatLinuxVersion",

  @doc("CheckOpenSuseLinuxVersion - Azure Vm Suitability Explanation")
  CheckOpenSuseLinuxVersion: "CheckOpenSuseLinuxVersion",

  @doc("CheckWindowsServer2008R2Version - Azure Vm Suitability Explanation")
  CheckWindowsServer2008R2Version: "CheckWindowsServer2008R2Version",

  @doc("CheckCentOsVersion - Azure Vm Suitability Explanation")
  CheckCentOsVersion: "CheckCentOsVersion",

  @doc("CheckDebianLinuxVersion - Azure Vm Suitability Explanation")
  CheckDebianLinuxVersion: "CheckDebianLinuxVersion",

  @doc("CheckSuseLinuxVersion - Azure Vm Suitability Explanation")
  CheckSuseLinuxVersion: "CheckSuseLinuxVersion",

  @doc("CheckOracleLinuxVersion - Azure Vm Suitability Explanation")
  CheckOracleLinuxVersion: "CheckOracleLinuxVersion",

  @doc("CheckUbuntuLinuxVersion - Azure Vm Suitability Explanation")
  CheckUbuntuLinuxVersion: "CheckUbuntuLinuxVersion",

  @doc("CheckCoreOsLinuxVersion - Azure Vm Suitability Explanation")
  CheckCoreOsLinuxVersion: "CheckCoreOsLinuxVersion",

  @doc("WindowsServerVersionConditionallySupported - Azure Vm Suitability Explanation")
  WindowsServerVersionConditionallySupported: "WindowsServerVersionConditionallySupported",

  @doc("NoGuestOperatingSystemConditionallySupported - Azure Vm Suitability Explanation")
  NoGuestOperatingSystemConditionallySupported: "NoGuestOperatingSystemConditionallySupported",

  @doc("WindowsClientVersionsConditionallySupported - Azure Vm Suitability Explanation")
  WindowsClientVersionsConditionallySupported: "WindowsClientVersionsConditionallySupported",

  @doc("BootTypeUnknown - Azure Vm Suitability Explanation")
  BootTypeUnknown: "BootTypeUnknown",

  @doc("GuestOperatingSystemUnknown - Azure Vm Suitability Explanation")
  GuestOperatingSystemUnknown: "GuestOperatingSystemUnknown",

  @doc("WindowsServerVersionsSupportedWithCaveat - Azure Vm Suitability Explanation")
  WindowsServerVersionsSupportedWithCaveat: "WindowsServerVersionsSupportedWithCaveat",

  @doc("WindowsOSNoLongerUnderMSSupport - Azure Vm Suitability Explanation")
  WindowsOSNoLongerUnderMSSupport: "WindowsOSNoLongerUnderMSSupport",

  @doc("EndorsedWithConditionsLinuxDistributions - Azure Vm Suitability Explanation")
  EndorsedWithConditionsLinuxDistributions: "EndorsedWithConditionsLinuxDistributions",

  @doc("UnendorsedLinuxDistributions - Azure Vm Suitability Explanation")
  UnendorsedLinuxDistributions: "UnendorsedLinuxDistributions",

  @doc("NoVmSizeForStandardPricingTier - Azure Vm Suitability Explanation")
  NoVmSizeForStandardPricingTier: "NoVmSizeForStandardPricingTier",

  @doc("NoVmSizeForBasicPricingTier - Azure Vm Suitability Explanation")
  NoVmSizeForBasicPricingTier: "NoVmSizeForBasicPricingTier",

  @doc("NoVmSizeInSelectedFamilyFound - Azure Vm Suitability Explanation")
  NoVmSizeInSelectedFamilyFound: "NoVmSizeInSelectedFamilyFound",

  @doc("NoEaPriceFoundForVmSize - Azure Vm Suitability Explanation")
  NoEaPriceFoundForVmSize: "NoEaPriceFoundForVmSize",

  @doc("NoVmSizeFoundForOfferCurrencyReservedInstance - Azure Vm Suitability Explanation")
  NoVmSizeFoundForOfferCurrencyReservedInstance: "NoVmSizeFoundForOfferCurrencyReservedInstance",

  @doc("DiskSizeGreaterThanSupported - Azure Vm Suitability Explanation")
  DiskSizeGreaterThanSupported: "DiskSizeGreaterThanSupported",

  @doc("NoSuitableDiskSizeForIops - Azure Vm Suitability Explanation")
  NoSuitableDiskSizeForIops: "NoSuitableDiskSizeForIops",

  @doc("NoSuitableDiskSizeForThroughput - Azure Vm Suitability Explanation")
  NoSuitableDiskSizeForThroughput: "NoSuitableDiskSizeForThroughput",

  @doc("NoDiskSizeFoundInSelectedLocation - Azure Vm Suitability Explanation")
  NoDiskSizeFoundInSelectedLocation: "NoDiskSizeFoundInSelectedLocation",

  @doc("NoDiskSizeFoundForSelectedRedundancy - Azure Vm Suitability Explanation")
  NoDiskSizeFoundForSelectedRedundancy: "NoDiskSizeFoundForSelectedRedundancy",

  @doc("InternalErrorOccurredForDiskEvaluation - Azure Vm Suitability Explanation")
  InternalErrorOccurredForDiskEvaluation: "InternalErrorOccurredForDiskEvaluation",

  @doc("NoEaPriceFoundForDiskSize - Azure Vm Suitability Explanation")
  NoEaPriceFoundForDiskSize: "NoEaPriceFoundForDiskSize",

  @doc("InternalErrorOccurred - Azure Vm Suitability Explanation")
  InternalErrorOccurred: "InternalErrorOccurred",

  string,
}

@doc("Azure Vm Suitability Detail")
union AzureVmSuitabilityDetail {
  @doc("None - Azure Vm Suitability Detail")
  None: "None",

  @doc("RecommendedSizeHasLessNetworkAdapters - Azure Vm Suitability Detail")
  RecommendedSizeHasLessNetworkAdapters: "RecommendedSizeHasLessNetworkAdapters",

  @doc("CannotReportComputeCost - Azure Vm Suitability Detail")
  CannotReportComputeCost: "CannotReportComputeCost",

  @doc("CannotReportStorageCost - Azure Vm Suitability Detail")
  CannotReportStorageCost: "CannotReportStorageCost",

  @doc("CannotReportBandwidthCosts - Azure Vm Suitability Detail")
  CannotReportBandwidthCosts: "CannotReportBandwidthCosts",

  @doc("PercentageOfCoresUtilizedMissing - Azure Vm Suitability Detail")
  PercentageOfCoresUtilizedMissing: "PercentageOfCoresUtilizedMissing",

  @doc("PercentageOfMemoryUtilizedMissing - Azure Vm Suitability Detail")
  PercentageOfMemoryUtilizedMissing: "PercentageOfMemoryUtilizedMissing",

  @doc("PercentageOfCoresUtilizedOutOfRange - Azure Vm Suitability Detail")
  PercentageOfCoresUtilizedOutOfRange: "PercentageOfCoresUtilizedOutOfRange",

  @doc("PercentageOfMemoryUtilizedOutOfRange - Azure Vm Suitability Detail")
  PercentageOfMemoryUtilizedOutOfRange: "PercentageOfMemoryUtilizedOutOfRange",

  string,
}

@doc("Assessed machine type")
union AssessedMachineType {
  @doc("Unknown - Assessed machine type")
  Unknown: "Unknown",

  @doc("AssessedMachine - Assessed machine type")
  AssessedMachine: "AssessedMachine",

  @doc("AvsAssessedMachine - Assessed machine type")
  AvsAssessedMachine: "AvsAssessedMachine",

  @doc("SqlAssessedMachine - Assessed machine type")
  SqlAssessedMachine: "SqlAssessedMachine",

  string,
}

@doc("Guest operating system architecture")
union GuestOperatingSystemArchitecture {
  @doc("Unknown - Guest operating system architecture")
  Unknown: "Unknown",

  @doc("X86 - Guest operating system architecture")
  X86: "X86",

  @doc("X64 - Guest operating system architecture")
  X64: "X64",

  string,
}

@doc("Azure Security Offering Type")
union AzureSecurityOfferingType {
  @doc("NO - Azure Security Offering Type")
  NO: "NO",

  @doc("MDC - Azure Security Offering Type")
  MDC: "MDC",

  string,
}

@doc("Scope type")
union ScopeType {
  @doc("ServerGroupId - Scope type")
  ServerGroupId: "ServerGroupId",

  @doc("AzureResourceGraphQuery - Scope type")
  AzureResourceGraphQuery: "AzureResourceGraphQuery",

  string,
}

@doc("Summary Type")
union SummaryType {
  @doc("Unknown - Summary Type")
  Unknown: "Unknown",

  @doc("Strategy - Summary Type")
  Strategy: "Strategy",

  @doc("Target - Summary Type")
  Target: "Target",

  string,
}

@doc("Assessment Source")
union AssessmentSource {
  @doc("Unknown - Assessment Source")
  Unknown: "Unknown",

  @doc("Machine - Assessment Source")
  Machine: "Machine",

  @doc("IIS - Assessment Source")
  IIS: "IIS",

  @doc("TomCat - Assessment Source")
  TomCat: "TomCat",

  @doc("OracleServer - Assessment Source")
  OracleServer: "OracleServer",

  @doc("OracleDatabase - Assessment Source")
  OracleDatabase: "OracleDatabase",

  @doc("SAPInstance - Assessment Source")
  SAPInstance: "SAPInstance",

  @doc("SpringbootApplication - Assessment Source")
  SpringbootApplication: "SpringbootApplication",

  @doc("MySQLServer - Assessment Source")
  MySQLServer: "MySQLServer",

  @doc("SqlInstance - Assessment Source")
  SqlInstance: "SqlInstance",

  @doc("SqlDatabase - Assessment Source")
  SqlDatabase: "SqlDatabase",

  @doc("WebApps - Assessment Source")
  WebApps: "WebApps",

  string,
}

@doc("Migration Workload type")
union MigrateWorkloadType {
  @doc("Unknown - Migration Workload type")
  Unknown: "Unknown",

  @doc("Machine - Migration Workload type")
  Machine: "Machine",

  @doc("Server - Migration Workload type")
  Server: "Server",

  @doc("Instance - Migration Workload type")
  Instance: "Instance",

  @doc("WebServer - Migration Workload type")
  WebServer: "WebServer",

  @doc("WebApplication - Migration Workload type")
  WebApplication: "WebApplication",

  @doc("Database - Migration Workload type")
  Database: "Database",

  @doc("Host - Migration Workload type")
  Host: "Host",

  @doc("ManagementServer - Migration Workload type")
  ManagementServer: "ManagementServer",

  string,
}

@doc("Migration Platform")
union MigrationPlatform {
  @doc("Unknown - Migration Platform")
  Unknown: "Unknown",

  @doc("PaaS - Migration Platform")
  PaaS: "PaaS",

  @doc("IaaS - Migration Platform")
  IaaS: "IaaS",

  @doc("SaaS - Migration Platform")
  SaaS: "SaaS",

  string,
}

@doc("Azure Target")
union AzureTarget {
  @doc("Unknown - Azure Target")
  Unknown: "Unknown",

  @doc("SqlDatabase - Azure Target")
  SqlDatabase: "SqlDatabase",

  @doc("SqlMI - Azure Target")
  SqlMI: "SqlMI",

  @doc("FlexServerPG - Azure Target")
  FlexServerPG: "FlexServerPG",

  @doc("OracleIaasVM - Azure Target")
  OracleIaasVM: "OracleIaasVM",

  @doc("AzureSpringApps - Azure Target")
  AzureSpringApps: "AzureSpringApps",

  @doc("SAPAzureInstance - Azure Target")
  SAPAzureInstance: "SAPAzureInstance",

  @doc("AKS - Azure Target")
  AKS: "AKS",

  @doc("MySQLAzureFlexServer - Azure Target")
  MySQLAzureFlexServer: "MySQLAzureFlexServer",

  @doc("AzureSQLVM - Azure Target")
  AzureSQLVM: "AzureSQLVM",

  @doc("AzureVM - Azure Target")
  AzureVM: "AzureVM",

  @doc("AzureAppService - Azure Target")
  AzureAppService: "AzureAppService",

  @doc("AzureAppServiceContainer - Azure Target")
  AzureAppServiceContainer: "AzureAppServiceContainer",

  @doc("Avs - Azure Target")
  Avs: "Avs",

  @doc("ContainerApps - Azure Target")
  ContainerApps: "ContainerApps",

  string,
}

@doc("Web App Target type")
union WebAppTargetType {
  @doc("Unknown - Web App Target type")
  Unknown: "Unknown",

  @doc("AzureAppService - Web App Target type")
  AzureAppService: "AzureAppService",

  @doc("AzureAppServiceContainer - Web App Target type")
  AzureAppServiceContainer: "AzureAppServiceContainer",

  string,
}

@doc("Cloud Suitability Common")
union CloudSuitabilityCommon {
  @doc("Unknown - Cloud Suitability Common")
  Unknown: "Unknown",

  @doc("NotSuitable - Cloud Suitability Common")
  NotSuitable: "NotSuitable",

  @doc("Suitable - Cloud Suitability Common")
  Suitable: "Suitable",

  @doc("ConditionallySuitable - Cloud Suitability Common")
  ConditionallySuitable: "ConditionallySuitable",

  @doc("ReadinessUnknown - Cloud Suitability Common")
  ReadinessUnknown: "ReadinessUnknown",

  @doc("SuitableWithWarnings - Cloud Suitability Common")
  SuitableWithWarnings: "SuitableWithWarnings",

  string,
}

@doc("Cost type")
union CostType {
  @doc("MonthlyStorageCost - Cost type")
  MonthlyStorageCost: "MonthlyStorageCost",

  @doc("MonthlyComputeCost - Cost type")
  MonthlyComputeCost: "MonthlyComputeCost",

  @doc("MonthlyLicensingCost - Cost type")
  MonthlyLicensingCost: "MonthlyLicensingCost",

  @doc("MonthlySecurityCost - Cost type")
  MonthlySecurityCost: "MonthlySecurityCost",

  @doc("MonthlyManagementCost - Cost type")
  MonthlyManagementCost: "MonthlyManagementCost",

  @doc("MonitoringService - Cost type")
  MonitoringService: "MonitoringService",

  @doc("DataProtectionService - Cost type")
  DataProtectionService: "DataProtectionService",

  @doc("PatchingService - Cost type")
  PatchingService: "PatchingService",

  @doc("MonthlyAzureHybridCost - Cost type")
  MonthlyAzureHybridCost: "MonthlyAzureHybridCost",

  @doc("MonthlyPremiumV2StorageCost - Cost type")
  MonthlyPremiumV2StorageCost: "MonthlyPremiumV2StorageCost",

  @doc("MonthlyLinuxAzureHybridCost - Cost type")
  MonthlyLinuxAzureHybridCost: "MonthlyLinuxAzureHybridCost",

  @doc("MonthlyUltraStorageCost - Cost type")
  MonthlyUltraStorageCost: "MonthlyUltraStorageCost",

  @doc("MonthlyStandardSsdStorageCost - Cost type")
  MonthlyStandardSsdStorageCost: "MonthlyStandardSsdStorageCost",

  @doc("MonthlyBandwidthCost - Cost type")
  MonthlyBandwidthCost: "MonthlyBandwidthCost",

  @doc("MonthlyPremiumStorageCost - Cost type")
  MonthlyPremiumStorageCost: "MonthlyPremiumStorageCost",

  @doc("MonthlyUltraDiskCost - Cost type")
  MonthlyUltraDiskCost: "MonthlyUltraDiskCost",

  @doc("MonthlyStandardHddStorageCost - Cost type")
  MonthlyStandardHddStorageCost: "MonthlyStandardHddStorageCost",

  @doc("MonthlyAvsExternalStorageCost - Cost type")
  MonthlyAvsExternalStorageCost: "MonthlyAvsExternalStorageCost",

  @doc("MonthlyAvsNetworkCost - Cost type")
  MonthlyAvsNetworkCost: "MonthlyAvsNetworkCost",

  @doc("MonthlyAvsNodeCost - Cost type")
  MonthlyAvsNodeCost: "MonthlyAvsNodeCost",

  @doc("TotalMonthlyCost - Cost type")
  TotalMonthlyCost: "TotalMonthlyCost",

  string,
}

@doc("Migration Type")
union MigrationType {
  @doc("Unknown - Migration Type")
  Unknown: "Unknown",

  @doc("Replatform - Migration Type")
  Replatform: "Replatform",

  @doc("Rehost - Migration Type")
  Rehost: "Rehost",

  @doc("Retain - Migration Type")
  Retain: "Retain",

  @doc("Rearchitect - Migration Type")
  Rearchitect: "Rearchitect",

  string,
}

@doc("Strategy type")
union StrategyType {
  @doc("PaaSPreferred - Strategy type")
  PaaSPreferred: "PaaSPreferred",

  @doc("CostOptimized - Strategy type")
  CostOptimized: "CostOptimized",

  @doc("EffortOptimized - Strategy type")
  EffortOptimized: "EffortOptimized",

  string,
}

@doc("Linkage type")
union LinkageType {
  @doc("Parent - Linkage type")
  Parent: "Parent",

  @doc("Source - Linkage type")
  Source: "Source",

  string,
}

@doc("Linkage kind")
union LinkageKind {
  @doc("Unknown - Linkage kind")
  Unknown: "Unknown",

  @doc("Machine - Linkage kind")
  Machine: "Machine",

  @doc("Server - Linkage kind")
  Server: "Server",

  @doc("Instance - Linkage kind")
  Instance: "Instance",

  @doc("WebServer - Linkage kind")
  WebServer: "WebServer",

  @doc("WebApplication - Linkage kind")
  WebApplication: "WebApplication",

  @doc("Database - Linkage kind")
  Database: "Database",

  string,
}

@doc("Sku Kind")
union SkuKind {
  @doc("Endpoint - Sku Kind")
  Endpoint: "Endpoint",

  @doc("Details - Sku Kind")
  Details: "Details",

  string,
}

@doc("Sku type")
union SkuType {
  @doc("Unknown - Sku type")
  Unknown: "Unknown",

  @doc("Compute - Sku type")
  Compute: "Compute",

  @doc("Storage - Sku type")
  Storage: "Storage",

  @doc("Network - Sku type")
  Network: "Network",

  @doc("AppServicePlan - Sku type")
  AppServicePlan: "AppServicePlan",

  @doc("AzureSpringApps - Sku type")
  AzureSpringApps: "AzureSpringApps",

  string,
}

@doc("Assessed Sql Machine Sku Capability Type")
union AssessedSqlMachineSkuCapabilityType {
  @doc("RecommendedVmSize - Assessed Sql Machine Sku Capability Type")
  RecommendedVmSize: "RecommendedVmSize",

  @doc("RecommendedVmFamily - Assessed Sql Machine Sku Capability Type")
  RecommendedVmFamily: "RecommendedVmFamily",

  @doc("RecommendedVmSizeNumberOfCores - Assessed Sql Machine Sku Capability Type")
  RecommendedVmSizeNumberOfCores: "RecommendedVmSizeNumberOfCores",

  @doc("RecommendedVmSizeMegabytesOfMemory - Assessed Sql Machine Sku Capability Type")
  RecommendedVmSizeMegabytesOfMemory: "RecommendedVmSizeMegabytesOfMemory",

  @doc("RecommendedDiskSize - Assessed Sql Machine Sku Capability Type")
  RecommendedDiskSize: "RecommendedDiskSize",

  @doc("RecommendedDiskType - Assessed Sql Machine Sku Capability Type")
  RecommendedDiskType: "RecommendedDiskType",

  @doc("RecommendedDiskSizeGigabytes - Assessed Sql Machine Sku Capability Type")
  RecommendedDiskSizeGigabytes: "RecommendedDiskSizeGigabytes",

  @doc("RecommendDiskThroughputInMbps - Assessed Sql Machine Sku Capability Type")
  RecommendDiskThroughputInMbps: "RecommendDiskThroughputInMbps",

  @doc("RecommendedDiskIops - Assessed Sql Machine Sku Capability Type")
  RecommendedDiskIops: "RecommendedDiskIops",

  @doc("RecommendedSize - Assessed Sql Machine Sku Capability Type")
  RecommendedSize: "RecommendedSize",

  @doc("NumberOfCoresForRecommendedSize - Assessed Sql Machine Sku Capability Type")
  NumberOfCoresForRecommendedSize: "NumberOfCoresForRecommendedSize",

  @doc("MegabytesOfMemoryForRecommendedSize - Assessed Sql Machine Sku Capability Type")
  MegabytesOfMemoryForRecommendedSize: "MegabytesOfMemoryForRecommendedSize",

  @doc("MonthlyComputeCostForRecommendedSize - Assessed Sql Machine Sku Capability Type")
  MonthlyComputeCostForRecommendedSize: "MonthlyComputeCostForRecommendedSize",

  string,
}

@doc("Azure Suitability Detail")
union AzureSuitabilityDetail {
  @doc("None - Azure Suitability Detail")
  None: "None",

  @doc("RecommendedSizeHasLessNetworkAdapters - Azure Suitability Detail")
  RecommendedSizeHasLessNetworkAdapters: "RecommendedSizeHasLessNetworkAdapters",

  @doc("CannotReportComputeCost - Azure Suitability Detail")
  CannotReportComputeCost: "CannotReportComputeCost",

  @doc("CannotReportStorageCost - Azure Suitability Detail")
  CannotReportStorageCost: "CannotReportStorageCost",

  @doc("CannotReportBandwidthCosts - Azure Suitability Detail")
  CannotReportBandwidthCosts: "CannotReportBandwidthCosts",

  @doc("PercentageOfCoresUtilizedMissing - Azure Suitability Detail")
  PercentageOfCoresUtilizedMissing: "PercentageOfCoresUtilizedMissing",

  @doc("PercentageOfMemoryUtilizedMissing - Azure Suitability Detail")
  PercentageOfMemoryUtilizedMissing: "PercentageOfMemoryUtilizedMissing",

  @doc("PercentageOfCoresUtilizedOutOfRange - Azure Suitability Detail")
  PercentageOfCoresUtilizedOutOfRange: "PercentageOfCoresUtilizedOutOfRange",

  @doc("PercentageOfMemoryUtilizedOutOfRange - Azure Suitability Detail")
  PercentageOfMemoryUtilizedOutOfRange: "PercentageOfMemoryUtilizedOutOfRange",

  @doc("MegabytesOfDataTransmittedMissing - Azure Suitability Detail")
  MegabytesOfDataTransmittedMissing: "MegabytesOfDataTransmittedMissing",

  @doc("MegabytesOfDataTransmittedOutOfRange - Azure Suitability Detail")
  MegabytesOfDataTransmittedOutOfRange: "MegabytesOfDataTransmittedOutOfRange",

  @doc("MegabytesOfDataRecievedMissing - Azure Suitability Detail")
  MegabytesOfDataRecievedMissing: "MegabytesOfDataRecievedMissing",

  @doc("MegabytesOfDataRecievedOutOfRange - Azure Suitability Detail")
  MegabytesOfDataRecievedOutOfRange: "MegabytesOfDataRecievedOutOfRange",

  @doc("NumberOfReadOperationsPerSecondMissing - Azure Suitability Detail")
  NumberOfReadOperationsPerSecondMissing: "NumberOfReadOperationsPerSecondMissing",

  @doc("NumberOfWriteOperationsPerSecondMissing - Azure Suitability Detail")
  NumberOfWriteOperationsPerSecondMissing: "NumberOfWriteOperationsPerSecondMissing",

  @doc("MegabytesPerSecondOfReadMissing - Azure Suitability Detail")
  MegabytesPerSecondOfReadMissing: "MegabytesPerSecondOfReadMissing",

  @doc("MegabytesPerSecondOfWriteMissing - Azure Suitability Detail")
  MegabytesPerSecondOfWriteMissing: "MegabytesPerSecondOfWriteMissing",

  @doc("DiskGigabytesConsumedMissing - Azure Suitability Detail")
  DiskGigabytesConsumedMissing: "DiskGigabytesConsumedMissing",

  @doc("DiskGigabytesProvisionedMissing - Azure Suitability Detail")
  DiskGigabytesProvisionedMissing: "DiskGigabytesProvisionedMissing",

  @doc("NumberOfReadOperationsPerSecondOutOfRange - Azure Suitability Detail")
  NumberOfReadOperationsPerSecondOutOfRange: "NumberOfReadOperationsPerSecondOutOfRange",

  @doc("NumberOfWriteOperationsPerSecondOutOfRange - Azure Suitability Detail")
  NumberOfWriteOperationsPerSecondOutOfRange: "NumberOfWriteOperationsPerSecondOutOfRange",

  @doc("MegabytesPerSecondOfReadOutOfRange - Azure Suitability Detail")
  MegabytesPerSecondOfReadOutOfRange: "MegabytesPerSecondOfReadOutOfRange",

  @doc("MegabytesPerSecondOfWriteOutOfRange - Azure Suitability Detail")
  MegabytesPerSecondOfWriteOutOfRange: "MegabytesPerSecondOfWriteOutOfRange",

  @doc("DiskGigabytesConsumedOutOfRange - Azure Suitability Detail")
  DiskGigabytesConsumedOutOfRange: "DiskGigabytesConsumedOutOfRange",

  @doc("DiskGigabytesProvisionedOutOfRange - Azure Suitability Detail")
  DiskGigabytesProvisionedOutOfRange: "DiskGigabytesProvisionedOutOfRange",

  string,
}

@doc("Azure Suitability Explanation")
union AzureSuitabilityExplanation {
  @doc("Unknown - Azure Suitability Explanation")
  Unknown: "Unknown",

  @doc("NotApplicable - Azure Suitability Explanation")
  NotApplicable: "NotApplicable",

  @doc("GuestOperatingSystemArchitectureNotSupported - Azure Suitability Explanation")
  GuestOperatingSystemArchitectureNotSupported: "GuestOperatingSystemArchitectureNotSupported",

  @doc("GuestOperatingSystemNotSupported - Azure Suitability Explanation")
  GuestOperatingSystemNotSupported: "GuestOperatingSystemNotSupported",

  @doc("BootTypeNotSupported - Azure Suitability Explanation")
  BootTypeNotSupported: "BootTypeNotSupported",

  @doc("MoreDisksThanSupported - Azure Suitability Explanation")
  MoreDisksThanSupported: "MoreDisksThanSupported",

  @doc("NoSuitableVmSizeFound - Azure Suitability Explanation")
  NoSuitableVmSizeFound: "NoSuitableVmSizeFound",

  @doc("OneOrMoreDisksNotSuitable - Azure Suitability Explanation")
  OneOrMoreDisksNotSuitable: "OneOrMoreDisksNotSuitable",

  @doc("OneOrMoreAdaptersNotSuitable - Azure Suitability Explanation")
  OneOrMoreAdaptersNotSuitable: "OneOrMoreAdaptersNotSuitable",

  @doc("InternalErrorOccurredDuringComputeEvaluation - Azure Suitability Explanation")
  InternalErrorOccurredDuringComputeEvaluation: "InternalErrorOccurredDuringComputeEvaluation",

  @doc("InternalErrorOccurredDuringStorageEvaluation - Azure Suitability Explanation")
  InternalErrorOccurredDuringStorageEvaluation: "InternalErrorOccurredDuringStorageEvaluation",

  @doc("InternalErrorOccurredDuringNetworkEvaluation - Azure Suitability Explanation")
  InternalErrorOccurredDuringNetworkEvaluation: "InternalErrorOccurredDuringNetworkEvaluation",

  @doc("NoVmSizeSupportsStoragePerformance - Azure Suitability Explanation")
  NoVmSizeSupportsStoragePerformance: "NoVmSizeSupportsStoragePerformance",

  @doc("NoVmSizeSupportsNetworkPerformance - Azure Suitability Explanation")
  NoVmSizeSupportsNetworkPerformance: "NoVmSizeSupportsNetworkPerformance",

  @doc("NoVmSizeForSelectedPricingTier - Azure Suitability Explanation")
  NoVmSizeForSelectedPricingTier: "NoVmSizeForSelectedPricingTier",

  @doc("NoVmSizeForSelectedAzureLocation - Azure Suitability Explanation")
  NoVmSizeForSelectedAzureLocation: "NoVmSizeForSelectedAzureLocation",

  @doc("CheckRedHatLinuxVersion - Azure Suitability Explanation")
  CheckRedHatLinuxVersion: "CheckRedHatLinuxVersion",

  @doc("CheckOpenSuseLinuxVersion - Azure Suitability Explanation")
  CheckOpenSuseLinuxVersion: "CheckOpenSuseLinuxVersion",

  @doc("CheckWindowsServer2008R2Version - Azure Suitability Explanation")
  CheckWindowsServer2008R2Version: "CheckWindowsServer2008R2Version",

  @doc("CheckCentOsVersion - Azure Suitability Explanation")
  CheckCentOsVersion: "CheckCentOsVersion",

  @doc("CheckDebianLinuxVersion - Azure Suitability Explanation")
  CheckDebianLinuxVersion: "CheckDebianLinuxVersion",

  @doc("CheckSuseLinuxVersion - Azure Suitability Explanation")
  CheckSuseLinuxVersion: "CheckSuseLinuxVersion",

  @doc("CheckOracleLinuxVersion - Azure Suitability Explanation")
  CheckOracleLinuxVersion: "CheckOracleLinuxVersion",

  @doc("CheckUbuntuLinuxVersion - Azure Suitability Explanation")
  CheckUbuntuLinuxVersion: "CheckUbuntuLinuxVersion",

  @doc("CheckCoreOsLinuxVersion - Azure Suitability Explanation")
  CheckCoreOsLinuxVersion: "CheckCoreOsLinuxVersion",

  @doc("WindowsServerVersionConditionallySupported - Azure Suitability Explanation")
  WindowsServerVersionConditionallySupported: "WindowsServerVersionConditionallySupported",

  @doc("NoGuestOperatingSystemConditionallySupported - Azure Suitability Explanation")
  NoGuestOperatingSystemConditionallySupported: "NoGuestOperatingSystemConditionallySupported",

  @doc("WindowsClientVersionsConditionallySupported - Azure Suitability Explanation")
  WindowsClientVersionsConditionallySupported: "WindowsClientVersionsConditionallySupported",

  @doc("BootTypeUnknown - Azure Suitability Explanation")
  BootTypeUnknown: "BootTypeUnknown",

  @doc("GuestOperatingSystemUnknown - Azure Suitability Explanation")
  GuestOperatingSystemUnknown: "GuestOperatingSystemUnknown",

  @doc("WindowsServerVersionsSupportedWithCaveat - Azure Suitability Explanation")
  WindowsServerVersionsSupportedWithCaveat: "WindowsServerVersionsSupportedWithCaveat",

  @doc("WindowsOSNoLongerUnderMSSupport - Azure Suitability Explanation")
  WindowsOSNoLongerUnderMSSupport: "WindowsOSNoLongerUnderMSSupport",

  @doc("EndorsedWithConditionsLinuxDistributions - Azure Suitability Explanation")
  EndorsedWithConditionsLinuxDistributions: "EndorsedWithConditionsLinuxDistributions",

  @doc("UnendorsedLinuxDistributions - Azure Suitability Explanation")
  UnendorsedLinuxDistributions: "UnendorsedLinuxDistributions",

  @doc("NoVmSizeForStandardPricingTier - Azure Suitability Explanation")
  NoVmSizeForStandardPricingTier: "NoVmSizeForStandardPricingTier",

  @doc("NoVmSizeForBasicPricingTier - Azure Suitability Explanation")
  NoVmSizeForBasicPricingTier: "NoVmSizeForBasicPricingTier",

  @doc("NoVmSizeInSelectedFamilyFound - Azure Suitability Explanation")
  NoVmSizeInSelectedFamilyFound: "NoVmSizeInSelectedFamilyFound",

  @doc("NoEaPriceFoundForVmSize - Azure Suitability Explanation")
  NoEaPriceFoundForVmSize: "NoEaPriceFoundForVmSize",

  @doc("NoVmSizeFoundForOfferCurrencyReservedInstance - Azure Suitability Explanation")
  NoVmSizeFoundForOfferCurrencyReservedInstance: "NoVmSizeFoundForOfferCurrencyReservedInstance",

  @doc("DiskSizeGreaterThanSupported - Azure Suitability Explanation")
  DiskSizeGreaterThanSupported: "DiskSizeGreaterThanSupported",

  @doc("NoSuitableDiskSizeForIops - Azure Suitability Explanation")
  NoSuitableDiskSizeForIops: "NoSuitableDiskSizeForIops",

  @doc("NoSuitableDiskSizeForThroughput - Azure Suitability Explanation")
  NoSuitableDiskSizeForThroughput: "NoSuitableDiskSizeForThroughput",

  @doc("NoDiskSizeFoundInSelectedLocation - Azure Suitability Explanation")
  NoDiskSizeFoundInSelectedLocation: "NoDiskSizeFoundInSelectedLocation",

  @doc("NoDiskSizeFoundForSelectedRedundancy - Azure Suitability Explanation")
  NoDiskSizeFoundForSelectedRedundancy: "NoDiskSizeFoundForSelectedRedundancy",

  @doc("InternalErrorOccurredForDiskEvaluation - Azure Suitability Explanation")
  InternalErrorOccurredForDiskEvaluation: "InternalErrorOccurredForDiskEvaluation",

  @doc("NoEaPriceFoundForDiskSize - Azure Suitability Explanation")
  NoEaPriceFoundForDiskSize: "NoEaPriceFoundForDiskSize",

  @doc("InternalErrorOccurred - Azure Suitability Explanation")
  InternalErrorOccurred: "InternalErrorOccurred",

  string,
}

@doc("Azure management Offering type")
union AzureManagementOfferingType {
  @doc("No - Azure management Offering type")
  No: "No",

  @doc("SCOMMI - Azure management Offering type")
  SCOMMI: "SCOMMI",

  @doc("AzMon - Azure management Offering type")
  AzMon: "AzMon",

  @doc("AUM - Azure management Offering type")
  AUM: "AUM",

  @doc("AzureBackup - Azure management Offering type")
  AzureBackup: "AzureBackup",

  string,
}

@doc("Savings type")
union SavingsType {
  @doc("MonthlyAzureHybridCostSavings - Savings type")
  MonthlyAzureHybridCostSavings: "MonthlyAzureHybridCostSavings",

  @doc("MonthlyLinuxAzureHybridCostSavings - Savings type")
  MonthlyLinuxAzureHybridCostSavings: "MonthlyLinuxAzureHybridCostSavings",

  @doc("MonthlyAhubSqlCostSavings - Savings type")
  MonthlyAhubSqlCostSavings: "MonthlyAhubSqlCostSavings",

  @doc("MonthlyVcfByolCostDifference - Savings type")
  MonthlyVcfByolCostDifference: "MonthlyVcfByolCostDifference",

  string,
}
