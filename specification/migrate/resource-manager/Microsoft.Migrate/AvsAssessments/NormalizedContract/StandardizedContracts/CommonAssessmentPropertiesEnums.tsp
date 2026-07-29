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

@doc("Azure VM Family")
union AzureVmFamily {
  @doc("Unknown - Azure VM Family")
  Unknown: "Unknown",

  @doc("Basic_A0_A4")
  BasicA0A4: "Basic_A0_A4",

  @doc("Standard_A0_A7")
  StandardA0A7: "Standard_A0_A7",

  @doc("Standard_A8_A11")
  StandardA8A11: "Standard_A8_A11",

  @doc("Av2_series")
  Av2Series: "Av2_series",

  @doc("D_series")
  DSeries: "D_series",

  @doc("Dv2_series")
  Dv2Series: "Dv2_series",

  @doc("DS_series")
  DSSeries: "DS_series",

  @doc("DSv2_series")
  DSv2Series: "DSv2_series",

  @doc("F_series")
  FSeries: "F_series",

  @doc("Fs_series")
  FsSeries: "Fs_series",

  @doc("G_series")
  GSeries: "G_series",

  @doc("GS_series")
  GSSeries: "GS_series",

  @doc("H_series")
  HSeries: "H_series",

  @doc("Ls_series")
  LsSeries: "Ls_series",

  @doc("Dsv3_series")
  Dsv3Series: "Dsv3_series",

  @doc("Dv3_series")
  Dv3Series: "Dv3_series",

  @doc("Fsv2_series")
  Fsv2Series: "Fsv2_series",

  @doc("Ev3_series")
  Ev3Series: "Ev3_series",

  @doc("Esv3_series")
  Esv3Series: "Esv3_series",

  @doc("M_series")
  MSeries: "M_series",

  @doc("DC_Series")
  DCSeries: "DC_Series",

  @doc("Lsv2_series")
  Lsv2Series: "Lsv2_series",

  @doc("Ev4_series")
  Ev4Series: "Ev4_series",

  @doc("Esv4_series")
  Esv4Series: "Esv4_series",

  @doc("Edv4_series")
  Edv4Series: "Edv4_series",

  @doc("Edsv4_series")
  Edsv4Series: "Edsv4_series",

  @doc("Dv4_series")
  Dv4Series: "Dv4_series",

  @doc("Dsv4_series")
  Dsv4Series: "Dsv4_series",

  @doc("Ddv4_series")
  Ddv4Series: "Ddv4_series",

  @doc("Ddsv4_series")
  Ddsv4Series: "Ddsv4_series",

  @doc("Easv4_series")
  Easv4Series: "Easv4_series",

  @doc("Dasv4_series")
  Dasv4Series: "Dasv4_series",

  @doc("Mv2_series")
  Mv2Series: "Mv2_series",

  @doc("Eav4_series")
  Eav4Series: "Eav4_series",

  @doc("Dav4_series")
  Dav4Series: "Dav4_series",

  @doc("Msv2_series")
  Msv2Series: "Msv2_series",

  @doc("Mdsv2_series")
  Mdsv2Series: "Mdsv2_series",

  @doc("Dv5_series")
  Dv5Series: "Dv5_series",

  @doc("Dsv5_series")
  Dsv5Series: "Dsv5_series",

  @doc("Ddv5_series")
  Ddv5Series: "Ddv5_series",

  @doc("Ddsv5_series")
  Ddsv5Series: "Ddsv5_series",

  @doc("Dasv5_series")
  Dasv5Series: "Dasv5_series",

  @doc("Dadsv5_series")
  Dadsv5Series: "Dadsv5_series",

  @doc("Ev5_series")
  Ev5Series: "Ev5_series",

  @doc("Esv5_series")
  Esv5Series: "Esv5_series",

  @doc("Edv5_series")
  Edv5Series: "Edv5_series",

  @doc("Edsv5_series")
  Edsv5Series: "Edsv5_series",

  @doc("Easv5_series")
  Easv5Series: "Easv5_series",

  @doc("Eadsv5_series")
  Eadsv5Series: "Eadsv5_series",

  @doc("Ebsv5_series")
  Ebsv5Series: "Ebsv5_series",

  @doc("Ebdsv5_series")
  Ebdsv5Series: "Ebdsv5_series",

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

@doc("Azure Disk size")
union AzureDiskSize {
  @doc("Unknown - Azure Disk size")
  Unknown: "Unknown",

  @doc("Standard_S4")
  StandardS4: "Standard_S4",

  @doc("Standard_S6")
  StandardS6: "Standard_S6",

  @doc("Standard_S10")
  StandardS10: "Standard_S10",

  @doc("Standard_S15")
  StandardS15: "Standard_S15",

  @doc("Standard_S20")
  StandardS20: "Standard_S20",

  @doc("Standard_S30")
  StandardS30: "Standard_S30",

  @doc("Standard_S40")
  StandardS40: "Standard_S40",

  @doc("Standard_S50")
  StandardS50: "Standard_S50",

  @doc("Standard_S60")
  StandardS60: "Standard_S60",

  @doc("Standard_S70")
  StandardS70: "Standard_S70",

  @doc("Standard_S80")
  StandardS80: "Standard_S80",

  @doc("Premium_P4")
  PremiumP4: "Premium_P4",

  @doc("Premium_P6")
  PremiumP6: "Premium_P6",

  @doc("Premium_P10")
  PremiumP10: "Premium_P10",

  @doc("Premium_P15")
  PremiumP15: "Premium_P15",

  @doc("Premium_P20")
  PremiumP20: "Premium_P20",

  @doc("Premium_P30")
  PremiumP30: "Premium_P30",

  @doc("Premium_P40")
  PremiumP40: "Premium_P40",

  @doc("Premium_P50")
  PremiumP50: "Premium_P50",

  @doc("Premium_P60")
  PremiumP60: "Premium_P60",

  @doc("Premium_P70")
  PremiumP70: "Premium_P70",

  @doc("Premium_P80")
  PremiumP80: "Premium_P80",

  @doc("StandardSSD_E10")
  StandardSSDE10: "StandardSSD_E10",

  @doc("StandardSSD_E15")
  StandardSSDE15: "StandardSSD_E15",

  @doc("StandardSSD_E20")
  StandardSSDE20: "StandardSSD_E20",

  @doc("StandardSSD_E30")
  StandardSSDE30: "StandardSSD_E30",

  @doc("StandardSSD_E40")
  StandardSSDE40: "StandardSSD_E40",

  @doc("StandardSSD_E50")
  StandardSSDE50: "StandardSSD_E50",

  @doc("StandardSSD_E60")
  StandardSSDE60: "StandardSSD_E60",

  @doc("StandardSSD_E70")
  StandardSSDE70: "StandardSSD_E70",

  @doc("StandardSSD_E80")
  StandardSSDE80: "StandardSSD_E80",

  @doc("StandardSSD_E4")
  StandardSSDE4: "StandardSSD_E4",

  @doc("StandardSSD_E6")
  StandardSSDE6: "StandardSSD_E6",

