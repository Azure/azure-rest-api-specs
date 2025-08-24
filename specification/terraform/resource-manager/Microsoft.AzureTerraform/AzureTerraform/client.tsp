import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Microsoft.AzureTerraform;

@@clientName(Type, "CommonExportType", "csharp");
@@clientName(BaseExportModel, "CommonExportProperties", "csharp");
@@clientName(BaseExportModel.fullProperties,
  "IsOutputFullPropertiesEnabled",
  "csharp"
);
@@clientName(BaseExportModel.maskSensitive, "IsMaskSensitiveEnabled", "csharp");
@@clientName(BaseExportModel.excludeAzureResource,
  "AzureResourcesToExclude",
  "csharp"
);
@@clientName(BaseExportModel.excludeTerraformResource,
  "TerraformResourcesToExclude",
  "csharp"
);

// Name ending with "Resource" is reserved for ARM resource in .NET SDK
// Refer to https://github.com/Azure/azure-sdk-for-net/blob/4dacd22df0cf904b11cb3b1389aa566c552fdd0f/common/ManagementTestShared/Redesign/InheritanceCheckTests.cs#L23
@@clientName(ExportQuery, "ExportQueryTerraform", "csharp");
@@clientName(ExportQuery.recursive, "IsRecursive", "csharp");
@@clientName(ExportResource, "ExportResourceTerraform", "csharp");
@@clientName(ExportResourceGroup, "ExportResourceGroupTerraform", "csharp");
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
@@clientName(Microsoft.AzureTerraform, "TerraformMgmt", "python");
@@clientName(authorizationScopeFilter,
  "TerraformAuthorizationScopeFilter",
  "csharp"
);
