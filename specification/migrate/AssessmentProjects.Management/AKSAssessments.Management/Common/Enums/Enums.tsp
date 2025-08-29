using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Migrate;

@doc("Assessment Status.")
union AssessmentStatus {
  @doc("Assessment is Created.")
  Created: "Created",

  @doc("Assessment is Updated.")
  Updated: "Updated",

  @doc("Assessment is currently running.")
  Running: "Running",

  @doc("Assessment is Completed or Ready.")
  Completed: "Completed",

  @doc("Assessment is Failed i.e. it is now invalid.")
  Invalid: "Invalid",

  @doc("Assessment is Out of Sync.")
  OutOfSync: "OutOfSync",

  @doc("Assessment is Out Dated.")
  OutDated: "OutDated",

  @doc("Assessment is Deleted.")
  Deleted: "Deleted",

  @doc("Assessment has Failed.")
  Failed: "Failed",

  string,
}

@doc("Assessment Sizing Criteria.")
union AssessmentSizingCriterion {
  @doc("Performance Data based Sizing.")
  PerformanceBased: "PerformanceBased",

  @doc("As On Premises or Static Data based Sizing.")
  AsOnPremises: "AsOnPremises",

  string,
}

@doc("Cloud Suitability for Azure.")
union CloudSuitability {
  @doc("Unknown. Indicates missing data.")
  Unknown: "Unknown",

  @doc("Not Suitable for Azure.")
  NotSuitable: "NotSuitable",

  @doc("Suitable for Azure.")
  Suitable: "Suitable",

  @doc("Conditionally Suitable for Azure.")
  ConditionallySuitable: "ConditionallySuitable",

  @doc("Unknown Readiness for Azure.")
  ReadinessUnknown: "ReadinessUnknown",

  string,
}

@doc("The status of the current operation.")
union ProvisioningState {
  @doc("Resource provisioning Successful.")
  Succeeded: "Succeeded",

  @doc("Resource provisioning Failed.")
  Failed: "Failed",

  @doc("Resource provisioning Canceled.")
  Canceled: "Canceled",

  @doc("Resource is being Provisioned.")
  Provisioning: "Provisioning",

  @doc("Resource is being Updated.")
  Updating: "Updating",

  @doc("Resource is being Deleted.")
  Deleting: "Deleting",

  @doc("Resource is being Accepted.")
  Accepted: "Accepted",

  string,
}

@doc("Location for Azure.")
union AzureLocation {
  @doc("Unknown Location for Azure")
  Unknown: "Unknown",

  @doc("EastAsia Location for Azure")
  EastAsia: "EastAsia",

  @doc("SoutheastAsia Location for Azure")
  SoutheastAsia: "SoutheastAsia",

  @doc("AustraliaEast Location for Azure")
  AustraliaEast: "AustraliaEast",

  @doc("AustraliaSoutheast Location for Azure")
  AustraliaSoutheast: "AustraliaSoutheast",

  @doc("BrazilSouth Location for Azure")
  BrazilSouth: "BrazilSouth",

  @doc("CanadaCentral Location for Azure")
  CanadaCentral: "CanadaCentral",

  @doc("CanadaEast Location for Azure")
  CanadaEast: "CanadaEast",

  @doc("WestEurope Location for Azure")
  WestEurope: "WestEurope",

  @doc("NorthEurope Location for Azure")
  NorthEurope: "NorthEurope",

  @doc("CentralIndia Location for Azure")
  CentralIndia: "CentralIndia",

  @doc("SouthIndia Location for Azure")
  SouthIndia: "SouthIndia",

  @doc("WestIndia Location for Azure")
  WestIndia: "WestIndia",

  @doc("JapanEast Location for Azure")
  JapanEast: "JapanEast",

  @doc("JapanWest Location for Azure")
  JapanWest: "JapanWest",

  @doc("KoreaCentral Location for Azure")
  KoreaCentral: "KoreaCentral",

  @doc("KoreaSouth Location for Azure")
  KoreaSouth: "KoreaSouth",

  @doc("UkWest Location for Azure")
  UkWest: "UkWest",

  @doc("UkSouth Location for Azure")
  UkSouth: "UkSouth",

  @doc("NorthCentralUs Location for Azure")
  NorthCentralUs: "NorthCentralUs",

  @doc("EastUs Location for Azure")
  EastUs: "EastUs",

  @doc("WestUs2 Location for Azure")
  WestUs2: "WestUs2",

  @doc("SouthCentralUs Location for Azure")
  SouthCentralUs: "SouthCentralUs",

  @doc("CentralUs Location for Azure")
  CentralUs: "CentralUs",