  @doc("StandardSSD_E1")
  StandardSSDE1: "StandardSSD_E1",

  @doc("StandardSSD_E2")
  StandardSSDE2: "StandardSSD_E2",

  @doc("StandardSSD_E3")
  StandardSSDE3: "StandardSSD_E3",

  @doc("Premium_P1")
  PremiumP1: "Premium_P1",

  @doc("Premium_P2")
  PremiumP2: "Premium_P2",

  @doc("Premium_P3")
  PremiumP3: "Premium_P3",

  @doc("Ultra - Azure Disk size")
  Ultra: "Ultra",

  @doc("PremiumV2 - Azure Disk size")
  PremiumV2: "PremiumV2",

  string,
}

@doc("Azure VM Size")
union AzureVmSize {
  @doc("Unknown - Azure VM Size")
  Unknown: "Unknown",

  @doc("Basic_A0")
  BasicA0: "Basic_A0",

  @doc("Basic_A1")
  BasicA1: "Basic_A1",

  @doc("Basic_A2")
  BasicA2: "Basic_A2",

  @doc("Basic_A3")
  BasicA3: "Basic_A3",

  @doc("Basic_A4")
  BasicA4: "Basic_A4",

  @doc("Standard_A0")
  StandardA0: "Standard_A0",

  @doc("Standard_A1")
  StandardA1: "Standard_A1",

  @doc("Standard_A2")
  StandardA2: "Standard_A2",

  @doc("Standard_A3")
  StandardA3: "Standard_A3",

  @doc("Standard_A4")
  StandardA4: "Standard_A4",

  @doc("Standard_A5")
  StandardA5: "Standard_A5",

  @doc("Standard_A6")
  StandardA6: "Standard_A6",

  @doc("Standard_A7")
  StandardA7: "Standard_A7",

  @doc("Standard_A8")
  StandardA8: "Standard_A8",

  @doc("Standard_A9")
  StandardA9: "Standard_A9",

  @doc("Standard_A10")
  StandardA10: "Standard_A10",

  @doc("Standard_A11")
  StandardA11: "Standard_A11",

  @doc("Standard_A1_v2")
  StandardA1V2: "Standard_A1_v2",

  @doc("Standard_A2_v2")
  StandardA2V2: "Standard_A2_v2",

  @doc("Standard_A4_v2")
  StandardA4V2: "Standard_A4_v2",

  @doc("Standard_A8_v2")
  StandardA8V2: "Standard_A8_v2",

  @doc("Standard_A2m_v2")
  StandardA2MV2: "Standard_A2m_v2",

  @doc("Standard_A4m_v2")
  StandardA4MV2: "Standard_A4m_v2",

  @doc("Standard_A8m_v2")
  StandardA8MV2: "Standard_A8m_v2",

  @doc("Standard_D1")
  StandardD1: "Standard_D1",

  @doc("Standard_D2")
  StandardD2: "Standard_D2",

  @doc("Standard_D3")
  StandardD3: "Standard_D3",

  @doc("Standard_D4")
  StandardD4: "Standard_D4",

  @doc("Standard_D11")
  StandardD11: "Standard_D11",

  @doc("Standard_D12")
  StandardD12: "Standard_D12",

  @doc("Standard_D13")
  StandardD13: "Standard_D13",

  @doc("Standard_D14")
  StandardD14: "Standard_D14",

  @doc("Standard_D1_v2")
  StandardD1V2: "Standard_D1_v2",

  @doc("Standard_D2_v2")
  StandardD2V2: "Standard_D2_v2",

  @doc("Standard_D3_v2")
  StandardD3V2: "Standard_D3_v2",

  @doc("Standard_D4_v2")
  StandardD4V2: "Standard_D4_v2",

  @doc("Standard_D5_v2")
  StandardD5V2: "Standard_D5_v2",

  @doc("Standard_D11_v2")
  StandardD11V2: "Standard_D11_v2",

  @doc("Standard_D12_v2")
  StandardD12V2: "Standard_D12_v2",

  @doc("Standard_D13_v2")
  StandardD13V2: "Standard_D13_v2",

  @doc("Standard_D14_v2")
  StandardD14V2: "Standard_D14_v2",

  @doc("Standard_D15_v2")
  StandardD15V2: "Standard_D15_v2",

  @doc("Standard_DS1")
  StandardDS1: "Standard_DS1",

  @doc("Standard_DS2")
  StandardDS2: "Standard_DS2",

  @doc("Standard_DS3")
  StandardDS3: "Standard_DS3",

  @doc("Standard_DS4")
  StandardDS4: "Standard_DS4",

  @doc("Standard_DS11")
  StandardDS11: "Standard_DS11",

  @doc("Standard_DS12")
  StandardDS12: "Standard_DS12",

  @doc("Standard_DS13")
  StandardDS13: "Standard_DS13",

  @doc("Standard_DS14")
  StandardDS14: "Standard_DS14",

  @doc("Standard_DS1_v2")
  StandardDS1V2: "Standard_DS1_v2",

  @doc("Standard_DS2_v2")
  StandardDS2V2: "Standard_DS2_v2",

  @doc("Standard_DS3_v2")
  StandardDS3V2: "Standard_DS3_v2",

  @doc("Standard_DS4_v2")
  StandardDS4V2: "Standard_DS4_v2",

  @doc("Standard_DS5_v2")
  StandardDS5V2: "Standard_DS5_v2",

  @doc("Standard_DS11_v2")
  StandardDS11V2: "Standard_DS11_v2",

  @doc("Standard_DS12_v2")
  StandardDS12V2: "Standard_DS12_v2",

  @doc("Standard_DS13_v2")
  StandardDS13V2: "Standard_DS13_v2",

  @doc("Standard_DS14_v2")
  StandardDS14V2: "Standard_DS14_v2",

  @doc("Standard_DS15_v2")
  StandardDS15V2: "Standard_DS15_v2",

  @doc("Standard_F1")
  StandardF1: "Standard_F1",

  @doc("Standard_F2")
  StandardF2: "Standard_F2",

  @doc("Standard_F4")
  StandardF4: "Standard_F4",

  @doc("Standard_F8")
  StandardF8: "Standard_F8",

  @doc("Standard_F16")
  StandardF16: "Standard_F16",

  @doc("Standard_F1s")
  StandardF1S: "Standard_F1s",

  @doc("Standard_F2s")
  StandardF2S: "Standard_F2s",

  @doc("Standard_F4s")
  StandardF4S: "Standard_F4s",

  @doc("Standard_F8s")
  StandardF8S: "Standard_F8s",

  @doc("Standard_F16s")
  StandardF16S: "Standard_F16s",

  @doc("Standard_G1")
  StandardG1: "Standard_G1",

  @doc("Standard_G2")
  StandardG2: "Standard_G2",

  @doc("Standard_G3")
  StandardG3: "Standard_G3",

  @doc("Standard_G4")
  StandardG4: "Standard_G4",

  @doc("Standard_G5")
  StandardG5: "Standard_G5",

  @doc("Standard_GS1")
  StandardGS1: "Standard_GS1",

