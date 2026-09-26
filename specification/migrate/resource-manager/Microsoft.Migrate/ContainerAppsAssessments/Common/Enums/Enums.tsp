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
