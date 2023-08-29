enum FttAndRaidLevel {
    "Unknown",
    "Ftt1Raid1",
    "Ftt1Raid5",
    "Ftt2Raid1",
    "Ftt2Raid6",
    "Ftt3Raid1",
}

enum AzureAvsNodeType {
    "Unknown",
    "AV36",
}

enum AzureAvsSuitabilityExplanation {
    "Unknown",
    "NotApplicable",
    "UnsupportedLocationForSelectedNode",
}

enum AzureAvsVmSuitabilityExplanation {
    "Unknown",
    "NotApplicable",
    "IpV6NotSupported",
    "UnsupportedOperatingSystem",
}

enum AzureAvsVmSuitabilityDetail {
    "None",
    "PercentageOfCoresUtilizedMissing",
    "PercentageOfMemoryUtilizedMissing",
    "PercentageOfCoresUtilizedOutOfRange",
    "PercentageOfMemoryUtilizedOutOfRange",
    "PercentageOfStorageUtilizedOutOfRange",
}