  @doc("Standard_GS2")
  StandardGS2: "Standard_GS2",

  @doc("Standard_GS3")
  StandardGS3: "Standard_GS3",

  @doc("Standard_GS4")
  StandardGS4: "Standard_GS4",

  @doc("Standard_GS5")
  StandardGS5: "Standard_GS5",

  @doc("Standard_H8")
  StandardH8: "Standard_H8",

  @doc("Standard_H16")
  StandardH16: "Standard_H16",

  @doc("Standard_H8m")
  StandardH8M: "Standard_H8m",

  @doc("Standard_H16m")
  StandardH16M: "Standard_H16m",

  @doc("Standard_H16r")
  StandardH16R: "Standard_H16r",

  @doc("Standard_H16mr")
  StandardH16Mr: "Standard_H16mr",

  @doc("Standard_L4s")
  StandardL4S: "Standard_L4s",

  @doc("Standard_L8s")
  StandardL8S: "Standard_L8s",

  @doc("Standard_L16s")
  StandardL16S: "Standard_L16s",

  @doc("Standard_L32s")
  StandardL32S: "Standard_L32s",

  @doc("Standard_D2s_v3")
  StandardD2SV3: "Standard_D2s_v3",

  @doc("Standard_D4s_v3")
  StandardD4SV3: "Standard_D4s_v3",

  @doc("Standard_D8s_v3")
  StandardD8SV3: "Standard_D8s_v3",

  @doc("Standard_D16s_v3")
  StandardD16SV3: "Standard_D16s_v3",

  @doc("Standard_D32s_v3")
  StandardD32SV3: "Standard_D32s_v3",

  @doc("Standard_D64s_v3")
  StandardD64SV3: "Standard_D64s_v3",

  @doc("Standard_D2_v3")
  StandardD2V3: "Standard_D2_v3",

  @doc("Standard_D4_v3")
  StandardD4V3: "Standard_D4_v3",

  @doc("Standard_D8_v3")
  StandardD8V3: "Standard_D8_v3",

  @doc("Standard_D16_v3")
  StandardD16V3: "Standard_D16_v3",

  @doc("Standard_D32_v3")
  StandardD32V3: "Standard_D32_v3",

  @doc("Standard_D64_v3")
  StandardD64V3: "Standard_D64_v3",

  @doc("Standard_F2s_v2")
  StandardF2SV2: "Standard_F2s_v2",

  @doc("Standard_F4s_v2")
  StandardF4SV2: "Standard_F4s_v2",

  @doc("Standard_F8s_v2")
  StandardF8SV2: "Standard_F8s_v2",

  @doc("Standard_F16s_v2")
  StandardF16SV2: "Standard_F16s_v2",

  @doc("Standard_F32s_v2")
  StandardF32SV2: "Standard_F32s_v2",

  @doc("Standard_F64s_v2")
  StandardF64SV2: "Standard_F64s_v2",

  @doc("Standard_F72s_v2")
  StandardF72SV2: "Standard_F72s_v2",

  @doc("Standard_E2_v3")
  StandardE2V3: "Standard_E2_v3",

  @doc("Standard_E4_v3")
  StandardE4V3: "Standard_E4_v3",

  @doc("Standard_E8_v3")
  StandardE8V3: "Standard_E8_v3",

  @doc("Standard_E16_v3")
  StandardE16V3: "Standard_E16_v3",

  @doc("Standard_E32_v3")
  StandardE32V3: "Standard_E32_v3",

  @doc("Standard_E64_v3")
  StandardE64V3: "Standard_E64_v3",

  @doc("Standard_E2s_v3")
  StandardE2SV3: "Standard_E2s_v3",

  @doc("Standard_E4s_v3")
  StandardE4SV3: "Standard_E4s_v3",

  @doc("Standard_E8s_v3")
  StandardE8SV3: "Standard_E8s_v3",

  @doc("Standard_E16s_v3")
  StandardE16SV3: "Standard_E16s_v3",

  @doc("Standard_E32s_v3")
  StandardE32SV3: "Standard_E32s_v3",

  @doc("Standard_E64s_v3")
  StandardE64SV3: "Standard_E64s_v3",

  @doc("Standard_M64s")
  StandardM64S: "Standard_M64s",

  @doc("Standard_M64ms")
  StandardM64Ms: "Standard_M64ms",

  @doc("Standard_M128s")
  StandardM128S: "Standard_M128s",

  @doc("Standard_M128ms")
  StandardM128Ms: "Standard_M128ms",

  @doc("Standard_DC2s")
  StandardDC2S: "Standard_DC2s",

  @doc("Standard_DC4s")
  StandardDC4S: "Standard_DC4s",

  @doc("Standard_E20_v3")
  StandardE20V3: "Standard_E20_v3",

  @doc("Standard_E20s_v3")
  StandardE20SV3: "Standard_E20s_v3",

  @doc("Standard_E64i_v3")
  StandardE64IV3: "Standard_E64i_v3",

  @doc("Standard_E64is_v3")
  StandardE64IsV3: "Standard_E64is_v3",

  @doc("Standard_M8ms")
  StandardM8Ms: "Standard_M8ms",

  @doc("Standard_M16ms")
  StandardM16Ms: "Standard_M16ms",

  @doc("Standard_M32ls")
  StandardM32Ls: "Standard_M32ls",

  @doc("Standard_M32ms")
  StandardM32Ms: "Standard_M32ms",

  @doc("Standard_M32ts")
  StandardM32Ts: "Standard_M32ts",

  @doc("Standard_M64")
  StandardM64: "Standard_M64",

  @doc("Standard_M64ls")
  StandardM64Ls: "Standard_M64ls",

  @doc("Standard_M64m")
  StandardM64M: "Standard_M64m",

  @doc("Standard_M128")
  StandardM128: "Standard_M128",

  @doc("Standard_M128m")
  StandardM128M: "Standard_M128m",

  @doc("Standard_L8s_v2")
  StandardL8SV2: "Standard_L8s_v2",

  @doc("Standard_L16s_v2")
  StandardL16SV2: "Standard_L16s_v2",

  @doc("Standard_L32s_v2")
  StandardL32SV2: "Standard_L32s_v2",

  @doc("Standard_L48s_v2")
  StandardL48SV2: "Standard_L48s_v2",

  @doc("Standard_L64s_v2")
  StandardL64SV2: "Standard_L64s_v2",

  @doc("Standard_L80s_v2")
  StandardL80SV2: "Standard_L80s_v2",

  @doc("Standard_D2_v4")
  StandardD2V4: "Standard_D2_v4",

  @doc("Standard_D4_v4")
  StandardD4V4: "Standard_D4_v4",

  @doc("Standard_D8_v4")
  StandardD8V4: "Standard_D8_v4",

  @doc("Standard_D16_v4")
  StandardD16V4: "Standard_D16_v4",

  @doc("Standard_D32_v4")
  StandardD32V4: "Standard_D32_v4",

  @doc("Standard_D48_v4")
  StandardD48V4: "Standard_D48_v4",

