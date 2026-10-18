import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.RecoveryServices;

@@clientName(
  BackupResourceStorageConfigs.update::parameters.resource,
  "parameters"
);
@@clientName(BackupResourceStorageConfigs.patch, "patch");
@@clientName(
  BackupResourceStorageConfigs.patch::parameters.properties,
  "parameters"
);

@@clientName(RecoveryPoints.getAccessToken::parameters.body, "parameters");

@@clientName(CrossRegionRestore.trigger::parameters.body, "parameters");

@@clientName(BackupCrrJobDetails.get::parameters.body, "parameters");

@@clientName(BackupCrrJobs.list::parameters.body, "parameters");

// These language-scoped names avoid duplicate SDK model names without changing
// the AutoRest definition keys in the frozen OpenAPI contract.
@@clientName(
  Microsoft.RecoveryServices.Resource,
  "CrrResource",
  "csharp,java,python"
);
@@clientName(
  Microsoft.RecoveryServices.ErrorDetail,
  "CrrErrorDetail",
  "csharp,java,python"
);