  @doc("EastUs2 Location for Azure")
  EastUs2: "EastUs2",

  @doc("WestUs Location for Azure")
  WestUs: "WestUs",

  @doc("WestCentralUs Location for Azure")
  WestCentralUs: "WestCentralUs",

  @doc("GermanyCentral Location for Azure")
  GermanyCentral: "GermanyCentral",

  @doc("GermanyNortheast Location for Azure")
  GermanyNortheast: "GermanyNortheast",

  @doc("ChinaNorth Location for Azure")
  ChinaNorth: "ChinaNorth",

  @doc("ChinaEast Location for Azure")
  ChinaEast: "ChinaEast",

  @doc("USGovArizona Location for Azure")
  USGovArizona: "USGovArizona",

  @doc("USGovTexas Location for Azure")
  USGovTexas: "USGovTexas",

  @doc("USGovIowa Location for Azure")
  USGovIowa: "USGovIowa",

  @doc("USGovVirginia Location for Azure")
  USGovVirginia: "USGovVirginia",

  @doc("USDoDCentral Location for Azure")
  USDoDCentral: "USDoDCentral",

  @doc("USDoDEast Location for Azure")
  USDoDEast: "USDoDEast",

  @doc("FranceCentral Location for Azure")
  FranceCentral: "FranceCentral",

  @doc("AustraliaCentral Location for Azure")
  AustraliaCentral: "AustraliaCentral",

  @doc("SouthAfricaNorth Location for Azure")
  SouthAfricaNorth: "SouthAfricaNorth",

  @doc("FranceSouth Location for Azure")
  FranceSouth: "FranceSouth",

  @doc("AustraliaCentral2 Location for Azure")
  AustraliaCentral2: "AustraliaCentral2",

  @doc("SouthAfricaWest Location for Azure")
  SouthAfricaWest: "SouthAfricaWest",

  @doc("GermanyNorth Location for Azure")
  GermanyNorth: "GermanyNorth",

  @doc("GermanyWestCentral Location for Azure")
  GermanyWestCentral: "GermanyWestCentral",

  @doc("NorwayEast Location for Azure")
  NorwayEast: "NorwayEast",

  @doc("NorwayWest Location for Azure")
  NorwayWest: "NorwayWest",

  @doc("ChinaEast2 Location for Azure")
  ChinaEast2: "ChinaEast2",

  @doc("ChinaNorth2 Location for Azure")
  ChinaNorth2: "ChinaNorth2",

  @doc("SwitzerlandNorth Location for Azure")
  SwitzerlandNorth: "SwitzerlandNorth",

  @doc("SwitzerlandWest Location for Azure")
  SwitzerlandWest: "SwitzerlandWest",

  @doc("UAENorth Location for Azure")
  UAENorth: "UAENorth",

  @doc("UAECentral Location for Azure")
  UAECentral: "UAECentral",

  @doc("UsNatEast Location for Azure")
  UsNatEast: "UsNatEast",

  @doc("UsNatWest Location for Azure")
  UsNatWest: "UsNatWest",

  @doc("UsSecEast Location for Azure")
  UsSecEast: "UsSecEast",

  @doc("UsSecCentral Location for Azure")
  UsSecCentral: "UsSecCentral",

  @doc("UsSecWest Location for Azure")
  UsSecWest: "UsSecWest",

  @doc("SwedenCentral Location for Azure")
  SwedenCentral: "SwedenCentral",

  @doc("QatarCentral Location for Azure")
  QatarCentral: "QatarCentral",

  @doc("JioIndiaWest Location for Azure")
  JioIndiaWest: "JioIndiaWest",

  @doc("ItalyNorth Location for Azure")
  ItalyNorth: "ItalyNorth",

  @doc("PolandCentral Location for Azure")
  PolandCentral: "PolandCentral",

  @doc("IsraelCentral Location for Azure")
  IsraelCentral: "IsraelCentral",

  @doc("MexicoCentral Location for Azure")
  MexicoCentral: "MexicoCentral",

  @doc("NewZealandNorth Location for Azure")
  NewZealandNorth: "NewZealandNorth",

  @doc("SpainCentral Location for Azure")
  SpainCentral: "SpainCentral",

  string,
}

@doc("Currency for Azure.")
union AzureCurrency {
  @doc("Unknown Currency for Azure")
  Unknown: "Unknown",

  @doc("USD Currency for Azure")
  USD: "USD",

  @doc("DKK Currency for Azure")
  DKK: "DKK",

  @doc("CAD Currency for Azure")
  CAD: "CAD",

  @doc("IDR Currency for Azure")
  IDR: "IDR",

  @doc("JPY Currency for Azure")
  JPY: "JPY",