  @doc("Standard_D64_v4")
  StandardD64V4: "Standard_D64_v4",

  @doc("Standard_D2s_v4")
  StandardD2SV4: "Standard_D2s_v4",

  @doc("Standard_D4s_v4")
  StandardD4SV4: "Standard_D4s_v4",

  @doc("Standard_D8s_v4")
  StandardD8SV4: "Standard_D8s_v4",

  @doc("Standard_D16s_v4")
  StandardD16SV4: "Standard_D16s_v4",

  @doc("Standard_D32s_v4")
  StandardD32SV4: "Standard_D32s_v4",

  @doc("Standard_D48s_v4")
  StandardD48SV4: "Standard_D48s_v4",

  @doc("Standard_D64s_v4")
  StandardD64SV4: "Standard_D64s_v4",

  @doc("Standard_D2d_v4")
  StandardD2DV4: "Standard_D2d_v4",

  @doc("Standard_D4d_v4")
  StandardD4DV4: "Standard_D4d_v4",

  @doc("Standard_D8d_v4")
  StandardD8DV4: "Standard_D8d_v4",

  @doc("Standard_D16d_v4")
  StandardD16DV4: "Standard_D16d_v4",

  @doc("Standard_D32d_v4")
  StandardD32DV4: "Standard_D32d_v4",

  @doc("Standard_D48d_v4")
  StandardD48DV4: "Standard_D48d_v4",

  @doc("Standard_D64d_v4")
  StandardD64DV4: "Standard_D64d_v4",

  @doc("Standard_D2ds_v4")
  StandardD2DsV4: "Standard_D2ds_v4",

  @doc("Standard_D4ds_v4")
  StandardD4DsV4: "Standard_D4ds_v4",

  @doc("Standard_D8ds_v4")
  StandardD8DsV4: "Standard_D8ds_v4",

  @doc("Standard_D16ds_v4")
  StandardD16DsV4: "Standard_D16ds_v4",

  @doc("Standard_D32ds_v4")
  StandardD32DsV4: "Standard_D32ds_v4",

  @doc("Standard_D48ds_v4")
  StandardD48DsV4: "Standard_D48ds_v4",

  @doc("Standard_D64ds_v4")
  StandardD64DsV4: "Standard_D64ds_v4",

  @doc("Standard_E2_v4")
  StandardE2V4: "Standard_E2_v4",

  @doc("Standard_E4_v4")
  StandardE4V4: "Standard_E4_v4",

  @doc("Standard_E8_v4")
  StandardE8V4: "Standard_E8_v4",

  @doc("Standard_E16_v4")
  StandardE16V4: "Standard_E16_v4",

  @doc("Standard_E20_v4")
  StandardE20V4: "Standard_E20_v4",

  @doc("Standard_E32_v4")
  StandardE32V4: "Standard_E32_v4",

  @doc("Standard_E48_v4")
  StandardE48V4: "Standard_E48_v4",

  @doc("Standard_E64_v4")
  StandardE64V4: "Standard_E64_v4",

  @doc("Standard_E2s_v4")
  StandardE2SV4: "Standard_E2s_v4",

  @doc("Standard_E4s_v4")
  StandardE4SV4: "Standard_E4s_v4",

  @doc("Standard_E8s_v4")
  StandardE8SV4: "Standard_E8s_v4",

  @doc("Standard_E16s_v4")
  StandardE16SV4: "Standard_E16s_v4",

  @doc("Standard_E20s_v4")
  StandardE20SV4: "Standard_E20s_v4",

  @doc("Standard_E32s_v4")
  StandardE32SV4: "Standard_E32s_v4",

  @doc("Standard_E48s_v4")
  StandardE48SV4: "Standard_E48s_v4",

  @doc("Standard_E64s_v4")
  StandardE64SV4: "Standard_E64s_v4",

  @doc("Standard_E2d_v4")
  StandardE2DV4: "Standard_E2d_v4",

  @doc("Standard_E4d_v4")
  StandardE4DV4: "Standard_E4d_v4",

  @doc("Standard_E8d_v4")
  StandardE8DV4: "Standard_E8d_v4",

  @doc("Standard_E16d_v4")
  StandardE16DV4: "Standard_E16d_v4",

  @doc("Standard_E20d_v4")
  StandardE20DV4: "Standard_E20d_v4",

  @doc("Standard_E32d_v4")
  StandardE32DV4: "Standard_E32d_v4",

  @doc("Standard_E48d_v4")
  StandardE48DV4: "Standard_E48d_v4",

  @doc("Standard_E64d_v4")
  StandardE64DV4: "Standard_E64d_v4",

  @doc("Standard_E2ds_v4")
  StandardE2DsV4: "Standard_E2ds_v4",

  @doc("Standard_E4ds_v4")
  StandardE4DsV4: "Standard_E4ds_v4",

  @doc("Standard_E8ds_v4")
  StandardE8DsV4: "Standard_E8ds_v4",

  @doc("Standard_E16ds_v4")
  StandardE16DsV4: "Standard_E16ds_v4",

  @doc("Standard_E20ds_v4")
  StandardE20DsV4: "Standard_E20ds_v4",

  @doc("Standard_E32ds_v4")
  StandardE32DsV4: "Standard_E32ds_v4",

  @doc("Standard_E48ds_v4")
  StandardE48DsV4: "Standard_E48ds_v4",

  @doc("Standard_E64ds_v4")
  StandardE64DsV4: "Standard_E64ds_v4",

  @doc("Standard_E2as_v4")
  StandardE2AsV4: "Standard_E2as_v4",

  @doc("Standard_E4as_v4")
  StandardE4AsV4: "Standard_E4as_v4",

  @doc("Standard_E8as_v4")
  StandardE8AsV4: "Standard_E8as_v4",

  @doc("Standard_E16as_v4")
  StandardE16AsV4: "Standard_E16as_v4",

  @doc("Standard_E20as_v4")
  StandardE20AsV4: "Standard_E20as_v4",

  @doc("Standard_E32as_v4")
  StandardE32AsV4: "Standard_E32as_v4",

  @doc("Standard_E48as_v4")
  StandardE48AsV4: "Standard_E48as_v4",

  @doc("Standard_E64as_v4")
  StandardE64AsV4: "Standard_E64as_v4",

  @doc("Standard_E96as_v4")
  StandardE96AsV4: "Standard_E96as_v4",

  @doc("Standard_D2as_v4")
  StandardD2AsV4: "Standard_D2as_v4",

  @doc("Standard_D4as_v4")
  StandardD4AsV4: "Standard_D4as_v4",

  @doc("Standard_D8as_v4")
  StandardD8AsV4: "Standard_D8as_v4",

  @doc("Standard_D16as_v4")
  StandardD16AsV4: "Standard_D16as_v4",

  @doc("Standard_D32as_v4")
  StandardD32AsV4: "Standard_D32as_v4",

  @doc("Standard_D48as_v4")
  StandardD48AsV4: "Standard_D48as_v4",

  @doc("Standard_D64as_v4")
  StandardD64AsV4: "Standard_D64as_v4",

