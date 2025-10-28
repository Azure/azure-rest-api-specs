using Azure.ResourceManager;

namespace Microsoft.ApplicationMigration;

@doc("The report framework for code scanning.")
union ReportFramework {
  @doc("Java framework.")
  Java: "Java",

  @doc(".NET framework.")
  DOTNET: "DOTNET",

  string,
}

@doc("The target platform for migration.")
union AzureTarget {
  @doc("Azure Kubernetes Service.")
  AKS: "AKS",

  @doc("App Service Container.")
  AzureAppServiceContainer: "AzureAppServiceContainer",

  @doc("App Service Native.")
  AzureAppService: "AzureAppService",

  string,
}

@doc("The report format.")
union ReportFormat {
  @doc("JSON format.")
  JSON: "JSON",

  string,
}

@doc("The report type.")
union ReportType {
  @doc("AppCAT report type.")
  AppCAT: "AppCAT",

  string,
}

@doc("The status of the report.")
union ReportStatus {
  @doc("The report is available.")
  Available: "Available",

  @doc("Scan has been requested.")
  ScanRequested: "ScanRequested",

  @doc("Scan request is in progress.")
  InProgress: "InProgress",

  string,
}

@doc("The status of the process operation.")
union ProcessStatus {
  @doc("The operation has been accepted.")
  Accepted: "Accepted",

  string,
}

@doc("The issue category.")
union IssueCategory {
  @doc("Issue category.")
  Issue: "Issue",

  @doc("Warning category.")
  Warning: "Warning",

  @doc("Internal category.")
  Internal: "Internal",

  @doc("Information category.")
  Information: "Information",

  string,
}

@doc("SAS URI response model.")
model SasUriResponse {
  @doc("The SAS URI for uploading reports.")
  @secret
  sasUri: string;
}

@doc("Process report request model.")
model ProcessReportRequest {
  @doc("Properties for processing the report.")
  properties: ProcessReportProperties;
}

@doc("Properties for processing the report.")
model ProcessReportProperties {
  @doc("The SAS URI of the report to process.")
  @secret
  sasUri: string;

  @doc("The type of the report.")
  reportType: ReportType;
}

@doc("Model representing the status of the process report operation.")
model ProcessReportOperationStatusResponse {
  @doc("Additional properties applicable for process report operation status result")
  properties: ProcessReportOperationStatusProperties;
}

@doc("Model representing the properties of the process report operation status.")
model ProcessReportOperationStatusProperties {
  @doc("Status of the process report request.")
  status: ProcessReportOperationStatus;

  @doc("The number of reports validated successfully.")
  @minValue(0)
  reportSuccessCount: int32;

  @doc("The number of reports processed.")
  @minValue(0)
  reportCount: int32;

  @doc("The summary of the reports processed.")
  @identifiers(#["reportName"])
  summary: ProcessReportSummary[];
}

@doc("Model representing the summary of the reports processed.")
model ProcessReportSummary {
  @doc("Status of the process report request.")
  reportStatus: ProcessReportOperationStatus;

  @doc("The report name.")
  reportName: string;

  @doc("Contains error details if status is Failed/Canceled.")
  error?: Azure.ResourceManager.Foundations.ErrorDetail;
}

@doc("The status of the process report operation.")
union ProcessReportOperationStatus {
  string,

  @doc("The import operation status - Accepted.")
  Accepted: "Accepted",

  @doc("The import operation status - InProgress.")
  InProgress: "InProgress",

  @doc("The process report operation status - Succeeded.")
  Succeeded: "Succeeded",

  @doc("The import operation status - PartiallySucceeded.")
  PartiallySucceeded: "PartiallySucceeded",

  @doc("The process report operation status - Failed.")
  Failed: "Failed",

  @doc("The process report operation status - Canceled.")
  Canceled: "Canceled",
}

@doc("Reference link model.")
model ReferenceLink {
  @doc("The URL of the reference link.")
  url: string;

  @doc("The label of the reference link.")
  label: string;
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
