import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Microsoft.AzureTerraform;

@@clientName(ExportResult, "TerraformExportResult", "csharp");
@@clientName(ResourceProvisioningState,
  "TerraformResourceProvisioningState",
  "csharp"
);
@@clientName(TargetTerraformProvider.azapi, "AzApi", "csharp");
@@clientName(TargetTerraformProvider.azurerm, "AzureRM", "csharp");
@@clientName(Terraform.exportTerraform, "ExportTerraform", "csharp");