  @doc("Standard_D96as_v4")
  StandardD96AsV4: "Standard_D96as_v4",

  @doc("Standard_M208ms_v2")
  StandardM208MsV2: "Standard_M208ms_v2",

  @doc("Standard_M208s_v2")
  StandardM208SV2: "Standard_M208s_v2",

  @doc("Standard_M416ms_v2")
  StandardM416MsV2: "Standard_M416ms_v2",

  @doc("Standard_M416s_v2")
  StandardM416SV2: "Standard_M416s_v2",

  @doc("Standard_F48s_v2")
  StandardF48SV2: "Standard_F48s_v2",

  @doc("Standard_E48_v3")
  StandardE48V3: "Standard_E48_v3",

  @doc("Standard_E48s_v3")
  StandardE48SV3: "Standard_E48s_v3",

  @doc("Standard_E80is_v4")
  StandardE80IsV4: "Standard_E80is_v4",

  @doc("Standard_E80ids_v4")
  StandardE80IdsV4: "Standard_E80ids_v4",

  @doc("Standard_E2a_v4")
  StandardE2AV4: "Standard_E2a_v4",

  @doc("Standard_E4a_v4")
  StandardE4AV4: "Standard_E4a_v4",

  @doc("Standard_E8a_v4")
  StandardE8AV4: "Standard_E8a_v4",

  @doc("Standard_E16a_v4")
  StandardE16AV4: "Standard_E16a_v4",

  @doc("Standard_E20a_v4")
  StandardE20AV4: "Standard_E20a_v4",

  @doc("Standard_E32a_v4")
  StandardE32AV4: "Standard_E32a_v4",

  @doc("Standard_E48a_v4")
  StandardE48AV4: "Standard_E48a_v4",

  @doc("Standard_E64a_v4")
  StandardE64AV4: "Standard_E64a_v4",

  @doc("Standard_E96a_v4")
  StandardE96AV4: "Standard_E96a_v4",

  @doc("Standard_D2a_v4")
  StandardD2AV4: "Standard_D2a_v4",

  @doc("Standard_D4a_v4")
  StandardD4AV4: "Standard_D4a_v4",

  @doc("Standard_D8a_v4")
  StandardD8AV4: "Standard_D8a_v4",

  @doc("Standard_D16a_v4")
  StandardD16AV4: "Standard_D16a_v4",

  @doc("Standard_D32a_v4")
  StandardD32AV4: "Standard_D32a_v4",

  @doc("Standard_D48a_v4")
  StandardD48AV4: "Standard_D48a_v4",

  @doc("Standard_D64a_v4")
  StandardD64AV4: "Standard_D64a_v4",

  @doc("Standard_D96a_v4")
  StandardD96AV4: "Standard_D96a_v4",

  @doc("Standard_M32ms_v2")
  StandardM32MsV2: "Standard_M32ms_v2",

  @doc("Standard_M64s_v2")
  StandardM64SV2: "Standard_M64s_v2",

  @doc("Standard_M64ms_v2")
  StandardM64MsV2: "Standard_M64ms_v2",

  @doc("Standard_M128s_v2")
  StandardM128SV2: "Standard_M128s_v2",

  @doc("Standard_M128ms_v2")
  StandardM128MsV2: "Standard_M128ms_v2",

  @doc("Standard_M192is_v2")
  StandardM192IsV2: "Standard_M192is_v2",

  @doc("Standard_M192ims_v2")
  StandardM192ImsV2: "Standard_M192ims_v2",

  @doc("Standard_M32dms_v2")
  StandardM32DmsV2: "Standard_M32dms_v2",

  @doc("Standard_M64ds_v2")
  StandardM64DsV2: "Standard_M64ds_v2",

  @doc("Standard_M64dms_v2")
  StandardM64DmsV2: "Standard_M64dms_v2",

  @doc("Standard_M128ds_v2")
  StandardM128DsV2: "Standard_M128ds_v2",

  @doc("Standard_M128dms_v2")
  StandardM128DmsV2: "Standard_M128dms_v2",

  @doc("Standard_M192ids_v2")
  StandardM192IdsV2: "Standard_M192ids_v2",

  @doc("Standard_M192idms_v2")
  StandardM192IdmsV2: "Standard_M192idms_v2",

  @doc("Standard_D2_v5")
  StandardD2V5: "Standard_D2_v5",

  @doc("Standard_D4_v5")
  StandardD4V5: "Standard_D4_v5",

  @doc("Standard_D8_v5")
  StandardD8V5: "Standard_D8_v5",

  @doc("Standard_D16_v5")
  StandardD16V5: "Standard_D16_v5",

  @doc("Standard_D32_v5")
  StandardD32V5: "Standard_D32_v5",

  @doc("Standard_D48_v5")
  StandardD48V5: "Standard_D48_v5",

  @doc("Standard_D64_v5")
  StandardD64V5: "Standard_D64_v5",

  @doc("Standard_D96_v5")
  StandardD96V5: "Standard_D96_v5",

  @doc("Standard_D2s_v5")
  StandardD2SV5: "Standard_D2s_v5",

  @doc("Standard_D4s_v5")
  StandardD4SV5: "Standard_D4s_v5",

  @doc("Standard_D8s_v5")
  StandardD8SV5: "Standard_D8s_v5",

  @doc("Standard_D16s_v5")
  StandardD16SV5: "Standard_D16s_v5",

  @doc("Standard_D32s_v5")
  StandardD32SV5: "Standard_D32s_v5",

  @doc("Standard_D48s_v5")
  StandardD48SV5: "Standard_D48s_v5",

  @doc("Standard_D64s_v5")
  StandardD64SV5: "Standard_D64s_v5",

  @doc("Standard_D96s_v5")
  StandardD96SV5: "Standard_D96s_v5",

  @doc("Standard_D2d_v5")
  StandardD2DV5: "Standard_D2d_v5",

  @doc("Standard_D4d_v5")
  StandardD4DV5: "Standard_D4d_v5",

  @doc("Standard_D8d_v5")
  StandardD8DV5: "Standard_D8d_v5",

  @doc("Standard_D16d_v5")
  StandardD16DV5: "Standard_D16d_v5",

  @doc("Standard_D32d_v5")
  StandardD32DV5: "Standard_D32d_v5",

  @doc("Standard_D48d_v5")
  StandardD48DV5: "Standard_D48d_v5",

  @doc("Standard_D64d_v5")
  StandardD64DV5: "Standard_D64d_v5",

  @doc("Standard_D96d_v5")
  StandardD96DV5: "Standard_D96d_v5",

  @doc("Standard_D2ds_v5")
  StandardD2DsV5: "Standard_D2ds_v5",

  @doc("Standard_D4ds_v5")
  StandardD4DsV5: "Standard_D4ds_v5",

  @doc("Standard_D8ds_v5")
  StandardD8DsV5: "Standard_D8ds_v5",

  @doc("Standard_D16ds_v5")
  StandardD16DsV5: "Standard_D16ds_v5",

  @doc("Standard_D32ds_v5")
  StandardD32DsV5: "Standard_D32ds_v5",