  @doc("KRW Currency for Azure")
  KRW: "KRW",

  @doc("NZD Currency for Azure")
  NZD: "NZD",

  @doc("NOK Currency for Azure")
  NOK: "NOK",

  @doc("RUB Currency for Azure")
  RUB: "RUB",

  @doc("SAR Currency for Azure")
  SAR: "SAR",

  @doc("ZAR Currency for Azure")
  ZAR: "ZAR",

  @doc("SEK Currency for Azure")
  SEK: "SEK",

  @doc("TRY Currency for Azure")
  TRY: "TRY",

  @doc("GBP Currency for Azure")
  GBP: "GBP",

  @doc("MXN Currency for Azure")
  MXN: "MXN",

  @doc("MYR Currency for Azure")
  MYR: "MYR",

  @doc("INR Currency for Azure")
  INR: "INR",

  @doc("HKD Currency for Azure")
  HKD: "HKD",

  @doc("BRL Currency for Azure")
  BRL: "BRL",

  @doc("TWD Currency for Azure")
  TWD: "TWD",

  @doc("EUR Currency for Azure")
  EUR: "EUR",

  @doc("CHF Currency for Azure")
  CHF: "CHF",

  @doc("ARS Currency for Azure")
  ARS: "ARS",

  @doc("AUD Currency for Azure")
  AUD: "AUD",

  @doc("CNY Currency for Azure")
  CNY: "CNY",

  string,
}

@doc("The savings options.")
union SavingsOptions {
  @doc("No savings options.")
  None: "None",

  @doc("Reserved Instance for 1 year.")
  RI1Year: "RI1Year",

  @doc("Reserved Instance for 3 years.")
  RI3Year: "RI3Year",

  @doc("The savings plan for 1 year.")
  SavingsPlan1Year: "SavingsPlan1Year",

  @doc("The savings plan for 3  years.")
  SavingsPlan3Year: "SavingsPlan3Year",

  @doc("Custom azure offer code.")
  CustomAzureOfferCode: "CustomAzureOfferCode",

  string,
}

@doc("Premium Disk Support")
union PremiumDiskSupport {
  @doc("Premium Disk Supported")
  PremiumDiskSupported: "PremiumDiskSupported",

  @doc("Premium Disk Not Supported")
  PremiumDiskNotSupported: "PremiumDiskNotSupported",

  string,
}

@doc("Web Server Type.")
union WebServerType {
  @doc("Unknown. Indicates Missing Data.")
  Unknown: "Unknown",

  @doc("ASP.NET Web App.")
  IIS: "IIS",

  @doc("Java Web App.")
  Tomcat: "Tomcat",

  string,
}

@doc("Web App Type.")
union WebAppType {
  @doc("Unknown. Indicates Missing Data.")
  Unknown: "Unknown",

  @doc("ASP.NET Web App.")
  ASPNET: "ASP.Net",

  @doc("Java Web App.")
  Java: "Java",

  string,
}

@doc("Wep App Tier.")
union AzureWebAppTier {
  @doc("Unknown. Indicates Missing Data.")
  Unknown: "Unknown",

  @doc("Free Tier.")
  Free: "Free",

  @doc("Shared Tier.")
  Shared: "Shared",

  @doc("Basic Tier.")
  Basic: "Basic",

  @doc("Standard Tier.")
  Standard: "Standard",

  @doc("Premium Tier.")
  Premium: "Premium",

  @doc("PremiumV2 Tier.")
  PremiumV2: "PremiumV2",

  @doc("Isolated Tier.")
  Isolated: "Isolated",

  string,
}

@doc("Percentile for Performance Data.")
union Percentile {
  @doc("Percentile 50.")
  Percentile50: "Percentile50",

  @doc("Percentile 90.")
  Percentile90: "Percentile90",

  @doc("Percentile 95.")
  Percentile95: "Percentile95",

  @doc("Percentile 99.")
  Percentile99: "Percentile99",

  @doc("Percentile unknown.")
  PercentileUnknown: "PercentileUnknown",

  string,
}

@doc("Time Range for Performance Data.")
union TimeRange {
  @doc("Daily.")
  Day: "Day",

  @doc("Weekly.")
  Week: "Week",

  @doc("Monthly.")
  Month: "Month",

  @doc("Custom Time Range.")
  Custom: "Custom",

  string,
}

@doc("The licensing program.")
union LicensingProgram {
  @doc("Retail/Pay as you go.")
  Retail: "Retail",

  @doc("Not known")
  Unknown: "Unknown",

  @doc("Enterprise agreement.")
  EA: "EA",

  @doc("Microsoft customer agreement.")
  MCA: "MCA",

  string,
}
