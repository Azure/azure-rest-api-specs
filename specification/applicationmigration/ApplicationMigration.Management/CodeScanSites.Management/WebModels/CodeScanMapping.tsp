import "../models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.ApplicationMigration;

@doc("Configuration properties for the code scan mapping.")
model CodeScanMappingConfigurations {
  @doc("The ARM ID of the connection.")
  connectionArmId?: string;

  @doc("The external application name.")
  externalAppName?: string;

  @doc("The migration target.")
  azureTarget: AzureTarget;
}

@doc("Report information for the code scan mapping.")
model CodeScanMappingReports {
  @doc("The ARM ID of the report.")
  reportArmId: string;

  @doc("The report name.")
  @visibility(Lifecycle.Read)
  reportName?: string;

  @doc("The report type.")
  @visibility(Lifecycle.Read)
  reportType?: ReportType;

  @doc("The migrate Gartner R rating.")
  @visibility(Lifecycle.Read)
  migrateGartnerR?: string;

  @doc("The effort in hours.")
  @visibility(Lifecycle.Read)
  effortInHr?: int32;

  @doc("Cloud Suitability for Azure.")
  @visibility(Lifecycle.Read)
  cloudSuitability?: CloudSuitability;

  @doc("The status of the report.")
  @visibility(Lifecycle.Read)
  reportStatus?: ReportStatus;
}

@doc("CodeScanMapping properties.")
model CodeScanMappingProperties {
  @doc("The provisioning state of the CodeScanMapping.")
  @visibility(Lifecycle.Read)
  provisioningState?: Azure.ResourceManager.ResourceProvisioningState;

  @doc("Configuration properties for the code scan mapping.")
  configurations?: CodeScanMappingConfigurations;

  @doc("Report information for the code scan mapping.")
  reportDetails?: CodeScanMappingReports;
}

@doc("CodeScanMapping resource - Extension resource under web app sites.")
model CodeScanMapping
  is Azure.ResourceManager.ExtensionResource<CodeScanMappingProperties> {
  @doc("CodeScanMapping name")
  @key("codeScanMappingName")
  @segment("codeScanMappings")
  @path
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,62}[a-zA-Z0-9]$")
  name: string;
}
