import "../models.tsp";
import "./CodeScanSite.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.ApplicationMigration;

@doc("Configuration properties for the code scan report.")
model CodeScanReportConfigurations {
  @doc("The ARM ID of the connection.")
  connectionArmId?: string;

  @doc("The issue ID.")
  issueId?: string;

  @doc("The external web application name.")
  externalWebAppName?: string;

  @doc("The report framework.")
  reportFramework?: ReportFramework;

  @doc("The target platform for migration.")
  azureTargets: AzureTarget[];
}

@doc("Details of the code scan report.")
model CodeScanReportDetails {
  @doc("The report ID.")
  reportId: string;

  @doc("The report type.")
  reportType: ReportType;

  @doc("The report name.")
  reportName: string;

  @doc("The report format.")
  reportFormat: ReportFormat;

  @doc("The status of the report.")
  @visibility(Lifecycle.Read)
  status: ReportStatus;
}

@doc("Report recommendations from the code scan analysis.")
model ReportRecommendations {
  @doc("Gartner migration strategy recommendation.")
  migrateGartnerR: string;

  @doc("Estimated effort required for migration in hours.")
  effortInHr: int32;

  @doc("Cloud suitability assessment for the application.")
  cloudSuitability: CloudSuitability;

  @doc("Recommended target platform for migration.")
  azureTarget: AzureTarget;
}

@doc("CodeScanReport properties.")
model CodeScanReportProperties {
  @doc("The provisioning state of the CodeScanReport.")
  @visibility(Lifecycle.Read)
  provisioningState?: Azure.ResourceManager.ResourceProvisioningState;

  @doc("Configuration properties for the code scan report.")
  configurations: CodeScanReportConfigurations;

  @doc("Details of the code scan report.")
  reportDetails?: CodeScanReportDetails;

  @doc("The recommendations suggested by the code scan report.")
  @identifiers(#["azureTarget"])
  reportRecommendations?: ReportRecommendations[];
}

@parentResource(CodeScanSite)
@doc("CodeScanReport resource.")
model CodeScanReport
  is Azure.ResourceManager.ProxyResource<CodeScanReportProperties> {
  @doc("CodeScanReport name")
  @key("reportId")
  @segment("codeScanReports")
  @path
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,62}[a-zA-Z0-9]$")
  name: string;
}
