using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Migrate;

@doc("Azure AVS Node type")
union AzureAvsNodeType {
  @doc("Unknown Node type")
  Unknown: "Unknown",

  @doc("AVS36 Node type")
  AV36: "AV36",

  @doc("AV36P Node type")
  AV36P: "AV36P",

  @doc("AV52 Node type")
  AV52: "AV52",

  @doc("AV64 Node type")
  AV64: "AV64",

  string,
}

@doc("Azure AVS Suitability Detail")
union AzureAvsSuitabilityExplanation {
  @doc("Suitability Unknown")
  Unknown: "Unknown",

  @doc("Suitability Not applicable")
  NotApplicable: "NotApplicable",

  @doc("Unsupported location for selected node")
  UnsupportedLocationForSelectedNode: "UnsupportedLocationForSelectedNode",

  @doc("Internal error in recommendation")
  InternalErrorInRecommendation: "InternalErrorInRecommendation",

  @doc("Unsupported location for selected external storage types")
  UnsupportedLocationForSelectedExternalStorageTypes: "UnsupportedLocationForSelectedExternalStorageTypes",

  string,
}

@doc("Azure AVS VM Suitability Explanation")
union AzureAvsVmSuitabilityExplanation {
  @doc("Suitability Unknown")
  Unknown: "Unknown",

  @doc("Suitability Not Applicable")
  NotApplicable: "NotApplicable",

  @doc("IPv6 Not supported")
  IpV6NotSupported: "IpV6NotSupported",

  @doc("Unsupported operating system")
  UnsupportedOperatingSystem: "UnsupportedOperatingSystem",

  string,
}

@doc("Azure AVS VM Suitability Detail")
union AzureAvsVmSuitabilityDetail {
  @doc("Suitability None")
  None: "None",

  @doc("Percentage of cores utilized missing")
  PercentageOfCoresUtilizedMissing: "PercentageOfCoresUtilizedMissing",

  @doc("Percentage of Memory Utilized missing")
  PercentageOfMemoryUtilizedMissing: "PercentageOfMemoryUtilizedMissing",

  @doc("Percentage of cores utilized out of range.")
  PercentageOfCoresUtilizedOutOfRange: "PercentageOfCoresUtilizedOutOfRange",

  @doc("Percentage of Memory utilized out of range.")
  PercentageOfMemoryUtilizedOutOfRange: "PercentageOfMemoryUtilizedOutOfRange",

  @doc("Percentage of storage utilized out of range.")
  PercentageOfStorageUtilizedOutOfRange: "PercentageOfStorageUtilizedOutOfRange",

  string,
}

@doc("Scenarios with which Avs Assessments can be created.")
union AvsAssessmentScenario {
  @doc("Unknown assessment scenario")
  Unknown: "Unknown",

  @doc("Create Assessment for new Avs Sddc")
  NewAvsSddc: "NewAvsSddc",

  @doc("Create Assessment for existing Avs Sddc")
  AvsSddcExpansion: "AvsSddcExpansion",

  string,
}

@doc("FTT and RAID Level.")
union FttAndRaidLevel {
  @doc("Unknown FTT and RAID Level.")
  Unknown: "Unknown",

  @doc("FTT 1 and RAID Level 1.")
  Ftt1Raid1: "Ftt1Raid1",

  @doc("FTT 1 and RAID Level 5.")
  Ftt1Raid5: "Ftt1Raid5",

  @doc("FTT 2 and RAID Level 1.")
  Ftt2Raid1: "Ftt2Raid1",

  @doc("FTT 2 and RAID Level 6.")
  Ftt2Raid6: "Ftt2Raid6",

  @doc("FTT 3 and RAID Level 1.")
  Ftt3Raid1: "Ftt3Raid1",

  string,
}

@doc("Different External storage skus.")
union ExternalStorageType {
  @doc("Indicates un-supported external storage.")
  Unknown: "Unknown",

  @doc("Indicates No external storage.")
  None: "None",

  @doc("ANF external storage with Standard SKU.")
  AnfStandard: "AnfStandard",

  @doc("ANF external storage with Premium SKU.")
  AnfPremium: "AnfPremium",

  @doc("ANF external storage with Ultra SKU.")
  AnfUltra: "AnfUltra",

  string,
}

@doc("Different network skus.")
union NetworkSkuType {
  @doc("Indicates un-supported network SKU.")
  Unknown: "Unknown",

  @doc("Indicates No network SKU.")
  None: "None",

  @doc("Express Route network type with Ultra SKU.")
  ExpressRouteUltra: "ExpressRouteUltra",

  string,
}