  @doc("Standard_D48ds_v5")
  StandardD48DsV5: "Standard_D48ds_v5",

  @doc("Standard_D64ds_v5")
  StandardD64DsV5: "Standard_D64ds_v5",

  @doc("Standard_D96ds_v5")
  StandardD96DsV5: "Standard_D96ds_v5",

  @doc("Standard_D2as_v5")
  StandardD2AsV5: "Standard_D2as_v5",

  @doc("Standard_D4as_v5")
  StandardD4AsV5: "Standard_D4as_v5",

  @doc("Standard_D8as_v5")
  StandardD8AsV5: "Standard_D8as_v5",

  @doc("Standard_D16as_v5")
  StandardD16AsV5: "Standard_D16as_v5",

  @doc("Standard_D32as_v5")
  StandardD32AsV5: "Standard_D32as_v5",

  @doc("Standard_D48as_v5")
  StandardD48AsV5: "Standard_D48as_v5",

  @doc("Standard_D64as_v5")
  StandardD64AsV5: "Standard_D64as_v5",

  @doc("Standard_D96as_v5")
  StandardD96AsV5: "Standard_D96as_v5",

  @doc("Standard_D2ads_v5")
  StandardD2AdsV5: "Standard_D2ads_v5",

  @doc("Standard_D4ads_v5")
  StandardD4AdsV5: "Standard_D4ads_v5",

  @doc("Standard_D8ads_v5")
  StandardD8AdsV5: "Standard_D8ads_v5",

  @doc("Standard_D16ads_v5")
  StandardD16AdsV5: "Standard_D16ads_v5",

  @doc("Standard_D32ads_v5")
  StandardD32AdsV5: "Standard_D32ads_v5",

  @doc("Standard_D48ads_v5")
  StandardD48AdsV5: "Standard_D48ads_v5",

  @doc("Standard_D64ads_v5")
  StandardD64AdsV5: "Standard_D64ads_v5",

  @doc("Standard_D96ads_v5")
  StandardD96AdsV5: "Standard_D96ads_v5",

  @doc("Standard_E2_v5")
  StandardE2V5: "Standard_E2_v5",

  @doc("Standard_E4_v5")
  StandardE4V5: "Standard_E4_v5",

  @doc("Standard_E8_v5")
  StandardE8V5: "Standard_E8_v5",

  @doc("Standard_E16_v5")
  StandardE16V5: "Standard_E16_v5",

  @doc("Standard_E20_v5")
  StandardE20V5: "Standard_E20_v5",

  @doc("Standard_E32_v5")
  StandardE32V5: "Standard_E32_v5",

  @doc("Standard_E48_v5")
  StandardE48V5: "Standard_E48_v5",

  @doc("Standard_E64_v5")
  StandardE64V5: "Standard_E64_v5",

  @doc("Standard_E96_v5")
  StandardE96V5: "Standard_E96_v5",

  @doc("Standard_E104i_v5")
  StandardE104IV5: "Standard_E104i_v5",

  @doc("Standard_E2s_v5")
  StandardE2SV5: "Standard_E2s_v5",

  @doc("Standard_E4s_v5")
  StandardE4SV5: "Standard_E4s_v5",

  @doc("Standard_E8s_v5")
  StandardE8SV5: "Standard_E8s_v5",

  @doc("Standard_E16s_v5")
  StandardE16SV5: "Standard_E16s_v5",

  @doc("Standard_E20s_v5")
  StandardE20SV5: "Standard_E20s_v5",

  @doc("Standard_E32s_v5")
  StandardE32SV5: "Standard_E32s_v5",

  @doc("Standard_E48s_v5")
  StandardE48SV5: "Standard_E48s_v5",

  @doc("Standard_E64s_v5")
  StandardE64SV5: "Standard_E64s_v5",

  @doc("Standard_E96s_v5")
  StandardE96SV5: "Standard_E96s_v5",

  @doc("Standard_E104is_v5")
  StandardE104IsV5: "Standard_E104is_v5",

  @doc("Standard_E2d_v5")
  StandardE2DV5: "Standard_E2d_v5",

  @doc("Standard_E4d_v5")
  StandardE4DV5: "Standard_E4d_v5",

  @doc("Standard_E8d_v5")
  StandardE8DV5: "Standard_E8d_v5",

  @doc("Standard_E16d_v5")
  StandardE16DV5: "Standard_E16d_v5",

  @doc("Standard_E20d_v5")
  StandardE20DV5: "Standard_E20d_v5",

  @doc("Standard_E32d_v5")
  StandardE32DV5: "Standard_E32d_v5",

  @doc("Standard_E48d_v5")
  StandardE48DV5: "Standard_E48d_v5",

  @doc("Standard_E64d_v5")
  StandardE64DV5: "Standard_E64d_v5",

  @doc("Standard_E96d_v5")
  StandardE96DV5: "Standard_E96d_v5",

  @doc("Standard_E104id_v5")
  StandardE104IdV5: "Standard_E104id_v5",

  @doc("Standard_E2ds_v5")
  StandardE2DsV5: "Standard_E2ds_v5",

  @doc("Standard_E4ds_v5")
  StandardE4DsV5: "Standard_E4ds_v5",

  @doc("Standard_E8ds_v5")
  StandardE8DsV5: "Standard_E8ds_v5",

  @doc("Standard_E16ds_v5")
  StandardE16DsV5: "Standard_E16ds_v5",

  @doc("Standard_E20ds_v5")
  StandardE20DsV5: "Standard_E20ds_v5",

  @doc("Standard_E32ds_v5")
  StandardE32DsV5: "Standard_E32ds_v5",

  @doc("Standard_E48ds_v5")
  StandardE48DsV5: "Standard_E48ds_v5",

  @doc("Standard_E64ds_v5")
  StandardE64DsV5: "Standard_E64ds_v5",

  @doc("Standard_E96ds_v5")
  StandardE96DsV5: "Standard_E96ds_v5",

  @doc("Standard_E104ids_v5")
  StandardE104IdsV5: "Standard_E104ids_v5",

  @doc("Standard_E2as_v5")
  StandardE2AsV5: "Standard_E2as_v5",

  @doc("Standard_E4as_v5")
  StandardE4AsV5: "Standard_E4as_v5",

  @doc("Standard_E8as_v5")
  StandardE8AsV5: "Standard_E8as_v5",

  @doc("Standard_E16as_v5")
  StandardE16AsV5: "Standard_E16as_v5",

  @doc("Standard_E20as_v5")
  StandardE20AsV5: "Standard_E20as_v5",

  @doc("Standard_E32as_v5")
  StandardE32AsV5: "Standard_E32as_v5",

  @doc("Standard_E48as_v5")
  StandardE48AsV5: "Standard_E48as_v5",

  @doc("Standard_E64as_v5")
  StandardE64AsV5: "Standard_E64as_v5",

  @doc("Standard_E96as_v5")
  StandardE96AsV5: "Standard_E96as_v5",

  @doc("Standard_E2ads_v5")
  StandardE2AdsV5: "Standard_E2ads_v5",

