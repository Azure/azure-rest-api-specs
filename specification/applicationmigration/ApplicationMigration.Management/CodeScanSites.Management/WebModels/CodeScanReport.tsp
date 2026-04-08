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

  @added(CodeScanSitesApiVersions.v2026_05_12_preview)
  @doc("The ARM ID of the migrate workload.")
  migrateWorkloadArmId?: string;

  @added(CodeScanSitesApiVersions.v2026_05_12_preview)
  @doc("The type of the migrate workload.")
  migrateWorkloadType?: MigrateWorkloadType;

  @added(CodeScanSitesApiVersions.v2026_05_12_preview)
  @doc("The list of processed repositories.")
  @identifiers(#["repoName"])
  processedRepos?: ProcessedRepo[];
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

  @added(CodeScanSitesApiVersions.v2026_05_12_preview)
  @doc("The source of the report.")
  reportSource: ReportSource;
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

@added(CodeScanSitesApiVersions.v2026_05_12_preview)
@doc("The Migrate Workload Type for the resource being assessed.")
union MigrateWorkloadType {
  @doc("WebApp type of Migrate Workload.")
  WebApplication: "WebApplication",

  string,
}

@added(CodeScanSitesApiVersions.v2026_05_12_preview)
@doc("Details of the processed repository.")
model ProcessedRepo {
  @doc("The repository name.")
  repoName?: string;

  @doc("The timestamp when the repo was last analyzed and results received.")
  @visibility(Lifecycle.Read)
  lastUpdatedOn?: utcDateTime;
}

@added(CodeScanSitesApiVersions.v2026_05_12_preview)
@doc("The request model for triggering code scan.")
model ScanRequest {
  @doc("The list of application IDs for the scan.")
  applicationIds?: armResourceIdentifier[];

  @doc("The list of webapp IDs for the scan.")
  webAppIds?: armResourceIdentifier[];
}

@added(CodeScanSitesApiVersions.v2026_05_12_preview)
@doc("The URI path response model for the configuration file.")
model ConfigUriResponse {
  @doc("The URI path of the Configuration file to be used by Modernize CLI.")
  configUri: url;
}

@added(CodeScanSitesApiVersions.v2026_05_12_preview)
@doc("The Operation status response model for the configuration file URI generation.")
model ConfigUriOperationStatusResponse {
  @doc("The response of the operation for generating the configuration file URI.")
  properties: ConfigUriResponse;
}

@added(CodeScanSitesApiVersions.v2026_05_12_preview)
@doc("The request model for fetching SAS URI by report paths.")
model SasUriByReportPathsRequest {
  @doc("The list of report paths for which SAS URI is requested.")
  reportPaths: string[];
}

@added(CodeScanSitesApiVersions.v2026_05_12_preview)
@doc("The response model for fetching SAS URI by report paths.")
model SasUriByReportPathsResponse {
  @doc("The list of SAS URI by report paths requested.")
  @identifiers(#["reportPath"])
  sasUris: SasUriByReportPath[];
}

@added(CodeScanSitesApiVersions.v2026_05_12_preview)
@doc("The response model for fetching SAS URI by Report path.")
model SasUriByReportPath {
  @doc("The report path for which SAS URI is generated.")
  reportPath: string;

  @doc("The SAS URI generated where report will be uploaded by Modernize CLI.")
  sasUri: url;
}
