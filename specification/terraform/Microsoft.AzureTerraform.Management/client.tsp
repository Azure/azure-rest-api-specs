import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Microsoft.AzureTerraform;

@@clientName(BaseExportModel, "CommonExportProperties", "csharp");
@@clientName(ExportResult, "TerraformExportResult", "csharp");
@@clientName(ExportResult.skippedResources, "SkippedResourceIds", "csharp");
@@clientName(ResourceProvisioningState,
  "TerraformResourceProvisioningState",
  "csharp"
);
@@clientName(targetProvider, "TargetTerraformProvider", "csharp");
@@clientName(targetProvider.azapi, "AzApi", "csharp");
@@clientName(targetProvider.azurerm, "AzureRM", "csharp");
@@clientName(Terraform.exportTerraform, "ExportTerraform", "csharp");