  @doc("Standard_E4ads_v5")
  StandardE4AdsV5: "Standard_E4ads_v5",

  @doc("Standard_E8ads_v5")
  StandardE8AdsV5: "Standard_E8ads_v5",

  @doc("Standard_E16ads_v5")
  StandardE16AdsV5: "Standard_E16ads_v5",

  @doc("Standard_E20ads_v5")
  StandardE20AdsV5: "Standard_E20ads_v5",

  @doc("Standard_E32ads_v5")
  StandardE32AdsV5: "Standard_E32ads_v5",

  @doc("Standard_E48ads_v5")
  StandardE48AdsV5: "Standard_E48ads_v5",

  @doc("Standard_E64ads_v5")
  StandardE64AdsV5: "Standard_E64ads_v5",

  @doc("Standard_E96ads_v5")
  StandardE96AdsV5: "Standard_E96ads_v5",

  @doc("Standard_M8_2ms")
  StandardM82Ms: "Standard_M8_2ms",

  @doc("Standard_M8_4ms")
  StandardM84Ms: "Standard_M8_4ms",

  @doc("Standard_M16_4ms")
  StandardM164Ms: "Standard_M16_4ms",

  @doc("Standard_M16_8ms")
  StandardM168Ms: "Standard_M16_8ms",

  @doc("Standard_M32_8ms")
  StandardM328Ms: "Standard_M32_8ms",

  @doc("Standard_M32_16ms")
  StandardM3216Ms: "Standard_M32_16ms",

  @doc("Standard_M64_32ms")
  StandardM6432Ms: "Standard_M64_32ms",

  @doc("Standard_M64_16ms")
  StandardM6416Ms: "Standard_M64_16ms",

  @doc("Standard_M128_64ms")
  StandardM12864Ms: "Standard_M128_64ms",

  @doc("Standard_M128_32ms")
  StandardM12832Ms: "Standard_M128_32ms",

  @doc("Standard_E4_2s_v3")
  StandardE42SV3: "Standard_E4_2s_v3",

  @doc("Standard_E8_4s_v3")
  StandardE84SV3: "Standard_E8_4s_v3",

  @doc("Standard_E8_2s_v3")
  StandardE82SV3: "Standard_E8_2s_v3",

  @doc("Standard_E16_8s_v3")
  StandardE168SV3: "Standard_E16_8s_v3",

  @doc("Standard_E16_4s_v3")
  StandardE164SV3: "Standard_E16_4s_v3",

  @doc("Standard_E32_16s_v3")
  StandardE3216SV3: "Standard_E32_16s_v3",

  @doc("Standard_E32_8s_v3")
  StandardE328SV3: "Standard_E32_8s_v3",

  @doc("Standard_E64_32s_v3")
  StandardE6432SV3: "Standard_E64_32s_v3",

  @doc("Standard_E64_16s_v3")
  StandardE6416SV3: "Standard_E64_16s_v3",

  @doc("Standard_E4_2s_v4")
  StandardE42SV4: "Standard_E4_2s_v4",

  @doc("Standard_E8_4s_v4")
  StandardE84SV4: "Standard_E8_4s_v4",

  @doc("Standard_E8_2s_v4")
  StandardE82SV4: "Standard_E8_2s_v4",

  @doc("Standard_E16_8s_v4")
  StandardE168SV4: "Standard_E16_8s_v4",

  @doc("Standard_E16_4s_v4")
  StandardE164SV4: "Standard_E16_4s_v4",

  @doc("Standard_E32_16s_v4")
  StandardE3216SV4: "Standard_E32_16s_v4",

  @doc("Standard_E32_8s_v4")
  StandardE328SV4: "Standard_E32_8s_v4",

  @doc("Standard_E64_32s_v4")
  StandardE6432SV4: "Standard_E64_32s_v4",

  @doc("Standard_E64_16s_v4")
  StandardE6416SV4: "Standard_E64_16s_v4",

  @doc("Standard_E4_2ds_v4")
  StandardE42DsV4: "Standard_E4_2ds_v4",

  @doc("Standard_E8_4ds_v4")
  StandardE84DsV4: "Standard_E8_4ds_v4",

  @doc("Standard_E8_2ds_v4")
  StandardE82DsV4: "Standard_E8_2ds_v4",

  @doc("Standard_E16_8ds_v4")
  StandardE168DsV4: "Standard_E16_8ds_v4",

  @doc("Standard_E16_4ds_v4")
  StandardE164DsV4: "Standard_E16_4ds_v4",

  @doc("Standard_E32_16ds_v4")
  StandardE3216DsV4: "Standard_E32_16ds_v4",

  @doc("Standard_E32_8ds_v4")
  StandardE328DsV4: "Standard_E32_8ds_v4",

  @doc("Standard_E64_32ds_v4")
  StandardE6432DsV4: "Standard_E64_32ds_v4",

  @doc("Standard_E64_16ds_v4")
  StandardE6416DsV4: "Standard_E64_16ds_v4",

  @doc("Standard_E4_2as_v4")
  StandardE42AsV4: "Standard_E4_2as_v4",

  @doc("Standard_E8_4as_v4")
  StandardE84AsV4: "Standard_E8_4as_v4",

  @doc("Standard_E8_2as_v4")
  StandardE82AsV4: "Standard_E8_2as_v4",

  @doc("Standard_E16_8as_v4")
  StandardE168AsV4: "Standard_E16_8as_v4",

  @doc("Standard_E16_4as_v4")
  StandardE164AsV4: "Standard_E16_4as_v4",

  @doc("Standard_E32_16as_v4")
  StandardE3216AsV4: "Standard_E32_16as_v4",

  @doc("Standard_E32_8as_v4")
  StandardE328AsV4: "Standard_E32_8as_v4",

  @doc("Standard_E64_32as_v4")
  StandardE6432AsV4: "Standard_E64_32as_v4",

  @doc("Standard_E64_16as_v4")
  StandardE6416AsV4: "Standard_E64_16as_v4",

  @doc("Standard_E96_48as_v4")
  StandardE9648AsV4: "Standard_E96_48as_v4",

  @doc("Standard_E96_24as_v4")
  StandardE9624AsV4: "Standard_E96_24as_v4",

  @doc("Standard_E4_2ads_v5")
  StandardE42AdsV5: "Standard_E4_2ads_v5",

  @doc("Standard_E8_4ads_v5")
  StandardE84AdsV5: "Standard_E8_4ads_v5",

  @doc("Standard_E8_2ads_v5")
  StandardE82AdsV5: "Standard_E8_2ads_v5",

  @doc("Standard_E16_8ads_v5")
  StandardE168AdsV5: "Standard_E16_8ads_v5",

  @doc("Standard_E16_4ads_v5")
  StandardE164AdsV5: "Standard_E16_4ads_v5",

  @doc("Standard_E32_16ads_v5")
  StandardE3216AdsV5: "Standard_E32_16ads_v5",

  @doc("Standard_E32_8ads_v5")
  StandardE328AdsV5: "Standard_E32_8ads_v5",

  @doc("Standard_E64_32ads_v5")
  StandardE6432AdsV5: "Standard_E64_32ads_v5",

