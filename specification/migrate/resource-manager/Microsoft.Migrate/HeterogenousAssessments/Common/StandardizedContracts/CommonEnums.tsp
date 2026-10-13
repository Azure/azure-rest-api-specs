@doc("Machine Boot Type")
union MachineBootType {
  @doc("Unknown - Machine Boot Type")
  Unknown: "Unknown",

  @doc("EFI - Machine Boot Type")
  EFI: "EFI",

  @doc("BIOS - Machine Boot Type")
  Bios: "BIOS",

  @doc("NotSpecified - Machine Boot Type")
  NotSpecified: "NotSpecified",

  string,
}

@doc("Environment Type")
union EnvironmentType {
  @doc("Production - Environment Type")
  Production: "Production",

  @doc("Unknown - Environment Type")
  Unknown: "Unknown",

  @doc("DevTest - Environment Type")
  DevTest: "DevTest",

  string,
}

@doc("Azure Managed Disk Sku Dto Disk Type")
union AzureManagedDiskSkuDtoDiskType {
  @doc("Unknown - Azure Managed Disk Sku Dto Disk Type")
  Unknown: "Unknown",

  @doc("Standard - Azure Managed Disk Sku Dto Disk Type")
  Standard: "Standard",

  @doc("StandardSSD - Azure Managed Disk Sku Dto Disk Type")
  StandardSSD: "StandardSSD",

  @doc("Premium - Azure Managed Disk Sku Dto Disk Type")
  Premium: "Premium",

  @doc("StandardOrPremium - Azure Managed Disk Sku Dto Disk Type")
  StandardOrPremium: "StandardOrPremium",

  @doc("Ultra - Azure Managed Disk Sku Dto Disk Type")
  Ultra: "Ultra",

  @doc("PremiumV2 - Azure Managed Disk Sku Dto Disk Type")
  PremiumV2: "PremiumV2",

  string,
}

@doc("Azure Managed Disk Sku Dto Disk Redundancy")
union AzureManagedDiskSkuDtoDiskRedundancy {
  @doc("Unknown - Azure Managed Disk Sku Dto Disk Redundancy")
  Unknown: "Unknown",

  @doc("LRS - Azure Managed Disk Sku Dto Disk Redundancy")
  LRS: "LRS",

  @doc("ZRS - Azure Managed Disk Sku Dto Disk Redundancy")
  ZRS: "ZRS",

  string,
}

@doc("Azure Quorum Witness Dto Quorum Witness Type")
union AzureQuorumWitnessDtoQuorumWitnessType {
  @doc("Unknown - Quorum Witness Type")
  Unknown: "Unknown",

  @doc("Cloud Quorum Witness Type")
  Cloud: "Cloud",

  @doc("Disk Quorum Witness Type")
  Disk: "Disk",

  string,
}

@doc("Migration Issues Category")
union MigrationIssuesCategory {
  @doc("Issue - Migration Issues Category")
  Issue: "Issue",

  @doc("Warning - Migration Issues Category")
  Warning: "Warning",

  @doc("Internal - Migration Issues Category")
  Internal: "Internal",

  string,
}
