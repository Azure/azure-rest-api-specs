import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.AzureTerraform;

@@clientName(ExportTerraform.export, "ExportTerraform", "csharp");
@@clientName(ExportTerraform.getOperationStatus,
  "GetOperationStatus",
  "csharp"
);
@@access(ExportTerraform.getOperationStatus, Access.internal, "csharp");