  @doc("Standard_E64_16ads_v5")
  StandardE6416AdsV5: "Standard_E64_16ads_v5",

  @doc("Standard_E96_48ads_v5")
  StandardE9648AdsV5: "Standard_E96_48ads_v5",

  @doc("Standard_E96_24ads_v5")
  StandardE9624AdsV5: "Standard_E96_24ads_v5",

  @doc("Standard_E4_2s_v5")
  StandardE42SV5: "Standard_E4_2s_v5",

  @doc("Standard_E8_4s_v5")
  StandardE84SV5: "Standard_E8_4s_v5",

  @doc("Standard_E8_2s_v5")
  StandardE82SV5: "Standard_E8_2s_v5",

  @doc("Standard_E16_8s_v5")
  StandardE168SV5: "Standard_E16_8s_v5",

  @doc("Standard_E16_4s_v5")
  StandardE164SV5: "Standard_E16_4s_v5",

  @doc("Standard_E32_16s_v5")
  StandardE3216SV5: "Standard_E32_16s_v5",

  @doc("Standard_E32_8s_v5")
  StandardE328SV5: "Standard_E32_8s_v5",

  @doc("Standard_E64_32s_v5")
  StandardE6432SV5: "Standard_E64_32s_v5",

  @doc("Standard_E64_16s_v5")
  StandardE6416SV5: "Standard_E64_16s_v5",

  @doc("Standard_E96_48s_v5")
  StandardE9648SV5: "Standard_E96_48s_v5",

  @doc("Standard_E96_24s_v5")
  StandardE9624SV5: "Standard_E96_24s_v5",

  @doc("Standard_E4_2ds_v5")
  StandardE42DsV5: "Standard_E4_2ds_v5",

  @doc("Standard_E8_4ds_v5")
  StandardE84DsV5: "Standard_E8_4ds_v5",

  @doc("Standard_E8_2ds_v5")
  StandardE82DsV5: "Standard_E8_2ds_v5",

  @doc("Standard_E16_8ds_v5")
  StandardE168DsV5: "Standard_E16_8ds_v5",

  @doc("Standard_E16_4ds_v5")
  StandardE164DsV5: "Standard_E16_4ds_v5",

  @doc("Standard_E32_16ds_v5")
  StandardE3216DsV5: "Standard_E32_16ds_v5",

  @doc("Standard_E32_8ds_v5")
  StandardE328DsV5: "Standard_E32_8ds_v5",

  @doc("Standard_E64_32ds_v5")
  StandardE6432DsV5: "Standard_E64_32ds_v5",

  @doc("Standard_E64_16ds_v5")
  StandardE6416DsV5: "Standard_E64_16ds_v5",

  @doc("Standard_E96_48ds_v5")
  StandardE9648DsV5: "Standard_E96_48ds_v5",

  @doc("Standard_E96_24ds_v5")
  StandardE9624DsV5: "Standard_E96_24ds_v5",

  @doc("Standard_E4_2as_v5")
  StandardE42AsV5: "Standard_E4_2as_v5",

  @doc("Standard_E8_4as_v5")
  StandardE84AsV5: "Standard_E8_4as_v5",

  @doc("Standard_E8_2as_v5")
  StandardE82AsV5: "Standard_E8_2as_v5",

  @doc("Standard_E16_8as_v5")
  StandardE168AsV5: "Standard_E16_8as_v5",

  @doc("Standard_E16_4as_v5")
  StandardE164AsV5: "Standard_E16_4as_v5",

  @doc("Standard_E32_16as_v5")
  StandardE3216AsV5: "Standard_E32_16as_v5",

  @doc("Standard_E32_8as_v5")
  StandardE328AsV5: "Standard_E32_8as_v5",

  @doc("Standard_E64_32as_v5")
  StandardE6432AsV5: "Standard_E64_32as_v5",

  @doc("Standard_E64_16as_v5")
  StandardE6416AsV5: "Standard_E64_16as_v5",

  @doc("Standard_E96_48as_v5")
  StandardE9648AsV5: "Standard_E96_48as_v5",

  @doc("Standard_E96_24as_v5")
  StandardE9624AsV5: "Standard_E96_24as_v5",

  @doc("Standard_GS4_8")
  StandardGS48: "Standard_GS4_8",

  @doc("Standard_GS4_4")
  StandardGS44: "Standard_GS4_4",

  @doc("Standard_GS5_16")
  StandardGS516: "Standard_GS5_16",

  @doc("Standard_GS5_8")
  StandardGS58: "Standard_GS5_8",

  @doc("Standard_DS11_1_v2")
  StandardDS111V2: "Standard_DS11_1_v2",

  @doc("Standard_DS12_2_v2")
  StandardDS122V2: "Standard_DS12_2_v2",

  @doc("Standard_DS12_1_v2")
  StandardDS121V2: "Standard_DS12_1_v2",

  @doc("Standard_DS13_4_v2")
  StandardDS134V2: "Standard_DS13_4_v2",

  @doc("Standard_DS13_2_v2")
  StandardDS132V2: "Standard_DS13_2_v2",

  @doc("Standard_DS14_8_v2")
  StandardDS148V2: "Standard_DS14_8_v2",

  @doc("Standard_DS14_4_v2")
  StandardDS144V2: "Standard_DS14_4_v2",

  @doc("Standard_M416_208s_v2")
  StandardM416208SV2: "Standard_M416_208s_v2",

  @doc("Standard_M416_208ms_v2")
  StandardM416208MsV2: "Standard_M416_208ms_v2",

  @doc("Standard_E2bs_v5")
  StandardE2BsV5: "Standard_E2bs_v5",

  @doc("Standard_E4bs_v5")
  StandardE4BsV5: "Standard_E4bs_v5",

  @doc("Standard_E8bs_v5")
  StandardE8BsV5: "Standard_E8bs_v5",

  @doc("Standard_E16bs_v5")
  StandardE16BsV5: "Standard_E16bs_v5",

  @doc("Standard_E32bs_v5")
  StandardE32BsV5: "Standard_E32bs_v5",

  @doc("Standard_E48bs_v5")
  StandardE48BsV5: "Standard_E48bs_v5",

  @doc("Standard_E64bs_v5")
  StandardE64BsV5: "Standard_E64bs_v5",

  @doc("Standard_E2bds_v5")
  StandardE2BdsV5: "Standard_E2bds_v5",

  @doc("Standard_E4bds_v5")
  StandardE4BdsV5: "Standard_E4bds_v5",

  @doc("Standard_E8bds_v5")
  StandardE8BdsV5: "Standard_E8bds_v5",

  @doc("Standard_E16bds_v5")
  StandardE16BdsV5: "Standard_E16bds_v5",

  @doc("Standard_E32bds_v5")
  StandardE32BdsV5: "Standard_E32bds_v5",

  @doc("Standard_E48bds_v5")
  StandardE48BdsV5: "Standard_E48bds_v5",

  @doc("Standard_E64bds_v5")
  StandardE64BdsV5: "Standard_E64bds_v5",

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
